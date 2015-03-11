# an idea: create one method named pivots with kwargs

function floorpivots{T,N}(ohlc::TimeArray{T,N})
  
    p  = lag(typical(ohlc))
    s1 = 2.*p .- lag(ohlc["High"])
    r1 = 2.*p .- lag(ohlc["Low"])
    s2 = p .- (r1 .- s1)
    r2 = (p .- s1) .+ r1
    s3 = p .- (r2 .- s1)
    r3 = (p .- s1) .+ r2
    
    TimeArray(s1.timestamp, [s3.values s2.values s1.values p.values r1.values r2.values r3.values],
              ["s3", "s2", "s1", "pivot", "r1", "r2", "r3"], ohlc.meta)
  
end

function woodiespivots{T,N}(ohlc::TimeArray{T,N})
 
    rng = lag(ohlc["High"]) .- lag(ohlc["Low"])
 
    p  = (lag(ohlc["High"]) .+ lag(ohlc["Low"]) .+ 2.*ohlc["Open"]) ./ 4
    s1 = 2.*p .- lag(ohlc["High"])
    r1 = 2.*p .- lag(ohlc["Low"])
    s2 = p .- rng
    r2 = p .+ rng
    s3 = s1 .- rng
    r3 = r1 .+ rng
    # s4 = s3 - range # can't get an answer that matches online calculators
    # r4 = r3 + range
 
    TimeArray(s1.timestamp, [s3.values s2.values s1.values p.values r1.values r2.values r3.values],
              ["s3", "s2", "s1", "pivot", "r1", "r2", "r3"], ohlc.meta)
end
# 
# function camarillapivots{T,V}(hi::Array{SeriesPair{T,V},1},
#                               lo::Array{SeriesPair{T,V},1},
#                               cl::Array{SeriesPair{T,V},1})
#   #code here
#   ##  R4 = (H - L) * 1.1/2 + C 
#   ##  R3 = (H - L) * 1.1/4 + C
#   ##  R2 = (H - L) * 1.1/6 + C
#   ##  R1 = (H - L) * 1.1/12 + C
#   ##  S1 = C - (H - L) * 1.1/12
#   ##  S2 = C - (H - L) * 1.1/6
#   ##  S3 = C - (H - L) * 1.1/4
#   ##  S4 = C - (H - L) * 1.1/2
# end
# 
# function demarkpivots{T,V}(op::Array{SeriesPair{T,V},1},
#                            hi::Array{SeriesPair{T,V},1},
#                            lo::Array{SeriesPair{T,V},1},
#                            cl::Array{SeriesPair{T,V},1})
#   #code here
#   ## If Close < Open then X = (H + (L * 2) + C) 
#   ## If Close > Open then X = ((H * 2) + L + C) 
#   ## If Close = Open then X = (H + L + (C * 2)) 
#   ## 
#   ## R1 = X / 2 - L
#   ## PP = X / 4 
#   ## S1 = X / 2 - H
# end

function market_profile(x)
  #code here
end

