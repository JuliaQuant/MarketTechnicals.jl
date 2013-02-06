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

  obvval = cumsum(dv)

  within!(df, quote
    obv = $obvval
    end)
  df

end

function vwap(df::DataFrame, n::Int)
  df = copy(df)

  typical = with(df, :((High + Low + Close)/3))
  VP      = with(df, :($typical .* Volume))
  sumVP   = moving(VP, sum, 10)
  sumV    = moving(df["Volume"], sum, 10)
  vwapval = sumVP ./ sumV

  within!(df, quote
    vwap = $vwapval
    end)
  df
end

vwap(df::DataFrame) = vwap(df::DataFrame, 10)

function advance_decline(x)
  #code here
end

function mcclellan_summation(x)
  #code here
end

function williams_ad(x)
  #code here
end
