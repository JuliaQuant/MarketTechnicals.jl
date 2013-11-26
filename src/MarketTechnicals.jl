using TimeSeries, DataFrames, DataArrays, Datetime

module MarketTechnicals

using TimeSeries, DataFrames, DataArrays, Datetime

export ema,
       ema_unpadded,
       ema_wilder,
       sma, 
       bollinger_bands, 
       true_range, 
       atr, 
       atr_wilder, 
       keltner_bands, 
       obv, 
       vwap, 
       doji, 
       rsi, 
       rsi_wilder, 
       macd, 
       cci, 
       floor_pivots,
       @markettechnicals

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momo.jl")
include("volatility.jl")
include("volume.jl")
include("testmarkettechnicals.jl")


end 
