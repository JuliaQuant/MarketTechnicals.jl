using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Levels" begin


@testset "floor pivots" begin
    # values verified by various website calculators
    @test isapprox(values(floorpivots(ohlc)[:r3])[1]   , 123.310, atol=.01)
    @test isapprox(values(floorpivots(ohlc)[:r2])[1]   , 119.52, atol=.01)
    @test isapprox(values(floorpivots(ohlc)[:r1])[1]   , 115.73, atol=.01)
    @test isapprox(values(floorpivots(ohlc)[:pivot])[1], 108.71, atol=.01)
    @test isapprox(values(floorpivots(ohlc)[:s1])[1]   , 104.92, atol=.01)
    @test isapprox(values(floorpivots(ohlc)[:s2])[1]   , 97.900, atol=.01)
    @test isapprox(values(floorpivots(ohlc)[:s3])[1]   , 94.110, atol=.01)
    @test timestamp(floorpivots(ohlc))[end] == Date(2001,12,31)
end


@testset "woodiespivots" begin
    # @test_approx_eq  97.37500000000001 value(wr4)[2]   # values NEED to be verified with online calculators
    # @test_approx_eq   88.62500000000001 value(ws4)[2]
    @test isapprox(values(woodiespivots(ohlc)[:r3])[1]   , 124.465, atol=.01)
    @test isapprox(values(woodiespivots(ohlc)[:r2])[1]   , 118.480, atol=.01)
    @test isapprox(values(woodiespivots(ohlc)[:r1])[1]   , 113.655, atol=.01)
    @test isapprox(values(woodiespivots(ohlc)[:pivot])[1], 107.670, atol=.01)
    @test isapprox(values(woodiespivots(ohlc)[:s1])[1]   , 102.845, atol=.01)
    @test isapprox(values(woodiespivots(ohlc)[:s2])[1]   , 96.8625, atol=.01)
    @test isapprox(values(woodiespivots(ohlc)[:s3])[1]   , 92.035, atol=.01)
    @test timestamp(woodiespivots(ohlc))[end] == Date(2001,12,31)
end


end  # @testset "Levels"
