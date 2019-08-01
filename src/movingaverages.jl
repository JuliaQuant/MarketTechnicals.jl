function sma(ta::TimeArray, n::Int)
    tstamps = timestamp(ta)[n:end]

    vals = zeros(size(values(ta),1) - (n-1), size(values(ta),2))
    for i in 1:size(values(ta),1) - (n-1)
        for j in 1:size(values(ta),2)
            vals[i,j] = nanmean(values(ta)[i:i+(n-1),j])[1]
        end
    end

    cname = Symbol[]
    cols  = colnames(ta)
    for c in 1:length(cols)
        push!(cname, Symbol(string(cols[c], "_sma_", n)))
    end

    TimeArray(tstamps, vals, cname, meta(ta))
end

function ema(ta::TimeArray, n::Int; wilder=false)
    k = if wilder
        1 / n
    else
        2 / (n + 1)
    end

    tstamps = timestamp(ta)[n:end]

    vals    =  zeros(size(values(ta),1), size(values(ta),2))
    # seed with first value with an sma value
    vals[n,:] = values(sma(ta, n))[1,:]

    for i in n+1:size(values(ta),1)
        for j in 1:size(values(ta),2)
            _v = values(ta)[i,j]
            vals[i,j] = isnan(_v) ? vals[i-1, j] : _v * k + vals[i-1, j] * (1-k)
        end
    end

    cname   = Symbol[]
    cols    = colnames(ta)
    for c in 1:length(cols)
        push!(cname, Symbol(string(cols[c], "_ema_", n)))
    end

    TimeArray(tstamps, vals[n:length(ta),:], cname, meta(ta))
end

function kama(ta::TimeArray, n::Int=10, fn::Int=2, sn::Int=30)
    vola = moving(nansum, abs.(ta .- lag(ta)), n)
    change = abs.(ta .- lag(ta, n))
    er = safediv.(change, vola)  # Efficiency Ratio

    # Smooth Constant
    sc = (er .* (2 / (fn + 1) - 2 / (sn + 1)) .+ 2 / (sn + 1)).^2

    cl = ta[n+1:end]

    vals = similar(Array{Float64}, axes(values(cl)))
    # using simple moving average as initial kama
    pri_kama = nanmean(values(ta[1:n]))

    @assert length(cl) == length(sc)

    for idx ∈ 1:length(cl)
        _p_k = pri_kama .+ values(sc[idx]) .* (values(cl[idx]) .- pri_kama)
        
        #Added check for NaN and adequately backfill with the correct last available pri_kama
        if typeof(pri_kama) == Float64
            pri_kama = isnan.(_p_k)[1] ? pri_kama : _p_k
        else
            _p_k[isnan.(_p_k)] .= pri_kama[isnan.(_p_k)]
            pri_kama = _p_k
        end

        vals[idx, :] = pri_kama
            
    end

    cols =
    if length(colnames(ta)) == 1
        [:kama]
    else
        [Symbol("$(c)_kama") for c in colnames(ta)]
    end

    TimeArray(timestamp(cl), vals, cols)
end

function env(ta::TimeArray, n::Int; e::Float64 = 0.1)
    tstamps = timestamp(ta)[n:end]

    s = sma(ta, n)

    upper = values(s) .* (1 + e)
    lower = values(s) .* (1 - e)

    up_cnames = Symbol.(["$(string.(c_name))_env_$(n)_up" for c_name in colnames(ta)])
    lw_cnames = Symbol.(["$(string.(c_name))_env_$(n)_low" for c_name in colnames(ta)])

    u = TimeArray(tstamps, upper, up_cnames, meta(ta))
    l = TimeArray(tstamps, lower, lw_cnames, meta(ta))

    merge(l, u, :inner)
end

# Array dispatch for use by other algorithms

function sma(a::Array, n::Int)
    vals = zeros(size(a,1) - (n-1), size(a,2))

    for i in 1:size(a,1) - (n-1)
        for j in 1:size(a,2)
            vals[i,j] = nanmean(a[i:i+(n-1),j])
        end
    end

    vals
end

function ema(a::Array, n::Int; wilder=false)
    k = if wilder
        1 / n
    else
        2 / (n + 1)
    end

    vals = zeros(size(a,1), size(a,2))
    # seed with first value with an sma value
    vals[n,:] = sma(a, n)[1,:]

    for i in n+1:size(a,1)
        for j in 1:size(a,2)
            vals[i,j] = a[i,j] * k + vals[i-1, j] * (1-k)
        end
    end

    vals[n:end, :]
end

function env(a::AbstractArray, n::Int; e::Float64 = 0.1)
    s = sma(a, n)

    upper = @. s * (1 + e)
    lower = @. s * (1 - e)

    [lower upper]
end

"""
    sma(arr, n)

Simple Moving Average

```math
SMA = 'frac{sum_i^n{P_i}}{n}'
```
"""

"""
    ema(arr, n, wilder=false)

Exponemtial Moving Average

A.k.a. exponentially weighted moving average (EWMA)

```math
    'text{Let } k text{denote the degree of weighting decrease}'
```

If parameter `wilder` is `true`, ``k = 'frac{1}{n}'``,
else ``k = 'frac{2}{n + 1}'``.

```math
    EMA_t = k 'times P_t + (1 - k) times EMA_{t - 1}'
```
"""

"""

Kaufman's Adaptive Moving Average

**Arguments**:

- `n`: period

- `fn`: the fastest EMA constant

- `sn`: the slowest EMA constant

**Formula**:

```math
    'begin{align*}
        KAMA_t & = KAMA_{t-1} + SC times (Price - KAMA_{t-1}) \\
        SC     & =
            (ER times (frac{2}{fn + 1} - frac{2}{sn + 1}) + frac{2}{sn + 1})^2 \\
        ER     & = frac{Change}{Volatility} \\
        Change & = | Price - Price_{t-n} | \\
        Volatility & = sum_{i}^{n} | Price_i - Price_{i-1} |
    end{align*}'
```
"""

"""

    env(arr, n; e = 0.1)

Moving Average Envelope

```math
  'begin{align*}
    text{Upper Envelope} & = text{n period SMA } times (1 + e) \\
    text{Lower Envelope} & = text{n period SMA } times (1 - e)
  end{align*}''
```

**Arguments**

- `e`: the envelope, `0.1` implies the `10%` envelope.

**Reference**

- [TradingView](https://www.tradingview.com/wiki/Envelope_(ENV))
"""
