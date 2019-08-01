using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Utilities" begin


@testset "typical price" begin
    ts = collect(Date(2017, 5, 1):Day(1):Date(2017, 5, 5))
    ta = typical(TimeArray(ts, reshape(1:15, (5, 3)), [:High, :Low, :Close]))

    @test timestamp(ta)[1]   == Date(2017, 5, 1)
    @test timestamp(ta)[end] == Date(2017, 5, 5)
    @test values(ta)         == [6, 7, 8, 9, 10]
end


@testset "relu" begin
    @test MarketTechnicals.relu(10) == 10
    @test MarketTechnicals.relu(-5) == 0
    @test MarketTechnicals.relu(0)  == 0

    date = collect(Date(2017, 5, 1):Day(1):Date(2017, 5, 3))
    ta = TimeArray(date, [10, -5, 0], [:magic], "meta")
    ta = MarketTechnicals.relu(ta)
    @test timestamp(ta)[1] == Date(2017, 5, 1)
    @test values(ta)       == [10, 0, 0]
    @test colnames(ta)     == [:magic]
    @test meta(ta)         == "meta"
end


@testset "wilder_smooth" begin
    date = collect(Date(2017, 5, 1):Day(1):Date(2017, 5, 5))
    ta = TimeArray(date, [0, 10, 5, 6, 7], [:magic], "meta")
    ta = MarketTechnicals.wilder_smooth(ta, 3)
    @test timestamp(ta)[1] == Date(2017, 5, 3)
    @test values(ta)[1]    == 15.
    @test values(ta)[2]    == 16.
    @test colnames(ta)     == [:magic]
    @test meta(ta)         == "meta"

    ta = TimeArray(date, [0, 10, 5, 6, 7], [:magic], "meta")
    ta = MarketTechnicals.wilder_smooth(ta, 3, padding=true)
    @test timestamp(ta)[1]     == Date(2017, 5, 1)
    @test isnan(values(ta)[1])
    @test isnan(values(ta)[2])
    @test values(ta)[3]        == 15.
    @test values(ta)[4]        == 16.
    @test colnames(ta)         == [:magic]
    @test meta(ta)             == "meta"

    ta = TimeArray(date, [0, 4, 5, 6, 7], [:magic], "meta")
    ta = MarketTechnicals.wilder_smooth(ta, 3, dx=true)
    @test timestamp(ta)[1] == Date(2017, 5, 3)
    @test values(ta)[1]    == 3.
    @test values(ta)[2]    == 4.
    @test colnames(ta)     == [:magic]
    @test meta(ta)         == "meta"
end


end  # @testset "Utilities"
