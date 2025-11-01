module SGA
    export sga

    using ProgressMeter

    include("population.jl")
    include("crossover.jl")
    include("mutation.jl")

    using .PopulationOperators: initialize_bit_matrix, roulette_wheel_selection, get_best_individual
    using .CrossoverOperators: one_point_crossover
    using .MutationOperators: bit_flip_mutation

    """
        Implementation of the Simple Genetic Algorithm (SGA)
        
        The only alternation to the original one, is that there is an optional parameter (local_search)
        used to perform local search if present.
    """
    function sga(population_size::Int, number_of_features::Int, number_of_generations::Int, fitness_function::Function, crossover_probability::Float64, mutation_probability::Float64, save_run::Bool, local_search=nothing)
        population::BitMatrix = initialize_bit_matrix(population_size, number_of_features)

        best_per_generation::Union{Vector{Float64}, Nothing} = nothing

        if save_run
            best_per_generation = Vector{Float64}(undef, number_of_generations+1)
            best_per_generation[1] = get_best_individual(population, fitness_function)[2]
        end

        progress_meter = Progress(number_of_generations, dt=1, desc="Computing...")

        for generation = 1:number_of_generations
            parents::Vector{BitVector} = roulette_wheel_selection(population, fitness_function, size(population, 1))

            # TODO: shuffle the mating pool (should maybe check if this is what is done in the original)

            offspring::Vector{BitVector} = one_point_crossover(parents, crossover_probability)

            mutations::Vector{BitVector} = bit_flip_mutation(offspring, mutation_probability) 
            
            # TODO: perform LS if parameter is present. Take heed to LS depth and frequency

            population = reshape(reduce(vcat, mutations), population_size, number_of_features)

            if save_run
                best_per_generation[generation] = get_best_individual(population, fitness_function)[2]
            end

            next!(progress_meter)
        end

        return get_best_individual(population, fitness_function)..., best_per_generation
    end
end