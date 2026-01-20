import pandas as pd
import matplotlib.pyplot as plt

frequency_path = "./runs/hep_12071608.csv"

frequency_df = pd.read_csv(frequency_path)

grouped = frequency_df[["local_search_frequency", "average_hamming_distance"]].groupby(["local_search_frequency"]).mean()
print(grouped.head())

plt.figure(figsize=(7, 5))

line = grouped.query("local_search_frequency == 0")
plt.axhline(float(line["average_hamming_distance"]), linestyle='-', label="no local search", color='red')

grouped = grouped.query("local_search_frequency <= 50 and local_search_frequency > 0")
plt.scatter(grouped.index, grouped["average_hamming_distance"], marker='o')
plt.xlabel("Local search period")
plt.ylabel("Average hamming distance")
plt.title("Local search period vs Average hamming distance")
plt.grid(True)
plt.show()