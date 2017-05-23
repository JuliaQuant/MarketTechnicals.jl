facts("Utilities") do
    context("typical price") do
        ts = collect(Date(2017, 5, 1):Date(2017, 5, 5))
        ta = typical(
                TimeArray(ts, reshape(1:15, (5, 3)), ["High", "Low", "Close"]))

        @fact ta.timestamp[1]   --> Date(2017, 5, 1)
        @fact ta.timestamp[end] --> Date(2017, 5, 5)
        @fact ta.values         --> [6, 7, 8, 9, 10]
    end

    context("relu") do
        @fact MarketTechnicals.relu(10)  --> 10
        @fact MarketTechnicals.relu(-5)  --> 0
        @fact MarketTechnicals.relu(0)   --> 0

        date = collect(Date(2017, 5, 1):Date(2017, 5, 3))
        ta = TimeArray(date, [10, -5, 0], ["magic"], "meta")
        ta = MarketTechnicals.relu(ta)
        @fact ta.timestamp[1] --> Date(2017, 5, 1)
        @fact ta.values       --> [10, 0, 0]
        @fact ta.colnames     --> ["magic"]
        @fact ta.meta         --> "meta"
    end
end
