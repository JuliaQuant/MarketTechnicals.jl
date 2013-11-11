df     = readtime(Pkg.dir("MarketTechnicals/test/data/spx.csv"))

# rsi 
rsi_df = rsi(df)

@assert 73.80060302291837 == rsi_df[507, 8]

# rsi_wilder 
rsw_df = rsi_wilder(df)

@assert 72.15153048735719 == rsw_df[507, 8] # from TTR 1971-12-31 72.151530

# macd
mac_df = macd(df)

@assert 1.8694463607370295 == mac_df[507, 8] # TTR value with percent=FALSE is 1.900959 
@assert 1.7189453474752991 == mac_df[507, 9] # TTR value with percent=FALSE is 1.736186

# cci 
#cci_df = cci(df)

#@assert -146.17060449635804 == cci_df[20 ,8]  # TTR::CCI value is -175.8644

# williams_percent_r 
