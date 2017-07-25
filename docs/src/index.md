# MarketTechnicals Overview

The MarketTechnicals package provides common technical analysis algorithms
for financial time series.

## Naming Convention

This package names its method by spelling out the entire name without
camel casing or underscores, which is typical for the Julia programming
language. In special cases where an abbreviation is widely recognized,
it is used instead. For example, the `rsi`, `cci` and `adx` methods are
abbreviated while `chaikinvolatility` is spelled out.

For those who find this naming convention too cumbersome, an
`src/.rc.jl` file is provided. It has been added to the `.gitignore` file so
whatever modifications or customizations you make there will not be corrupted
with each package update.
An example of using this to rename methods would be to include the following
line:

```julia
export cvola

cvola = chaikinvolatility
```

## Contents

```@contents
Pages = [
    "getting_started.md",
    "ma.md",
    "levels.md",
    "momentum.md",
    "volatility.md",
    "volume.md",
    "candlesticks.md",
    "utils.md",
]
```
