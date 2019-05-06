"""
    rsi(ta, n=14; wilder=false)

Relative Strength Index

```math
    RSI = 'frac{EMA(Up, n)}{EMA(Up, n) + EMA(Dn, n)}'
```
"""
function rsi(ta::TimeArray, n::Int=14; wilder::Bool=false)
    ret = diff(values(ta), dims=1)
    ups = zeros(size(values(ta), 1) - 1, size(values(ta), 2))
    dns = zeros(size(values(ta), 1) - 1, size(values(ta), 2))

    # println("Ret")
    # println(ret)

    #skip NaNs (by explicitly comparing on both sides of zero)
    @inbounds for i in 1:size(values(ta), 1) - 1
        for j in 1:size(values(ta), 2)
            if ret[i, j] >= 0
                ups[i, j] += ret[i, j]
            elseif ret[i, j] < 0   
                dns[i, j] += ret[i, j]
            end
        end
    end

    upsema = ema(ups, n, wilder=wilder)
    dnsema = abs.(ema(dns, n, wilder=wilder))
    rs     = upsema ./ dnsema

    res  = @. 100 - (100 / (1 + rs))

    cname   = Symbol[]
    cols    = colnames(ta)
    for c in 1:length(cols)
        push!(cname, Symbol("$(string(cols[c]))_rsi_$n"))
    end

    TimeArray(timestamp(ta)[n+1:end], res, cname, meta(ta))
end

"""
    cci(ohlc, ma=20, c=0.015)

Commodity Channel Index

```math
    CCI = 'frac{P_{typical} - SMA(P_{typical})}{c times sigma(P_{typical})}'
```

**Reference**

- https://en.wikipedia.org/wiki/Commodity_channel_index

"""
function cci(ohlc::TimeArray, ma::Int=20, c::AbstractFloat=0.015)
    pt = typical(ohlc)
    cci = safediv.((pt .- sma(pt, ma)), moving(mean_abs_dev, pt, ma)) ./ c
    rename(cci, :cci)
end

"""
    chaikinoscillator(ohlcv, fast=3, slow=10; h="High", l="Low", c="Close")

**Chaikin Oscillator**

Developed by Marc Chaikin

**Formula**

```math
    'Chaikin OSC = EMA(ADL, fast) - EMA(ADL, slow)'
```

where the [`adl`](@ref) is the Accumulation/Distribution Line.

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:chaikin_oscillator)
"""
function chaikinoscillator(ohlcv::TimeArray, fast::Integer=3, slow::Integer=10;
                           h=:High, l=:Low, c=:Close, v=:Volume)
    _adl = adl(ohlcv, h=h, l=l, c=c, v=v)
    rename(ema(_adl, fast) .- ema(_adl, slow), [:chaikinoscillator])
end

"""
    macd(ta, fast=12, slow=26, signal=9; wilder=false)

Moving Average Convergence / Divergence

```math
    'begin{align*}
        MACD Bar & = DIF - DEM \\
        DIF & = EMA(P_{close}, fast) - EMA(P_{close}, slow) \\
        DEM & = EMA(DIF, 9) tag{signal}
    end{align*}'
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

    cols = [:macd, :dif, :signal]
    new_cols = (N > 1) ? gen_colnames(colnames(ta), cols) : cols

    merge(merge(osc, dif), sig, colnames=new_cols)
end

"""
    roc(ta, n)

**Rate of Change**

**Formula**:

```math
    roc = 'frac{close_{t} - close_{t-n}}{close_{t-n}}'
```

**Reference**:

