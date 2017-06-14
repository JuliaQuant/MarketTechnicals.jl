### 0.6.0

* Drop 0.4 support (issue #86)

* New indicator:
  * Kaufman's Adaptive Moving Average (issue #76, #83)

  * Kelter Bands (issue #88)

  * Rate of change (ROC) (issue #82)

  * Average Directional Movement Index (ADX) (issue #89)

  * Accumulation/Distribution Line (ADL) (issue #91)

  * Chaikin Oscillator (issue #92)

  * Chaikin Volatility (issue #94)

  * Donchian Channels (issue #95)

* doc: migrate to `Documenter.jl`, and the online doc is available at github
  pages. (issue #63, #58, #69)

* macd: rename original `macd` column to `dif`,
  and add the macd osc bar as `macd`. (issue #71)

* macd: widen to accept multi-column `TimeArray`. (issue #72)

* macd: add wiler option for `ema` calculation. (issue #79)

* rsi: rename the ouput column. (issue #75)

* cci: fix calculation. (issue #84)

### 0.5.0

* support floor of julia 0.5.0

### 0.4.1

* precompilation code added

### 0.4.0

* first version to support Julia 0.4 only

### 0.3.5

* limit support for Julia 0.3 only
* fixes macd, obv and vwap
* turned on tests for volume algorithms

### pre-0.3.5

Not currently documented.
