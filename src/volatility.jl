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
function bollingerbands{T,N}(ta::TimeArray{T,N}, ma::Int, width::Float64)
    tama   = sma(ta, ma)
    upband = tama .+ moving(ta, std, ma) .* width .* sqrt((ma-1)/ma) # take out Bessel correction, per algorithm
    dnband = tama .- moving(ta, std, ma) .* width .* sqrt((ma-1)/ma)
    bands  =  merge(upband, dnband)
    merge(bands, tama, colnames = ["up", "down", "mean"])
end

bollingerbands{T,N}(ta::TimeArray{T,N}) = bollingerbands(ta, 20, 2.0)

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
function atr{T,N}(ohlc::TimeArray{T,N}, n::Int; h="High", l="Low", c="Close")
    # atr was invented by Wilder, so only his ema is currently supported
    res = ema(truerange(ohlc), n, wilder=true)
    TimeArray(res.timestamp, res.values, ["atr"], ohlc.meta)
end

atr{T,N}(ta::TimeArray{T,N}) = atr(ta, 14)

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

**Referenc**

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

# # function chaikinvolatility{T,N}(ta::TimeArray{T,N}, n::Int)
# #   #code here
# # end
