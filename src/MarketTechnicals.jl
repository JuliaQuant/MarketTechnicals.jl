using Series, Datetime

module MarketTechnicals

using Series, Datetime

export sma, ema,             # ema_wilder,
                       # bollinger_bands, # true_range, # atr, # atr_wilder, # keltner_bands, 
                       # obv, # vwap, 
       doji, 
                       # rsi, # rsi_wilder, # macd, # cci, 
       floorpivots, woodiespivots, 
       @markettechnicals

include("candlesticks.jl")
include("levels.jl")
include("movingaverages.jl")
# include("momo.jl")
# include("volatility.jl")
# include("volume.jl")
include("../test/testmacro.jl")

end 
