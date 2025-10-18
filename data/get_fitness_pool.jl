module GetFitnessPool
    export get_precomputed_fitness_pool

    using JLD2

    function get_precomputed_fitness_pool(file_path::String)::Vector{Float64}
        dataset = load(file_path)

        # The fitnesses are stored in the first column of a matrix stored as "single_stored_object"
        fitness_pool = dataset["single_stored_object"][:, 1]

        return fitness_pool
    end
end