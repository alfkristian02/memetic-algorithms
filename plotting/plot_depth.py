import pandas as pd
import matplotlib.pyplot as plt
import ast
from statsmodels.nonparametric.smoothers_lowess import lowess

frequency_path = "./runs/depth_11151748.csv"

try:
    frequency_df = pd.read_csv(frequency_path)

    # convert stringified list into real list
    col_list = frequency_df.columns[1]
    frequency_df[col_list] = frequency_df[col_list].apply(ast.literal_eval)

    # group by frequency
    grouped = frequency_df.groupby(frequency_df.columns[0])

    # average length of list in each group
    x = grouped[col_list].apply(lambda s: s.apply(len).mean())
    y = grouped[frequency_df.columns[0]].first()

    # load other df
    # sga_df = pd.read_csv("./runs/no_local_search_11151124.csv")
    # sga_df['history'] = sga_df['history'].apply(ast.literal_eval)
    # sga_y = sga_df['history'].apply(len).mean()
    sga_y = 1119.8609
    # print(sga_y)

    plt.figure(figsize=(10, 6))

    # plot grouped series
    plt.plot(y, x, marker='o', label='Grouped Averages')

    x_vals = y.values.astype(float)
    y_vals = x.values.astype(float)
    smooth = lowess(y_vals, x_vals, frac=0.3)
    plt.plot(smooth[:,0], smooth[:,1], color='black', linewidth=2, label='Smooth Curve (LOWESS)')

    # horizontal SGA reference line
    plt.axhline(sga_y, color='red', linestyle=':', label='SGA Average (Horizontal)')

    plt.title("Average Length vs " + frequency_df.columns[0])
    plt.xlabel(frequency_df.columns[0])
    plt.ylabel("Average Length of " + frequency_df.columns[1])
    plt.grid()
    plt.legend()
    plt.tight_layout()
    plt.show()

except Exception as e:
    print("Error:", e)
