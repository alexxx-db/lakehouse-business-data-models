-- Metric views for domain: wastewater | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_biosolids_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production and quality KPIs for biosolids batches"
  source: "`vibe_water_utilities_v1`.`wastewater`.`biosolids_batch`"
  dimensions:
    - name: "batch_year"
      expr: DATE_TRUNC('year', batch_date)
      comment: "Year the biosolids batch was produced"
    - name: "wwtp_id"
      expr: wwtp_id
      comment: "Identifier of the wastewater treatment plant producing the batch"
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Process type used for biosolids treatment"
    - name: "exceptional_quality_flag"
      expr: exceptional_quality_flag
      comment: "Flag indicating whether the batch met exceptional quality criteria"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of biosolids production batches"
    - name: "total_dry_weight_tons"
      expr: SUM(CAST(dry_weight_tons AS DOUBLE))
      comment: "Sum of dry weight of biosolids produced (tons)"
    - name: "average_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH of biosolids across batches"
    - name: "average_percent_solids"
      expr: AVG(CAST(percent_solids AS DOUBLE))
      comment: "Average percent solids in biosolids"
    - name: "exceptional_quality_batch_count"
      expr: COUNT(CASE WHEN exceptional_quality_flag THEN 1 END)
      comment: "Count of batches flagged as exceptional quality"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_collection_system_blockage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor frequency, cost and severity of collection system blockages"
  source: "`vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`"
  dimensions:
    - name: "blockage_year"
      expr: DATE_TRUNC('year', event_timestamp)
      comment: "Year of the blockage event"
    - name: "blockage_type"
      expr: blockage_type
      comment: "Type/category of blockage"
    - name: "blockage_severity"
      expr: blockage_severity
      comment: "Severity level of the blockage"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of blockage"
  measures:
    - name: "total_blockages"
      expr: COUNT(1)
      comment: "Total number of collection system blockage incidents"
    - name: "average_clearance_time_minutes"
      expr: AVG(CAST(clearance_time_minutes AS DOUBLE))
      comment: "Average time to clear a blockage (minutes)"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Sum of estimated cost for all blockage incidents (USD)"
    - name: "severe_blockage_count"
      expr: COUNT(CASE WHEN blockage_severity = 'Severe' THEN 1 END)
      comment: "Count of blockages classified as Severe"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_cso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for CSO events, supporting operational and regulatory decision‑making"
  source: "`vibe_water_utilities_v1`.`wastewater`.`cso_event`"
  dimensions:
    - name: "event_year"
      expr: DATE_TRUNC('year', event_start_timestamp)
      comment: "Calendar year of the CSO event start"
    - name: "outfall_id"
      expr: outfall_id
      comment: "Identifier of the outfall where overflow occurred"
    - name: "cause_category"
      expr: cause_category
      comment: "High‑level cause category for the CSO event"
  measures:
    - name: "total_cso_events"
      expr: COUNT(1)
      comment: "Total number of Combined Sewer Overflow (CSO) events"
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Sum of overflow volume in gallons across all CSO events"
    - name: "average_event_duration_minutes"
      expr: AVG(CAST(event_duration_minutes AS DOUBLE))
      comment: "Average duration of CSO events in minutes"
    - name: "total_precipitation_inches"
      expr: SUM(CAST(precipitation_amount_inches AS DOUBLE))
      comment: "Total precipitation associated with CSO events (in inches)"
    - name: "public_notification_events"
      expr: COUNT(CASE WHEN public_notification_required THEN 1 END)
      comment: "Count of CSO events where public notification was required"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_effluent_discharge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPIs for effluent discharge compliance and volume management"
  source: "`vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event`"
  dimensions:
    - name: "discharge_year"
      expr: DATE_TRUNC('year', discharge_start_timestamp)
      comment: "Year of the discharge event"
    - name: "wwtp_id"
      expr: wwtp_id
      comment: "Identifier of the wastewater treatment plant"
    - name: "outfall_id"
      expr: outfall_id
      comment: "Outfall associated with the discharge"
    - name: "discharge_type"
      expr: discharge_type
      comment: "Classification of the discharge (e.g., routine, emergency)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the discharge"
  measures:
    - name: "total_discharge_events"
      expr: COUNT(1)
      comment: "Total number of effluent discharge events"
    - name: "total_discharge_volume_mgd"
      expr: SUM(CAST(discharge_volume_mgd AS DOUBLE))
      comment: "Sum of discharge volume (million gallons per day) across all events"
    - name: "average_discharge_flow_rate_gpm"
      expr: AVG(CAST(discharge_flow_rate_gpm AS DOUBLE))
      comment: "Average discharge flow rate in gallons per minute"
    - name: "compliant_discharge_events"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of discharge events that met compliance status"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_ii_flow_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to assess infiltration/inflow volumes and alarm occurrences"
  source: "`vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement`"
  dimensions:
    - name: "measurement_year"
      expr: DATE_TRUNC('year', measurement_timestamp)
      comment: "Year of the II measurement"
    - name: "ii_type"
      expr: ii_type
      comment: "Type of II measurement (e.g., infiltration, inflow)"
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Whether the measurement triggered an alarm"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of infiltration/inflow (II) flow measurements recorded"
    - name: "total_measured_flow_mgd"
      expr: SUM(CAST(measured_flow_rate_mgd AS DOUBLE))
      comment: "Sum of measured II flow rates (million gallons per day)"
    - name: "average_calculated_volume_gallons"
      expr: AVG(CAST(calculated_ii_volume_gallons AS DOUBLE))
      comment: "Average calculated II volume per measurement (gallons)"
    - name: "alarm_triggered_count"
      expr: COUNT(CASE WHEN alarm_triggered_flag THEN 1 END)
      comment: "Count of measurements where an alarm was triggered"
$$;