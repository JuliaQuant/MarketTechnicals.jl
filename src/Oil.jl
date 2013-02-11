using TimeSeries, DataFrames, Calendar, UTF16

module TechnicalAnalysis

using TimeSeries, DataFrames, Calendar, UTF16

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
       @oil

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momo.jl")
include("volatility.jl")
include("volume.jl")
include("testtechnicalanalysis.jl")


end 
