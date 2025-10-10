module PopulationOperators
    using Random

    export initialize_bit_matrix, random_replacement, get_best_individual

    function initialize_bit_matrix(m::Int, n::Int)::BitMatrix
        return Random.bitrand((m, n))
    end

    function random_replacement(population::BitMatrix, new_individuals::Tuple{BitVector, BitVector})::BitMatrix
        indexes = rand(1:size(population, 1), length(new_individuals))

        population[indexes, :] = vcat(new_individuals...)

        return population
    end

    function get_best_individual(candidates::BitMatrix, all_fitnesses::Vector{Float64})::Tuple{BitVector, Float64}
        candidates_copy = [copy(row) for row in eachrow(candidates)]

        candidates_decimal_representation = binary_to_decimal.(candidates_copy)

        index_of_zero = findfirst(x -> x == 0, candidates_decimal_representation)

        if index_of_zero !== nothing
            deleteat!(candidates_decimal_representation, index_of_zero)
            deleteat!(candidates_copy, index_of_zero)
        end

        best_index = argmax(all_fitnesses[candidates_decimal_representation])

        return candidates_copy[best_index], all_fitnesses[candidates_decimal_representation[best_index]]
    end

    function binary_to_decimal(bit_vector::BitVector)::Int
        return sum(bit_vector .* 2 .^(length(bit_vector) .- eachindex(bit_vector)))
    end
end

if abspath(PROGRAM_FILE) == @__FILE__        
    test::BitMatrix = BitMatrix([1 0 1 ; 0 0 0])
    vector::Vector{BitVector} = [[1, 1, 1]]

    print(PopulationOperators.random_replacement(test, vector))
end