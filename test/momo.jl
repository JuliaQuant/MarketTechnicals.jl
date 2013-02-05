df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# rsi 

rsi_df = rsi(df)

@assert 72.151530 == rsi_df[507,1]

# macd

# cci 
# williams_percent_r 
