# Logistique : Piloter autrement

> *Un dashboard né des vraies questions d’un responsable transport.*

---

## Pourquoi ce projet ?

Parce que les chiffres cachés dans PostgreSQL ne parlent pas tout seuls.  
L’idée ici : **prendre des données brutes de livraisons**, les modeler, et en faire un outil de pilotage quotidien.

Pas de bullshit. Juste des indicateurs qui aident à décider :
- Où sont les retards récurrents ?
- Quels transporteurs déçoivent ?
- Quelles régions méritent qu’on y regarde de plus près ?

---

## Ce qu’il y a sous le capot

| Brique | Techno |
|--------|--------|
| Stockage des commandes / livraisons | PostgreSQL |
| Nettoyage & calculs lourds | SQL (CTE, fenêtres, vues) |
| Modélisation & tableau de bord | Power BI (DAX, schéma étoile) |
| Versioning du projet | GitHub |

---

## Organisation du dépôt

```text
logistics-dashboard/
├── sql/              # Les requêtes qui font le sale boulot
├── powerbi/          # Le fichier .pbix et les mesures DAX
├── data/             # Samples (fichiers réels exclus par .gitignore)
├── docs/             # Notes, captures, dictionnaire
└── scripts/          # Éventuels petits outils Python ou bash
