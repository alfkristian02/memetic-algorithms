import pandas as pd
import matplotlib.pyplot as plt

frequency_path = "./runs/heart_12071609.csv"

frequency_df = pd.read_csv(frequency_path)

lists = frequency_df["history"].apply(lambda x: 0 if x == "[]" else len(x.strip("[]").split(",")))

bins = lists < 10000

counts = bins.value_counts()

plt.figure(figsize=(7, 5))
bars = plt.bar(["Reached", "Not reached"], counts)

for bar in bars:
    height = bar.get_height()
    plt.text(bar.get_x() + bar.get_width() / 2, height, str(height), ha='center', va='bottom')

plt.ylabel("Number of runs")
plt.title("Number of runs reaching global optima")
plt.grid(axis='y')
plt.show()
