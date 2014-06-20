using MarketData

facts("Candlesticks") do

  context("doji") do
    @fact ohlc[findall(doji(ohlc))].timestamp[1] => Date(2000, 5, 30)
    @fact ohlc[findall(doji(ohlc))].timestamp[2] => Date(2000, 12, 11)
    @fact length(ohlc[findall(doji(ohlc))])      => 5
  end
end
