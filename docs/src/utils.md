# Utilities

```@setup base
using MarketData
using MarketTechnicals
```

## Typical Price

```@docs
typical
```

```@repl base
merge(ohlc, typical(ohlc))
```
