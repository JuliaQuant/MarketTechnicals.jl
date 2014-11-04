if VERSION < v"0.4-"
    using Dates, StatsBase
else
    using Base.Dates, StatsBase
end

module MarketTechnicals

if VERSION < v"0.4-"
    using Dates, StatsBase
else
    using Base.Dates, StatsBase
end

export sma, ema,             
       bollingerbands, truerange, atr, #keltnerbands, 
       obv, vwap, 
       doji, 
       rsi, macd, #cci, 
       floorpivots, woodiespivots,
       abs, typical

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("utilities.jl")
include("volatility.jl")
include("volume.jl")

end 
