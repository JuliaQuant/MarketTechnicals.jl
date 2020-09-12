@doc raw"""
    obv(ohlcv; price = :Close, v = :Volume)

On Balance Volume

# Formula

```math
\begin{align*}
\text{OBV}_t = \text{OBV_{t - 1} +
  \begin{cases}
    \text{volume}  & \text{if} P^\text{Close}_t > P^\text{Close}_{t-1} \\
      0            & \text{if} P^\text{Close}_t = P^\text{Close}_{t-1} \\
    -\text{volume} & \text{if} P^\text{Close}_t < P^\text{Close}_{t-1}
  \end{cases}
\end{align*}
```
"""
function obv(ohlcv::TimeArray; price = :Close, v = :Volume)
  ret = percentchange(ohlcv[price])
  vol = zeros(length(ohlcv))

  _vol_values = values(ohlcv[v])
  _ret_values = values(ret)

  vol[1] = _vol_values[1]

  for i=2:length(ohlcv)
    if _ret_values[i-1] >= 0
      vol[i] += _vol_values[i]
    else _ret_values[i-1] < 0
      vol[i] -= _vol_values[i]
    end
  end

  TimeArray(timestamp(ohlcv), reshape(nancumsum(vol), (length(timestamp(ohlcv)), 1)), [:obv], meta(ohlcv))
end

"""
    obv_mean(ohlcv; price = :Close, v = :Volume)

On Balance Volume Mean
"""
obv_mean(ohlcv::TimeArray, n::Integer = 10; price = :Close, v = :Volume) =
  moving(nanmean, obv(ohlcv, price = price, v = v), n)

@doc raw"""
    vwap(ohlcv, n = 10; price = :Close, v = :Volume)

Volume Weight-Adjusted Price

# Formula

```math
P = \frac{\sum_j P_j V_j}{\sum_j V_j}
```
"""
function vwap(ohlcv::TimeArray, n::Integer = 10; price = :Close, v = :Volume)
  p   = ohlcv[price]
  q   = ohlcv[v]
  ∑PQ = moving(nansum, p .* q, n)
  ∑Q  = moving(nansum, q, n)
  val = ∑PQ ./ ∑Q

  TimeArray(timestamp(val), values(val), [:vwap], meta(ohlcv))
end

function advance_decline(x)
  #code here
end

function mcclellan_summation(x)
  #code here
end

function williams_ad(x)
  #code here
end

@doc raw"""
    adl(ohlcv; h = :High, l = :Low, c = :Close, v = :Volume)

Accumulation/Distribution Line

Developed by Marc Chaikin.

# Formula

```math
ADL_t = ADL_{t-1} +
    'frac{(Close_t - Low_t) - (High_t - Close_t)}{High_t - Low_t}'
    'times Volume_t'
```

# References

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:accumulation_distribution_line)
"""
function adl(ohlcv::TimeArray; h = :High, l = :Low, c = :Close, v = :Volume)
  _h = ohlcv[h]
  _l = ohlcv[l]
  _c = ohlcv[c]
  _v = ohlcv[v]

  flow_facor = ((_c .- _l) .- (_h .- _c)) ./ (_h .- _l)
  flow_vol = flow_facor .* _v

  _flowvol_values = values(flow_vol)

  vals = similar(_flowvol_values)
  vals[1] = isnan(_flowvol_values[1]) ? 0.0 : _flowvol_values[1]
  for i ∈ 2:length(_flowvol_values)
    vals[i] = vals[i-1] + (isnan(_flowvol_values[i]) ? 0.0 : _flowvol_values[i])
  end

  TimeArray(timestamp(ohlcv), vals, [:adl], meta(ohlcv))
end


"""
Chaikin Money Flow
"""
function chaikinmoneyflow(ohlcv::TimeArray, n::Integer = 10;
                          h = :High, l = :Low, c = :Close, v = :Volume)
  _h = ohlcv[h]
  _l = ohlcv[l]
  _c = ohlcv[c]
  _v = ohlcv[v]

  flow_facor = ((_c .- _l) .- (_h .- _c)) ./ (_h .- _l)
  flow_vol = flow_facor .* _v

  cmf = rename(moving(nansum, flow_vol, n) ./ moving(nansum, _v, n), :cmf)
end


"""
Force Index

It illustrates how strong the actual buying or selling pressure is. High
positive values mean there is a strong rising trend, and low values signify
a strong downward trend.


# References

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:force_index)

"""
function forceindex(ohlcv::TimeArray, n::Integer = 10; c = :Close, v = :Volume)
  _c = ohlcv[c]
  _v = ohlcv[v]

  fi = rename(diff(_c, differences = n) .* diff(_v, differences = n), :fi)
end


"""
Ease of Movement

    It relate an asset's price change to its volume and is particularly useful
    for assessing the strength of a trend.

# References

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Ease_of_movement)
"""
function easeofmovement(ohlcv::TimeArray, n::Integer = 10; v = :Volume, h = :High, l = :Low)
  _h = ohlcv[h]
  _l = ohlcv[l]
  _v = ohlcv[v]

  _emv = (diff(_h) .+ diff(_l)) .* (_h .- _l) ./ (2 .* (_v./100000))
  emv = rename(moving(nanmean, _emv, n), :emv)
end


"""
Volume Price Trend

Is based on a running cumulative volume that adds or substracts a multiple
of the percentage change in share price trend and current volume, depending
upon the investment's upward or downward movements.

# References

- [Wikipedia]
  (https://en.wikipedia.org/wiki/Volume%E2%80%93price_trend)

"""
function volumepricetrend(ohlcv::TimeArray, n::Integer = 10; c = :Close, v = :Volume)
  _c = ohlcv[c]
  _v = ohlcv[v]

  _lagc = lagfill(_c, 1, nanmean(values(_c)))

  _vpt = (_v./100000) .* (_c .- _lagc) ./ _lagc
  _lagvpt = lagfill(_vpt, 1, nanmean(values(_vpt)))

  vpt = rename(_vpt .+ _lagvpt, :vpt)
end
