# function bollingerbands{T,V}(sa::Array{SeriesPair{T,V},1}, ma::Int, width::Float64)

#   df_ma  = moving!(df, col, mean, ma) #delete
#   sama   = sma(sa, ma)
    upband = df_new[ma_col] + df_new[sd_col] * width
    dnband = df_new[ma_col] - df_new[sd_col] * width
#   df_new
end

# bollinger_bands(df::DataFrame) = bollinger_bands(df::DataFrame, "Close", 20, 2.0)

function truerange{T,V}(hi::Array{SeriesPair{T,V},1},
                        lo::Array{SeriesPair{T,V},1},
                        cl::Array{SeriesPair{T,V},1})

#   Range = with(df, :(High - Low))
#   Hilag = with(df, :(abs(High - $lag(Close))))
#   Lolag = with(df, :(abs(Low - $lag(Close))))
# 
#   Hilag = replaceNA(Hilag, 0)
#   Lolag = replaceNA(Lolag, 0)
# 
#   within!(df, quote
#     TR  = float(max($Range, $Hilag, $Lolag))
#     end)
#   df
# 
end

function atr{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int; method="simple")
  if method == "simple"
#     k   = 2/(n+1)
#     m   = sma(sa, n) 
#     res = SeriesPair{T,V}[]
#     push!(res, SeriesPair(index(sa)[n], m[1].value)) # first one is always simple 
# 
#     for i = n+1:length(sa)
#       sp = SeriesPair(sa[i].index, (sa[i].value * k + res[i-n].value * (1-k)))
#       push!(res, sp)
#     end
#     res

  elseif method == "wilder"
#     ATR = $ema($TR, $n, method="wilder") 
    println("")
    print_with_color(:blue, "support for  wilder method is planned.")
    println("")

  else
    error("method is not supported.")
  end
end

#   tr = true_range(df)
#   TR = tr[:,"TR"]
# 
#   within!(df, quote
#     ATR = $ema($TR, $n) 
#     end)
#   df
# end
end
 
# atr(df::DataFrame) = atr(df::DataFrame, 14)
 
function keltnerbands{T,V}(hi::Array{SeriesPair{T,V},1},
                           lo::Array{SeriesPair{T,V},1},
                           cl::Array{SeriesPair{T,V},1}, n::Int)

#   typical = with(df, :((High .+ Low .+ Close) ./3))
#   rng     = with(df, :(High .- Low)) 
#   rma     = with(df, :($moving($rng, mean, $n)))
# 
#   within!(df, quote
#     kma   = $moving($typical, mean, $n)
#     up    = kma + $rma/2 
#     dn    = kma - $rma/2 
#     end)
#   df
end
 
# keltner_bands(df::DataFrame) = keltner_bands(df::DataFrame, 10)

# function chaikinvolatility{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int)
#   #code here
# end
