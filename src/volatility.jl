doc"""
    bollingerbands(ta, ma=20, width=2.0)

Bollinger Bands

```math
\begin{align*}

    Up & = SMA + width \times \sigma \\
    Mean & = SMA \\
    Down & = SMA - width \times \sigma

\end{align*}
```
"""
function bollingerbands{T,N}(ta::TimeArray{T,N}, ma::Integer=20,
                             width::AbstractFloat=2.0)
    tama   = sma(ta, ma)
    upband = tama .+ moving(ta, std, ma) .* width .* sqrt((ma-1)/ma) # take out Bessel correction, per algorithm
    dnband = tama .- moving(ta, std, ma) .* width .* sqrt((ma-1)/ma)
    bands  =  merge(upband, dnband)
    merge(bands, tama, colnames = ["up", "down", "mean"])
end

doc"""
    truerange(ohlc; h="High", l="Low", c="Close")

True Range

```math
    TR = \max (H_t, C_{t-1}) - \min (L_t, C{t-1})
```

"""
function truerange{T,N}(ohlc::TimeArray{T,N}; h="High", l="Low", c="Close")
    highs    = merge(ohlc[h], lag(ohlc[c]))
    lows     = merge(ohlc[l], lag(ohlc[c]))
    truehigh = TimeArray(highs.timestamp, maximum(highs.values, 2), ["hi"], highs.meta)
    truelow  = TimeArray(lows.timestamp,  minimum(lows.values, 2),  ["lo"], lows.meta)
    rename(truehigh .- truelow, "tr")
end

doc"""
    atr(ohlc, n=14; h="High", l="Low", c="Close")

Average True Range

It's the exponential moving average of [`truerange`](@ref)

```math
    ATR = EMA(TR, n)
```

"""
function atr{T,N}(ohlc::TimeArray{T,N}, n::Integer=14;
                  h="High", l="Low", c="Close")
    # atr was invented by Wilder, so only his ema is currently supported
    res = ema(truerange(ohlc), n, wilder=true)
    TimeArray(res.timestamp, res.values, ["atr"], ohlc.meta)
end

doc"""
    keltnerbands(ohlc, n=20, w=2; h="High", l="Low", c="Close")

**Keltner Channels**

Linda Bradford Raschke introduced the newer version of Keltner Channels
in the 1980s. We implement the newer version.

**Formula**

```math
    \begin{align*}
        \text{Up}   & = \text{Mid} + w \times ATR(n) \\
        \text{Mid}  & = EMA(P_{typical}, n) \\
        \text{Down} & = \text{Mid} - w \times ATR(n)
    \end{align*}
```

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:keltner_channels)

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Keltner_channel)

"""
function keltnerbands{T,N}(ohlc::TimeArray{T,N}, n::Integer=20, w::Integer=2;
                           h="High", l="Low", c="Close")
    kma = rename(ema(typical(ohlc, h=h, l=l, c=c), n), "kma")
    rng = atr(ohlc, n, h=h, l=l, c=c)

    kup = rename(kma .+ (2 .* rng), "kup")
    kdn = rename(kma .- (2 .* rng), "kdn")

    merge(kup, merge(kma, kdn))
end

doc"""
    chaikinvolatility(ta, n=10, p=10; h="High", l="Low")

**Chaikin Volatility**

**Parameters**

- `n` is the smooth period

- `p` is the previous period

**Formula**

```math
    Chaikin\ Vola =
        \frac{EMA(High_t - Low_t, n) - EMA(High_{t-p} - Low_{t-p}, n)}
        {EMA(High_{t-p} - Low_{t-p}, n)}
        \times 100
```

**Reference**

- [IncredibleCharts]
  (https://www.incrediblecharts.com/indicators/chaikin_volatility.php)

"""
function chaikinvolatility(ta::TimeArray, n::Integer=10, p::Integer=10;
                                h="High", l="Low")
    rng = ema(ta[h] .- ta[l], n)
    prev = lag(rng, p)
    rename((rng .- prev) ./ prev * 100, "chaikinvolatility")
end
