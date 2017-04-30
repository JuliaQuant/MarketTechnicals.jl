using MarketData


@testset "Moving averages on TimeArrays"  begin

    @testset "sma"  begin
        ta = sma(cl, 10)
        @test ta.values[1]       ≈ 98.782 atol=.01  # TTR value 98.782
        @test ta.values[2]       ≈ 97.982 atol=.01  # TTR value 97.982
        @test ta.values[3]       ≈ 98.388 atol=.01  # TTR value 98.388
        @test ta.values[490]     ≈ 21.266 atol=.01  # TTR value 21.266
        @test ta.values[491]     ≈ 21.417 atol=.01  # TTR value 21.417
        @test ta.timestamp[491] == Date(2001,12,31)

        ta = sma(ohlc, 10)
        @test ta.values[1,:]     ≈ [100.692, 103.981, 96.001, 98.782] atol=.01
        @test ta.values[2,:]     ≈ [100.304, 103.331, 95.876, 97.982] atol=.01
        @test ta.values[3,:]     ≈ [100.041, 103.144, 96.095,98.388]  atol=.01
        @test ta.values[490,:]   ≈ [21.081, 21.685, 20.797, 21.266]   atol=.01
        @test ta.values[491,:]   ≈ [21.259, 21.868, 20.971, 21.417]   atol=.01
        @test ta.timestamp[491] == Date(2001,12,31)
    end

    @testset "ema"  begin
        ta = ema(cl, 10)
        @test ta.values[1]       ≈ 98.782  atol=.01  # TTR value 98.78200
        @test ta.values[2]       ≈ 99.719  atol=.01  # TTR value 99.71982
        @test ta.values[3]       ≈ 100.963 atol=.01  # TTR value 100.96349
        @test ta.values[490]     ≈ 21.585  atol=.01  # TTR value 21.58580
        @test ta.values[491]     ≈ 21.642  atol=.01  # TTR value 21.64293
        @test ta.timestamp[491] == Date(2001,12,31)

        ta = ema(ohlc, 10)
        @test ta.values[1,:]     ≈ [100.692, 103.981, 96.001, 98.782]  atol=.01
        @test ta.values[2,:]     ≈ [100.748, 104.348, 96.808, 99.719]  atol=.01
        @test ta.values[3,:]     ≈ [101.634, 105.148, 98.003, 100.963] atol=.01
        @test ta.values[490,:]   ≈ [21.369, 22.030, 21.125, 21.585]    atol=.01
        @test ta.values[491,:]   ≈ [21.576, 22.145, 21.253, 21.642]    atol=.01
        @test ta.timestamp[491] == Date(2001,12,31)
    end

    @testset "ema wilder true"  begin
        ta = ema(cl, 10, wilder=true)
        @test ta.values[1]       ≈ 98.782  atol=.01  # TTR value 98.7820
        @test ta.values[2]       ≈ 99.297  atol=.01  # TTR value 99.2978
        @test ta.values[3]       ≈ 100.024 atol=.01  # TTR value 100.0240
        @test ta.values[490]     ≈ 21.345  atol=.01  # TTR value 21.34556
        @test ta.values[491]     ≈ 21.401  atol=.01  # TTR value 21.40100
        @test ta.timestamp[491] == Date(2001,12,31)

        ta = ema(ohlc, 10, wilder=true)
        @test ta.values[1,:]     ≈ [100.692, 103.981, 96.001, 98.782] atol=.01
        @test ta.values[2,:]     ≈ [100.723, 104.183, 96.444, 99.297] atol=.01
        @test ta.values[3,:]     ≈ [101.213, 104.64, 97.138, 100.024] atol=.01
        @test ta.values[490,:]   ≈ [21.184, 21.776, 20.847, 21.345]   atol=.01
        @test ta.values[491,:]   ≈ [21.317, 21.865, 20.945, 21.401]   atol=.01
        @test ta.timestamp[491] == Date(2001,12,31)
    end
end

@testset "Moving averages on arrays"  begin

    @testset "Array dispatch on sma"  begin
        arr = sma(cl.values, 10)
        @test arr[1]   ≈ 98.782 atol=.01  # same values as above TimeArray dispatch
        @test arr[2]   ≈ 97.982 atol=.01
        @test arr[3]   ≈ 98.388 atol=.01
        @test arr[490] ≈ 21.266 atol=.01
        @test arr[491] ≈ 21.417 atol=.01

        arr = sma(ohlc.values, 10)
        @test arr[1,:]   ≈ [100.692, 103.981, 96.001, 98.782] atol=.01
        @test arr[2,:]   ≈ [100.304, 103.331, 95.876, 97.982] atol=.01
        @test arr[3,:]   ≈ [100.041, 103.144, 96.095,98.388]  atol=.01
        @test arr[490,:] ≈ [21.081, 21.685, 20.797, 21.266]   atol=.01
        @test arr[491,:] ≈ [21.259, 21.868, 20.971, 21.417]   atol=.01
    end

    @testset "Array dispatch on ema"  begin
        arr = ema(cl.values, 10)
        @test arr[1]   ≈ 98.782  atol=.01
        @test arr[2]   ≈ 99.719  atol=.01
        @test arr[3]   ≈ 100.963 atol=.01
        @test arr[490] ≈ 21.585  atol=.01
        @test arr[491] ≈ 21.642  atol=.01

        arr = ema(ohlc.values, 10)
        @test arr[1,:]   ≈ [100.692, 103.981, 96.001, 98.782]  atol=.01
        @test arr[2,:]   ≈ [100.748, 104.348, 96.808, 99.719]  atol=.01
        @test arr[3,:]   ≈ [101.634, 105.148, 98.003, 100.963] atol=.01
        @test arr[490,:] ≈ [21.369, 22.030, 21.125, 21.585]    atol=.01
        @test arr[491,:] ≈ [21.576, 22.145, 21.253, 21.642]    atol=.01
    end

    @testset "Array dispatch on ema wilder true"  begin
        arr = ema(cl.values, 10, wilder=true)
        @test arr[1]   ≈ 98.782  atol=.01
        @test arr[2]   ≈ 99.297  atol=.01
        @test arr[3]   ≈ 100.024 atol=.01
        @test arr[490] ≈ 21.345  atol=.01
        @test arr[491] ≈ 21.401  atol=.01

        arr = ema(ohlc.values, 10, wilder=true)
        @test arr[1,:]   ≈ [100.692, 103.981, 96.001, 98.782] atol=.01
        @test arr[2,:]   ≈ [100.723, 104.183, 96.444, 99.297] atol=.01
        @test arr[3,:]   ≈ [101.213, 104.64, 97.138, 100.024] atol=.01
        @test arr[490,:] ≈ [21.184, 21.776, 20.847, 21.345]   atol=.01
        @test arr[491,:] ≈ [21.317, 21.865, 20.945, 21.401]   atol=.01
    end
end
