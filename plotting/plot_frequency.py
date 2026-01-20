import pandas as pd
import matplotlib.pyplot as plt

frequency_path = "./runs/hep_12071608.csv"

frequency_df = pd.read_csv(frequency_path)

frequency_df["num_generations"] = frequency_df["history"].apply(lambda x: 0 if x == "[]" else len(x.strip("[]").split(",")))

grouped = frequency_df[["local_search_frequency", "num_generations"]].groupby(["local_search_frequency"]).mean()
print(grouped.head())

plt.figure(figsize=(7, 5))

line = grouped.query("local_search_frequency == 0")
plt.axhline(float(line["num_generations"]), linestyle='-', label="no local search", color='red')

grouped = grouped.query("local_search_frequency <= 50 and local_search_frequency > 0")
plt.scatter(grouped.index, grouped["num_generations"], marker='o')
plt.xlabel("Local search period")
plt.ylabel("Average number of generations")
plt.title("Local search period vs Number of generations")
plt.grid(True)
plt.show()