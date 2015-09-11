function obv{T,N}(ohlcv::TimeArray{T,N}; price="Close", v="Volume")

    ret    = percentchange(ohlcv[price])
    vol    = zeros(length(ohlcv))
    vol[1] = ohlcv[v].values[1]
    
    for i=2:length(ohlcv) 
      if ret.values[i-1] >= 0
        vol[i] += ohlcv[v].values[i]
      else
        vol[i] -= ohlcv[v].values[i]
      end
    end

    TimeArray(ohlcv.timestamp, cumsum(vol), ["obv"], ohlcv.meta)
end
 
function vwap{T,N}(ohlcv::TimeArray{T,N}, n::Int; price="Close", v="Volume")
  
    p   = ohlcv[price]
    q   = ohlcv[v]
    ∑PQ = moving(p.*q, sum, n)
    ∑Q  = moving(q, sum, n)
    val = ∑PQ ./ ∑Q
 
    TimeArray(val.timestamp, val.values, ["vwap"], ohlcv.meta)
end
 
vwap{T,N}(ohlcv::TimeArray{T,N}) = vwap(ohlcv, 10)
 
function advance_decline(x)
    #code here
end

function mcclellan_summation(x)
    #code here
end

function williams_ad(x)
    #code here
end
