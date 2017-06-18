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
    "text": "Pages = [\n    \"getting_started.md\",\n    \"ma.md\",\n    \"levels.md\",\n    \"momentum.md\",\n    \"volatility.md\",\n    \"volume.md\",\n    \"candlesticks.md\",\n    \"utils.md\",\n]"
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
    "text": "sma(arr, n)\n\nSimple Moving Average\n\nSMA = fracsum_i^nP_in\n\n\n\n"
},

{
    "location": "ma.html#Simple-Moving-Average-1",
    "page": "Moving Averages",
    "title": "Simple Moving Average",
    "category": "section",
    "text": "smausing MarketData\nusing MarketTechnicals\n\nsma(cl, 5)"
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
    "text": "emausing MarketData\nusing MarketTechnicals\n\nema(cl, 10, wilder=true)"
},

{
    "location": "ma.html#MarketTechnicals.kama",
    "page": "Moving Averages",
    "title": "MarketTechnicals.kama",
    "category": "Function",
    "text": "Kaufman's Adaptive Moving Average\n\nArguments:\n\nn: period\nfn: the fastest EMA constant\nsn: the slowest EMA constant\n\nFormula:\n\n    beginalign*\n        KAMA_t  = KAMA_t-1 + SC times (Price - KAMA_t-1) \n        SC      =\n            (ER times (frac2fn + 1 - frac2sn + 1) + frac2sn + 1)^2 \n        ER      = fracChangeVolatility \n        Change  =  Price - Price_t-n  \n        Volatility  = sum_i^n  Price_i - Price_i-1 \n    endalign*\n\n\n\n"
},

{
    "location": "ma.html#Kaufman's-Adaptive-Moving-Average-1",
    "page": "Moving Averages",
    "title": "Kaufman's Adaptive Moving Average",
    "category": "section",
    "text": "kamausing MarketData\nusing MarketTechnicals\n\nkama(cl)"
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
    "text": "floorpivotsusing MarketData\nusing MarketTechnicals\n\nfloorpivots(ohlc)"
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
    "text": "woodiespivotsusing MarketData\nusing MarketTechnicals\n\nwoodiespivots(ohlc)"
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
    "location": "momentum.html#MarketTechnicals.adx",
    "page": "Momentum",
    "title": "MarketTechnicals.adx",
    "category": "Function",
    "text": "adx{T,N}(ohlc, n=14; h=\"High\", l=\"Low\", c=\"Close\")\n\nAverage Directional Movement Index\n\nDeveloped by J. Welles Wilder. This Implementation follow StockCharts.\n\nReference\n\nwikipedia\nStockCharts\n\n\n\n"
},

{
    "location": "momentum.html#Average-Directional-Movement-Index-(ADX)-1",
    "page": "Momentum",
    "title": "Average Directional Movement Index (ADX)",
    "category": "section",
    "text": "adxusing MarketData\nusing MarketTechnicals\n\nadx(ohlc)"
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
    "text": "rsiusing MarketData\nusing MarketTechnicals\n\nrsi(cl)"
},

{
    "location": "momentum.html#MarketTechnicals.macd",
    "page": "Momentum",
    "title": "MarketTechnicals.macd",
    "category": "Function",
    "text": "macd(ta, fast=12, slow=26, signal=9; wilder=false)\n\nMoving Average Convergence / Divergence\n\n    beginalign*\n        MACD Bar  = DIF - DEM \n        DIF  = EMA(P_close fast) - EMA(P_close slow) \n        DEM  = EMA(DIF 9) tagsignal\n    endalign*\n\nReturn:\n\nTimeArray with 3 columns [\"macd\", \"dif\", \"signal\"].\n\nIf the input is a multi-column TimeArray, the new column names will be [\"A_macd\", \"B_macd\", \"A_dif\", \"B_dif\", \"A_signal\", \"B_signal\"].\n\n\n\n"
},

{
    "location": "momentum.html#MACD-1",
    "page": "Momentum",
    "title": "MACD",
    "category": "section",
    "text": "macdusing MarketData\nusing MarketTechnicals\n\nmacd(cl)"
},

