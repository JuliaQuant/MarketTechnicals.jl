function rsi{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int; wilder=false)

  ret = [0; diff(value(sa))]
  ups = zeros(size(sa, 1))
  dns = zeros(size(sa, 1))

  for i=1:size(sa, 1)
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
  SeriesArray(index(sa)[n:end], res)
end

rsi{T,V}(sa::Array{SeriesPair{T,V},1}) = rsi(sa, 14)

function macd{T,V}(sa::Array{SeriesPair{T,V},1}, fast::Int, slow::Int, signal::Int)
 
  fastma = ema(value(sa), fast)[slow-fast+1:end] # match dimensions with shorter slow array
  slowma = ema(value(sa), slow)
  mcdval = (fastma - slowma)[signal:end]
  sigval = ema(mcdval, signal)
 
  idx = index(sa)[size(sa,1) - size(sigval,1) + 1:end]
  mcd = SeriesArray(idx, mcdval)
  sig = SeriesArray(idx, sigval)
 
  mcd, sig
end

macd{T,V}(sa::Array{SeriesPair{T,V},1}) = macd(sa, 12, 26, 9)
 
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
