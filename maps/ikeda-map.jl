#------------------------------------------
# This script specifies the Ikeda map as
# per Ikeda, Kensuke (1979). "Multiple-valued 
# stationary state and its instability of 
# the transmitted light by a ring cavity 
# system". Optics Communications. Elsevier 
# BV. 30 (2): 257–261.
#------------------------------------------

#------------------------------------------
# Author Trent Henderson, 14 September 2021
#------------------------------------------

using Plots, Distributions, Random

Random.seed!(123) # Fix seed for reproduciblity

#-------------- Ikeda map ---------------

function IkedaMap(μ::Float64 = 0.6, τ::Int64 = 1000)
    
    x = zeros(τ)
    y = zeros(τ)
    x[1] = 0.1 * rand(Uniform(0, 1), 1)[1]
    y[1] = 0.1 * rand(Uniform(0, 1), 1)[1]
    t = 0.4 - 6 / (1 + x[1]^ 2 + y[1]^2)
    x[1] = 1 + μ * (x[1] * cos(t) - y[1] * sin(t))
    y[1] = μ * (x[1] * sin(t) + y[1] * cos(t))

    for i in 2:τ
        t = 0.4 - 6 / (1 + x[i-1]^ 2 + y[i-1]^2)
        x[i] = 1 + μ * (x[i-1] * cos(t) - y[i-1] * sin(t))
        y[i] = μ * (x[i-1] * sin(t) + y[i-1] * cos(t))
    end

    p1 = plot(x, y, title = "Ikeda map", xlabel = "x", ylabel = "y")
    return p1
end
