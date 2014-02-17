function rsi{T,N}(ta::TimeArray{T,N}, n::Int; wilder=false)

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

rsi{T,N}(ta::TimeArray{T,N}) = rsi(ta, 14)

function macd{T,N}(ta::TimeArray{T,N}, fast::Int, slow::Int, signal::Int)
 
  fastma = ema(ta.values, fast)[slow-fast+1:end] # match dimensions with shorter slow array
  slowma = ema(ta.values, slow)
  mcdval = (fastma - slowma)[signal:end]
  sigval = ema(mcdval, signal)
  tstamp = ta.timestamp[length(ta) - size(sigval,1) + 1:end]
 
  TimeArray(tstamp, [sigval mcdval[signal:end]], ["sig", "macd"])
 
end

macd{T,N}(ta::TimeArray{T,N}) = macd(ta, 12, 26, 9)
 
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
