using Documenter
using MarketTechnicals


makedocs(
    format = Documenter.HTML(),
    sitename = "MarketTechnicals.jl",
    modules = [MarketTechnicals],
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
    repo         = "github.com/JuliaQuant/MarketTechnicals.jl.git",
    devbranch    = "master",
    push_preview = true,
)
