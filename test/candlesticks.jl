using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Candlesticks" begin


@testset "doji" begin
  @test ohlc[find(doji(ohlc))].timestamp[1] == Date(2000, 5, 30)
  @test ohlc[find(doji(ohlc))].timestamp[2] == Date(2000, 12, 11)
  @test length(ohlc[find(doji(ohlc))])      == 5
end


end  # @testset "Candlesticks"
