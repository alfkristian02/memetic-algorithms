module AlfKristianMemeticAlgorithm
    export first_try

    using ProgressMeter

    include("population.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("local_search.jl")

    using .PopulationOperators: initialize_bit_matrix, get_best_individual, random_selection, random_replacement
    using .CrossoverOperators: one_point_crossover
    using .MutationOperators: bit_flip_mutation
    using .LocalSearch: hamming_neighborhood_search

    """
        A simple memetic algorithm

        Serves as the starting point for modularizing the code I will write for this project
    """
    function first_try(population_size, number_of_features, number_of_generations, fitness_function, mutation_rate, local_search_frequency, local_search_depth, save_run)
        population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

        best_per_generation::Union{Vector{Float64}, Nothing} = nothing

        if save_run
            best_per_generation = Vector{Float64}(undef, number_of_generations+1)
            best_per_generation[1] = get_best_individual(population, fitness_function)[2]
        end

        # To show progress bar during execution
        progress_meter = Progress(number_of_generations, dt=1, desc="Computing...")

        for generation = 1:number_of_generations

            parents::Vector{BitVector} = random_selection(population, 2)
            children::Tuple{BitVector, BitVector} = one_point_crossover(parents[1], parents[2])
            mutated_children::Vector{BitVector} = bit_flip_mutation(collect(children), mutation_rate)
            
            if generation%local_search_frequency == 0
                mutated_children = hamming_neighborhood_search(mutated_children, fitness_function, local_search_depth)
            end

            population = random_replacement(population, collect(mutated_children))

            if save_run
                best_per_generation[generation] = get_best_individual(population, fitness_function)[2]
            end

            # Update progress bar
            next!(progress_meter)
        end

        return get_best_individual(population, fitness_function)..., best_per_generation
    end
end