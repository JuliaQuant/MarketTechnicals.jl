function bollinger_bands(df::DataFrame, col::String, ma::Int, width::Float64)

  df = copy(df) #preserve the original DataFrame
  ma_col = strcat("mean_", ma)
  sd_col = strcat("std_", ma)
  df_ma  = moving!(df, col, mean, ma)
  df_new = df_ma[ma:end, :] 

  moving!(df_new, ma_col, std, 20) 
  df_new["up_bband"] = df_new[ma_col] + df_new[sd_col] * width
  df_new["dn_bband"] = df_new[ma_col] - df_new[sd_col] * width
  df_new
end

bollinger_bands(df::DataFrame) = bollinger_bands(df::DataFrame, "Close", 20, 2.0)

function true_range(df::DataFrame)

  df  = copy(df)

  Range = with(df, :(High - Low))
  Hilag = with(df, :(abs(High - $lag(Close))))
  Lolag = with(df, :(abs(Low - $lag(Close))))

  Hilag = replaceNA(Hilag, 0)
  Lolag = replaceNA(Lolag, 0)

  within!(df, quote
    TR  = float(max($Range, $Hilag, $Lolag))
    end)
  df

end

function atr(df::DataFrame, n::Int)

  df = copy(df)
  tr = true_range(df)
  TR = tr[:,"TR"]

  within!(df, quote
    ATR = $ema($TR, $n) 
    end)
  df
end

atr(df::DataFrame) = atr(df::DataFrame, 14)

function atr_wilder(df::DataFrame, n::Int)

  df = copy(df)
  tr = true_range(df)
  TR = tr[:,"TR"]

  within!(df, quote
    ATR = $ema_wilder($TR, $n) 
    end)
  df
end

atr_wilder(df::DataFrame) = atr_wilder(df::DataFrame, 14)

function keltner_bands(df::DataFrame, n::Int)

  df      =  copy(df)
  typical = with(df, :((High .+ Low .+ Close) ./3))
  rng     = with(df, :(High .- Low)) 
  rma     = with(df, :($moving($rng, mean, $n)))

  within!(df, quote
    kma   = $moving($typical, mean, $n)
    up    = kma + $rma/2 
    dn    = kma - $rma/2 
    end)
  df
end

keltner_bands(df::DataFrame) = keltner_bands(df::DataFrame, 10)

#    20 ema
#    10 period ATR +/-

#   10 sma typical price
#   10 sma range
#   upper 10 sma typical price + 1/2 10 sma range
#   lower 10 sma typical price - 1/2 10 sma range

function chaikin_volatility(x)
  #code here
end

