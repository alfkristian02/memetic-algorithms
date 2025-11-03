import pandas as pd
import matplotlib.pyplot as plt

import os
import glob

def plot_latest_csv(folder="./runs"):
    csv_files = glob.glob(os.path.join(folder, "*.csv"))
    if not csv_files:
        print("No CSV files found in the folder.")
        return

    csv_files.sort(reverse=True)

    latest_csv = csv_files[0]
    print(f"Plotting latest CSV: {latest_csv}")
    plot_csv(latest_csv)

def plot_csv(csv_file):
    try:
        df = pd.read_csv(csv_file)

        numeric_cols = df.select_dtypes(include=["float", "int"]).columns
        if len(numeric_cols) == 0:
            print("No numeric columns found to plot.")
            return

        df[numeric_cols].plot(title="CSV Float Data", figsize=(10, 6))

        plt.xlabel("Index")
        plt.ylabel("Values")
        plt.grid()
        plt.tight_layout()
        plt.show()

    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
    except pd.errors.EmptyDataError:
        print("Error: The CSV file is empty or invalid.")
    except Exception as e:
        print(f"Unexpected error: {e}")


plot_latest_csv()