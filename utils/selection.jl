module ParentSelectionOperators
    export random_selection, roulette_wheel_selection, tournament_selection
        
    function random_selection(population::BitMatrix)::Tuple{BitVector, BitVector}
        selected = BitVector.(eachrow(population)[rand(1:size(population, 1), 2)])
        return (selected[1], selected[2])
    end

    function roulette_wheel_selection() end

    function tournament_selection() end
end

if abspath(PROGRAM_FILE) == @__FILE__
    test::BitMatrix = BitMatrix([1 0 1 ;0 0 0])
    print(ParentSelectionOperators.random_selection(test))
end