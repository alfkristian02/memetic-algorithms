module CrossoverOperators
    function one_point_crossover(parents::Tuple{BitVector, BitVector})::Tuple{BitVector, BitVector}
        if length(parents[1]) != length(parents[2])
            error("Error thrown in file \"crossover.jl\", line 3: The two parents have different dimensions")
        end

        parents_length::Int = length(parents[1]) 

        crossover_point::Int = rand(1:parents_length)

        child_one::BitVector = [parents[1][1:crossover_point] ; parents[2][crossover_point+1:parents_length]]
        child_two::BitVector = [parents[2][1:crossover_point] ; parents[1][crossover_point+1:parents_length]]

        return child_one, child_two
    end
end