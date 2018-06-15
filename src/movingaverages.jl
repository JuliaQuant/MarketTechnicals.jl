function sma(ta::TimeArray{T,N}, n::Int) where {T,N}
    tstamps = ta.timestamp[n:end]

    vals = zeros(size(ta.values,1) - (n-1), size(ta.values,2))
    for i in 1:size(ta.values,1) - (n-1)
        for j in 1:size(ta.values,2)
            vals[i,j] = mean(ta.values[i:i+(n-1),j])
        end
    end

    cname = String[]
    cols  = colnames(ta)
    for c in 1:length(cols)
        push!(cname, string(cols[c], "_sma_", n))
    end

    TimeArray(tstamps, vals, cname, ta.meta)
end

function ema(ta::TimeArray{T,N}, n::Int; wilder=false) where {T,N}
    k = if wilder
        1 / n
    else
        2 / (n + 1)
    end

    tstamps = ta.timestamp[n:end]

    vals    =  zeros(size(ta.values,1), size(ta.values,2))
    # seed with first value with an sma value
    vals[n,:] = sma(ta, n).values[1,:]

    for i in n+1:size(ta.values,1)
        for j in 1:size(ta.values,2)
            vals[i,j] = ta.values[i,j] * k + vals[i-1, j] * (1-k)
        end
    end

    cname   = String[]
    cols    = colnames(ta)
    for c in 1:length(cols)
        push!(cname, string(cols[c], "_ema_", n))
    end

    TimeArray(tstamps, vals[n:length(ta),:], cname, ta.meta)
end

function kama(ta::TimeArray{T,N}, n::Int=10, fn::Int=2, sn::Int=30) where {T,N}
    vola = moving(sum, abs.(ta .- lag(ta)), n)
    change = abs.(ta .- lag(ta, n))
    er = safediv.(change, vola)  # Efficiency Ratio

    # Smooth Constant
    sc = (er .* (2 / (fn + 1) - 2 / (sn + 1)) .+ 2 / (sn + 1)).^2

    cl = ta[n+1:end]
    vals = similar(Array{Float64}, indices(cl.values))
    # using simple moving average as initial kama
    pri_kama = mean(ta[1:n].values, 1)

    @assert length(cl) == length(sc)

    for idx ∈ 1:length(cl)
        vals[idx, :] =
            pri_kama =
            pri_kama .+ sc[idx].values .* (cl[idx].values .- pri_kama)
    end

    cols =
    if length(ta.colnames) == 1
        ["kama"]
    else
        ["$c\_kama" for c in ta.colnames]
    end

    TimeArray(cl.timestamp, vals, cols)
end

function env(ta::TimeArray{T,N}, n::Int; e::Float64 = 0.1) where {T,N}
    tstamps = ta.timestamp[n:end]

    s = sma(ta, n)

    upper = s.values .+ (s.values .* e)
    lower = s.values .- (s.values .* e)

    cname = String[]
    cols  = colnames(ta)
    for c in 1:length(cols)
        push!(cname, string(cols[c], "_env_", n))
    end

    TimeArray(tstamps, upper, cname, ta.meta), TimeArray(tstamps, lower, cname, ta.meta)
end

# Array dispatch for use by other algorithms

function sma(a::Array{T,N}, n::Int) where {T,N}
    vals = zeros(size(a,1) - (n-1), size(a,2))

    for i in 1:size(a,1) - (n-1)
        for j in 1:size(a,2)
            vals[i,j] = mean(a[i:i+(n-1),j])
        end
    end

    vals
end

function ema(a::Array{T,N}, n::Int; wilder=false) where {T,N}
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

function env(a::Array{T,N}, n::Int; e::Float64 = 0.1) where {T,N}
    s = sma(a, n)

    upper = s + s * e
    lower = s - s * e

    upper, lower
end

doc"""
    sma(arr, n)

Simple Moving Average

```math
SMA = \frac{\sum_i^n{P_i}}{n}
```
"""
sma

doc"""
    ema(arr, n, wilder=false)

Exponemtial Moving Average

A.k.a. exponentially weighted moving average (EWMA)

```math
    \text{Let } k \text{denote the degree of weighting decrease}
```

If parameter `wilder` is `true`, ``k = \frac{1}{n}``,
else ``k = \frac{2}{n + 1}``.

```math
    EMA_t = k \times P_t + (1 - k) \times EMA_{t - 1}
```
"""
ema

doc"""

Kaufman's Adaptive Moving Average

**Arguments**:

- `n`: period

- `fn`: the fastest EMA constant

- `sn`: the slowest EMA constant

**Formula**:

```math
    \begin{align*}
        KAMA_t & = KAMA_{t-1} + SC \times (Price - KAMA_{t-1}) \\
        SC     & =
            (ER \times (\frac{2}{fn + 1} - \frac{2}{sn + 1}) + \frac{2}{sn + 1})^2 \\
        ER     & = \frac{Change}{Volatility} \\
        Change & = | Price - Price_{t-n} | \\
        Volatility & = \sum_{i}^{n} | Price_i - Price_{i-1} |
    \end{align*}
```
"""
kama
