import pandas as pd
import matplotlib.pyplot as plt

frequency_path = "./runs/credit_12071610.csv"

frequency_df = pd.read_csv(frequency_path)

grouped = frequency_df[["local_search_depth", "fitness_function_accesses"]].groupby(["local_search_depth"]).mean()
print(grouped.head())

plt.figure(figsize=(7, 5))

plt.plot(grouped.index, grouped["fitness_function_accesses"], marker='o')
plt.xlabel("Local search depth")
plt.ylabel("Average fitness function accesses")
plt.title("Local search depth vs Fitness function accesses")
plt.grid(True)
plt.show()