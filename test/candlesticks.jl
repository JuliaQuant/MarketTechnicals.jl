using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Candlesticks" begin


@testset "doji" begin
    @test timestamp(ohlc[findall(doji(ohlc))])[1] == Date(2000, 5, 30)
    @test timestamp(ohlc[findall(doji(ohlc))])[2] == Date(2000, 12, 11)
    @test length(ohlc[findall(doji(ohlc))])      == 5
end


end  # @testset "Candlesticks"
