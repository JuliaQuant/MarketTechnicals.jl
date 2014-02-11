using MarketData

facts("Candlesticks") do

  context("doji") do
    @fact ohlc[findall(doji(ohlc))].timestamp[1] => date(1980, 10, 14)
    @fact ohlc[findall(doji(ohlc))].timestamp[2] => date(1981, 4, 7)
    @fact length(ohlc[findall(doji(ohlc))])      => 5
  end
end
