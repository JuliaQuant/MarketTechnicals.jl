using MarketTechnicals, MarketData, FactCheck 

facts("Volume") do

  context("obv") do
    @fact obv(vm)[end].value => 8080000   #manual addition/subtration value of first three volume values
  end 

  context("vwap") do
    @fact vwap(vm)[end].value => 101.44708763647094  # TTR value 101.44709
  end

end
