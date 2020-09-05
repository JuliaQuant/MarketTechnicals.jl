# Volatility

```@setup base
using MarketData
using MarketTechnicals
```

## Average True Range

```@docs
atr
```

```@repl base
atr(ohlc)
```

## Bollinger Bands

```@docs
bollingerbands
```

```@repl base
bollingerbands(cl)
```

## Chaikin Volatility

```@docs
chaikinvolatility
```

```@repl base
chaikinvolatility(ohlc)
```

## Donchian Channels

```@docs
donchianchannels
```

```@repl base
donchianchannels(ohlc)
```

## Keltner Bands

```@docs
keltnerbands
```

```@repl base
keltnerbands(ohlc)
```

## True Range

```@docs
truerange
```

```@repl base
truerange(ohlc)
```
