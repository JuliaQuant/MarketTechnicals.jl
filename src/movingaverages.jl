function sma{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)
  res = SeriesPair{T,V}[]
  for i in 1:length(sa) - (n-1)
    sp = SeriesPair(sa[i].index, mean(value(sa[i:i+(n-1)])))
    push!(res, sp)
  end
  res
end

function ema{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int; method="simple")
  if method == "simple"
    k   = 2/(n+1)
    m   = sma(sa, n) 
    res = SeriesPair{T,V}[]
    push!(res, SeriesPair(index(sa)[n], m[1].value)) # first one is always simple 

    for i = n+1:length(sa)
      sp = SeriesPair(sa[i].index, (sa[i].value * k + res[i-n].value * (1-k)))
      push!(res, sp)
    end
    res

  elseif method == "wilder"
    println("")
    print_with_color(:blue, "support for  wilder method is planned.")
    println("")

  else
    error("method is not supported.")
  end
end