- [Wikipedia](https://en.wikipedia.org/wiki/Momentum_(technical_analysis))

"""
function roc(ta::TimeArray, n::Integer)
    prev = lag(ta, n)
    rename((ta .- prev) ./ prev, [Symbol("$(c)_roc_$(n)") for c ∈ colnames(ta)])
end

"""
    aroon(ohlc, n=25; h="High", l="Low")

**Aroon Oscillator**

**Formula**

```math
    'begin{align*}
        up   & = frac{mathop{argmax}(High_{t-n} dots High_t)}{n} times 100 \\
        down & = frac{mathop{argmin}(Low_{t-n} dots Low_t)}{n} times 100 \\
        osc  & = up - down
    end{align*}''
```

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:aroon_oscillator)
"""
function aroon(ohlc::TimeArray, n::Integer=25; h=:High, l=:Low)
    up = rename(moving(nanargmax, ohlc[h], n) ./ n .* 100, :up)
    dn = rename(moving(nanargmin, ohlc[l], n) ./ n .* 100, :down)
    osc = rename(up .- dn, :osc)

    merge(merge(up, dn), osc)
end

"""
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
function adx(ohlc::TimeArray, n::Integer=14; h=:High, l=:Low, c=:Close)
    dm = relu(merge(ohlc[h] .- lag(ohlc[h]), lag(ohlc[l]) .- ohlc[l]))

    _dm_values = values(dm)
    _dm_values[findmin(_dm_values, dims=2)[2]] .= 0

    dm = TimeArray(timestamp(dm), _dm_values, colnames(dm))

    dm = wilder_smooth(dm, n)

    tr = wilder_smooth(truerange(ohlc, h=h, l=l, c=c), n)

    di = (dm ./ tr) .* 100
    di = rename(di, [:di_plus, :di_minus])

    dx = @. abs((di[:di_plus] - di[:di_minus]) / (di[:di_plus] + di[:di_minus])) * 100
    adx = wilder_smooth(dx, n, dx=true)

    rename(merge(adx, merge(dx, di)), ([:adx, :dx, :di_plus, :di_minus]))
end

"""
    stochasticoscillator(ohlc, n=14, fast_d=3, slow_d=3; h="High", l="Low", c="Close")

**Stochastic Oscillator**

A.k.a *%K%D*, or *KD*

**Parameter**

- `n`: period of fast(raw) `%K`

- `fast_d`: MA period of fast `%D`

- `slow_d`: MA period of slow `%D`

**Formula**

```math
    'begin{align*}
        fast %K & = frac{Close_t - max(High_{t-n}, dots, High_t)}
            {max(High_{t-n}, dots, High_t) - min(Low_{t-n}, dots, Low_t)}
            times 100 \\
        fast %D & = SMA(fast %K) \\
        slow %D & = SMA(fast %D)
    end{align*}'
```

**Reference**

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Stochastic_oscillator)

- [FMLabs]
  (http://www.fmlabs.com/reference/default.htm?url=StochasticOscillator.htm)
"""
function stochasticoscillator(ohlc::TimeArray, n::Integer=14, fast_d::Integer=3,
                              slow_d::Integer=3; h=:High, l=:Low, c=:Close)
    high = moving(nanmax, ohlc[h], n)
    low = moving(nanmin, ohlc[l], n)
    fast_k = rename((ohlc[c] .- low) ./ (high .- low) .* 100, :fast_k)
    fast_d = rename(sma(fast_k, fast_d), :fast_d)
    slow_d = rename(sma(fast_d, slow_d), :slow_d)
    stch = merge(merge(fast_k, fast_d), slow_d)

end



"""
Vortex Indicator
    
    It consists of two oscillators that capture positive and negative trend
    movement. A bullish signal triggers when the positive trend indicator
    crosses above the negative trend indicator or a key level.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:vortex_indicator
"""
function vortex(ohlc::TimeArray, n::Integer=14; h=:High, l=:Low, c=:Close)
    _h = ohlc[h]
    _l = ohlc[l]
    _c = ohlc[c]

    _lagc = lagfill(_c, 1, nanmean(values(_c)))

    tr = max.(_h, _lagc) .- min.(_l, _lagc)
    trn = moving(nansum, tr, n)

    _lagl = lagfill(_l, 1, nanmean(values(_l)))
    _lagh = lagfill(_h, 1, nanmean(values(_h)))

    vp = moving(nansum, abs.(_h .- _lagl), n) ./ trn
    vm = moving(nansum, abs.(_l .- _lagh), n) ./ trn

    vi = rename(merge(vp, vm), [:v_plus, :v_minus])

