using MarketData

facts("Moving averages on TimeArrays") do

    context("sma") do  
        @fact sma(cl, 10).values[1]        --> roughly(98.782, atol=.01)  # TTR value 98.782
        @fact sma(cl, 10).values[2]        --> roughly(97.982, atol=.01)  # TTR value 97.982
        @fact sma(cl, 10).values[3]        --> roughly(98.388, atol=.01)  # TTR value 98.388
        @fact sma(cl, 10).values[490]      --> roughly(21.266, atol=.01)  # TTR value 21.266
        @fact sma(cl, 10).values[491]      --> roughly(21.417, atol=.01)  # TTR value 21.417
        @fact sma(cl, 10).timestamp[491]   --> Date(2001,12,31)
        @fact sma(ohlc, 10).values[1,:]    --> roughly([100.692, 103.981, 96.001, 98.782] , atol=.01)  # TTR value 98.782
        @fact sma(ohlc, 10).values[2,:]    --> roughly([100.304, 103.331, 95.876, 97.982], atol=.01)  # TTR value 97.982
        @fact sma(ohlc, 10).values[3,:]    --> roughly([100.041, 103.144, 96.095,98.388], atol=.01)  # TTR value 98.388
        @fact sma(ohlc, 10).values[490,:]  --> roughly([21.081, 21.685, 20.797, 21.266], atol=.01)  # TTR value 21.266
        @fact sma(ohlc, 10).values[491,:]  --> roughly([21.259, 21.868, 20.971, 21.417], atol=.01)  # TTR value 21.417
        @fact sma(ohlc, 10).timestamp[491] --> Date(2001,12,31)
    end 
    
    context("ema") do 
        @fact ema(cl, 10).values[1]        --> roughly(98.782, atol=.01)   # TTR value 98.78200
        @fact ema(cl, 10).values[2]        --> roughly(99.719, atol=.01)   # TTR value 99.71982
        @fact ema(cl, 10).values[3]        --> roughly(100.963, atol=.01)  # TTR value 100.96349
        @fact ema(cl, 10).values[490]      --> roughly(21.585, atol=.01)   # TTR value 21.58580
        @fact ema(cl, 10).values[491]      --> roughly(21.642, atol=.01)   # TTR value 21.64293
        @fact ema(cl, 10).timestamp[491]   --> Date(2001,12,31)
        @fact ema(ohlc, 10).values[1,:]    --> roughly([100.692, 103.981, 96.001, 98.782], atol=.01)   # TTR value 98.78200
        @fact ema(ohlc, 10).values[2,:]    --> roughly([100.748, 104.348, 96.808, 99.719], atol=.01)   # TTR value 99.71982
        @fact ema(ohlc, 10).values[3,:]    --> roughly([101.634, 105.148, 98.003, 100.963], atol=.01)  # TTR value 100.96349
        @fact ema(ohlc, 10).values[490,:]  --> roughly([21.369, 22.030, 21.125, 21.585], atol=.01)   # TTR value 21.58580
        @fact ema(ohlc, 10).values[491,:]  --> roughly([21.576, 22.145, 21.253, 21.642], atol=.01)   # TTR value 21.64293
        @fact ema(ohlc, 10).timestamp[491] --> Date(2001,12,31)
    end
  
    context("ema wilder true") do 
        @fact ema(cl, 10, wilder=true).values[1]        --> roughly(98.782, atol=.01)  # TTR value 98.7820
        @fact ema(cl, 10, wilder=true).values[2]        --> roughly(99.297, atol=.01)  # TTR value 99.2978
        @fact ema(cl, 10, wilder=true).values[3]        --> roughly(100.024, atol=.01)  # TTR value 100.0240
        @fact ema(cl, 10, wilder=true).values[490]      --> roughly(21.345, atol=.01)  # TTR value 21.34556
        @fact ema(cl, 10, wilder=true).values[491]      --> roughly(21.401, atol=.01)  # TTR value 21.40100
        @fact ema(cl, 10, wilder=true).timestamp[491]   --> Date(2001,12,31)
        @fact ema(ohlc, 10, wilder=true).values[1,:]    --> roughly([100.692, 103.981, 96.001, 98.782], atol=.01)  # TTR value 98.7820
        @fact ema(ohlc, 10, wilder=true).values[2,:]    --> roughly([100.723, 104.183, 96.444, 99.297], atol=.01)  # TTR value 99.2978
        @fact ema(ohlc, 10, wilder=true).values[3,:]    --> roughly([101.213, 104.64, 97.138, 100.024], atol=.01)  # TTR value 100.0240
        @fact ema(ohlc, 10, wilder=true).values[490,:]  --> roughly([21.184, 21.776, 20.847, 21.345], atol=.01)  # TTR value 21.34556
        @fact ema(ohlc, 10, wilder=true).values[491,:]  --> roughly([21.317, 21.865, 20.945, 21.401], atol=.01)  # TTR value 21.40100
        @fact ema(ohlc, 10, wilder=true).timestamp[491] --> Date(2001,12,31)
    end
