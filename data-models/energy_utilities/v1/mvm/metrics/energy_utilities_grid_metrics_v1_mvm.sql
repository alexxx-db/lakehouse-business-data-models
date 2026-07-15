-- Metric views for domain: grid | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_frequency_stability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key frequency stability indicators for operational monitoring and reliability planning"
  source: "`energy_utilities_ecm`.`grid`.`frequency_event`"
  dimensions:
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region where the event occurred"
    - name: "event_type"
      expr: event_type
      comment: "Categorical type of frequency event"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_start_timestamp)
      comment: "Date of the event (day bucket)"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of frequency events recorded"
    - name: "avg_frequency_deviation_hz"
      expr: AVG(CAST(frequency_deviation_hz AS DOUBLE))
      comment: "Average frequency deviation (Hz) across events"
    - name: "max_rocof_hz_per_second"
      expr: MAX(rocof_hz_per_second)
      comment: "Maximum Rate of Change of Frequency observed (Hz/s)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_agc_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automatic Generation Control (AGC) effectiveness and compliance metrics"
  source: "`energy_utilities_ecm`.`grid`.`agc_signal`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier for the AGC signal"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region of the control area"
    - name: "agc_mode"
      expr: agc_mode
      comment: "AGC operating mode"
    - name: "ancillary_service_type"
      expr: ancillary_service_type
      comment: "Type of ancillary service provided"
    - name: "signal_quality_code"
      expr: signal_quality_code
      comment: "Quality code of the AGC signal"
    - name: "signal_date"
      expr: DATE_TRUNC('day', signal_timestamp)
      comment: "Date of the signal (day bucket)"
  measures:
    - name: "total_signals"
      expr: COUNT(1)
      comment: "Total AGC signal records"
    - name: "avg_actual_frequency_hz"
      expr: AVG(CAST(actual_frequency_hz AS DOUBLE))
      comment: "Average actual system frequency (Hz)"
    - name: "avg_regulation_reserve_deployed_mw"
      expr: AVG(CAST(regulation_reserve_deployed_mw AS DOUBLE))
      comment: "Average regulation reserve deployed (MW)"
    - name: "cps1_compliance_rate"
      expr: AVG(CASE WHEN cps1_compliant THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of signals compliant with CPS1 (percentage)"
    - name: "cps2_compliance_rate"
      expr: AVG(CASE WHEN cps2_compliant THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of signals compliant with CPS2 (percentage)"
    - name: "avg_filtered_ace_mw"
      expr: AVG(CAST(filtered_ace_mw AS DOUBLE))
      comment: "Average filtered ACE (MW)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_generation_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation dispatch performance and environmental impact metrics"
  source: "`energy_utilities_ecm`.`grid`.`generation_dispatch`"
  dimensions:
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Identifier of the generating unit"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area where generation is dispatched"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel type of the unit"
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the dispatch"
    - name: "dispatch_type"
      expr: dispatch_type
      comment: "Dispatch classification (e.g., market, reliability)"
    - name: "dispatch_date"
      expr: DATE_TRUNC('day', dispatch_timestamp)
      comment: "Date of the dispatch (day bucket)"
  measures:
    - name: "total_actual_output_mw"
      expr: SUM(CAST(actual_output_mw AS DOUBLE))
      comment: "Total actual generation output (MW) for the period"
    - name: "avg_dispatch_setpoint_mw"
      expr: AVG(CAST(dispatch_mw_setpoint AS DOUBLE))
      comment: "Average dispatch set‑point (MW)"
    - name: "dispatch_compliance_rate"
      expr: AVG(CASE WHEN dispatch_compliance_flag THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of dispatches that met compliance criteria"
    - name: "total_co2_emissions_lbs"
      expr: SUM(emissions_rate_co2_lbs_per_mwh * actual_output_mw)
      comment: "Weighted total CO2 emissions (lbs) based on actual output"
    - name: "avg_ramp_rate_mw_per_min"
      expr: AVG(CAST(ramp_rate_mw_per_min AS DOUBLE))
      comment: "Average ramp rate (MW per minute)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_load_forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load forecast accuracy and error aggregation"
  source: "`energy_utilities_ecm`.`grid`.`load_forecast`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area for which load is forecasted"
    - name: "forecast_horizon_type"
      expr: forecast_horizon_type
      comment: "Type of forecast horizon (e.g., day-ahead, hour-ahead)"
    - name: "day_type"
      expr: day_type
      comment: "Classification of the day (weekday, weekend, holiday)"
    - name: "season"
      expr: season
      comment: "Season of the forecast"
    - name: "forecast_date"
      expr: DATE_TRUNC('day', forecast_run_timestamp)
      comment: "Date of the forecast run"
  measures:
    - name: "total_forecasted_load_mw"
      expr: SUM(CAST(forecasted_load_mw AS DOUBLE))
      comment: "Total forecasted load (MW) for the selected horizon"
    - name: "total_actual_load_mw"
      expr: SUM(CAST(actual_load_mw AS DOUBLE))
      comment: "Total actual load (MW) observed"
    - name: "total_absolute_error_mw"
      expr: SUM(ABS(actual_load_mw - forecasted_load_mw))
      comment: "Sum of absolute forecast errors (MW)"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_reliability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level grid reliability event KPIs for risk and performance management"
  source: "`energy_utilities_ecm`.`grid`.`grid_reliability_event`"
  dimensions:
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region of the event"
    - name: "event_type"
      expr: event_type
      comment: "Categorical type of reliability event"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area impacted"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total grid reliability events recorded"
    - name: "total_mw_impact"
      expr: SUM(CAST(mw_impact AS DOUBLE))
      comment: "Cumulative MW impact across events"
    - name: "avg_severity_index"
      expr: AVG(CAST(severity_index AS DOUBLE))
      comment: "Average severity index of reliability events"
    - name: "nerc_reportable_rate"
      expr: AVG(CASE WHEN nerc_reportable_flag THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of events that are NERC reportable"
    - name: "avg_event_duration_minutes"
      expr: AVG(CAST(event_duration_minutes AS DOUBLE))
      comment: "Average event duration (minutes)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_scada_measurements`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCADA measurement health and power quality metrics"
  source: "`energy_utilities_ecm`.`grid`.`grid_scada_measurement`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area of the measurement"
    - name: "measurement_category"
      expr: measurement_category
      comment: "Category of the SCADA measurement"
    - name: "voltage_level_kv"
      expr: voltage_level_kv
      comment: "Voltage level bucket (kV)"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total SCADA measurement records"
    - name: "avg_active_power_mw"
      expr: AVG(CAST(active_power_mw AS DOUBLE))
      comment: "Average active power (MW) measured"
    - name: "max_voltage_magnitude_kv"
      expr: MAX(voltage_magnitude_kv)
      comment: "Maximum voltage magnitude observed (kV)"
    - name: "alarm_count"
      expr: SUM(CASE WHEN alarm_flag THEN 1 ELSE 0 END)
      comment: "Number of alarmed measurements"
$$;
