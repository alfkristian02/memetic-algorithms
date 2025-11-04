import os
import h5py
import matplotlib.pyplot as plt

script_dir = os.path.dirname(os.path.abspath(__file__))
input_dir = os.path.join(script_dir, "../data/", "precomputed_tables_hdf5")

filename = "01-seeds_dt_mat-1.h5"
path = os.path.join(input_dir, filename)

with h5py.File(path, "r") as f:
    key = "single_stored_object"
    data = f[key][0]

plt.plot(data)
plt.xlabel("Index")
plt.ylabel("Fitness")
plt.title(f"{filename} : fitness")
plt.grid()
plt.show()