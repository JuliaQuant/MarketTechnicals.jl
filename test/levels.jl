using MarketData

facts("Levels") do

    context("floor pivots") do
        @fact floorpivots(ohlc)["r3"].values[1]    => roughly(123.310, atol=.01)              # values verified by various website calculators
        @fact floorpivots(ohlc)["r2"].values[1]    => roughly(119.52, atol=.01) 
        @fact floorpivots(ohlc)["r1"].values[1]    => roughly(115.73, atol=.01) 
        @fact floorpivots(ohlc)["pivot"].values[1] => roughly(108.71, atol=.01) 
        @fact floorpivots(ohlc)["s1"].values[1]    => roughly(104.92, atol=.01) 
        @fact floorpivots(ohlc)["s2"].values[1]    => roughly(97.900, atol=.01) 
        @fact floorpivots(ohlc)["s3"].values[1]    => roughly(94.110, atol=.01) 
        @fact floorpivots(ohlc).timestamp[end]     => Date(2001,12,31)
    end                               
  
    context("woodiespivots") do
  #    #  @fact_approx_eq  97.37500000000001 value(wr4)[2]   # values NEED to be verified with online calculators 
  #    #  @fact_approx_eq   88.62500000000001 value(ws4)[2]  
        @fact woodiespivots(ohlc)["r3"].values[1]    => roughly(124.465, atol=.01)  
        @fact woodiespivots(ohlc)["r2"].values[1]    => roughly(118.480, atol=.01)  
        @fact woodiespivots(ohlc)["r1"].values[1]    => roughly(113.655, atol=.01)  
        @fact woodiespivots(ohlc)["pivot"].values[1] => roughly(107.670, atol=.01)    
        @fact woodiespivots(ohlc)["s1"].values[1]    => roughly(102.845, atol=.01)  
        @fact woodiespivots(ohlc)["s2"].values[1]    => roughly(96.8625, atol=.01)  
        @fact woodiespivots(ohlc)["s3"].values[1]    => roughly(92.035, atol=.01)  
        @fact woodiespivots(ohlc).timestamp[end]     => Date(2001,12,31)
    end
end
