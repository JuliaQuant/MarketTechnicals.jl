function sma{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)
  res = SeriesPair{T,V}[]
  for i in 1:length(sa) - (n-1)
    sp = SeriesPair(sa[i].index, mean(value(sa[i:i+(n-1)])))
    push!(res, sp)
  end
  res
end

function ema{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)

  k   = 2/(n+1)
  m   = sma(sa, n) 
  res = SeriesPair{T,V}[]
  push!(res, SeriesPair(index(sa)[n], m[1].value)) # first one is always simple 

  for i = n+1:length(sa)
    sp = SeriesPair(sa[i].index, (sa[i].value * k + res[i-n].value * (1-k)))
    push!(res, sp)
  end
  res
end


#### function ema_wilder(dv::DataArray, n::Int)
#### 
####   dv = copy(dv)
#### 
####   k = 1/n
####   m = sma(dv, n) 
#### 
####   if n == 1
####     [dv[i] = dv[i] for i=1:length(dv)]
####   else
####     dv[n] = m[1] 
####     [dv[i] = dv[i]*k + dv[i-1]*(1-k) for i=(n+1):length(dv)]
####   end
####   pad(dv[n:length(dv)], n-1, 0, NA)
#### end
