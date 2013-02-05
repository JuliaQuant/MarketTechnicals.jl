df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# rsi 

rsi_df = rsi(df)

@assert 73.80060302291837 == rsi_df[507,8]

# macd

# cci 
# williams_percent_r 
