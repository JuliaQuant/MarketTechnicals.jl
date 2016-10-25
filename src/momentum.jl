#function rsi{T}(ta::TimeArray{T,1}, n::Int; wilder=false)

function rsi{T,N}(ta::TimeArray{T,N}, n::Int=14; wilder=false)

    # for the record I'm not happy about transposing zeros here since it's difficult to see why
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

#rsi{T,N}(ta::TimeArray{T,N}) = rsi(ta, 14)

function macd{T}(ta::TimeArray{T,1}, fast::Int=12, slow::Int=26, signal::Int=9)
    mcd = ema(ta, fast) .- ema(ta, slow)
    sig = ema(mcd, signal)
    merge(mcd, sig, colnames=["macd", "signal"])
end

#macd{T}(ta::TimeArray{T,1}) = macd(ta, 12, 26, 9)
 
# function cci{T,N,M}(ohlc::TimeArray{T,N,M}, ma::Int, c::Float64)
#   	typ     = typical(ohlc)
#     sma_typ = sma(typ, ma)
#     diff    = typ .- sma_typ
#     #mead   = mad1(typ)
#     mead    = moving(typ, mad1, 20)
#     divisor = mead .* c
#     vals    = diff ./ divisor
#   	TimeArray(diff.timestamp, vals.values, ["cci"])
# end
# 
# cci{T,N,M}(ohlc::TimeArray{T,N,M}) = cci(ohlc, 20, .015)
