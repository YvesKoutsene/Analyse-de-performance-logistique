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

