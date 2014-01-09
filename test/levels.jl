using MarketTechnicals, MarketData, FactCheck 

fr3, fr2, fr1, fp, fs1, fs2, fs3 = floorpivots(hi, lo, cl)
wr3, wr2, wr1, wp, ws1, ws2, ws3 = woodiespivots(op, hi, lo)
  
facts("Levels") do

  context("floor pivots") do
    @fact value(fr3)[2]  => roughly(108.900)              # values NEED to be verified by various website calculators
    @fact value(fr2)[2]  => roughly(107.673) 
    @fact value(fr1)[2]  => roughly(106.447) 
    @fact value(fp)[2]   => roughly(104.853) 
    @fact value(fs1)[2]  => roughly(103.627) 
    @fact value(fs2)[2]  => roughly(102.033) 
    @fact value(fs3)[2]  => roughly(100.807) 
    @fact index(fp)[end] => lastday
  end                               

  context("woodiespivots") do
    #  @fact_approx_eq  97.37500000000001 value(wr4)[2]   # values NEED to be verified with online calculators 
    #  @fact_approx_eq   88.62500000000001 value(ws4)[2]  
    @fact value(wr3)[2]  => roughly(109.450)  
    @fact value(wr2)[2]  => roughly(107.765)  
    @fact value(wr1)[2]  => roughly(106.630)  
    @fact value(wp)[2]   => roughly(104.945)    
    @fact value(ws1)[2]  => roughly(103.810)  
    @fact value(ws2)[2]  => roughly(102.125)  
    @fact value(ws3)[2]  => roughly(100.990)  
    @fact index(wp)[end] => lastday
  end

end
