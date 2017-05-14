doc"""
    rsi(ta, n=14; wilder=false)

Relative Strength Index

```math
    RSI = \frac{EMA(Up, n)}{EMA(Up, n) + EMA(Dn, n)}
```
"""
function rsi{T,N}(ta::TimeArray{T,N}, n::Int=14; wilder::Bool=false)
    # for the record I'm not happy about transposing zeros here
    # since it's difficult to see why
    ret = vcat(zeros(length(colnames(ta)))', diff(ta.values))
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
    dnsema = abs(ema(dns, n, wilder=wilder))
    rs     = upsema ./ dnsema

    res  = 100 .- (100./(1 .+ rs))

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
function cci{T,N}(ohlc::TimeArray{T,N}, ma::Int=20, c::AbstractFloat=0.015)
    pt = typical(ohlc)
    cci = ((pt .- sma(pt, ma)) ./ moving(pt, mean_abs_dev, ma)) ./ c
    rename(cci, "cci")
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
function macd{T,N}(ta::TimeArray{T,N},
                   fast::Int=12, slow::Int=26, signal::Int=9;
                   wilder::Bool=false)
    dif = ema(ta, fast, wilder=wilder) .- ema(ta, slow, wilder=wilder)
    sig = ema(dif, signal, wilder=wilder)
    osc = dif .- sig

    cols = ["macd", "dif", "signal"]
    new_cols = (N > 1) ? gen_colnames(ta.colnames, cols) : cols

    merge(merge(osc, dif), sig, colnames=new_cols)
end
