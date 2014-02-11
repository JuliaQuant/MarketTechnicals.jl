[![Build Status](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl.png)](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl)

#### A toolkit for technical analysis of financial time series in Julia

Functions include a range of popular studies in TA including candlesticks, price levels,
momentum indicators, moving averages, volatility studies and volume analysis. 

## Notice of change to API 

MarketTechnicals will support the TimeArray data structure found in the TimeSeries package. The data structure is lightweight and is
suited for technical analysis algorithms. 

## Installation

````julia
julia> Pkg.add("MarketTechnicals")
````
The un-registered MarketData package provides `const` objects of price series data based on the TimeArray structure. The package is used in 
testing and benchmarking, but may also be useful prototyping trading signals. 

````julia
julia> Pkg.clone("git://github.com/JuliaQuant/MarketData.jl.git")
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

````
