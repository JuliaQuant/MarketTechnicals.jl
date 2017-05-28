doc"""
    typical(ohlc; h="High", l="Low", c="Close")

Typical Price

```math
    \text{Typical Price} = \frac{H + L + C}{3}
```
"""
function typical{T,N}(ohlc::TimeArray{T,N}; h="High", l="Low", c="Close")
    val = (ohlc[h] .+ ohlc[l] .+ ohlc[c]) ./ 3
    TimeArray(val.timestamp, val.values, ["typical"], ohlc.meta)
end

function mean_abs_dev{T}(a::Array{T,1}, scale::Bool=false)
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
function gen_colnames(orig::Vector{String}, suffix::Vector{String})
   vec(["$o\_$s" for o ∈ orig, s ∈ suffix])
end

gen_colnames(orig::Vector{String}, suffix::String) = gen_colnames(orig, [suffix])

function add_padding_call(expr::Expr)
    if expr.head != :call
        return [add_padding_call(arg) for arg ∈ expr.args if isa(arg, Expr)]
    end

    func = expr.args[1]
    if func ∈ (:diff, :lag, :lead, :moving, :percentchange)
        push!(expr.args, Expr(:kw, :padding, :padding))
    end

    return [add_padding_call(arg)
            for arg ∈ expr.args[2:end-1] if isa(arg, Expr)]
end

"""
This macro will append a keyword argument `padding=true` to
function parameters, and append `padding` to all related call
in function body. For the listed related call, please check out
`add_padding_call`.

e.g.

```
@padding function f(ta, n)
    ...
    moving(...)
    ...
    lag(...)
    ...
end
```

will make `f` compiled as following

```
function sma(ta, n; padding=false)
    ...
    moving(..., padding=padding)
    ....
    lag(..., padding=padding)
    ...
end
```

"""
macro padding(f)
    @assert f.head == :function

    # add :padding keyword argument in function signature
    params_ast = f.args[1]
    kw_node = Expr(:kw, :padding, false)

    if (length(params_ast.args) < 2) || (params_ast.args[2].head != :parameters)
        insert!(params_ast.args, 2, Expr(:parameters, kw_node))
    else
        push!(params_ast.args[2], kw_node)
    end

    add_padding_call(f.args[2])
    return f
end
