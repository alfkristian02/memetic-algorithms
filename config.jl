module ConfigParameters
    export population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name, local_search_frequency, local_search_depth, save_run, crossover_probability, sls_p
    
    # The focus of the project:
    local_search_frequency::Vector{Int} = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 25, 50, 100, 500, 1000]
    local_search_depth::Int = 1

    population_size::Int = 500
    number_of_features::Int = 9
    number_of_generations::Int = 10000
    crossover_probability::Float64 = 0.5
    mutation_rate::Float64 = 0.1
    dataset_file_name::String = "10-hepatitis_dt_matG.jld2" # 01-seeds_dt_mat-1, 04-glass_dt_mat-1, 05-heart-c_dt_mat-1, 10-hepatitis_dt_matG

    save_run::Bool = 1

    sls_p::Float64 = 0.1
end