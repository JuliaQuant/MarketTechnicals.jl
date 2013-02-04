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
  ndf = ncol(df)
  nex = ndf + 4  # spacer for TR column
  df  = copy(df)

  within!(df, quote
    Range = High - Low
    Hilag = abs(High - $lag(Close))
    Lolag = abs(Low - $lag(Close))
    end)

  df_new = df[2:end, :] # remove nasty first row NA

  within!(df_new, quote
    TR  = float(max(Range, Hilag, Lolag))
    end)

  df_out = df_new[:, [1:ndf, nex]]

end

function atr(df::DataFrame, n::Int)
  ndf = ncol(df)
  nex = ndf + 2  # spacer for ATR column
  df  = copy(df)
  tr  = true_range(df)

  within!(tr, quote
    ATR = $ema(TR, $n) 
    end)
  df_out = tr[:, [1:ndf, nex]]
end

atr(df::DataFrame) = atr(df::DataFrame, 14)

function keltner_bands(x)

#   10 sma typical price
#   10 sma range
#   upper 10 sma typical price + 1/2 10 sma range
#   lower 10 sma typical price - 1/2 10 sma range


  #code here
end

function chaikin_volatility(x)
  #code here
end

