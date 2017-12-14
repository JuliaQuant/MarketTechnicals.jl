function doji(ohlc::TimeArray{T,N}; width=.01, op="Open", hi="High", lo="Low", cl="Close") where {T,N}
  res = @. abs((ohlc[op] - ohlc[cl])) / (ohlc[hi] - ohlc[lo]) < width
  TimeArray(res.timestamp, res.values, ["doji"], ohlc.meta)
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
