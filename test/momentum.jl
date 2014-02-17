using MarketTechnicals, MarketData, FactCheck 


facts("Momentum") do
  
  context("rsi") do
    @fact rsi(cl, 14).values[end]              => roughly(45.452) # TTR value is 45.45173 
    @fact rsi(cl, 14, wilder=true).values[end] => roughly(47.050) # TTR value is 47.05027    
    @fact rsi(cl, 14).timestamp[end]           => lastday
  end
  
  context("macd") do 
    @fact macd(cl).values[end, 1] => roughly(-0.27215228) # TTR value with percent=FALSE is -0.272152282
    @fact macd(cl).values[end, 2] => roughly(-0.02004125) # TTR value with percent=FALSE is -0.0200412507
    @fact macd(cl).timestamp[end] => lastday
  end
    
  context("cci") do 
#   @fact cci(cl)[end].value  => -146.17060449635804   # TTR::CCI value is -175.8644
#   @fact index(cci(cl))[end] => lastday
  end

end
