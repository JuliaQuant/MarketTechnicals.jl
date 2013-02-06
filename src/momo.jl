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

  upsema  = ema(DataArray(ups), n)
  dnsema  = abs(ema(DataArray(dns), n))
  RS      = upsema ./ dnsema  

  upsemaw = ema_wilder(DataArray(ups), n)
  dnsemaw = abs(ema_wilder(DataArray(dns), n))
  RSw     = upsemaw ./ dnsemaw  

  within!(df, quote
    rsi  = 100 .- (100./(1 .+ $RS))
    rsiw = 100 .- (100./(1 .+ $RSw))
    end)
  df 
end

rsi(df::DataFrame) = rsi(df::DataFrame, 14)

function macd(df::DataFrame, fast::Int, slow::Int, signal::Int)

  df  = copy(df)

   fast_ma = with(df, :($ema(Close, $fast)))
   slow_ma = with(df, :($ema(Close, $slow)))

  within!(df, quote
    macd   = $fast_ma .- $slow_ma
#    signal = $ema(removeNA(macd), 9)
    end)
  df
end

macd(df::DataFrame) = macd(df::DataFrame, 12, 26, 9)

function cci(df::DataFrame, n::Int)

  df = copy(df)

  typical = with(df, :((High .+ Low .+ Close) ./3))
  sma_typ = moving(typical, mean, n)
  mad_typ = moving(typical, mad, n)

  within!(df, quote
    cci = (1/0.015) .* ($typical .- $sma_typ) ./ $mad_typ
    end)
  df 
end

cci(df::DataFrame) = cci(df::DataFrame, 20)

function williams_percent_r(x)
  #code here
end

