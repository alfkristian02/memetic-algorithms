include("config.jl")
include("utils/population.jl")
include("utils/selection.jl")
include("utils/crossover.jl")
include("utils/mutation.jl")

using .ConfigParameters: population_size, number_of_features, number_of_generations, mutation_rate
using .PopulationInitializer: initialize_bit_matrix
using .ParentSelectionOperators: random_selection
using .CrossoverOperators: one_point_crossover
using .MutationOperators: bit_flip_mutation

population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

for generation = 1:number_of_generations
    parents::Tuple{BitVector, BitVector} = Tuple(random_selection(population, 2))

    children::Tuple{BitVector, BitVector} = one_point_crossover(parents)

    mutated_children::Tuple{BitVector, BitVector} = bit_flip_mutation(children, mutation_rate)

    # local search here -> kind of need it to make the algorithm memetic
    
    # could do some crowding but is that common in memetic algorithms? kind of defeats the local search no? maybe do it before the local search then. See if there are any papers on it.

    new_population::BitMatrix = random_replacement(population)

    print("It ran")
end