import pandas as pd
import matplotlib.pyplot as plt
import sys

def plot_csv(csv_file):
    try:
        # Read the CSV file (automatically detects headers)
        df = pd.read_csv(csv_file)

        # Ensure there are numeric columns to plot
        numeric_cols = df.select_dtypes(include=["float", "int"]).columns
        if len(numeric_cols) == 0:
            print("No numeric columns found to plot.")
            return

        # Plot each numeric column
        df[numeric_cols].plot(title="CSV Float Data", figsize=(10, 6))

        plt.xlabel("Index")
        plt.ylabel("Values")
        plt.grid(True)
        plt.tight_layout()
        plt.show()

    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
    except pd.errors.EmptyDataError:
        print("Error: The CSV file is empty or invalid.")
    except Exception as e:
        print(f"Unexpected error: {e}")

import pandas as pd
import matplotlib.pyplot as plt
import sys

def plot_csv(csv_file):
    try:
        # Read the CSV file (automatically detects headers)
        df = pd.read_csv(csv_file)

        # Ensure there are numeric columns to plot
        numeric_cols = df.select_dtypes(include=["float", "int"]).columns
        if len(numeric_cols) == 0:
            print("No numeric columns found to plot.")
            return

        # Plot each numeric column
        df[numeric_cols].plot(title="CSV Float Data", figsize=(10, 6))

        plt.xlabel("Index")
        plt.ylabel("Values")
        plt.grid(True)
        plt.tight_layout()
        plt.show()

    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
    except pd.errors.EmptyDataError:
        print("Error: The CSV file is empty or invalid.")
    except Exception as e:
        print(f"Unexpected error: {e}")

plot_csv("./runs/2025-10-15_13-11-16.csv")