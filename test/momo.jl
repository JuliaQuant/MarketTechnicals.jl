df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# rsi 
rsi_df = rsi(df)

@assert 73.80060302291837 == rsi_df[507, 8]

# rsi_wilder 
rsw_df = rsi_wilder(df)

@assert 72.15153048735719 == rsw_df[507, 8] # from TTR 1971-12-31 72.151530

# macd

# cci 
cci_df = cci(df)

#@assert  -175.8644 == cci_df[20 ,8]  # TTR::CCI value is -175.8644

# williams_percent_r 
