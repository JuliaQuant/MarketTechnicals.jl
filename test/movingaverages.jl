facts("Moving Averages") do

  context("sma") do  
    @fact value(sma(cl, 10))[1]   => roughly(108.893)
    @fact sma(value(cl), 10)[1]   => roughly(108.893)
    @fact value(sma(cl, 10))[end] => roughly(122.698)
    @fact sma(value(cl), 10)[end] => roughly(122.698)
    @fact index(sma(cl, 10))[end] => lastday
  end
  
  context("ema") do 
    @fact value(ema(cl, 10))[1]                => roughly(108.893)
    @fact ema(value(cl), 10)[1]                => roughly(108.893)
    @fact value(ema(cl, 10))[end]              => roughly(122.675)
    @fact ema(value(cl), 10)[end]              => roughly(122.675)
    @fact value(ema(cl, 10, wilder=true))[end] => roughly(123.021) # TTR  99.72706
    @fact index(ema(cl, 10))[end]              => lastday
  end
end
