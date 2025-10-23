include("config.jl")
include("utils/population.jl")
include("utils/crossover.jl")
include("utils/mutation.jl")
include("utils/local_search.jl")
include("data/get_fitness_pool.jl")
include("utils/number_conversion.jl")

using .ConfigParameters: population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name, local_search_frequency, local_search_depth, save_run

using .GetFitnessPool: get_precomputed_fitness_pool
using .PopulationOperators: initialize_bit_matrix, random_selection, random_replacement, get_best_individual
using .CrossoverOperators: one_point_crossover
using .MutationOperators: bit_flip_mutation
using .LocalSearch: hamming_neighborhood_search
using .BinaryDecimalConversion: binary_to_decimal, decimal_to_binary

using ProgressMeter
using CSV
using DataFrames
using Dates



const load_fitness::Vector{Float64} = get_precomputed_fitness_pool(joinpath(@__DIR__, "data/precomputed_tables/", dataset_file_name))

function fitness_function(individual)::Float64
    decimal_representation::Int = binary_to_decimal(BitVector(individual))

    if decimal_representation == 0 
        return .0 
    end

    return load_fitness[decimal_representation]
end

population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

if save_run
    best_per_generation::Vector{Float64} = Vector{Float64}(undef, number_of_generations+1)
end

# To show progress bar during execution
progress_meter = Progress(number_of_generations, dt=1, desc="Computing...")

for generation = 1:number_of_generations

    if save_run
        # save best individual in population
        best_per_generation[generation] = get_best_individual(population, fitness_function)[2]
    end

    parents::Vector{BitVector} = random_selection(population, 2)
    children::Tuple{BitVector, BitVector} = one_point_crossover(parents[1], parents[2])
    mutated_children::Vector{BitVector} = bit_flip_mutation(collect(children), mutation_rate)

    if generation%local_search_frequency == 0
        mutated_children = hamming_neighborhood_search(mutated_children, fitness_function, local_search_depth)
    end

    new_population::BitMatrix = random_replacement(population, collect(mutated_children))
    
    # Update progress bar
    next!(progress_meter)
end

best_individual, fitness = get_best_individual(population, fitness_function)

if save_run
    # write the history to file
    best_per_generation[number_of_generations+1] = fitness
    df = DataFrame(column_name = best_per_generation)
    timestamp = Dates.format(now(), "yyyymmddHHMMSS")
    filename = joinpath(@__DIR__, "runs", timestamp * ".csv")
    CSV.write(joinpath(@__DIR__, "runs/", filename), df)
end

println(fitness, best_individual)
println(maximum(load_fitness), decimal_to_binary(argmax(load_fitness), number_of_features))