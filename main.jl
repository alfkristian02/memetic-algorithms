include("config.jl")
include("utils/population.jl")
include("utils/selection.jl")
include("utils/crossover.jl")
include("utils/mutation.jl")
include("utils/local_search.jl")

include("data/binary_decimal_conversion.jl")
include("data/get_fitness.jl")

using .ConfigParameters: population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name
using .PopulationOperators: initialize_bit_matrix
using .ParentSelectionOperators: random_selection
using .CrossoverOperators: one_point_crossover
using .MutationOperators: bit_flip_mutation
using .LocalSearch: hamming_one_neighborhood_search

using .BinaryDecimalConversion: binary_to_decimal
using .PrecomputedFitness: get_precomputed_fitness

all_fitnesses::Vector{Float64} = get_precomputed_fitness(dataset_file_name)

# Initialize population
population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

for generation = 1:number_of_generations
    parents::Tuple{BitVector, BitVector} = random_selection(population)
    children::Tuple{BitVector, BitVector} = one_point_crossover(parents)
    mutated_children::Tuple{BitVector, BitVector} = bit_flip_mutation(children, mutation_rate)
    improved_children::Tuple{BitVector, BitVector} = hamming_one_neighborhood_search(mutated_children, all_fitnesses)
    
    # Todo: this is started on
    # new_population::BitMatrix = random_replacement(population)

    print("It ran")
end