-- Metric views for domain: product | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_assay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key assay performance and quality metrics"
  source: "`oil_gas_ecm`.`product`.`assay`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the assay was performed"
    - name: "crude_grade_id"
      expr: crude_grade_id
      comment: "Identifier for the crude grade tested"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Laboratory vendor performing the assay"
    - name: "lease_id"
      expr: lease_id
      comment: "Lease associated with the sample"
    - name: "assay_status"
      expr: assay_status
      comment: "Current status of the assay"
  measures:
    - name: "total_assays"
      expr: COUNT(1)
      comment: "Count of assay records"
    - name: "avg_api_gravity"
      expr: AVG(CAST(api_gravity AS DOUBLE))
      comment: "Average API gravity across assays"
    - name: "avg_diesel_yield_pct"
      expr: AVG(CAST(diesel_yield_vol_pct AS DOUBLE))
      comment: "Average diesel yield percentage"
    - name: "avg_sulfur_content_wt_pct"
      expr: AVG(CAST(sulfur_content_wt_pct AS DOUBLE))
      comment: "Average sulfur content by weight"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_price_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing performance and cost metrics"
  source: "`oil_gas_ecm`.`product`.`price_history`"
  dimensions:
    - name: "price_date"
      expr: price_date
      comment: "Date of the price record"
    - name: "price_currency_code"
      expr: price_currency_code
      comment: "Currency of the price"
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region"
    - name: "pricing_point"
      expr: pricing_point
      comment: "Pricing point identifier"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Associated petroleum product"
  measures:
    - name: "total_price_records"
      expr: COUNT(1)
      comment: "Number of price history records"
    - name: "avg_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final price"
    - name: "avg_price_differential"
      expr: AVG(CAST(price_differential AS DOUBLE))
      comment: "Average price differential"
    - name: "sum_processing_cost"
      expr: SUM(CAST(processing_cost AS DOUBLE))
      comment: "Total processing cost"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_refined_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refined product quality and specification metrics"
  source: "`oil_gas_ecm`.`product`.`refined_product`"
  dimensions:
    - name: "product_grade"
      expr: product_grade
      comment: "Grade of the refined product"
    - name: "api_gravity"
      expr: api_gravity
      comment: "API gravity of the refined product"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the product record"
    - name: "product_status"
      expr: product_status
      comment: "Current status of the refined product"
  measures:
    - name: "total_refined_products"
      expr: COUNT(1)
      comment: "Count of refined product records"
    - name: "avg_sulfur_ppm"
      expr: AVG(CAST(sulfur_content_ppm AS DOUBLE))
      comment: "Average sulfur content (ppm)"
    - name: "avg_cetane_number"
      expr: AVG(CAST(cetane_number AS DOUBLE))
      comment: "Average cetane number"
    - name: "avg_viscosity_cst"
      expr: AVG(CAST(viscosity_cst AS DOUBLE))
      comment: "Average viscosity (cSt)"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_ngl_stream`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NGL stream composition and energy metrics"
  source: "`oil_gas_ecm`.`product`.`ngl_stream`"
  dimensions:
    - name: "stream_name"
      expr: stream_name
      comment: "Name of the NGL stream"
    - name: "component_type"
      expr: component_type
      comment: "Component type of the stream"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the stream record"
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation for the stream"
  measures:
    - name: "total_stream_records"
      expr: COUNT(1)
      comment: "Number of NGL stream records"
    - name: "avg_ethane_percent"
      expr: AVG(CAST(ethane_mol_percent AS DOUBLE))
      comment: "Average ethane composition percentage"
    - name: "avg_propane_percent"
      expr: AVG(CAST(propane_mol_percent AS DOUBLE))
      comment: "Average propane composition percentage"
    - name: "avg_heating_value_btu_per_gallon"
      expr: AVG(CAST(heating_value_btu_per_gallon AS DOUBLE))
      comment: "Average heating value (BTU per gallon)"
$$;
