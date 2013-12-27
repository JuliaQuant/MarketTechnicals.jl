module TestCandlesticks
  
  using Base.Test
  using Series
  using Datetime
  using MarketTechnicals

  op  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=2)
  hi  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=3)
  lo  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=4)
  cl  = readseries(Pkg.dir("MarketTechnicals/test/data/spx.csv"), value=5)
  
  # doji
  dojisa   = doji(op,hi,lo,cl)
  
  @test index(dojisa[value(dojisa) .== 1])[1] == date(1970, 3, 31)
  @test index(dojisa[value(dojisa) .== 1])[13] == date(1971, 11, 12)

end


# hammer
# inverted_hammer
# hanging_man
# mirabosu
# shooting_star
# spinning_top
# three_white_soldiers
# three_black_crows
# morning_star
