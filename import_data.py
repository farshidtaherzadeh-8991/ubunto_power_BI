import os
import pandas as pd
from sqlalchemy import create_engine

csv_folder = "BI_project/BI_Isere_CSV"

engine = create_engine("postgresql://group6:Gzn4LDT;[[dP%(nnx2_*@195.154.71.31:27675/BI_group6")

target_schema = "source_isere_raw"

for file in os.listdir(csv_folder):
    if file.endswith(".csv"):
        file_path = os.path.join(csv_folder, file)
        table_name = os.path.splitext(file)[0].lower().replace(" ", "_").replace("-", "_")
        print(f" Loading {file} → table {target_schema}.{table_name}")
        try:
            df = pd.read_csv(file_path, encoding="utf-8")
            df.to_sql(table_name, engine, schema=target_schema, if_exists="replace", index=False)
        except Exception as e:
            print(f" Error loading {file}: {e}")