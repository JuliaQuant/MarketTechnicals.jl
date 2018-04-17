doc"""
    rsi(ta, n=14; wilder=false)

Relative Strength Index

```math
    RSI = \frac{EMA(Up, n)}{EMA(Up, n) + EMA(Dn, n)}
```
"""
function rsi(ta::TimeArray, n::Int=14; wilder::Bool=false)
    ret = [zeros(1, size(ta, 2)); diff(ta.values)]
    ups = zeros(size(ta.values, 1), size(ta.values, 2))
    dns = zeros(size(ta.values, 1), size(ta.values, 2))

    for i in 1:size(ta.values,1)
        for j in 1:size(ta.values,2)
            if ret[i,j] >= 0
                ups[i,j] += ret[i,j]
            else
                dns[i,j] += ret[i,j]
            end
        end
    end

    upsema = ema(ups, n, wilder=wilder)
    dnsema = abs.(ema(dns, n, wilder=wilder))
    rs     = upsema ./ dnsema

    res  = @. 100 - (100 / (1 + rs))

    cname   = String[]
    cols    = colnames(ta)
    for c in 1:length(cols)
        push!(cname, string(cols[c], "_rsi_", n))
    end

    TimeArray(ta.timestamp[n:end], res, cname, ta.meta)
end

doc"""
    cci(ohlc, ma=20, c=0.015)

Commodity Channel Index

```math
    CCI = \frac{P_{typical} - SMA(P_{typical})}{c \times \sigma(P_{typical})}
```

**Reference**

- https://en.wikipedia.org/wiki/Commodity_channel_index

"""
function cci(ohlc::TimeArray, ma::Int=20, c::AbstractFloat=0.015)
    pt = typical(ohlc)
    cci = ((pt .- sma(pt, ma)) ./ moving(mean_abs_dev, pt, ma)) ./ c
    rename(cci, "cci")
end

doc"""
    chaikinoscillator(ohlcv, fast=3, slow=10; h="High", l="Low", c="Close")

**Chaikin Oscillator**

Developed by Marc Chaikin

**Formula**

```math
    Chaikin\ OSC = EMA(ADL, fast) - EMA(ADL, slow)
```

where the [`adl`](@ref) is the Accumulation/Distribution Line.

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:chaikin_oscillator)
"""
function chaikinoscillator(ohlcv::TimeArray, fast::Integer=3, slow::Integer=10;
                           h="High", l="Low", c="Close")
    _adl = adl(ohlcv, h=h, l=l, c=c)
    rename(ema(_adl, fast) .- ema(_adl, slow), ["chaikinoscillator"])
end

doc"""
    macd(ta, fast=12, slow=26, signal=9; wilder=false)

Moving Average Convergence / Divergence

```math
    \begin{align*}
        MACD Bar & = DIF - DEM \\
        DIF & = EMA(P_{close}, fast) - EMA(P_{close}, slow) \\
        DEM & = EMA(DIF, 9) \tag{signal}
    \end{align*}
```

**Return**:

`TimeArray` with 3 columns `["macd", "dif", "signal"]`.

If the input is a multi-column `TimeArray`, the new column names will be
`["A_macd", "B_macd", "A_dif", "B_dif", "A_signal", "B_signal"]`.

"""
function macd(ta::TimeArray{T,N},
              fast::Int=12, slow::Int=26, signal::Int=9;
              wilder::Bool=false) where {T,N}
    dif = ema(ta, fast, wilder=wilder) .- ema(ta, slow, wilder=wilder)
    sig = ema(dif, signal, wilder=wilder)
    osc = dif .- sig

    cols = ["macd", "dif", "signal"]
    new_cols = (N > 1) ? gen_colnames(ta.colnames, cols) : cols

    merge(merge(osc, dif), sig, colnames=new_cols)
end

