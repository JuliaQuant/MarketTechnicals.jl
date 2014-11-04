using MarketData

facts("Moving Averages") do

    context("sma") do  
        @fact sma(cl, 10).values[1]      => roughly(98.782)  # TTR value 98.782
        @fact sma(cl, 10).values[2]      => roughly(97.982)  # TTR value 97.982
        @fact sma(cl, 10).values[3]      => roughly(98.388)  # TTR value 98.388
        @fact sma(cl, 10).values[490]    => roughly(21.266)  # TTR value 21.266
        @fact sma(cl, 10).values[491]    => roughly(21.417)  # TTR value 21.417
        @fact sma(cl, 10).timestamp[491] => Date(2001,12,31)
    end 
    
    context("ema") do 
        @fact ema(cl, 10).values[1]      => roughly(98.78200)   # TTR value 98.78200
        @fact ema(cl, 10).values[2]      => roughly(99.71982)   # TTR value 99.71982
        @fact ema(cl, 10).values[3]      => roughly(100.96349)  # TTR value 100.96349
        @fact ema(cl, 10).values[490]    => roughly(21.58580)   # TTR value 21.58580
        @fact ema(cl, 10).values[491]    => roughly(21.64293)   # TTR value 21.64293
        @fact ema(cl, 10).timestamp[491] => Date(2001,12,31)
    end
  
    context("ema wilder true") do 
        @fact ema(cl, 10, wilder=true).values[1]      => roughly(98.7820)  # TTR value 98.7820
        @fact ema(cl, 10, wilder=true).values[2]      => roughly(99.2978)  # TTR value 99.2978
        @fact ema(cl, 10, wilder=true).values[3]      => roughly(100.0240)  # TTR value 100.0240
        @fact ema(cl, 10, wilder=true).values[490]    => roughly(21.34556)  # TTR value 21.34556
        @fact ema(cl, 10, wilder=true).values[491]    => roughly(21.40100)  # TTR value 21.40100
        @fact ema(cl, 10, wilder=true).timestamp[491] => Date(2001,12,31)
    end
  
    context("Array dispatch is correct too") do 
        @fact sma(cl.values, 10)[1]                => roughly(98.782)   # same values as above TimeArray dispatch
        @fact sma(cl.values, 10)[2]                => roughly(97.982)   
        @fact sma(cl.values, 10)[3]                => roughly(98.388)   
        @fact sma(cl.values, 10)[490]              => roughly(21.266)   
        @fact sma(cl.values, 10)[491]              => roughly(21.417)   
        @fact ema(cl.values, 10)[1]                => roughly(98.78200)   
        @fact ema(cl.values, 10)[2]                => roughly(99.71982)  
        @fact ema(cl.values, 10)[3]                => roughly(100.96349) 
        @fact ema(cl.values, 10)[490]              => roughly(21.58580)  
        @fact ema(cl.values, 10)[491]              => roughly(21.64293)  
        @fact ema(cl.values, 10, wilder=true)[1]   => roughly(98.7820)
        @fact ema(cl.values, 10, wilder=true)[2]   => roughly(99.2978)  
        @fact ema(cl.values, 10, wilder=true)[3]   => roughly(100.0240)  
        @fact ema(cl.values, 10, wilder=true)[490] => roughly(21.34556)  
        @fact ema(cl.values, 10, wilder=true)[491] => roughly(21.40100)  
    end
end
