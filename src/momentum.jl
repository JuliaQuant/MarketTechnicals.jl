doc"""
    rsi(ta, n=14; wilder=false)

Relative Strength Index

```math
    RSI = \frac{EMA(Up, n)}{EMA(Up, n) + EMA(Dn, n)}
```
"""
function rsi{T,N}(ta::TimeArray{T,N}, n::Int=14; wilder=false)
    # for the record I'm not happy about transposing zeros here
    # since it's difficult to see why
    ret = vcat(zeros(length(colnames(ta)))', diff(ta.values))
    ups = zeros(size(ta.values,1), size(ta.values,2))
    dns = zeros(size(ta.values,1), size(ta.values,2))

    for i in 1:size(ta.values,1)
        for j in 1:size(ta.values,2)
            if ret[i,j] >= 0
                ups[i,j] += ret[i,j]
            else
                dns[i,j] += ret[i,j]
            end
        end
    end

    if  wilder
        upsema = ema(ups, n, wilder=true)
        dnsema = abs(ema(dns, n, wilder=true))
        rs     = upsema ./ dnsema

    else
        upsema  = ema(ups, n)
        dnsema  = abs(ema(dns, n))
        rs      = upsema ./ dnsema
    end

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
"""
function cci{T,N}(ohlc::TimeArray{T,N}, ma::Int=20, c::Float64=0.015)
    res = moving(typical(ohlc), mean_abs_dev, ma) ./ c
    rename(res, "cci")
end

doc"""
    macd(ta, fast=12, slow=26, signal=9)

Moving Average Convergence / Divergence

```math
    \begin{align*}
        MACD Bar & = DIF - DEM \\
        DIF & = EMA(P_{close}, fast) - EMA(P_{close}, slow) \\
        DEM & = EMA(DIF, 9) \tag{signal}
    \end{align*}
```
"""
function macd{T}(ta::TimeArray{T,1}, fast::Int=12, slow::Int=26, signal::Int=9)
    mcd = ema(ta, fast) .- ema(ta, slow)
    sig = ema(mcd, signal)
    merge(mcd, sig, colnames=["macd", "signal"])
end
