using Documenter
using MarketTechnicals

# https://juliadocs.github.io/Documenter.jl/stable/man/doctests/#Module-level-metadata
DocMeta.setdocmeta!(MarketTechnicals, :DocTestSetup, :(using MarketTechnicals);
                    recursive = true)

makedocs(
  format = Documenter.HTML(mathengine = Documenter.Writers.HTMLWriter.MathJax3()),
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
  ],
)

deploydocs(
  repo         = "github.com/JuliaQuant/MarketTechnicals.jl.git",
  devbranch    = "master",
  push_preview = true,
)
