using Base.Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Momentum" begin


@testset "rsi" begin
    # TTR: RSI(x["Close"])
    # TTR: 45.95363 50.50249 48.97830 48.83191 ...
    @test rsi(cl, wilder=true).values[1:4] ≈ [45.95363, 50.50249, 48.97830, 48.83191] atol=.01
    # TTR value is 55.84922
    @test rsi(cl).values[end] ≈ 55.849 atol=.01
    # TTR value is 55.95932
    @test rsi(cl, wilder=true).values[end] ≈ 55.959 atol=.01
    # TTR value is 56.21947
    @test rsi(cl, 10).values[end] ≈ 56.219 atol=.01
    @test rsi(ohlc).values[end, :] ≈ [68.030, 61.872, 70.062, 55.849] atol=.01

    # seed is included (TODO: debate amongst yourselves)
    @test rsi(cl).timestamp[1]              == Date(2000,1,24)
    @test rsi(cl, wilder=true).timestamp[1] == Date(2000,1,24)
    @test rsi(cl, 10).timestamp[1]          == Date(2000,1,18)
    @test rsi(ohlc).timestamp[1]            == Date(2000,1,24)

    @test rsi(cl).timestamp[end]              == Date(2001,12,31)
    @test rsi(cl, wilder=true).timestamp[end] == Date(2001,12,31)
    @test rsi(cl, 10).timestamp[end]          == Date(2001,12,31)
    @test rsi(ohlc).timestamp[end]            == Date(2001,12,31)
end


@testset "macd" begin
    @test isapprox(macd(cl).values[end, 1], -0.020, atol=.01)
    @test isapprox(macd(cl).values[end, 2], 0.421, atol=.01) # TTR value with percent=FALSE is 0.421175152
    @test isapprox(macd(cl).values[end, 3], 0.441, atol=.01) # TTR value with percent=FALSE is 0.4414275
    @test macd(cl).timestamp[end] == Date(2001,12,31)
end


@testset "macd multi-column TimeArray" begin
    # multi-column TimeArray
    # TTR: MACD(..., maType="EMA", percent=0)
    ta = macd(ohlc["Open", "Close"])
    @test ta.colnames[1:2]  == ["Open_macd", "Close_macd"]
    @test ta.timestamp[end] == Date(2001, 12, 31)
    @test isapprox(ta.values[end, 3], 0.44254569, atol=.01)    # Open_dif
    @test isapprox(ta.values[end, 5], 4.536854e-01, atol=.01)  # Open_signal
    @test isapprox(ta.values[end, 4], 0.421175152, atol=.01)   # Close_dif
    @test isapprox(ta.values[end, 6], 4.414275e-01, atol=.01)  # Close_signal
end


@testset "chaikinoscillator" begin
    """
    Quote from TTR

    > EMA(adl, 3) - EMA(adl, 10)
        [1]            NA            NA            NA            NA            NA
        [6]            NA            NA            NA            NA  -6851466.867
    [11]  -5508824.158  -4145747.583  -8413321.022 -10025864.828 -10655603.670
    [16]  -8761003.151  -8025814.774  -6995436.368  -6906221.064  -4303730.935
    [21]  -3660985.797  -3451576.257  -2336638.695  -1217362.729    546925.363
    [26]   1788691.016   1349030.229   1738675.716   1239751.751   1946952.206
    [31]   2893048.890   2658896.120   2715328.628   1937437.546   1910085.631
    [36]   2145262.005   1978248.295   1075784.464   1048400.357    814497.124
    [41]   2914695.065   2944188.520   3555908.642   3085073.413   2268377.529
    [46]   1942893.354   1778694.035   1810347.568   1241765.961   -261885.061
    [51]  -1237656.884   -576205.604    613370.430    649457.675   1738353.505
    [56]   3591576.201   2828408.458   1949186.773   1159350.740    626861.789
    [61]    183217.498  -1132617.797   -712700.508   -691386.657    -57610.324
    [66]    774998.562    561961.806   1084391.707    634202.420   -523959.226
    [71]  -1968845.762  -2496129.556  -3167709.694  -2000329.427   -230334.824
    [76]   -577397.260  -1747313.599   -806782.684    617588.662    443152.062
    [81]   1214832.531   1341044.310   1592063.283    936678.383    186056.580
    [86]  -1209996.220  -1516911.058  -1995687.520  -2776094.760  -4090715.405
    """

    ta = chaikinoscillator(ohlcv)
    @test ta.colnames     == ["chaikinoscillator"]
    @test ta.meta         == ta.meta
    @test ta.timestamp[1] == ohlcv.timestamp[10]
    @test isapprox(ta.values[1], -6851466.867, atol=.01)
    @test isapprox(ta.values[2], -5508824.158, atol=.01)
    @test isapprox(ta.values[3], -4145747.583, atol=.01)
