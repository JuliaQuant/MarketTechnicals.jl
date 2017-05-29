__precompile__(true)

using TimeSeries, StatsBase

module MarketTechnicals

using TimeSeries, StatsBase

export sma, ema, kama,
       bollingerbands, truerange, atr, keltnerbands,
       obv, vwap,
       doji,
       rsi, macd, cci, roc,
       floorpivots, woodiespivots,
       typical

include("utilities.jl")  # we need macro in compiling stage

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("volatility.jl")
include("volume.jl")

end
