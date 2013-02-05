function rsi(df::DataFrame, n::Int)

  df  = copy(df)
  ret = diff(df["Close"])
  ret = [0; ret]
  ups = zeros(nrow(df))
  dns = zeros(nrow(df))

  for i=1:nrow(df)
    if ret[i] >= 0
      ups[i] += ret[i]
    else
      dns[i] += ret[i]
    end
   end

  upsema = ema(DataArray(ups), n)
  dnsema = abs(ema(DataArray(dns), n))
  RS     = upsema ./ dnsema  

  within!(df, quote
    rsi = 100 .- (100./(1 .+ $RS))
    end)
  df 
end

rsi(df::DataFrame) = rsi(df::DataFrame, 14)

function macd(x)
  #code here
end

function cci(x)
  #code here
end

function williams_percent_r(x)
  #code here
end

