-- Metric views for domain: distribution | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_nrw_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic NRW performance metrics per DMA and audit period."
  source: "`vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the Distribution Management Area (DMA)."
    - name: "audit_period_month"
      expr: DATE_TRUNC('month', audit_period_start_date)
      comment: "Month of the audit period start date."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Completed, In‑Progress)."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the audit (e.g., Metered, Estimated)."
  measures:
    - name: "total_apparent_losses_mg"
      expr: SUM(CAST(apparent_losses_mg AS DOUBLE))
      comment: "Total apparent water losses (mg) across the selected period and DMA."
    - name: "total_real_losses_mg"
      expr: SUM(CAST(real_losses_mg AS DOUBLE))
      comment: "Total real water losses (mg) across the selected period and DMA."
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non‑Revenue Water (NRW) percentage across records."
    - name: "total_unauthorized_consumption_mg"
      expr: SUM(CAST(unauthorized_consumption_mg AS DOUBLE))
      comment: "Total unauthorized water consumption (mg) across the selected period and DMA."
    - name: "count_balances"
      expr: COUNT(1)
      comment: "Number of NRW balance records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational flow and pressure KPIs for distribution network."
  source: "`vibe_water_utilities_v1`.`distribution`.`flow_reading`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the reading was taken."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g., Instantaneous, Averaged)."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of the flow reading (day granularity)."
  measures:
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total flow volume recorded (MG) across all readings."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average pressure (psi) observed across readings."
    - name: "count_readings"
      expr: COUNT(1)
      comment: "Number of flow reading records."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flushing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flushing event effectiveness and volume metrics."
  source: "`vibe_water_utilities_v1`.`distribution`.`flushing_event`"
  dimensions:
    - name: "flush_reason"
      expr: flush_reason
      comment: "Reason for the flushing event (e.g., Maintenance, Water Quality)."
    - name: "flush_status"
      expr: flush_status
      comment: "Current status of the flushing event."
    - name: "flush_month"
      expr: DATE_TRUNC('month', flush_date)
      comment: "Month of the flushing event."
  measures:
    - name: "total_volume_discharged_gallons"
      expr: SUM(CAST(volume_discharged_gallons AS DOUBLE))
      comment: "Total volume of water discharged during flushing events (gallons)."
    - name: "count_flush_events"
      expr: COUNT(1)
      comment: "Number of flushing events recorded."
    - name: "avg_flush_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of flushing events (minutes)."
    - name: "effective_flush_count"
      expr: SUM(CASE WHEN flush_effectiveness_rating = 'Effective' THEN 1 ELSE 0 END)
      comment: "Count of flushing events rated as Effective."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Main break impact and repair performance metrics."
  source: "`vibe_water_utilities_v1`.`distribution`.`main_break`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the break occurred."
    - name: "break_type"
      expr: break_type
      comment: "Type of main break (e.g., Pipe rupture, Valve failure)."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the break (e.g., Open, Closed)."
    - name: "break_month"
      expr: DATE_TRUNC('month', break_timestamp)
      comment: "Month when the break was reported."
  measures:
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water loss (gallons) attributed to main breaks."
    - name: "count_breaks"
      expr: COUNT(1)
      comment: "Number of main break incidents recorded."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average repair duration for main breaks (hours)."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_storage_tank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tank capacity and operational status KPIs."
  source: "`vibe_water_utilities_v1`.`distribution`.`storage_tank`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the tank is located."
    - name: "tank_type"
      expr: tank_type
      comment: "Classification of tank (e.g., Elevated, Ground)."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the tank was installed."
  measures:
    - name: "total_capacity_gallons"
      expr: SUM(CAST(capacity_gallons AS DOUBLE))
      comment: "Aggregate storage capacity across tanks (gallons)."
    - name: "total_usable_capacity_gallons"
      expr: SUM(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Aggregate usable capacity across tanks (gallons)."
    - name: "count_tanks"
      expr: COUNT(1)
      comment: "Number of storage tank records."
    - name: "operational_tank_count"
      expr: SUM(CASE WHEN operational_status = 'Operational' THEN 1 ELSE 0 END)
      comment: "Count of tanks currently in operational status."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_nrw_water_balance_losses`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real and apparent losses versus system input per AWWA M36, the flagship water-loss KPI for the utility."
  source: "`vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "Audit Period Type"
      expr: audit_period_type
      comment: "Audit period"
    - name: "Data Grading"
      expr: data_grading
      comment: "AWWA data grade"
  measures:
    - name: "Real Losses MG"
      expr: ROUND(SUM(CAST(current_annual_real_losses_mg AS DOUBLE)), 2)
      comment: "Current annual real losses"
    - name: "Apparent Losses MG"
      expr: ROUND(SUM(CAST(apparent_losses_mg AS DOUBLE)), 2)
      comment: "Apparent losses"
    - name: "Authorized Consumption MG"
      expr: ROUND(SUM(CAST(authorized_consumption_mg AS DOUBLE)), 2)
      comment: "Authorized consumption"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_billed_metered_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billed metered against billed unmetered consumption from the water balance, framing revenue capture efficiency."
  source: "`vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "Audit Status"
      expr: audit_status
      comment: "Audit status"
  measures:
    - name: "Billed Metered MG"
      expr: ROUND(SUM(CAST(billed_metered_consumption_mg AS DOUBLE)), 2)
      comment: "Billed metered consumption"
    - name: "Billed Unmetered MG"
      expr: ROUND(SUM(CAST(billed_unmetered_consumption_mg AS DOUBLE)), 2)
      comment: "Billed unmetered consumption"
    - name: "Meter Inaccuracy MG"
      expr: ROUND(SUM(CAST(customer_meter_inaccuracies_mg AS DOUBLE)), 2)
      comment: "Losses from meter inaccuracies"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_main_break_frequency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Count of distribution main breaks and affected customers, a core infrastructure reliability KPI (breaks per period)."
  source: "`vibe_water_utilities_v1`.`distribution`.`main_break`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "Break Type"
      expr: break_type
      comment: "Type of break"
    - name: "Break Status"
      expr: break_status
      comment: "Status"
  measures:
    - name: "Break Count"
      expr: COUNT(1)
      comment: "Number of main breaks"
    - name: "Total Affected Customers"
      expr: SUM(CAST(affected_customer_count AS DOUBLE))
      comment: "Customers affected"
    - name: "Boil Water Advisory %"
      expr: ROUND(100.0 * SUM(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent triggering boil-water advisory"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_leak_detection_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leaks found per survey and estimated leak rate, driving proactive NRW reduction program ROI."
  source: "`vibe_water_utilities_v1`.`distribution`.`leak_detection_survey`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
  measures:
    - name: "Total Leaks Found"
      expr: SUM(CAST(leaks_found_count AS DOUBLE))
      comment: "Leaks found"
    - name: "Avg Estimated Leak Rate GPM"
      expr: ROUND(AVG(CAST(estimated_leak_rate_gpm AS DOUBLE)), 2)
      comment: "Average estimated leak rate"
    - name: "Surveys"
      expr: COUNT(1)
      comment: "Number of surveys"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_valve_exercising_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valve exercise completion and deficiency rate, an operability KPI for isolation readiness."
  source: "`vibe_water_utilities_v1`.`distribution`.`valve_exercise`"
  dimensions:
    - name: "Exercise Method"
      expr: exercise_method
      comment: "Method"
    - name: "Exercise Status"
      expr: exercise_status
      comment: "Status"
  measures:
    - name: "Exercises Completed"
      expr: COUNT(1)
      comment: "Number of valve exercises"
    - name: "Deficiency %"
      expr: ROUND(100.0 * SUM(CASE WHEN deficiency_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with deficiencies"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydrant_fire_flow_adequacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available fire flow at 20 psi and ISO adequacy from hydrant flow tests, a fire-protection and ISO-rating KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test`"
  dimensions:
    - name: "NFPA Color Class"
      expr: nfpa_color_classification
      comment: "NFPA 291 color"
    - name: "ISO Fire Flow Adequacy"
      expr: iso_fire_flow_adequacy
      comment: "ISO adequacy"
  measures:
    - name: "Avg Available Flow at 20psi GPM"
      expr: ROUND(AVG(CAST(available_flow_at_20psi_gpm AS DOUBLE)), 0)
      comment: "Average available fire flow"
    - name: "Tests Conducted"
      expr: COUNT(1)
      comment: "Number of flow tests"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flushing_program_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flushing events and effectiveness rating, maintaining water quality and chlorine residuals in the network."
  source: "`vibe_water_utilities_v1`.`distribution`.`flushing_event`"
  dimensions:
    - name: "Flush Reason"
      expr: flush_reason
      comment: "Reason for flush"
    - name: "Flush Status"
      expr: flush_status
      comment: "Status"
  measures:
    - name: "Flushing Events"
      expr: COUNT(1)
      comment: "Number of flushing events"
    - name: "Avg Flow Rate GPM"
      expr: ROUND(AVG(CAST(flow_rate_gpm AS DOUBLE)), 0)
      comment: "Average flush flow rate"
    - name: "Avg Effectiveness Rating"
      expr: ROUND(AVG(CAST(flush_effectiveness_rating AS DOUBLE)), 2)
      comment: "Average effectiveness rating"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pressure_zone_nrw_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average NRW percentage and demand by pressure zone, framing hydraulic and loss performance geographically."
  source: "`vibe_water_utilities_v1`.`distribution`.`pressure_zone`"
  dimensions:
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
    - name: "Operational Status"
      expr: operational_status
      comment: "Status"
  measures:
    - name: "Avg NRW %"
      expr: ROUND(AVG(CAST(nrw_percentage AS DOUBLE)), 2)
      comment: "Average non-revenue water percentage"
    - name: "Total Avg Daily Demand MGD"
      expr: ROUND(SUM(CAST(average_daily_demand_mgd AS DOUBLE)), 2)
      comment: "Total average daily demand"
    - name: "Total Customers"
      expr: SUM(CAST(customer_count AS DOUBLE))
      comment: "Total customers served"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_dma_leakage_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Minimum night flow thresholds and main length by DMA, a leakage monitoring and NRW KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`dma`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "DMA Status"
      expr: dma_status
      comment: "Status"
    - name: "Criticality"
      expr: criticality_rating
      comment: "Criticality"
  measures:
    - name: "Avg Min Night Flow GPM"
      expr: ROUND(AVG(CAST(minimum_night_flow_threshold_gpm AS DOUBLE)), 1)
      comment: "Average minimum night flow threshold"
    - name: "Total Main Miles"
      expr: ROUND(SUM(CAST(main_length_miles AS DOUBLE)), 1)
      comment: "Total main length"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flow_alarm_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of distribution flow readings in alarm and estimated readings, a SCADA data-quality and anomaly KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`flow_reading`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "Measurement Type"
      expr: measurement_type
      comment: "Measurement type"
    - name: "Flow Direction"
      expr: flow_direction
      comment: "Flow direction"
  measures:
    - name: "Alarm %"
      expr: ROUND(100.0 * SUM(CASE WHEN alarm_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of readings in alarm"
    - name: "Estimated Reading %"
      expr: ROUND(100.0 * SUM(CASE WHEN estimated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent estimated"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pipe_condition_grade_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition grades and break history across mains, informing capital renewal prioritization."
  source: "`vibe_water_utilities_v1`.`distribution`.`pipe_main`"
  dimensions:
    - name: "Condition Grade"
      expr: condition_grade
      comment: "Condition grade"
    - name: "Criticality Rating"
      expr: criticality_rating
      comment: "Criticality"
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
  measures:
    - name: "Total Break History"
      expr: SUM(CAST(break_history_count AS DOUBLE))
      comment: "Cumulative break count"
    - name: "Fire Flow Capable %"
      expr: ROUND(100.0 * SUM(CASE WHEN fire_flow_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent fire-flow capable"
    - name: "Mains"
      expr: COUNT(1)
      comment: "Number of mains"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_lead_service_line_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line counts by material and connection status, supporting Lead and Copper Rule Revisions inventory."
  source: "`vibe_water_utilities_v1`.`distribution`.`service_line`"
  dimensions:
    - name: "Connection Status"
      expr: connection_status
      comment: "Connection status"
    - name: "City"
      expr: city
      comment: "City"
  measures:
    - name: "Service Lines"
      expr: COUNT(1)
      comment: "Number of service lines"
    - name: "Avg Diameter Inches"
      expr: ROUND(AVG(CAST(diameter_inches AS DOUBLE)), 2)
      comment: "Average diameter"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydraulic_model_pressure_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Minimum and average modeled pressures and fire flow availability from hydraulic runs, a network performance KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run`"
  dimensions:
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
    - name: "Calibration Status"
      expr: calibration_status
      comment: "Model calibration status"
  measures:
    - name: "Avg Min Pressure psi"
      expr: ROUND(AVG(CAST(minimum_pressure_psi AS DOUBLE)), 1)
      comment: "Average minimum pressure"
    - name: "Avg Fire Flow Available GPM"
      expr: ROUND(AVG(CAST(fire_flow_available_gpm AS DOUBLE)), 0)
      comment: "Average fire flow available"
    - name: "Runs Converged %"
      expr: ROUND(100.0 * SUM(CASE WHEN convergence_achieved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of runs converged"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_network_isolation_event_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Isolation events and affected customers, quantifying planned/emergency service disruption."
  source: "`vibe_water_utilities_v1`.`distribution`.`network_isolation_event`"
  dimensions:
    - name: "DMA"
      expr: dma_id
      comment: "District metered area"
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
  measures:
    - name: "Isolation Events"
      expr: COUNT(1)
      comment: "Number of isolation events"
    - name: "Total Affected Customers"
      expr: SUM(CAST(affected_customer_count AS DOUBLE))
      comment: "Customers affected"
    - name: "Boil Water Advisory %"
      expr: ROUND(100.0 * SUM(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with boil-water advisory"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pump_station_reliability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design capacity and backup generator coverage across booster stations, a resilience and reliability KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`pump_station`"
  dimensions:
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
    - name: "Condition Rating"
      expr: asset_condition_rating
      comment: "Condition"
  measures:
    - name: "Total Design Capacity MGD"
      expr: ROUND(SUM(CAST(design_flow_capacity_mgd AS DOUBLE)), 2)
      comment: "Total pump capacity"
    - name: "Backup Generator Coverage %"
      expr: ROUND(100.0 * SUM(CASE WHEN backup_generator_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with backup generator"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_storage_tank_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total storage and emergency/fire reserve capacity, a supply resilience KPI for the distribution system."
  source: "`vibe_water_utilities_v1`.`distribution`.`storage_tank`"
  dimensions:
    - name: "Pressure Zone"
      expr: pressure_zone_id
      comment: "Pressure zone"
    - name: "Coating Condition"
      expr: coating_condition
      comment: "Coating condition"
  measures:
    - name: "Total Capacity MG"
      expr: ROUND(SUM(CAST(capacity_million_gallons AS DOUBLE)), 2)
      comment: "Total storage capacity"
    - name: "Total Fire Reserve Gallons"
      expr: ROUND(SUM(CAST(fire_flow_reserve_gallons AS DOUBLE)), 0)
      comment: "Fire flow reserve"
    - name: "Total Emergency Storage Gallons"
      expr: ROUND(SUM(CAST(emergency_storage_gallons AS DOUBLE)), 0)
      comment: "Emergency storage"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydrant_flow_test_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hydrant counts by flow class color and flushing program participation, a fire-protection asset KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydrant`"
  dimensions:
    - name: "Flow Class Color"
      expr: flow_class_color
      comment: "NFPA flow class color"
    - name: "Condition Status"
      expr: condition_status
      comment: "Condition"
    - name: "Fire District"
      expr: fire_district
      comment: "Fire district"
  measures:
    - name: "Hydrants"
      expr: COUNT(1)
      comment: "Number of hydrants"
    - name: "Avg Flow Capacity GPM"
      expr: ROUND(AVG(CAST(flow_capacity_gpm AS DOUBLE)), 0)
      comment: "Average flow capacity"
    - name: "In Flushing Program %"
      expr: ROUND(100.0 * SUM(CASE WHEN flushing_program_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent in flushing program"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_network_valve_operability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valve counts by condition and motorization, informing isolation readiness and exercising program scope."
  source: "`vibe_water_utilities_v1`.`distribution`.`network_valve`"
  dimensions:
    - name: "Condition Rating"
      expr: condition_rating
      comment: "Condition"
    - name: "Current Position"
      expr: current_position
      comment: "Current position"
    - name: "Criticality Rating"
      expr: criticality_rating
      comment: "Criticality"
  measures:
    - name: "Valves"
      expr: COUNT(1)
      comment: "Number of valves"
    - name: "Motorized %"
      expr: ROUND(100.0 * SUM(CASE WHEN is_motorized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent motorized"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_prv_station_calibration_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PRV station counts and calibration frequency by criticality, a pressure-management maintenance KPI."
  source: "`vibe_water_utilities_v1`.`distribution`.`prv_station`"
  dimensions:
    - name: "Asset Criticality"
      expr: asset_criticality
      comment: "Criticality"
    - name: "City"
      expr: city
      comment: "City"
  measures:
    - name: "PRV Stations"
      expr: COUNT(1)
      comment: "Number of PRV stations"
    - name: "Avg Calibration Frequency Months"
      expr: ROUND(AVG(CAST(calibration_frequency_months AS DOUBLE)), 1)
      comment: "Average calibration frequency"
    - name: "Avg Design Flow Capacity GPM"
      expr: ROUND(AVG(CAST(design_flow_capacity_gpm AS DOUBLE)), 0)
      comment: "Average design flow capacity"
$$;