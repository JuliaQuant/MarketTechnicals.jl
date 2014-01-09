using MarketData, FactCheck 

fr3, fr2, fr1, fp, fs1, fs2, fs3 = floorpivots(hi, lo, cl)
wr3, wr2, wr1, wp, ws1, ws2, ws3 = woodiespivots(op, hi, lo)
  
facts("Levels") do

  context("floor pivots") do
    @fact  108.900 => roughly(value(fr3)[2])              # values NEED to be verified by various website calculators
    @fact  107.673 => roughly(value(fr2)[2]) 
    @fact  106.447 => roughly(value(fr1)[2]) 
    @fact  104.853 => roughly(value(fp)[2])
    @fact  103.627 => roughly(value(fs1)[2]) 
    @fact  102.033 => roughly(value(fs2)[2]) 
    @fact  100.807 => roughly(value(fs3)[2]) 
  end                               

  context("woodiespivots") do
 
    #  @fact_approx_eq  97.37500000000001 value(wr4)[2]   # values NEED to be verified with online calculators 
    #  @fact_approx_eq   88.62500000000001 value(ws4)[2]  
 
    @fact  109.450 => roughly(value(wr3)[2])  
    @fact  107.765 => roughly(value(wr2)[2])  
    @fact  106.630 => roughly(value(wr1)[2])  
    @fact  104.945 => roughly(value(wp)[2])   
    @fact  103.810 => roughly(value(ws1)[2])  
    @fact  102.125 => roughly(value(ws2)[2])  
    @fact  100.990 => roughly(value(ws3)[2])  
    @fact index(p)[end]               => lastday
  end
end
