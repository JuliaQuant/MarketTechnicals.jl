df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

#ema
dv  = df["Close"]
e1  = ema(dv, 1)
e2  = ema(dv, 2)
e10 = ema(dv, 10)

@assert e1[507]  == dv[507]
@assert e2[507]  == 102.01237121462606 # R's TTR::EMA returns 102.01237 (rounded)
@assert e10[507] == 101.10189950870759 # R's TTR::EMA returns 101.10190 (rounded)
