module LocalSearch
    export hamming_neighborhood_search

    include("../data/binary_decimal_conversion.jl")
    using .BinaryDecimalConversion: binary_to_decimal
    
    function combinations(n::Int, h::Int)::Vector{Vector{Int}}
        if h==0 return [[]] end
        if h > n return [] end

        result::Vector{Vector{Int}} = []

        for i in 1:(n-h+1)
            for tail in combinations(n-i, h-1)
                push!(result, [i; map(x -> x + i, tail)])
            end
        end

        return result
    end
    
    function get_neighborhood(individual::BitVector, depth::Int)::Vector{BitVector}
        n::Int = length(individual)
        neighbors::Vector{BitVector} = []

        indices::Vector{Vector{Int}} = []

        for h in 1:depth
            append!(indices, combinations(n, h))
        end
        
        for combination in indices
            c::BitVector = copy(individual)
            for index in combination 
                c[index] = !c[index]
            end
            push!(neighbors, c)
        end

        return neighbors
    end


    function hamming_neighborhood_search(children::Tuple{BitVector, BitVector}, all_fitnesses::Vector{Float64}, depth::Int)::Tuple{BitVector, BitVector}
        best_children = Vector{BitVector}(undef, 2)

        for i in eachindex(children)
            candidates = get_neighborhood(children[i], depth)
            push!(candidates, children[i])

            candidates_decimal_representation = binary_to_decimal.(candidates)

            index_of_zero = findfirst(x -> x == 0, candidates_decimal_representation)

            if index_of_zero !== nothing
                deleteat!(candidates_decimal_representation, index_of_zero)
                deleteat!(candidates, index_of_zero)
            end

            best_index = argmax(all_fitnesses[candidates_decimal_representation])

            best_children[i] = candidates[best_index]
        end
        
        return Tuple(best_children)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    # fitnesses::Vector{Float64}=[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]
    # test::Tuple{BitVector, BitVector} = ([1, 1, 1], [1, 0, 0])
    # print(LocalSearch.hamming_one_neighborhood_search(test, fitnesses))
    
    print(LocalSearch.combinations(3, 2))
    print(LocalSearch.get_neighborhood(BitVector([0,0,0,0,0]),3))
end