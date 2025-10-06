module ConfigParameters
    export population_size, number_of_features, number_of_generations, mutation_rate, dataset_file_name
    
    population_size::Int = 200
    number_of_features::Int = 7
    number_of_generations::Int = 1
    mutation_rate::Float64 = 0.01
    dataset_file_name::String = "01-seeds_dt_mat-1.jld2"
end