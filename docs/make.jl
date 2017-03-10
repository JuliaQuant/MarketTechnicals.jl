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
    ]
)
