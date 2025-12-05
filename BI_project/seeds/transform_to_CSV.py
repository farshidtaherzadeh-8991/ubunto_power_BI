#Pour les contours des communes, j'ai mis un nouveau fichier sur le drive.

#Il s'agit d'un fichier .shp.

#Pour le lire en python il faut utiliser geopandas. Voici le code pour l'ouvrir :  

import geopandas as gpd
import pandas as pd
import os
from pathlib import Path

# Define the source and output directories with absolute paths
source_dir = "/home/farshid/Projet_BI/BI_project/seeds/BI_Isere_CSV/Communes/Contours (France)"
output_dir = os.path.join(source_dir, "CSV_Output")

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Debug: Check if source directory exists and list files
print(f"Source directory: {source_dir}")
print(f"Directory exists: {os.path.exists(source_dir)}")
print(f"Files in directory:")
for file in os.listdir(source_dir):
    print(f"  - {file}")

# Process shapefile (.shp)
shp_files = list(Path(source_dir).glob("**/*.shp"))
print(f"\nFound {len(shp_files)} shapefile(s)")

for shp_file in shp_files:
    try:
        print(f"Processing shapefile: {shp_file.name}")
        gdf = gpd.read_file(str(shp_file))
        
        # Convert geometry to WKT for CSV compatibility
        gdf['geometry'] = gdf['geometry'].to_wkt()
        
        # Save to CSV
        csv_output = os.path.join(output_dir, f"{shp_file.stem}.csv")
        gdf.to_csv(csv_output, index=False)
        print(f"✓ Saved: {csv_output}")
    except Exception as e:
        print(f"✗ Error processing {shp_file.name}: {e}")

print("\nTransformation complete!")