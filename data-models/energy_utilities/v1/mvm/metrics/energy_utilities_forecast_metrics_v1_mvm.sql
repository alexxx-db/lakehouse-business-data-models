-- Metric views for domain: forecast | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key accuracy KPIs for forecast models, enabling executive oversight of model performance and regulatory compliance."
  source: "`energy_utilities_ecm`.`forecast`.`accuracy`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "zone_id"
      expr: zone_id
      comment: "Geographic zone of the forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., load, generation)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of forecast accuracy records"
    - name: "avg_absolute_error_mw"
      expr: AVG(CAST(absolute_error_mw AS DOUBLE))
      comment: "Average absolute error in MW across forecasts"
    - name: "avg_mae_mw"
      expr: AVG(CAST(mae_mw AS DOUBLE))
      comment: "Mean Absolute Error (MAE) in MW"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_capacity_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity planning metrics that inform investment decisions and reliability assessments."
  source: "`energy_utilities_ecm`.`forecast`.`capacity_requirement`"
  dimensions:
    - name: "planning_period_id"
      expr: planning_period_id
      comment: "Planning period identifier"
    - name: "zone_id"
      expr: zone_id
      comment: "RTO/ISO zone associated with the requirement"
    - name: "requirement_type"
      expr: requirement_type
      comment: "Category of capacity requirement (e.g., renewable, thermal)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of capacity requirement records"
    - name: "total_capacity_deficiency_mw"
      expr: SUM(CAST(capacity_deficiency_mw AS DOUBLE))
      comment: "Total capacity deficiency in MW for the planning period"
    - name: "total_capacity_surplus_mw"
      expr: SUM(CAST(capacity_surplus_mw AS DOUBLE))
      comment: "Total capacity surplus in MW for the planning period"
    - name: "avg_auction_price_per_mw_day"
      expr: AVG(CAST(capacity_auction_clearing_price_per_mw_day AS DOUBLE))
      comment: "Average auction clearing price per MW‑day"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_energy_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market‑level price KPIs that drive revenue forecasting and hedging strategies."
  source: "`energy_utilities_ecm`.`forecast`.`energy_price`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "market_type"
      expr: market_type
      comment: "Market classification (e.g., day‑ahead, real‑time)"
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO code"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of energy price records"
    - name: "avg_lmp_total_usd_per_mwh"
      expr: AVG(CAST(lmp_total_usd_per_mwh AS DOUBLE))
      comment: "Average total locational marginal price (LMP) in USD/MWh"
    - name: "avg_renewable_credit_price_usd"
      expr: AVG(CAST(renewable_energy_credit_price_usd AS DOUBLE))
      comment: "Average renewable energy credit price in USD"
    - name: "avg_carbon_price_usd_per_ton"
      expr: AVG(CAST(carbon_price_usd_per_ton AS DOUBLE))
      comment: "Average carbon price in USD per ton"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_load_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load forecasting performance metrics used for operational planning and demand‑side management."
  source: "`energy_utilities_ecm`.`forecast`.`load`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area for the load forecast"
    - name: "zone_id"
      expr: zone_id
      comment: "Geographic zone of the load forecast"
    - name: "day_type"
      expr: day_type
      comment: "Day type (e.g., weekday, weekend)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of load forecast records"
    - name: "avg_peak_demand_mw"
      expr: AVG(CAST(peak_demand_mw AS DOUBLE))
      comment: "Average forecasted peak demand in MW"
    - name: "avg_total_energy_mwh"
      expr: AVG(CAST(total_energy_mwh AS DOUBLE))
      comment: "Average total energy forecast in MWh"
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error of load forecasts"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_peak_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive‑level peak demand KPIs that influence capacity investment and reliability planning."
  source: "`energy_utilities_ecm`.`forecast`.`peak_demand`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area associated with the peak demand"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Forecast type (e.g., short‑term, long‑term)"
    - name: "peak_date"
      expr: peak_date
      comment: "Date of the forecasted peak"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of peak demand records"
    - name: "max_peak_mw"
      expr: MAX(mw)
      comment: "Maximum forecasted peak demand in MW"
    - name: "avg_peak_error_mw"
      expr: AVG(CAST(forecast_error_mw AS DOUBLE))
      comment: "Average forecast error for peak demand in MW"
    - name: "pct_capex_trigger_flag"
      expr: AVG(CASE WHEN capex_trigger_flag THEN 1 ELSE 0 END) * 100
      comment: "Percentage of peaks that trigger CAPEX decisions"
$$;
