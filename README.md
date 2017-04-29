# MarketTechnicals.jl

[![Build Status](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl.svg?branch=master)](https://travis-ci.org/JuliaQuant/MarketTechnicals.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaQuant/MarketTechnicals.jl/badge.svg?branch=master)](https://coveralls.io/r/JuliaQuant/MarketTechnicals.jl?branch=master)
[![MarketTechnicals](http://pkg.julialang.org/badges/MarketTechnicals_0.5.svg)](http://pkg.julialang.org/?pkg=MarketTechnicals&ver=0.5)

A toolkit for technical analysis of financial time series in Julia,
with documentation provided
[here.](http://markettechnicals.readthedocs.org/en/latest/)


## Development Setup

### Documentation

We use `Documenter.jl` as our doc builder, please install it at first.

```julia
Pkg.add("Documenter")
```

Then, build it.

```shell
$ cd docs
$ make
```

The generated doc locates at `docs/build`.
