using CSV
using DataFrames
using Dates

include("config.jl")
include("data/get_fitness_pool.jl")
include("utils/number_conversion.jl")
include("utils/first_try.jl")
include("utils/SGA.jl")
include("utils/local_search.jl")

using .ConfigParameters: population_size, number_of_generations, mutation_rate, local_search_frequencies, local_search_depths, save_run, crossover_probability, sls_p
using .GetFitnessPool: get_precomputed_fitness_pool
using .BinaryDecimalConversion: binary_to_decimal, decimal_to_binary
using .SGA: sga
using .LocalSearch: SLS

const dataset_file_name::String = "05-heart-c_dt_mat-1.jld2"

println("Starting computation...")

const load_base_fitness::Vector{Float64} = get_precomputed_fitness_pool(joinpath(@__DIR__, "data/precomputed_tables/", dataset_file_name))
const epsilon = 0.001

function fitness_function(individual)::Float64
    decimal_representation = binary_to_decimal(BitVector(individual))
    
    if decimal_representation == 0
        return .0
    end
    
    base_fitness = load_base_fitness[decimal_representation]
    penalty = sum(individual)
    
    return base_fitness - epsilon * penalty
end

const number_of_features::Int = log2(1+length(load_base_fitness))
const global_optima::Float64 = fitness_function(decimal_to_binary(findmax(load_base_fitness)[2], number_of_features))

const timestamp = Dates.format(now(), "mmddHHMM")
const filename = joinpath(@__DIR__, "runs", "heart_" * dataset_file_name * "_" * timestamp * ".csv")

for i in eachindex(local_search_frequencies)
    for j in eachindex(local_search_depths)
        for _ in 1:100
            best_individual, best_fitness, history, fitness_function_accesses, diversity = sga(population_size, number_of_features, number_of_generations, fitness_function, crossover_probability, mutation_rate, save_run, local_search_frequencies[i], local_search_depths[j], sls_p, global_optima, SLS)

            if save_run
                df = DataFrame(
                    local_search_frequency = local_search_frequencies[i],
                    local_search_depth = local_search_depths[j],
                    average_hamming_distance = diversity,
                    fitness_function_accesses = fitness_function_accesses,
                    history = Ref(history)
                )

                CSV.write(filename, df; append=isfile(filename))
            end

        end
    end
end

println("Finished:)")