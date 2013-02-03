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

  within!(df, quote
    Range = High - Low
    Hilag = abs(High - $lag(Close))
    Lolag = abs(Low - $lag(Close))
    end)

  df_new = df[2:end, :] # remove nasty first row NA

  within!(df_new, quote
    TR  = float(max(Range, Hilag, Lolag))
    ATR = $ema(TR, $n) 
    end)
  df_new

end

atr(df::DataFrame) = atr(df::DataFrame, 20)

function keltner_bands(x)
  #code here
end

function chaikin_volatility(x)
  #code here
end

