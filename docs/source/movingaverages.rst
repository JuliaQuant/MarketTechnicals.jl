Moving averages
===============

.. highlight:: julia

simple moving average
---------------------


exponential moving average
--------------------------

::

    julia> ema(cl, 10, wilder=true)
    496x1 TimeArray{Float64,1} 1980-01-16 to 1981-12-31

                 Close
    1980-01-16 | 108.89
    1980-01-17 | 109.07
    1980-01-18 | 109.27
    1980-01-21 | 109.56
    ...
    1981-12-24 | 123.44
    1981-12-28 | 123.33
    1981-12-29 | 123.16
    1981-12-30 | 123.07
    1981-12-31 | 123.02
