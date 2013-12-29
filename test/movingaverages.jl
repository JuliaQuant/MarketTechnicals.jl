module TestMovingAverages
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  op  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=2)
  hi  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=3)
  lo  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=4)
  cl  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=5)
  
  # sma
  
  # ema
  emasa = ema(cl, 10) 
  
  @test value(emasa)[1] == 92.394
  @test_approx_eq value(emasa)[end] 101.10189950870759

end
