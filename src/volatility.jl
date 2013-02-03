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

  df_new = df[2:end, :] # remove nasty first row NA
  df_new["TR"]    = max(df_new["Range"], df_new["Hilag"], df_new["Lowlag"])
  df_new["ATR"]   = padNA(ema_unpadded(df_new["TR"], n), n-1, 0)
  df_new

end

atr(df::DataFrame) = atr(df::DataFrame, 20)

function keltner_bands(x)
  #code here
end

function chaikin_volatility(x)
  #code here
end

