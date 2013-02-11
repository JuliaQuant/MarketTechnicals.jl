df     = read_yahoo(Pkg.dir("TechnicalAnalysis", "test", "data"), "spx.csv")

# obv
obv_df = obv(df)

@assert 8080000 == obv_df[3, "obv"] # manual addition/subtration value of first three volume values

# vwap
vwp_df = vwap(df)

@assert 101.44708763647094 == vwp_df[507,8] # TTR value 101.44709




# advance_decline
# mcclellan_summation
# williams_ad
