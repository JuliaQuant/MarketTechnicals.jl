df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# rsi 

rsi_df = rsi(df)

@assert 73.80060302291837 == rsi_df[507, 8]
@assert 72.15153048735719 == rsi_df[507, 9] # from TTR 1971-12-31 72.151530

# macd

# cci 
# williams_percent_r 
