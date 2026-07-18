-- Metric views for domain: collateral | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key collateral asset KPIs for risk and eligibility monitoring."
  source: "`banking_ecm`.`collateral`.`collateral_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the collateral asset."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier of the collateral asset."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the collateral was acquired."
    - name: "country_id"
      expr: country_id
      comment: "Country jurisdiction of the collateral."
  measures:
    - name: "total_collateral_count"
      expr: COUNT(1)
      comment: "Number of collateral asset records."
    - name: "total_collateral_value"
      expr: SUM(CAST(collateral_value AS DOUBLE))
      comment: "Aggregate nominal value of all collateral assets."
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Aggregate market value of all collateral assets."
    - name: "total_risk_weighted_assets"
      expr: SUM(CAST(risk_weight_percentage AS DOUBLE) * CAST(collateral_value AS DOUBLE) / 100.0)
      comment: "Risk‑weighted assets calculated as risk weight % of collateral value."
    - name: "average_haircut_percentage"
      expr: AVG(CAST(haircut_percentage AS DOUBLE))
      comment: "Average haircut applied across collateral assets."
    - name: "eligible_collateral_count"
      expr: SUM(CASE WHEN eligibility_flag THEN 1 ELSE 0 END)
      comment: "Count of collateral assets flagged as eligible."
    - name: "concentration_limit_breach_count"
      expr: SUM(CASE WHEN concentration_limit_flag THEN 1 ELSE 0 END)
      comment: "Number of assets breaching concentration limits."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collateral position metrics for margin and exposure monitoring."
  source: "`banking_ecm`.`collateral`.`collateral_position`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the collateral position."
    - name: "position_type"
      expr: position_type
      comment: "Type of the collateral position (e.g., pledged, received)."
    - name: "netting_set_id"
      expr: netting_set_id
      comment: "Identifier of the netting set associated with the position."
  measures:
    - name: "total_position_count"
      expr: COUNT(1)
      comment: "Number of collateral position records."
    - name: "total_net_collateral_value"
      expr: SUM(CAST(net_collateral_value AS DOUBLE))
      comment: "Sum of net collateral value across positions."
    - name: "total_net_margin_requirement"
      expr: SUM(CAST(net_margin_requirement AS DOUBLE))
      comment: "Total net margin requirement for all positions."
    - name: "average_haircut_percentage"
      expr: AVG(CAST(haircut_percentage AS DOUBLE))
      comment: "Average haircut percentage applied to positions."
    - name: "concentration_limit_breach_count"
      expr: SUM(CASE WHEN concentration_limit_breach THEN 1 ELSE 0 END)
      comment: "Count of positions breaching concentration limits."
    - name: "total_gross_positive_exposure"
      expr: SUM(CAST(gross_positive_exposure AS DOUBLE))
      comment: "Aggregate gross positive exposure across positions."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation‑level KPIs for collateral pricing and model confidence."
  source: "`banking_ecm`.`collateral`.`collateral_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used to value the collateral (e.g., market, model)."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of the valuation record."
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of the valuation date."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the valuation."
  measures:
    - name: "total_valuation_count"
      expr: COUNT(1)
      comment: "Number of collateral valuation records."
    - name: "total_net_collateral_value"
      expr: SUM(CAST(net_collateral_value AS DOUBLE))
      comment: "Sum of net collateral value from valuations."
    - name: "total_haircut_amount"
      expr: SUM(CAST(haircut_amount AS DOUBLE))
      comment: "Total haircut amount applied in valuations."
    - name: "average_confidence_interval_width"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE) - CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average width of confidence intervals for valuation estimates."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_margin_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Margin exposure metrics for risk and capital allocation."
  source: "`banking_ecm`.`collateral`.`margin_exposure`"
  dimensions:
    - name: "exposure_year"
      expr: YEAR(exposure_date)
      comment: "Year of the exposure date."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the exposure amount."
  measures:
    - name: "total_exposure_count"
      expr: COUNT(1)
      comment: "Number of margin exposure records."
    - name: "total_initial_margin"
      expr: SUM(CAST(initial_margin_amount AS DOUBLE))
      comment: "Aggregate initial margin amount across exposures."
    - name: "total_variation_margin"
      expr: SUM(CAST(variation_margin_amount AS DOUBLE))
      comment: "Aggregate variation margin amount across exposures."
    - name: "total_rwa"
      expr: SUM(CAST(rwa_amount AS DOUBLE))
      comment: "Total risk‑weighted assets derived from margin exposures."
    - name: "total_gne_amount"
      expr: SUM(CAST(gne_amount AS DOUBLE))
      comment: "Aggregate gross negative exposure amount."
$$;


CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge‑level KPIs for collateral coverage and substitution risk."
  source: "`banking_ecm`.`collateral`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g., active, released)."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the pledged amount."
    - name: "pledge_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g., cash, securities)."
  measures:
    - name: "total_pledge_count"
      expr: COUNT(1)
      comment: "Number of pledge records."
    - name: "total_pledge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Aggregate pledged amount across all pledges."
    - name: "average_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan‑to‑value ratio for pledges."
    - name: "substitution_allowed_count"
      expr: SUM(CASE WHEN substitution_allowed_flag THEN 1 ELSE 0 END)
      comment: "Count of pledges where substitution is allowed."
$$;
