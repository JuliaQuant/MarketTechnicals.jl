__precompile__(true)

using TimeSeries, StatsBase

module MarketTechnicals

using TimeSeries, StatsBase

export sma, ema, kama,
       bollingerbands, truerange, atr, keltnerbands, chaikinvolatility, donchianchannels,
       obv, vwap, adl,
       doji,
       rsi, macd, cci, roc, adx, stochasticoscillator, chaikinoscillator, aroon,
       floorpivots, woodiespivots,
       typical

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("utilities.jl")
include("volatility.jl")
include("volume.jl")

# for user customization
# FIXME: using @__DIR__ while we upgrade to julia 0.6+
RC_FILE = joinpath(dirname(@__FILE__), ".rc.jl")
if !ispath(RC_FILE)
    touch(RC_FILE)
end

include(RC_FILE)

end
