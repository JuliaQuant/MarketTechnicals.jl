using Oil

my_tests = ["test/appel.jl", 
            "test/bollinger.jl", 
            "test/demark.jl", 
            "test/donchian.jl",
            "test/granville.jl",
            "test/keltner.jl",
            "test/lambert.jl",
            "test/lane.jl", 
            "test/marketprofile.jl", 
            "test/mcclellan.jl", 
            "test/movingaverages.jl", 
            "test/pivots.jl", 
            "test/vwap.jl", 
            "test/wilder.jl",  
            "test/williams.jl"]

print_with_color("Running tests: ", :cyan) 
println("")

for my_test in my_tests
    print_with_color("**   ", :magenta) 
    print_with_color("$my_test", :blue) 
    println("")
    include(my_test)
end
