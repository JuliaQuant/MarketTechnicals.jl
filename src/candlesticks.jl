function doji{T,V}(op::Array{SeriesPair{T,V},1},
                   hi::Array{SeriesPair{T,V},1},
                   lo::Array{SeriesPair{T,V},1},
                   cl::Array{SeriesPair{T,V},1})

  ba = float64([abs(value(op) - value(cl)) ./ (value(hi) - value(lo)) .< .01])
  SeriesArray(index(op), ba)

  # SeriesArray(index(op), [abs(value(op) - value(cl)) ./ (value(hi) - value(lo)) .< .01])
end

function hammer(x)
  #code here
end

function inverted_hammer(x)
  #code here
end

function hanging_man(x)
  #code here
end

function mirabosu(x)
  #code here
end

function shooting_star(x)
  #code here
end

function spinning_top(x)
  #code here
end

function three_white_soldiers(x)
  #code here
end

function three_black_crows(x)
  #code here
end

function morning_star(x)
  #code here
end




