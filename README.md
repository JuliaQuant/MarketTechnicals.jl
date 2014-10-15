[![Build Status](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl.png)](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl)
[![MarketTechnicals](http://pkg.julialang.org/badges/MarketTechnicals_release.svg)](http://pkg.julialang.org/?pkg=MarketTechnicals&ver=release)

#### A toolkit for technical analysis of financial time series in Julia

Functions include a range of popular studies in TA including candlesticks, price levels,
momentum indicators, moving averages, volatility studies and volume analysis. 

MarketTechnicals supports the TimeArray data structure found in the TimeSeries package. The data structure is lightweight and is
well-suited for technical analysis algorithms. 

## Installation

````julia
julia> Pkg.add("MarketTechnicals")
````
The MarketData package provides `const` objects of price series data based on the TimeArray structure. The package is used in 
testing and benchmarking, but may also be useful prototyping trading signals. 

````julia
julia> Pkg.add("MarketData")
````

## A quick tour of the API 

````julia
julia> using MarketTechnicals, MarketData

julia> findwhen(doji(ohlc))
5-element Array{Date{ISOCalendar},1}:
 1980-10-14
 1981-04-07
 1981-05-08
 1981-06-08
 1981-07-14


julia> ema(cl, 10, wilder=true)
496x1 TimeArray{Float64,1} 1980-01-16 to 1981-12-31

             Close
1980-01-16 | 108.89
1980-01-17 | 109.07
1980-01-18 | 109.27
1980-01-21 | 109.56
...
1981-12-24 | 123.44
1981-12-28 | 123.33
1981-12-29 | 123.16
1981-12-30 | 123.07
1981-12-31 | 123.02

julia> woodiespivots(ohlc)
504x7 TimeArray{Float64,2} 1980-01-04 to 1981-12-31

             s3      s2      s1      pivot   r1      r2      r3
1980-01-04 | 100.99  102.13  103.81  104.94  106.63  107.76  109.45
1980-01-07 | 103.54  104.31  105.53  106.30  107.52  108.29  109.51
1980-01-08 | 103.81  104.81  105.81  106.81  107.81  108.81  109.81
1980-01-09 | 104.45  105.37  107.45  108.37  110.45  111.37  113.45
...
1981-12-24 | 119.30  120.44  121.31  122.45  123.32  124.46  125.33
1981-12-28 | 120.31  120.94  121.80  122.43  123.29  123.92  124.78
1981-12-29 | 119.83  120.78  121.45  122.41  123.08  124.04  124.71
1981-12-30 | 119.00  120.06  120.78  121.84  122.56  123.62  124.34
1981-12-31 | 119.20  120.12  121.27  122.19  123.33  124.26  125.40
````
