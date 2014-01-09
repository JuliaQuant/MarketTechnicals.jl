using MarketData, FactCheck  
  
sa   = doji(op,hi,lo,cl)

facts("Candlesticks") do

  context("doji") do
    @fact index(sa[value(sa) .== 1])[1] => date(1980, 10, 14)
    @fact index(sa[value(sa) .== 1])[2] => date(1981, 4, 7)
    @fact index(sa[value(sa) .== 1])[3] => date(1981, 5, 8)
  end

end
