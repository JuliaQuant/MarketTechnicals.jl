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


function atr(df::DataFrame, n::Int)

  df = copy(df)
  df["Range"]  = df["High"] - df["Low"]
  df["Hilag"]  = abs(df["High"] - lag(df["Close"]))
  df["Lowlag"] = abs(df["Low"] - lag(df["Close"]))
  df["TR"]    = max(df["Range"], df["Hilag"], df["Lowlag"])
  df["ATR"]   = padNA(ema(df["TR"], n), n-1, 0)
  df

end

function keltner_bands(x)
  #code here
end

function chaikin_volatility(x)
  #code here
end

