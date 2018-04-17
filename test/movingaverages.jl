using Base.Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Moving Averages" begin


@testset "Moving Averages on TimeArrays" begin
    @testset "sma" begin
        ta = sma(cl, 10)
        @test isapprox(ta.values[1]  , 98.782, atol=.01)  # TTR value 98.782
        @test isapprox(ta.values[2]  , 97.982, atol=.01)  # TTR value 97.982
        @test isapprox(ta.values[3]  , 98.388, atol=.01)  # TTR value 98.388
        @test isapprox(ta.values[490], 21.266, atol=.01)  # TTR value 21.266
        @test isapprox(ta.values[491], 21.417, atol=.01)  # TTR value 21.417
        @test ta.timestamp[491] == Date(2001,12,31)

        ta = sma(ohlc, 10)
        @test isapprox(ta.values[1,:]  , [100.692, 103.981, 96.001, 98.782] , atol=.01)
        @test isapprox(ta.values[2,:]  , [100.304, 103.331, 95.876, 97.982], atol=.01)
        @test isapprox(ta.values[3,:]  , [100.041, 103.144, 96.095,98.388], atol=.01)
        @test isapprox(ta.values[490,:], [21.081, 21.685, 20.797, 21.266], atol=.01)
        @test isapprox(ta.values[491,:], [21.259, 21.868, 20.971, 21.417], atol=.01)
        @test ta.timestamp[491] == Date(2001,12,31)
    end

    @testset "ema" begin
        ta = ema(cl, 10)
        @test isapprox(ta.values[1]  , 98.782, atol=.01)   # TTR value 98.78200
        @test isapprox(ta.values[2]  , 99.719, atol=.01)   # TTR value 99.71982
        @test isapprox(ta.values[3]  , 100.963, atol=.01)  # TTR value 100.96349
        @test isapprox(ta.values[490], 21.585, atol=.01)   # TTR value 21.58580
        @test isapprox(ta.values[491], 21.642, atol=.01)   # TTR value 21.64293
        @test ta.timestamp[491] == Date(2001,12,31)

        ta = ema(ohlc, 10)
        @test isapprox(ta.values[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(ta.values[2,:]  , [100.748, 104.348, 96.808, 99.719], atol=.01)
        @test isapprox(ta.values[3,:]  , [101.634, 105.148, 98.003, 100.963], atol=.01)
        @test isapprox(ta.values[490,:], [21.369, 22.030, 21.125, 21.585], atol=.01)
        @test isapprox(ta.values[491,:], [21.576, 22.145, 21.253, 21.642], atol=.01)
        @test ta.timestamp[491] == Date(2001,12,31)
    end

    @testset "ema wilder true" begin
        ta = ema(cl, 10, wilder=true)
        @test isapprox(ta.values[1]  , 98.782, atol=.01)  # TTR value 98.7820
        @test isapprox(ta.values[2]  , 99.297, atol=.01)  # TTR value 99.2978
        @test isapprox(ta.values[3]  , 100.024, atol=.01)  # TTR value 100.0240
        @test isapprox(ta.values[490], 21.345, atol=.01)  # TTR value 21.34556
        @test isapprox(ta.values[491], 21.401, atol=.01)  # TTR value 21.40100
        @test ta.timestamp[491] == Date(2001,12,31)

        ta = ema(ohlc, 10, wilder=true)
        @test isapprox(ta.values[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(ta.values[2,:]  , [100.723, 104.183, 96.444, 99.297], atol=.01)
        @test isapprox(ta.values[3,:]  , [101.213, 104.64, 97.138, 100.024], atol=.01)
        @test isapprox(ta.values[490,:], [21.184, 21.776, 20.847, 21.345], atol=.01)
        @test isapprox(ta.values[491,:], [21.317, 21.865, 20.945, 21.401], atol=.01)
        @test ta.timestamp[491] == Date(2001,12,31)
    end

    @testset "kama" begin
        ta = kama(cl)
        @test isapprox(ta.values[1], 98.9052, atol=.01)
        @test isapprox(ta.values[2], 99.0098, atol=.01)
        @test isapprox(ta.values[3], 99.4499, atol=.01)
        @test ta.timestamp[1] == Date(2000, 1, 18)
        @test ta.colnames     == ["kama"]

        ta = kama(ohlc)
        @test length(ta.colnames) == 4
        @test ta.timestamp[1]     == Date(2000, 1, 18)

        ta = kama(TimeArray(collect(Date(2011, 1, 1):Date(2011, 1, 20)), 1:20))
        @test ta.timestamp[end] == Date(2011, 1, 20)

        ta = kama(TimeArray(collect(Date(2011, 1, 1):Date(2011, 1, 20)), fill(42, 20)))
        @test ta.values == fill(42, length(ta))
    end
end


@testset "Moving Averages on arrays" begin
    @testset "Array dispatch on sma" begin
        arr = sma(cl.values, 10)
        # same values as above TimeArray dispatch
        @test isapprox(arr[1]  , 98.782, atol=.01)
        @test isapprox(arr[2]  , 97.982, atol=.01)
        @test isapprox(arr[3]  , 98.388, atol=.01)
        @test isapprox(arr[490], 21.266, atol=.01)
        @test isapprox(arr[491], 21.417, atol=.01)

        arr = sma(ohlc.values, 10)
        @test isapprox(arr[1,:]  , [100.692, 103.981, 96.001, 98.782] , atol=.01)
        @test isapprox(arr[2,:]  , [100.304, 103.331, 95.876, 97.982], atol=.01)
        @test isapprox(arr[3,:]  , [100.041, 103.144, 96.095,98.388], atol=.01)
        @test isapprox(arr[490,:], [21.081, 21.685, 20.797, 21.266], atol=.01)
        @test isapprox(arr[491,:], [21.259, 21.868, 20.971, 21.417], atol=.01)
    end

    @testset "Array dispatch on ema" begin
        arr = ema(cl.values, 10)
        @test isapprox(arr[1]  , 98.782, atol=.01)
        @test isapprox(arr[2]  , 99.719, atol=.01)
        @test isapprox(arr[3]  , 100.963, atol=.01)
        @test isapprox(arr[490], 21.585, atol=.01)
        @test isapprox(arr[491], 21.642, atol=.01)

        arr = ema(ohlc.values, 10)
        @test isapprox(arr[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(arr[2,:]  , [100.748, 104.348, 96.808, 99.719], atol=.01)
        @test isapprox(arr[3,:]  , [101.634, 105.148, 98.003, 100.963], atol=.01)
        @test isapprox(arr[490,:], [21.369, 22.030, 21.125, 21.585], atol=.01)
        @test isapprox(arr[491,:], [21.576, 22.145, 21.253, 21.642], atol=.01)
        @test ema(ohlc, 10).timestamp[491] == Date(2001,12,31)
    end

    @testset "Array dispatch on ema wilder true" begin
        arr = ema(cl.values, 10, wilder=true)
        @test isapprox(arr[1]  , 98.782, atol=.01)
        @test isapprox(arr[2]  , 99.297, atol=.01)
        @test isapprox(arr[3]  , 100.024, atol=.01)
        @test isapprox(arr[490], 21.345, atol=.01)
        @test isapprox(arr[491], 21.401, atol=.01)

        arr = ema(ohlc.values, 10, wilder=true)
        @test isapprox(arr[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(arr[2,:]  , [100.723, 104.183, 96.444, 99.297], atol=.01)
        @test isapprox(arr[3,:]  , [101.213, 104.64, 97.138, 100.024], atol=.01)
        @test isapprox(arr[490,:], [21.184, 21.776, 20.847, 21.345], atol=.01)
        @test isapprox(arr[491,:], [21.317, 21.865, 20.945, 21.401], atol=.01)
    end
end


end  # @testset "Moving Averages"
