using MarketData

facts("Moving Averages") do

  context("sma") do  
    @fact sma(cl, 10).values[1]      => roughly(108.893)  # TTR value 108.893
    @fact sma(cl, 10).values[2]      => roughly(109.441)  # TTR value 109.441
    @fact sma(cl, 10).values[3]      => roughly(109.896)  # TTR value 109.896
    @fact sma(cl, 10).values[495]    => roughly(122.685)  # TTR value 122.685
    @fact sma(cl, 10).values[496]    => roughly(122.698)  # TTR value 122.698
    @fact sma(cl, 10).timestamp[496] => lastday
  end 
  
  context("ema") do 
    @fact ema(cl, 10).values[1]      => roughly(108.893)   # TTR value 108.8930
    @fact ema(cl, 10).values[2]      => roughly(109.2215)  # TTR value 109.2215
    @fact ema(cl, 10).values[3]      => roughly(109.5576)  # TTR value 109.5576
    @fact ema(cl, 10).values[495]    => roughly(122.7024)  # TTR value 122.7024
    @fact ema(cl, 10).values[496]    => roughly(122.6747)  # TTR value 122.6747
    @fact ema(cl, 10).timestamp[496] => lastday
  end

  context("ema wilder true") do 
    @fact ema(cl, 10, wilder=true).values[1]      => roughly(108.893)   # TTR value 108.8930
    @fact ema(cl, 10, wilder=true).values[2]      => roughly(109.0737)  # TTR value 109.0737
    @fact ema(cl, 10, wilder=true).values[3]      => roughly(109.2733)  # TTR value 109.2733
    @fact ema(cl, 10, wilder=true).values[495]    => roughly(123.0738)  # TTR value 123.0738
    @fact ema(cl, 10, wilder=true).values[496]    => roughly(123.0214)  # TTR value 123.0214
    @fact ema(cl, 10, wilder=true).timestamp[496] => lastday
  end

  context("Array dispatch is correct too") do 
    @fact sma(cl.values, 10)[1]                => roughly(108.893)   # same values as above TimeArray dispatch
    @fact sma(cl.values, 10)[2]                => roughly(109.441)   
    @fact sma(cl.values, 10)[3]                => roughly(109.896)   
    @fact sma(cl.values, 10)[495]              => roughly(122.685)   
    @fact sma(cl.values, 10)[496]              => roughly(122.698)   
    @fact ema(cl.values, 10)[1]                => roughly(108.893)   
    @fact ema(cl.values, 10)[2]                => roughly(109.2215)  
    @fact ema(cl.values, 10)[3]                => roughly(109.5576)  
    @fact ema(cl.values, 10)[495]              => roughly(122.7024)  
    @fact ema(cl.values, 10)[496]              => roughly(122.6747)  
    @fact ema(cl.values, 10, wilder=true)[1]   => roughly(108.893)   
    @fact ema(cl.values, 10, wilder=true)[2]   => roughly(109.0737)  
    @fact ema(cl.values, 10, wilder=true)[3]   => roughly(109.2733)  
    @fact ema(cl.values, 10, wilder=true)[495] => roughly(123.0738)  
    @fact ema(cl.values, 10, wilder=true)[496] => roughly(123.0214)  
  end
end