end

"""
TRIX INDICATOR

    Shows the percent rate of change of a triple exponentially smoothed moving
    average.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:trix

"""
function trix(ohlc::TimeArray, n::Integer=14; c=:Close)
    _c = ohlc[c]

    ema1 = ema(_c, n)
    ema2 = ema(ema1, n)
    ema3 = ema(ema2, n)
   
    _lagema3 = lagfill(ema3, 1, nanmean(values(ema3))[1])

    trix = (ema3 .- _lagema3) ./ _lagema3
    trix = rename(100 .* trix, [:trix])
    
end


"""
MASS INDEX

    It uses the high-low range to identify trend reversals based on range
    expansions. It identifies range bulges that can foreshadow a reversal of
    the current trend.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:mass_index
"""  
function massindex(ohlc::TimeArray, n::Integer=14, n2::Int=25; h=:High, l=:Low)
    _h = ohlc[h]
    _l = ohlc[l]

    amplitude = _h .- _l

    ema1 = ema(amplitude, n)
    ema2 = ema(ema1, n)
    mass = ema1 ./ ema2
    mass = rename(moving(nansum, mass, n2), [:mi]) 

end

"""
Detrended Price Oscillator (DPO)

    Is an indicator designed to remove trend from price and make it easier to
    identify cycles.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:detrended_price_osci
"""
function dpo(ohlc::TimeArray, n::Int=14; c=:Close)
    _c = ohlc[c]

    lagPeriod = Int(floor(0.5*n) + 1)
    _lagc = lagfill(_c, lagPeriod, nanmean(values(_c)))

    dpo = rename(_lagc .- moving(nanmean, _c, n), [:dpo])

end

"""
KST Oscillator (KST)
    
    It is useful to identify major stock market cycle junctures because its
    formula is weighed to be more greatly influenced by the longer and more
    dominant time spans, in order to better reflect the primary swings of stock
    market cycle.

    https://en.wikipedia.org/wiki/KST_oscillator
"""
function kst(ohlc::TimeArray, r1::Int=10, r2::Int=15, r3::Int=20, r4::Int=30,
        n1::Int=10, n2::Int=10, n3::Int=10, n4::Int=15, nsig::Int=9; c=:Close)
    
    _c = ohlc[c]

    _meanc = nanmean(values(_c))
    _lagcr1 = lagfill(_c, r1, _meanc)
    _lagcr2 = lagfill(_c, r2, _meanc)
    _lagcr3 = lagfill(_c, r3, _meanc)
    _lagcr4 = lagfill(_c, r4, _meanc)

    rocma1 = (_c .- _lagcr1) ./ moving(nanmean, _lagcr1, n1, padding = true)
    rocma2 = (_c .- _lagcr2) ./ moving(nanmean, _lagcr2, n2, padding = true)
    rocma3 = (_c .- _lagcr3) ./ moving(nanmean, _lagcr3, n3, padding = true)
    rocma4 = (_c .- _lagcr4) ./ moving(nanmean, _lagcr4, n4, padding = true)

    kst = 100 .* (rocma1 .+ (2 .* rocma2) .+ (3 .* rocma3) .+ (4 .* rocma4))
    kst_sig = moving(nanmean, kst, nsig)

    rename(merge(kst, kst_sig), [:kst, :signal])
end

