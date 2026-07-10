-- Metric views for domain: supply | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_contract_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract pricing analytics tracking negotiated supplier prices, price changes, and tier-based pricing structures across brands and ingredients."
  source: "`vibe_restaurants_v1`.`supply`.`contract_price`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Restaurant brand identifier for multi-brand contract analysis"
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient identifier for ingredient-level price tracking"
    - name: "supplier_contract_id"
      expr: supplier_contract_id
      comment: "Parent supplier contract identifier"
    - name: "contract_price_status"
      expr: contract_price_status
      comment: "Current status of the contract price (active, expired, pending)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the price is denominated"
    - name: "price_type"
      expr: price_type
      comment: "Type of pricing structure (fixed, tiered, indexed)"
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating if this is the currently active price"
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason for price change (market conditions, renegotiation, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year when the contract price became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when the contract price became effective"
  measures:
    - name: "total_contract_price_records"
      expr: COUNT(1)
      comment: "Total number of contract price records"
    - name: "avg_price_amount"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average contracted price amount across all contract prices"
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Sum of all contract price amounts"
    - name: "min_price_amount"
      expr: MIN(CAST(price_amount AS DOUBLE))
      comment: "Minimum contracted price amount"
    - name: "max_price_amount"
      expr: MAX(CAST(price_amount AS DOUBLE))
      comment: "Maximum contracted price amount"
    - name: "avg_tier_min_qty"
      expr: AVG(CAST(price_tier_min_qty AS DOUBLE))
      comment: "Average minimum quantity threshold for tiered pricing"
    - name: "avg_tier_max_qty"
      expr: AVG(CAST(price_tier_max_qty AS DOUBLE))
      comment: "Average maximum quantity threshold for tiered pricing"
    - name: "distinct_ingredients"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of unique ingredients with contracted prices"
    - name: "distinct_contracts"
      expr: COUNT(DISTINCT supplier_contract_id)
      comment: "Number of unique supplier contracts represented"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt performance tracking delivery quality, temperature compliance, and receiving efficiency at restaurant units."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit receiving the goods"
    - name: "purchase_order_id"
      expr: purchase_order_id
      comment: "Purchase order fulfilled by this receipt"
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (received, inspected, rejected)"
    - name: "condition"
      expr: condition
      comment: "Condition of goods upon receipt (good, damaged, acceptable)"
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Flag indicating cold chain compliance for temperature-sensitive items"
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Flag indicating temperature was outside acceptable range"
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (dock, direct, drop-ship)"
    - name: "receipt_year"
      expr: YEAR(receipt_timestamp)
      comment: "Year of goods receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month of goods receipt"
    - name: "receipt_date"
      expr: DATE(receipt_timestamp)
      comment: "Date of goods receipt"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed"
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received"
    - name: "avg_receipt_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per goods receipt"
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts"
    - name: "avg_quantity_per_receipt"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average quantity received per receipt"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature recorded at receipt for temperature-controlled items"
    - name: "cold_chain_compliant_receipts"
      expr: SUM(CASE WHEN is_cold_chain_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts meeting cold chain compliance requirements"
    - name: "temperature_deviation_receipts"
      expr: SUM(CASE WHEN temperature_deviation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts with temperature deviations"
    - name: "distinct_units_receiving"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of unique restaurant units receiving goods"
    - name: "distinct_purchase_orders"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of unique purchase orders fulfilled"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level goods receipt analytics tracking item quality, variance, waste, and COGS at the SKU level."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "goods_receipt_id"
      expr: goods_receipt_id
      comment: "Parent goods receipt identifier"
    - name: "stock_item_id"
      expr: stock_item_id
      comment: "Stock item received"
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location for received items"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status (passed, failed, pending)"
    - name: "is_perishable"
      expr: is_perishable
      comment: "Flag indicating if item is perishable"
    - name: "is_returned"
      expr: is_returned
      comment: "Flag indicating if item was returned to supplier"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating compliance with receiving standards"
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status of the received item"
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Flag indicating if item requires temperature control"
    - name: "received_year"
      expr: YEAR(received_timestamp)
      comment: "Year item was received"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month item was received"
  measures:
    - name: "total_receipt_lines"
      expr: COUNT(1)
      comment: "Total number of goods receipt line items"
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold for received items"
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost across all receipt lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all received items"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of items received"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of items rejected at receipt"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance between ordered and received"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of received items"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of received items in kilograms"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of received items in cubic meters"
    - name: "returned_lines"
      expr: SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipt lines that were returned to supplier"
    - name: "non_compliant_lines"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of receipt lines failing compliance checks"
    - name: "distinct_stock_items"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of unique stock items received"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient master data analytics tracking nutritional profiles, cost, allergens, and compliance attributes for menu ingredients."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient`"
  dimensions:
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Unique ingredient identifier"
    - name: "category"
      expr: category
      comment: "Ingredient category (protein, produce, dairy, etc.)"
    - name: "sub_category"
      expr: sub_category
      comment: "Ingredient sub-category for detailed classification"
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Current status of ingredient (active, discontinued, seasonal)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where ingredient is sourced"
    - name: "organic_flag"
      expr: organic_flag
      comment: "Flag indicating if ingredient is certified organic"
    - name: "non_gmo_flag"
      expr: non_gmo_flag
      comment: "Flag indicating if ingredient is non-GMO"
    - name: "halal_flag"
      expr: halal_flag
      comment: "Flag indicating if ingredient is halal certified"
    - name: "kosher_flag"
      expr: kosher_flag
      comment: "Flag indicating if ingredient is kosher certified"
    - name: "haccp_classification"
      expr: haccp_classification
      comment: "HACCP risk classification for food safety"
    - name: "usda_grade"
      expr: usda_grade
      comment: "USDA quality grade for applicable ingredients"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging for the ingredient"
  measures:
    - name: "total_ingredients"
      expr: COUNT(1)
      comment: "Total number of ingredients in the catalog"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across all ingredients"
    - name: "total_ingredient_cost"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Sum of cost per unit across all ingredients"
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across all ingredients"
    - name: "avg_nutritional_calories"
      expr: AVG(CAST(nutritional_calories_per_unit AS DOUBLE))
      comment: "Average calories per unit across all ingredients"
    - name: "avg_protein_content_pct"
      expr: AVG(CAST(protein_content_percent AS DOUBLE))
      comment: "Average protein content percentage"
    - name: "avg_fat_content_pct"
      expr: AVG(CAST(fat_content_percent AS DOUBLE))
      comment: "Average fat content percentage"
    - name: "avg_carb_content_pct"
      expr: AVG(CAST(carbohydrate_content_percent AS DOUBLE))
      comment: "Average carbohydrate content percentage"
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg_per_unit AS DOUBLE))
      comment: "Average sodium content in milligrams per unit"
    - name: "avg_standard_weight"
      expr: AVG(CAST(standard_weight_per_unit AS DOUBLE))
      comment: "Average standard weight per unit"
    - name: "organic_ingredients"
      expr: SUM(CASE WHEN organic_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of organic certified ingredients"
    - name: "non_gmo_ingredients"
      expr: SUM(CASE WHEN non_gmo_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of non-GMO ingredients"
    - name: "halal_ingredients"
      expr: SUM(CASE WHEN halal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of halal certified ingredients"
    - name: "kosher_ingredients"
      expr: SUM(CASE WHEN kosher_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of kosher certified ingredients"
    - name: "distinct_categories"
      expr: COUNT(DISTINCT category)
      comment: "Number of unique ingredient categories"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient lot traceability and quality analytics tracking batch-level quality scores, yield, waste, and compliance for food safety and recall management."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient_lot`"
  dimensions:
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient identifier for lot tracking"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier who provided this lot"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where lot is stored"
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location for the lot"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot (available, quarantined, expired, consumed)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (production, sample, trial)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of the lot"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating if lot is subject to recall"
    - name: "organic_certified"
      expr: organic_certified
      comment: "Flag indicating if lot is organic certified"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Flag indicating if lot requires temperature control"
    - name: "traceability_enabled"
      expr: traceability_enabled
      comment: "Flag indicating if lot has full traceability"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where lot was produced"
    - name: "ingredient_category"
      expr: ingredient_category
      comment: "Category of ingredient in this lot"
    - name: "production_year"
      expr: YEAR(production_date)
      comment: "Year lot was produced"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month lot was produced"
    - name: "received_year"
      expr: YEAR(received_date)
      comment: "Year lot was received"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month lot was received"
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of ingredient lots tracked"
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all lots"
    - name: "total_lot_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all ingredient lots"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across all lots"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across all lots"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage indicating usable portion of lot"
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across all lots"
    - name: "avg_storage_temperature"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature in Celsius"
    - name: "recalled_lots"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lots subject to recall"
    - name: "organic_certified_lots"
      expr: SUM(CASE WHEN organic_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of organic certified lots"
    - name: "temperature_controlled_lots"
      expr: SUM(CASE WHEN temperature_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lots requiring temperature control"
    - name: "traceable_lots"
      expr: SUM(CASE WHEN traceability_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lots with full traceability enabled"
    - name: "distinct_ingredients"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of unique ingredients tracked in lots"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing lots"
    - name: "distinct_units"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of unique restaurant units with lots"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract performance analytics tracking contract terms, pricing tiers, rebates, compliance, and renewal management."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_contract`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier party to the contract"
    - name: "brand_id"
      expr: brand_id
      comment: "Restaurant brand covered by the contract"
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Current status of the contract (active, expired, pending, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (master, spot, framework)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated in the contract"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified in the contract"
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms (FOB, CIF, etc.)"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method specified in the contract"
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (automatic, manual, non-renewable)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating if contract is exclusive"
    - name: "confidentiality_clause"
      expr: confidentiality_clause
      comment: "Flag indicating presence of confidentiality clause"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which contract is denominated"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year contract became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month contract became effective"
    - name: "signed_year"
      expr: YEAR(signed_date)
      comment: "Year contract was signed"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of supplier contracts"
    - name: "avg_default_price"
      expr: AVG(CAST(default_price AS DOUBLE))
      comment: "Average default price across all contracts"
    - name: "total_default_price"
      expr: SUM(CAST(default_price AS DOUBLE))
      comment: "Sum of default prices across all contracts"
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage negotiated in contracts"
    - name: "avg_rebate_threshold"
      expr: AVG(CAST(rebate_threshold_amount AS DOUBLE))
      comment: "Average rebate threshold amount across contracts"
    - name: "avg_liability_limit"
      expr: AVG(CAST(liability_limit AS DOUBLE))
      comment: "Average liability limit specified in contracts"
    - name: "total_liability_exposure"
      expr: SUM(CAST(liability_limit AS DOUBLE))
      comment: "Total liability exposure across all contracts"
    - name: "avg_volume_tier_1_price"
      expr: AVG(CAST(volume_tier_1_price AS DOUBLE))
      comment: "Average price at volume tier 1"
    - name: "avg_volume_tier_2_price"
      expr: AVG(CAST(volume_tier_2_price AS DOUBLE))
      comment: "Average price at volume tier 2"
    - name: "exclusive_contracts"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive supplier contracts"
    - name: "confidential_contracts"
      expr: SUM(CASE WHEN confidentiality_clause = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with confidentiality clauses"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers under contract"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of unique brands covered by contracts"
$$;