using MarketTechnicals, MarketData, FactCheck 

facts("Volume") do

  context("obv") do
    @fact obv(vm)[end].value => 1.23196e9 
  end 

  context("vwap") do
    @fact vwap(hi, lo, cl, vm)[end].value => roughly(122.795)  # TTR value 101.44709
  end

end
