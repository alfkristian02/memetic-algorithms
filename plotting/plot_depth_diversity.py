import pandas as pd
import matplotlib.pyplot as plt

frequency_path = "./runs/heart_12071609.csv"

frequency_df = pd.read_csv(frequency_path)

grouped = frequency_df[["local_search_depth", "average_hamming_distance"]].groupby(["local_search_depth"]).mean()
print(grouped.head())

plt.figure(figsize=(7, 5))

plt.plot(grouped.index, grouped["average_hamming_distance"], marker='o')
plt.xlabel("Local search depth")
plt.ylabel("Average Hamming distance")
plt.title("Local search depth vs Average Hamming distance")
plt.grid(True)
plt.show()