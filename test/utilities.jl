using Test

using MarketData
using TimeSeries

using MarketTechnicals


@testset "Utilities" begin


@testset "typical price" begin
  ts = collect(Date(2017, 5, 1):Date(2017, 5, 5))
  ta = typical(TimeArray(ts, reshape(1:15, (5, 3)), ["High", "Low", "Close"]))

  @test ta.timestamp[1]   == Date(2017, 5, 1)
  @test ta.timestamp[end] == Date(2017, 5, 5)
  @test ta.values         == [6, 7, 8, 9, 10]
end


@testset "relu" begin
  @test MarketTechnicals.relu(10) == 10
  @test MarketTechnicals.relu(-5) == 0
  @test MarketTechnicals.relu(0)  == 0

  date = collect(Date(2017, 5, 1):Date(2017, 5, 3))
  ta = TimeArray(date, [10, -5, 0], ["magic"], "meta")
  ta = MarketTechnicals.relu(ta)
  @test ta.timestamp[1] == Date(2017, 5, 1)
  @test ta.values       == [10, 0, 0]
  @test ta.colnames     == ["magic"]
  @test ta.meta         == "meta"
end


@testset "wilder_smooth" begin
  date = collect(Date(2017, 5, 1):Date(2017, 5, 5))
  ta = TimeArray(date, [0, 10, 5, 6, 7], ["magic"], "meta")
  ta = MarketTechnicals.wilder_smooth(ta, 3)
  @test ta.timestamp[1] == Date(2017, 5, 3)
  @test ta.values[1]    == 15.
  @test ta.values[2]    == 16.
  @test ta.colnames     == ["magic"]
  @test ta.meta         == "meta"

  ta = TimeArray(date, [0, 10, 5, 6, 7], ["magic"], "meta")
  ta = MarketTechnicals.wilder_smooth(ta, 3, padding=true)
  @test ta.timestamp[1]     == Date(2017, 5, 1)
  @test isnan(ta.values[1])
  @test isnan(ta.values[2])
  @test ta.values[3]        == 15.
  @test ta.values[4]        == 16.
  @test ta.colnames         == ["magic"]
  @test ta.meta             == "meta"

  ta = TimeArray(date, [0, 4, 5, 6, 7], ["magic"], "meta")
  ta = MarketTechnicals.wilder_smooth(ta, 3, dx=true)
  @test ta.timestamp[1] == Date(2017, 5, 3)
  @test ta.values[1]    == 3.
  @test ta.values[2]    == 4.
  @test ta.colnames     == ["magic"]
  @test ta.meta         == "meta"
end


end  # @testset "Utilities"
