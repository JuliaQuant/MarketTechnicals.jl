df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# doji
dojidf   = doji(df)
dojiday1 = subset(dojidf, :(Date .== $ymd(1970, 3, 31)))
dojiday2 = subset(dojidf, :(Date .== $ymd(1970, 8, 5)))

@assert "doji" == dojiday1[1, "doji"]
@assert "doji" == dojiday2[1, "doji"]












# hammer
# inverted_hammer
# hanging_man
# mirabosu
# shooting_star
# spinning_top
# three_white_soldiers
# three_black_crows
# morning_star
