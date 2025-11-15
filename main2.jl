using CSV
using DataFrames
using Dates
using ProgressMeter

include("config.jl")
include("data/get_fitness_pool.jl")
include("utils/number_conversion.jl")
include("utils/first_try.jl")
include("utils/SGA.jl")
include("utils/local_search.jl")

using .ConfigParameters: population_size, number_of_generations, mutation_rate, dataset_file_name, local_search_frequency, local_search_depth, save_run, crossover_probability, sls_p
using .GetFitnessPool: get_precomputed_fitness_pool
using .BinaryDecimalConversion: binary_to_decimal, decimal_to_binary
using .SGA: sga
using .LocalSearch: SLS

println("Starting computation...")

const load_fitness::Vector{Float64} = get_precomputed_fitness_pool(joinpath(@__DIR__, "data/precomputed_tables/", dataset_file_name))
const global_optima::Float64 = maximum(load_fitness)
const number_of_features::Int = log2(1+length(load_fitness))

function fitness_function(individual)::Float64
    decimal_representation::Int = binary_to_decimal(BitVector(individual))

    if decimal_representation == 0 
        return .0 
    end

    return load_fitness[decimal_representation]
end


timestamp = Dates.format(now(), "mmddHHMM")
filename = joinpath(@__DIR__, "runs", "depth_" * timestamp * ".csv")


@showprogress "Iterating the local search depth: " for i in 1:500
    for _ in 1:100
        best_individual, best_fitness, history, fitness_function_accesses = sga(population_size, number_of_features, number_of_generations, fitness_function, crossover_probability, mutation_rate, save_run, i, 1, sls_p, global_optima, SLS)

        if save_run
            df = DataFrame(
                local_search_frequency = i,
                history = Ref(history),
                fitness_function_accesses = fitness_function_accesses
            )
            CSV.write(filename, df; append=isfile(filename))
        end
    end
end

println("Finished:)")