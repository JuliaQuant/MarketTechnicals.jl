function sma{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)
  res = SeriesPair{T,V}[]
  for i in 1:length(sa) - (n-1)
    sp = SeriesPair(sa[i+(n-1)].index, mean(value(sa[i:i+(n-1)])))
    push!(res, sp)
  end
  res
end

function sma{T}(a::Array{T,1}, n::Int)
  res = Float64[]
  for i in 1:size(a, 1) - (n-1)
    val = mean(a[i:i+(n-1)])
    push!(res, val)
  end
  res
end

function ema{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int; wilder=false)

#  wilder ?  eval(:(k  = 1/$n)) : eval(:(k = 2/($n+1)))

  if  wilder 
    k  = 1/n 
  else
    k = 2/(n+1)
  end

  m   = sma(sa, n) 
  res = SeriesPair{T,V}[]
  push!(res, SeriesPair(index(sa)[n], m[1].value)) # first one is always simple 
 
  for i = n+1:length(sa)
    sp = SeriesPair(sa[i].index, (sa[i].value * k + res[i-n].value * (1-k)))
    push!(res, sp)
  end
  res
end

function ema{T}(a::Array{T,1}, n::Int; wilder=false)

  if  wilder 
    k  = 1/n 
  else
    k = 2/(n+1)
  end
 
  m   = sma(a, n) 
  res = Float64[]
  push!(res, m[1]) # first one is always simple 

  for i = n+1:size(a, 1)
    val = a[i] * k + res[i-n] * (1-k)
    push!(res, val)
  end
  res
end
