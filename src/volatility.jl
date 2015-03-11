function bollingerbands{T,N}(ta::TimeArray{T,N}, ma::Int, width::Float64)
    tama   = sma(ta, ma)
    upband = tama .+ moving(ta, std, ma) .* width .* sqrt((ma-1)/ma) # take out Bessel correction, per algorithm
    dnband = tama .- moving(ta, std, ma) .* width .* sqrt((ma-1)/ma)
    bands  =  merge(upband, dnband) 
    merge(bands, tama, col_names = ["up", "down", "mean"])
end

bollingerbands{T,N}(ta::TimeArray{T,N}) = bollingerbands(ta, 20, 2.0)

function truerange{T,N}(ohlc::TimeArray{T,N}; h="High", l="Low", c="Close")
    highs    = merge(ohlc[h], lag(ohlc[c]))
    lows     = merge(ohlc[l], lag(ohlc[c]))
    truehigh = TimeArray(highs.timestamp, maximum(highs.values, 2), ["hi"], highs.meta)
    truelow  = TimeArray(lows.timestamp,  minimum(lows.values, 2),  ["lo"], lows.meta)
    truehigh .- truelow
end

function atr{T,N}(ohlc::TimeArray{T,N}, n::Int; h="High", l="Low", c="Close")
    # atr was inveted by Wilder, so only his ema is currently supported
    res = ema(truerange(ohlc), n, wilder=true)
    TimeArray(res.timestamp, res.values, ["atr"], ohlc.meta)
end
  
atr{T,N}(ta::TimeArray{T,N}) = atr(ta, 14)

# function keltnerbands{T,N}(ohlc::TimeArray{T,N}, n::Int)
# 	typ = typical(ohlc)
# 	rng = ohlc["High"] .- ohlc["Low"]
# 	rma = sma(rng, n) 
# 
# 	kma     = sma(typ, n) 
# 	tstamps = kma.timestamp
# 	
# 	kma = TimeArray(tstamps, kma.values, ["kma"])
# 	kup = TimeArray(tstamps, (kma.+rma).values, ["kup"])
# 	kdn = TimeArray(tstamps, (kma.-rma).values, ["kdn"])
# 
# 	merge(kma, merge(kup, kdn))
# end
  
keltnerbands{T,N}(ohlc::TimeArray{T,N}) = keltnerbands(ohlc, 10)
 
# # function chaikinvolatility{T,N}(ta::TimeArray{T,N}, n::Int)
# #   #code here
# # end
