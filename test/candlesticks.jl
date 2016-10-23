using MarketData, TimeSeries

facts("Candlesticks") do

    context("doji") do
        @fact ohlc[find(doji(ohlc))].timestamp[1] --> Date(2000, 5, 30)
        @fact ohlc[find(doji(ohlc))].timestamp[2] --> Date(2000, 12, 11)
        @fact length(ohlc[find(doji(ohlc))])      --> 5
    end
end
