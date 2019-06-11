using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Volume" begin


@testset "obv" begin
  @test obv(ohlcv).values[1]     == 4783900 # TTR value is 4783900
  @test obv(ohlcv).values[12]    == 9390200 # TTR value is 2000-01-19   9390200
  @test obv(ohlcv).timestamp[12] == Date(2000,1,19)
end


@testset "vwap" begin
  # TTR value 2000-01-14 97.92154
  @test isapprox(vwap(ohlcv).values[1]   , 97.9215, atol=.01)
  # TTR value  21.44458
  @test isapprox(vwap(ohlcv).values[end] , 21.4446, atol=.01)
  @test vwap(ohlcv).timestamp[1] == Date(2000,1,14)
end


@testset "adl" begin
  """
  Quote from TTR

  > chaikinAD(x[,c('High', 'Low', 'Close')], x['Volume'])
      [1]     4288250.8     984498.1   -4126362.8  -10983262.8   -9113399.1
      [6]   -10015299.1  -11959861.3  -19338476.6  -16019132.6  -16929977.6
      [11]  -15868158.9  -14884408.6  -31233808.6  -33218729.3  -35989170.7
      [16]  -32269505.9  -34897972.6  -34897972.6  -37941049.9  -31849706.7
      [21]  -34405346.7  -35619584.9  -33370900.9  -31954278.7  -28196260.3
      [26]  -26405674.2  -28872966.5  -26697651.1  -28269906.1  -25051587.6
      [31]  -22431126.6  -23556859.9  -22318762.4  -24060310.9  -22592574.8
      [36]  -21272543.5  -21486881.4  -23543250.6  -22161637.3  -22562010.6
      [41]  -15427942.4  -17202733.1  -14476907.6  -15727198.9  -16807148.2
      [46]  -16131953.1  -15674416.0  -14855621.8  -16166047.8  -19805984.4
      [51]  -21014254.5  -18034460.1  -15310860.1  -16551649.3  -12990243.8
      [56]   -8069166.1  -11824243.5  -12798179.3  -13593182.8  -13919972.9
      [61]  -14450551.5  -17963286.2  -15275363.0  -15951899.0  -14184973.1
  """
  ta = adl(ohlcv)

  @test ta.meta           == ohlcv.meta
  @test ta.colnames       == ["adl"]
  @test ta.timestamp[1]   == ohlcv.timestamp[1]
  @test ta.timestamp[end] == ohlcv.timestamp[end]
  @test isapprox(ta.values[1], 4.2882507863e6, atol=.01)
  @test isapprox(ta.values[2], 984498.0822, atol=.01)
end


end  # @testset "Volume"
