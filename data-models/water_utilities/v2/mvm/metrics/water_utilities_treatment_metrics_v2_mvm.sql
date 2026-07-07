-- Metric views for domain: treatment | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily finished water production KPIs tracking treatment plant output volume, efficiency, and water quality. Core operational dashboard for plant managers and utility executives to monitor throughput, losses, and compliance with turbidity/pH targets."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility identifier — enables per-plant performance comparison and benchmarking."
    - name: "production_date"
      expr: DATE_TRUNC('day', production_date)
      comment: "Daily production date — supports trend analysis, seasonal patterns, and regulatory reporting periods."
    - name: "production_month"
      expr: DATE_TRUNC('month', production_date)
      comment: "Monthly production period — used for monthly operating reports and capacity planning."
    - name: "production_year"
      expr: YEAR(production_date)
      comment: "Production year — supports annual capital planning and long-term capacity forecasting."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Indicates whether the production record passed data quality checks — used to filter out suspect readings in regulatory submissions."
  measures:
    - name: "total_finished_water_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total finished (treated) water delivered to distribution in million gallons. Primary throughput KPI for capacity planning and revenue assurance."
    - name: "total_source_water_volume_mg"
      expr: SUM(CAST(source_water_volume_mg AS DOUBLE))
      comment: "Total raw source water withdrawn for treatment in million gallons. Compared against finished water to compute treatment losses and efficiency."
    - name: "total_backwash_volume_mg"
      expr: SUM(CAST(backwash_volume_mg AS DOUBLE))
      comment: "Total water volume consumed in filter backwash operations in million gallons. High backwash volume signals filter media degradation or over-cycling."
    - name: "total_filter_to_waste_volume_mg"
      expr: SUM(CAST(filter_to_waste_volume_mg AS DOUBLE))
      comment: "Total water volume wasted during filter-to-waste operations in million gallons. Tracks non-revenue water losses from treatment processes."
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (finished water / source water). Measures how effectively the plant converts raw water to potable product — a key operational and cost efficiency KPI."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity in NTU across production days. Regulatory compliance threshold is typically 0.3 NTU; sustained exceedances trigger enforcement action."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_max_ntu)
      comment: "Maximum single-day turbidity peak in NTU. Used to identify worst-case compliance events and assess filter performance under peak-load conditions."
    - name: "avg_cl2_residual_mg_l"
      expr: AVG(CAST(cl2_residual_avg_mg_l AS DOUBLE))
      comment: "Average chlorine residual in finished water (mg/L). Must remain above regulatory minimum (typically 0.2 mg/L) to ensure disinfection protection throughout the distribution system."
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average finished water pH. Optimal range is 6.5–8.5 per EPA Secondary Standards; deviations affect corrosion control and disinfection byproduct formation."
    - name: "avg_peak_production_rate_gpm"
      expr: AVG(CAST(peak_production_rate_gpm AS DOUBLE))
      comment: "Average peak production rate in gallons per minute. Indicates how close the plant operates to its design capacity ceiling — critical for capacity headroom analysis."
    - name: "production_days"
      expr: COUNT(DISTINCT production_date)
      comment: "Number of distinct production days in the reporting period. Used as the denominator for daily average calculations and to detect reporting gaps."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical dosing performance and compliance KPIs for treatment operations. Tracks disinfectant application accuracy, CT compliance, and chemical consumption — essential for regulatory reporting and cost control."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility — enables cross-facility chemical usage benchmarking."
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit where chemical was applied — supports unit-level dosing performance analysis."
    - name: "chemical_id"
      expr: chemical_id
      comment: "Chemical applied — enables cost and consumption analysis by chemical type."
    - name: "ct_compliance_flag"
      expr: ct_compliance_flag
      comment: "Indicates whether the dose event achieved required CT (concentration × time) for disinfection compliance. Non-compliant events require immediate regulatory notification."
    - name: "dose_start_month"
      expr: DATE_TRUNC('month', dose_start_timestamp)
      comment: "Month of dose event — supports monthly chemical consumption reporting and trend analysis."
    - name: "dose_start_date"
      expr: CAST(dose_start_timestamp AS DATE)
      comment: "Date of dose event — supports daily operational review of chemical application."
  measures:
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total chemical mass applied across all dose events in kilograms. Primary chemical consumption KPI for procurement planning and cost management."
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average chemical dose rate in mg/L. Compared against target residuals to assess dosing precision and identify over- or under-dosing patterns."
    - name: "avg_post_dose_residual_mg_per_l"
      expr: AVG(CAST(post_dose_residual_mg_per_l AS DOUBLE))
      comment: "Average measured residual concentration after dosing in mg/L. Must meet regulatory minimums; persistent shortfalls indicate dosing system or contact time issues."
    - name: "avg_target_residual_mg_per_l"
      expr: AVG(CAST(target_residual_mg_per_l AS DOUBLE))
      comment: "Average target residual concentration in mg/L. Baseline for computing residual achievement gap and dosing accuracy."
    - name: "total_dose_events"
      expr: COUNT(1)
      comment: "Total number of chemical dose events. Used to normalize consumption metrics and assess dosing frequency relative to flow conditions."
    - name: "ct_non_compliant_events"
      expr: SUM(CASE WHEN ct_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of dose events that failed CT compliance. Each non-compliant event is a potential regulatory violation requiring corrective action and reporting."
    - name: "avg_water_flow_rate_mgd"
      expr: AVG(CAST(water_flow_rate_mgd AS DOUBLE))
      comment: "Average water flow rate during dosing events in million gallons per day. Used to contextualize chemical consumption relative to throughput volume."
    - name: "total_water_volume_dosed_mgd"
      expr: SUM(CAST(water_flow_rate_mgd AS DOUBLE))
      comment: "Sum of flow rates across all dose events in MGD. Proxy for total water volume treated with chemical — supports per-unit-volume cost calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_ct_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CT (Concentration × Time) disinfection compliance KPIs required under the Surface Water Treatment Rule (SWTR). Tracks log inactivation achievement, CT ratios, and compliance status — directly tied to public health protection and regulatory standing."
  source: "`vibe_water_utilities_v1`.`treatment`.`ct_compliance_record`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility — enables facility-level compliance benchmarking and regulatory reporting."
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit where CT was calculated — supports unit-level disinfection performance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the CT record (e.g., Compliant, Non-Compliant, Pending). Primary filter for regulatory exception reporting."
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant used (e.g., chlorine, chloramine, ozone, UV). Drives CT table lookup and required inactivation credit calculations."
    - name: "target_organism"
      expr: target_organism
      comment: "Pathogen targeted for inactivation (e.g., Giardia, Cryptosporidium, viruses). Determines required log inactivation credits under SWTR/LT2ESWTR."
    - name: "operator_verified"
      expr: operator_verified
      comment: "Whether a certified operator has verified the CT calculation. Unverified records may not be accepted for regulatory submission."
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_timestamp)
      comment: "Month of CT calculation — supports monthly compliance summary reporting to primacy agencies."
  measures:
    - name: "total_ct_records"
      expr: COUNT(1)
      comment: "Total CT compliance records in the reporting period. Used to assess monitoring frequency and completeness of disinfection records."
    - name: "non_compliant_ct_records"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of CT records with non-compliant status. Each non-compliant record represents a potential SWTR violation requiring immediate corrective action and regulatory notification."
    - name: "avg_ct_ratio"
      expr: AVG(CAST(ct_ratio AS DOUBLE))
      comment: "Average CT ratio (CT achieved / CT required). Values below 1.0 indicate non-compliance; values well above 1.0 may indicate over-dosing and unnecessary chemical cost."
    - name: "min_ct_ratio"
      expr: MIN(ct_ratio)
      comment: "Minimum CT ratio observed in the period. The worst-case CT ratio is the most critical compliance indicator — a single value below 1.0 constitutes a violation."
    - name: "avg_log_inactivation_achieved"
      expr: AVG(CAST(log_inactivation_achieved AS DOUBLE))
      comment: "Average log inactivation credit achieved. SWTR requires minimum 3-log Giardia and 4-log virus inactivation; sustained shortfalls indicate systemic treatment deficiency."
    - name: "avg_ct_calculated"
      expr: AVG(CAST(ct_calculated AS DOUBLE))
      comment: "Average calculated CT value (mg/L·min). Tracks actual disinfection dose delivered — used to optimize chemical usage while maintaining compliance margin."
    - name: "avg_ct_required"
      expr: AVG(CAST(ct_required AS DOUBLE))
      comment: "Average required CT value (mg/L·min) based on temperature, pH, and target organism. Baseline for compliance gap analysis."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average water temperature in Celsius during CT calculations. Temperature is a primary driver of CT requirements — colder water requires higher CT to achieve the same inactivation."
    - name: "avg_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH during CT calculations. pH affects disinfectant efficacy (especially chlorine) and CT table lookup values — critical for accurate compliance determination."
    - name: "unverified_ct_records"
      expr: SUM(CASE WHEN operator_verified = FALSE THEN 1 ELSE 0 END)
      comment: "Count of CT records not yet verified by a certified operator. Unverified records create regulatory submission risk and audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source water quality and intake volume KPIs for treatment planning and permit compliance. Tracks raw water characteristics that drive treatment chemical demand, process adjustments, and permit compliance — essential for operations and environmental reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility receiving the source water — enables per-facility intake analysis."
    - name: "water_source_id"
      expr: water_source_id
      comment: "Source water body identifier — supports multi-source blending analysis and source-specific quality trending."
    - name: "source_type"
      expr: source_type
      comment: "Type of source water (e.g., surface water, groundwater, purchased). Drives regulatory treatment requirements and CT obligations."
    - name: "permit_compliance_status"
      expr: permit_compliance_status
      comment: "Permit compliance status for the intake event. Non-compliant intakes may violate withdrawal permits and trigger regulatory reporting."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the intake record — used to exclude suspect readings from regulatory calculations."
    - name: "intake_month"
      expr: DATE_TRUNC('month', intake_timestamp)
      comment: "Month of intake event — supports monthly withdrawal reporting and seasonal quality trend analysis."
  measures:
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total source water withdrawn in million gallons. Primary metric for water rights compliance — must not exceed permitted withdrawal volumes."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average raw water turbidity in NTU. High source turbidity drives increased coagulant demand and filter loading — a leading indicator of treatment cost and operational stress."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_ntu)
      comment: "Maximum raw water turbidity peak in NTU. Extreme turbidity events (e.g., storm runoff) can overwhelm treatment capacity and require emergency operational response."
    - name: "avg_toc_mg_per_l"
      expr: AVG(CAST(toc_mg_per_l AS DOUBLE))
      comment: "Average total organic carbon in source water (mg/L). TOC is the primary precursor to disinfection byproducts (DBPs) — high TOC drives enhanced coagulation requirements under the D/DBP Rule."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average source water pH. Drives coagulant selection, dosing optimization, and CT table requirements for disinfection compliance."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average source water temperature in Celsius. Cold water increases CT requirements and slows coagulation — critical for winter operations planning."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average intake flow rate in gallons per minute. Tracks withdrawal rate relative to permit limits and treatment plant capacity."
    - name: "avg_conductivity_us_per_cm"
      expr: AVG(CAST(conductivity_us_per_cm AS DOUBLE))
      comment: "Average source water conductivity in µS/cm. Elevated conductivity indicates dissolved solids loading — relevant for membrane treatment processes and corrosion control."
    - name: "permit_non_compliant_intakes"
      expr: SUM(CASE WHEN permit_compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of intake events with permit non-compliance status. Each non-compliant intake is a potential water rights or environmental permit violation requiring regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment process unit asset performance and capacity KPIs. Tracks unit condition, capacity utilization, and operational status — essential for capital planning, maintenance prioritization, and regulatory capacity certification."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_unit`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility — enables facility-level asset portfolio analysis."
    - name: "process_type"
      expr: process_type
      comment: "Type of treatment process (e.g., coagulation, filtration, disinfection, membrane). Supports technology-specific performance benchmarking."
    - name: "process_stage"
      expr: process_stage
      comment: "Stage in the treatment train (e.g., primary, secondary, tertiary). Enables stage-level capacity and condition analysis."
    - name: "treatment_technology"
      expr: treatment_technology
      comment: "Specific treatment technology deployed (e.g., GAC, UV, RO, chlorination). Drives technology-specific performance benchmarks and replacement planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the process unit (e.g., Online, Offline, Standby, Maintenance). Critical for capacity availability reporting."
    - name: "is_online"
      expr: is_online
      comment: "Whether the process unit is currently online and treating water. Used to compute available treatment capacity."
    - name: "is_redundant"
      expr: is_redundant
      comment: "Whether the unit provides redundant capacity. Redundancy level is a key resilience metric for AWIA risk assessments."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Asset condition rating (e.g., Good, Fair, Poor, Critical). Drives capital replacement prioritization and maintenance budget allocation."
  measures:
    - name: "total_process_units"
      expr: COUNT(1)
      comment: "Total number of process units in the asset portfolio. Baseline for capacity and redundancy analysis."
    - name: "online_process_units"
      expr: SUM(CASE WHEN is_online = TRUE THEN 1 ELSE 0 END)
      comment: "Count of process units currently online and operational. Compared against total units to compute availability ratio — a key reliability KPI."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design treatment capacity in MGD across all process units. Baseline for capacity utilization and expansion planning."
    - name: "total_rated_capacity_mgd"
      expr: SUM(CAST(rated_capacity_mgd AS DOUBLE))
      comment: "Total rated (operational) treatment capacity in MGD. Compared against design capacity to identify capacity degradation requiring rehabilitation."
    - name: "avg_condition_score"
      expr: AVG(CAST(condition_score AS DOUBLE))
      comment: "Average asset condition score across process units. Declining scores signal increasing capital reinvestment need and rising failure risk."
    - name: "avg_criticality_score"
      expr: AVG(CAST(criticality_score AS DOUBLE))
      comment: "Average criticality score across process units. High criticality combined with poor condition identifies assets requiring priority capital investment."
    - name: "avg_pfas_removal_efficiency_pct"
      expr: AVG(CAST(pfas_removal_efficiency_pct AS DOUBLE))
      comment: "Average PFAS removal efficiency percentage across capable process units. Critical KPI given EPA PFAS MCL enforcement — tracks whether treatment meets new regulatory limits."
    - name: "total_cumulative_volume_treated_mg"
      expr: SUM(CAST(cumulative_volume_treated_mg AS DOUBLE))
      comment: "Total cumulative volume treated across all process units in million gallons. Used to assess media exhaustion (e.g., GAC bed volumes) and schedule regeneration or replacement."
    - name: "avg_design_log_removal_credit"
      expr: AVG(CAST(design_log_removal_credit AS DOUBLE))
      comment: "Average design log removal credit across process units. Compared against CT compliance records to verify that installed units deliver their regulatory inactivation credits."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical process monitoring KPIs for treatment operations. Tracks measured parameter values against regulatory limits, exceedance rates, and data quality — essential for SCADA-driven operations, DMR reporting, and compliance management."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_reading`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility — enables facility-level process monitoring comparison."
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of process parameter measured (e.g., turbidity, chlorine residual, pH, flow). Primary grouping dimension for parameter-specific compliance analysis."
    - name: "process_stage"
      expr: process_stage
      comment: "Treatment process stage where the reading was taken. Enables stage-specific quality profiling across the treatment train."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Treatment process type associated with the reading. Supports technology-specific performance benchmarking."
    - name: "is_regulatory_exceedance"
      expr: is_regulatory_exceedance
      comment: "Flags readings that exceed regulatory limits. The primary compliance exception dimension — drives enforcement reporting and corrective action workflows."
    - name: "regulatory_limit_type"
      expr: regulatory_limit_type
      comment: "Type of regulatory limit applicable (e.g., MCL, Action Level, Treatment Technique). Contextualizes exceedance severity and required response."
    - name: "dmr_reporting_flag"
      expr: dmr_reporting_flag
      comment: "Indicates whether the reading is required for Discharge Monitoring Report (DMR) submission. Filters the dataset to regulatory-reportable readings."
    - name: "reading_date"
      expr: reading_date
      comment: "Date of the process reading — supports daily operational review and compliance period analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Month of the process reading — supports monthly compliance summary and DMR reporting periods."
    - name: "alarm_state"
      expr: alarm_state
      comment: "SCADA alarm state at time of reading (e.g., Normal, High, Low, Critical). Used to correlate process alarms with compliance exceedances."
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total process readings in the reporting period. Used to assess monitoring completeness and SCADA data availability."
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN is_regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readings that exceeded regulatory limits. Each exceedance is a potential compliance violation — the primary KPI for regulatory risk management."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value across readings. Compared against regulatory limits and target ranges to assess process stability."
    - name: "max_measured_value"
      expr: MAX(measured_value)
      comment: "Maximum measured parameter value in the period. Identifies worst-case process excursions that may trigger regulatory action."
    - name: "avg_regulatory_limit_value"
      expr: AVG(CAST(regulatory_limit_value AS DOUBLE))
      comment: "Average regulatory limit value for the parameter. Provides context for interpreting measured values relative to compliance thresholds."
    - name: "avg_ct_value"
      expr: AVG(CAST(ct_value AS DOUBLE))
      comment: "Average CT value from process readings in mg/L·min. Cross-validates CT compliance records with real-time SCADA measurements."
    - name: "avg_ct_required"
      expr: AVG(CAST(ct_required AS DOUBLE))
      comment: "Average required CT value from process readings. Used alongside avg_ct_value to compute real-time CT compliance margin."
    - name: "manual_entry_readings"
      expr: SUM(CASE WHEN is_manual_entry = TRUE THEN 1 ELSE 0 END)
      comment: "Count of manually entered readings (vs. automated SCADA). High manual entry rates indicate SCADA gaps and increase data integrity risk for regulatory submissions."
    - name: "quality_flagged_readings"
      expr: SUM(CASE WHEN quality_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readings flagged for data quality issues. Quality-flagged readings must be reviewed before inclusion in regulatory reports — high counts signal instrumentation or data pipeline problems."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment facility portfolio KPIs for executive and regulatory oversight. Tracks capacity utilization, operational status, energy intensity, and resilience attributes across the utility's treatment plant portfolio — essential for capital planning, AWIA compliance, and strategic investment decisions."
  source: "`vibe_water_utilities_v1`.`treatment`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of treatment facility (e.g., surface water plant, groundwater plant, desalination). Drives regulatory requirements and benchmarking peer groups."
    - name: "facility_status"
      expr: facility_status
      comment: "Current operational status of the facility (e.g., Active, Inactive, Decommissioned). Filters the portfolio to active assets for capacity planning."
    - name: "primary_treatment_process"
      expr: primary_treatment_process
      comment: "Primary treatment process employed (e.g., conventional, direct filtration, membrane). Supports technology-specific benchmarking and capital planning."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Primary disinfection method (e.g., chlorination, UV, ozone). Drives CT requirements and DBP formation potential."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification (e.g., municipal, private, authority). Relevant for rate-setting, regulatory jurisdiction, and financial reporting."
    - name: "state_code"
      expr: state_code
      comment: "State where the facility is located — supports state-level regulatory reporting and primacy agency submissions."
    - name: "backup_power_available"
      expr: backup_power_available
      comment: "Whether backup power is available at the facility. A critical resilience indicator under AWIA 2018 — facilities without backup power are high-priority for capital investment."
    - name: "pfas_treatment_capable_flag"
      expr: pfas_treatment_capable_flag
      comment: "Whether the facility is capable of treating PFAS compounds. Critical given EPA PFAS MCL enforcement — identifies facilities requiring technology upgrades."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of treatment facilities in the portfolio. Baseline for capacity and investment planning."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design treatment capacity across all facilities in MGD. Primary capacity planning KPI — compared against current demand to assess system headroom."
    - name: "total_operational_capacity_mgd"
      expr: SUM(CAST(operational_capacity_mgd AS DOUBLE))
      comment: "Total current operational capacity in MGD. Compared against design capacity to quantify capacity degradation requiring rehabilitation investment."
    - name: "total_average_daily_production_mgd"
      expr: SUM(CAST(average_daily_production_mgd AS DOUBLE))
      comment: "Total average daily production across all facilities in MGD. Primary throughput KPI for system-wide supply adequacy assessment."
    - name: "total_annual_operating_cost_usd"
      expr: SUM(CAST(annual_operating_cost_usd AS DOUBLE))
      comment: "Total annual operating cost across all treatment facilities in USD. Primary cost KPI for rate-setting, budget planning, and cost-per-gallon benchmarking."
    - name: "total_annual_energy_kwh"
      expr: SUM(CAST(annual_energy_kwh AS DOUBLE))
      comment: "Total annual energy consumption across all facilities in kWh. Drives energy cost forecasting, carbon footprint reporting, and energy efficiency investment decisions."
    - name: "avg_energy_intensity_kwh_per_mg"
      expr: AVG(CAST(energy_intensity_kwh_per_mg AS DOUBLE))
      comment: "Average energy intensity in kWh per million gallons treated. Industry benchmark KPI — high values indicate inefficient facilities requiring process optimization or equipment upgrades."
    - name: "total_service_population"
      expr: SUM(CAST(service_population AS DOUBLE))
      comment: "Total population served by treatment facilities. Used to compute per-capita cost and capacity metrics, and to size regulatory reporting obligations."
    - name: "facilities_without_backup_power"
      expr: SUM(CASE WHEN backup_power_available = FALSE THEN 1 ELSE 0 END)
      comment: "Count of facilities lacking backup power. AWIA 2018 resilience gap metric — each facility without backup power represents a public health risk during grid outages."
    - name: "pfas_capable_facilities"
      expr: SUM(CASE WHEN pfas_treatment_capable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities capable of PFAS treatment. Tracks readiness for EPA PFAS MCL compliance — gap between total facilities and this count drives the PFAS capital investment program."
$$;