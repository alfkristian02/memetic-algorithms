module ConfigParameters
    export EPSILON, population_size, number_of_generations, mutation_rate, local_search_frequencies, local_search_depths, save_run, crossover_probability, sls_p
    
    const EPSILON::Float64 = 0.001

    local_search_frequencies::Vector{Int} = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 50, 75, 100, 150, 250, 500]
    local_search_depths::Vector{Int} = [1, 2, 3, 4, 5]

    population_size::Int = 250
    number_of_generations::Int = 10000
    crossover_probability::Float64 = 0.25
    mutation_rate::Float64 = 0.05

    save_run::Bool = 0

    sls_p::Float64 = 0.1
end
