-- Metric views for domain: distribution | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational flow telemetry metrics for the distribution network. Tracks volumetric throughput, pressure performance, and data quality across all measurement points, DMAs, and pipe mains. Used by operations and engineering to monitor network hydraulics, detect anomalies, and support NRW analysis."
  source: "`vibe_water_utilities_v1`.`distribution`.`flow_reading`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area identifier — enables flow analysis segmented by DMA for leakage and NRW management."
    - name: "pipe_main_id"
      expr: pipe_main_id
      comment: "Pipe main identifier — supports flow analysis at the individual main level for hydraulic modelling."
    - name: "pump_station_id"
      expr: pump_station_id
      comment: "Pump station identifier — enables flow analysis by pumping asset to assess station throughput."
    - name: "storage_tank_id"
      expr: storage_tank_id
      comment: "Storage tank identifier — supports flow analysis for tank fill/draw cycles."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. inlet, outlet, bulk) — critical for distinguishing input vs. output flows in water balance calculations."
    - name: "flow_direction"
      expr: flow_direction
      comment: "Direction of flow (forward/reverse) — used to identify backflow events and validate hydraulic model assumptions."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation status of the reading — enables filtering to validated-only data for regulatory and billing purposes."
    - name: "engineering_unit"
      expr: engineering_unit
      comment: "Unit of measurement for the flow value (e.g. GPM, MGD) — ensures correct interpretation of flow figures."
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Indicates whether the reading triggered an alarm — used to filter and count alarm events."
    - name: "nrw_calculation_flag"
      expr: nrw_calculation_flag
      comment: "Indicates whether this reading is included in NRW (Non-Revenue Water) calculations — essential for water loss accounting."
    - name: "billing_flag"
      expr: billing_flag
      comment: "Indicates whether this reading is used for billing — supports revenue assurance analysis."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Indicates a data quality issue with the reading — used to quantify and monitor data integrity."
    - name: "estimated_flag"
      expr: estimated_flag
      comment: "Indicates whether the flow value was estimated rather than directly measured — important for data confidence assessment."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Calendar day of the flow reading — primary time dimension for daily operational trend analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Calendar month of the flow reading — supports monthly water balance and NRW reporting."
  measures:
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total volumetric flow across all readings in the selected period and grouping. Core measure for water balance, NRW calculation, and throughput reporting."
    - name: "avg_flow_rate"
      expr: AVG(CAST(flow_value AS DOUBLE))
      comment: "Average flow rate per reading interval. Used to assess typical demand levels and identify deviations from expected hydraulic behaviour."
    - name: "max_flow_rate"
      expr: MAX(CAST(flow_value AS DOUBLE))
      comment: "Peak flow rate observed in the period. Critical for capacity planning, surge detection, and hydraulic model calibration."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average network pressure at measurement points. Key indicator of pressure zone compliance and service quality; low pressure triggers regulatory and operational response."
    - name: "min_pressure_psi"
      expr: MIN(CAST(pressure_psi AS DOUBLE))
      comment: "Minimum recorded pressure across readings. Used to identify pressure deficiency events that may breach regulatory minimums or indicate main breaks."
    - name: "avg_meter_accuracy_pct"
      expr: AVG(CAST(meter_accuracy_percent AS DOUBLE))
      comment: "Average meter accuracy percentage across readings. Declining accuracy indicates meter degradation, directly impacting billing accuracy and NRW calculations."
    - name: "total_nrw_flow_volume"
      expr: SUM(CASE WHEN nrw_calculation_flag = TRUE THEN CAST(flow_value AS DOUBLE) ELSE 0 END)
      comment: "Total flow volume flagged for inclusion in NRW calculations. Directly feeds the water loss accounting process and regulatory NRW reporting."
    - name: "alarm_reading_count"
      expr: COUNT(CASE WHEN alarm_flag = TRUE THEN flow_reading_id END)
      comment: "Number of readings that triggered an alarm. High alarm counts indicate network instability, equipment faults, or pressure events requiring operational intervention."
    - name: "poor_quality_reading_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN flow_reading_id END)
      comment: "Number of readings flagged for data quality issues. Elevated counts undermine confidence in water balance and billing data, triggering data governance action."
    - name: "estimated_reading_count"
      expr: COUNT(CASE WHEN estimated_flag = TRUE THEN flow_reading_id END)
      comment: "Number of readings that were estimated rather than directly measured. High estimation rates reduce NRW calculation accuracy and may indicate meter or SCADA failures."
    - name: "total_reading_count"
      expr: COUNT(flow_reading_id)
      comment: "Total number of flow readings recorded. Baseline volume measure used to compute rates and assess data completeness across measurement points."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Main break incident metrics for the distribution network. Tracks break frequency, water loss, repair performance, and customer impact. Used by asset management, operations, and executives to steer pipe rehabilitation investment, manage regulatory risk, and minimise service disruption."
  source: "`vibe_water_utilities_v1`.`distribution`.`main_break`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area — enables break frequency and water loss analysis by DMA for targeted rehabilitation planning."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone — supports analysis of break rates by pressure regime to identify over-pressurised zones driving asset failure."
    - name: "pipe_main_id"
      expr: pipe_main_id
      comment: "Pipe main identifier — enables break history aggregation at the individual main level for asset condition scoring."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory — supports geographic breakdown of break incidents for resource deployment and customer impact reporting."
    - name: "break_type"
      expr: break_type
      comment: "Classification of the break (e.g. circumferential, longitudinal, joint failure) — informs root cause analysis and material-specific rehabilitation strategies."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the failed pipe — critical dimension for identifying high-risk material cohorts driving rehabilitation prioritisation."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the break (e.g. reported, in-repair, closed) — used to track open incidents and repair backlog."
    - name: "priority_level"
      expr: priority_level
      comment: "Operational priority assigned to the break — enables analysis of response performance by priority tier."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the break — supports failure mode analysis to drive preventive maintenance and capital investment decisions."
    - name: "repair_method"
      expr: repair_method
      comment: "Method used to repair the break — informs cost benchmarking and repair strategy effectiveness analysis."
    - name: "boil_water_advisory_issued"
      expr: boil_water_advisory_issued
      comment: "Whether a boil water advisory was issued — key public health and regulatory risk indicator associated with each break event."
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Whether a regulatory report was required — tracks compliance obligations triggered by break events."
    - name: "break_month"
      expr: DATE_TRUNC('month', break_timestamp)
      comment: "Calendar month of the break event — primary time dimension for trend analysis and seasonal pattern identification."
    - name: "break_year"
      expr: DATE_TRUNC('year', break_timestamp)
      comment: "Calendar year of the break event — supports annual break rate benchmarking and long-term asset deterioration trend analysis."
  measures:
    - name: "total_main_breaks"
      expr: COUNT(main_break_id)
      comment: "Total number of main break incidents. Primary KPI for network reliability; rising break rates trigger capital rehabilitation programmes and regulatory scrutiny."
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water lost due to main breaks in gallons. Directly quantifies physical water loss contributing to NRW; high values drive water loss reduction investment."
    - name: "avg_water_lost_per_break_gallons"
      expr: AVG(CAST(water_lost_gallons AS DOUBLE))
      comment: "Average water lost per break event. Indicates severity of individual break events; used to benchmark repair response speed and prioritise rapid response protocols."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average time to repair a main break in hours. Key operational efficiency KPI; long repair durations increase water loss, customer disruption, and regulatory exposure."
    - name: "max_repair_duration_hours"
      expr: MAX(CAST(repair_duration_hours AS DOUBLE))
      comment: "Maximum repair duration observed. Identifies worst-case repair performance events for root cause investigation and process improvement."
    - name: "total_repair_duration_hours"
      expr: SUM(CAST(repair_duration_hours AS DOUBLE))
      comment: "Total crew hours spent on main break repairs. Feeds labour cost estimation and resource capacity planning for the maintenance organisation."
    - name: "boil_water_advisory_count"
      expr: COUNT(CASE WHEN boil_water_advisory_issued = TRUE THEN main_break_id END)
      comment: "Number of breaks that resulted in a boil water advisory. Critical public health and regulatory KPI; each advisory represents a compliance event and reputational risk."
    - name: "regulatory_reportable_break_count"
      expr: COUNT(CASE WHEN regulatory_report_required = TRUE THEN main_break_id END)
      comment: "Number of breaks requiring regulatory reporting. Tracks compliance obligation volume; high counts signal systemic infrastructure risk to regulators."
    - name: "avg_operating_pressure_at_break_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure at the time and location of breaks. Used to correlate pressure levels with break frequency, informing pressure management strategy."
    - name: "avg_pipe_diameter_at_break_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average diameter of pipes experiencing breaks. Informs whether large or small diameter mains are disproportionately failing, guiding targeted rehabilitation investment."
    - name: "distinct_dmas_with_breaks"
      expr: COUNT(DISTINCT dma_id)
      comment: "Number of distinct DMAs experiencing at least one main break. Measures geographic spread of network deterioration; broad spread indicates systemic rather than localised asset risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_leak_detection_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leak detection survey programme metrics. Tracks survey coverage, leak discovery rates, estimated leak volumes, and programme cost-effectiveness. Used by water loss managers and executives to steer the active leakage control programme and demonstrate regulatory compliance."
  source: "`vibe_water_utilities_v1`.`distribution`.`leak_detection_survey`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area surveyed — enables analysis of survey coverage and leak discovery rates by DMA."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone — supports analysis of leak prevalence by pressure regime."
    - name: "pipe_main_id"
      expr: pipe_main_id
      comment: "Pipe main surveyed — enables leak detection results to be attributed to specific mains for asset condition assessment."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory — supports geographic breakdown of survey activity and outcomes."
    - name: "survey_method"
      expr: survey_method
      comment: "Detection method used (e.g. acoustic, correlator, ground-penetrating radar) — enables comparison of method effectiveness and cost-efficiency."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (e.g. scheduled, in-progress, completed) — tracks programme execution against plan."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Outcome of the survey (e.g. leak found, no leak found) — primary result dimension for programme effectiveness analysis."
    - name: "survey_priority"
      expr: survey_priority
      comment: "Priority assigned to the survey — enables analysis of whether high-priority areas are being surveyed first."
    - name: "repair_work_order_generated"
      expr: repair_work_order_generated
      comment: "Whether a repair work order was generated following the survey — measures conversion of leak detection to repair action."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Indicates data quality issues with the survey record — used to filter reliable data for programme reporting."
    - name: "survey_month"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Calendar month of the survey — primary time dimension for tracking survey programme cadence and seasonal patterns."
    - name: "survey_year"
      expr: DATE_TRUNC('year', survey_date)
      comment: "Calendar year of the survey — supports annual programme coverage and effectiveness reporting."
  measures:
    - name: "total_surveys_completed"
      expr: COUNT(CASE WHEN survey_status = 'completed' THEN leak_detection_survey_id END)
      comment: "Total number of completed leak detection surveys. Baseline measure of programme execution; used to track coverage against the annual survey plan."
    - name: "total_survey_length_feet"
      expr: SUM(CAST(survey_length_feet AS DOUBLE))
      comment: "Total pipe length surveyed in feet. Measures physical network coverage of the active leakage control programme; key input to regulatory coverage reporting."
    - name: "avg_survey_length_feet"
      expr: AVG(CAST(survey_length_feet AS DOUBLE))
      comment: "Average length of pipe covered per survey. Used to assess survey productivity and plan resource requirements for future survey cycles."
    - name: "total_estimated_leak_rate_gpm"
      expr: SUM(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Total estimated leak rate discovered across all surveys in gallons per minute. Directly quantifies recoverable water loss; drives prioritisation of repair work orders and NRW reduction targets."
    - name: "avg_estimated_leak_rate_gpm"
      expr: AVG(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Average estimated leak rate per survey. Indicates typical leak severity; used to benchmark survey method effectiveness and prioritise high-loss areas."
    - name: "surveys_with_leaks_found"
      expr: COUNT(CASE WHEN repair_work_order_generated = TRUE THEN leak_detection_survey_id END)
      comment: "Number of surveys that resulted in a repair work order being generated. Measures the productive yield of the survey programme; low conversion rates may indicate survey method or targeting inefficiency."
    - name: "distinct_dmas_surveyed"
      expr: COUNT(DISTINCT dma_id)
      comment: "Number of distinct DMAs covered by surveys. Measures geographic breadth of the active leakage control programme; gaps indicate under-surveyed high-risk areas."
    - name: "total_surveys"
      expr: COUNT(leak_detection_survey_id)
      comment: "Total number of survey records including all statuses. Used as the denominator for completion rate and leak discovery rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pressure_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pressure zone performance and water loss metrics. Tracks NRW/UFW percentages, demand levels, pressure compliance, and storage adequacy across all pressure zones. Used by operations, engineering, and executives to manage network efficiency, regulatory compliance, and capital investment planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`pressure_zone`"
  dimensions:
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Unique pressure zone identifier — primary grouping key for all zone-level performance analysis."
    - name: "zone_code"
      expr: zone_code
      comment: "Short alphanumeric code for the pressure zone — used in operational dashboards and regulatory submissions."
    - name: "zone_name"
      expr: zone_name
      comment: "Descriptive name of the pressure zone — business-friendly label for reporting and stakeholder communication."
    - name: "zone_type"
      expr: zone_type
      comment: "Classification of the zone (e.g. high, medium, low pressure) — enables analysis segmented by hydraulic tier."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the zone (e.g. active, decommissioned) — used to filter active zones for operational reporting."
    - name: "commissioning_year"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the pressure zone was commissioned — supports age-based analysis of zone infrastructure and rehabilitation planning."
  measures:
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non-Revenue Water percentage across pressure zones. Premier water loss KPI; high NRW signals physical losses (leakage) or commercial losses (unbilled consumption) requiring executive intervention."
    - name: "max_nrw_percentage"
      expr: MAX(CAST(nrw_percentage AS DOUBLE))
      comment: "Highest NRW percentage recorded across zones. Identifies the worst-performing zone for targeted water loss reduction investment."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water percentage across zones. Complementary water loss metric to NRW; used in regulatory reporting and efficiency benchmarking."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily demand across all zones in million gallons per day. Baseline demand measure for supply planning, treatment capacity sizing, and regulatory licence compliance."
    - name: "total_peak_hour_demand_mgd"
      expr: SUM(CAST(peak_hour_demand_mgd AS DOUBLE))
      comment: "Total peak hour demand across zones in MGD. Critical for infrastructure sizing and emergency response planning; peak demand drives pump station and storage capacity requirements."
    - name: "total_storage_capacity_mg"
      expr: SUM(CAST(storage_capacity_mg AS DOUBLE))
      comment: "Total storage capacity across all zones in million gallons. Measures system resilience and emergency supply buffer; low storage-to-demand ratios indicate vulnerability to supply interruptions."
    - name: "avg_design_pressure_psi"
      expr: AVG(CAST(design_pressure_psi AS DOUBLE))
      comment: "Average design pressure across zones in PSI. Used to assess whether zones are operating within design parameters; deviations indicate pressure management issues."
    - name: "avg_residual_pressure_fire_psi"
      expr: AVG(CAST(residual_pressure_fire_psi AS DOUBLE))
      comment: "Average residual pressure available for fire flow across zones. Regulatory and public safety KPI; zones below minimum fire flow pressure require urgent infrastructure investment."
    - name: "total_service_area_sq_mi"
      expr: SUM(CAST(service_area_sq_mi AS DOUBLE))
      comment: "Total geographic service area covered by pressure zones in square miles. Used to normalise break rates, leak rates, and demand figures for density-adjusted benchmarking."
    - name: "zones_above_target_max_pressure"
      expr: COUNT(CASE WHEN CAST(design_pressure_psi AS DOUBLE) > CAST(target_pressure_max_psi AS DOUBLE) THEN pressure_zone_id END)
      comment: "Number of zones where design pressure exceeds the target maximum. Over-pressurised zones experience higher break rates and leakage; this count drives pressure management and PRV installation decisions."
    - name: "active_zone_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN pressure_zone_id END)
      comment: "Number of currently active pressure zones. Baseline count for normalising per-zone KPIs and tracking network expansion or rationalisation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pipe_main`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipe main asset inventory and condition metrics. Tracks network length, material composition, hydraulic capacity, and age profile across the distribution mains. Used by asset management and capital planning teams to prioritise rehabilitation, manage risk, and optimise network performance."
  source: "`vibe_water_utilities_v1`.`distribution`.`pipe_main`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area — enables pipe inventory and condition analysis by DMA for targeted rehabilitation planning."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone — supports analysis of pipe asset profile by hydraulic zone."
    - name: "material"
      expr: material
      comment: "Pipe material (e.g. cast iron, ductile iron, PVC, HDPE) — primary dimension for material-based risk segmentation and rehabilitation prioritisation."
    - name: "pipe_type"
      expr: pipe_type
      comment: "Classification of the pipe (e.g. transmission, distribution, service) — enables analysis by functional role in the network."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the pipe (e.g. active, decommissioned, planned) — used to filter active network assets for operational analysis."
    - name: "lining_type"
      expr: lining_type
      comment: "Internal lining type — relevant to water quality risk and hydraulic performance assessment."
    - name: "cathodic_protection_flag"
      expr: cathodic_protection_flag
      comment: "Whether cathodic protection is installed — used to assess corrosion risk mitigation coverage across the metallic pipe inventory."
    - name: "fire_flow_capable_flag"
      expr: fire_flow_capable_flag
      comment: "Whether the main is capable of delivering fire flow — critical for fire risk management and regulatory compliance reporting."
    - name: "installation_year"
      expr: installation_year
      comment: "Year of installation — primary dimension for age-cohort analysis and end-of-life asset identification."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Party responsible for maintenance — supports accountability reporting and contractor performance management."
  measures:
    - name: "total_pipe_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of pipe mains in feet. Fundamental network inventory metric; used to normalise break rates (breaks per mile), calculate rehabilitation cost estimates, and report network scale."
    - name: "avg_pipe_length_feet"
      expr: AVG(CAST(length_feet AS DOUBLE))
      comment: "Average length of individual pipe main segments. Used in network segmentation analysis and to assess GIS data completeness."
    - name: "avg_nominal_diameter_inches"
      expr: AVG(CAST(nominal_diameter_inches AS DOUBLE))
      comment: "Average nominal diameter of pipe mains in inches. Indicates the typical capacity profile of the network; used in hydraulic model validation and capacity planning."
    - name: "total_max_flow_capacity_gpm"
      expr: SUM(CAST(max_flow_capacity_gpm AS DOUBLE))
      comment: "Total theoretical maximum flow capacity across all mains in GPM. Measures network hydraulic headroom; used to identify capacity-constrained zones requiring upsizing investment."
    - name: "avg_hazen_williams_c_factor"
      expr: AVG(CAST(hazen_williams_c_factor AS DOUBLE))
      comment: "Average Hazen-Williams C-factor across pipe mains. Measures hydraulic roughness and effective carrying capacity; declining C-factors indicate tuberculation or deterioration requiring rehabilitation."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across pipe mains in PSI. Used to assess pressure compliance and identify over-pressurised mains with elevated break risk."
    - name: "total_pipe_main_count"
      expr: COUNT(pipe_main_id)
      comment: "Total number of pipe main segments in the inventory. Baseline count for asset registry completeness assessment and per-segment KPI normalisation."
    - name: "mains_without_cathodic_protection"
      expr: COUNT(CASE WHEN cathodic_protection_flag = FALSE THEN pipe_main_id END)
      comment: "Number of metallic pipe mains without cathodic protection. Quantifies corrosion risk exposure in the network; drives targeted cathodic protection installation investment."
    - name: "fire_flow_capable_main_count"
      expr: COUNT(CASE WHEN fire_flow_capable_flag = TRUE THEN pipe_main_id END)
      comment: "Number of mains rated as fire flow capable. Used in fire risk compliance reporting and to identify gaps in fire flow coverage across the service area."
    - name: "avg_depth_feet"
      expr: AVG(CAST(depth_feet AS DOUBLE))
      comment: "Average burial depth of pipe mains in feet. Shallow mains are more vulnerable to surface loading and frost damage; used to identify at-risk segments for protective measures."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_storage_tank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tank asset and capacity metrics. Tracks total and usable storage capacity, emergency and fire flow reserves, and asset condition across the distribution storage portfolio. Used by operations and capital planning to ensure supply resilience, regulatory compliance, and asset integrity."
  source: "`vibe_water_utilities_v1`.`distribution`.`storage_tank`"
  dimensions:
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served by the tank — enables storage adequacy analysis by hydraulic zone."
    - name: "tank_type"
      expr: tank_type
      comment: "Type of storage tank (e.g. elevated, ground-level, standpipe) — enables analysis by tank configuration and hydraulic function."
    - name: "tank_material"
      expr: tank_material
      comment: "Construction material of the tank — used in condition and lifecycle analysis segmented by material type."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the tank (e.g. in-service, out-of-service) — used to filter active storage assets for capacity reporting."
    - name: "structural_condition"
      expr: structural_condition
      comment: "Structural condition rating of the tank — key asset health dimension for prioritising inspection and rehabilitation investment."
    - name: "coating_condition"
      expr: coating_condition
      comment: "Condition of the tank coating — deteriorating coatings increase corrosion risk and water quality risk; used to prioritise recoating programmes."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the tank (e.g. utility-owned, developer-owned) — supports asset responsibility and maintenance accountability reporting."
    - name: "mixing_system_installed"
      expr: mixing_system_installed
      comment: "Whether a mixing system is installed — relevant to water quality risk management; tanks without mixing are at higher risk of disinfectant decay and stratification."
    - name: "security_system_installed"
      expr: security_system_installed
      comment: "Whether a security system is installed — used in security compliance and vulnerability assessment reporting."
  measures:
    - name: "total_capacity_gallons"
      expr: SUM(CAST(capacity_gallons AS DOUBLE))
      comment: "Total gross storage capacity across all tanks in gallons. Primary supply resilience metric; used to assess days of supply buffer and compliance with regulatory storage requirements."
    - name: "total_usable_capacity_gallons"
      expr: SUM(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Total usable (operational) storage capacity in gallons. More operationally relevant than gross capacity; used for demand coverage calculations and emergency supply planning."
    - name: "total_emergency_storage_gallons"
      expr: SUM(CAST(emergency_storage_gallons AS DOUBLE))
      comment: "Total emergency storage reserve across all tanks in gallons. Measures the system's ability to maintain supply during source or treatment outages; critical for resilience planning and regulatory compliance."
    - name: "total_fire_flow_reserve_gallons"
      expr: SUM(CAST(fire_flow_reserve_gallons AS DOUBLE))
      comment: "Total fire flow reserve capacity across all tanks in gallons. Regulatory and public safety KPI; insufficient fire flow reserve triggers compliance action and infrastructure investment."
    - name: "total_capacity_million_gallons"
      expr: SUM(CAST(capacity_million_gallons AS DOUBLE))
      comment: "Total gross storage capacity in million gallons. Executive-level summary measure for board and regulatory reporting on system storage adequacy."
    - name: "avg_usable_capacity_gallons"
      expr: AVG(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Average usable capacity per tank in gallons. Used to identify undersized tanks relative to the zone demand they serve."
    - name: "in_service_tank_count"
      expr: COUNT(CASE WHEN operational_status = 'in-service' THEN storage_tank_id END)
      comment: "Number of tanks currently in service. Baseline operational count; reductions due to outages or decommissioning directly impact system storage adequacy."
    - name: "tanks_without_mixing_system"
      expr: COUNT(CASE WHEN mixing_system_installed = FALSE THEN storage_tank_id END)
      comment: "Number of tanks without a mixing system installed. Quantifies water quality risk exposure from disinfectant decay and stratification; drives mixing system installation investment prioritisation."
    - name: "tanks_without_security_system"
      expr: COUNT(CASE WHEN security_system_installed = FALSE THEN storage_tank_id END)
      comment: "Number of tanks without a security system. Measures security vulnerability across the storage portfolio; used in security compliance gap reporting and investment planning."
    - name: "avg_maximum_operating_level_feet"
      expr: AVG(CAST(maximum_operating_level_feet AS DOUBLE))
      comment: "Average maximum operating level across tanks in feet. Used in hydraulic model calibration and to assess whether tanks are being operated within design parameters."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pump_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pump station asset and capacity metrics. Tracks pumping capacity, redundancy, SCADA integration, and backup power coverage across the distribution pumping infrastructure. Used by operations and asset management to ensure reliable water delivery, manage energy risk, and plan capital investment."
  source: "`vibe_water_utilities_v1`.`distribution`.`pump_station`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area served — enables pumping capacity analysis by DMA."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served — supports analysis of pumping infrastructure by hydraulic zone."
    - name: "station_type"
      expr: station_type
      comment: "Type of pump station (e.g. booster, transfer, raw water) — enables analysis segmented by functional role."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the station — used to filter active stations for capacity and reliability reporting."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification — supports accountability and maintenance responsibility reporting."
    - name: "scada_integrated"
      expr: scada_integrated
      comment: "Whether the station is integrated with SCADA — measures remote monitoring coverage; non-SCADA stations represent operational blind spots."
    - name: "backup_generator_available"
      expr: backup_generator_available
      comment: "Whether a backup generator is available — critical resilience dimension; stations without backup power are vulnerable to supply interruptions during grid outages."
    - name: "vfd_equipped"
      expr: vfd_equipped
      comment: "Whether the station is equipped with variable frequency drives — VFD stations offer energy efficiency and pressure control benefits; used in energy optimisation analysis."
    - name: "power_supply_phase"
      expr: power_supply_phase
      comment: "Electrical supply phase configuration — relevant to power reliability risk assessment and upgrade planning."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the station was installed — supports age-based asset risk analysis and end-of-life planning."
  measures:
    - name: "total_design_flow_capacity_mgd"
      expr: SUM(CAST(design_flow_capacity_mgd AS DOUBLE))
      comment: "Total design pumping capacity across all stations in MGD. Primary capacity metric; used to assess whether pumping infrastructure can meet peak demand and growth projections."
    - name: "total_design_flow_capacity_gpm"
      expr: SUM(CAST(design_flow_capacity_gpm AS DOUBLE))
      comment: "Total design pumping capacity in GPM. Operational-level capacity measure used in hydraulic modelling and fire flow adequacy assessments."
    - name: "avg_discharge_pressure_psi"
      expr: AVG(CAST(discharge_pressure_psi AS DOUBLE))
      comment: "Average discharge pressure across pump stations in PSI. Used to assess whether stations are delivering adequate pressure to their service zones and to identify over/under-pressurisation."
    - name: "avg_total_dynamic_head_ft"
      expr: AVG(CAST(total_dynamic_head_ft AS DOUBLE))
      comment: "Average total dynamic head across stations in feet. Key hydraulic performance indicator; used in pump efficiency analysis and energy consumption benchmarking."
    - name: "total_backup_generator_capacity_kw"
      expr: SUM(CAST(backup_generator_capacity_kw AS DOUBLE))
      comment: "Total backup generator capacity across stations in kilowatts. Measures the system's ability to maintain pumping operations during grid outages; critical for emergency resilience planning."
    - name: "stations_without_backup_generator"
      expr: COUNT(CASE WHEN backup_generator_available = FALSE THEN pump_station_id END)
      comment: "Number of pump stations without backup generator capability. Quantifies resilience vulnerability; each station without backup power represents a single point of failure during grid outages."
    - name: "stations_without_scada"
      expr: COUNT(CASE WHEN scada_integrated = FALSE THEN pump_station_id END)
      comment: "Number of pump stations not integrated with SCADA. Measures operational monitoring blind spots; non-SCADA stations cannot be remotely monitored or controlled, increasing response times to failures."
    - name: "vfd_equipped_station_count"
      expr: COUNT(CASE WHEN vfd_equipped = TRUE THEN pump_station_id END)
      comment: "Number of pump stations equipped with variable frequency drives. Measures energy efficiency infrastructure coverage; VFD stations deliver significant energy savings and pressure control benefits."
    - name: "active_station_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN pump_station_id END)
      comment: "Number of currently active pump stations. Baseline operational count for capacity normalisation and availability reporting."
    - name: "avg_suction_pressure_psi"
      expr: AVG(CAST(suction_pressure_psi AS DOUBLE))
      comment: "Average suction pressure across pump stations in PSI. Low suction pressure indicates supply-side constraints or cavitation risk; used in pump performance and network hydraulic analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_dma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District Metered Area (DMA) configuration and performance metrics. Tracks DMA network characteristics, leakage targets, pressure performance, and monitoring coverage. Used by water loss managers and network planners to manage NRW targets, prioritise leakage surveys, and optimise DMA boundaries."
  source: "`vibe_water_utilities_v1`.`distribution`.`dma`"
  dimensions:
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone containing the DMA — enables analysis of DMA performance by hydraulic zone."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory — supports geographic breakdown of DMA performance for regional management."
    - name: "dma_status"
      expr: dma_status
      comment: "Current operational status of the DMA (e.g. active, decommissioned) — used to filter active DMAs for operational reporting."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the DMA — enables risk-weighted analysis of leakage and NRW performance."
    - name: "scada_monitored_flag"
      expr: scada_monitored_flag
      comment: "Whether the DMA is monitored by SCADA — measures real-time monitoring coverage; non-SCADA DMAs have reduced leakage detection capability."
  measures:
    - name: "total_main_length_miles"
      expr: SUM(CAST(main_length_miles AS DOUBLE))
      comment: "Total pipe main length across all DMAs in miles. Used to normalise leakage rates (gallons per mile per day) for inter-DMA benchmarking and regulatory reporting."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(average_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across DMAs in PSI. Key driver of leakage rates; higher average pressure correlates with higher background leakage and break frequency."
    - name: "avg_target_nrw_percentage"
      expr: AVG(CAST(target_nrw_percentage AS DOUBLE))
      comment: "Average NRW target percentage across DMAs. Used to assess the ambition level of the water loss reduction programme and benchmark actual NRW performance against targets."
    - name: "avg_target_ufw_percentage"
      expr: AVG(CAST(target_ufw_percentage AS DOUBLE))
      comment: "Average UFW target percentage across DMAs. Complementary to NRW target; used in regulatory performance reporting and programme planning."
    - name: "total_design_flow_mgd"
      expr: SUM(CAST(design_flow_mgd AS DOUBLE))
      comment: "Total design flow capacity across all DMAs in MGD. Measures the aggregate hydraulic capacity of the DMA network; used in demand forecasting and capacity planning."
    - name: "avg_minimum_night_flow_threshold_gpm"
      expr: AVG(CAST(minimum_night_flow_threshold_gpm AS DOUBLE))
      comment: "Average minimum night flow threshold across DMAs in GPM. MNF thresholds are the primary trigger for leakage investigation; this measure supports threshold calibration and benchmarking."
    - name: "scada_monitored_dma_count"
      expr: COUNT(CASE WHEN scada_monitored_flag = TRUE THEN dma_id END)
      comment: "Number of DMAs with SCADA monitoring. Measures real-time leakage detection coverage; low SCADA coverage reduces the organisation's ability to detect and respond to leakage events promptly."
    - name: "total_dma_count"
      expr: COUNT(dma_id)
      comment: "Total number of DMAs in the network. Baseline count for coverage analysis and per-DMA KPI normalisation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line asset inventory and regulatory compliance metrics. Tracks material composition, LCRR (Lead and Copper Rule Revisions) inventory verification status, condition, and replacement prioritisation across the service line portfolio. Used by asset management, compliance, and executives to manage lead service line replacement programmes and regulatory obligations."
  source: "`vibe_water_utilities_v1`.`distribution`.`service_line`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area — enables service line analysis by DMA for targeted replacement programme planning."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone — supports analysis of service line inventory by hydraulic zone."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory — supports geographic breakdown of service line inventory and compliance status."
    - name: "material_type"
      expr: material_type
      comment: "Material of the service line (e.g. lead, galvanised, copper, HDPE) — primary dimension for LCRR compliance analysis and replacement prioritisation."
    - name: "lcrr_classification"
      expr: lcrr_classification
      comment: "LCRR regulatory classification of the service line (e.g. lead, non-lead, unknown) — critical regulatory compliance dimension driving replacement programme scope and reporting."
    - name: "lcrr_inventory_verified"
      expr: lcrr_inventory_verified
      comment: "Whether the LCRR classification has been verified — measures inventory data completeness for regulatory submission; unverified lines represent compliance risk."
    - name: "connection_status"
      expr: connection_status
      comment: "Current connection status of the service line (e.g. active, abandoned) — used to filter active connections for compliance and operational reporting."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the service line (e.g. utility, customer) — critical for determining replacement programme responsibility and cost allocation."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (e.g. residential, commercial, fire) — enables analysis of service line inventory by customer class."
    - name: "installation_year"
      expr: installation_year
      comment: "Year of installation — supports age-cohort analysis for end-of-life and replacement prioritisation."
  measures:
    - name: "total_service_line_count"
      expr: COUNT(service_line_id)
      comment: "Total number of service lines in the inventory. Baseline count for LCRR compliance reporting and replacement programme scope quantification."
    - name: "lcrr_verified_count"
      expr: COUNT(CASE WHEN lcrr_inventory_verified = TRUE THEN service_line_id END)
      comment: "Number of service lines with verified LCRR classification. Measures progress toward full inventory verification required by the Lead and Copper Rule Revisions; a critical regulatory compliance KPI."
    - name: "lcrr_unverified_count"
      expr: COUNT(CASE WHEN lcrr_inventory_verified = FALSE THEN service_line_id END)
      comment: "Number of service lines with unverified LCRR classification. Quantifies remaining compliance gap in the lead service line inventory; drives field verification programme prioritisation."
    - name: "total_service_line_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of service lines in feet. Used to estimate replacement programme cost and duration; longer total length indicates greater capital investment requirement."
    - name: "avg_service_line_length_feet"
      expr: AVG(CAST(length_feet AS DOUBLE))
      comment: "Average length of individual service lines in feet. Used in unit cost estimation for replacement programme budgeting."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average diameter of service lines in inches. Used in hydraulic capacity analysis and to identify undersized connections limiting customer service pressure."
    - name: "curb_stop_installed_count"
      expr: COUNT(CASE WHEN curb_stop_installed = TRUE THEN service_line_id END)
      comment: "Number of service lines with a curb stop installed. Curb stops are required for isolation during repairs and replacements; gaps in coverage increase operational risk and replacement programme complexity."
    - name: "distinct_dmas_with_service_lines"
      expr: COUNT(DISTINCT dma_id)
      comment: "Number of distinct DMAs containing service lines. Used to assess geographic coverage of the service line inventory and identify DMAs requiring field verification."
$$;