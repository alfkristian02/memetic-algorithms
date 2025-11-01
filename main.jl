using CSV
using DataFrames
using Dates

include("config.jl")
include("data/get_fitness_pool.jl")
include("utils/number_conversion.jl")
include("utils/first_try.jl")
include("utils/SGA.jl")

using .ConfigParameters: population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name, local_search_frequency, local_search_depth, save_run, crossover_probability
using .GetFitnessPool: get_precomputed_fitness_pool
using .BinaryDecimalConversion: binary_to_decimal, decimal_to_binary
using .AlfKristianMemeticAlgorithm: first_try
using .SGA: sga


const load_fitness::Vector{Float64} = get_precomputed_fitness_pool(joinpath(@__DIR__, "data/precomputed_tables/", dataset_file_name))

function fitness_function(individual)::Float64
    decimal_representation::Int = binary_to_decimal(BitVector(individual))

    if decimal_representation == 0 
        return .0 
    end

    return load_fitness[decimal_representation]
end


# Run algorithm
# best_individual, best_fitness, history = first_try(population_size, number_of_features, number_of_generations, fitness_function, mutation_rate, local_search_frequency, local_search_depth, save_run)
best_individual, best_fitness, history = sga(population_size, number_of_features, number_of_generations, fitness_function, crossover_probability, mutation_rate, save_run)


if save_run
    # write the history to file
    df = DataFrame(column_name = history)
    timestamp = Dates.format(now(), "yyyymmddHHMMSS")
    filename = joinpath(@__DIR__, "runs", timestamp * ".csv")
    CSV.write(joinpath(@__DIR__, "runs/", filename), df)
end

println(best_fitness, best_individual)
println(maximum(load_fitness), decimal_to_binary(argmax(load_fitness), number_of_features))