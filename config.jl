module ConfigParameters
    export dataset_file_name, fitness_function, population_size, number_of_generations, mutation_rate, local_search_frequencies, local_search_depths, save_run, crossover_probability, sls_p
    
    const dataset_file_name::String = "05-heart-c_dt_mat-1.jld2" # 05-heart-c_dt_mat-1.jld2 || 07-credit-a_dt_matG.jld2 || 10-hepatitis_dt_matG.jld2
    
    const EPSILON::Float64 = 0.001

    function fitness_function(base_fitness_vector::Vector{Float64}, individual_binary::BitVector, individual_decimal::Int)::Float64
        if individual_decimal == 0
            return .0
        end
        
        return base_fitness_vector[individual_decimal] - EPSILON * sum(individual_binary)
    end

    # local_search_frequencies::Vector{Int} = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 50, 75, 100, 150, 250, 500]
    local_search_frequencies::Vector{Float64} = [.0, 1.0]
    local_search_depths::Vector{Int} = [1]

    population_size::Int = 250
    number_of_generations::Int = 5
    crossover_probability::Float64 = 0.25
    mutation_rate::Float64 = 0.05

    save_run::Bool = 0

    sls_p::Float64 = 0.1
end
