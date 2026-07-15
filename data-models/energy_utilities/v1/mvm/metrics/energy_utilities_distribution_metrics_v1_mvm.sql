-- Metric views for domain: distribution | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_substation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key reliability and load metrics at substation level"
  source: "`energy_utilities_ecm`.`distribution`.`distribution_substation`"
  dimensions:
    - name: "substation_type"
      expr: substation_type
      comment: "Classification of substation (e.g., transmission, distribution)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the substation"
    - name: "state_province"
      expr: state_province
      comment: "State or province where the substation is located"
    - name: "city"
      expr: city
      comment: "City of the substation location"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the substation"
  measures:
    - name: "total_average_load_mw"
      expr: SUM(CAST(average_load_mw AS DOUBLE))
      comment: "Total average load across substations (MW)"
    - name: "peak_load_mw"
      expr: MAX(peak_load_mw)
      comment: "Maximum peak load observed at any substation (MW)"
    - name: "total_saidi_minutes"
      expr: SUM(CAST(reliability_index_saidi_minutes AS DOUBLE))
      comment: "Cumulative SAIDI minutes for all substations"
    - name: "total_saifi_count"
      expr: SUM(CAST(reliability_index_saifi_count AS DOUBLE))
      comment: "Cumulative SAIFI interruption count for all substations"
    - name: "total_caidi_minutes"
      expr: SUM(CAST(reliability_index_caidi_minutes AS DOUBLE))
      comment: "Cumulative CAIDI minutes for all substations"
    - name: "substation_count"
      expr: COUNT(1)
      comment: "Number of substations"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_feeder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feeder-level capacity and reliability metrics"
  source: "`energy_utilities_ecm`.`distribution`.`feeder`"
  dimensions:
    - name: "feeder_type"
      expr: feeder_type
      comment: "Type of feeder (e.g., radial, loop)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the feeder"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the feeder"
    - name: "phase_configuration"
      expr: phase_configuration
      comment: "Phase configuration (e.g., single, three)"
  measures:
    - name: "total_feeder_length_miles"
      expr: SUM(CAST(length_miles AS DOUBLE))
      comment: "Total length of all feeders (miles)"
    - name: "peak_load_mw"
      expr: MAX(peak_load_mw)
      comment: "Maximum peak load among feeders (MW)"
    - name: "total_der_hosting_capacity_mw"
      expr: SUM(CAST(der_hosting_capacity_mw AS DOUBLE))
      comment: "Aggregate DER hosting capacity across feeders (MW)"
    - name: "feeder_count"
      expr: COUNT(1)
      comment: "Number of feeder records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_transformer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transformer performance and health metrics"
  source: "`energy_utilities_ecm`.`distribution`.`transformer`"
  dimensions:
    - name: "transformer_type"
      expr: transformer_type
      comment: "Classification of transformer (e.g., step-up, step-down)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the transformer"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the transformer"
    - name: "primary_voltage_kv"
      expr: primary_voltage_kv
      comment: "Primary voltage rating (kV)"
    - name: "distribution_substation_id"
      expr: distribution_substation_id
      comment: "Substation to which the transformer is attached"
  measures:
    - name: "total_kva_rating"
      expr: SUM(CAST(kva_rating AS DOUBLE))
      comment: "Total transformer capacity (kVA)"
    - name: "avg_health_index_score"
      expr: AVG(CAST(health_index_score AS DOUBLE))
      comment: "Average health index score across transformers"
    - name: "total_load_loss_watts"
      expr: SUM(CAST(load_loss_watts AS DOUBLE))
      comment: "Cumulative load loss (watts) for all transformers"
    - name: "transformer_count"
      expr: COUNT(1)
      comment: "Number of transformer records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_capacitor_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacitor bank capacity and VVO participation"
  source: "`energy_utilities_ecm`.`distribution`.`capacitor_bank`"
  dimensions:
    - name: "bank_type"
      expr: bank_type
      comment: "Type of capacitor bank (e.g., shunt, series)"
    - name: "control_mode"
      expr: control_mode
      comment: "Control mode of the bank"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model"
    - name: "voltage_rating_kv"
      expr: voltage_rating_kv
      comment: "Voltage rating of the bank (kV)"
  measures:
    - name: "total_rated_kvar"
      expr: SUM(CAST(rated_kvar AS DOUBLE))
      comment: "Total reactive power rating of capacitor banks (kVAR)"
    - name: "enabled_bank_count"
      expr: SUM(CASE WHEN volt_var_optimization_enabled THEN 1 ELSE 0 END)
      comment: "Count of capacitor banks with VVO enabled"
    - name: "total_bank_count"
      expr: COUNT(1)
      comment: "Total number of capacitor bank records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_der_interconnection_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DER interconnection capacity and inventory metrics"
  source: "`energy_utilities_ecm`.`distribution`.`der_interconnection_point`"
  dimensions:
    - name: "der_type"
      expr: der_type
      comment: "Broad DER classification (e.g., solar, wind)"
    - name: "der_subtype"
      expr: der_subtype
      comment: "Specific DER subtype"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the DER point"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the DER"
    - name: "feeder_id"
      expr: feeder_id
      comment: "Feeder that primarily serves the DER"
  measures:
    - name: "total_export_capacity_kw"
      expr: SUM(CAST(export_capacity_kw AS DOUBLE))
      comment: "Aggregate export capacity of DER interconnection points (kW)"
    - name: "der_count"
      expr: COUNT(1)
      comment: "Number of DER interconnection points"
    - name: "avg_nameplate_capacity_kw"
      expr: AVG(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Average nameplate capacity of DERs (kW)"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_reliability_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability event impact metrics"
  source: "`energy_utilities_ecm`.`distribution`.`distribution_reliability_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Classification of reliability event"
    - name: "critical_customer_affected_flag"
      expr: critical_customer_affected_flag
      comment: "Flag indicating if critical customers were affected"
    - name: "cause_id"
      expr: cause_id
      comment: "Root cause identifier for the event"
  measures:
    - name: "total_customers_interrupted_minutes"
      expr: SUM(CAST(customer_minutes_interrupted AS DOUBLE))
      comment: "Cumulative customer interruption minutes"
    - name: "total_energy_not_served_mwh"
      expr: SUM(CAST(energy_not_served_mwh AS DOUBLE))
      comment: "Total energy not served due to reliability events (MWh)"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of reliability events (minutes)"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of reliability events recorded"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_feeder_load_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feeder load reading performance metrics"
  source: "`energy_utilities_ecm`.`distribution`.`feeder_load_reading`"
  dimensions:
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of the reading (day bucket)"
    - name: "event_id"
      expr: event_id
      comment: "Associated event identifier"
  measures:
    - name: "total_active_power_mw"
      expr: SUM(CAST(active_power_mw AS DOUBLE))
      comment: "Total active power recorded across feeder readings (MW)"
    - name: "avg_power_factor"
      expr: AVG(CAST(power_factor AS DOUBLE))
      comment: "Average power factor across readings"
    - name: "max_voltage_phase_a_kv"
      expr: MAX(voltage_phase_a_kv)
      comment: "Maximum Phase A voltage observed (kV)"
    - name: "reading_count"
      expr: COUNT(1)
      comment: "Number of feeder load reading records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_volt_var_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volt‑VAR optimization action effectiveness metrics"
  source: "`energy_utilities_ecm`.`distribution`.`volt_var_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of VVO action (e.g., capacitor, tap changer)"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action"
    - name: "volt_load_zone_id"
      expr: volt_load_zone_id
      comment: "Load zone where the action was applied"
  measures:
    - name: "total_demand_reduction_kw"
      expr: SUM(CAST(demand_reduction_kw AS DOUBLE))
      comment: "Total demand reduction achieved by VVO actions (kW)"
    - name: "avg_voltage_improvement_pu"
      expr: AVG(CAST(voltage_improvement_pu AS DOUBLE))
      comment: "Average per-unit voltage improvement from actions"
    - name: "action_count"
      expr: COUNT(1)
      comment: "Number of VVO actions executed"
$$;
