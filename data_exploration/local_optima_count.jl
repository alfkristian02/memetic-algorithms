include("../data/get_fitness_pool.jl")
include("../utils/number_conversion.jl")
include("../utils/local_search.jl")

using .GetFitnessPool: get_precomputed_fitness_pool
using .BinaryDecimalConversion: decimal_to_binary, binary_to_decimal
using .LocalSearch: get_neighborhood

dataset_file_name::String = "05-heart-c_dt_mat-1.jld2"
number_of_features::Int = 13

const load_fitness::Vector{Float64} = get_precomputed_fitness_pool(joinpath(@__DIR__, "../data/precomputed_tables/", dataset_file_name))

function fitness_function(individual)::Float64
    decimal_representation::Int = binary_to_decimal(BitVector(individual))

    if decimal_representation == 0 
        return .0 
    end

    return load_fitness[decimal_representation]
end

count::Int = 0

for value in eachindex(load_fitness)
    binary = decimal_to_binary(value, number_of_features)
    current_fitness = fitness_function(binary)

    neighborhood = get_neighborhood(binary, 1)

    best_fitness = findmax(map(fitness_function, neighborhood))[1]

    if current_fitness == best_fitness
        global count = count+1
    end
end

println("Number of local optima: ", count)