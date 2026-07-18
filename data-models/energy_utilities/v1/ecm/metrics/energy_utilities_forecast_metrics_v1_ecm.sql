-- Metric views for domain: forecast | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key accuracy performance indicators for forecasting models"
  source: "`energy_utilities_ecm`.`forecast`.`accuracy`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "model_id"
      expr: accuracy_model_id
      comment: "Forecast model used for the prediction"
    - name: "zone_id"
      expr: zone_id
      comment: "Geographic zone of the forecast"
    - name: "day_type"
      expr: day_type
      comment: "Classification of the day (e.g., weekday, weekend)"
    - name: "forecast_horizon_hours"
      expr: forecast_horizon_hours
      comment: "Forecast horizon expressed in hours"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., load, price)"
  measures:
    - name: "average_mae_mw"
      expr: AVG(CAST(mae_mw AS DOUBLE))
      comment: "Mean Absolute Error across forecasts, lower is better for accuracy"
    - name: "average_mape_percent"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Mean Absolute Percentage Error, expresses error as a percent of actual values"
    - name: "average_rmse_mw"
      expr: AVG(CAST(rmse_mw AS DOUBLE))
      comment: "Root Mean Squared Error, penalizes larger errors"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of forecast accuracy records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_capacity_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity planning metrics for reliability and market participation"
  source: "`energy_utilities_ecm`.`forecast`.`capacity_requirement`"
  dimensions:
    - name: "planning_period_id"
      expr: planning_period_id
      comment: "Planning period associated with the requirement"
    - name: "zone_id"
      expr: zone_id
      comment: "RTO/ISO zone identifier"
    - name: "requirement_type"
      expr: requirement_type
      comment: "Category of capacity requirement (e.g., renewable, thermal)"
    - name: "requirement_status"
      expr: requirement_status
      comment: "Current status of the requirement (e.g., approved, pending)"
  measures:
    - name: "total_capacity_surplus_mw"
      expr: SUM(CAST(capacity_surplus_mw AS DOUBLE))
      comment: "Total surplus capacity across all zones"
    - name: "total_capacity_deficiency_mw"
      expr: SUM(CAST(capacity_deficiency_mw AS DOUBLE))
      comment: "Total capacity shortfall that must be addressed"
    - name: "total_import_limit_mw"
      expr: SUM(CAST(capacity_import_limit_mw AS DOUBLE))
      comment: "Aggregate import capacity limit"
    - name: "total_export_limit_mw"
      expr: SUM(CAST(capacity_export_limit_mw AS DOUBLE))
      comment: "Aggregate export capacity limit"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of capacity requirement records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_energy_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and load forecast KPIs for market analysis"
  source: "`energy_utilities_ecm`.`forecast`.`energy_price`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "pricing_node_id"
      expr: pricing_node_id
      comment: "Pricing node associated with the price"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Forecast type (e.g., day-ahead, real-time)"
    - name: "market_type"
      expr: market_type
      comment: "Market segment (e.g., energy, ancillary services)"
  measures:
    - name: "average_lmp_total_usd_per_mwh"
      expr: AVG(CAST(lmp_total_usd_per_mwh AS DOUBLE))
      comment: "Average locational marginal price across the market"
    - name: "average_load_forecast_mw"
      expr: AVG(CAST(load_forecast_mw AS DOUBLE))
      comment: "Average forecasted load in MW"
    - name: "average_renewable_generation_mw"
      expr: AVG(CAST(renewable_generation_forecast_mw AS DOUBLE))
      comment: "Average forecasted renewable generation in MW"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of energy price records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation forecast performance metrics for operational planning"
  source: "`energy_utilities_ecm`.`forecast`.`forecast_generation`"
  dimensions:
    - name: "forecast_run_id"
      expr: forecast_run_id
      comment: "Identifier of the forecast run"
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Generating unit identifier"
    - name: "interval_hour"
      expr: DATE_TRUNC('hour', interval_timestamp)
      comment: "Hour bucket of the forecast interval"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of generation forecast"
  measures:
    - name: "total_forecasted_output_mw"
      expr: SUM(CAST(forecasted_output_mw AS DOUBLE))
      comment: "Total forecasted generation output in MW"
    - name: "total_actual_output_mw"
      expr: SUM(CAST(actual_output_mw AS DOUBLE))
      comment: "Total actual generation output in MW"
    - name: "average_capacity_factor_percent"
      expr: AVG(CAST(capacity_factor_percent AS DOUBLE))
      comment: "Average capacity factor, indicating utilization efficiency"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of generation forecast records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`forecast_resource_adequacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to evaluate whether capacity meets projected demand and reliability standards"
  source: "`energy_utilities_ecm`.`forecast`.`resource_adequacy_assessment`"
  dimensions:
    - name: "assessment_period_start_date"
      expr: assessment_period_start_date
      comment: "Start date of the assessment period"
    - name: "assessment_period_end_date"
      expr: assessment_period_end_date
      comment: "End date of the assessment period"
    - name: "irp_scenario_id"
      expr: irp_scenario_id
      comment: "Integrated Resource Planning scenario identifier"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area for the assessment"
  measures:
    - name: "total_available_generation_capacity_mw"
      expr: SUM(CAST(available_generation_capacity_mw AS DOUBLE))
      comment: "Total generation capacity available for adequacy assessment"
    - name: "total_forecasted_peak_demand_mw"
      expr: SUM(CAST(forecasted_peak_demand_mw AS DOUBLE))
      comment: "Aggregate forecasted peak demand"
    - name: "average_loss_of_load_expectation_days"
      expr: AVG(CAST(loss_of_load_expectation_days_per_year AS DOUBLE))
      comment: "Average expected days of load loss per year"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of resource adequacy assessment records"
$$;
