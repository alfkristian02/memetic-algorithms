module PrecomputedFitness
    export get_precomputed_fitness

    using JLD2

    function get_precomputed_fitness(file_name::String)::Vector{Float64}
        dataset = load(joinpath(@__DIR__, "precomputed_tables/", file_name))

        # The fitnesses are stored in the first column of a matrix stored in "single_stored_object"
        all_fitnesses = dataset["single_stored_object"][:, 1]

        return all_fitnesses
    end
end