

function nacd(df::DataFrame, fast::Int, slow::Int, signal::Int)

  df  = copy(df)

   fast_ma = with(df, :($ema(Close, $fast)))
   slow_ma = with(df, :($ema(Close, $slow)))

  within!(df, quote
    macd   = $fast_ma .- $slow_ma
#    signal = $ema(removeNA(macd), 9)
    end)
  df
end

nacd(df::DataFrame) = nacd(df::DataFrame, 12, 26, 9)
