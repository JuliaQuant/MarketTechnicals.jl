function Base.abs{T,N}(ta::TimeArray{T,N})
    TimeArray(ta.timestamp, abs(ta.values), ta.colnames)
end

function typical{T,N}(ohlc::TimeArray{T,N}; h="High", l="Low", c="Close")
    val = (ohlc[h] .+ ohlc[l] .+ ohlc[c]) ./3
    TimeArray(val.timestamp, val.values, ["typical"])
end

# #function Base.min{T,N}(ta::TimeArray{T,N})
# function mini{T}(ta::TimeArray{T,2})
#     vals =  min(ta.values[:,1], ta.values[:,2])
#     TimeArray(ta,timestamp, vals, ["min"])
# end
# 
# #function Base.max{T,N}(ta::TimeArray{T,N})
# function maxi{T}(ta1::TimeArray{T,1}, ta2::TimeArray{T,1})
#     TimeArray(ta.timestamp, max(ta1.values, ta2.values), ["min"])
# end
