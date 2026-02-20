# Analyse de Performance Logistique - Dashboard Power BI

## Contexte du projet

Ce projet a pour objectif de créer un **dashboard décisionnel** pour analyser la performance logistique d'une entreprise de distribution. Il s'inscrit dans ma démarche de montée en compétences sur les outils d'analyse de données (Power BI, SQL avancé, DAX) et sera réalisé en 2025.

Le dashboard permettra de :
- Visualiser les **indicateurs clés de performance logistique**
- Identifier les **zones géographiques sous-performantes**
- Analyser les **tendances temporelles** des livraisons
- Formuler des **recommandations opérationnelles** basées sur les données

---

## Technologies utilisées

| Domaine | Technologies |
|---------|-------------|
| **Visualisation** | Power BI Desktop |
| **Langage de modélisation** | DAX (Data Analysis Expressions) |
| **Base de données** | PostgreSQL |
| **Requêtage** | SQL (agrégations, CTE, fenêtrage) |
| **Traitement des données** | Power Query (M language) |
| **Sources de données** | PostgreSQL + fichiers CSV |

---

## Structure des données

### Modèle relationnel

Le projet s'appuie sur un modèle de données logistiques comprenant :

┌─────────────┐ ┌─────────────┐
│ commandes │──────│ clients │
└─────────────┘ └─────────────┘
│
│
▼
┌─────────────┐ ┌─────────────┐
│ livraisons │──────│ regions │
└─────────────┘ └─────────────┘

**Tables principales :**
- `commandes` : informations sur les commandes (date, montant, client_id)
- `livraisons` : suivi des expéditions (date_expedition, date_livraison, statut, région_id)
- `clients` : données clients (nom, ville, région)
- `regions` : découpage géographique

---

## Requêtes SQL analytiques développées

### 1. Calcul des délais moyens de livraison par région

```sql
SELECT 
    r.nom_region,
    AVG(l.delai_jours) AS delai_moyen_jours,
    MIN(l.delai_jours) AS delai_min,
    MAX(l.delai_jours) AS delai_max,
    COUNT(*) AS nombre_livraisons
FROM livraisons l
JOIN regions r ON l.region_id = r.id
WHERE l.statut = 'livré'
GROUP BY r.nom_region
ORDER BY delai_moyen_jours DESC;
```

### 2. Taux de retard par région

```sql
WITH livraisons_avec_retard AS (
    SELECT 
        region_id,
        COUNT(*) AS total_livraisons,
        SUM(CASE WHEN delai_jours > delai_estime THEN 1 ELSE 0 END) AS livraisons_en_retard
    FROM livraisons
    WHERE statut = 'livré'
    GROUP BY region_id
)
SELECT 
    r.nom_region,
    l.total_livraisons,
    l.livraisons_en_retard,
    ROUND((l.livraisons_en_retard::DECIMAL / l.total_livraisons * 100), 2) AS taux_retard_pourcentage
FROM livraisons_avec_retard l
JOIN regions r ON l.region_id = r.id
ORDER BY taux_retard_pourcentage DESC;
```

### 3. Évolution mensuelle des performances

```sql
SELECT 
    DATE_TRUNC('month', date_commande) AS mois,
    COUNT(DISTINCT c.id) AS nombre_commandes,
    SUM(c.montant_total) AS chiffre_affaires,
    AVG(l.delai_jours) AS delai_moyen_mois
FROM commandes c
LEFT JOIN livraisons l ON c.id = l.commande_id
WHERE l.statut = 'livré'
GROUP BY DATE_TRUNC('month', date_commande)
ORDER BY mois;
```



