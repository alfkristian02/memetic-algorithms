module ConfigParameters
    export population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name
    
    population_size::Int = 300
    number_of_features::Int = 13
    number_of_generations::Int = 10000
    mutation_rate::Float64 = 0.1
    dataset_file_name::String = "05-heart-c_dt_mat-1.jld2" # 01-seeds_dt_mat-1, 04-glass_dt_mat-1, 05-heart-c_dt_mat-1, 10-hepatitis_dt_matG
end