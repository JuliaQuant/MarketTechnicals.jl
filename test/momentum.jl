facts("Momentum") do

    context("rsi") do
        @fact rsi(cl).values[end]              --> roughly(55.849, atol=.01) # TTR value is 55.84922
        @fact rsi(cl, wilder=true).values[end] --> roughly(55.959, atol=.01) # TTR value is 55.95932
        @fact rsi(cl, 10).values[end]          --> roughly(56.219, atol=.01) # TTR value is 56.21947
        @fact rsi(ohlc).values[end,:]          --> roughly([68.030, 61.872, 70.062, 55.849], atol=.01)

        # seed is included (TODO: debate amongst yourselves)
        @fact rsi(cl).timestamp[1]              --> Date(2000,1,21)
        @fact rsi(cl, wilder=true).timestamp[1] --> Date(2000,1,21)
        @fact rsi(cl, 10).timestamp[1]          --> Date(2000,1,14)
        @fact rsi(ohlc).timestamp[1]            --> Date(2000,1,21)

        @fact rsi(cl).timestamp[end]              --> Date(2001,12,31)
        @fact rsi(cl, wilder=true).timestamp[end] --> Date(2001,12,31)
        @fact rsi(cl, 10).timestamp[end]          --> Date(2001,12,31)
        @fact rsi(ohlc).timestamp[end]            --> Date(2001,12,31)
    end

    context("macd") do
        @fact macd(cl).values[end, 1] --> roughly(-0.020, atol=.01)
        @fact macd(cl).values[end, 2] --> roughly(0.421, atol=.01) # TTR value with percent=FALSE is 0.421175152
        @fact macd(cl).values[end, 3] --> roughly(0.441, atol=.01) # TTR value with percent=FALSE is 0.4414275
        @fact macd(cl).timestamp[end] --> Date(2001,12,31)
    end

    context("macd multi-column TimeArray") do
        # multi-column TimeArray
        # TTR: MACD(..., maType="EMA", percent=0)
        ta = macd(ohlc["Open", "Close"])
        @fact ta.colnames[1:2]        --> ["Open_macd", "Close_macd"]
        @fact ta.values[end, 3]       --> roughly(0.44254569, atol=.01)    # Open_dif
        @fact ta.values[end, 5]       --> roughly(4.536854e-01, atol=.01)  # Open_signal
        @fact ta.values[end, 4]       --> roughly(0.421175152, atol=.01)   # Close_dif
        @fact ta.values[end, 6]       --> roughly(4.414275e-01, atol=.01)  # Close_signal
        @fact ta.timestamp[end]       --> Date(2001, 12, 31)
    end

     context("cci") do
        # TTR::CCI value is -38.931614
        @fact cci(ohlc).values[1]      --> roughly(-38.931614, atol=.01)
        # TTR::CCI value is 46.3511339
        @fact cci(ohlc).values[end]    --> roughly(46.3511339, atol=.01)
        @fact cci(ohlc).timestamp[end] --> Date(2001, 12, 31)
     end

    context("roc") do
        ta = roc(cl, 3)
        @fact ta.colnames      --> ["Close_roc_3"]
        @fact ta.values[1]     --> roughly(-0.15133107021618722, atol=.01)
        @fact ta.values[2]     --> roughly(-0.02926829268292683, atol=.01)
        @fact ta.values[3]     --> roughly(-0.06009615384615385, atol=.01)
    end

    context("adx") do
        ta = adx(ohlc)
        @fact ta.colnames     --> ["adx", "dx", "+di", "-di"]
        @fact ta.values[1, 1] --> roughly(10.5998, atol=.01)
        @fact ta.values[1, 2] --> roughly(0.3916,  atol=.01)
        @fact ta.values[1, 3] --> roughly(23.6226, atol=.01)
        @fact ta.values[1, 4] --> roughly(23.4383, atol=.01)
        @fact ta.timestamp[1] --> Date(2000, 2, 10)
    end

    context("stochastic osc") do
        """
        Quote from TTR
        > stoch(x[, c("High", "Low", "Close")], maType=SMA)
                     fastK      fastD      slowD
         [18,] 0.671428571 0.69466667 0.67441270
         [19,] 0.432000000 0.59342857 0.64901587
         [20,] 0.492857143 0.53209524 0.60673016
         [21,] 0.392857143 0.43923810 0.52158730
         [22,] 0.217586207 0.36776683 0.44636672
         [23,] 0.326296296 0.31224655 0.37308382
         [24,] 0.500000000 0.34796083 0.34265807
         [25,] 0.724444444 0.51691358 0.39237365
         [26,] 0.754814815 0.65975309 0.50820917
         [27,] 0.801061008 0.76010676 0.64559114
         [28,] 0.839964633 0.79861349 0.73949111
        """
        ta = stoch_osc(ohlc)
        @fact ta.colnames     --> ["fast_k", "fast_d", "slow_d"]
        @fact ta.timestamp    --> ohlc[18:end].timestamp
        @fact ta.values[1, 1] --> roughly(67.142857, atol=.01)
        @fact ta.values[1, 2] --> roughly(69.466667, atol=.01)
        @fact ta.values[1, 3] --> roughly(67.441270, atol=.01)
    end
end
