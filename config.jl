module ConfigParameters
    export population_size, number_of_features, number_of_generations, mutation_rate
    
    population_size::Int = 200
    number_of_features::Int = 8
    number_of_generations::Int = 1
    mutation_rate::Float64 = 0.01
end