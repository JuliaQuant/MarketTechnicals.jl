df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# bollinger_bands

bb_df  = bollinger_bands(df)

@assert 2.2299598195282666 == bb_df[488, 9]   
@assert 103.98191963905654 == bb_df[488, 10]  # R's TTR value 103.6847 (uses typical price instead of close for std)
@assert  95.06208036094347 == bb_df[488, 11]  # R's TTR value 95.35932 (uses typical price instead of close for std)

# atr

atr_df  = atr(df)

#@assert 17.0466 == atr_df["Range"]
#@assert 1518.08 == atr_df["Hilag"]
#@assert 1449.89 == atr_df["Lolag"]
#@assert 1449.89 == atr_df["TR"]
#@assert 1449.89 == atr_df["ATR"]
#
#
## keltner_bands
#
#kel_df  = keltner_bands(df)
#
#@assert 17.0466 == kel_df["Range"]
#@assert 1518.08 == kel_df["Hilag"]
#@assert 1449.89 == kel_df["Lolag"]
#@assert 1449.89 == kel_df["TR"]
#@assert 1449.89 == kel_df["ATR"]
#
## chaikin_volatility
#
#chk_df  = chaikin_volatility(df)
#
#@assert 17.0466 == chk_df["Range"]
#@assert 1518.08 == chk_df["Hilag"]
#@assert 1449.89 == chk_df["Lolag"]
#@assert 1449.89 == chk_df["TR"]
#@assert 1449.89 == chk_df["ATR"]
