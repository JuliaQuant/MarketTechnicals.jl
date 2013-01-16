df = read_stock("test/data/spx.csv");


dv1 = df["Open"];

macd1  = macd(dv1)

@assert macd1[507]  == some_value
