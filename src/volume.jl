function obv{T,N}(ohlc::TimeArray{T,N}; price="Close", v="Volume")

  ret    = percentchange(ohlc[price])
  vol    = zeros(length(ohlc))
  vol[1] = ohlc[v].values[1]
  
  for i=2:length(ohlc) 
    if ret.values[i-1] >= 0
      vol[i] += ohlc[v].values[i]
    else
      vol[i] -= ohlc[v].values[i]
    end
  end

  TimeArray(ohlc.timestamp,  cumsum(vol), ["obv"])
end
# 
# function vwap{T,N}(ohlc::TimeArray{T,N}, n::Int; h="High", l="Low", c="Close", v="Volume")
#  
#   typ     = (hi + lo + cl) ./ 3
#   vp      = typ  .*  vm
#   sumVP   = moving(vp, sum, 10)
#   sumV    = moving(vm, sum, 10)
#   vwapval = sumVP ./ sumV
# 
# end
# 
# vwap{T,V}(hi::Array{SeriesPair{T,V},1},
#           lo::Array{SeriesPair{T,V},1},
#           cl::Array{SeriesPair{T,V},1}, 
#           vm::Array{SeriesPair{T,V},1}) =  vwap(hi, lo, cl, vm,  10)
# 
function advance_decline(x)
  #code here
end

function mcclellan_summation(x)
  #code here
end

function williams_ad(x)
  #code here
end
