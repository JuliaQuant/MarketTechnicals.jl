@doc raw"""
    bollingerbands(ta::TimeArray, ma=20, width=2.0)

Bollinger Bands

# Formula

```math
\begin{align*}
  \text{Up}   & = \text{SMA} + \text{width} \times \sigma(P) \\
  \text{Mean} & = \text{SMA} \\
  \text{Down} & = \text{SMA} - \text{width} \times \sigma(P)
\end{align*}
```
"""
function bollingerbands(ta::TimeArray, ma::Integer = 20, width::AbstractFloat = 2.0)
  tama   = sma(ta, ma)
  upband = tama .+ moving(nanstd, ta, ma) .* width .* sqrt((ma - 1) / ma) # take out Bessel correction, per algorithm
  dnband = tama .- moving(nanstd, ta, ma) .* width .* sqrt((ma - 1) / ma)
  bands  =  merge(upband, dnband)
  merge(bands, tama, colnames = [:up, :down, :mean])
end

@doc raw"""
    donchianchannels(ohlc::TimeArray, n = 20; h = :High, l = :Low)

Donchian Channels

# Formula

```math
\begin{align*}
  \text{Up}   & = \max(P_1^\text{High}, \dots, P_t^\text{High}) \\
  \text{Mid}  & = \frac{\text{Up} + \text{Down}}{2} \\
  \text{Down} & = \min(P_1^\text{Low}, \dots, P_t^\text{Low})
\end{align*}
```

# References

- [TradingView Wiki]
  (https://www.tradingview.com/wiki/Donchian_Channels_(DC))
"""
function donchianchannels(ohlc::TimeArray, n::Integer = 20; h = :High, l = :Low)
  up   = rename(moving(nanmax, ohlc[h], n), :up)
  down = rename(moving(nanmin, ohlc[l], n), :down)
  mid  = rename((up .+ down) ./ 2, :mid)
  merge(up, merge(mid, down))
end

@doc raw"""
    truerange(ohlc::TimeArray; h = :High, l = :Low, c = :Close)

True Range

# Formula

```math
\text{TR} = \max (P_t^\text{High}, P_{t-1}^\text{Close}) -
            \min (P_t^\text{Low},  P_{t-1}^\text{Close})
```
"""
function truerange(ohlc::TimeArray; h = :High, l = :Low, c = :Close)
  highs    = merge(ohlc[h], lag(ohlc[c]))
  lows     = merge(ohlc[l], lag(ohlc[c]))
  truehigh = TimeArray(timestamp(highs), maximum(values(highs), dims=2), [:hi], meta(highs))
  truelow  = TimeArray(timestamp(lows),  minimum(values(lows), dims=2),  [:lo], meta(lows))
  rename(truehigh .- truelow, :tr)
end

@doc raw"""
    atr(ohlc::TimeArray, n = 14; h= :High, l= :Low, c = :Close)

Average True Range

It's the exponential moving average of [`truerange`](@ref)

# Formula

```math
\text{ATR} = \text{EMA}(\text{TR}, n)
```
"""
function atr(ohlc::TimeArray, n::Integer = 14; h = :High, l = :Low, c = :Close)
  # atr was invented by Wilder, so only his ema is currently supported
  res = ema(truerange(ohlc; h = h, l = l, c = c), n, wilder = true)
  TimeArray(timestamp(res), values(res), [:atr], meta(ohlc))
end

@doc raw"""
    keltnerbands(ohlc, n = 20, w = 2; h = :High, l = :Low, c = :Close)

Keltner Channels

Linda Bradford Raschke introduced the newer version of Keltner Channels
in the 1980s. We implement the newer version.

# Formula

```math
\begin{align*}
  \text{Up}   & = \text{Mid} + w \times \text{ATR}(n) \\
  \text{Mid}  & = \text{EMA}(P^{typical}, n) \\
  \text{Down} & = \text{Mid} - w \times \text{ATR}(n)
\end{align*}
```

# References

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:keltner_channels)

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Keltner_channel)
"""
function keltnerbands(ohlc::TimeArray, n::Integer = 20, w::AbstractFloat = 2.0;
                      h = :High, l = :Low, c = :Close)
  kma = rename(ema(typical(ohlc, h=h, l=l, c=c), n), :kma)
  rng = atr(ohlc, n, h=h, l=l, c=c)

  kup = rename(kma .+ (2 .* rng), :kup)
  kdn = rename(kma .- (2 .* rng), :kdn)

  merge(kup, merge(kma, kdn))
end

@doc raw"""
    chaikinvolatility(ta, n = 10, p = 10; h = High, l = :Low)

Chaikin Volatility

# Arguments

- `n` is the smooth period
- `p` is the previous period

# Formula

```math
\text{Chaikin Vola} =
  \frac{\text{EMA}(P^\text{High}_t - P^\text{Low}_t, n) - \text{EMA}(P^\text{High}_{t-p} - P^\text{Low}_{t-p}, n)}
       {\text{EMA}(P^\text{High}_{t-p} - P^\text{Low}_{t-p}, n)}
  \times 100
```

# References

- [IncredibleCharts]
  (https://www.incrediblecharts.com/indicators/chaikin_volatility.php)
"""
function chaikinvolatility(ta::TimeArray, n::Integer = 10, p::Integer = 10;
                           h = :High, l = :Low)
  rng = ema(ta[h] .- ta[l], n)
  prev = lag(rng, p)
  rename(@.((rng - prev) / prev * 100), :chaikinvolatility)
end
