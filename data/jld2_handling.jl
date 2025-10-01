using JLD2

file = load("precomputed_tables/01-seeds_dt_mat-1.jld2")

data_matrix = file["single_stored_object"]

number_of_rows, number_of_columns = size(data_matrix)

for i in 1:size(data_matrix)[1]
    # print(i)
    for j in 1:size(data_matrix)[2]
        print(data_matrix[i, j], " \t ")
    end
    println(" ")
end

