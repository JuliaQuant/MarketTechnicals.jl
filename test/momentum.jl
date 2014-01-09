using MarketTechnicals, MarketData, FactCheck 

mcd, val = macd(cl)

facts("Momentum") do
  
  context("rsi") do
    @fact rsi(cl, 14)[end].value              => 73.80060302291837 
    @fact rsi(cl, 14, wilder=true)[end].value => 72.15153048735719  # from TTR 1971-12-31 72.151530
    @fact index(rsi(cl, 14))[end] => lastday
  end
  
  context("macd") do 
    @fact  mcd[end].value => 1.8694463607370295  # TTR value with percent=FALSE is 1.900959 
    @fact  val[end].value => 1.7189453474752991  # TTR value with percent=FALSE is 1.736186
    @fact index(mcd)[end] => lastday
  end
    
  context("cci") do 
#   @fact cci(cl)[end].value  => -146.17060449635804   # TTR::CCI value is -175.8644
#   @fact index(cci(cl))[end] => lastday
  end

end
