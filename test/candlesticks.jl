facts("Candlesticks") do

  context("doji") do
    @fact whentrue(doji(ohlc))[1]      => date(1980, 10, 14)
    @fact whentrue(doji(ohlc))[2]      => date(1981, 4, 7)
    @fact length(whentrue(doji(ohlc))) => 5
  end
end
