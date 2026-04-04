-- Vue Analytique : Performance Logistique
-- Auteur: Jean-Yves
-- Cette vue pré-calcule les KPIs principaux pour Power BI

CREATE OR REPLACE VIEW v_performance_logistique AS
SELECT 
    f.shipment_id,
    f.order_number,
    -- Dimensions liées
    c.carrier_name,
    c.carrier_type,
    cust.customer_name,
    cust.customer_segment,
    r.region_name,
    p.product_name,
    p.category as product_category,
    
    -- Dates
    f.fk_date_order as order_date,
    f.shipment_date,
    f.planned_delivery_date,
    f.actual_delivery_date,
    
    -- Calculs de délais (Lead Times)
    (f.actual_delivery_date - f.fk_date_order) as total_lead_time,
    (f.actual_delivery_date - f.planned_delivery_date) as delay_days,
    
    -- KPIs Binaires (pour calculs de taux dans Power BI)
    CASE 
        WHEN f.actual_delivery_date <= f.planned_delivery_date THEN 1 
        ELSE 0 
    END as is_on_time,
    
    CASE 
        WHEN f.actual_delivery_date > f.planned_delivery_date + INTERVAL '3 days' THEN 1 
        ELSE 0 
    END as is_critical_delay,
    
    -- Métriques financières et physiques
    f.quantity,
    f.total_weight_kg,
    f.shipping_cost,
    (f.shipping_cost / NULLIF(f.total_weight_kg, 0)) as cost_per_kg

FROM fact_shipments f
JOIN dim_carriers c ON f.fk_carrier_id = c.carrier_id
JOIN dim_customers cust ON f.fk_customer_id = cust.customer_id
JOIN dim_regions r ON f.fk_region_id = r.region_id
JOIN dim_products p ON f.fk_product_id = p.product_id;
