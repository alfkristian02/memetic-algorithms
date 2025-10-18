module MutationOperators
    export bit_flip_mutation

    """
        Flip a bit with probability equal to the mutation rate.
    """
    function bit_flip_mutation(children::Vector{BitVector}, mutation_rate::Float64)::Vector{BitVector}
        children_copy = copy(children)
        
        for child in children_copy
            for i in eachindex(child)
                if rand() < mutation_rate
                    child[i] = 1 - child[i]
                end
            end
        end

        return children_copy
    end
end