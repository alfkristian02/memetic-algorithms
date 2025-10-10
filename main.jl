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

all_fitnesses::Vector{Float64} = get_precomputed_fitness(dataset_file_name)

population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

# To show progress underway
progress_meter = Progress(number_of_generations, dt=1, desc="Computing...")

for generation = 1:number_of_generations

    parents::Tuple{BitVector, BitVector} = random_selection(population)
    children::Tuple{BitVector, BitVector} = one_point_crossover(parents)
    mutated_children::Tuple{BitVector, BitVector} = bit_flip_mutation(children, mutation_rate)
    improved_children::Tuple{BitVector, BitVector} = hamming_one_neighborhood_search(mutated_children, all_fitnesses)
    new_population::BitMatrix = random_replacement(population, improved_children)
    
    # Update progress
    next!(progress_meter)
end

# Give the best individual maybe?

best_individual, fitness = get_best_individual(population, all_fitnesses)

println(best_individual, fitness)

println(all_fitnesses[argmax(all_fitnesses)])