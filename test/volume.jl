module TestVolume
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  vl  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=6)

  # obv
  obvsa = obv(vl)
  
  @test_approx_eq 8080000 == obvsa[end].value # manual addition/subtration value of first three volume values
  
  # vwap
  vwpsa = vwap(vl)
  
  @test_approx_eq 101.44708763647094 == vwpsa[end].value  # TTR value 101.44709

end
