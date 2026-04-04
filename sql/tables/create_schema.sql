-- Script de création du schéma en étoile pour NexLogix Solutions

-- 1. Nettoyage (Optionnel, utile pour les tests)
DROP TABLE IF EXISTS fact_shipments CASCADE;
DROP TABLE IF EXISTS dim_carriers CASCADE;
DROP TABLE IF EXISTS dim_customers CASCADE;
DROP TABLE IF EXISTS dim_regions CASCADE;
DROP TABLE IF EXISTS dim_products CASCADE;
DROP TABLE IF EXISTS dim_calendar CASCADE;

-- 2. Création des Dimensions

-- Table des Transporteurs
CREATE TABLE dim_carriers (
    carrier_id SERIAL PRIMARY KEY,
    carrier_name VARCHAR(100) NOT NULL,
    carrier_type VARCHAR(50), -- Aérien, Routier, Maritime
    contract_sla_days INT -- Délai garanti contractuellement
);

-- Table des Régions (Géographie)
CREATE TABLE dim_regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    hub_center VARCHAR(100), -- Centre de tri principal
    country VARCHAR(50) DEFAULT 'France'
);

-- Table des Clients
CREATE TABLE dim_customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    customer_segment VARCHAR(50), -- SMB, Enterprise, Key Account
    city VARCHAR(100)
);

-- Table des Produits
CREATE TABLE dim_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    unit_weight_kg DECIMAL(10, 2)
);

-- Table Calendrier (Indispensable pour l'intelligence temporelle)
CREATE TABLE dim_calendar (
    date_key DATE PRIMARY KEY,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    day_of_week INT,
    is_weekend BOOLEAN
);

-- 3. Création de la Table de Faits (Centrale)

CREATE TABLE fact_shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    
    -- Clés Étrangères
    fk_carrier_id INT REFERENCES dim_carriers(carrier_id),
    fk_customer_id INT REFERENCES dim_customers(customer_id),
    fk_region_id INT REFERENCES dim_regions(region_id),
    fk_product_id INT REFERENCES dim_products(product_id),
    fk_date_order DATE REFERENCES dim_calendar(date_key),
    
    -- Dates de suivi
    shipment_date DATE,
    planned_delivery_date DATE,
    actual_delivery_date DATE,
    
    -- Métriques brutes
    quantity INT,
    total_weight_kg DECIMAL(12, 2),
    shipping_cost DECIMAL(12, 2),
    
    -- Statut
    order_status VARCHAR(50) -- Livré, En cours, Annulé
);

-- Index pour optimiser les jointures futures
CREATE INDEX idx_fact_date ON fact_shipments(fk_date_order);
CREATE INDEX idx_fact_carrier ON fact_shipments(fk_carrier_id);
CREATE INDEX idx_fact_region ON fact_shipments(fk_region_id);