"""
Ichimoku Kinkō Hyō (Ichimoku)
    
    It identifies the trend and look for potential signals within that trend.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:ichimoku_cloud
"""
function ichimoku(ohlc::TimeArray, n1::Int=9, n2::Int=26, n3::Int=52, visual::Bool=False; h=:High, l=:Low)
    _h = ohlc[h]
    _l = ohlc[l]

    conv = 0.5 .* (moving(nanmax, _h, n1) + moving(nanmin, _l, n1))
    base = 0.5 .* (moving(nanmax, _h, n2) + moving(nanmin, _l, n2))

    spana = 0.5 .* (conv + base)
    spanb = 0.5 .* (moving(nanmax, _h, n3) + moving(nanmin, _l, n3))

    if visual
        spana = lagfill(spana, n2, nanmean(values(spana)))
        spanb = lagfill(spana, n2, nanmean(values(spanb)))
    end
    
    ichimoku = rename(merge(spana, spanb), [:ichimoku_a, :ichimoku_b])

end



"""
Money Flow Index (MFI)
    
    Uses both price and volume to measure buying and selling pressure. It is
    positive when the typical price rises (buying pressure) and negative when
    the typical price declines (selling pressure). A ratio of positive and
    negative money flow is then plugged into an RSI formula to create an
    oscillator that moves between zero and one hundred.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:money_flow_index_mfi
"""
function moneyflowindex(ohlcv::TimeArray, n::Int=14; c=:Close, h=:High, l=:Low, v=:Volume)   

    _v = ohlcv[v]
    typ = typical(ohlcv, c = c, h = h, l = l)

    rmf = typ .* _v
    values_rmf = values(rmf)

    lagtyp = lagfill(typ, 1, NaN)

    mf_pos_flag = values(typ .> lagtyp)
    mf_neg_flag = values(typ .< lagtyp)
    
    # Positive rate of money flow
    values_rmf_p = copy(values_rmf)
    values_rmf_p[mf_pos_flag] .= 0
    rmf_p = moving(nansum, TimeArray(timestamp(ohlcv), values_rmf_p, [:rmf_p]), n, padding = true) 

    # Negative rate of money flow
    values_rmf_n = copy(values_rmf)
    values_rmf_n[mf_neg_flag] .= 0
    rmf_n = moving(nansum, TimeArray(timestamp(ohlcv), values_rmf_n, [:rmf_n]), n, padding = true)

    mfr = rmf_p ./ rmf_n
    
    mfi_values = 100 .- 100 ./ (1 .+ values(mfr))

    mfi = TimeArray(timestamp(ohlcv), mfi_values, [:mfi])


end


"""
TRUE STRENGTH INDEX

    Shows both trend direction and overbought/oversold conditions.
    
    https://en.wikipedia.org/wiki/True_strength_index
"""
function tsi(ohlc::TimeArray, r::Int=25, s::Int=13; c=:Close)
    _c = ohlc[c]
    _lagc = lagfill(_c, 1, nanmean(values(_c)))

    m = _c .- _lagc

    m1 = ema(ema(m, r), s)
    m2 = ema(ema(abs.(m), r), s)

    tsi = rename(100 .* (m1 ./ m2), [:tsi])

end


"""
Ultimate Oscillator

    Larry Williams' (1976) signal, a momentum oscillator designed to capture
    momentum across three different timeframes.

    http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:ultimate_oscillator

    BP = Close - Minimum(Low or Prior Close).
    TR = Maximum(High or Prior Close)  -  Minimum(Low or Prior Close)
    Average7 = (7-period BP Sum) / (7-period TR Sum)
    Average14 = (14-period BP Sum) / (14-period TR Sum)
    Average28 = (28-period BP Sum) / (28-period TR Sum)
    UO = 100 x [(4 x Average7)+(2 x Average14)+Average28]/(4+2+1)
"""
function ultimateoscillator(ohlc::TimeArray, s::Int=7, m::Int=14, len::Int=28, ws::Float64=4.0, wm::Float64=2.0, wl::Float64=1.0; c=:Close, h=:High, l=:Low)
    _c = ohlc[c]
    _h = ohlc[h]
    _l = ohlc[l]

    _lagc = lagfill(_c, 1, nanmean(values(_c)))

    min_l_or_pc = min.(_l, _lagc)
    max_h_or_pc = max.(_h, _lagc)

    bp = _c .- min_l_or_pc
    tr = max_h_or_pc .- min_l_or_pc

    avg_s = moving(nansum, bp, s, padding = true) ./ moving(nansum, tr, s, padding = true)
    avg_m = moving(nansum, bp, m, padding = true) ./ moving(nansum, tr, m, padding = true)
    avg_l = moving(nansum, bp, len, padding = true) ./ moving(nansum, tr, len, padding = true)

    uo = rename(100.0 .* ((ws .* avg_s) .+ (wm .* avg_m) .+ (wl .* avg_l)) ./ (ws + wm + wl), [:uo])

