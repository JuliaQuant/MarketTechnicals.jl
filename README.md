# MarketTechnicals.jl

|                                                                                                  **Documentation**                                                                                                  |                                                                                                                          **Build Status**                                                                                                                          |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaQuant.github.io/MarketTechnicals.jl/stable)[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaQuant.github.io/MarketTechnicals.jl/dev) | [![Build](https://github.com/JuliaQuant/MarketTechnicals.jl/workflows/CI/badge.svg)](https://github.com/JuliaQuant/MarketTechnicals.jl/actions)[![Coverage](https://codecov.io/gh/JuliaQuant/MarketTechnicals.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaQuant/MarketTechnicals.jl) |

A toolkit for technical analysis of financial time series in Julia.

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
