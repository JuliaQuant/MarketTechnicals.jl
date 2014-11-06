using MarketData

facts("Volume") do
    context("obv") do
       @pending obv(ohlc).values[1]      => 50480000.00      # TTR value is 50480000
       @pending obv(ohlc).values[end]    => 1145460000.00    # TTR value is 1145460000 
       @pending obv(ohlc).timestamp[end] => Date(2001,12,31)
    end 
  
    context("vwap") do
       @pending vwap(ohlc).values[1]      => roughly(109.0703)  # TTR value 109.0703
       @pending vwap(ohlc).values[end]    => roughly(122.7716)  # TTR value 122.7716
       @pending vwap(ohlc).timestamp[end] => Date(2001,12,31)
    end
end
