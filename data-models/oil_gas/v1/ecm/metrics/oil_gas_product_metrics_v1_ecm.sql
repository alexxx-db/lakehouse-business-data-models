-- Metric views for domain: product | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_blend_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational KPIs for blending operations"
  source: "`oil_gas_ecm`.`product`.`blend_recipe`"
  dimensions:
    - name: "blend_type"
      expr: blend_type
      comment: "Category of blend (e.g., gasoline, diesel)"
  measures:
    - name: "total_blend_volume"
      expr: SUM(CAST(actual_blend_volume AS DOUBLE))
      comment: "Total volume blended across all blend recipes"
    - name: "average_blend_ron"
      expr: AVG(CAST(actual_ron AS DOUBLE))
      comment: "Average Research Octane Number of blended product"
    - name: "average_sulfur_content"
      expr: AVG(CAST(actual_sulfur_content AS DOUBLE))
      comment: "Average sulfur content (ppm) in blended product"
    - name: "blend_count"
      expr: COUNT(1)
      comment: "Number of blend recipe records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_price_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing performance and trend analysis"
  source: "`oil_gas_ecm`.`product`.`price_history`"
  dimensions:
    - name: "price_month"
      expr: DATE_TRUNC('month', price_date)
      comment: "Month of the price record"
    - name: "pricing_benchmark_id"
      expr: pricing_benchmark_id
      comment: "Benchmark identifier used for pricing"
    - name: "product_grade"
      expr: product_grade
      comment: "Grade of the petroleum product"
    - name: "price_currency_code"
      expr: price_currency_code
      comment: "Currency of the price"
  measures:
    - name: "average_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final price per price record"
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Sum of final prices across the period"
    - name: "price_record_count"
      expr: COUNT(1)
      comment: "Number of price history records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_emission_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emission factor tracking"
  source: "`oil_gas_ecm`.`product`.`emission_factor`"
  dimensions:
    - name: "emission_category"
      expr: emission_category
      comment: "Category of emission (e.g., CO2, CH4)"
  measures:
    - name: "average_factor_value"
      expr: AVG(CAST(factor_value AS DOUBLE))
      comment: "Average emission factor value"
    - name: "total_factor_value"
      expr: SUM(CAST(factor_value AS DOUBLE))
      comment: "Sum of emission factor values"
    - name: "factor_record_count"
      expr: COUNT(1)
      comment: "Number of emission factor records"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_crude_lifting_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crude lifting performance metrics"
  source: "`oil_gas_ecm`.`product`.`crude_lifting_nomination`"
  dimensions:
    - name: "crude_grade_id"
      expr: crude_grade_id
      comment: "Identifier for the crude grade"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner responsible for the nomination"
    - name: "lifting_priority"
      expr: lifting_priority
      comment: "Priority level of the lifting nomination"
  measures:
    - name: "total_nomination_volume_bbl"
      expr: SUM(CAST(lifting_nomination_volume_bbl AS DOUBLE))
      comment: "Total nominated crude volume (barrels)"
    - name: "total_actual_lifted_volume_bbl"
      expr: SUM(CAST(actual_lifted_volume_bbl AS DOUBLE))
      comment: "Total actual lifted crude volume (barrels)"
    - name: "lift_success_rate_pct"
      expr: AVG(actual_lifted_volume_bbl / NULLIF(lifting_nomination_volume_bbl, 0) * 100)
      comment: "Average percentage of nominated volume that was actually lifted"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`product_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budgeting and forecast KPIs"
  source: "`oil_gas_ecm`.`product`.`budget_allocation`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the budget allocation"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g., approved, pending)"
  measures:
    - name: "total_budgeted_price"
      expr: SUM(CAST(budgeted_price AS DOUBLE))
      comment: "Total budgeted price across allocations"
    - name: "total_budgeted_volume"
      expr: SUM(CAST(budgeted_volume AS DOUBLE))
      comment: "Total budgeted volume across allocations"
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast AS DOUBLE))
      comment: "Aggregated revenue forecast from budget allocations"
    - name: "budget_allocation_count"
      expr: COUNT(1)
      comment: "Number of budget allocation records"
$$;
