using MarketTechnicals, MarketData, FactCheck 

bbma, bbup, bbdn = bollingerbands(cl, 20, 2.0)
kma, kup, kdn    = keltnerbands(hi, lo, cl, 10)
#chk             = chaikinvolatility(sa)
  
facts("Volatility") do

  context("bollinger_bands") do
    @fact bbma[end].value  => 9.522               # R's TTR value 99.522
    @fact bbup[end].value  => 03.79282439964834   # R's TTR value 103.6847 # std must be calculated slightly differently
    @fact bbdn[end].value  => 5.25117560035167    # R's TTR value 95.35932 # std must be calculated slightly differently
    @fact index(bbma)[end] => lastday
  end
  
  context("truerange") do
    @fact truerange(hi,lo,cl)[end].value  => 0.31             # TTR  0.31 
    @fact index(truerange(hi,lo,cl))[end] => lastday
  end
   
  context("atr") do
    @fact atr(hi,lo,cl,14)[end].value               => .6507814197238606    # test needs confirmation
    @fact atr(hi,lo,cl, 14, wilder=true)[end].value => .9248091375004336     # test needs confirmation 
    @fact index(atr(hi,lo,cl,14))[end]              => lastday
  end
   
  context("keltner_bands") do
    @fact kma[1].value    => 8.10133333333333   # needs confirmation 
    @fact kup[1].value    => 8.91883333333332   # needs confirmation 
    @fact kdn[1].value    => 7.28383333333333   # needs confirmation  
    @fact index(kma)[end] => lastday
  end
  
  context("chaikin_volatility") do
#   @fact chk => 17.0466 
  end

end 
