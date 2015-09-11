facts("Utilities") do

  context("Base.abs returns all positive numbers") do
    @fact sum((abs(cl .- op) .>= 0).values) => length(cl)
  end

  context("pad correctly pads NaN values for non-existent values") do
#    @fact sum((abs(cl .- op) .>= 0).values) => length(cl)
  end

  context("pad correctly pads NaN values for missing values") do
#    @fact sum((abs(cl .- op) .>= 0).values) => length(cl)
  end
end
