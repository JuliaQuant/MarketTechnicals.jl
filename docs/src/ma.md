# Moving Averages

```@setup base
using MarketData
using MarketTechnicals
```

## Simple Moving Average

```@docs
sma
```

```@repl base
sma(cl, 5)
```

## Exponential Moving Average

```@docs
ema
```

```@repl base
ema(cl, 10, wilder=true)
```

## Kaufman's Adaptive Moving Average

```@docs
kama
```

```@repl base
kama(cl)
```

## Moving Average Envelope

```@docs
env
```

```@repl base
env(cl, 5)
```
