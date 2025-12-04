# ...existing code...
import os
import glob
import re
import pandas as pd
from sqlalchemy import create_engine, text

# Ajouts pour shapefiles
try:
    import geopandas as gpd
except Exception:
    gpd = None

try:
    from simpledbf import Dbf5
except Exception:
    Dbf5 = None

engine = create_engine("postgresql://group6:Gzn4LDT;[[dP%(nnx2_*@195.154.71.31:27675/BI_group6")

with engine.connect() as conn:
    conn.execute(text("CREATE SCHEMA IF NOT EXISTS raw_isere;"))
    conn.commit()

dossier_principal = "BI_Isere_CSV"

def sanitize_table_name(name):
    return re.sub(r'\W+', '_', name).strip('_').lower()

# recherche récursive de tous les fichiers
fichiers = [
    f for f in glob.glob(os.path.join(dossier_principal, "**/*"), recursive=True)
    if os.path.isfile(f)
]

for fichier in fichiers:
    ext = os.path.splitext(fichier)[1].lower()
    base_name = os.path.splitext(os.path.basename(fichier))[0]
    nom_table = sanitize_table_name(base_name)

    print(f"Traitement: {fichier} (ext {ext})")

    try:
        if ext == ".csv":
            df = pd.read_csv(fichier)
            df.to_sql(nom_table, engine, schema="raw_isere", if_exists="replace", index=False)
            print(f" -> CSV importé en raw_isere.{nom_table}")

        elif ext in (".tsv", ".txt"):
            try:
                df = pd.read_csv(fichier, sep='\t')
            except Exception:
                df = pd.read_csv(fichier, sep=None, engine='python')
            df.to_sql(nom_table, engine, schema="raw_isere", if_exists="replace", index=False)
            print(f" -> TSV/TXT importé en raw_isere.{nom_table}")

        elif ext in (".xls", ".xlsx"):
            xls = pd.read_excel(fichier, sheet_name=None)
            for sheet_name, df_sheet in xls.items():
                table = sanitize_table_name(f"{base_name}_{sheet_name}")
                df_sheet.to_sql(table, engine, schema="raw_isere", if_exists="replace", index=False)
                print(f" -> feuille '{sheet_name}' importée en raw_isere.{table}")

        elif ext == ".shp":
            if gpd is None:
                print(" -> geopandas non installé : shapefile ignoré.")
            else:
                gdf = gpd.read_file(fichier)
                # convertir la géométrie en WKT pour stockage générique (si PostGIS présent, adapter)
                if 'geometry' in gdf.columns:
                    gdf['wkt_geom'] = gdf.geometry.apply(lambda g: g.wkt if g is not None else None)
                    gdf = gdf.drop(columns='geometry')
                gdf.to_sql(nom_table, engine, schema="raw_isere", if_exists="replace", index=False)
                print(f" -> Shapefile importé en raw_isere.{nom_table} (géométrie en wkt_geom)")

        elif ext == ".dbf":
            if Dbf5 is not None:
                df = Dbf5(fichier).to_dataframe()
                df.to_sql(nom_table, engine, schema="raw_isere", if_exists="replace", index=False)
                print(f" -> DBF importé en raw_isere.{nom_table}")
            else:
                print(" -> simpledbf non installé : .dbf ignoré (ou utilisez .shp pour importer la couche complète).")

        else:
            # ignorer .shx, .prj et autres composants ; seuls .shp/.dbf sont traités
            print(" -> type non pris en charge ou composant de shapefile (ignoré).")

    except Exception as e:
        print(f"Erreur pour {fichier}: {e}")

print("Traitement terminé.")
# ...existing code...