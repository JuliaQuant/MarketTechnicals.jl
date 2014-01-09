module TestVolatility
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  op = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=2)
  hi = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=3)
  lo = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=4)
  cl = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=5)
  tp = SeriesArray(index(hi), ((value(hi) + value(lo) + value(cl)) ./ 3))

  # bollinger_bands
  bbma, bbup, bbdn  = bollingerbands(cl, 20, 2.0)
  
  @test_approx_eq  99.522             bbma[end].value   # R's TTR value 99.522
  @test_approx_eq  103.79282439964834 bbup[end].value   # R's TTR value 103.6847 # std must be calculated slightly differently
  @test_approx_eq  95.25117560035167  bbdn[end].value   # R's TTR value 95.35932 # std must be calculated slightly differently
  @test index(bbma)[end] == date(1971, 12, 31)
  
  # truerange
  trg  = truerange(hi,lo,cl)
   
  @test_approx_eq 0.31 trg[end].value # TTR  0.31 
  @test index(trg)[end] == date(1971, 12, 31)
   
  # atr
  atrsa  = atr(hi,lo,cl, 14)
  atw  = atr(hi,lo,cl, 14, wilder=true)
   
  @test_approx_eq 0.6507814197238606 atrsa[end].value # test needs confirmation
  @test_approx_eq 0.9248091375004336 atw[end].value   # test needs confirmation 
  @test index(atrsa)[end] == date(1971, 12, 31)
   
  # keltner_bands
  kma, kup, kdn  = keltnerbands(hi, lo, cl, 10)
   
  @test_approx_eq  98.10133333333333 kma[1].value  # needs confirmation 
  @test_approx_eq  98.91883333333332 kup[1].value  # needs confirmation 
  @test_approx_eq  97.28383333333333 kdn[1].value  # needs confirmation  
  @test index(kma)[end] == date(1971, 12, 31)
  
#   ## chaikin_volatility
#   
#   #chk  = chaikinvolatility(sa)
#   
#   #@test_approx_eq 17.0466 == chk
end 
