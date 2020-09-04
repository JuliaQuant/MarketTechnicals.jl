"""
    typical(ohlc; h="High", l="Low", c="Close")

Typical Price

```math
    'text{Typical Price} = frac{H + L + C}{3}'
```
"""
function typical(ohlc::TimeArray{T,N}; h=:High, l=:Low, c=:Close) where {T,N}
    val = (ohlc[h] .+ ohlc[l] .+ ohlc[c]) ./ 3
    TimeArray(timestamp(val), values(val), [:typical], meta(ohlc))
end

function mean_abs_dev(a::AbstractArray{T,1}, scale::Bool=false) where T
    scale ? c = 1 / (-sqrt(2) * erfcinv(3 * 1 / 2)) : c =1

    res = ones(length(a))
    for i in 1:length(a)
        @inbounds res[i] = abs(a[i] - nanmean(a))
    end

    nanmean(res) * c
end

"""
Parameters:
    * orig: the original colnames
    * suffix: the suffix applied to `orig`

```jldoctest
julia> gen_colnames([:Open, :Close], [:macd, :dif, :sig])
6-element Array{Symbol,1}:
 :Open_macd
 :Close_macd
 :Open_dif
 :Close_dif
 :Open_sig
 :Close_sig
```
"""
gen_colnames(orig::Vector{Symbol}, suffix::Vector{Symbol}) =
    vec([Symbol(o, "_", s) for o ∈ orig, s ∈ suffix])

relu(x) = max(x, 0)

relu(ta::TimeArray) =
    TimeArray(timestamp(ta), relu.(values(ta)), colnames(ta), meta(ta))

"""
The smooth method used by ADX
"""
function wilder_smooth(ta::TimeArray, n::Integer;
                       padding::Bool=false, dx::Bool=false)
    val = similar(Array{Float64}, axes(values(ta)))

    first_cal = (dx ? nanmean : nansum)

    ncols = size(val, 2)
    _vals_ta = values(ta)

    for i ∈ 1:size(val, 1)
        if i < n
            val[i, :] .= NaN
        elseif i == n
            _fv = first_cal(values(ta[1:n]))
            val[i, :] = isa(_fv, Number) ? reshape([_fv], (1,ncols)) : _fv
        elseif dx
            _nv = (val[i-1, :] .* (n - 1) .+ _vals_ta[i, :]) ./ n
            _nv[isnan.(_nv)] .= val[i-1, :][isnan.(_nv)]

            val[i, :] = reshape(_nv, (1, ncols))
        else
            _nv = (val[i-1, :] .* (n - 1) ./ n) .+ _vals_ta[i, :]
            _nv[isnan.(_nv)] .= val[i-1, :][isnan.(_nv)]

            val[i, :] = reshape(_nv, (1, ncols))
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


function lagfill(ta::TimeArray, r1::Int, fill::Float64)
    _lta = lag(ta, r1, padding = true)
    _lta_values = values(_lta)
    _lta_values[1:r1] .= fill

    TimeArray(timestamp(ta), _lta_values, colnames(ta))

end

_nanmean(x) = mean(filter(!isnan, x))
nanmean(x; dims = 1) = ndims(x) > 1 ? mapslices(_nanmean, x, dims = dims) : _nanmean(x)

_nansum(x) = sum(filter(!isnan,x))
nansum(x; dims = 1) = ndims(x) > 1 ? mapslices(_nansum, x, dims = dims) : _nansum(x)

_nanstd(x) = std(filter(!isnan,x))
nanstd(x; dims = 1) = ndims(x) > 1 ? mapslices(_nanstd, x, dims = dims) : _nanstd(x)

function nancumsum(x)
	x[isnan.(x)] .= 0
	cumsum(x)
end

function nanargmax(x)
	x[isnan.(x)] .= -Inf
	argmax(x)
end

function nanargmin(x)
	x[isnan.(x)] .= Inf
	argmin(x)
end

function nanmax(x)
	x[isnan.(x)] .= -Inf
	maximum(x)
end

function nanmin(x)
	x[isnan.(x)] .= Inf
	minimum(x)
end
