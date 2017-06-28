using Base.Test

tests = [
    "candlesticks",
    "levels",
    "momentum",
    "movingaverages",
    "utilities",
    "volatility",
    "volume",
]


@testset "MarketTechnicals" begin
    println("Running tests:")

    for test ∈ tests
        println("\t* $test ...")
        include("$test.jl")
    end
end
