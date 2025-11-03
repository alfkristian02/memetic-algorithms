using JLD2
using HDF5

function convert_jld2_to_hdf5(input_path::String, output_path::String)
    data = JLD2.load(input_path)

    h5open(output_path, "w") do file
        for (key, value) in data
            try
                write(file, key, value)
            catch err
                print(err)
            end
        end
    end
end

input_dir = joinpath(@__DIR__, "precomputed_tables")
output_dir = joinpath(@__DIR__, "precomputed_tables_hdf5")

files = filter(f -> endswith(f, ".jld2"), readdir(input_dir; join=true))

for input_path in files

    println("Converting ", input_path)

    base = splitext(basename(input_path))[1]
    output_path = joinpath(output_dir, base * ".h5")

    try
        convert_jld2_to_hdf5(input_path, output_path)
    catch err
        print(err)
    end
end
