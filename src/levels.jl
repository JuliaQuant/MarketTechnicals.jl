function floor_pivots(x)
  #code here  
  ## R3 = (P - S1) + R2
  ## R2 = (P - S1) + R1
  ## R1 = (2*P) - L
  ## PP = (H + L + C)/3
  ## S1 = (2*P) – H
  ## S2 = P - (R1 - S1)
  ## S3 = P - (R2 - S1)
end

function woodies_pivots(x)
  #code here
  ##  R4 = R3 + (H - L)
  ##  R3 = H + 2 * (PP - L) 
  ##  R2 = PP + (H - L)
  ##  R1 = (2 * PP) - LOW
  ##  PP = (HIGH + LOW + (OPEN * 2)) / 4
  ##  S1 = (2 * PP) - HIGH
  ##  S2 = PP - (H - L)
  ##  S3 = L - 2 * (H - PP) 
  ##  S4 = S3 - (H - L)
end

function camarilla_pivots(x)
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

function demark_pivots(x)
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

