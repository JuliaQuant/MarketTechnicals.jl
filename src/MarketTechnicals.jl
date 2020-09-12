module MarketTechnicals

using Reexport
using Statistics
using StatsBase

@reexport using TimeSeries

# movingaverages.jl
export sma, ema, kama, env
# levels.jl
export floorpivots, woodiespivots
# momentum.jl
export rsi, macd, cci, roc, adx, stochasticoscillator, chaikinoscillator, aroon, vortex,
       trix, massindex, dpo, kst, ichimoku, moneyflowindex, tsi, ultimateoscillator, williamsr,
       awesomeoscillator
# candlesticks.jl
export doji
# utilities.jl
export typical
# volatility.jl
export bollingerbands, truerange, atr, keltnerbands, chaikinvolatility, donchianchannels
# volume.jl
export obv, vwap, adl, chaikinmoneyflow, forceindex, easeofmovement, volumepricetrend

include("utilities.jl")
include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("volatility.jl")
include("volume.jl")

# for user customization
RC_FILE = joinpath(@__DIR__, ".rc.jl")
if !ispath(RC_FILE)
  touch(RC_FILE)
end

include(RC_FILE)

end
