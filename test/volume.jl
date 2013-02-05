df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# obv

obv_df = obv(df)

@assert 8080000 == obv_df[3, "obv"]


# vwap
# advance_decline
# mcclellan_summation
# williams_ad
