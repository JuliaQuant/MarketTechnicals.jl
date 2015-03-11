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

  TimeArray(ohlc.timestamp,  cumsum(vol), ["obv"], ohlc.meta)
end
 
function vwap{T,N}(ohlc::TimeArray{T,N}, n::Int; price="Close", v="Volume")
  
    p   = ohlc[price]
    q   = ohlc[v]
    ∑PQ = moving(p.*q, sum, n)
    ∑Q  = moving(q, sum, n)
    val = ∑PQ ./ ∑Q
 
    TimeArray(val.timestamp, val.values, ["vwap"], ohlc.meta)
end
 
vwap{T,N}(ohlc::TimeArray{T,N}) = vwap(ohlc, 10)
 
function advance_decline(x)
  #code here
end

function mcclellan_summation(x)
  #code here
end

function williams_ad(x)
  #code here
end
