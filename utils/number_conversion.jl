"""
    Convert BitVector to decimal number.
"""
function binary_to_decimal(bit_vector::BitVector)::Int
    return sum(bit_vector .* 2 .^(length(bit_vector) .- eachindex(bit_vector)))
end

"""
    Convert decimal number to BitVector
"""
function decimal_to_binary(decimal::Int, length::Int)
    return BitVector(((decimal >> (length - i)) & 1) == 1 for i in 1:length)
end