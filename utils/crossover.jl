module CrossoverOperators
    export one_point_crossover

    """
        Perform one point crossover between two individuals
    """
    function one_point_crossover(individual_one::BitVector, individual_two::BitVector)::Tuple{BitVector, BitVector}
        if length(individual_one) != length(individual_two)
            error("Error thrown in file \"crossover.jl\", line 3: The two individuals have different dimensions.")
        end

        individual_length::Int = length(individual_one) 

        crossover_point::Int = rand(1:individual_length)

        child_one::BitVector = [individual_one[1:crossover_point] ; individual_two[crossover_point+1:individual_length]]
        child_two::BitVector = [individual_two[1:crossover_point] ; individual_one[crossover_point+1:individual_length]]

        return child_one, child_two
    end

    """
        Perform one point crossover on consecutive pairs of individuals with specified probability. 
    """
    function one_point_crossover(individuals::Vector{BitVector}, crossover_probability::Float64)::Vector{BitVector}
        if length(individuals)%2 !== 0
            error("Error thrown in file \"crossover.jl\", line 27: The vector is of odd length.") 
        end

        new_individuals = Vector{BitVector}(undef, length(individuals))

        for i in 1:2:length(individuals)
            if rand() < crossover_probability
                new_individuals[i], new_individuals[i+1] = one_point_crossover(individuals[i], individuals[i+1])
            else
                new_individuals[i], new_population[i+1] = individuals[i], individuals[i+1]
            end
        end

        return new_individuals
    end
end