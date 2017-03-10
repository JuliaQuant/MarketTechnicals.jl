function sma{T,N}(ta::TimeArray{T,N}, n::Int)

    tstamps = ta.timestamp[n:end]

    vals = zeros(size(ta.values,1) - (n-1), size(ta.values,2))
    for i in 1:size(ta.values,1) - (n-1)
        for j in 1:size(ta.values,2)
            vals[i,j] = mean(ta.values[i:i+(n-1),j])
        end
    end

    cname   = String[]
    cols    = colnames(ta)
    for c in 1:length(cols)
        push!(cname, string(cols[c], "_sma_", n))
    end

    TimeArray(tstamps, vals, cname, ta.meta)
end

function ema{T,N}(ta::TimeArray{T,N}, n::Int; wilder=false)

    if  wilder
        k  = 1/n
    else
        k = 2/(n+1)
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

# Array dispatch for use by other algorithms

function sma{T,N}(a::Array{T,N}, n::Int)

    vals = zeros(size(a,1) - (n-1), size(a,2))

    for i in 1:size(a,1) - (n-1)
        for j in 1:size(a,2)
            vals[i,j] = mean(a[i:i+(n-1),j])
        end
    end

    vals
end

function ema{T,N}(a::Array{T,N}, n::Int; wilder=false)

    if  wilder
        k  = 1/n
    else
        k = 2/(n+1)
    end

    vals    =  zeros(size(a,1), size(a,2))
    # seed with first value with an sma value
    vals[n,:] = sma(a, n)[1,:]

    for i in n+1:size(a,1)
        for j in 1:size(a,2)
            vals[i,j] = a[i,j] * k + vals[i-1, j] * (1-k)
        end
    end

    vals[n:end,:]
end

doc"""
Simple Moving Average

```math
SMA = \frac{\sum^n{P_i}}{n}
```
"""
sma
