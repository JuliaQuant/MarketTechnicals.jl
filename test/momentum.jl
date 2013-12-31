module TestMomentum
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  op  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=2)
  hi  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=3)
  lo  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=4)
  cl  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=5)
  
  # rsi 
  rsisa = rsi(cl, 14)
  rsiw  = rsi(cl, 14, wilder=true)
  
  @test_approx_eq 73.80060302291837 rsisa[end].value
  @test_approx_eq 72.15153048735719 rsiw[end].value # from TTR 1971-12-31 72.151530
  @test index(rsisa)[end] == date(1971, 12, 31)
  
  # macd
  mcd, val = macd(cl)
   
#   @test_approx_eq 1.8694463607370295 mcd[end].value  # TTR value with percent=FALSE is 1.900959 
#   @test_approx_eq 1.7189453474752991 val[end].value  # TTR value with percent=FALSE is 1.736186
  @test index(mcd)[end] == date(1971, 12, 31)
    
  # cci 
#   ccisa = cci(sa)
#    
#   @test_approx_eq -146.17060449635804 ccisa[end].value  # TTR::CCI value is -175.8644
#   @test index(ccisa)[end] == date(1971, 12, 31)
end
