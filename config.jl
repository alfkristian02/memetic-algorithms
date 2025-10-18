module ConfigParameters
    export population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name, local_search_frequency, local_search_depth
    
    # The focus of project assignment:
    local_search_frequency::Int = 1  # how often to perform local search
    local_search_depth::Int = 1      # will be the hamming distance, at least for now

    population_size::Int = 500
    number_of_features::Int = 19
    number_of_generations::Int = 100000
    mutation_rate::Float64 = 0.2
    dataset_file_name::String = "10-hepatitis_dt_matG.jld2" # 01-seeds_dt_mat-1, 04-glass_dt_mat-1, 05-heart-c_dt_mat-1, 10-hepatitis_dt_matG
end