function obv(df::DataFrame)
  df = copy(df)
  simple_return!(df, "Close")

  within!(df, quote
    sgn = integer(sign(Close_RET))
#    obv = cumsum(Volume * integer(sign(Close_RET)))
    end)
  df
end

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
