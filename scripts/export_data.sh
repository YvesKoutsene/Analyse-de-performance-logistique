#!/bin/bash
# Script d'exportation des données pour Power BI Service
# Auteur: Jean-Yves

# Configuration (à adapter selon tes accès PostgreSQL)
DB_NAME="logistique_db"
DB_USER="postgres"
OUTPUT_DIR="../data"

echo "🚀 Début de l'exportation des données NexLogix..."

# Créer le dossier data s'il n'existe pas
mkdir -p $OUTPUT_DIR

# Fonction d'exportation
export_table() {
    local table_name=$1
    local file_name=$2
    echo "📦 Exportation de $table_name..."
    psql -d $DB_NAME -U $DB_USER -c "\copy (SELECT * FROM $table_name) TO '$OUTPUT_DIR/$file_name' WITH CSV HEADER"
}

# 1. Exportation des Dimensions
export_table "dim_carriers" "dim_carriers.csv"
export_table "dim_customers" "dim_customers.csv"
export_table "dim_regions" "dim_regions.csv"
export_table "dim_products" "dim_products.csv"
export_table "dim_calendar" "dim_calendar.csv"

# 2. Exportation de la Vue Analytique (C'est elle qu'on utilisera principalement)
export_table "v_performance_logistique" "v_performance_logistique.csv"

echo "✅ Exportation terminée ! Les fichiers sont dans le dossier /data"
echo "👉 Prochaine étape : Upload ces fichiers sur Power BI Service."