end

facts("Moving averages on arrays") do
    
    context("Array dispatch on sma") do 
        @fact sma(cl.values, 10)[1]       --> roughly(98.782, atol=.01)   # same values as above TimeArray dispatch
        @fact sma(cl.values, 10)[2]       --> roughly(97.982, atol=.01)   
        @fact sma(cl.values, 10)[3]       --> roughly(98.388, atol=.01)   
        @fact sma(cl.values, 10)[490]     --> roughly(21.266, atol=.01)   
        @fact sma(cl.values, 10)[491]     --> roughly(21.417, atol=.01)   
        @fact sma(ohlc.values, 10)[1,:]   --> roughly([100.692, 103.981, 96.001, 98.782] , atol=.01)  # TTR value 98.782
        @fact sma(ohlc.values, 10)[2,:]   --> roughly([100.304, 103.331, 95.876, 97.982], atol=.01)  # TTR value 97.982
        @fact sma(ohlc.values, 10)[3,:]   --> roughly([100.041, 103.144, 96.095,98.388], atol=.01)  # TTR value 98.388
        @fact sma(ohlc.values, 10)[490,:] --> roughly([21.081, 21.685, 20.797, 21.266], atol=.01)  # TTR value 21.266
        @fact sma(ohlc.values, 10)[491,:] --> roughly([21.259, 21.868, 20.971, 21.417], atol=.01)  # TTR value 21.417
    end 
    
    context("Array dispatch on ema") do 
        @fact ema(cl.values, 10)[1]        --> roughly(98.782, atol=.01)   
        @fact ema(cl.values, 10)[2]        --> roughly(99.719, atol=.01)  
        @fact ema(cl.values, 10)[3]        --> roughly(100.963, atol=.01) 
        @fact ema(cl.values, 10)[490]      --> roughly(21.585, atol=.01)  
        @fact ema(cl.values, 10)[491]      --> roughly(21.642, atol=.01)  
        @fact ema(ohlc, 10).values[1,:]    --> roughly([100.692, 103.981, 96.001, 98.782], atol=.01)   # TTR value 98.78200
        @fact ema(ohlc, 10).values[2,:]    --> roughly([100.748, 104.348, 96.808, 99.719], atol=.01)   # TTR value 99.71982
        @fact ema(ohlc, 10).values[3,:]    --> roughly([101.634, 105.148, 98.003, 100.963], atol=.01)  # TTR value 100.96349
        @fact ema(ohlc, 10).values[490,:]  --> roughly([21.369, 22.030, 21.125, 21.585], atol=.01)   # TTR value 21.58580
        @fact ema(ohlc, 10).values[491,:]  --> roughly([21.576, 22.145, 21.253, 21.642], atol=.01)   # TTR value 21.64293
        @fact ema(ohlc, 10).timestamp[491] --> Date(2001,12,31)
    end

    context("Array dispatch on ema wilder true") do 
        @fact ema(cl.values, 10, wilder=true)[1]       --> roughly(98.782, atol=.01)
        @fact ema(cl.values, 10, wilder=true)[2]       --> roughly(99.297, atol=.01)  
        @fact ema(cl.values, 10, wilder=true)[3]       --> roughly(100.024, atol=.01)  
        @fact ema(cl.values, 10, wilder=true)[490]     --> roughly(21.345, atol=.01)  
        @fact ema(cl.values, 10, wilder=true)[491]     --> roughly(21.401, atol=.01)  
        @fact ema(ohlc.values, 10, wilder=true)[1,:]   --> roughly([100.692, 103.981, 96.001, 98.782], atol=.01)  # TTR value 98.7820
        @fact ema(ohlc.values, 10, wilder=true)[2,:]   --> roughly([100.723, 104.183, 96.444, 99.297], atol=.01)  # TTR value 99.2978
        @fact ema(ohlc.values, 10, wilder=true)[3,:]   --> roughly([101.213, 104.64, 97.138, 100.024], atol=.01)  # TTR value 100.0240
        @fact ema(ohlc.values, 10, wilder=true)[490,:] --> roughly([21.184, 21.776, 20.847, 21.345], atol=.01)  # TTR value 21.34556
        @fact ema(ohlc.values, 10, wilder=true)[491,:] --> roughly([21.317, 21.865, 20.945, 21.401], atol=.01)  # TTR value 21.40100
    end
end
