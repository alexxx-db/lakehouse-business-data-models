-- Metric views for domain: distribution | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational flow telemetry metrics for the distribution network. Tracks volumetric throughput, pressure performance, data quality, and alarm rates across DMAs, meters, and pipe mains. Core KPI layer for hydraulic performance monitoring and NRW analysis."
  source: "`vibe_water_utilities_v1`.`distribution`.`flow_reading`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area identifier — primary grouping for zone-level flow analysis."
    - name: "flow_direction"
      expr: flow_direction
      comment: "Direction of flow (inlet/outlet/bypass) — used to separate supply-side from demand-side readings."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. bulk, zone, customer) — segments readings by purpose."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation state (validated/rejected/pending) — filters to trusted readings for KPI computation."
    - name: "engineering_unit"
      expr: engineering_unit
      comment: "Unit of measure for the flow value (e.g. GPM, MGD) — ensures correct unit-aware aggregation."
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Boolean flag indicating whether this reading triggered a SCADA alarm — used to isolate anomalous events."
    - name: "estimated_flag"
      expr: estimated_flag
      comment: "Boolean flag indicating the reading was estimated rather than directly measured — quality stratification."
    - name: "nrw_calculation_flag"
      expr: nrw_calculation_flag
      comment: "Boolean flag indicating this reading is included in Non-Revenue Water calculations — NRW scope filter."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean flag indicating a data quality issue with this reading — used to exclude suspect data from KPIs."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Calendar day of the flow reading — enables daily trend analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Calendar month of the flow reading — enables monthly aggregation for reporting periods."
    - name: "scada_tag_name"
      expr: scada_tag_name
      comment: "SCADA tag identifier for the sensor — enables sensor-level diagnostics and traceability."
  measures:
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total volumetric flow across all readings in the selected period and grouping. Primary throughput KPI for distribution network capacity and demand planning."
    - name: "avg_flow_rate"
      expr: AVG(CAST(flow_value AS DOUBLE))
      comment: "Average flow rate per reading interval. Benchmarks normal operating conditions and detects sustained demand shifts that require infrastructure response."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average operating pressure across readings. Tracks compliance with target pressure bands and identifies zones at risk of low-pressure service failures or high-pressure pipe stress."
    - name: "min_pressure_psi"
      expr: MIN(CAST(pressure_psi AS DOUBLE))
      comment: "Minimum recorded pressure in the period. Critical for identifying pressure deficiency events that breach regulatory minimums or fire-flow requirements."
    - name: "max_pressure_psi"
      expr: MAX(CAST(pressure_psi AS DOUBLE))
      comment: "Maximum recorded pressure in the period. Identifies transient overpressure events that accelerate pipe fatigue and increase main break risk."
    - name: "avg_meter_accuracy_pct"
      expr: AVG(CAST(meter_accuracy_percent AS DOUBLE))
      comment: "Average meter accuracy percentage across readings. Declining accuracy directly inflates apparent NRW and undermines billing integrity — a key asset management KPI."
    - name: "total_alarm_readings"
      expr: SUM(CASE WHEN alarm_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readings that triggered a SCADA alarm. Tracks network instability events requiring operational response."
    - name: "alarm_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alarm_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings that triggered alarms. A rising alarm rate signals systemic network stress or sensor degradation requiring capital or maintenance investment."
    - name: "estimated_reading_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN estimated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings that were estimated rather than directly measured. High estimation rates undermine NRW accuracy and billing confidence — a data quality governance KPI."
    - name: "validated_reading_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN validation_status = 'validated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings that have passed validation. Measures data pipeline health and readiness for regulatory and billing use."
    - name: "nrw_eligible_flow_volume"
      expr: SUM(CASE WHEN nrw_calculation_flag = TRUE THEN CAST(flow_value AS DOUBLE) ELSE 0 END)
      comment: "Total flow volume from readings flagged for NRW calculation. Feeds the water balance model to quantify real and apparent losses."
    - name: "total_totalizer_reading"
      expr: SUM(CAST(totalizer_reading AS DOUBLE))
      comment: "Sum of cumulative totalizer readings. Used for bulk water balance reconciliation between supply and consumption points."
    - name: "reading_count"
      expr: COUNT(1)
      comment: "Total number of flow readings in the period. Baseline volume metric for data completeness assessment and sensor uptime monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Main break incident metrics for the distribution network. Tracks break frequency, repair performance, water loss, customer impact, and infrastructure risk. Core KPI layer for asset reliability, capital planning, and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`distribution`.`main_break`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area where the break occurred — primary geographic grouping for break frequency analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone of the break — identifies hydraulic zones with elevated break rates for targeted pressure management."
    - name: "break_type"
      expr: break_type
      comment: "Classification of the break (e.g. circumferential, longitudinal, joint failure) — informs root cause and repair strategy."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the break incident (e.g. open, repaired, closed) — operational triage and backlog management."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the failed pipe — identifies high-risk material cohorts for pipe replacement prioritization."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the break (e.g. corrosion, pressure surge, third-party damage) — drives targeted mitigation programs."
    - name: "repair_method"
      expr: repair_method
      comment: "Method used to repair the break — informs cost benchmarking and repair effectiveness analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Operational priority assigned to the break — measures response alignment with criticality."
    - name: "boil_water_advisory_issued"
      expr: boil_water_advisory_issued
      comment: "Boolean flag indicating a boil water advisory was issued — tracks public health impact events for regulatory reporting."
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Boolean flag indicating regulatory reporting is required for this break — compliance scope filter."
    - name: "break_month"
      expr: DATE_TRUNC('month', break_timestamp)
      comment: "Calendar month of the break event — enables monthly trend and seasonality analysis."
    - name: "break_year"
      expr: DATE_TRUNC('year', break_timestamp)
      comment: "Calendar year of the break event — enables annual break rate benchmarking and capital planning."
    - name: "pipe_diameter_inches"
      expr: pipe_diameter_inches
      comment: "Diameter of the failed pipe in inches — segments break risk by pipe size for targeted renewal programs."
  measures:
    - name: "total_main_breaks"
      expr: COUNT(1)
      comment: "Total number of main break incidents. Primary infrastructure reliability KPI — rising break rates trigger capital renewal investment decisions."
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water lost due to main breaks in gallons. Directly quantifies real water loss contribution to NRW — a key financial and sustainability KPI."
    - name: "avg_water_lost_per_break_gallons"
      expr: AVG(CAST(water_lost_gallons AS DOUBLE))
      comment: "Average water lost per break event. Benchmarks break severity and informs response time targets to minimize loss per incident."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average time to repair a main break in hours. Measures operational response efficiency — prolonged repairs increase water loss, customer disruption, and regulatory exposure."
    - name: "max_repair_duration_hours"
      expr: MAX(CAST(repair_duration_hours AS DOUBLE))
      comment: "Maximum repair duration in hours. Identifies worst-case response performance and outlier incidents requiring process review."
    - name: "total_boil_water_advisories"
      expr: SUM(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaks that triggered a boil water advisory. Tracks public health impact events — a critical regulatory and reputational KPI."
    - name: "boil_water_advisory_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks resulting in a boil water advisory. Measures contamination risk exposure per break event — drives investment in pressure management and rapid response."
    - name: "avg_operating_pressure_at_break_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure at the break location. Correlates pressure levels with break frequency to justify pressure reduction programs."
    - name: "regulatory_reportable_break_count"
      expr: SUM(CASE WHEN regulatory_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaks requiring regulatory reporting. Tracks compliance obligation volume and ensures no reportable incidents are missed."
    - name: "avg_pipe_diameter_at_break_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average diameter of pipes that experienced breaks. Identifies whether large-main or small-main failures dominate — informs renewal program scope and cost."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_leak_detection_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leak detection survey performance and outcome metrics. Tracks survey coverage, leak discovery rates, estimated loss volumes, survey costs, and repair work order generation. Core KPI layer for active leakage control program management."
  source: "`vibe_water_utilities_v1`.`distribution`.`leak_detection_survey`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area surveyed — primary geographic grouping for leakage control coverage analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone of the survey — identifies zones with highest leakage density for prioritized intervention."
    - name: "survey_method"
      expr: survey_method
      comment: "Detection technology used (e.g. acoustic, correlator, ground-penetrating radar) — benchmarks method effectiveness and cost efficiency."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (e.g. scheduled, in-progress, completed) — tracks program execution against plan."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Outcome of the survey (e.g. leaks found, no leaks found) — measures detection yield by zone and method."
    - name: "survey_priority"
      expr: survey_priority
      comment: "Priority level assigned to the survey — validates that high-priority zones are surveyed first."
    - name: "repair_work_order_generated"
      expr: repair_work_order_generated
      comment: "Boolean flag indicating a repair work order was generated from this survey — measures conversion from detection to remediation."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean flag indicating data quality issues with the survey record — used to exclude suspect records from KPIs."
    - name: "survey_month"
      expr: DATE_TRUNC('month', survey_start_time)
      comment: "Calendar month the survey was conducted — enables monthly program throughput tracking."
    - name: "survey_year"
      expr: DATE_TRUNC('year', survey_start_time)
      comment: "Calendar year the survey was conducted — enables annual leakage control program review."
    - name: "technician_name"
      expr: technician_name
      comment: "Name of the technician who conducted the survey — enables productivity and quality benchmarking by operator."
  measures:
    - name: "total_surveys_completed"
      expr: SUM(CASE WHEN survey_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Total number of completed leak detection surveys. Measures active leakage control program throughput — a key regulatory and operational performance indicator."
    - name: "total_survey_length_feet"
      expr: SUM(CAST(survey_length_feet AS DOUBLE))
      comment: "Total pipe length surveyed in feet. Measures network coverage achieved by the leakage control program — tracks progress toward full network survey cycles."
    - name: "avg_survey_length_feet"
      expr: AVG(CAST(survey_length_feet AS DOUBLE))
      comment: "Average pipe length covered per survey. Benchmarks survey productivity and helps plan resource allocation for coverage targets."
    - name: "total_estimated_leak_rate_gpm"
      expr: SUM(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Total estimated leak rate in gallons per minute across all surveys. Quantifies the volume of real losses identified — directly informs NRW reduction targets and repair prioritization."
    - name: "avg_estimated_leak_rate_gpm"
      expr: AVG(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Average estimated leak rate per survey. Benchmarks leakage severity by zone and method — identifies areas where leakage density justifies accelerated pipe renewal."
    - name: "total_survey_cost"
      expr: SUM(CAST(survey_cost_currency AS DOUBLE))
      comment: "Total cost of leak detection surveys. Enables cost-per-unit-length and cost-per-leak-found efficiency analysis for program budget justification."
    - name: "avg_survey_cost"
      expr: AVG(CAST(survey_cost_currency AS DOUBLE))
      comment: "Average cost per survey. Benchmarks survey efficiency across methods and contractors — informs procurement and program design decisions."
    - name: "repair_work_order_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN repair_work_order_generated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys that resulted in a repair work order being generated. Measures the end-to-end effectiveness of the leakage control program from detection to remediation."
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total number of survey records. Baseline volume metric for program activity tracking and data completeness validation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_dma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District Metered Area (DMA) portfolio metrics. Tracks network configuration, leakage targets, infrastructure scale, and monitoring coverage across DMAs. Core KPI layer for zone-level NRW management and capital planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`dma`"
  dimensions:
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone the DMA belongs to — groups DMAs by hydraulic zone for pressure management analysis."
    - name: "dma_status"
      expr: dma_status
      comment: "Operational status of the DMA (e.g. active, decommissioned) — filters to active zones for operational KPIs."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the DMA — segments zones by strategic importance for prioritized investment."
    - name: "scada_monitored_flag"
      expr: scada_monitored_flag
      comment: "Boolean flag indicating SCADA monitoring is active for this DMA — measures real-time visibility coverage across the network."
    - name: "established_year"
      expr: DATE_TRUNC('year', established_date)
      comment: "Year the DMA was established — enables cohort analysis of DMA age and performance."
  measures:
    - name: "total_dmas"
      expr: COUNT(1)
      comment: "Total number of DMAs in the portfolio. Baseline metric for network segmentation coverage — more DMAs enable finer-grained leakage detection."
    - name: "scada_monitored_dma_count"
      expr: SUM(CASE WHEN scada_monitored_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of DMAs with active SCADA monitoring. Measures real-time visibility coverage — unmonitored DMAs are blind spots for NRW detection."
    - name: "scada_monitoring_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN scada_monitored_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMAs with SCADA monitoring. A strategic KPI for digital network visibility — low coverage limits early leak detection capability."
    - name: "total_main_length_miles"
      expr: SUM(CAST(main_length_miles AS DOUBLE))
      comment: "Total pipe main length across all DMAs in miles. Measures network scale and informs per-mile leakage and break rate benchmarking."
    - name: "avg_main_length_miles"
      expr: AVG(CAST(main_length_miles AS DOUBLE))
      comment: "Average pipe main length per DMA. Benchmarks DMA sizing — oversized DMAs reduce leakage detection sensitivity."
    - name: "avg_target_nrw_pct"
      expr: AVG(CAST(target_nrw_percentage AS DOUBLE))
      comment: "Average target Non-Revenue Water percentage across DMAs. Tracks the ambition level of the NRW reduction program — a primary financial sustainability KPI."
    - name: "avg_target_ufw_pct"
      expr: AVG(CAST(target_ufw_percentage AS DOUBLE))
      comment: "Average target Unaccounted-For Water percentage across DMAs. Measures the leakage reduction ambition embedded in operational plans."
    - name: "avg_design_flow_mgd"
      expr: AVG(CAST(design_flow_mgd AS DOUBLE))
      comment: "Average design flow capacity in million gallons per day across DMAs. Benchmarks hydraulic capacity planning against actual demand growth."
    - name: "avg_minimum_night_flow_threshold_gpm"
      expr: AVG(CAST(minimum_night_flow_threshold_gpm AS DOUBLE))
      comment: "Average minimum night flow threshold in GPM. Minimum night flow is the primary field indicator of background leakage — this threshold drives automated leak alert triggers."
    - name: "avg_average_pressure_psi"
      expr: AVG(CAST(average_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across DMAs in PSI. Pressure is the primary driver of leakage rate — this KPI informs pressure management investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pressure_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pressure zone hydraulic performance and capacity metrics. Tracks NRW/UFW performance, demand levels, pressure compliance, and storage adequacy across pressure zones. Core KPI layer for hydraulic planning and leakage management."
  source: "`vibe_water_utilities_v1`.`distribution`.`pressure_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of pressure zone (e.g. high, medium, low) — segments zones by hydraulic tier for pressure management analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the pressure zone (e.g. active, decommissioned) — filters to active zones for performance KPIs."
    - name: "zone_code"
      expr: zone_code
      comment: "Alphanumeric code identifying the pressure zone — used for cross-system reconciliation with hydraulic models and SCADA."
    - name: "zone_name"
      expr: zone_name
      comment: "Human-readable name of the pressure zone — primary label for executive dashboards and regulatory reports."
    - name: "commissioning_year"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the pressure zone was commissioned — enables age-cohort analysis of zone performance and infrastructure condition."
  measures:
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non-Revenue Water percentage across pressure zones. The primary financial sustainability KPI for water utilities — high NRW represents direct revenue loss and resource waste."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water percentage across pressure zones. Measures the real loss component of NRW — drives pipe renewal and active leakage control investment."
    - name: "avg_average_daily_demand_mgd"
      expr: AVG(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Average daily demand in million gallons per day. Baseline demand metric for capacity planning, source water procurement, and treatment sizing."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily demand across all pressure zones in MGD. System-wide demand baseline for supply planning and regulatory reporting."
    - name: "avg_peak_hour_demand_mgd"
      expr: AVG(CAST(peak_hour_demand_mgd AS DOUBLE))
      comment: "Average peak hour demand in MGD. Measures hydraulic stress at peak conditions — drives pump station sizing and storage capacity decisions."
    - name: "total_storage_capacity_mg"
      expr: SUM(CAST(storage_capacity_mg AS DOUBLE))
      comment: "Total storage capacity in million gallons across pressure zones. Measures system resilience and emergency supply buffer — a key regulatory and operational security KPI."
    - name: "avg_design_pressure_psi"
      expr: AVG(CAST(design_pressure_psi AS DOUBLE))
      comment: "Average design pressure in PSI across zones. Benchmarks actual operating pressure against design intent — deviations indicate hydraulic model recalibration needs."
    - name: "avg_residual_pressure_fire_psi"
      expr: AVG(CAST(residual_pressure_fire_psi AS DOUBLE))
      comment: "Average residual pressure available for fire flow in PSI. Measures fire protection adequacy — a regulatory compliance KPI with direct public safety implications."
    - name: "avg_service_area_sq_mi"
      expr: AVG(CAST(service_area_sq_mi AS DOUBLE))
      comment: "Average service area per pressure zone in square miles. Informs zone boundary optimization — oversized zones reduce hydraulic control granularity."
    - name: "total_service_area_sq_mi"
      expr: SUM(CAST(service_area_sq_mi AS DOUBLE))
      comment: "Total service area covered by all pressure zones in square miles. Measures geographic footprint of the distribution system for regulatory and planning reporting."
    - name: "pressure_zone_count"
      expr: COUNT(1)
      comment: "Total number of pressure zones. Baseline metric for network segmentation — more zones enable finer pressure management and leakage control."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pipe_main`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipe main asset portfolio metrics. Tracks network length, hydraulic capacity, condition, and material composition. Core KPI layer for capital renewal planning, risk prioritization, and infrastructure investment decisions."
  source: "`vibe_water_utilities_v1`.`distribution`.`pipe_main`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the pipe main belongs to — primary geographic grouping for network condition analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone of the pipe main — groups assets by hydraulic zone for pressure-correlated failure analysis."
    - name: "material"
      expr: material
      comment: "Pipe material (e.g. cast iron, ductile iron, PVC, HDPE) — primary driver of failure risk and renewal prioritization."
    - name: "pipe_type"
      expr: pipe_type
      comment: "Functional type of the pipe (e.g. transmission, distribution, service) — segments the network by hydraulic role."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Asset lifecycle stage (e.g. active, decommissioned, planned) — filters to in-service assets for operational KPIs."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition assessment grade of the pipe — primary input to renewal prioritization and risk scoring models."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the pipe main — segments assets by consequence of failure for risk-based investment planning."
    - name: "cathodic_protection_flag"
      expr: cathodic_protection_flag
      comment: "Boolean flag indicating cathodic protection is installed — measures corrosion mitigation coverage on metallic mains."
    - name: "installation_year"
      expr: installation_year
      comment: "Year the pipe was installed — enables age-cohort analysis and remaining useful life estimation."
    - name: "condition_assessment_year"
      expr: DATE_TRUNC('year', condition_assessment_date)
      comment: "Year of the most recent condition assessment — identifies pipes overdue for reassessment."
  measures:
    - name: "total_pipe_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total pipe main length in feet. Primary network scale metric — drives per-foot renewal cost estimates and regulatory asset reporting."
    - name: "avg_pipe_length_feet"
      expr: AVG(CAST(length_feet AS DOUBLE))
      comment: "Average pipe segment length in feet. Informs segmentation strategy and repair vs. replace decision thresholds."
    - name: "avg_nominal_diameter_inches"
      expr: AVG(CAST(nominal_diameter_inches AS DOUBLE))
      comment: "Average nominal pipe diameter in inches. Benchmarks network capacity profile — smaller average diameters indicate higher velocity and pressure loss risk."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across pipe mains in PSI. Pressure is the primary driver of pipe fatigue and leakage — this KPI informs pressure management investment."
    - name: "avg_hazen_williams_c_factor"
      expr: AVG(CAST(hazen_williams_c_factor AS DOUBLE))
      comment: "Average Hazen-Williams C-factor across pipe mains. Measures hydraulic roughness — declining C-factors indicate tuberculation and capacity loss requiring rehabilitation."
    - name: "avg_max_flow_capacity_gpm"
      expr: AVG(CAST(max_flow_capacity_gpm AS DOUBLE))
      comment: "Average maximum flow capacity in GPM. Benchmarks hydraulic capacity headroom — low capacity relative to demand signals network reinforcement needs."
    - name: "total_max_flow_capacity_gpm"
      expr: SUM(CAST(max_flow_capacity_gpm AS DOUBLE))
      comment: "Total maximum flow capacity across all pipe mains in GPM. System-wide hydraulic capacity metric for supply adequacy and fire flow planning."
    - name: "cathodic_protection_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cathodic_protection_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipe mains with cathodic protection installed. Measures corrosion mitigation coverage — low coverage on metallic mains increases break risk and renewal costs."
    - name: "avg_average_daily_flow_gpm"
      expr: AVG(CAST(average_daily_flow_gpm AS DOUBLE))
      comment: "Average daily flow through pipe mains in GPM. Measures utilization relative to capacity — high utilization pipes are priority candidates for upsizing or parallel mains."
    - name: "pipe_main_count"
      expr: COUNT(1)
      comment: "Total number of pipe main segments. Baseline asset inventory metric for network completeness and GIS data quality assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pump_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pump station asset and capacity metrics. Tracks pumping capacity, backup power coverage, SCADA integration, and operational status across the distribution network. Core KPI layer for supply security, energy management, and resilience planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`pump_station`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area served by the pump station — geographic grouping for supply security analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served by the pump station — links pumping capacity to hydraulic zone demand."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the pump station (e.g. active, standby, decommissioned) — filters to active assets for capacity KPIs."
    - name: "station_type"
      expr: station_type
      comment: "Type of pump station (e.g. booster, transfer, raw water) — segments by hydraulic function for targeted performance analysis."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the pump station — prioritizes resilience investment on highest-consequence assets."
    - name: "backup_generator_available"
      expr: backup_generator_available
      comment: "Boolean flag indicating backup generator availability — measures resilience against power outage events."
    - name: "scada_integrated"
      expr: scada_integrated
      comment: "Boolean flag indicating SCADA integration — measures real-time monitoring coverage of pumping assets."
    - name: "vfd_equipped"
      expr: vfd_equipped
      comment: "Boolean flag indicating variable frequency drive (VFD) equipment — VFDs enable energy-efficient pressure management."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the pump station (e.g. utility-owned, private) — segments assets by maintenance responsibility."
  measures:
    - name: "total_design_flow_capacity_mgd"
      expr: SUM(CAST(design_flow_capacity_mgd AS DOUBLE))
      comment: "Total design pumping capacity in million gallons per day. Primary supply security KPI — measures whether installed pumping capacity meets current and projected demand."
    - name: "avg_design_flow_capacity_mgd"
      expr: AVG(CAST(design_flow_capacity_mgd AS DOUBLE))
      comment: "Average design flow capacity per pump station in MGD. Benchmarks station sizing — undersized stations are bottlenecks for peak demand and fire flow response."
    - name: "total_design_flow_capacity_gpm"
      expr: SUM(CAST(design_flow_capacity_gpm AS DOUBLE))
      comment: "Total design pumping capacity in gallons per minute. Operational-level capacity metric used for hydraulic model calibration and fire flow adequacy assessment."
    - name: "backup_generator_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN backup_generator_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pump stations with backup generator availability. Measures resilience against power outages — a critical regulatory and emergency preparedness KPI."
    - name: "scada_integration_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN scada_integrated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pump stations with SCADA integration. Measures real-time operational visibility — unmonitored stations are blind spots for supply disruption detection."
    - name: "vfd_equipped_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vfd_equipped = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pump stations equipped with variable frequency drives. VFDs reduce energy consumption and enable pressure optimization — a key energy efficiency and cost KPI."
    - name: "avg_discharge_pressure_psi"
      expr: AVG(CAST(discharge_pressure_psi AS DOUBLE))
      comment: "Average discharge pressure across pump stations in PSI. Measures whether stations are delivering target pressures — deviations indicate pump wear or hydraulic imbalance."
    - name: "avg_total_dynamic_head_ft"
      expr: AVG(CAST(total_dynamic_head_ft AS DOUBLE))
      comment: "Average total dynamic head in feet. Measures pumping energy requirement — high TDH drives energy costs and informs pump selection for replacements."
    - name: "avg_backup_generator_capacity_kw"
      expr: AVG(CAST(backup_generator_capacity_kw AS DOUBLE))
      comment: "Average backup generator capacity in kilowatts. Validates that backup power is adequately sized to sustain critical pumping operations during outages."
    - name: "pump_station_count"
      expr: COUNT(1)
      comment: "Total number of pump stations. Baseline asset inventory metric for network infrastructure reporting and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_storage_tank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tank asset and capacity metrics. Tracks total and usable storage capacity, emergency and fire flow reserves, operational status, and inspection compliance. Core KPI layer for supply security, regulatory compliance, and asset management."
  source: "`vibe_water_utilities_v1`.`distribution`.`storage_tank`"
  dimensions:
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served by the storage tank — links storage capacity to zone-level demand and supply security."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the tank (e.g. active, offline, decommissioned) — filters to in-service assets for capacity KPIs."
    - name: "tank_type"
      expr: tank_type
      comment: "Type of storage tank (e.g. elevated, ground-level, standpipe) — segments by hydraulic function and pressure contribution."
    - name: "tank_material"
      expr: tank_material
      comment: "Construction material of the tank (e.g. steel, concrete, fiberglass) — informs inspection frequency and rehabilitation cost estimates."
    - name: "asset_criticality_rating"
      expr: asset_criticality_rating
      comment: "Criticality rating of the storage tank — prioritizes inspection and maintenance investment on highest-consequence assets."
    - name: "structural_condition"
      expr: structural_condition
      comment: "Structural condition assessment of the tank — primary input to rehabilitation and replacement planning."
    - name: "regulatory_inspection_status"
      expr: regulatory_inspection_status
      comment: "Status of regulatory inspection compliance — tracks whether tanks meet mandatory inspection cycle requirements."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the tank — segments assets by maintenance responsibility and capital accountability."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the tank was installed — enables age-cohort analysis and remaining useful life estimation."
  measures:
    - name: "total_capacity_million_gallons"
      expr: SUM(CAST(capacity_million_gallons AS DOUBLE))
      comment: "Total storage capacity in million gallons across all tanks. Primary supply security KPI — measures system-wide buffer against supply interruptions and peak demand events."
    - name: "total_usable_capacity_gallons"
      expr: SUM(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Total usable storage capacity in gallons. Excludes dead storage — the operationally available buffer for demand management and emergency response."
    - name: "total_emergency_storage_gallons"
      expr: SUM(CAST(emergency_storage_gallons AS DOUBLE))
      comment: "Total emergency storage reserve in gallons. Measures the system's ability to sustain supply during source water or treatment outages — a critical regulatory compliance KPI."
    - name: "total_fire_flow_reserve_gallons"
      expr: SUM(CAST(fire_flow_reserve_gallons AS DOUBLE))
      comment: "Total fire flow reserve storage in gallons. Measures compliance with fire protection storage requirements — a regulatory and public safety KPI."
    - name: "avg_capacity_million_gallons"
      expr: AVG(CAST(capacity_million_gallons AS DOUBLE))
      comment: "Average storage capacity per tank in million gallons. Benchmarks tank sizing relative to zone demand — undersized tanks reduce supply resilience."
    - name: "usable_to_total_capacity_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(usable_capacity_gallons AS DOUBLE)) / NULLIF(SUM(CAST(capacity_gallons AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that is usable (excludes dead storage). Measures storage efficiency — low ratios indicate tanks with excessive dead storage requiring rehabilitation."
    - name: "avg_maximum_operating_level_feet"
      expr: AVG(CAST(maximum_operating_level_feet AS DOUBLE))
      comment: "Average maximum operating level in feet. Benchmarks hydraulic head contribution of storage assets — informs pressure zone design and booster pump requirements."
    - name: "tank_count"
      expr: COUNT(1)
      comment: "Total number of storage tanks. Baseline asset inventory metric for infrastructure reporting and storage redundancy assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line asset portfolio metrics. Tracks material composition, LCRR compliance, connection status, and physical characteristics. Core KPI layer for lead service line replacement programs, regulatory compliance, and customer connection management."
  source: "`vibe_water_utilities_v1`.`distribution`.`service_line`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the service line belongs to — geographic grouping for compliance and condition analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone of the service line — links asset condition to hydraulic zone for integrated network analysis."
    - name: "material_type"
      expr: material_type
      comment: "Material of the service line (e.g. lead, galvanized, copper, plastic) — primary driver of LCRR compliance status and public health risk."
    - name: "connection_status"
      expr: connection_status
      comment: "Connection status of the service line (e.g. active, inactive, abandoned) — filters to active connections for demand and compliance KPIs."
    - name: "lcrr_classification"
      expr: lcrr_classification
      comment: "Lead and Copper Rule Revision (LCRR) classification of the service line — regulatory compliance grouping for lead service line inventory reporting."
    - name: "lcrr_inventory_verified"
      expr: lcrr_inventory_verified
      comment: "Boolean flag indicating LCRR inventory verification is complete — tracks regulatory compliance with mandatory inventory submission requirements."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the service line (e.g. utility, customer) — determines maintenance responsibility and replacement program eligibility."
    - name: "service_type"
      expr: service_type
      comment: "Type of service connection (e.g. residential, commercial, industrial) — segments the customer base for demand and compliance analysis."
    - name: "installation_year"
      expr: installation_year
      comment: "Year the service line was installed — enables age-cohort analysis for replacement prioritization."
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of service lines. Baseline asset inventory metric — the denominator for all LCRR compliance rate calculations."
    - name: "lcrr_verified_count"
      expr: SUM(CASE WHEN lcrr_inventory_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service lines with verified LCRR inventory status. Tracks progress toward mandatory regulatory inventory completion — a critical compliance KPI."
    - name: "lcrr_verification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lcrr_inventory_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service lines with verified LCRR inventory status. Primary regulatory compliance KPI for the Lead and Copper Rule Revision — utilities face enforcement action for low verification rates."
    - name: "total_service_line_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of service lines in feet. Measures the scale of the customer connection network — informs replacement program cost estimation."
    - name: "avg_service_line_length_feet"
      expr: AVG(CAST(length_feet AS DOUBLE))
      comment: "Average service line length in feet. Benchmarks connection depth — longer service lines have higher replacement costs and greater lead exposure risk."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average service line diameter in inches. Measures capacity profile of the customer connection network — undersized connections limit fire flow and peak demand delivery."
    - name: "curb_stop_installed_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN curb_stop_installed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service lines with a curb stop installed. Curb stops enable rapid isolation of individual connections — low coverage increases response time for leaks and contamination events."
    - name: "avg_tap_size_inches"
      expr: AVG(CAST(tap_size_inches AS DOUBLE))
      comment: "Average tap size in inches. Measures the hydraulic connection capacity at the main — undersized taps constrain customer flow and fire flow delivery."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fire hydrant asset portfolio and inspection compliance metrics. Tracks hydrant inventory, pressure performance, inspection currency, and flushing program coverage. Core KPI layer for fire protection adequacy, regulatory compliance, and asset management."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydrant`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the hydrant belongs to — geographic grouping for fire protection coverage analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone of the hydrant — links fire flow performance to hydraulic zone conditions."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the hydrant (e.g. active, out-of-service, decommissioned) — filters to serviceable hydrants for fire protection KPIs."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition of the hydrant — primary input to maintenance prioritization and replacement planning."
    - name: "hydrant_type"
      expr: hydrant_type
      comment: "Type of hydrant (e.g. dry barrel, wet barrel) — segments by design type for maintenance and performance benchmarking."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the hydrant — prioritizes inspection and maintenance on highest-consequence fire protection assets."
    - name: "flushing_program_flag"
      expr: flushing_program_flag
      comment: "Boolean flag indicating the hydrant is enrolled in a flushing program — measures water quality maintenance coverage."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the hydrant (e.g. utility, private, municipal) — determines maintenance responsibility and inspection accountability."
    - name: "flow_class_color"
      expr: flow_class_color
      comment: "NFPA flow class color code (e.g. blue, green, orange, red) — indicates fire flow capacity class for fire department planning."
  measures:
    - name: "total_hydrants"
      expr: COUNT(1)
      comment: "Total number of hydrants in the inventory. Baseline fire protection asset metric — the denominator for all inspection and compliance rate calculations."
    - name: "avg_static_pressure_psi"
      expr: AVG(CAST(static_pressure_psi AS DOUBLE))
      comment: "Average static pressure at hydrants in PSI. Measures baseline hydraulic head available for fire flow — low static pressure zones require pressure management or network reinforcement."
    - name: "avg_residual_pressure_psi"
      expr: AVG(CAST(residual_pressure_psi AS DOUBLE))
      comment: "Average residual pressure during flow test in PSI. Measures actual fire flow delivery performance — residual pressure below 20 PSI indicates inadequate fire protection capacity."
    - name: "avg_main_diameter_inches"
      expr: AVG(CAST(main_diameter_inches AS DOUBLE))
      comment: "Average diameter of the main supplying each hydrant in inches. Measures hydraulic capacity of the fire protection supply network — undersized mains limit fire flow delivery."
    - name: "flushing_program_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN flushing_program_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hydrants enrolled in a flushing program. Measures water quality maintenance coverage — unflushed hydrants accumulate sediment and degrade water quality."
    - name: "avg_valve_turns_to_open"
      expr: AVG(CAST(valve_turns_to_open AS DOUBLE))
      comment: "Average number of turns required to open a hydrant. Excessive turns indicate valve wear or corrosion — a maintenance condition indicator for field crews."
    - name: "avg_bury_depth_feet"
      expr: AVG(CAST(bury_depth_feet AS DOUBLE))
      comment: "Average hydrant bury depth in feet. Validates installation compliance with depth standards — shallow installations risk freeze damage in cold climates."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_network_valve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network valve asset portfolio and exercising compliance metrics. Tracks valve inventory, operational status, condition, and exercising program currency. Core KPI layer for network isolation capability, emergency response readiness, and asset management."
  source: "`vibe_water_utilities_v1`.`distribution`.`network_valve`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the valve belongs to — geographic grouping for isolation capability analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone of the valve — links isolation assets to hydraulic zone boundaries."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the valve (e.g. open, closed, inoperable) — identifies valves that cannot perform their isolation function."
    - name: "valve_type"
      expr: valve_type
      comment: "Type of valve (e.g. gate, butterfly, ball, PRV) — segments by design type for maintenance and performance benchmarking."
    - name: "valve_function"
      expr: valve_function
      comment: "Functional role of the valve (e.g. isolation, pressure reducing, check) — segments by operational purpose for targeted maintenance programs."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Condition assessment rating of the valve — primary input to replacement prioritization and risk scoring."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the valve — prioritizes exercising and maintenance on highest-consequence isolation assets."
    - name: "is_motorized"
      expr: is_motorized
      comment: "Boolean flag indicating the valve is motorized — motorized valves enable remote operation for faster emergency isolation."
    - name: "material"
      expr: material
      comment: "Material of the valve body — informs corrosion risk and expected service life for replacement planning."
  measures:
    - name: "total_network_valves"
      expr: COUNT(1)
      comment: "Total number of network valves. Baseline isolation asset inventory metric — the denominator for all exercising compliance and condition rate calculations."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average valve diameter in inches. Measures the hydraulic scale of isolation assets — larger valves have higher replacement costs and greater consequence of failure."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across network valves in PSI. Validates that valves are operating within their pressure rating — exceedances accelerate wear and increase failure risk."
    - name: "avg_pressure_rating_psi"
      expr: AVG(CAST(pressure_rating_psi AS DOUBLE))
      comment: "Average pressure rating of network valves in PSI. Benchmarks the pressure capacity of the isolation asset fleet — low ratings relative to operating pressure indicate replacement needs."
    - name: "motorized_valve_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_motorized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of network valves that are motorized. Measures remote operation capability — higher motorization enables faster emergency isolation and reduces crew deployment costs."
    - name: "avg_burial_depth_feet"
      expr: AVG(CAST(burial_depth_feet AS DOUBLE))
      comment: "Average valve burial depth in feet. Validates installation compliance with depth standards and informs excavation cost estimates for maintenance access."
$$;