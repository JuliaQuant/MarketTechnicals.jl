function doji{T,N}(ohlc::TimeArray{T,N}; op="Open", hi="High", lo="Low", cl="Close")
    
  TimeArray(index(op), [abs(value(op) - value(cl)) ./ (value(hi) - value(lo)) .< .01])
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




