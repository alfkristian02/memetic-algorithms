module MutationOperators
    export bit_flip_mutation

    """
        Flip a bit with probability equal to the mutation rate.
    """
    function bit_flip_mutation(individuals::Vector{BitVector}, mutation_rate::Float64)::Vector{BitVector}
        individuals_copy = copy(individuals)
        
        for individual in individuals_copy
            for i in eachindex(individual)
                if rand() < mutation_rate
                    individual[i] = 1 - individual[i]
                end
            end
        end

        return individuals_copy
    end
end