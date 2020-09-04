# Moving Averages

## Simple Moving Average

```@docs
sma
```

```@setup
using MarketTechnicals
using MarketData
```

```@repl
sma(cl, 5)
```

## Exponential Moving Average

```@docs
ema
```

```@repl
ema(cl, 10, wilder=true)
```

## Kaufman's Adaptive Moving Average

```@docs
kama
```


```@repl
kama(cl)
```

## Moving Average Envelope

```@docs
env
```

```@repl
env(cl, 5)
```
