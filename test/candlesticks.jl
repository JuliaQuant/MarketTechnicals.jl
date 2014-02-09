facts("Candlesticks") do

  context("doji") do
    @fact ohlc[findfirst(doji(ohlc).values)].timestamp => [date(1980, 10, 14)]
  end
end
