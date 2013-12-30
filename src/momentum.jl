function rsi{T,V}(sa::Array{SeriesPair{T,V},1}; method="simple")

  ret = diff(value(sa))
  ret = [0; ret]
  ups = zeros(size(sa, 1))
  dns = zeros(size(sa, 1))

  for i=1:size(sa, 1)
    if ret[i] >= 0
      ups[i] += ret[i]
    else
      dns[i] += ret[i]
    end
   end

  if method == "simple"

    upsema  = ema(ups, n)
    dnsema  = abs(ema(dns, n))
    RS      = upsema ./ dnsema  


  elseif method == "wilder"
  
#    upsema = ema(ups, n, method="wilder")
#    dnsema = abs(ema(dns, n, method="wilder"))
#    RS     = upsema ./ dnsema  
    println("")
    print_with_color(:blue, "support for  wilder method is planned.")
    println("")

  else
    error("method is not supported.")
  end

    res  = 100 .- (100./(1 .+ RS))
end


#rsi_wilder(df::DataFrame) = rsi_wilder(df::DataFrame, "Close", 14)

# function macd(df::DataFrame, col::String, fast::Int, slow::Int, signal::Int)
# 
#   df  = copy(df)
# 
#   fast_ma = with(df, :($ema($df[$col], $fast)))
#   slow_ma = with(df, :($ema($df[$col], $slow)))
#   macdval = fast_ma - slow_ma
#   tempema = ema(macdval[slow:end], signal)
#   signal  = pad(tempema, slow-1, 0, NA)
# 
#   within!(df, quote
#     macd   = $macdval
#     signal = $signal
#     end)
# 
#   df
# end
# 
# #macd(df::DataFrame, col::String) = macd(df::DataFrame, col::String, 12, 26, 9)
# 
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
# #cci(df::DataFrame) = cci(df::DataFrame, 20, 0.015)
# 
# function williamspercentr(x)
#   #code here
# end
