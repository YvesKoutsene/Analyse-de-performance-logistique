# 🧠 Guide des Mesures DAX – NexLogix

Ce guide répertorie les mesures DAX à créer dans Power BI Service pour piloter la performance logistique.

---

## 1. Performance Globale (OTIF)
**OTIF % (On-Time In-Full)**  
C'est l'indicateur clé : quel pourcentage de nos commandes sont arrivées à l'heure ?

```dax
OTIF % = 
DIVIDE(
    CALCULATE(
        COUNTROWS('v_performance_logistique'), 
        'v_performance_logistique'[is_on_time] = 1
    ), 
    COUNTROWS('v_performance_logistique'), 
    0
)
```

---

## 2. Délais (Lead Times)
**Délai Moyen (Jours)**  
Le temps moyen écoulé entre la commande et la livraison réelle.

```dax
Moyenne Délai Livraison = AVERAGE('v_performance_logistique'[total_lead_time])
```

---

## 3. Analyse Financière
**Coût Logistique Moyen par KG**  
Indique si nos expéditions sont rentables. Un coût trop élevé peut indiquer un mauvais choix de transporteur.

```dax
Coût au KG = 
DIVIDE(
    SUM('v_performance_logistique'[shipping_cost]), 
    SUM('v_performance_logistique'[total_weight_kg]), 
    0
)
```

---

## 4. Retards Critiques
**% Retard Critique**  
Commandes ayant plus de 3 jours de retard sur la date prévue.

```dax
% Retard Critique = 
DIVIDE(
    SUM('v_performance_logistique'[is_critical_delay]), 
    COUNTROWS('v_performance_logistique'), 
    0
)
```

---

## 5. Volume de Commandes
**Nombre Total d'Expéditions**  
Compte simple des commandes traitées.

```dax
Total Expéditions = COUNTROWS('v_performance_logistique')
```
