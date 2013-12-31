function bollingerbands{T,V}(sa::Array{SeriesPair{T,V},1}, ma::Int, width::Float64)

  sama   = sma(sa, ma)
  sastd  = removenan(moving(sa, std, ma))
  upband = value(sama) + value(sastd) * width
  dnband = value(sama) - value(sastd) * width
  sama, SeriesArray(index(sama), upband) , SeriesArray(index(sama), dnband) 
end

bollingerbands{T,V}(sa::Array{SeriesPair{T,V},1}) = bollingerbands(sa, 20, 2.0)

function truerange{T,V}(hi::Array{SeriesPair{T,V},1},
                        lo::Array{SeriesPair{T,V},1},
                        cl::Array{SeriesPair{T,V},1})

  rng   = value(hi) - value(lo) 
  hilag = abs(value(hi) - value(lag(cl)))
  lolag = abs(value(lo) - value(lag(cl)))
  
  trv = [rng[1]] # because the other two have NaN values in the first row
  for i in 2:size(rng,1)
    push!(trv, maximum([rng[i], hilag[i], lolag[i]]))
  end

  SeriesArray(index(hi), trv)
end

function atr{T,V}(hi::Array{SeriesPair{T,V},1},
                  lo::Array{SeriesPair{T,V},1},
                  cl::Array{SeriesPair{T,V},1} , n::Int; wilder=false)

  tr = truerange(hi,lo,cl)

  if  wilder
    res = ema(tr, n, wilder=true)
  else
    res = ema(tr, n)
  end
  res 
end
 
#atr{T,V}(hi::Array{SeriesPair{T,V},1}, lo::Array{SeriesPair{T,V},1}, cl::Array{SeriesPair{T,V},1}) = atr(hi,lo,cl,14, wilder=false)

 
function keltnerbands{T,V}(hi::Array{SeriesPair{T,V},1},
                           lo::Array{SeriesPair{T,V},1},
                           cl::Array{SeriesPair{T,V},1}, n::Int)

  idx = index(hi)[n:end]
  typ = (value(hi) + value(lo) + value(cl)) / 3
  rng = value(hi) - value(lo)
  rma = sma(rng, n) 
 
  kma = sma(typ, n) 
  kup = kma + rma/2 
  kdn = kma - rma/2 
  
  SeriesArray(idx, kma), SeriesArray(idx, kup), SeriesArray(idx, kdn)
end
 
# keltner_bands(df::DataFrame) = keltner_bands(df::DataFrame, 10)

# function chaikinvolatility{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)
#   #code here
# end
