__precompile__(true)

using TimeSeries, StatsBase

module MarketTechnicals

using TimeSeries, StatsBase

export sma, ema, kama,
       bollingerbands, truerange, atr, keltnerbands, chaikinvolatility, donchian_channels,
       obv, vwap, adl,
       doji,
       rsi, macd, cci, roc, adx, stoch_osc, chaikinoscillator, aroon,
       floorpivots, woodiespivots,
       typical

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("utilities.jl")
include("volatility.jl")
include("volume.jl")

end
