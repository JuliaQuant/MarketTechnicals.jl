using Documenter
using MarketTechnicals


makedocs(
    format = :html,
    sitename = "MarketTechnicals.jl",
    pages = [
        "index.md",
        "getting_started.md",
        "ma.md",
        "levels.md",
        "momentum.md",
        "volatility.md",
        "volume.md",
        "candlesticks.md",
        "utils.md",
    ]
)

deploydocs(
    repo = "github.com/JuliaQuant/MarketTechnicals.jl.git",
    julia  = "0.5",
    latest = "master",
    target = "build",
    deps = nothing,  # we use the `format = :html`, without `mkdocs`
    make = nothing,  # we use the `format = :html`, without `mkdocs`
)
