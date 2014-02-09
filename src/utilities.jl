function Base.abs{T,N}(ta::TimeArray{T,N})
    TimeArray(ta.timestamp, abs(ta.values), ta.colnames)
end
