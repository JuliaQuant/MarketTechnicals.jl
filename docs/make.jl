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
    ]
)
