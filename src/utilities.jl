doc"""
    typical(ohlc; h="High", l="Low", c="Close")

Typical Price

```math
    \text{Typical Price} = \frac{H + L + C}{3}
```
"""
function typical(ohlc::TimeArray; h="High", l="Low", c="Close")
  val = (ohlc[h] .+ ohlc[l] .+ ohlc[c]) ./ 3
  TimeArray(timestamp(val), values(val), ["typical"], meta(ohlc))
end

function mean_abs_dev(a::Array{T,1}, scale::Bool=false) where T
  scale ? c = 1 / (-sqrt(2) * erfcinv(3 * 1 / 2)) : c =1

  res = ones(length(a))
  for i in 1:length(a)
    @inbounds res[i] = abs(a[i] - mean(a))
  end

  mean(res) * c
end

"""
Parameters:
    * orig: the original colnames
    * suffix: the suffix applied to `orig`

```jldoctest
julia> gen_colnames(["Open", "Close"], ["macd", "dif", "sig"])
6-element Array{String,1}:
 "Open_macd"
 "Close_macd"
 "Open_dif"
 "Close_dif"
 "Open_sig"
 "Close_sig"
```
"""
gen_colnames(orig::Vector, suffix::Vector) =
  vec([Symbol(o, "_", s) for o ∈ orig, s ∈ suffix])

relu(x) = max(x, 0)

relu(ta::TimeArray) =
  TimeArray(timestamp(ta), relu.(values(ta)), colnames(ta), meta(ta))

"""
The soomth method used by ADX
"""
function wilder_smooth(ta::TimeArray, n::Integer;
                       padding::Bool=false, dx::Bool=false)
  val = similar(Array{Float64}, indices(values(ta)))

  first_cal = (dx ? mean : sum)

  for i ∈ 1:size(val, 1)
    val[i, :] =
      if i < n
        NaN
      elseif i == n
        first_cal(ta[1:n].values, 1)
      elseif dx
        (val[i-1, :] .* (n - 1) .+ values(ta)[i, :]) ./ n
      else
        (val[i-1, :] .* (n - 1) ./ n) .+ values(ta)[i, :]
      end
  end

  ret = TimeArray(timestamp(ta), val, colnames(ta), meta(ta))

  if padding
    ret
  else
    dropnan(ret)
  end
end

safediv(x, y) = ifelse(iszero(x) && iszero(y), x, x / y)
