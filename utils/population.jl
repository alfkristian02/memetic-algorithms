module PopulationOperators
    export initialize_bit_matrix, random_selection, random_replacement, get_best_individual

    using Random

    include("number_conversion.jl")
    using .BinaryDecimalConversion: binary_to_decimal

    """
        Initialize a bit matrix with m rows and n columns.
    """
    function initialize_bit_matrix(m::Int, n::Int)::BitMatrix
        return Random.bitrand((m, n))
    end
    
    """
        Select n random individuals from the population.

    """
    function random_selection(population::BitMatrix, n::Int)::Vector{BitVector}
        indices = rand(1:size(population, 1), n)

        return eachrow(population)[indices]
    end

    
    """
        Replace randomly selected individuals in the population with the incoming ones.

    """
    function random_replacement(population::BitMatrix, incoming_individuals::Vector{BitVector})::BitMatrix
        indices = rand(1:size(population, 1), length(incoming_individuals))

        population[indices, :] = vcat(incoming_individuals...)

        return population
    end

    """
        Get the best individual among the candidates, given a fitness pool.

    """
    function get_best_individual(candidates::BitMatrix, fitness_pool::Vector{Float64})::Tuple{BitVector, Float64}
        candidates_copy = [copy(row) for row in eachrow(candidates)]

        candidates_decimal_representation = binary_to_decimal.(candidates_copy)

        index_of_zero = findall(x -> x == 0, candidates_decimal_representation)

        if index_of_zero !== nothing
            deleteat!(candidates_decimal_representation, index_of_zero)
            deleteat!(candidates_copy, index_of_zero)
        end

        best_index = argmax(fitness_pool[candidates_decimal_representation])

        return candidates_copy[best_index], fitness_pool[candidates_decimal_representation[best_index]]
    end
end

if abspath(PROGRAM_FILE) == @__FILE__        
    test::BitMatrix = BitMatrix([1 0 1 ; 0 0 0])
    vector::BitVector = [1, 1, 1]

    println(PopulationOperators.binary_to_decimal(vector))
end