function obv{T,V}(sa::Array{SeriesPair{T,V},1})

  vol = zeros(size(sa, 1))
  ret = percentchange(sa)
  
  for i=1:size(sa, 1)
    if ret[i].value >= 0
      vol[i] += sa[i].value
    else
      vol[i] -= sa[i].value
    end
  end

  SeriesArray(index(sa),  cumsum(vol))
end

function vwap{T,V}(hi::Array{SeriesPair{T,V},1},
                   lo::Array{SeriesPair{T,V},1},
                   cl::Array{SeriesPair{T,V},1}, 
                   vm::Array{SeriesPair{T,V},1}, n::Int)
 
  typ     = (hi + lo + cl) ./ 3
  vp      = typ  .*  vm
  sumVP   = moving(vp, sum, 10)
  sumV    = moving(vm, sum, 10)
  vwapval = sumVP ./ sumV

end

vwap{T,V}(hi::Array{SeriesPair{T,V},1},
          lo::Array{SeriesPair{T,V},1},
          cl::Array{SeriesPair{T,V},1}, 
          vm::Array{SeriesPair{T,V},1}) =  vwap(hi, lo, cl, vm,  10)

function advance_decline(x)
  #code here
end

function mcclellan_summation(x)
  #code here
end

function williams_ad(x)
  #code here
end
