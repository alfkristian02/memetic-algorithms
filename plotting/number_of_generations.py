import pandas as pd
import matplotlib.pyplot as plt

dataset_paths = [
    "./runs/heart_12071609.csv",
    "./runs/credit_12071610.csv",
    "./runs/hep_12071608.csv",
]

dataset_names = ["Heart-C", "Credit-A", "Hepatitis"]
avg_generations = []

for path in dataset_paths:
    df = pd.read_csv(path)
    
    histories = df["history"].apply(lambda x: 0 if x == "[]" else len(x.strip("[]").split(",")))
    
    found = histories[histories != 1001]
    
    avg_gen = found.mean()
    avg_generations.append(avg_gen)

plt.figure(figsize=(7, 5))
bars = plt.bar(dataset_names, avg_generations, color=["skyblue", "salmon", "lightgreen"])

for bar in bars:
    height = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, height, f"{height:.1f}", ha='center', va='bottom')

plt.ylabel("Average generations to optimum")
plt.title("Average generations before optimum found per dataset")
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()
