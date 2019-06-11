module MarketTechnicals

# stdlib
using Statistics
using Markdown
# 3rd-party
using Reexport
using StatsBase

@reexport using TimeSeries

# movingaverages.jl
export sma, ema, kama, env
# volatility.jl
export bollingerbands, truerange, atr, keltnerbands, chaikinvolatility, donchianchannels
# volume.jl
export obv, vwap, adl
# candlesticks.jl
export doji
#  momentum.jl
export rsi, macd, cci, roc, adx, stochasticoscillator, chaikinoscillator, aroon
# levels.jl
export floorpivots, woodiespivots
# utilities.jl
export typical

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("utilities.jl")
include("volatility.jl")
include("volume.jl")

# for user customization
RC_FILE = joinpath(@__DIR__, ".rc.jl")
if !ispath(RC_FILE)
  touch(RC_FILE)
end

include(RC_FILE)

end
