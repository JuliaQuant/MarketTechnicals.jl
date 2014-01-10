using MarketTechnicals, MarketData, FactCheck 

bbma, bbup, bbdn = bollingerbands(cl, 20, 2.0)
kma, kup, kdn    = keltnerbands(hi, lo, cl, 10)
#chk             = chaikinvolatility(sa)
  
facts("Volatility") do

  context("bollinger_bands") do
    @fact bbma[end].value  => roughly(123.634)      # R's TTR value 99.522
    @fact bbup[end].value  => roughly(126.448)      # R's TTR value 103.6847 # std must be calculated slightly differently
    @fact bbdn[end].value  => roughly(120.820)      # R's TTR value 95.35932 # std must be calculated slightly differently
    @fact index(bbma)[end] => lastday
  end
  
  context("truerange") do
    @fact truerange(hi,lo,cl)[end].value  => roughly(1.850)       # TTR  0.31 
    @fact index(truerange(hi,lo,cl))[end] => lastday
  end
   
  context("atr") do
    @fact atr(hi,lo,cl,14)[end].value               => roughly(1.95523)   # test needs confirmation
    @fact atr(hi,lo,cl, 14, wilder=true)[end].value => roughly(2.08509)   # test needs confirmation 
    @fact index(atr(hi,lo,cl,14))[end]              => lastday
  end
   
  context("keltner_bands") do
    @fact kma[1].value    => roughly(108.798)  # needs confirmation 
    @fact kup[1].value    => roughly(110.011)  # needs confirmation 
    @fact kdn[1].value    => roughly(107.586)  # needs confirmation  
    @fact index(kma)[end] => lastday
  end
  
  context("chaikin_volatility") do
#   @fact chk => 17.0466 
  end

end 
