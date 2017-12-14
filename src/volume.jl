doc"""
    obv(ohlcv; price="Close", v="Volume")

On Balance Volume

```math
    OBV_t = OBV_{t - 1} +
        \begin{cases}
            volume  & \text{if} \ close_t > close_{t-1} \\
            0       & \text{if} \ close_t = close_{t-1} \\
            -volume & \text{if} \ close_t < close_{t-1}
        \end{cases}
```

"""
function obv(ohlcv::TimeArray{T,N}; price="Close", v="Volume") where {T,N}

    ret    = percentchange(ohlcv[price])
    vol    = zeros(length(ohlcv))
    vol[1] = ohlcv[v].values[1]

    for i=2:length(ohlcv)
      if ret.values[i-1] >= 0
        vol[i] += ohlcv[v].values[i]
      else
        vol[i] -= ohlcv[v].values[i]
      end
    end

    TimeArray(ohlcv.timestamp, cumsum(vol), ["obv"], ohlcv.meta)
end

doc"""
    vwap(ohlcv, n; price="Close", v="Volume")

Volume Weight-Adjusted Price

```math
    P = \frac{\sum_j P_j Q_j}{\sum_j Q_j} \ ,\text{where Q is the volume}
```

"""
function vwap(ohlcv::TimeArray{T,N}, n::Int; price="Close", v="Volume") where {T,N}
    p   = ohlcv[price]
    q   = ohlcv[v]
    ∑PQ = moving(sum, p .* q, n)
    ∑Q  = moving(sum, q, n)
    val = ∑PQ ./ ∑Q

    TimeArray(val.timestamp, val.values, ["vwap"], ohlcv.meta)
end

vwap(ohlcv::TimeArray{T,N}) where {T,N} = vwap(ohlcv, 10)

function advance_decline(x)
    #code here
end

function mcclellan_summation(x)
    #code here
end

function williams_ad(x)
    #code here
end

doc"""
    adl(ohlcv; h="High", l="Low", c="Close", v="Volume")

**Accumulation/Distribution Line**

Developed by Marc Chaikin.

**Formula**

```math
    ADL_t = ADL_{t-1} +
        \frac{(Close_t - Low_t) - (High_t - Close_t)}{High_t - Low_t}
        \times Volume_t
```

**Reference**

- [StockCharts]
  (http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:accumulation_distribution_line)
"""
function adl(ohlcv::TimeArray; h="High", l="Low", c="Close", v="Volume")
    _h = ohlcv[h]
    _l = ohlcv[l]
    _c = ohlcv[c]
    _v = ohlcv[v]

    flow_facor = ((_c .- _l) .- (_h .- _c)) ./ (_h .- _l)
    flow_vol = flow_facor .* _v

    vals = similar(flow_vol.values)
    vals[1] = flow_vol.values[1]
    for i ∈ 2:length(flow_vol.values)
        vals[i] = vals[i-1] + flow_vol.values[i]
    end

    TimeArray(ohlcv.timestamp, vals, ["adl"], ohlcv.meta)
end
