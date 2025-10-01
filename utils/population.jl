module PopulationOperators
    using Random

    export initialize_bit_matrix, random_replacement

    function initialize_bit_matrix(m::Int, n::Int)::BitMatrix
        return Random.bitrand((m, n))
    end

    function random_replacement(population::BitMatrix, new_individuals::Vector{BitVector})::BitMatrix
        # TODO
        # hmm tanke-> hva er forskjellen på en BitMatrix og en BitVector? kan hende jeg kommer meg unna med å bruke kun den ene som hadde gjort ting sykt nice
        return
    end
end