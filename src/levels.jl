function floorpivots{T,V}(hi::Array{SeriesPair{T,V},1},
                          lo::Array{SeriesPair{T,V},1},
                          cl::Array{SeriesPair{T,V},1})


  p  = (value(lag(hi)) + value(lag(lo)) + value(lag(cl))) ./ 3
  s1 = 2p - value(lag(hi))
  r1 = 2p - value(lag(lo))
  s2 = p - (r1 - s1)
  r2 = (p - s1) + r1
  s3 = p - (r2 - s1)
  r3 = (p - s1) + r2
  
  SeriesArray(index(hi), r3, "r3"),
  SeriesArray(index(hi), r2, "r2"),
  SeriesArray(index(hi), r1, "r1"),
  SeriesArray(index(hi), p , "pivot"),
  SeriesArray(index(hi), s1, "s1"),
  SeriesArray(index(hi), s2, "s2"),
  SeriesArray(index(hi), s3, "s3")

end

function woodiespivots{T,V}(op::Array{SeriesPair{T,V},1},
                            hi::Array{SeriesPair{T,V},1},
                            lo::Array{SeriesPair{T,V},1})

  range = value(lag(hi)) - value(lag(lo))

  p  = ((value(lag(hi)) + value(lag(lo)) + 2value(op))) / 4
  s1 = 2p - value(lag(hi))
  r1 = 2p - value(lag(lo))
  s2 = p - range
  r2 = p + range
  s3 = s1 - range
  r3 = r1 + range
  # s4 = s3 - range # can't get an answer that matches online calculators
  # r4 = r3 + range


  # SeriesArray(index(op), r4, "r4"),
  SeriesArray(index(op), r3, "r3"),
  SeriesArray(index(op), r2, "r2"),
  SeriesArray(index(op), r1, "r1"),
  SeriesArray(index(op), p , "pivot"),
  SeriesArray(index(op), s1, "s1"),
  SeriesArray(index(op), s2, "s2"),
  SeriesArray(index(op), s3, "s3")
  # SeriesArray(index(op), s4, "s4")
end

function camarillapivots{T,V}(op::Array{SeriesPair{T,V},1},
                              hi::Array{SeriesPair{T,V},1},
                              lo::Array{SeriesPair{T,V},1},
                              cl::Array{SeriesPair{T,V},1})
  #code here
  ##  R4 = (H - L) * 1.1/2 + C 
  ##  R3 = (H - L) * 1.1/4 + C
  ##  R2 = (H - L) * 1.1/6 + C
  ##  R1 = (H - L) * 1.1/12 + C
  ##  S1 = C - (H - L) * 1.1/12
  ##  S2 = C - (H - L) * 1.1/6
  ##  S3 = C - (H - L) * 1.1/4
  ##  S4 = C - (H - L) * 1.1/2
end

function demarkpivots{T,V}(op::Array{SeriesPair{T,V},1},
                           hi::Array{SeriesPair{T,V},1},
                           lo::Array{SeriesPair{T,V},1},
                           cl::Array{SeriesPair{T,V},1})
  #code here
  ## If Close < Open then X = (H + (L * 2) + C) 
  ## If Close > Open then X = ((H * 2) + L + C) 
  ## If Close = Open then X = (H + L + (C * 2)) 
  ## 
  ## R1 = X / 2 - L
  ## PP = X / 4 
  ## S1 = X / 2 - H
end

function market_profile(x)
  #code here
end

