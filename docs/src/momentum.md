# Momentum

```@setup base
using MarketData
using MarketTechnicals
```

## ADX

```@docs
adx
```

```@repl base
adx(ohlc)
```

## Aroon Oscillator

```@docs
aroon
```

```@repl base
aroon(ohlc)
```

## RSI

```@docs
rsi
```

```@repl base
rsi(cl)
```

## MACD

```@docs
macd
```

```@repl base
macd(cl)
```

## Chaikin Oscillator

```@docs
chaikinoscillator
```

```@repl base
chaikinoscillator(ohlcv)
```

## CCI

```@docs
cci
```

```@repl base
cci(ohlc)
```

## Rate of Change (ROC)

```@docs
roc
```

```@repl base
roc(cl, 5)
```

## Stochastic Oscillator

```@docs
stochasticoscillator
```

```@repl base
stochasticoscillator(ohlc)
```
