using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Volatility" begin


@testset "bollinger_bands" begin
    # TTR default uses sample=FALSE and value 117.3251
    @test isapprox(values(bollingerbands(cl)[:up])[1]  , 117.3251, atol=.01)
    # TTR default uses sample=FALSE and value 89.39392
    @test isapprox(values(bollingerbands(cl)[:down])[1], 89.39392, atol=.01)
    # TTR 103.3595
    @test isapprox(values(bollingerbands(cl)[:mean])[1], 103.3595, atol=.01)
    @test timestamp(bollingerbands(cl))[1]   == Date(2000,1,31)
    @test timestamp(bollingerbands(cl))[end] == Date(2001,12,31)
end


@testset "truerange" begin
    @test isapprox(values(truerange(ohlc))[end], 0.83, atol=.01) # TTR 0.83
    @test timestamp(truerange(ohlc))[end] == Date(2001,12,31)
end


@testset "donchianchannels" begin
    ta = donchianchannels(ohlc)

    @test meta(ta)      == meta(ohlc)
    @test timestamp(ta) == timestamp(ohlc[20:end])
    @test isapprox(values(ta[:up])[1]   , 121.5, atol=.01)
    @test isapprox(values(ta[:down])[1] , 86.5, atol=.01)
    @test values(ta[:mid])[1] == (values(ta[:up])[1] + values(ta[:down])[1]) / 2
end


@testset "atr" begin
    @test isapprox(values(atr(ohlc))[1]  , 8.343571428571428)   # TTR value 8.343571
    @test isapprox(values(atr(ohlc))[end], 0.9664561242651976)  # TTR value 0.9664561
    @test timestamp(atr(ohlc))[1] == Date(2000,1,24)
end


@testset "keltner_bands" begin
    ta = keltnerbands(ohlc)

    @test values(ta[:kup])[end] > values(ta[:kma])[end]
    @test values(ta[:kma])[end] > values(ta[:kdn])[end]

    @test isapprox(values(ta[:kup])[end], 23.3156, atol=.01)  # needs confirmation
    @test isapprox(values(ta[:kma])[end], 21.3705, atol=.01)  # needs confirmation
    @test isapprox(values(ta[:kdn])[end], 19.4254, atol=.01)  # needs confirmation
    @test timestamp(ta)[1]   == Date(2000, 2, 1)
    @test timestamp(ta)[end] == Date(2001, 12, 31)
end


@testset "chaikin_volatility" begin
    ta = chaikinvolatility(ohlc)

    @test timestamp(ta) == timestamp(ohlc[10+10:end])
    @test colnames(ta)  == [:chaikinvolatility]
    @test meta(ta)      == meta(ohlc)
    @test isapprox(values(ta)[1], -2.2401, atol=.01)  # needs confirmation
    @test isapprox(values(ta)[2], -3.2901, atol=.01)  # needs confirmation
end


end  # @testset "Volatility"
