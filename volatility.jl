"""
    bollingerbands(ta, ma=20, width=2.0)

Bollinger Bands

```math
'begin{align*}

    Up & = SMA + width times sigma \\
    Mean & = SMA \\
    Down & = SMA - width times sigma

end{align*}''
```
"""
function bollingerbands(ta::TimeArray, ma::Integer=20, width::AbstractFloat=2.0)
    tama   = sma(ta, ma)
    upband = tama .+ moving(nanstd, ta, ma) .* width .* sqrt((ma-1)/ma) # take out Bessel correction, per algorithm
    dnband = tama .- moving(nanstd, ta, ma) .* width .* sqrt((ma-1)/ma)
    bands  =  merge(upband, dnband)
    merge(bands, tama, colnames = [:up, :down, :mean])
end

"""
    donchianchannels(ta, n=20; h="High", l="Low")

**Donchian Channels**

**Formula**

```math
    'begin{align*}
        Up   & = max (High_1 to High_t) \\
        Mid  & = frac{Up + Down}{2} \\
        Down & = min (Low_1 to Low_t)
    end{align*}'
```

**Reference**

- [TradingView Wiki]
  (https://www.tradingview.com/wiki/Donchian_Channels_(DC))

"""
function donchianchannels(ta::TimeArray, n::Integer=20; h=:High, l=:Low)
    up = rename(moving(nanmax, ta[h], n), :up)
    down = rename(moving(nanmin, ta[l], n), :down)
    mid = rename((up .+ down) ./ 2, :mid)
    merge(up, merge(mid, down))
end

"""
    truerange(ohlc; h="High", l="Low", c="Close")

True Range

```math
    TR = 'max (H_t, C_{t-1}) - min (L_t, C{t-1})'
```

"""
function truerange(ohlc::TimeArray{T,N}; h=:High, l=:Low, c=:Close) where {T,N}
    highs    = merge(ohlc[h], lag(ohlc[c]))
    lows     = merge(ohlc[l], lag(ohlc[c]))
    truehigh = TimeArray(timestamp(highs), maximum(values(highs), dims=2), [:hi], meta(highs))
    truelow  = TimeArray(timestamp(lows),  minimum(values(lows), dims=2),  [:lo], meta(lows))
    rename(truehigh .- truelow, :tr)
end

"""
    atr(ohlc, n=14; h="High", l="Low", c="Close")

Average True Range

It's the exponential moving average of [`truerange`](@ref)

```math
    ATR = EMA(TR, n)
```

"""
function atr(ohlc::TimeArray, n::Integer=14; h=:High, l=:Low, c=:Close)
    # atr was invented by Wilder, so only his ema is currently supported
    res = ema(truerange(ohlc), n, wilder=true)
    TimeArray(timestamp(res), values(res), [:atr], meta(ohlc))
end

"""
    keltnerbands(ohlc, n=20, w=2; h="High", l="Low", c="Close")

**Keltner Channels**

Linda Bradford Raschke introduced the newer version of Keltner Channels
in the 1980s. We implement the newer version.

**Formula**

```math
    'begin{align*}
        text{Up}   & = text{Mid} + w times ATR(n) \\
        text{Mid}  & = EMA(P_{typical}, n) \\
        text{Down} & = text{Mid} - w times ATR(n)
    end{align*}'
```

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:keltner_channels)

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Keltner_channel)

"""
function keltnerbands(ohlc::TimeArray, n::Integer=20, w::Float64=2.0;
                      h=:High, l=:Low, c=:Close)
    kma = rename(ema(typical(ohlc, h=h, l=l, c=c), n), :kma)
    rng = atr(ohlc, n, h=h, l=l, c=c)

    kup = rename(kma .+ (2 .* rng), :kup)
    kdn = rename(kma .- (2 .* rng), :kdn)

    merge(kup, merge(kma, kdn))
end

"""
    chaikinvolatility(ta, n=10, p=10; h="High", l="Low")

**Chaikin Volatility**

**Parameters**

- `n` is the smooth period

- `p` is the previous period

**Formula**

```math
    'Chaikin Vola =
        frac{EMA(High_t - Low_t, n) - EMA(High_{t-p} - Low_{t-p}, n)}
        {EMA(High_{t-p} - Low_{t-p}, n)}
        times 100'
```

**Reference**

- [IncredibleCharts]
  (https://www.incrediblecharts.com/indicators/chaikin_volatility.php)

"""
function chaikinvolatility(ta::TimeArray, n::Integer=10, p::Integer=10;
                           h=:High, l=:Low)
    rng = ema(ta[h] .- ta[l], n)
    prev = lag(rng, p)
    rename(@.((rng - prev) / prev * 100), :chaikinvolatility)
end
