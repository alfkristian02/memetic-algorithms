include("config.jl")
include("utils/population.jl")
include("utils/selection.jl")
include("utils/crossover.jl")
include("utils/mutation.jl")
include("utils/local_search.jl")
include("data/binary_decimal_conversion.jl")
include("data/get_fitness.jl")

using .ConfigParameters: population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name
using .PopulationOperators: initialize_bit_matrix, random_replacement, get_best_individual
using .ParentSelectionOperators: random_selection
using .CrossoverOperators: one_point_crossover
using .MutationOperators: bit_flip_mutation
using .LocalSearch: hamming_one_neighborhood_search
using .BinaryDecimalConversion: binary_to_decimal
using .PrecomputedFitness: get_precomputed_fitness

using ProgressMeter
using CSV
using DataFrames
using Dates

all_fitnesses::Vector{Float64} = get_precomputed_fitness(dataset_file_name)

population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

best_individuals_through_time::Vector{Float64} = Vector{Float64}(undef, number_of_generations+1)

# To show progress underway
progress_meter = Progress(number_of_generations, dt=1, desc="Computing...")

for generation = 1:number_of_generations

    # save best individual in population
    best_individuals_through_time[generation] = get_best_individual(population, all_fitnesses)[2]

    parents::Tuple{BitVector, BitVector} = random_selection(population)
    children::Tuple{BitVector, BitVector} = one_point_crossover(parents)
    mutated_children::Tuple{BitVector, BitVector} = bit_flip_mutation(children, mutation_rate)
    improved_children::Tuple{BitVector, BitVector} = hamming_one_neighborhood_search(mutated_children, all_fitnesses)
    new_population::BitMatrix = random_replacement(population, improved_children)
    
    # Update progress
    next!(progress_meter)
end

best_individual, fitness = get_best_individual(population, all_fitnesses)

# write the history to file
best_individuals_through_time[number_of_generations+1] = fitness
df = DataFrame(column_name = best_individuals_through_time)
timestamp = Dates.format(now(), "yyyy-mm-dd_HH-MM-SS")
filename = joinpath(@__DIR__, "runs", timestamp * ".csv")
CSV.write(joinpath(@__DIR__, "runs/", filename), df)

println(best_individual, fitness)
println(all_fitnesses[argmax(all_fitnesses)])