doc"""
    roc(ta, n)

**Rate of Change**

**Formula**:

```math
    roc = \frac{close_{t} - close_{t-n}}{close_{t-n}}
```

**Reference**:

- [Wikipedia](https://en.wikipedia.org/wiki/Momentum_(technical_analysis))

"""
function roc(ta::TimeArray, n::Integer)
    prev = lag(ta, n)
    rename((ta .- prev) ./ prev, ["$c\_roc_$n" for c ∈ ta.colnames])
end

doc"""
    aroon(ohlc, n=25; h="High", l="Low")

**Aroon Oscillator**

**Formula**

```math
    \begin{align*}
        up   & = \frac{\mathop{argmax}(High_{t-n} \dots High_t)}{n} \times 100 \\
        down & = \frac{\mathop{argmin}(Low_{t-n} \dots Low_t)}{n} \times 100 \\
        osc  & = up - down
    \end{align*}
```

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:aroon_oscillator)
"""
function aroon(ohlc::TimeArray, n::Integer=25; h="High", l="Low")
    up = rename(moving(indmax, ohlc[h], n) ./ n .* 100, "up")
    dn = rename(moving(indmin, ohlc[l], n) ./ n .* 100, "dn")
    osc = rename(up .- dn, "osc")

    merge(merge(up, dn), osc)
end

doc"""
    adx(ohlc, n=14; h="High", l="Low", c="Close")

**Average Directional Movement Index**

Developed by J. Welles Wilder.
This Implementation follows StockCharts.

**Reference**

- [wikipedia]
  (https://en.wikipedia.org/wiki/Average_directional_movement_index)

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:average_directional_index_adx)
"""
function adx(ohlc::TimeArray, n::Integer=14; h="High", l="Low", c="Close")
    dm = relu(merge(ohlc[h] .- lag(ohlc[h]), lag(ohlc[l]) .- ohlc[l]))
    dm.values[findmin(dm.values, 2)[2]] = 0

    dm = wilder_smooth(dm, n)

    tr = wilder_smooth(truerange(ohlc, h=h, l=l, c=c), n)

    di = (dm ./ tr) .* 100
    di = rename(di, ["+di", "-di"])

    dx = @. abs((di["+di"] - di["-di"]) / (di["+di"] + di["-di"])) * 100
    adx = wilder_smooth(dx, n, dx=true)

    rename(merge(adx, merge(dx, di)), ["adx", "dx", "+di", "-di"])
end

doc"""
    stochasticoscillator(ohlc, n=14, fast_d=3, slow_d=3; h="High", l="Low", c="Close")

**Stochastic Oscillator**

A.k.a *%K%D*, or *KD*

**Parameter**

- `n`: period of fast(raw) `%K`

- `fast_d`: MA period of fast `%D`

- `slow_d`: MA period of slow `%D`

**Formula**

```math
    \begin{align*}
        fast\ \%K & = \frac{Close_t - \max(High_{t-n}, \dots, High_t)}
            {\max(High_{t-n}, \dots, High_t) - \min(Low_{t-n}, \dots, Low_t)}
            \times 100 \\
        fast\ \%D & = SMA(fast\ \%K) \\
        slow\ \%D & = SMA(fast\ \%D)
    \end{align*}
```

**Reference**

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Stochastic_oscillator)

- [FMLabs]
  (http://www.fmlabs.com/reference/default.htm?url=StochasticOscillator.htm)
"""
function stochasticoscillator(ohlc::TimeArray, n::Integer=14, fast_d::Integer=3,
                              slow_d::Integer=3; h="High", l="Low", c="Close")
    high = moving(maximum, ohlc[h], n)
    low = moving(minimum, ohlc[l], n)
    fast_k = rename((ohlc[c] .- low) ./ (high .- low) .* 100, "fast_k")
    fast_d = rename(sma(fast_k, fast_d), "fast_d")
    slow_d = rename(sma(fast_d, slow_d), "slow_d")
    merge(merge(fast_k, fast_d), slow_d)
end