end


"""
Williams %R

    From: http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:williams_r

    Developed by Larry Williams, Williams %R is a momentum indicator that is
    the inverse of the Fast Stochastic Oscillator. Also referred to as %R,
    Williams %R reflects the level of the close relative to the highest high
    for the look-back period. In contrast, the Stochastic Oscillator reflects
    the level of the close relative to the lowest low. %R corrects for the
    inversion by multiplying the raw value by -100. As a result, the Fast
    Stochastic Oscillator and Williams %R produce the exact same lines, only
    the scaling is different. Williams %R oscillates from 0 to -100.

    Readings from 0 to -20 are considered overbought. Readings from -80 to -100
    are considered oversold.

    Unsurprisingly, signals derived from the Stochastic Oscillator are also
    applicable to Williams %R.

    %R = (Highest High - Close)/(Highest High - Lowest Low) * -100

    Lowest Low = lowest low for the look-back period
    Highest High = highest high for the look-back period
    %R is multiplied by -100 correct the inversion and move the decimal.

    From: https://www.investopedia.com/terms/w/williamsr.asp
    The Williams %R oscillates from 0 to -100. When the indicator produces
    readings from 0 to -20, this indicates overbought market conditions. When
    readings are -80 to -100, it indicates oversold market conditions.
"""
function williamsr(ohlc::TimeArray, n::Int=14; c=:Close, h=:High, l=:Low)
    _c = ohlc[c]
    _h = ohlc[h]
    _l = ohlc[l]

    hh = moving(nanmax, _h, n) # highest high over lookback period lbp
    ll = moving(nanmin, _l, n) # lowest low over lookback period lbp
    
    wr = rename(-100 .* (hh .- _c) ./ (hh .- ll), [:wr])

end


"""
Awesome Oscillator
    
    From: https://www.tradingview.com/wiki/Awesome_Oscillator_(AO)
    
    The Awesome Oscillator is an indicator used to measure market momentum. AO
    calculates the difference of a 34 Period and 5 Period Simple Moving
    Averages. The Simple Moving Averages that are used are not calculated
    using closing price but rather each bar's midpoints. AO is generally used
    to affirm trends or to anticipate possible reversals.

    From: https://www.ifcm.co.uk/ntx-indicators/awesome-oscillator

    Awesome Oscillator is a 34-period simple moving average, plotted through
    the central points of the bars (H+L)/2, and subtracted from the 5-period
    simple moving average, graphed across the central points of the bars
    (H+L)/2.

    MEDIAN PRICE = (HIGH+LOW)/2

    AO = SMA(MEDIAN PRICE, 5)-SMA(MEDIAN PRICE, 34)
    where
    SMA — Simple Moving Average.

"""
function awesomeoscillator(ohlc::TimeArray, s::Int=5, len::Int=34; h=:High, l=:Low)
    _h = ohlc[h]
    _l = ohlc[l]

    mp = 0.5 .* (_h .+ _l)
    
    ao = rename(moving(nanmean, mp, s) .- moving(nanmean, mp, len), [:ao])

end

