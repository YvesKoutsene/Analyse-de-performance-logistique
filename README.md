# 🚚 Dashboard Décisionnel – Performance Logistique (PostgreSQL & Power BI)

## 📋 Présentation du Projet
Ce projet est une solution complète d'analyse de données logistiques visant à transformer des données transactionnelles brutes en insights stratégiques. L'objectif est de piloter la performance de livraison, d'identifier les goulets d'étranglement et d'optimiser les flux régionaux.

---

## 📊 Aperçu du Dashboard (NexLogix)
![Dashboard Performance Logistique](docs/img/dashboard_final.png)
*(Note: Capture d'écran du rapport Power BI Desktop final)*

---

## 🏗️ Architecture Technique
*   **Source de données :** PostgreSQL (Modèle relationnel transactionnel).
*   **Traitement & Modélisation :** SQL Analytique (CTEs, Window Functions, Vues).
*   **Visualisation & Intelligence :** Power BI (DAX, Star Schema).
*   **Plateforme :** Développé sur Linux (Ubuntu) et finalisé sur Windows.

---

## 🧠 Analyse & Vision Stratégique : Ce que les chiffres nous racontent

Au-delà de la technique, ce projet m'a permis de mettre en lumière trois réalités critiques pour la performance de **NexLogix** :

1. **L'Épreuve du Feu (Saisonnalité) :**  
Les données ne mentent pas : chaque année, le pic de charge de novembre et décembre (Black Friday / Noël) met notre réseau sous une tension extrême. On observe une chute brutale de 15% de l'OTIF. Ce n'est pas une fatalité, c'est un signal : notre capacité logistique actuelle sature. **Ma reco :** Anticiper dès septembre des renforts de hubs temporaires pour lisser cette courbe.

2. **Le Piège du "Low-Cost" :**  
L'analyse comparative est sans appel pour **LocalExpress**. Si leurs tarifs sont attractifs, leur taux de retard frôle les 40%. En logistique, le "pas cher" coûte cher en réputation client. On voit clairement que privilégier un partenaire comme **DHL**, même plus onéreux, sécurise notre promesse client et stabilise notre flux financier sur le long terme.

3. **Le Signal Faible des Hauts-de-France :**  
En isolant l'anomalie de juin dans le Nord, on découvre qu'un incident localisé peut paralyser une région entière. C'est ici que la Data prend tout son sens : elle nous permet de détecter des goulots d'étranglement géographiques avant qu'ils ne deviennent chroniques.

**En résumé :** Ce dashboard n'est pas qu'un outil de suivi, c'est une boussole. Il transforme le "chaos" des expéditions quotidiennes en décisions claires pour optimiser chaque kilomètre parcouru.

---

## 🛠️ Structure du Dépôt
*   📁 `sql/` : Scripts de création de tables, vues analytiques et injection de données.
*   📁 `powerbi/` : Fichiers `.pbix` et documentation des mesures DAX.
*   📁 `docs/` : Documentation technique et analyses stratégiques.
*   📁 `scripts/` : Scripts d'automatisation (Export CSV pour workflow Linux).

---

## ✍️ Auteur
**Jean-Yves** – Data Analyst & Informaticien
