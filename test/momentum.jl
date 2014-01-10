using MarketTechnicals, MarketData, FactCheck 

mcd, val = macd(cl)

facts("Momentum") do
  
  context("rsi") do
    @fact rsi(cl, 14)[end].value              => roughly(45.452)
    @fact rsi(cl, 14, wilder=true)[end].value => roughly(47.050)         # from TTR 1971-12-31 72.151530
    @fact index(rsi(cl, 14))[end] => lastday
  end
  
  context("macd") do 
    @fact  mcd[end].value => 0.30288417471292917   # TTR value with percent=FALSE is 1.900959 
    @fact  val[end].value => -0.02004125066740741  # TTR value with percent=FALSE is 1.736186
    @fact index(mcd)[end] => lastday
  end
    
  context("cci") do 
#   @fact cci(cl)[end].value  => -146.17060449635804   # TTR::CCI value is -175.8644
#   @fact index(cci(cl))[end] => lastday
  end

end
