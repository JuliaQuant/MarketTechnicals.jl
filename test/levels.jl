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
#    @fact value(wr3)[2]  => roughly(109.450)  
#    @fact value(wr2)[2]  => roughly(107.765)  
#    @fact value(wr1)[2]  => roughly(106.630)  
#    @fact value(wp)[2]   => roughly(104.945)    
#    @fact value(ws1)[2]  => roughly(103.810)  
#    @fact value(ws2)[2]  => roughly(102.125)  
#    @fact value(ws3)[2]  => roughly(100.990)  
#    @fact index(wp)[end] => lastday
  end
end
