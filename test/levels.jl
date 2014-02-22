using MarketData

facts("Levels") do

  context("floor pivots") do
    @fact floorpivots(ohlc)["r3"].values[1]    => roughly(108.900)              # values NEED to be verified by various website calculators
    @fact floorpivots(ohlc)["r2"].values[1]    => roughly(107.673) 
    @fact floorpivots(ohlc)["r1"].values[1]    => roughly(106.447) 
    @fact floorpivots(ohlc)["pivot"].values[1] => roughly(104.853) 
    @fact floorpivots(ohlc)["s1"].values[1]    => roughly(103.627) 
    @fact floorpivots(ohlc)["s2"].values[1]    => roughly(102.033) 
    @fact floorpivots(ohlc)["s3"].values[1]    => roughly(100.807) 
    @fact floorpivots(ohlc).timestamp[end]     => lastday
  end                               

  context("woodiespivots") do
#    #  @fact_approx_eq  97.37500000000001 value(wr4)[2]   # values NEED to be verified with online calculators 
#    #  @fact_approx_eq   88.62500000000001 value(ws4)[2]  
    @fact woodiespivots(ohlc)["r3"].values[1]    => roughly(109.450)  
    @fact woodiespivots(ohlc)["r2"].values[1]    => roughly(107.765)  
    @fact woodiespivots(ohlc)["r1"].values[1]    => roughly(106.630)  
    @fact woodiespivots(ohlc)["pivot"].values[1] => roughly(104.945)    
    @fact woodiespivots(ohlc)["s1"].values[1]    => roughly(103.810)  
    @fact woodiespivots(ohlc)["s2"].values[1]    => roughly(102.125)  
    @fact woodiespivots(ohlc)["s3"].values[1]    => roughly(100.990)  
    @fact woodiespivots(ohlc).timestamp[end]       => lastday
  end
end
