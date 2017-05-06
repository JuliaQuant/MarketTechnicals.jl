# Moving Averages

## Simple Moving Average

```@docs
sma
```

```@repl
using MarketData
using MarketTechnicals

sma(cl, 5)
```

## Exponential Moving Average

```@docs
ema
```

```@repl
using MarketData
using MarketTechnicals

ema(cl, 10, wilder=true)
```
