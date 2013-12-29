function sma(x, n::Int)
  [mean(x[i:i+(n-1)]) for i=1:length(x)-(n-1)]
end


function ema{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)

  k   = 2/(n+1)
  m   = sma(value(sa), n) 
  res = SeriesPair{T,V}[]
  push!(res, SeriesPair(index(sa)[n], m[n])) # first one is always simple 

  if n > 1
  for i = n+1:length(sa)
    sp = SeriesPair(sa[i].index, (sa[i].value * k + sa[i-1].value * (1-k)))
    push!(res, sp)
  else
    error("You can't move with a period of less than 2. Think about this grasshopper.")
  end
  end
  res
end


#    [sa[i] = sa[i]*k + sa[i-1]*(1-k) for i=(n+1):length(sa)]


function ema_wilder(dv::DataArray, n::Int)

  dv = copy(dv)

  k = 1/n
  m = sma(dv, n) 

  if n == 1
    [dv[i] = dv[i] for i=1:length(dv)]
  else
    dv[n] = m[1] 
    [dv[i] = dv[i]*k + dv[i-1]*(1-k) for i=(n+1):length(dv)]
  end
  pad(dv[n:length(dv)], n-1, 0, NA)
end



function ema_unpadded(dv::DataArray, n::Int)
  k = 2/(n+1)
  #m = sma_reg(dv, n) 
  m = sma(dv, n) 

  if n == 1
    [dv[i] = dv[i] for i=1:length(dv)]
  else
    dv[n] = m[1] 
  for i=(n+1):length(dv)
    dv[i] = dv[i]*k + dv[i-1]*(1-k) 
  end
  end
  dv[n:length(dv)]
end
