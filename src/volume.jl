function obv(df::DataFrame)
  df  = copy(df)
  dv  = zeros(nrow(df))
  ret = simple_return(df["Close"])
  
  for i=1:nrow(df)
    if ret[i] >= 0
      dv[i] += df[i, 6]
    else
      dv[i] -= df[i, 6]
    end
   end

  within!(df, quote
    obv = cumsum($dv)
    end)
  df

end

#function vwap(df::Union(DataFrame, SubDataFrame))
function vwap(df::DataFrame)
  df = copy(df)

  typical = with(df, :((High + Low + Close)/3))
  VP      = with(df, :($typical .* Volume))
  sumVP   = with(df, :(cumsum($VP)))
  sumV    = with(df, :(cumsum(Volume)))

  within!(df, quote
    vwap    = $sumVP ./ $sumV
    end)
  df
end

function advance_decline(x)
  #code here
end

function mcclellan_summation(x)
  #code here
end

function williams_ad(x)
  #code here
end
