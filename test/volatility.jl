using MarketData

facts("Volatility") do

  context("bollinger_bands") do
    @fact bollingerbands(cl)["up"].values[1]   => roughly(116.3501)      # TTR value 116.3501
    @fact bollingerbands(cl)["down"].values[1] => roughly(105.5679)      # TTR value 105.5679
    @fact bollingerbands(cl)["mean"].values[1] => roughly(110.96)      # TTR value 110.959
    @fact bollingerbands(cl).timestamp[1]      => date(1980,1,30) 
#    @fact bollingerbands(cl)["bwidth"].values[1] => roughly(120.820)      # TTR value 0.30241094 
    @fact bollingerbands(cl).timestamp[end]    => lastday
  end
  
   context("truerange") do
     @fact truerange(ohlc).values[end]    => roughly(1.85)       # TTR  1.85
     @fact truerange(ohlc).timestamp[end] => lastday
   end
   
  context("atr") do
#     @fact atr(hi,lo,cl,14)[end].value               => roughly(1.95523)   # test needs confirmation
#     @fact atr(hi,lo,cl, 14, wilder=true)[end].value => roughly(2.08509)   # test needs confirmation 
#     @fact index(atr(hi,lo,cl,14))[end]              => lastday
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
