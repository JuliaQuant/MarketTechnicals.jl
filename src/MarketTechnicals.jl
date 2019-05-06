__precompile__()

module MarketTechnicals

using Reexport
using StatsBase
using Statistics

@reexport using TimeSeries

export sma, ema, kama, env,
       bollingerbands, truerange, atr, keltnerbands, chaikinvolatility, donchianchannels,
       obv, vwap, adl, chaikinmoneyflow, forceindex, easeofmovement, volumepricetrend, 
       doji,
       rsi, macd, cci, roc, adx, stochasticoscillator, chaikinoscillator, aroon, vortex,
       trix, massindex, dpo, kst, ichimoku, moneyflowindex, tsi, ultimateoscillator, williamsr,
       awesomeoscillator,
       floorpivots, woodiespivots,
       typical

_nanmean(x) = mean(filter(!isnan, x))
nanmean(x; dims = 1) = ndims(x) > 1 ? mapslices(_nanmean, x, dims = dims) : _nanmean(x)

_nansum(x) = sum(filter(!isnan,x))
nansum(x; dims = 1) = ndims(x) > 1 ? mapslices(_nansum, x, dims = dims) : _nansum(x)

_nanstd(x) = std(filter(!isnan,x))
nanstd(x; dims = 1) = ndims(x) > 1 ? mapslices(_nanstd, x, dims = dims) : _nanstd(x)

function nancumsum(x)
	x[isnan.(x)] .= 0
	cumsum(x)
end

function nanargmax(x) 
	x[isnan.(x)] .= -Inf
	argmax(x)
end

function nanargmin(x) 
	x[isnan.(x)] .= Inf
	argmin(x)
end

function nanmax(x) 
	x[isnan.(x)] .= -Inf
	maximum(x)
end

function nanmin(x) 
	x[isnan.(x)] .= Inf
	minimum(x)
end

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