{
    "location": "momentum.html#MarketTechnicals.chaikin_osc",
    "page": "Momentum",
    "title": "MarketTechnicals.chaikin_osc",
    "category": "Function",
    "text": "chaikin_osc(ohlcv, fast=3, slow=10; h=\"High\", l=\"Low\", c=\"Close\")\n\nChaikin Oscillator\n\nDeveloped by Marc Chaikin\n\nFormula\n\n    Chaikin OSC = EMA(ADL fast) - EMA(ADL slow)\n\nwhere the adl is the Accumulation/Distribution Line.\n\nReference\n\nStockCharts\n\n\n\n"
},

{
    "location": "momentum.html#Chaikin-Oscillator-1",
    "page": "Momentum",
    "title": "Chaikin Oscillator",
    "category": "section",
    "text": "chaikin_oscusing MarketData\nusing MarketTechnicals\n\nchaikin_osc(ohlcv)"
},

{
    "location": "momentum.html#MarketTechnicals.cci",
    "page": "Momentum",
    "title": "MarketTechnicals.cci",
    "category": "Function",
    "text": "cci(ohlc, ma=20, c=0.015)\n\nCommodity Channel Index\n\n    CCI = fracP_typical - SMA(P_typical)c times sigma(P_typical)\n\nReference\n\nhttps://en.wikipedia.org/wiki/Commodity_channel_index\n\n\n\n"
},

{
    "location": "momentum.html#CCI-1",
    "page": "Momentum",
    "title": "CCI",
    "category": "section",
    "text": "cciusing MarketData\nusing MarketTechnicals\n\ncci(ohlc)"
},

{
    "location": "momentum.html#MarketTechnicals.roc",
    "page": "Momentum",
    "title": "MarketTechnicals.roc",
    "category": "Function",
    "text": "roc(ta, n)\n\nRate of Change\n\nFormula:\n\n    roc = fracclose_t - close_t-nclose_t-n\n\nReference:\n\nWikipedia\n\n\n\n"
},

{
    "location": "momentum.html#Rate-of-Change-(ROC)-1",
    "page": "Momentum",
    "title": "Rate of Change (ROC)",
    "category": "section",
    "text": "rocusing MarketData\nusing MarketTechnicals\n\nroc(cl, 5)"
},

{
    "location": "momentum.html#MarketTechnicals.stoch_osc",
    "page": "Momentum",
    "title": "MarketTechnicals.stoch_osc",
    "category": "Function",
    "text": "stoch_osc(ohlc, n=14, fast_d=3, slow_d=3; h=\"High\", l=\"Low\", c=\"Close\")\n\nStochastic Oscillator\n\nA.k.a %K%D, or KD\n\nParameter\n\nn: period of fast(raw) %K\nfast_d: MA period of fast %D\nslow_d: MA period of slow %D\n\nFormula\n\n    beginalign*\n        fast K  = fracClose_t - max(High_t-n dots High_t)\n            max(High_t-n dots High_t) - min(Low_t-n dots Low_t)\n            times 100 \n        fast D  = SMA(fast K) \n        slow D  = SMA(fast D)\n    endalign*\n\nReference\n\nWikipedia\nFMLabs\n\n\n\n"
},

{
    "location": "momentum.html#Stochastic-Oscillator-1",
    "page": "Momentum",
    "title": "Stochastic Oscillator",
    "category": "section",
    "text": "stoch_oscusing MarketData\nusing MarketTechnicals\n\nstoch_osc(ohlc)"
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
    "text": "bollingerbandsusing MarketData\nusing MarketTechnicals\n\nbollingerbands(cl)"
},

{
    "location": "volatility.html#MarketTechnicals.chaikinvolatility",
    "page": "Volatility",
    "title": "MarketTechnicals.chaikinvolatility",
    "category": "Function",
    "text": "chaikinvolatility(ta, n=10, p=10; h=\"High\", l=\"Low\")\n\nChaikin Volatility\n\nParameters\n\nn is the smooth period\np is the previous period\n\nFormula\n\n    Chaikin Vola =\n        fracEMA(High_t - Low_t n) - EMA(High_t-p - Low_t-p n)\n        EMA(High_t-p - Low_t-p n)\n        times 100\n\nReference\n\nIncredibleCharts\n\n\n\n"
},

{
    "location": "volatility.html#Chaikin-Volatility-1",
    "page": "Volatility",
    "title": "Chaikin Volatility",
    "category": "section",
    "text": "chaikinvolatilityusing MarketData\nusing MarketTechnicals\n\nchaikinvolatility(ohlc)"
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
    "text": "truerangeusing MarketData\nusing MarketTechnicals\n\ntruerange(ohlc)"
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
    "text": "atrusing MarketData\nusing MarketTechnicals\n\natr(ohlc)"
},

