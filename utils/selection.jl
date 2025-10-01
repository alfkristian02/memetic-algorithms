module ParentSelectionOperators
    export random_selection, roulette_wheel_selection, tournament_selection
        
    function random_selection(population::BitMatrix, n::Int=2)::Vector{BitVector}
        return BitVector.(eachcol(population)[rand(1:end, n)]) 
    end

    function roulette_wheel_selection() end

    function tournament_selection() end
end