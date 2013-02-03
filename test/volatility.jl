df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# bollinger_bands

bb_df  = bollinger_bands(df)
bb_tst = tail(bb_df, 1)

@assert 17.0466 == bb_tst["std_20"]
@assert 1518.08 == bb_tst["up_bband"]
@assert 1449.89 == bb_tst["dn_bband"]

# atr

atr_df  = atr(df)
atr_tst = tail(atr_df, 1)

#@assert 17.0466 == atr_tst["Range"]
#@assert 1518.08 == atr_tst["Hilag"]
#@assert 1449.89 == atr_tst["Lolag"]
#@assert 1449.89 == atr_tst["TR"]
#@assert 1449.89 == atr_tst["ATR"]
#
#
## keltner_bands
#
#kel_df  = keltner_bands(df)
#kel_tst = tail(kel_df, 1)
#
#@assert 17.0466 == kel_tst["Range"]
#@assert 1518.08 == kel_tst["Hilag"]
#@assert 1449.89 == kel_tst["Lolag"]
#@assert 1449.89 == kel_tst["TR"]
#@assert 1449.89 == kel_tst["ATR"]
#
## chaikin_volatility
#
#chk_df  = chaikin_volatility(df)
#chk_tst = tail(chk_df, 1)
#
#@assert 17.0466 == chk_tst["Range"]
#@assert 1518.08 == chk_tst["Hilag"]
#@assert 1449.89 == chk_tst["Lolag"]
#@assert 1449.89 == chk_tst["TR"]
#@assert 1449.89 == chk_tst["ATR"]