{
    "location": "volatility.html#MarketTechnicals.donchian_channels",
    "page": "Volatility",
    "title": "MarketTechnicals.donchian_channels",
    "category": "Function",
    "text": "donchian_channels(ta, n=20; h=\"High\", l=\"Low\")\n\nDonchian Channels\n\nFormula\n\n    beginalign*\n        Up    = max (High_1 to High_t) \n        Mid   = fracUp + Down2 \n        Down  = min (Low_1 to Low_t)\n    endalign*\n\nReference\n\nTradingView Wiki\n\n\n\n"
},

{
    "location": "volatility.html#Donchian-Channels-1",
    "page": "Volatility",
    "title": "Donchian Channels",
    "category": "section",
    "text": "donchian_channelsusing MarketData\nusing MarketTechnicals\n\ndonchian_channels(ohlc)"
},

{
    "location": "volatility.html#MarketTechnicals.keltnerbands",
    "page": "Volatility",
    "title": "MarketTechnicals.keltnerbands",
    "category": "Function",
    "text": "keltnerbands(ohlc, n=20, w=2; h=\"High\", l=\"Low\", c=\"Close\")\n\nKeltner Channels\n\nLinda Bradford Raschke introduced the newer version of Keltner Channels in the 1980s. We implement the newer version.\n\nFormula\n\n    beginalign*\n        textUp    = textMid + w times ATR(n) \n        textMid   = EMA(P_typical n) \n        textDown  = textMid - w times ATR(n)\n    endalign*\n\nReference\n\nStockCharts\nWikipedia\n\n\n\n"
},

{
    "location": "volatility.html#Keltner-Bands-1",
    "page": "Volatility",
    "title": "Keltner Bands",
    "category": "section",
    "text": "keltnerbandsusing MarketData\nusing MarketTechnicals\n\nkeltnerbands(ohlc)"
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
    "location": "volume.html#MarketTechnicals.adl",
    "page": "Volume",
    "title": "MarketTechnicals.adl",
    "category": "Function",
    "text": "adl(ohlcv; h=\"High\", l=\"Low\", c=\"Close\", v=\"Volume\")\n\nAccumulation/Distribution Line\n\nDeveloped by Marc Chaikin.\n\nFormula\n\n    ADL_t = ADL_t-1 +\n        frac(Close_t - Low_t) - (High_t - Close_t)High_t - Low_t\n        times Volume_t\n\nReference\n\nStockCharts\n\n\n\n"
},

{
    "location": "volume.html#Accumulation/Distribution-Line-(ADL)-1",
    "page": "Volume",
    "title": "Accumulation/Distribution Line (ADL)",
    "category": "section",
    "text": "adlusing MarketData\nusing MarketTechnicals\n\nadl(ohlcv)"
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
    "text": "obvusing MarketData\nusing MarketTechnicals\n\nobv(ohlcv)"
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
    "text": "vwapusing MarketData\nusing MarketTechnicals\n\nvwap(ohlcv)"
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
    "text": "The doji pattern is identified with a very small candle body, where the open and closing price are nearly identical. It suggests some ambivalence in the market about what the fair value of the underlying asset is.using TimeSeries\nusing MarketData\nusing MarketTechnicals\n\nfindwhen(doji(ohlc))"
},

{
    "location": "utils.html#",
    "page": "Utilities",
    "title": "Utilities",
    "category": "page",
    "text": ""
},

{
    "location": "utils.html#Utilities-1",
    "page": "Utilities",
    "title": "Utilities",
    "category": "section",
    "text": ""
},

{
    "location": "utils.html#MarketTechnicals.typical",
    "page": "Utilities",
    "title": "MarketTechnicals.typical",
    "category": "Function",
    "text": "typical(ohlc; h=\"High\", l=\"Low\", c=\"Close\")\n\nTypical Price\n\n    textTypical Price = fracH + L + C3\n\n\n\n"
},

{
    "location": "utils.html#Typical-Price-1",
    "page": "Utilities",
    "title": "Typical Price",
    "category": "section",
    "text": "typicalusing MarketData\nusing MarketTechnicals\n\nmerge(ohlc, typical(ohlc))"
},

]}
