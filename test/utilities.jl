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

    context("wilder_smooth") do
        date = collect(Date(2017, 5, 1):Date(2017, 5, 5))
        ta = TimeArray(date, [0, 10, 5, 6, 7], ["magic"], "meta")
        ta = MarketTechnicals.wilder_smooth(ta, 3)
        @fact ta.timestamp[1] --> Date(2017, 5, 3)
        @fact ta.values[1]    --> 15.
        @fact ta.values[2]    --> 16.
        @fact ta.colnames     --> ["magic"]
        @fact ta.meta         --> "meta"

        ta = TimeArray(date, [0, 10, 5, 6, 7], ["magic"], "meta")
        ta = MarketTechnicals.wilder_smooth(ta, 3, padding=true)
        @fact ta.timestamp[1]     --> Date(2017, 5, 1)
        @fact isnan(ta.values[1]) --> true
        @fact isnan(ta.values[2]) --> true
        @fact ta.values[3]        --> 15.
        @fact ta.values[4]        --> 16.
        @fact ta.colnames         --> ["magic"]
        @fact ta.meta             --> "meta"

        ta = TimeArray(date, [0, 4, 5, 6, 7], ["magic"], "meta")
        ta = MarketTechnicals.wilder_smooth(ta, 3, dx=true)
        @fact ta.timestamp[1] --> Date(2017, 5, 3)
        @fact ta.values[1]    --> 3.
        @fact ta.values[2]    --> 4.
        @fact ta.colnames     --> ["magic"]
        @fact ta.meta         --> "meta"
    end
end
