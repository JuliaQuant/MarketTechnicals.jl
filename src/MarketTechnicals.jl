module MarketTechnicals

using Reexport
using Statistics
using StatsBase

@reexport using TimeSeries

# movingaverages.jl
export sma, ema, kama, env,
       bollingerbands, truerange, atr, keltnerbands, chaikinvolatility, donchianchannels,
       obv, vwap, adl, chaikinmoneyflow, forceindex, easeofmovement, volumepricetrend,
       doji,
       typical
# levels.jl
export floorpivots, woodiespivots
# momentum.jl
export rsi, macd, cci, roc, adx, stochasticoscillator, chaikinoscillator, aroon, vortex,
       trix, massindex, dpo, kst, ichimoku, moneyflowindex, tsi, ultimateoscillator, williamsr,
       awesomeoscillator

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
