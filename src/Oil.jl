using Thyme, DataFrames, Calendar, UTF16

module Oil  

using Thyme, DataFrames, Calendar, UTF16

export ema,
       sma, 
       @testoil

include(joinpath(julia_pkgdir(), "Oil", "src", "movingaverages.jl"))
include(joinpath(julia_pkgdir(), "Oil", "src", "testoil.jl"))


end 
