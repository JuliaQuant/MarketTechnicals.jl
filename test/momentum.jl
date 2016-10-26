using MarketTechnicals, MarketData, FactCheck 

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
        @fact macd(cl).values[end, 1] --> roughly(0.421, atol=.01) # TTR value with percent=FALSE is 0.421175152
        @fact macd(cl).values[end, 2] --> roughly(0.441, atol=.01) # TTR value with percent=FALSE is 0.4414275
        @fact macd(cl).timestamp[end] --> Date(2001,12,31)
    end
        
     context("cci") do 
        @fact cci(ohlc).values[1]      --> roughly(360.765, atol=01)      # TTR::CCI value is -38.931614
        @fact cci(ohlc).values[end]    --> roughly(44.651, atol=.01)      # TTR::CCI value is 46.3511339
        @fact cci(ohlc).timestamp[end] --> Date(2001,12,31)
     end
end
