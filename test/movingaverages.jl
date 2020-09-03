using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Moving Averages" begin


@testset "Moving Averages on TimeArrays" begin
    @testset "sma" begin
        ta = sma(cl, 10)
        @test isapprox(values(ta)[1]  , 98.782, atol=.01)  # TTR value 98.782
        @test isapprox(values(ta)[2]  , 97.982, atol=.01)  # TTR value 97.982
        @test isapprox(values(ta)[3]  , 98.388, atol=.01)  # TTR value 98.388
        @test isapprox(values(ta)[490], 21.266, atol=.01)  # TTR value 21.266
        @test isapprox(values(ta)[491], 21.417, atol=.01)  # TTR value 21.417
        @test timestamp(ta)[491] == Date(2001,12,31)

        ta = sma(ohlc, 10)
        @test isapprox(values(ta)[1,:]  , [100.692, 103.981, 96.001, 98.782] , atol=.01)
        @test isapprox(values(ta)[2,:]  , [100.304, 103.331, 95.876, 97.982], atol=.01)
        @test isapprox(values(ta)[3,:]  , [100.041, 103.144, 96.095,98.388], atol=.01)
        @test isapprox(values(ta)[490,:], [21.081, 21.685, 20.797, 21.266], atol=.01)
        @test isapprox(values(ta)[491,:], [21.259, 21.868, 20.971, 21.417], atol=.01)
        @test timestamp(ta)[491] == Date(2001,12,31)
    end

    @testset "ema" begin
        ta = ema(cl, 10)
        @test isapprox(values(ta)[1]  , 98.782, atol=.01)   # TTR value 98.78200
        @test isapprox(values(ta)[2]  , 99.719, atol=.01)   # TTR value 99.71982
        @test isapprox(values(ta)[3]  , 100.963, atol=.01)  # TTR value 100.96349
        @test isapprox(values(ta)[490], 21.585, atol=.01)   # TTR value 21.58580
        @test isapprox(values(ta)[491], 21.642, atol=.01)   # TTR value 21.64293
        @test timestamp(ta)[491] == Date(2001,12,31)

        ta = ema(ohlc, 10)
        @test isapprox(values(ta)[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(values(ta)[2,:]  , [100.748, 104.348, 96.808, 99.719], atol=.01)
        @test isapprox(values(ta)[3,:]  , [101.634, 105.148, 98.003, 100.963], atol=.01)
        @test isapprox(values(ta)[490,:], [21.369, 22.030, 21.125, 21.585], atol=.01)
        @test isapprox(values(ta)[491,:], [21.576, 22.145, 21.253, 21.642], atol=.01)
        @test timestamp(ta)[491] == Date(2001,12,31)
    end

    @testset "ema wilder true" begin
        ta = ema(cl, 10, wilder=true)
        @test isapprox(values(ta)[1]  , 98.782, atol=.01)  # TTR value 98.7820
        @test isapprox(values(ta)[2]  , 99.297, atol=.01)  # TTR value 99.2978
        @test isapprox(values(ta)[3]  , 100.024, atol=.01)  # TTR value 100.0240
        @test isapprox(values(ta)[490], 21.345, atol=.01)  # TTR value 21.34556
        @test isapprox(values(ta)[491], 21.401, atol=.01)  # TTR value 21.40100
        @test timestamp(ta)[491] == Date(2001,12,31)

        ta = ema(ohlc, 10, wilder=true)
        @test isapprox(values(ta)[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(values(ta)[2,:]  , [100.723, 104.183, 96.444, 99.297], atol=.01)
        @test isapprox(values(ta)[3,:]  , [101.213, 104.64, 97.138, 100.024], atol=.01)
        @test isapprox(values(ta)[490,:], [21.184, 21.776, 20.847, 21.345], atol=.01)
        @test isapprox(values(ta)[491,:], [21.317, 21.865, 20.945, 21.401], atol=.01)
        @test timestamp(ta)[491] == Date(2001,12,31)
    end

    @testset "kama" begin
        ta = kama(cl)
        @test isapprox(values(ta)[1], 98.9052, atol=.01)
        @test isapprox(values(ta)[2], 99.0098, atol=.01)
        @test isapprox(values(ta)[3], 99.4499, atol=.01)
        @test timestamp(ta)[1] == Date(2000, 1, 18)
        @test colnames(ta)     == [:kama]

        ta = kama(ohlc)
        @test length(colnames(ta)) == 4
        @test timestamp(ta)[1]     == Date(2000, 1, 18)

        ta = kama(TimeArray(collect(Date(2011, 1, 1):Day(1):Date(2011, 1, 20)), 1:20))
        @test timestamp(ta)[end] == Date(2011, 1, 20)

        ta = kama(TimeArray(collect(Date(2011, 1, 1):Day(1):Date(2011, 1, 20)), fill(42, 20)))
        @test values(ta) == fill(42, length(ta))
    end

    @testset "env" begin
        ta = env(cl, 10)
        @test isapprox(values(ta)[1,2]  , 108.66, atol=.01)
        @test isapprox(values(ta)[2,2]  , 107.78, atol=.01)
        @test isapprox(values(ta)[490,2]  , 23.3926, atol=.01)
        @test isapprox(values(ta)[491,2]  , 23.5587, atol=.01)
        @test isapprox(values(ta)[1,1]  , 88.9038, atol=.01)
        @test isapprox(values(ta)[2,1]  , 88.1838, atol=.01)
        @test isapprox(values(ta)[490,1]  , 19.1394, atol=.01)
        @test isapprox(values(ta)[491,1]  , 19.2753, atol=.01)

        ta = env(ohlc, 10)
        @test isapprox(values(ta)[1,5:end]  , [110.761, 114.379, 105.601, 108.66] , atol=.01)
        @test isapprox(values(ta)[2,5:end]  , [110.334, 113.664, 105.464, 107.78], atol=.01)
        @test isapprox(values(ta)[490,5:end]  , [23.1891, 23.8535, 22.8767, 23.3926], atol=.01)
        @test isapprox(values(ta)[491,5:end]  , [23.3849, 24.0548, 23.0681, 23.5587], atol=.01)
        @test isapprox(values(ta)[1,1:4]  , [90.6228, 93.5829, 86.4009, 88.9038] , atol=.01)
        @test isapprox(values(ta)[2,1:4]  , [90.2736, 92.9979, 86.2884, 88.1838], atol=.01)
        @test isapprox(values(ta)[490,1:4]  , [18.9729, 19.5165, 18.7173, 19.1394], atol=.01)
        @test isapprox(values(ta)[491,1:4]  , [19.1331, 19.6812, 18.8739, 19.2753], atol=.01)
    end
end


@testset "Moving Averages on arrays" begin
    @testset "Array dispatch on sma" begin
        arr = sma(values(cl), 10)
        # same values as above TimeArray dispatch
        @test isapprox(arr[1]  , 98.782, atol=.01)
        @test isapprox(arr[2]  , 97.982, atol=.01)
        @test isapprox(arr[3]  , 98.388, atol=.01)
        @test isapprox(arr[490], 21.266, atol=.01)
        @test isapprox(arr[491], 21.417, atol=.01)

        arr = sma(values(ohlc), 10)
        @test isapprox(arr[1,:]  , [100.692, 103.981, 96.001, 98.782] , atol=.01)
        @test isapprox(arr[2,:]  , [100.304, 103.331, 95.876, 97.982], atol=.01)
        @test isapprox(arr[3,:]  , [100.041, 103.144, 96.095,98.388], atol=.01)
        @test isapprox(arr[490,:], [21.081, 21.685, 20.797, 21.266], atol=.01)
        @test isapprox(arr[491,:], [21.259, 21.868, 20.971, 21.417], atol=.01)
    end

    @testset "Array dispatch on ema" begin
        arr = ema(values(cl), 10)
        @test isapprox(arr[1]  , 98.782, atol=.01)
        @test isapprox(arr[2]  , 99.719, atol=.01)
        @test isapprox(arr[3]  , 100.963, atol=.01)
        @test isapprox(arr[490], 21.585, atol=.01)
        @test isapprox(arr[491], 21.642, atol=.01)

        arr = ema(values(ohlc), 10)
        @test isapprox(arr[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(arr[2,:]  , [100.748, 104.348, 96.808, 99.719], atol=.01)
        @test isapprox(arr[3,:]  , [101.634, 105.148, 98.003, 100.963], atol=.01)
        @test isapprox(arr[490,:], [21.369, 22.030, 21.125, 21.585], atol=.01)
        @test isapprox(arr[491,:], [21.576, 22.145, 21.253, 21.642], atol=.01)
        @test timestamp(ema(ohlc, 10))[491] == Date(2001,12,31)
    end

    @testset "Array dispatch on ema wilder true" begin
        arr = ema(values(cl), 10, wilder=true)
        @test isapprox(arr[1]  , 98.782, atol=.01)
        @test isapprox(arr[2]  , 99.297, atol=.01)
        @test isapprox(arr[3]  , 100.024, atol=.01)
        @test isapprox(arr[490], 21.345, atol=.01)
        @test isapprox(arr[491], 21.401, atol=.01)

        arr = ema(values(ohlc), 10, wilder=true)
        @test isapprox(arr[1,:]  , [100.692, 103.981, 96.001, 98.782], atol=.01)
        @test isapprox(arr[2,:]  , [100.723, 104.183, 96.444, 99.297], atol=.01)
        @test isapprox(arr[3,:]  , [101.213, 104.64, 97.138, 100.024], atol=.01)
        @test isapprox(arr[490,:], [21.184, 21.776, 20.847, 21.345], atol=.01)
        @test isapprox(arr[491,:], [21.317, 21.865, 20.945, 21.401], atol=.01)
    end

    @testset "Array dispatch on env" begin
        ta = env(values(cl), 10)
        @test isapprox(ta[1,:]  , [88.9038, 108.66], atol=.01)
        @test isapprox(ta[2,:]  , [88.1838, 107.78], atol=.01)
        @test isapprox(ta[490,:]  , [19.1394, 23.3926], atol=.01)
        @test isapprox(ta[491,:]  , [19.2753, 23.5587], atol=.01)

        ta = env(values(ohlc), 10)
        @test isapprox(ta[1,:]  , [90.6228, 93.5829, 86.4009, 88.9038, 110.761, 114.379, 105.601, 108.66] , atol=.01)
        @test isapprox(ta[2,:]  , [90.2736, 92.9979, 86.2884, 88.1838, 110.334, 113.664, 105.464, 107.78], atol=.01)
        @test isapprox(ta[490,:]  , [18.9729, 19.5165, 18.7173, 19.1394, 23.1891, 23.8535, 22.8767, 23.3926], atol=.01)
        @test isapprox(ta[491,:]  , [19.1331, 19.6812, 18.8739, 19.2753, 23.3849, 24.0548, 23.0681, 23.5587], atol=.01)
    end
end


end  # @testset "Moving Averages"
