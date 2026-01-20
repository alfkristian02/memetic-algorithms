include("../config.jl")
include("../data/get_fitness_pool.jl")
include("../utils/number_conversion.jl")
include("../utils/local_search.jl")

using .ConfigParameters: EPSILON
using .GetFitnessPool: get_precomputed_fitness_pool
using .BinaryDecimalConversion: decimal_to_binary, binary_to_decimal


const file_name::String = "05-heart-c_dt_mat-1.jld2" # 05-heart-c_dt_mat-1.jld2 || 07-credit-a_dt_matG.jld2 || 10-hepatitis_dt_matG.jld2
const load_fitness::Vector{Float64} = get_precomputed_fitness_pool(joinpath(@__DIR__, "../data/precomputed_tables/", file_name))
const number_of_features::Int = log2(1+length(load_fitness))

function fitness_function(individual)::Float64
    decimal_representation = binary_to_decimal(BitVector(individual))

    if decimal_representation == 0
        return .0
    end

    base_fitness = load_fitness[decimal_representation]
    penalty = sum(individual)

    return base_fitness - EPSILON * penalty
end

all_fitness_values = Vector{Float64}(undef, length(load_fitness))

for value in eachindex(load_fitness)
    binary = decimal_to_binary(value, number_of_features)
    all_fitness_values[value] = fitness_function(binary)
end

global_max_fitness = maximum(all_fitness_values)
count_global_optima = count(==(global_max_fitness), all_fitness_values)

println("Global optimum fitness value: ", global_max_fitness)
println("Number of global optima: ", count_global_optima)
