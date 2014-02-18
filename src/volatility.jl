function bollingerbands{T,N}(ta::TimeArray{T,N}, ma::Int, width::Float64)
    tama   = sma(ta, ma)
    upband = tama + moving(ta, std, ma) * width
    dnband = tama - moving(ta, std, ma) * width
    bands  =  merge(upband, dnband) 
    merge(bands, tama, colnames=["up", "down", "mean"])
end

bollingerbands{T,N}(ta::TimeArray{T,N}) = bollingerbands(ta, 20, 2.0)

# function truerange{T,N}(hi::Array{SeriesPair{T,N},1},
#                         lo::Array{SeriesPair{T,N},1},
#                         cl::Array{SeriesPair{T,N},1})
# 
#   rng   = value(hi) - value(lo) 
#   hilag = abs(value(hi) - value(lag(cl)))
#   lolag = abs(value(lo) - value(lag(cl)))
#   
#   trv = [rng[1]] # because the other two have NaN values in the first row
#   for i in 2:size(rng,1)
#     push!(trv, maximum([rng[i], hilag[i], lolag[i]]))
#   end
# 
#   SeriesArray(index(hi), trv)
# end
# 
# function atr{T,N}(hi::Array{SeriesPair{T,N},1},
#                   lo::Array{SeriesPair{T,N},1},
#                   cl::Array{SeriesPair{T,N},1} , n::Int; wilder=false)
# 
#   tr = truerange(hi,lo,cl)
# 
#   if  wilder
#     res = ema(tr, n, wilder=true)
#   else
#     res = ema(tr, n)
#   end
#   res 
# end
#  
# #atr{T,N}(hi::Array{SeriesPair{T,N},1}, lo::Array{SeriesPair{T,N},1}, cl::Array{SeriesPair{T,N},1}) = atr(hi,lo,cl,14, wilder=false)
# 
#  
# function keltnerbands{T,N}(hi::Array{SeriesPair{T,N},1},
#                            lo::Array{SeriesPair{T,N},1},
#                            cl::Array{SeriesPair{T,N},1}, n::Int)
# 
#   idx = index(hi)[n:end]
#   typ = (value(hi) + value(lo) + value(cl)) / 3
#   rng = value(hi) - value(lo)
#   rma = sma(rng, n) 
#  
#   kma = sma(typ, n) 
#   kup = kma + rma/2 
#   kdn = kma - rma/2 
#   
#   SeriesArray(idx, kma), SeriesArray(idx, kup), SeriesArray(idx, kdn)
# end
#  
# # keltner_bands(df::DataFrame) = keltner_bands(df::DataFrame, 10)
# 
# # function chaikinvolatility{T,N}(ta::TimeArray{T,N}, n::Int)
# #   #code here
# # end
