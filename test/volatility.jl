using MarketData

facts("Volatility") do

    context("bollinger_bands") do
        @fact bollingerbands(cl)["up"].values[1]   => roughly(117.3251, atol=.01)      # TTR default uses sample=FALSE and value 117.3251
        @fact bollingerbands(cl)["down"].values[1] => roughly(89.39392, atol=.01)      # TTR default uses sample=FALSE and value 89.39392
        @fact bollingerbands(cl)["mean"].values[1] => roughly(103.3595, atol=.01)      # TTR 103.3595 
        @fact bollingerbands(cl).timestamp[1]      => Date(2000,1,31) 
        @fact bollingerbands(cl).timestamp[end]    => Date(2001,12,31)
    end
  
    context("truerange") do
        @fact truerange(ohlc).values[end]    => roughly(0.83, atol=.01)       # TTR 0.83
        @fact truerange(ohlc).timestamp[end] => Date(2001,12,31)
    end
    
    context("atr") do
        @fact atr(ohlc).values[1]    => roughly(8.343571428571428)   # TTR value 8.343571
        @fact atr(ohlc).values[end]  => roughly(0.9664561242651976)  # TTR value 0.9664561
        @fact atr(ohlc).timestamp[1] => Date(2000,1,24)
    end
   
   #  context("keltner_bands") do
   #      @fact keltnerbands(ohlc)["kma"].values[end] => roughly(21.42)  # needs confirmation 
   #      @fact keltnerbandb(ohlc)["kup"].values[end] => roughly(22.32)  # needs confirmation 
   #      @fact keltnerbands(ohlc)["kdn"].values[end] => roughly(20.52)  # needs confirmation  
   #      @fact keltnerbands(ohlc).timestamp[1]       => Date(2000,1,14)
   #  end
  
   #  context("chaikin_volatility") do
   #     @fact chk => 17.0466 
   #  end
end 
