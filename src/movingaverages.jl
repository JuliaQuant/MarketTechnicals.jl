function sma(ta::TimeArray, n::Integer)
  m = moving(mean, ta, n)
  cols = gen_colnames(colnames(ta), ["sma_$n"])
  TimeArray(m; colnames = cols)
end

function ema(ta::TimeArray, n::Integer; wilder::Bool = false)
  k       = wilder ? (1 / n) : 2 / (n + 1)
  tstamps = timestamp(ta)[n:end]
  vals    = _ema(values(ta), n, k)
  cols    = gen_colnames(colnames(ta), ["ema_$n"])

  TimeArray(tstamps, vals, cols, meta(ta))
end

function kama(ta::TimeArray, n::Int=10, fn::Int=2, sn::Int=30)
  vola = moving(sum, abs.(ta .- lag(ta)), n)
  change = abs.(ta .- lag(ta, n))
  er = safediv.(change, vola)  # Efficiency Ratio

  # Smooth Constant
  sc = (er .* (2 / (fn + 1) - 2 / (sn + 1)) .+ 2 / (sn + 1)).^2

  cl = ta[n+1:end]
  vals = similar(values(cl), Float64)
  # using simple moving average as initial kama
  pri_kama = mean(values(ta[1:n]), dims = 1)

  @assert length(cl) == length(sc)

  for idx ∈ 1:length(cl)
    vals[idx, :] =
    pri_kama =
    pri_kama .+ values(sc[idx]) .* (values(cl[idx]) .- pri_kama)
  end

  cols =
    if length(colnames(ta)) == 1
      [:kama]
    else
      Symbol.(colnames(ta), "_kama")
    end

  TimeArray(timestamp(cl), vals, cols)
end

function env(ta::TimeArray, n::Int; e::Float64 = 0.1)
  tstamps = timestamp(ta)[n:end]

  s = sma(ta, n)

  upper = values(s) .* (1 + e)
  lower = values(s) .* (1 - e)

  up_cname = Symbol.(colnames(ta), "_env_$n", "_up")
  lw_cname = Symbol.(colnames(ta), "_env_$n", "_low")

  u = TimeArray(tstamps, upper, up_cname, meta(ta))
  l = TimeArray(tstamps, lower, lw_cname, meta(ta))

  merge(l, u, method = :inner)
end

# Array dispatch for use by other algorithms

function sma(A::AbstractArray{T,1}, n::Integer) where {T}
  B = similar(@view(A[n:end]), Float64)
  for i ∈ eachindex(B)
    B[i] = mean(@view(A[i:i+n-1]))
  end
  B
end

function sma(A::AbstractArray{T,2}, n::Integer) where {T}
  B = similar(@view(A[n:end, :]), Float64)
  for i ∈ 1:size(B, 1)
    B[i, :] .= vec(mean(@view(A[i:i+n-1, :]), dims = 1))
  end
  B
end

ema(A::AbstractArray, n::Integer; wilder = false) =
  _ema(A, n, ifelse(wilder, 1 / n, 2 / (n + 1 )))

function _ema(A::AbstractArray{T,1}, n::Integer, k::AbstractFloat) where {T}
  l = length(A)
  B = @view A[n:end]
  C = similar(B, Float64)
  # sma as initial value
  C[1] = first(sma(@view(A[1:n]), n))

  for i ∈ 2:size(C, 1)
    C[i] = B[i] * k + C[i-1] * (1 - k)
  end

  C
end

function _ema(A::AbstractArray{T,2}, n::Integer, k::AbstractFloat) where {T}
  l = size(A, 1)
  B = @view A[n:end, :]
  C = similar(B, Float64)
  # sma as initial value
  C[1, :] .= @view(sma(@view(A[1:n, :]), n)[1, :])

  for i ∈ 2:size(C, 1)
    @. C[i, :] = B[i, :] * k + C[i-1, :] * (1 - k)
  end

  C
end

function env(a::AbstractArray, n::Integer; e::Float64 = 0.1)
  s = sma(a, n)

  upper = @. s * (1 + e)
  lower = @. s * (1 - e)

  [lower upper]
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

doc"""

    env(arr, n; e = 0.1)

Moving Average Envelope

```math
  \begin{align*}
    \text{Upper Envelope} & = \text{n period SMA } \times (1 + e) \\
    \text{Lower Envelope} & = \text{n period SMA } \times (1 - e)
  \end{align*}
```

**Arguments**

- `e`: the envelope, `0.1` implies the `10%` envelope.

**Reference**

- [TradingView](https://www.tradingview.com/wiki/Envelope_(ENV))
"""
env
