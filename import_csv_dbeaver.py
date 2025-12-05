import pandas as pd
import psycopg2
from psycopg2.extras import execute_values


# connection parameters
CSV_FOLDER = "../Projet_BI/0csv"
DB_NAME = "BI_group6"
DB_USER = "group6"  
DB_PASSWORD = "Gzn4LDT;[[dP%(nnx2_*"
DB_HOST = "195.154.71.31"
DB_PORT = "27675"
SCHEMA = "dwh_raw"


# chemins vers tes CSV
FILES = {
    "dates": f"{CSV_FOLDER}/dates.csv",
    "ref_tranche_effectifs_unite_legale": f"{CSV_FOLDER}/ref_tranche_effectifs_unite_legale.csv",
    "population_municipale_communes_france": f"{CSV_FOLDER}/POPULATION_MUNICIPALE_COMMUNES_FRANCE - III_1_insee_population_fr_commu.csv",
    "naf2008_liste_n5": f"{CSV_FOLDER}/naf2008_liste_n5.csv",
    "naf2008_liste_n4": f"{CSV_FOLDER}/naf2008_liste_n4.csv",
    "naf2008_liste_n3": f"{CSV_FOLDER}/naf2008_liste_n3.csv",
    "naf2008_liste_n2": f"{CSV_FOLDER}/naf2008_liste_n2.csv",
    "naf2008_liste_n1": f"{CSV_FOLDER}/naf2008_liste_n1.csv",
    "naf2008_5_niveaux": f"{CSV_FOLDER}/naf2008_5_niveaux.csv",
    # "geopandas": f"{CSV_FOLDER}/geopandas.csv",
    "etablissements": f"{CSV_FOLDER}/etablissements.csv",
    "cj_septembre_2022_niveau3": f"{CSV_FOLDER}/cj_septembre_2022 - Niveau III.csv",
    "cj_septembre_2022_niveau2": f"{CSV_FOLDER}/cj_septembre_2022 - Niveau II.csv",
    "cj_septembre_2022_niveau1": f"{CSV_FOLDER}/cj_septembre_2022 - Niveau I.csv"
}

# fonction to connect to db
def connect_to_db():
    return psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT
    )

# main function to ingest data
def ingest_data():
    # connect to postgresql
    conn = connect_to_db()
    cur = conn.cursor()

    # create schema if doesn't exist
    cur.execute(f"CREATE SCHEMA IF NOT EXISTS {SCHEMA};")
    conn.commit()
    print(f"✓ Schéma '{SCHEMA}' créé\n")

    # import csv in FILES
    for table_name, csv_path in FILES.items():
        print(f"Importing {csv_path} → table {SCHEMA}.{table_name}")

        # read CSV in string to avoid dtype issues
        df = pd.read_csv(csv_path, dtype=str, keep_default_na=False)
        # Nettoyage des noms de colonnes : minuscules et suppression des deux-points
        df.columns = df.columns.str.lower().str.replace(':', '', regex=False)

        # createtable with columns as TEXT
        columns_sql = ", ".join([f'"{col}" TEXT' for col in df.columns])
        cur.execute(f"DROP TABLE IF EXISTS {SCHEMA}.{table_name};")
        cur.execute(f"CREATE TABLE {SCHEMA}.{table_name} ({columns_sql});")
        conn.commit()

        # insert all rows at once using execute_values
        rows = [tuple(x) for x in df.to_numpy()]
        placeholders = "(" + ",".join(["%s"] * len(df.columns)) + ")"
        insert_sql = f"INSERT INTO {SCHEMA}.{table_name} VALUES %s"
        execute_values(cur, insert_sql, rows, template=placeholders)
        conn.commit()
        print(f"✓ {table_name} imported.\n")
    
    # close connection
    cur.close()
    conn.close()
    print("✓ All data ingested successfully.")

if __name__ == "__main__":
    ingest_data()