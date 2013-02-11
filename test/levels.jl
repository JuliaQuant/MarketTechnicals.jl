df     = read_yahoo(Pkg.dir("TechnicalAnalysis", "test", "data"), "spx.csv")

# floor_pivots
pvt_df = floor_pivots(df)

@assert  95.29             == pvt_df[2, "R3"] # values verified by various website calculators
@assert  94.52666666666669 == pvt_df[2, "R2"]
@assert  93.76333333333336 == pvt_df[2, "R1"]
@assert  92.77666666666669 == pvt_df[2, "pivot"]
@assert  92.01333333333336 == pvt_df[2, "S1"]
@assert  91.02666666666669 == pvt_df[2, "S2"]
@assert  90.26333333333336 == pvt_df[2, "S3"] 









# woodies_pivots
# camarilla_pivots 
# demark_pivots 
# market_profile
