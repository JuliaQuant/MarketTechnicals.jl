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
  smasa = sma(cl, 10) 
  smaa  = sma(value(cl), 10) 

  @test_approx_eq value(smasa)[1] 92.394
  @test_approx_eq smaa[1] 92.394
  @test_approx_eq value(smasa)[end] 101.45100000000001
  @test_approx_eq smaa[end] 101.45100000000001
  
  # ema
  emasa = ema(cl, 10) 
  emaw  = ema(cl, 10, wilder=false) 
  #emaw  = ema(cl, 10, method="wilder") 
  emaa  = ema(value(cl), 10) 
  
  @test value(emasa)[1] == 92.394
  @test emaa[1] == 92.394
  @test_approx_eq value(emasa)[end] 101.10189950870759
  @test_approx_eq value(emaw)[end] 99.72706080954146   # TTR  99.72706
  @test_approx_eq emaa[end] 101.10189950870759

end
