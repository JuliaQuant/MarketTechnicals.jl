function doji(df::DataFrame)

  df = copy(df)

# boolean for abs diff between Open and Close / range is less than 1%
  dj = with(df, :((abs(Open - Close)) ./ (High - Low) .< .01))

  within!(df, quote
    doji = map(x -> x == true? "doji": false, $dj)
    end)
  df

# to get only the doji values from the result use:
# subset(df, :(doji .== "doji"))
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

function moring_star(x)
  #code here
end
