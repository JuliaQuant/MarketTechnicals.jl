using Thyme, DataFrames, Calendar, UTF16

module Oil  

using Thyme, DataFrames, Calendar, UTF16

export ema,
       sma, 
       bollinger_bands, 
       @oil

include("movingaverages.jl")
include("volatility.jl")
include("testoil.jl")


end 
