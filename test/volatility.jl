using MarketData

facts("Volatility") do

  context("bollinger_bands") do
    @fact bollingerbands(cl)["up"].values[1]   => roughly(116.49)      # TTR default uses sample=FALSE and value 116.350, otherwise 116.49  
    @fact bollingerbands(cl)["down"].values[1] => roughly(105.43)      # TTR default uses sample=FALSE and value 105.567, otherwise 105.43
    @fact bollingerbands(cl)["mean"].values[1] => roughly(110.96)      # TTR 110.959 
    @fact bollingerbands(cl).timestamp[1]      => date(1980,1,30) 
#    @fact bollingerbands(cl)["bwidth"].values[1] => roughly(120.820)      # TTR value 0.30241094 
    @fact bollingerbands(cl).timestamp[end]    => lastday
  end
  
   context("truerange") do
     @fact truerange(ohlc).values[end]    => roughly(1.85)       # TTR  1.85
     @fact truerange(ohlc).timestamp[end] => lastday
   end
   
  context("atr") do
     @fact atr(ohlc).values[1]    => roughly(2.350714)   # TTR value 2.350714 
     @fact atr(ohlc).values[end]  => roughly(2.085099)  # TTR value 2.085099
     @fact atr(ohlc).timestamp[1] => date(1980,1,23)
  end
   
  context("keltner_bands") do
#    @fact kma[1].value    => roughly(108.798)  # needs confirmation 
#    @fact kup[1].value    => roughly(110.011)  # needs confirmation 
#    @fact kdn[1].value    => roughly(107.586)  # needs confirmation  
#    @fact index(kma)[end] => lastday
  end
  
  context("chaikin_volatility") do
#   @fact chk => 17.0466 
  end
end 
