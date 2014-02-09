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

## A quick tour of the API (coming as soon as the code is written)
