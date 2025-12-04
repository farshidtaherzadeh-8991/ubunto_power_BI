import os
import glob
import pandas as pd
from sqlalchemy import create_engine, text

engine = create_engine("postgresql://group6:Gzn4LDT;[[dP%(nnx2_*@195.154.71.31:27675/BI_group6")

with engine.connect() as conn:
    conn.execute(text("CREATE SCHEMA IF NOT EXISTS raw;"))
    conn.commit()

dossier_principal = "BI_Isere_CSV"   

fichiers_csv = glob.glob(os.path.join(dossier_principal, "**/*.csv"), recursive=True)

for fichier in fichiers_csv:
    nom_table = os.path.splitext(os.path.basename(fichier))[0]
    
    print(f"Importation du fichier {fichier} dans la table raw.{nom_table} ...")
    
    df = pd.read_csv(fichier)
    
    df.to_sql(nom_table, engine, schema="raw", if_exists="replace", index=False)

print(" Tous les fichiers CSV ont été importés")
 