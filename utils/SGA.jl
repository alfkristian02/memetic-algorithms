module SGA
    export sga

    include("population.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("diversity_metrics.jl")

    using .PopulationOperators: initialize_bit_matrix, roulette_wheel_selection, get_best_individual
    using .CrossoverOperators: one_point_crossover
    using .MutationOperators: bit_flip_mutation
    using .DiversityMetrics: average_hamming_distance

    """
        Implementation of the Simple Genetic Algorithm (SGA)
        
        The only alternation to the original one, is that there is an optional parameter (local_search)
        used to perform local search if present.
    """
    function sga(population_size::Int, number_of_features::Int, number_of_generations::Int, fitness_function::Function, crossover_probability::Float64, mutation_probability::Float64, save_run::Bool, local_search_frequency::Float64, local_search_depth::Int, sls_p::Float64, global_optima, local_search=nothing)
        population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)
        global_best_individual = get_best_individual(population, fitness_function)
        fitness_function_accesses::Int = 0

        best_per_generation = save_run ? Float64[] : nothing

        if save_run
            push!(best_per_generation, global_best_individual[2])
        end

        for _ = 1:number_of_generations
            parents::Vector{BitVector} = roulette_wheel_selection(population, fitness_function, size(population, 1))

            fitness_function_accesses += population_size
            # TODO: shuffle the mating pool (should maybe check if this is what is done in the original)

            offspring::Vector{BitVector} = one_point_crossover(parents, crossover_probability)

            mutations::Vector{BitVector} = bit_flip_mutation(offspring, mutation_probability) 
            
            if local_search !== nothing && local_search_frequency !== 0.0 && local_search_depth !== nothing && sls_p !== nothing
                if rand() < local_search_frequency
                    mutations = local_search(mutations, fitness_function, local_search_depth, sls_p)
                    fitness_function_accesses += sum(binomial(number_of_features, k) for k in 0:local_search_depth)
                end
            end

            population = reshape(reduce(vcat, mutations), population_size, number_of_features)

            best_individual = get_best_individual(population, fitness_function)
            fitness_function_accesses += population_size
            
            if best_individual[2] > global_best_individual[2]
                global_best_individual = best_individual
            end

            if save_run
                push!(best_per_generation, best_individual[2])
            end

            if best_individual[2] == global_optima
                break
            end
        end

        return global_best_individual..., best_per_generation, fitness_function_accesses, DiversityMetrics.average_hamming_distance([BitVector(population[i, :]) for i in 1:size(population, 1)])
    end
end