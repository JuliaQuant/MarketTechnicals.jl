df     = read_yahoo(Pkg.dir("Oil", "test", "data"), "spx.csv")

# doji

dojidf  = doji(df)
dojiday = subset(d, :(Date .== $ymd(1970, 3, 31)))

@assert "doji" == dojiday[1, "doji"]












# hammer
# inverted_hammer
# hanging_man
# mirabosu
# shooting_star
# spinning_top
# three_white_soldiers
# three_black_crows
# morning_star
