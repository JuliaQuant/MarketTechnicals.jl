facts("Volume") do

    context("obv") do
        @fact obv(ohlcv).values[1]     --> 4783900 # TTR value is 4783900
        @fact obv(ohlcv).values[12]    --> 9390200 # TTR value is 2000-01-19   9390200
        @fact obv(ohlcv).timestamp[12] --> Date(2000,1,19)
    end

    context("vwap") do
       @fact vwap(ohlcv).values[1]    --> roughly(97.9215, atol=.01)  # TTR value 2000-01-14 97.92154
       @fact vwap(ohlcv).values[end]  --> roughly(21.4446, atol=.01)  # TTR value  21.44458
       @fact vwap(ohlcv).timestamp[1] --> Date(2000,1,14)
    end

    context("adl") do
        ta = adl(ohlcv)
        @fact ta.meta           --> ohlcv.meta
        @fact ta.colnames       --> ["adl"]
        @fact ta.timestamp[1]   --> ohlcv.timestamp[1]
        @fact ta.timestamp[end] --> ohlcv.timestamp[end]
        @fact ta.values[1]      --> roughly(4.2882507863e6, atol=.01)
        @fact ta.values[2]      --> roughly(984498.0822, atol=.01)
    end
end
