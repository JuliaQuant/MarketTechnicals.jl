using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Volatility" begin


@testset "bollinger_bands" begin
  # TTR default uses sample=FALSE and value 117.3251
  @test isapprox(bollingerbands(cl)["up"].values[1]  , 117.3251, atol=.01)
  # TTR default uses sample=FALSE and value 89.39392
  @test isapprox(bollingerbands(cl)["down"].values[1], 89.39392, atol=.01)
  # TTR 103.3595
  @test isapprox(bollingerbands(cl)["mean"].values[1], 103.3595, atol=.01)
  @test bollingerbands(cl).timestamp[1]   == Date(2000,1,31)
  @test bollingerbands(cl).timestamp[end] == Date(2001,12,31)
end


@testset "truerange" begin
  @test isapprox(truerange(ohlc).values[end], 0.83, atol=.01) # TTR 0.83
  @test truerange(ohlc).timestamp[end] == Date(2001,12,31)
end


@testset "donchianchannels" begin
  ta = donchianchannels(ohlc)

  @test ta.meta      == ohlc.meta
  @test ta.timestamp == ohlc[20:end].timestamp
  @test isapprox(ta["up"].values[1]   , 121.5, atol=.01)
  @test isapprox(ta["down"].values[1] , 86.5, atol=.01)
  @test ta["mid"].values[1] == (ta["up"].values[1] + ta["down"].values[1]) / 2
end


@testset "atr" begin
  @test isapprox(atr(ohlc).values[1]  , 8.343571428571428)   # TTR value 8.343571
  @test isapprox(atr(ohlc).values[end], 0.9664561242651976)  # TTR value 0.9664561
  @test atr(ohlc).timestamp[1] == Date(2000,1,24)
end


@testset "keltner_bands" begin
  ta = keltnerbands(ohlc)

  @test ta["kup"].values[end] > ta["kma"].values[end]
  @test ta["kma"].values[end] > ta["kdn"].values[end]

  @test isapprox(ta["kup"].values[end], 23.3156, atol=.01)  # needs confirmation
  @test isapprox(ta["kma"].values[end], 21.3705, atol=.01)  # needs confirmation
  @test isapprox(ta["kdn"].values[end], 19.4254, atol=.01)  # needs confirmation
  @test ta.timestamp[1]   == Date(2000, 2, 1)
  @test ta.timestamp[end] == Date(2001, 12, 31)
end


@testset "chaikin_volatility" begin
  ta = chaikinvolatility(ohlc)

  @test ta.timestamp == ohlc[10+10:end].timestamp
  @test ta.colnames  == ["chaikinvolatility"]
  @test ta.meta      == ohlc.meta
  @test isapprox(ta.values[1], -2.2401, atol=.01)  # needs confirmation
  @test isapprox(ta.values[2], -3.2901, atol=.01)  # needs confirmation
end


end  # @testset "Volatility"
