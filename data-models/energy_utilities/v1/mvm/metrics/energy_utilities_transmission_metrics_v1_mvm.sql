-- Metric views for domain: transmission | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_atc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key ATC capability metrics for planning and reliability"
  source: "`energy_utilities_ecm`.`transmission`.`atc_calculation`"
  dimensions:
    - name: "calculation_type"
      expr: calculation_type
      comment: "Methodology type of the ATC calculation"
    - name: "calculation_timestamp"
      expr: calculation_timestamp
      comment: "Timestamp when the ATC calculation was performed"
    - name: "path_id"
      expr: path_id
      comment: "Identifier of the primary transmission path for the ATC"
  measures:
    - name: "total_firm_atc_mw"
      expr: SUM(CAST(firm_atc_mw AS DOUBLE))
      comment: "Total firm ATC (MW) across all calculations"
    - name: "total_non_firm_atc_mw"
      expr: SUM(CAST(non_firm_atc_mw AS DOUBLE))
      comment: "Total non‑firm ATC (MW) across all calculations"
    - name: "avg_atc_mw"
      expr: AVG(CAST(atc_mw AS DOUBLE))
      comment: "Average ATC (MW) per calculation"
    - name: "max_atc_mw"
      expr: MAX(CAST(atc_mw AS DOUBLE))
      comment: "Maximum ATC (MW) observed"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_congestion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated congestion impact metrics for operational and market analysis"
  source: "`energy_utilities_ecm`.`transmission`.`congestion_event`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area where congestion occurred"
    - name: "market_type"
      expr: market_type
      comment: "Market type (e.g., day‑ahead, real‑time)"
    - name: "congestion_start_timestamp"
      expr: congestion_start_timestamp
      comment: "Start time of the congestion event"
    - name: "congestion_direction"
      expr: congestion_direction
      comment: "Direction of congestion flow"
  measures:
    - name: "total_congestion_cost_usd"
      expr: SUM(CAST(congestion_cost_usd AS DOUBLE))
      comment: "Total cost of congestion events (USD)"
    - name: "total_curtailed_mw"
      expr: SUM(CAST(curtailed_mw AS DOUBLE))
      comment: "Total MW curtailed due to congestion"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of congestion events recorded"
    - name: "avg_lmp_differential_usd_per_mwh"
      expr: AVG(CAST(lmp_differential_usd_per_mwh AS DOUBLE))
      comment: "Average LMP differential (USD/MWh) across events"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage performance and impact metrics for reliability management"
  source: "`energy_utilities_ecm`.`transmission`.`transmission_outage`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Classification of outage (e.g., planned, forced)"
    - name: "outage_status"
      expr: outage_status
      comment: "Current status of the outage"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area affected by the outage"
    - name: "start_timestamp"
      expr: start_timestamp
      comment: "Timestamp when outage began"
  measures:
    - name: "total_outage_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Cumulative outage duration (hours)"
    - name: "total_mw_impact"
      expr: SUM(CAST(mw_impact AS DOUBLE))
      comment: "Total MW impact across outages"
    - name: "outage_count"
      expr: COUNT(1)
      comment: "Number of transmission outages recorded"
    - name: "avg_estimated_repair_cost_usd"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per outage (USD)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and capacity commitments from transmission service agreements"
  source: "`energy_utilities_ecm`.`transmission`.`transmission_service_agreement`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of transmission service (e.g., firm, non‑firm)"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement"
    - name: "term_start_date"
      expr: term_start_date
      comment: "Agreement start date"
    - name: "term_end_date"
      expr: term_end_date
      comment: "Agreement end date"
  measures:
    - name: "total_contracted_capacity_mw"
      expr: SUM(CAST(contracted_capacity_mw AS DOUBLE))
      comment: "Total contracted transmission capacity (MW)"
    - name: "total_monthly_capacity_charge_usd"
      expr: SUM(CAST(monthly_capacity_charge_usd AS DOUBLE))
      comment: "Total monthly capacity charges (USD)"
    - name: "total_collateral_amount_usd"
      expr: SUM(CAST(collateral_amount_usd AS DOUBLE))
      comment: "Total collateral posted for agreements (USD)"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of active service agreements"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`transmission_power_transformer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transformer asset health and capacity metrics for asset management"
  source: "`energy_utilities_ecm`.`transmission`.`power_transformer`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the transformer"
    - name: "is_critical_asset"
      expr: is_critical_asset
      comment: "Flag indicating if transformer is a critical asset"
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the transformer was commissioned"
  measures:
    - name: "avg_health_index"
      expr: AVG(CAST(health_index AS DOUBLE))
      comment: "Average health index of transformers"
    - name: "count_critical_assets"
      expr: SUM(CASE WHEN is_critical_asset THEN 1 ELSE 0 END)
      comment: "Number of critical transformers"
    - name: "total_mva_rating"
      expr: SUM(CAST(mva_rating AS DOUBLE))
      comment: "Aggregate MVA rating of transformers"
    - name: "transformer_count"
      expr: COUNT(1)
      comment: "Total number of transformers"
$$;
