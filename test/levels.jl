module TestLevels
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  op  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=2)
  hi  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=3)
  lo  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=4)
  cl  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=5)
  

  # floor_pivots
  r3, r2, r1, p, s1, s2, s3 = floorpivots(hi, lo, cl)

  @test  95.29             == value(r3)[2] # values verified by various website calculators
  @test  94.52666666666669 == value(r2)[2] 
  @test  93.76333333333336 == value(r1)[2] 
  @test  92.77666666666669 == value(p)[2] 
  @test  92.01333333333336 == value(s1)[2] 
  @test  91.02666666666669 == value(s2)[2] 
  @test  90.26333333333336 == value(s3)[2] 
  @test index(s1)[end] == date(1971, 12, 31)

  # woodiespivots 
  #wr4, wr3, wr2, wr1, p, ws1, ws2, ws3, ws4 = woodiespivots(op, hi, lo)
  wr3, wr2, wr1, p, ws1, ws2, ws3 = woodiespivots(op, hi, lo)

#  @test_approx_eq  97.37500000000001 value(wr4)[2]  # 98.08  verified with online calculators 
  @test_approx_eq   95.62500000000001 value(wr3)[2]  # 95.63  
  @test_approx_eq   94.58250000000001 value(wr2)[2]  # 94.58  
  @test_approx_eq   93.87500000000001 value(wr1)[2]  # 93.88  
  @test_approx_eq   92.83250000000001 value(p)[2]    # 92.83 
  @test_approx_eq   92.12500000000001 value(ws1)[2]  # 92.13  
  @test_approx_eq   91.08250000000001 value(ws2)[2]  # 91.08  
  @test_approx_eq   90.37500000000001 value(ws3)[2]  # 90.38  
#  @test_approx_eq   88.62500000000001 value(ws4)[2]  # 87.58
  @test index(p)[end]               == date(1971, 12, 31)
end

# camarilla_pivots 
# demark_pivots 
# market_profile
