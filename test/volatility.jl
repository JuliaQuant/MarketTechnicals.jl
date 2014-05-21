using MarketData

facts("Volatility") do

  context("bollinger_bands") do
    @fact bollingerbands(cl)["up"].values[1]   => roughly(117.3251)      # TTR default uses sample=FALSE and value 117.3251
    @fact bollingerbands(cl)["down"].values[1] => roughly(89.39392)      # TTR default uses sample=FALSE and value 89.39392
    @fact bollingerbands(cl)["mean"].values[1] => roughly(103.3595)      # TTR 103.3595 
    @fact bollingerbands(cl).timestamp[1]      => date(2000,1,31) 
    @fact bollingerbands(cl).timestamp[end]    => date(2001,12,31)
  end
  
  # tests are commented out because TTR::ATR has different results
#    context("truerange") do
#      @fact truerange(ohlc).values[end]    => roughly(0.83)       # TTR 0.55 
#      @fact truerange(ohlc).timestamp[end] => date(2001,12,31)
#    end
#    
#   context("atr") do
#      @fact atr(ohlc).values[1]    => roughly(8.343571428571428)   # TTR value 4.362857
#      @fact atr(ohlc).values[end]  => roughly(0.9664561242651976)  # TTR value 0.4822861
#      @fact atr(ohlc).timestamp[1] => date(1980,1,24)
#   end
   
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
