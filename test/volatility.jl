module TestVolatility
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  op  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=2)
  hi  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=3)
  lo  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=4)
  cl  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=5)

  # bollinger_bands
  bbma, bbup, bbdn  = bollingerbands(cl, 20, 2.0)
  
  # @test_approx_eq  2.2299598195282666  bbma[end].value   
  # @test_approx_eq  103.98191963905654  bbup[end].value   # R's TTR value 103.6847 (uses typical price instead of close for std)
  # @test_approx_eq   95.06208036094347  bbdn[end].value   # R's TTR value 95.35932 (uses typical price instead of close for std)
  
  # true_range
#   trg  = truerange(hi, lo, cl)
#   
#   @test_approx_eq 0.4299999999999926 trg[end]
#   
#   # atr
#   atrsa  = atr(sa)
#   
#   @test_approx_eq 1.6727174227174808  atrsa[end] 
#   
#   # atr wilder
#   atw  = atr(sa, method="wilder")
#    
#   @test_approx_eq 1.6327218109893784 atw[end] # TTR uses Wilder ema 1.632722
#   
#   # keltner_bands
#   kma, kup, kdn  = keltnerbands(hi, lo, cl, 10)
#   
#   @test_approx_eq  98.10133333333333 kma[end]  # needs confirmation 
#   @test_approx_eq  98.91883333333332 kup[end]  # needs confirmation 
#   @test_approx_eq  97.28383333333333 kdn[end]  # needs confirmation  
#   
#   ## chaikin_volatility
#   
#   #chk  = chaikinvolatility(sa)
#   
#   #@test_approx_eq 17.0466 == chk
end
