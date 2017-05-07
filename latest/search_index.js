var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "MarketTechnicals Overview",
    "title": "MarketTechnicals Overview",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#MarketTechnicals-Overview-1",
    "page": "MarketTechnicals Overview",
    "title": "MarketTechnicals Overview",
    "category": "section",
    "text": "The MarketTechnicals package provides common technical analysis algorithms for financial time series."
},

{
    "location": "index.html#Contents-1",
    "page": "MarketTechnicals Overview",
    "title": "Contents",
    "category": "section",
    "text": "Pages = [\n    \"getting_started.md\",\n    \"ma.md\",\n    \"levels.md\",\n    \"momentum.md\",\n    \"volatility.md\",\n    \"volume.md\",\n    \"candlesticks.md\",\n]"
},

{
    "location": "getting_started.html#",
    "page": "Getting Started",
    "title": "Getting Started",
    "category": "page",
    "text": ""
},

{
    "location": "getting_started.html#Getting-Started-1",
    "page": "Getting Started",
    "title": "Getting Started",
    "category": "section",
    "text": "MarketTechnicals is a registered package. To add it to your Julia packages, simply do the following in REPL  Pkg.add(\"MarketTechnicals\")We will use data from the MarketData package to demonstrate how this package produces results from various technical analysis indicators. That package can also be added from REPL  Pkg.add(\"MarketData\")"
},

{
    "location": "ma.html#",
    "page": "Moving Averages",
    "title": "Moving Averages",
    "category": "page",
    "text": ""
},

{
    "location": "ma.html#Moving-Averages-1",
    "page": "Moving Averages",
    "title": "Moving Averages",
    "category": "section",
    "text": ""
},

{
    "location": "ma.html#MarketTechnicals.sma",
    "page": "Moving Averages",
    "title": "MarketTechnicals.sma",
    "category": "Function",
    "text": "sma(arr, n)\n\nSimple Moving Average\n\nSMA = fracsum^nP_in\n\n\n\n"
},

{
    "location": "ma.html#Simple-Moving-Average-1",
    "page": "Moving Averages",
    "title": "Simple Moving Average",
    "category": "section",
    "text": "sma"
},

{
    "location": "ma.html#MarketTechnicals.ema",
    "page": "Moving Averages",
    "title": "MarketTechnicals.ema",
    "category": "Function",
    "text": "ema(arr, n, wilder=false)\n\nExponemtial Moving Average\n\nA.k.a. exponentially weighted moving average (EWMA)\n\n    textLet  k textdenote the degree of weighting decrease\n\nIf parameter wilder is true, k = frac1n, else k = frac2n + 1.\n\n    EMA_t = k times P_t + (1 - k) times EMA_t - 1\n\n\n\n"
},

{
    "location": "ma.html#Exponential-Moving-Average-1",
    "page": "Moving Averages",
    "title": "Exponential Moving Average",
    "category": "section",
    "text": "ema  julia> ema(cl, 10, wilder=true)\n  496x1 TimeArray{Float64,1} 1980-01-16 to 1981-12-31\n\n                Close\n  1980-01-16 | 108.89\n  1980-01-17 | 109.07\n  1980-01-18 | 109.27\n  1980-01-21 | 109.56\n  ...\n  1981-12-24 | 123.44\n  1981-12-28 | 123.33\n  1981-12-29 | 123.16\n  1981-12-30 | 123.07\n  1981-12-31 | 123.02"
},

{
    "location": "levels.html#",
    "page": "Trade levels",
    "title": "Trade levels",
    "category": "page",
    "text": ""
},

{
    "location": "levels.html#Trade-levels-1",
    "page": "Trade levels",
    "title": "Trade levels",
    "category": "section",
    "text": ""
},

{
    "location": "levels.html#MarketTechnicals.floorpivots",
    "page": "Trade levels",
    "title": "MarketTechnicals.floorpivots",
    "category": "Function",
    "text": "floorpivots(ohlc)\n\nFloor Trader Pivots\n\nbeginalign*\n\n    R3  = Pivot_t + (R2 - S1) \n    R2  = Pivot_t + (R1 - S1) \n    R1  = 2 Pivot_t - P^low_t-1 \n    Pivot_t  = Price^typical_t-1 =\n        fracP^high_t-1 + P^low_t-1 + P^close_t-13 \n    S1  = 2 Pivot_t - P^high_t-1 \n    S2  = Pivot_t - (R1 - S1) \n    S3  = Pivot_t - (R2 - S1)\n\nendalign*\n\n\n\n"
},

{
    "location": "levels.html#Floor-Trader-Pivots-1",
    "page": "Trade levels",
    "title": "Floor Trader Pivots",
    "category": "section",
    "text": "floorpivots"
},

