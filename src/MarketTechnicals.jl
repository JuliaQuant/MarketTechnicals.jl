using Series, Datetime

module MarketTechnicals

using Series, Datetime

export sma, ema,             
       bollingerbands, # truerange, # atr, # keltnerbands, 
                       # obv, # vwap, 
       doji, 
       rsi, macd, # cci, 
       floorpivots, woodiespivots, 
       @markettechnicals

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
include("momentum.jl")
include("volatility.jl")
# include("volume.jl")
include("../test/testmacro.jl")

end 
