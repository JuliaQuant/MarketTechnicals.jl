function bollinger_bands(df::DataFrame, col::String, ma::Int, width::Float64)

  df = copy(df) #preserve the original DataFrame
  ma_col = strcat("mean_", ma)
  df_ma  = moving!(df, col, mean, ma)
  df_new = df_ma[ma:end, :] 

  moving!(df_new, ma_col, std, 20) 
  df_new["up_bband"] = df_new[ma_col] + df_new["std_20"] * width
  df_new["dn_bband"] = df_new[ma_col] - df_new["std_20"] * width
  df_new
end

bollinger_bands(df::DataFrame) = bollinger_bands(df::DataFrame, "Close", 20, 2.0)


function atr(x)
  #code here
end

function keltner_bands(x)
  #code here
end

function chaikin_volatility(x)
  #code here
end

