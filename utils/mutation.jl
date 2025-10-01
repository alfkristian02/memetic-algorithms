module MutationOperators
    export bit_flip_mutation

    function bit_flip_mutation(children::Tuple{BitVector, BitVector}, mutation_rate::Float64)::Tuple{BitVector, BitVector}
        for child in children
            for i in eachindex(child)
                if rand() < mutation_rate
                    child[i] = 1 - child[i]
                end
            end
        end

        return children
    end
end