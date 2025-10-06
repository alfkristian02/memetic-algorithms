module BinaryDecimalConversion
    export decimal_to_binary, binary_decimal

    function binary_to_decimal(bit_vector::BitVector)::Int
        return sum(bit_vector .* 2 .^(length(bit_vector) .- eachindex(bit_vector)))
    end
end