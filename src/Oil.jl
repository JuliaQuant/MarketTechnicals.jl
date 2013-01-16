using Thyme 

module Oil  

using Thyme

export ema,
       sma, 
       @testit

include(joinpath(julia_pkgdir(), "Oil", "src", "movingaverages.jl"))
include(joinpath(julia_pkgdir(), "Thyme", "src", "testit.jl"))

end 
