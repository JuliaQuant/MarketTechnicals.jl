facts("Utilities") do

    context("typical price") do

        ts = collect(Date(2017, 5, 1):Date(2017, 5, 5))
        ta = typical(
                TimeArray(ts, reshape(1:15, (5, 3)), ["High", "Low", "Close"]))

        @fact ta.timestamp[1]   --> Date(2017, 5, 1)
        @fact ta.timestamp[end] --> Date(2017, 5, 5)
        @fact ta.values         --> [6, 7, 8, 9, 10]
    end
end
