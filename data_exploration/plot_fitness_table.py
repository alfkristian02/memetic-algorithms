import os
import h5py
import matplotlib.pyplot as plt
import numpy as np

# TODO: use params here also (but they are in .jl file)
file_name = "10-hepatitis_dt_matG.h5"
number_of_features = 19
epsilon = 0.001


def decimal_to_binary_list(value, num_bits):
    return [(value >> i) & 1 for i in reversed(range(num_bits))]


def fitness_function(individual_bits, base_fitness):
    penalty = sum(individual_bits)
    return base_fitness - epsilon * penalty

script_dir = os.path.dirname(os.path.abspath(__file__))
input_dir = os.path.join(script_dir, "../data/", "precomputed_tables_hdf5")

path = os.path.join(input_dir, file_name)

with h5py.File(path, "r") as f:
    key = "single_stored_object"
    load_fitness = np.array(f[key][0])


penalized_fitness = np.zeros_like(load_fitness, dtype=float)

for value in range(len(load_fitness)):
    bits = decimal_to_binary_list(value, number_of_features)
    penalized_fitness[value] = fitness_function(bits, load_fitness[value])

plt.plot(penalized_fitness)
plt.xlabel("Decimal Representation")
plt.ylabel("Fitness")
plt.title(f"Fitness vs. Decimal Representation")
plt.grid()
plt.show()
