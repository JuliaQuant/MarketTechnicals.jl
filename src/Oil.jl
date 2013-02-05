using Thyme, DataFrames, Calendar, UTF16

module Oil  

using Thyme, DataFrames, Calendar, UTF16

export ema,
       ema_unpadded,
       ema_wilder,
       sma, 
       bollinger_bands, 
       true_range, 
       atr, 
       keltner_bands, 
       obv, 
       vwap, 
       doji, 
       rsi, 
       @oil

include("candlesticks.jl")
include("movingaverages.jl")
include("momo.jl")
include("volatility.jl")
include("volume.jl")
include("testoil.jl")


end 
