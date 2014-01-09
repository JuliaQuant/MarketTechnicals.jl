[![Build Status](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl.png)](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl)

#### A toolkit for technical analysis of financial time series in Julia

Functions include a range of popular studies in TA including candlesticks, price levels,
momentum indicators, moving averages, volatility studies and volume analysis. 

````julia
julia> Pkg.add("MarketTechnicals")
julia> Pkg.checkout("MarketTechnicals", "dataframes") # package defaults to support for Series
````

This is a work in progress and the API is not fixed.~~ The current plan is to implement the semantics
that the function name (e.g. `bollinger_bands`) will produce a copy of the `DataFrame` passed into it.
This will require the user to assign a variable to the "new" DataFrame. The semantics of the function 
bang version (e.g. `bollinger_bands!`) will modify the `DataFrame` being passed into it and return it.~~

There are two functions for whom the semantics will be unique and those include `ema` and `sma`. The 
reasoning is that these functions are called in many of the technical studies and serve a special 
purpose.

## Contributions are welcome! 

If you'd like to implement a function not in this package, such as the `Ulcer Index`, then pull 
requests are welcome. Feel free to copy and paste an existing function to use as a template for your
new function. Also, include some test assertions that provide users with some confidence that your
implementation is correct. Test suites are stored in the `/test` directory and are grouped into
a few general files such as `candlesticks.jl`, etc.

You can run the entire test suite from within Julia:

````julia
julia> @markettechnicals
Running tests: 
**   test/candlesticks.jl
**   test/levels.jl
**   test/momo.jl
**   test/movingaverages.jl
**   test/volatility.jl
**   test/volume.jl
````

The current test suite passes silently and stops completely if an error is detected. Expect improvements to 
this interface in the future. 

## Important near-term goals

Since TA functions can be implemented in different ways, a github web page is planned to document how the 
implementations in `MarketTechnicals` are handled. This will include references and credits as appropriate. 
