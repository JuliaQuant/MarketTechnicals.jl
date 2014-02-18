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
    mcd = ema(ta, fast) - ema(ta, slow)
    sig = ema(mcdl, signal)
    merge(mcd, sig, ["macd", "signal"])
end

macd{T}(ta::TimeArray{T,1}) = macd(ta, 12, 26, 9)
 
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
