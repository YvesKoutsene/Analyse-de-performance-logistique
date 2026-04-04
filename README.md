# 🚚 Dashboard Décisionnel – Performance Logistique (PostgreSQL & Power BI)

## 📋 Présentation du Projet
Ce projet est une solution complète d'analyse de données logistiques visant à transformer des données transactionnelles brutes en insights stratégiques. L'objectif est de piloter la performance de livraison, d'identifier les goulets d'étranglement et d'optimiser les flux régionaux.

### 🏗️ Architecture Technique
*   **Source de données :** PostgreSQL (Modèle relationnel transactionnel).
*   **Traitement & Modélisation :** SQL Analytique (CTEs, Window Functions, Vues).
*   **Visualisation & Intelligence :** Power BI (DAX, Star Schema, Dynamic Dashboards).
*   **Méthodologie :** Architecture en Étoile (Star Schema) pour une performance optimale.

---

## 🚀 Structure du Dépôt
*   📁 `sql/` : Scripts de création de tables, vues analytiques et requêtes de test.
*   📁 `powerbi/` : Fichiers `.pbix` (ou modèles `.pbit`) et documentation des mesures DAX.
*   📁 `data/` : Jeux de données (fichiers CSV ignorés par git, documentés ici).
*   📁 `docs/` : Documentation technique, dictionnaire de données et captures d'écran du dashboard.
*   📁 `scripts/` : Scripts Python/Bash pour l'ingestion ou le nettoyage éventuel.

---

## 📊 Indicateurs de Performance (KPIs) Cibles
1.  **OTIF (On-Time In-Full) :** Taux de commandes livrées à l'heure et complètes.
2.  **Délai de Transit Moyen :** Temps écoulé entre l'expédition et la réception finale.
3.  **Taux de Retard par Région :** Identification des zones géographiques sous-performantes.
4.  **Performance Transporteur :** Comparaison des délais réels vs engagements contractuels (SLA).
5.  **Volume & Tendances :** Évolution mensuelle des expéditions (MoM Growth).

---

## 🛠️ Installation & Utilisation
1.  **PostgreSQL :** Exécuter les scripts dans `sql/tables` puis `sql/views`.
2.  **Power BI :** Connecter le fichier `.pbix` à votre instance PostgreSQL locale.
3.  **Analyse :** Explorer les visuels interactifs et les rapports de tendances.

---

## ✍️ Auteur
**Jean-Yves** – Data Analyst & Informaticien
