using Base.Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Levels" begin


@testset "floor pivots" begin
    # values verified by various website calculators
    @test isapprox(floorpivots(ohlc)["r3"].values[1]   , 123.310, atol=.01)
    @test isapprox(floorpivots(ohlc)["r2"].values[1]   , 119.52, atol=.01)
    @test isapprox(floorpivots(ohlc)["r1"].values[1]   , 115.73, atol=.01)
    @test isapprox(floorpivots(ohlc)["pivot"].values[1], 108.71, atol=.01)
    @test isapprox(floorpivots(ohlc)["s1"].values[1]   , 104.92, atol=.01)
    @test isapprox(floorpivots(ohlc)["s2"].values[1]   , 97.900, atol=.01)
    @test isapprox(floorpivots(ohlc)["s3"].values[1]   , 94.110, atol=.01)
    @test floorpivots(ohlc).timestamp[end] == Date(2001,12,31)
end


@testset "woodiespivots" begin
    # @test_approx_eq  97.37500000000001 value(wr4)[2]   # values NEED to be verified with online calculators
    # @test_approx_eq   88.62500000000001 value(ws4)[2]
    @test isapprox(woodiespivots(ohlc)["r3"].values[1]   , 124.465, atol=.01)
    @test isapprox(woodiespivots(ohlc)["r2"].values[1]   , 118.480, atol=.01)
    @test isapprox(woodiespivots(ohlc)["r1"].values[1]   , 113.655, atol=.01)
    @test isapprox(woodiespivots(ohlc)["pivot"].values[1], 107.670, atol=.01)
    @test isapprox(woodiespivots(ohlc)["s1"].values[1]   , 102.845, atol=.01)
    @test isapprox(woodiespivots(ohlc)["s2"].values[1]   , 96.8625, atol=.01)
    @test isapprox(woodiespivots(ohlc)["s3"].values[1]   , 92.035, atol=.01)
    @test woodiespivots(ohlc).timestamp[end] == Date(2001,12,31)
end


end  # @testset "Levels"
