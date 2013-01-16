df = read_stock("test/data/spx.csv");

dv1 = df["Open"];
dv2 = df["Close"];
dv3 = df["Adj Close"];

e1  = ema(dv1,1)
e2  = ema(dv2,2)
e13 = ema(dv3,13)

@assert e1[507]  == dv1[507]
@assert e2[506]  == 102.01237121462606  # R's TTR::EMA returns 102.01237 (rounded)
@assert e13[495] == 100.62558587207887  # R's TTR::EMA returns 100.62559 (rounded)
