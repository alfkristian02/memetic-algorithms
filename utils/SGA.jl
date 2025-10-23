# This is an implementation of the SGA, with the option of performing local search which is taken as a parameter

include("population.jl")
include("crossover.jl")

using .PopulationOperators: roulette_wheel_selection
using .CrossoverOperators: one_point_crossover

"""
"""
function SGA(population::BitMatrix, number_of_generations::Int, fitness_function::Function, crossover_probability::Float16, mutation_probability::Float16, local_search=nothing)
    old_population = copy(population)

    new_population = BitMatrix(undef, size(old_population)) 
    for i in 1:1
        parents::Vector{BitVector} = roulette_wheel_selection(old_population, fitness_function, size(old_population, 1))
        offspring::Vector{BitVector} = one_point_crossover(parents, crossover_probability)

        # TODO
    end
end