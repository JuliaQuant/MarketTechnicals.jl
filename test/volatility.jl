using MarketData

facts("Volatility") do

  context("bollinger_bands") do
    @fact bollingerbands(cl)["up"].values[1]     => roughly(123.634)      # TTR value 126.3771 
    @fact bollingerbands(cl)["down"].values[1]   => roughly(126.448)      # TTR value 120.8909 
    @fact bollingerbands(cl)["mvg"].values[1]    => roughly(120.820)      # TTR value 123.6340
#    @fact bollingerbands(cl)["bwidth"].values[1] => roughly(120.820)      # TTR value 0.30241094 
    @fact bollingerbands(cl).timestmp[end]       => lastday
  end
  
   context("truerange") do
#     @fact truerange(hi,lo,cl)[end].value  => roughly(1.850)       # TTR  0.31 
#     @fact index(truerange(hi,lo,cl))[end] => lastday
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
