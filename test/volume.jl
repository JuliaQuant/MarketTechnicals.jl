using MarketData

facts("Volume") do

  context("obv") do
    @fact obv(ohlc).values[1]      => 50480000.00
    @fact obv(ohlc).values[end]    => 1145460000.00
    @fact obv(ohlc).timestamp[end] => lastday
  end 

  context("vwap") do
#    @fact vwap(hi, lo, cl, vm)[end].value => roughly(122.795)  # TTR value 101.44709
  end

end