{
    "location": "levels.html#MarketTechnicals.woodiespivots",
    "page": "Trade levels",
    "title": "MarketTechnicals.woodiespivots",
    "category": "Function",
    "text": "woodiespivots(ohlc)\n\nWoodie's Pivot\n\nbeginalign*\n\n    Range  = Price^high_t-1 - Price^low_t-1 \n\n    R4  = S4 + Range tagnot implemented \n    R3  = R1 + Range \n    R2  = Pivot_t + Range \n    R1  = 2 Pivot_t - Price^low_t-1 \n    Pivot_t  =\n        fracPrice^high_t-1 + Price^low_t-1 + 2 Price^open_t4 \n    S1  = 2 Pivot_t - Price^high_t-1 \n    S2  = Pivot_t - Range \n    S3  = S1 - Range \n    S4  = S3 - Range tagnot implemented\n\nendalign*\n\n\n\n"
},

{
    "location": "levels.html#Woodies-Pivots-1",
    "page": "Trade levels",
    "title": "Woodies Pivots",
    "category": "section",
    "text": "woodiespivots  julia> woodiespivots(ohlc)\n  504x7 TimeArray{Float64,2} 1980-01-04 to 1981-12-31\n\n                s3      s2      s1      pivot   r1      r2      r3\n  1980-01-04 | 100.99  102.13  103.81  104.94  106.63  107.76  109.45\n  1980-01-07 | 103.54  104.31  105.53  106.30  107.52  108.29  109.51\n  1980-01-08 | 103.81  104.81  105.81  106.81  107.81  108.81  109.81\n  1980-01-09 | 104.45  105.37  107.45  108.37  110.45  111.37  113.45\n  ...\n  1981-12-24 | 119.30  120.44  121.31  122.45  123.32  124.46  125.33\n  1981-12-28 | 120.31  120.94  121.80  122.43  123.29  123.92  124.78\n  1981-12-29 | 119.83  120.78  121.45  122.41  123.08  124.04  124.71\n  1981-12-30 | 119.00  120.06  120.78  121.84  122.56  123.62  124.34\n  1981-12-31 | 119.20  120.12  121.27  122.19  123.33  124.26  125.40"
},

{
    "location": "momentum.html#",
    "page": "Momentum",
    "title": "Momentum",
    "category": "page",
    "text": ""
},

{
    "location": "momentum.html#Momentum-1",
    "page": "Momentum",
    "title": "Momentum",
    "category": "section",
    "text": ""
},

{
    "location": "momentum.html#MarketTechnicals.rsi",
    "page": "Momentum",
    "title": "MarketTechnicals.rsi",
    "category": "Function",
    "text": "rsi(ta, n=14; wilder=false)\n\nRelative Strength Index\n\n    RSI = fracEMA(Up n)EMA(Up n) + EMA(Dn n)\n\n\n\n"
},

{
    "location": "momentum.html#RSI-1",
    "page": "Momentum",
    "title": "RSI",
    "category": "section",
    "text": "rsi"
},

{
    "location": "momentum.html#MarketTechnicals.macd",
    "page": "Momentum",
    "title": "MarketTechnicals.macd",
    "category": "Function",
    "text": "macd(ta, fast=12, slow=26, signal=9)\n\nMoving Average Convergence / Divergence\n\n    beginalign*\n        MACD Bar  = DIF - DEM \n        DIF  = EMA(P_close fast) - EMA(P_close slow) \n        DEM  = EMA(DIF 9) tagsignal\n    endalign*\n\nReturn:     TimeArray with 3 columns [\"macd\", \"dif\", \"signal\"].\n\nIf the input is a multi-column `TimeArray`, the new column names will be\n`[\"A_macd\", \"B_macd\", \"A_dif\", \"B_dif\", \"A_signal\", \"B_signal\"]`.\n\n\n\n"
},

{
    "location": "momentum.html#MACD-1",
    "page": "Momentum",
    "title": "MACD",
    "category": "section",
    "text": "macd"
},

{
    "location": "momentum.html#MarketTechnicals.cci",
    "page": "Momentum",
    "title": "MarketTechnicals.cci",
    "category": "Function",
    "text": "cci(ohlc, ma=20, c=0.015)\n\nCommodity Channel Index\n\n    CCI = fracP_typical - SMA(P_typical)c times sigma(P_typical)\n\n\n\n"
},

{
    "location": "momentum.html#CCI-1",
    "page": "Momentum",
    "title": "CCI",
    "category": "section",
    "text": "cci"
},

{
    "location": "volatility.html#",
    "page": "Volatility",
    "title": "Volatility",
    "category": "page",
    "text": ""
},

{
    "location": "volatility.html#Volatility-1",
    "page": "Volatility",
    "title": "Volatility",
    "category": "section",
    "text": ""
},

