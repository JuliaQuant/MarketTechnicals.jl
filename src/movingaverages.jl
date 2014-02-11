function sma{T,N}(ta::TimeArray{T,N}, n::Int)
  tstamps = ta.timestamp[n:end]
  vals    = zeros(length(ta) - (n-1))
  for i in 1:length(ta) - (n-1)
    vals[i] =  mean(ta.values[i:i+(n-1)])
  end
  TimeArray(tstamps, vals, ta.colnames) 
end

function ema{T,N}(ta::TimeArray{T,N}, n::Int; wilder=false)

  if  wilder 
    k  = 1/n 
  else
    k = 2/(n+1)
  end

  tstamps = ta.timestamp[n:end]
  vals    = ones(length(ta))
  vals[n] = sma(ta, n).values[1] # seed with first value an sma value
 
  for i = n+1:length(ta)
    vals[i] =  ta.values[i] * k + vals[i-1] * (1-k)
  end
  TimeArray(tstamps, vals[n:length(ta)], ta.colnames)
end
