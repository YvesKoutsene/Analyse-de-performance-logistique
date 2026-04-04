-- Script d'injection de données "VIVANTES" (Storytelling Data)
-- Projet: NexLogix Solutions | Auteur: Jean-Yves

-- 1. Nettoyage
TRUNCATE TABLE fact_shipments, dim_carriers, dim_customers, dim_regions, dim_products, dim_calendar CASCADE;

-- 2. Dimensions (Stables)
INSERT INTO dim_carriers (carrier_name, carrier_type, contract_sla_days) VALUES
('DHL Express', 'Aérien', 2),
('FedEx Logistics', 'Aérien', 3),
('Geodis', 'Routier', 5),
('Chronopost', 'Routier', 2),
('LocalExpress', 'Routier', 7);

INSERT INTO dim_regions (region_name, hub_center) VALUES
('Île-de-France', 'Garonor Hub'),
('Auvergne-Rhône-Alpes', 'Lyon-St Exupéry'),
('Provence-Alpes-Côte d''Azur', 'Marseille-Fos'),
('Nouvelle-Aquitaine', 'Bordeaux-Cestas'),
('Hauts-de-France', 'Lille-Lesquin');

INSERT INTO dim_customers (customer_name, customer_segment, city) VALUES
('TechGiant Corp', 'Key Account', 'Paris'),
('BioLab Systems', 'Enterprise', 'Lyon'),
('EcoPrint SAS', 'SMB', 'Nantes'),
('NextGen Robotics', 'Key Account', 'Toulouse'),
('SmartSolutions Ltd', 'Enterprise', 'Nice'),
('PetitCommerce SARL', 'SMB', 'Bordeaux'),
('CloudSystems', 'Key Account', 'Lille'),
('DataCenter Pro', 'Enterprise', 'Rennes');

INSERT INTO dim_products (product_name, category, unit_weight_kg) VALUES
('Processeur Intel i9', 'Composants', 0.5),
('Écran OLED 27"', 'Périphériques', 5.2),
('Serveur Rack 2U', 'Infrastructure', 15.0),
('Câble Fibre Optique 10m', 'Réseau', 1.2),
('Carte Graphique RTX 4080', 'Composants', 2.1);

-- 3. Calendrier (2024)
INSERT INTO dim_calendar (date_key, year, quarter, month, month_name, day_of_week, is_weekend)
SELECT datum, EXTRACT(YEAR FROM datum), EXTRACT(QUARTER FROM datum), EXTRACT(MONTH FROM datum),
TO_CHAR(datum, 'TMMonth'), EXTRACT(DOW FROM datum), CASE WHEN EXTRACT(DOW FROM datum) IN (0, 6) THEN TRUE ELSE FALSE END
FROM generate_series('2024-01-01'::DATE, '2024-12-31'::DATE, '1 day'::interval) datum;

-- 4. Génération de 1000 expéditions avec LOGIQUE MÉTIER
INSERT INTO fact_shipments (
    order_number, fk_carrier_id, fk_customer_id, fk_region_id, fk_product_id, 
    fk_date_order, shipment_date, planned_delivery_date, actual_delivery_date, 
    quantity, total_weight_kg, shipping_cost, order_status
)
SELECT 
    'ORD-' || LPAD(s.id::text, 5, '0'),
    -- Distribution inégale des transporteurs (DHL et FedEx plus fréquents)
    CASE 
        WHEN RANDOM() < 0.4 THEN 1 -- DHL
        WHEN RANDOM() < 0.7 THEN 2 -- FedEx
        WHEN RANDOM() < 0.85 THEN 3 -- Geodis
        WHEN RANDOM() < 0.95 THEN 4 -- Chronopost
        ELSE 5 -- LocalExpress
    END as fk_carrier_id,
    (FLOOR(RANDOM() * 8) + 1)::int as fk_customer_id,
    (FLOOR(RANDOM() * 5) + 1)::int as fk_region_id,
    (FLOOR(RANDOM() * 5) + 1)::int as fk_product_id,
    -- Saisonnalité : Plus de commandes en fin d'année (Oct-Dec)
    CASE 
        WHEN RANDOM() < 0.4 THEN '2024-10-01'::DATE + (RANDOM() * 90)::INT * INTERVAL '1 day'
        ELSE '2024-01-01'::DATE + (RANDOM() * 270)::INT * INTERVAL '1 day'
    END as fk_date_order,
    NULL, NULL, NULL, -- Dates à calculer après
    (FLOOR(RANDOM() * 15) + 1)::int as quantity,
    0.0, 0.0, 'Livré'
FROM generate_series(1, 1000) as s(id);

-- 5. Mise à jour des dates avec LOGIQUE DE PERFORMANCE
-- Étape 1 : Calcul des dates de base
UPDATE fact_shipments 
SET 
    shipment_date = fk_date_order + INTERVAL '1 day',
    planned_delivery_date = fk_date_order + INTERVAL '4 days',
    total_weight_kg = quantity * (SELECT unit_weight_kg FROM dim_products WHERE product_id = fk_product_id);

-- Étape 2 : Simulation de la Performance Transporteur (Actual Delivery)
UPDATE fact_shipments f
SET actual_delivery_date = planned_delivery_date + 
    CASE 
        -- DHL (ID 1) : 95% ponctuel, max 1 jour de retard
        WHEN fk_carrier_id = 1 THEN (CASE WHEN RANDOM() < 0.95 THEN 0 ELSE 1 END) * INTERVAL '1 day'
        -- LocalExpress (ID 5) : 50% de retards, souvent 3-5 jours
        WHEN fk_carrier_id = 5 THEN (CASE WHEN RANDOM() < 0.50 THEN 0 ELSE 3 + FLOOR(RANDOM() * 3) END) * INTERVAL '1 day'
        -- Anomalie Hauts-de-France (Region 5) en Juin (Month 6) : +4 jours de retard systématique
        WHEN fk_region_id = 5 AND EXTRACT(MONTH FROM fk_date_order) = 6 THEN INTERVAL '4 days'
        -- Par défaut : 80% ponctuel
        ELSE (CASE WHEN RANDOM() < 0.8 THEN 0 ELSE 1 + FLOOR(RANDOM() * 2) END) * INTERVAL '1 day'
    END;

-- Étape 3 : Calcul du Coût (Poids * Distance simulée par Région + Frais Fixes Carrier)
UPDATE fact_shipments f
SET shipping_cost = 
    (CASE WHEN fk_carrier_id = 1 THEN 50 ELSE 20 END) -- Frais fixes
    + (total_weight_kg * (CASE WHEN fk_carrier_id = 1 THEN 5 ELSE 2 END)) -- Coût au kg
    + (fk_region_id * 5); -- Surcharge régionale
