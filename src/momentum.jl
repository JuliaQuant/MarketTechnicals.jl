function rsi{T}(ta::TimeArray{T,1}, n::Int; wilder=false)

  ret = [0; diff(ta.values)]
  ups = zeros(length(ta))
  dns = zeros(length(ta))

  for i=1:length(ta)
    if ret[i] >= 0
      ups[i] += ret[i]
    else
      dns[i] += ret[i]
    end
   end

  if  wilder 
    upsema = ema(ups, n, wilder=true)
    dnsema = abs(ema(dns, n, wilder=true))
    rs     = upsema ./ dnsema  

  else
    upsema  = ema(ups, n)
    dnsema  = abs(ema(dns, n))
    rs      = upsema ./ dnsema  
  end

  res  = 100 .- (100./(1 .+ rs))
  TimeArray(ta.timestamp[n:end], res, ["rsi"])
end

rsi{T}(ta::TimeArray{T,1}) = rsi(ta, 14)

function macd{T}(ta::TimeArray{T,1}, fast::Int, slow::Int, signal::Int)
    mcd = ema(ta, fast) .- ema(ta, slow)
    sig = ema(mcd, signal)
    merge(mcd, sig, colnames=["macd", "signal"])
end

macd{T}(ta::TimeArray{T,1}) = macd(ta, 12, 26, 9)
 
function cci{T,N}(ohlc::TimeArray{T,N}, n::Int; cciconst=0.015, h="High", l="Low", c="Close")
	price = (ohlc[h] + ohlc[l] + ohlc[c])/3
	psma = sma(price, n)
	avepdev = sma((price-psma), n)
	
	cci = (price - psma) / avepdev / cciconst
  	tstamps = cci.timestamp[1:end]
  	
	TimeArray(tstamps, cci.values, ["cci"])
end

cci{T,N}(ohlc::TimeArray{T,N}, n::Int) = cci(ohlc, 20)

function stochasticOsc{T,N}(ohlc::TimeArray{T,N}; nk=14, nd=3, h="High", l="Low", c="Close")
	cl = ohlc[c]
	lowest = NBarLowest(ohlc[l].values, nk)
	highest = NBarHighest(ohlc[h].values, nk)

    percentK = zeros(length(ohlc))
    
    for i in 1:length(ohlc)
        percentK[i] = 100 * ((cl[i].values - lowest[i]) / (highest[i] - lowest[i]))
    end
    
    percentD = sma(percentK, nd);
    
    TimeArray(ohlc.timestamp, hcat(percentK, percentD), ["%K", "%D"])
end

stochasticOsc{T,N}(ohlc::TimeArray{T,N}) = stochasticOsc(ohlc)

# function cci(df::DataFrame, n::Int, c::Float64)
# 
#   df = copy(df)
# 
#   typical = with(df, :(+(High, Low, Close) ./3))
#   sma_typ = moving(typical, mean, n)
#   mad_typ = moving(typical, mad, n)
#   ccival  = (typical - sma_typ) ./ (mad_typ * c)
# 
#   within!(df, quote
#     cci = $ccival
#     end)
#   df 
# end
# 
# #cci(df::DataFrame) = cci(sa, 20, 0.015)