{
    "location": "volatility.html#MarketTechnicals.bollingerbands",
    "page": "Volatility",
    "title": "MarketTechnicals.bollingerbands",
    "category": "Function",
    "text": "bollingerbands(ta, ma=20, width=2.0)\n\nBollinger Bands\n\nbeginalign*\n\n    Up  = SMA + width times sigma \n    Mean  = SMA \n    Down  = SMA - width times sigma\n\nendalign*\n\n\n\n"
},

{
    "location": "volatility.html#Bollinger-Bands-1",
    "page": "Volatility",
    "title": "Bollinger Bands",
    "category": "section",
    "text": "bollingerbands"
},

{
    "location": "volatility.html#MarketTechnicals.truerange",
    "page": "Volatility",
    "title": "MarketTechnicals.truerange",
    "category": "Function",
    "text": "truerange(ohlc; h=\"High\", l=\"Low\", c=\"Close\")\n\nTrue Range\n\n    TR = max (H_t C_t-1) - min (L_t Ct-1)\n\n\n\n"
},

{
    "location": "volatility.html#True-Range-1",
    "page": "Volatility",
    "title": "True Range",
    "category": "section",
    "text": "truerange"
},

{
    "location": "volatility.html#MarketTechnicals.atr",
    "page": "Volatility",
    "title": "MarketTechnicals.atr",
    "category": "Function",
    "text": "atr(ohlc, n=14; h=\"High\", l=\"Low\", c=\"Close\")\n\nAverage True Range\n\nIt's the exponential moving average of truerange\n\n    ATR = EMA(TR n)\n\n\n\n"
},

{
    "location": "volatility.html#Average-True-Range-1",
    "page": "Volatility",
    "title": "Average True Range",
    "category": "section",
    "text": "atr"
},

{
    "location": "volatility.html#Keltner-Bands-1",
    "page": "Volatility",
    "title": "Keltner Bands",
    "category": "section",
    "text": "Not Implemented"
},

{
    "location": "volume.html#",
    "page": "Volume",
    "title": "Volume",
    "category": "page",
    "text": ""
},

{
    "location": "volume.html#Volume-1",
    "page": "Volume",
    "title": "Volume",
    "category": "section",
    "text": ""
},

{
    "location": "volume.html#MarketTechnicals.obv",
    "page": "Volume",
    "title": "MarketTechnicals.obv",
    "category": "Function",
    "text": "obv(ohlcv; price=\"Close\", v=\"Volume\")\n\nOn Balance Volume\n\n    OBV_t = OBV_t - 1 +\n        begincases\n            volume   textif  close_t  close_t-1 \n            0        textif  close_t = close_t-1 \n            -volume  textif  close_t  close_t-1\n        endcases\n\n\n\n"
},

{
    "location": "volume.html#On-Balance-Volume-(OBV)-1",
    "page": "Volume",
    "title": "On Balance Volume (OBV)",
    "category": "section",
    "text": "obv"
},

{
    "location": "volume.html#MarketTechnicals.vwap",
    "page": "Volume",
    "title": "MarketTechnicals.vwap",
    "category": "Function",
    "text": "vwap(ohlcv, n; price=\"Close\", v=\"Volume\")\n\nVolume Weight-Adjusted Price\n\n    P = fracsum_j P_j Q_jsum_j Q_j  textwhere Q is the volume\n\n\n\n"
},

{
    "location": "volume.html#Volume-Weight-Adjusted-Price-(VWAP)-1",
    "page": "Volume",
    "title": "Volume Weight-Adjusted Price (VWAP)",
    "category": "section",
    "text": "vwap"
},

{
    "location": "candlesticks.html#",
    "page": "Candlesticks",
    "title": "Candlesticks",
    "category": "page",
    "text": ""
},

{
    "location": "candlesticks.html#Candlesticks-1",
    "page": "Candlesticks",
    "title": "Candlesticks",
    "category": "section",
    "text": "Candlestick depiction of price involves three components: open, high, low and close. The body of the candlestick consists of the open and close, and the color of the candle body depicts which one is on top and which is on the bottom. Green is typically reserved for a higher close than the open, because traders were able to realize profits for the day. Red depicts a higher open and a lower close.The candlestick also includes wicks to the top and the bottom. These wicks are bounded by the high for the top wick and low for the bottom wick.Candlestick patterns identify certain formations for these candlesticks. Sometimes these patterns only concern a single trading day's activity and other times it spans several trading periods."
},

{
    "location": "candlesticks.html#Doji-1",
    "page": "Candlesticks",
    "title": "Doji",
    "category": "section",
    "text": "The doji pattern is identified with a very small candle body, where the open and closing price are nearly identical. It suggests some ambivalence in the market about what the fair value of the underlying asset is.\n    julia> using MarketTechnicals, MarketData\n\n    julia> findwhen(doji(ohlc))\n    5-element Array{Date{ISOCalendar},1}:\n     1980-10-14\n     1981-04-07\n     1981-05-08\n     1981-06-08\n     1981-07-14"
},

]}
