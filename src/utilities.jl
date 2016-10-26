function typical{T,N}(ohlc::TimeArray{T,N}; h="High", l="Low", c="Close")
    val = (ohlc[h] .+ ohlc[l] .+ ohlc[c]) ./3
    TimeArray(val.timestamp, val.values, ["typical"], ohlc.meta)
end

function mean_abs_dev{T}(a::Array{T,1}, scale::Bool=false)
    scale ? c = 1 / (-sqrt(2) * erfcinv(3 * 1 / 2)) : c =1

    res = ones(length(a))
    for i in 1:length(a)
        @inbounds res[i] = abs(a[i] - mean(a))
    end

    mean(res) * c
end
