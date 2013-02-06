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

  within!(df, quote
    rsi  = 100 .- (100./(1 .+ $RS))
    end)
  df 
end

rsi(df::DataFrame) = rsi(df::DataFrame, 14)

function rsi_wilder(df::DataFrame, n::Int)

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

  upsemaw = ema_wilder(DataArray(ups), n)
  dnsemaw = abs(ema_wilder(DataArray(dns), n))
  RSw     = upsemaw ./ dnsemaw  

  within!(df, quote
    rsiw = 100 .- (100./(1 .+ $RSw))
    end)
  df 
end

rsi_wilder(df::DataFrame) = rsi_wilder(df::DataFrame, 14)

function macd(df::DataFrame, fast::Int, slow::Int, signal::Int)

  df  = copy(df)

  fast_ma = with(df, :($ema(Close, $fast)))
  slow_ma = with(df, :($ema(Close, $slow)))
  macdval = fast_ma - slow_ma
  tempema = ema(macdval[slow:end], signal)
  signal  = padNA(tempema, slow-1, 0)

  within!(df, quote
    macd   = $macdval
    signal = $signal
    end)

  df
end

macd(df::DataFrame) = macd(df::DataFrame, 12, 26, 9)

function cci(df::DataFrame, n::Int, c::Float64)

  df = copy(df)

  typical = with(df, :(+(High, Low, Close) ./3))
  sma_typ = moving(typical, mean, n)
  mad_typ = moving(typical, mad, n)
  ccival  = (typical - sma_typ) ./ (mad_typ * c)

  within!(df, quote
    cci = $ccival
    end)
  df 
end

cci(df::DataFrame) = cci(df::DataFrame, 20, 0.015)
cci(df::DataFrame, n::Int) = cci(df::DataFrame, n::Int, 0.015)

function williams_percent_r(x)
  #code here
end

