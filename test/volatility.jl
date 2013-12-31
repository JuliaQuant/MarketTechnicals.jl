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
  @test_approx_eq  103.79282439964834 bbup[end].value   # R's TTR value 103.6847 
  @test_approx_eq  95.25117560035167  bbdn[end].value   # R's TTR value 95.35932 
  @test index(bbma)[end] == date(1971, 12, 31)
  
  # truerange
  trg  = truerange(hi, lo, cl)
   
  @test_approx_eq 0.31 trg[end].value # TTR  0.31 
  @test index(trg)[end] == date(1971, 12, 31)
   
  # atr
#   atrsa  = atr(sa)
#   atw  = atr(sa, wilder=true)
   
#   @test_approx_eq 1.6727174227174808  atrsa[end]  # 0.6892646   102.09  101.78
#   @test_approx_eq 1.6327218109893784 atw[end] # TTR uses Wilder ema 1.632722
#   @test index(atrsa)[end] == date(1971, 12, 31)
   
  # keltner_bands
#   kma, kup, kdn  = keltnerbands(hi, lo, cl, 10)
   
#   @test_approx_eq  98.10133333333333 kma[end]  # needs confirmation 
#   @test_approx_eq  98.91883333333332 kup[end]  # needs confirmation 
#   @test_approx_eq  97.28383333333333 kdn[end]  # needs confirmation  
#   @test index(kma)[end] == date(1971, 12, 31)
  
#   ## chaikin_volatility
#   
#   #chk  = chaikinvolatility(sa)
#   
#   #@test_approx_eq 17.0466 == chk
end 
