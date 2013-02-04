using Thyme, DataFrames, Calendar, UTF16

module Oil  

using Thyme, DataFrames, Calendar, UTF16

export ema,
       ema_unpadded,
       sma, 
       bollinger_bands, 
       true_range, 
       atr, 
       keltner_bands, 
       @oil

include("movingaverages.jl")
include("volatility.jl")
include("testoil.jl")


end 
