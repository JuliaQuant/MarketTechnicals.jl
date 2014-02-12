using MarketData

facts("Moving Averages") do

  context("sma") do  
    @fact sma(cl, 10).values[1]      => roughly(108.893)  # TTR value
    @fact sma(cl, 10).values[2]      => roughly(109.441)  # TTR value
    @fact sma(cl, 10).values[3]      => roughly(109.896)  # TTR value
    @fact sma(cl, 10).values[495]    => roughly(122.685)  # TTR value
    @fact sma(cl, 10).values[496]    => roughly(122.698)  # TTR value
    @fact sma(cl, 10).timestamp[496] => lastday
  end 
  
  context("ema") do 
    @fact ema(cl, 10).values[1]      => roughly(108.893)   # TTR value
    @fact ema(cl, 10).values[2]      => roughly(109.2215)  # TTR value
    @fact ema(cl, 10).values[3]      => roughly(109.5576)  # TTR value
    @fact ema(cl, 10).values[495]    => roughly(122.7024)  # TTR value
    @fact ema(cl, 10).values[496]    => roughly(122.6747)  # TTR value
    @fact ema(cl, 10).timestamp[496] => lastday
  end

  context("ema wilder true") do 
    @fact ema(cl, 10, wilder=true).values[1]      => roughly(108.893)   # TTR value
    @fact ema(cl, 10, wilder=true).values[2]      => roughly(109.0737)  # TTR value
    @fact ema(cl, 10, wilder=true).values[3]      => roughly(109.2733)  # TTR value
    @fact ema(cl, 10, wilder=true).values[495]    => roughly(123.0738)  # TTR value
    @fact ema(cl, 10, wilder=true).values[496]    => roughly(123.0214)  # TTR value
    @fact ema(cl, 10, wilder=true).timestamp[496] => lastday
  end

  context("Array dispatch is correct too") do 
    @fact sma(cl.values, 10)[1]                => roughly(108.893)   # TTR value
    @fact sma(cl.values, 10)[2]                => roughly(109.441)   # TTR value
    @fact sma(cl.values, 10)[3]                => roughly(109.896)   # TTR value
    @fact sma(cl.values, 10)[495]              => roughly(122.685)   # TTR value
    @fact sma(cl.values, 10)[496]              => roughly(122.698)   # TTR value
    @fact ema(cl.values, 10)[1]                => roughly(108.893)   # TTR value
    @fact ema(cl.values, 10)[2]                => roughly(109.2215)  # TTR value
    @fact ema(cl.values, 10)[3]                => roughly(109.5576)  # TTR value
    @fact ema(cl.values, 10)[495]              => roughly(122.7024)  # TTR value
    @fact ema(cl.values, 10)[496]              => roughly(122.6747)  # TTR value
    @fact ema(cl.values, 10, wilder=true)[1]   => roughly(108.893)   # TTR value
    @fact ema(cl.values, 10, wilder=true)[2]   => roughly(109.0737)  # TTR value
    @fact ema(cl.values, 10, wilder=true)[3]   => roughly(109.2733)  # TTR value
    @fact ema(cl.values, 10, wilder=true)[495] => roughly(123.0738)  # TTR value
    @fact ema(cl.values, 10, wilder=true)[496] => roughly(123.0214)  # TTR value
  end
end