end


@testset "cci" begin
    # TTR::CCI value is -38.931614
    @test isapprox(cci(ohlc).values[1]  , -38.931614, atol=.01)
    # TTR::CCI value is 46.3511339
    @test isapprox(cci(ohlc).values[end], 46.3511339, atol=.01)
    @test cci(ohlc).timestamp[end] == Date(2001, 12, 31)

    ta = cci(TimeArray(collect(Date(2011, 1, 1):Date(2011, 1, 30)),
                       fill(42, (30, 4)), ["Open", "High", "Low", "Close"]))
    @test all(ta.values .== 0)
end


@testset "aroon" begin
    """
    Quote from TTR

    > aroon(x[c('High', 'Low')], 25)
            aroonUp aroonDn oscillator
    [24,]      NA      NA         NA
    [25,]      NA      NA         NA
    [26,]      48      28         20
    [27,]      44      24         20
    [28,]      40      20         20
    [29,]      36      16         20
    [30,]      32      12         20
    """

    ta = aroon(ohlc)
    @test ta.colnames  == ["up", "dn", "osc"]
    @test ta.timestamp == ohlc[25:end].timestamp
    @test isapprox(ta.values[2, 1], 48)
    @test isapprox(ta.values[2, 2], 28)
    @test isapprox(ta.values[2, 3], 20)
end


@testset "roc" begin
    ta = roc(cl, 3)
    @test ta.colnames == ["Close_roc_3"]
    @test isapprox(ta.values[1], -0.15133107021618722, atol=.01)
    @test isapprox(ta.values[2], -0.02926829268292683, atol=.01)
    @test isapprox(ta.values[3], -0.06009615384615385, atol=.01)
end


@testset "adx" begin
    ta = adx(ohlc)
    @test ta.colnames == ["adx", "dx", "+di", "-di"]
    @test isapprox(ta.values[1, 1], 10.5998, atol=.01)
    @test isapprox(ta.values[1, 2], 0.3916,  atol=.01)
    @test isapprox(ta.values[1, 3], 23.6226, atol=.01)
    @test isapprox(ta.values[1, 4], 23.4383, atol=.01)
    @test ta.timestamp[1] == Date(2000, 2, 10)
end


@testset "stochasticoscillator" begin
    """
    Quote from TTR
    > stoch(x[, c("High", "Low", "Close")], maType=SMA)
                fastK      fastD      slowD
    [18,] 0.671428571 0.69466667 0.67441270
    [19,] 0.432000000 0.59342857 0.64901587
    [20,] 0.492857143 0.53209524 0.60673016
    [21,] 0.392857143 0.43923810 0.52158730
    [22,] 0.217586207 0.36776683 0.44636672
    [23,] 0.326296296 0.31224655 0.37308382
    [24,] 0.500000000 0.34796083 0.34265807
    [25,] 0.724444444 0.51691358 0.39237365
    [26,] 0.754814815 0.65975309 0.50820917
    [27,] 0.801061008 0.76010676 0.64559114
    [28,] 0.839964633 0.79861349 0.73949111
    """

    ta = stochasticoscillator(ohlc)
    @test ta.colnames  == ["fast_k", "fast_d", "slow_d"]
    @test ta.timestamp == ohlc[18:end].timestamp
    @test isapprox(ta.values[1, 1], 67.142857, atol=.01)
    @test isapprox(ta.values[1, 2], 69.466667, atol=.01)
    @test isapprox(ta.values[1, 3], 67.441270, atol=.01)
end


end  # @testset "Momentum"
