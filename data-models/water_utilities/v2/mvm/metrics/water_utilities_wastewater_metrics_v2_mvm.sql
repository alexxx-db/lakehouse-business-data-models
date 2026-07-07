-- Metric views for domain: wastewater | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_wwtp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for Wastewater Treatment Plant (WWTP) capacity, operational efficiency, and compliance posture. Used by operations leadership and regulators to assess plant performance and investment priorities."
  source: "`vibe_water_utilities_v1`.`wastewater`.`wwtp`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the wastewater treatment plant for facility-level reporting."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of WWTP facility (e.g., activated sludge, lagoon) for technology-segment analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the plant (e.g., Active, Offline, Decommissioned)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the plant, critical for permit and enforcement tracking."
    - name: "treatment_level"
      expr: treatment_level
      comment: "Level of treatment achieved (Primary, Secondary, Tertiary) for regulatory and quality segmentation."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Disinfection technology used (e.g., UV, Chlorination) for operational benchmarking."
    - name: "biosolids_class"
      expr: biosolids_class
      comment: "Class of biosolids produced (Class A / Class B) for regulatory and disposition planning."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the plant for multi-jurisdiction compliance reporting."
    - name: "receiving_water_classification"
      expr: receiving_water_classification
      comment: "Classification of the receiving water body, relevant for discharge permit stringency."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the plant is located for geographic performance analysis."
  measures:
    - name: "total_wwtp_count"
      expr: COUNT(1)
      comment: "Total number of wastewater treatment plants. Baseline fleet size metric for capacity planning and investment decisions."
    - name: "active_wwtp_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active WWTPs. Tracks operational availability of the treatment fleet."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total permitted design capacity in million gallons per day across all plants. Key infrastructure capacity metric for growth and regulatory planning."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total average daily flow processed across all plants in MGD. Measures actual throughput versus design capacity."
    - name: "total_peak_flow_mgd"
      expr: SUM(CAST(peak_flow_mgd AS DOUBLE))
      comment: "Total peak flow capacity across all plants in MGD. Critical for wet-weather event planning and infrastructure resilience."
    - name: "avg_energy_consumption_kwh_per_mg"
      expr: AVG(CAST(energy_consumption_kwh_per_mg AS DOUBLE))
      comment: "Average energy intensity in kWh per million gallons treated. Drives energy efficiency benchmarking and sustainability reporting."
    - name: "non_compliant_wwtp_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of plants with a non-compliant permit status. Directly informs regulatory risk exposure and enforcement prioritization."
    - name: "plants_near_capacity_count"
      expr: COUNT(CASE WHEN CAST(average_daily_flow_mgd AS DOUBLE) >= 0.9 * CAST(design_capacity_mgd AS DOUBLE) THEN 1 END)
      comment: "Number of plants operating at or above 90% of design capacity. Triggers capital investment and expansion planning decisions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_effluent_discharge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance KPIs for effluent discharge events. Used by compliance officers, plant managers, and regulators to monitor discharge volumes, violation rates, and permit adherence."
  source: "`vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event`"
  dimensions:
    - name: "discharge_type"
      expr: discharge_type
      comment: "Type of discharge event (e.g., Routine, Bypass, Emergency) for compliance categorization."
    - name: "discharge_status"
      expr: discharge_status
      comment: "Current status of the discharge event for operational tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the discharge event against permit limits."
    - name: "treatment_level_achieved"
      expr: treatment_level_achieved
      comment: "Level of treatment achieved during the discharge event, relevant for permit compliance."
    - name: "receiving_water_body_name"
      expr: receiving_water_body_name
      comment: "Name of the receiving water body for environmental impact segmentation."
    - name: "receiving_water_body_classification"
      expr: receiving_water_body_classification
      comment: "Classification of the receiving water body for regulatory stringency analysis."
    - name: "bypass_reason_code"
      expr: bypass_reason_code
      comment: "Reason code for bypass events, used to identify systemic infrastructure or operational failures."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of discharge, used to correlate wet-weather events with compliance exceedances."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "Discharge Monitoring Report period for regulatory submission tracking."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Boolean flag indicating whether the discharge event resulted in a permit violation."
  measures:
    - name: "total_discharge_events"
      expr: COUNT(1)
      comment: "Total number of discharge events recorded. Baseline volume metric for operational and compliance reporting."
    - name: "total_discharge_volume_mgd"
      expr: SUM(CAST(discharge_volume_mgd AS DOUBLE))
      comment: "Total effluent discharge volume in million gallons per day across all events. Core throughput metric for permit compliance and environmental reporting."
    - name: "avg_discharge_flow_rate_gpm"
      expr: AVG(CAST(discharge_flow_rate_gpm AS DOUBLE))
      comment: "Average discharge flow rate in gallons per minute. Benchmarks operational flow performance against permit limits."
    - name: "avg_discharge_duration_hours"
      expr: AVG(CAST(discharge_duration_hours AS DOUBLE))
      comment: "Average duration of discharge events in hours. Longer durations may indicate infrastructure or operational issues."
    - name: "violation_event_count"
      expr: COUNT(CASE WHEN violation_flag = TRUE THEN 1 END)
      comment: "Number of discharge events that resulted in a permit violation. Primary compliance risk KPI for regulatory reporting and enforcement tracking."
    - name: "bypass_event_count"
      expr: COUNT(CASE WHEN discharge_type = 'Bypass' THEN 1 END)
      comment: "Number of bypass discharge events. Bypasses represent significant regulatory and environmental risk requiring immediate executive attention."
    - name: "dmr_submitted_event_count"
      expr: COUNT(CASE WHEN dmr_submitted_flag = TRUE THEN 1 END)
      comment: "Number of discharge events for which a Discharge Monitoring Report has been submitted. Tracks regulatory reporting compliance."
    - name: "total_rainfall_amount_inches"
      expr: SUM(CAST(rainfall_amount_inches AS DOUBLE))
      comment: "Total rainfall associated with discharge events. Used to correlate wet-weather conditions with discharge volumes and violations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_effluent_parameter_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water quality and regulatory compliance KPIs derived from effluent parameter test results. Used by environmental compliance teams and regulators to monitor permit limit exceedances, DMR submission status, and analytical quality."
  source: "`vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the parameter result against permit limits (e.g., Compliant, Exceedance)."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., Grab, Composite) for analytical method segmentation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the parameter result, required for cross-parameter comparison."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period for regulatory submission tracking."
    - name: "dmr_submission_status"
      expr: dmr_submission_status
      comment: "Status of DMR submission (e.g., Submitted, Pending, Overdue) for compliance deadline management."
    - name: "data_validation_status"
      expr: data_validation_status
      comment: "Validation status of the analytical result for data quality governance."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency to which results are reported, for multi-agency compliance tracking."
    - name: "result_qualifier"
      expr: result_qualifier
      comment: "Qualifier code for the result (e.g., <, >, ND) indicating detection status."
  measures:
    - name: "total_parameter_results"
      expr: COUNT(1)
      comment: "Total number of effluent parameter results. Baseline analytical throughput metric."
    - name: "exceedance_result_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of parameter results that exceeded permit limits. Primary water quality compliance KPI driving regulatory response and enforcement actions."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceeded permit limits. Quantifies severity of compliance exceedances for prioritization."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured concentration of effluent parameters. Tracks central tendency of effluent quality over time."
    - name: "total_mass_loading_lbs_per_day"
      expr: SUM(CAST(mass_loading_lbs_per_day AS DOUBLE))
      comment: "Total pollutant mass loading in pounds per day. Critical metric for watershed-level environmental impact assessment and permit limit setting."
    - name: "avg_flow_rate_mgd"
      expr: AVG(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Average flow rate at time of sampling in MGD. Contextualizes concentration results with hydraulic loading conditions."
    - name: "quality_control_flagged_count"
      expr: COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END)
      comment: "Number of results flagged for quality control issues. Tracks analytical data integrity and laboratory performance."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_biosolids_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production, quality, and regulatory compliance KPIs for biosolids batches. Used by biosolids program managers and compliance officers to track production volumes, pathogen class distribution, heavy metal concentrations, and disposition compliance."
  source: "`vibe_water_utilities_v1`.`wastewater`.`biosolids_batch`"
  dimensions:
    - name: "biosolids_class"
      expr: biosolids_class
      comment: "Regulatory class of biosolids (Class A / Class B) determining allowable disposition methods."
    - name: "pathogen_class"
      expr: pathogen_class
      comment: "Pathogen reduction class achieved, critical for land application permitting."
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method used to dispose of or beneficially reuse biosolids (e.g., Land Application, Landfill, Incineration)."
    - name: "stabilization_method"
      expr: stabilization_method
      comment: "Stabilization process applied to biosolids (e.g., Anaerobic Digestion, Lime Stabilization)."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Type of treatment process used to generate the biosolids batch."
    - name: "exceptional_quality_flag"
      expr: exceptional_quality_flag
      comment: "Flag indicating whether the batch meets Exceptional Quality (EQ) standards, enabling unrestricted land application."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period for regulatory biosolids reporting."
  measures:
    - name: "total_batch_count"
      expr: COUNT(1)
      comment: "Total number of biosolids batches produced. Baseline production volume metric."
    - name: "total_dry_weight_tons"
      expr: SUM(CAST(dry_weight_tons AS DOUBLE))
      comment: "Total dry weight of biosolids produced in tons. Primary production volume KPI for biosolids program management and regulatory reporting."
    - name: "total_wet_weight_tons"
      expr: SUM(CAST(wet_weight_tons AS DOUBLE))
      comment: "Total wet weight of biosolids produced in tons. Used for transportation cost estimation and logistics planning."
    - name: "avg_percent_solids"
      expr: AVG(CAST(percent_solids AS DOUBLE))
      comment: "Average percent solids content of biosolids batches. Higher solids content reduces transportation and disposal costs."
    - name: "avg_volatile_solids_reduction_percent"
      expr: AVG(CAST(volatile_solids_reduction_percent AS DOUBLE))
      comment: "Average volatile solids reduction percentage. Key indicator of stabilization effectiveness and pathogen reduction compliance."
    - name: "exceptional_quality_batch_count"
      expr: COUNT(CASE WHEN exceptional_quality_flag = TRUE THEN 1 END)
      comment: "Number of batches meeting Exceptional Quality standards. EQ biosolids command higher reuse value and fewer regulatory restrictions."
    - name: "avg_total_nitrogen_percent"
      expr: AVG(CAST(total_nitrogen_percent AS DOUBLE))
      comment: "Average total nitrogen content of biosolids. Determines agronomic value for land application and nutrient management planning."
    - name: "avg_mercury_concentration_mg_per_kg"
      expr: AVG(CAST(mercury_concentration_mg_per_kg AS DOUBLE))
      comment: "Average mercury concentration in biosolids (mg/kg). Mercury is a regulated heavy metal with strict EPA 503 limits; exceedances restrict land application."
    - name: "avg_lead_concentration_mg_per_kg"
      expr: AVG(CAST(lead_concentration_mg_per_kg AS DOUBLE))
      comment: "Average lead concentration in biosolids (mg/kg). Regulated under EPA 503 rules; high concentrations restrict beneficial reuse options."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanitary Sewer Overflow (SSO) event KPIs for regulatory compliance, environmental impact, and infrastructure risk management. Used by utility executives, compliance officers, and regulators to track overflow frequency, volume, environmental impact, and response effectiveness."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sso_event`"
  dimensions:
    - name: "cause_category"
      expr: cause_category
      comment: "High-level category of SSO cause (e.g., Blockage, Capacity, Infrastructure Failure) for root cause analysis."
    - name: "cause_code"
      expr: cause_code
      comment: "Specific cause code for the SSO event, enabling granular failure mode analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the SSO event (e.g., Open, Closed, Under Investigation)."
    - name: "overflow_location_type"
      expr: overflow_location_type
      comment: "Type of location where overflow occurred (e.g., Manhole, Cleanout, Building) for infrastructure targeting."
    - name: "receiving_environment"
      expr: receiving_environment
      comment: "Environment receiving the overflow (e.g., Surface Water, Storm Drain, Land) for environmental impact classification."
    - name: "reached_surface_water"
      expr: reached_surface_water
      comment: "Boolean indicating whether overflow reached a surface water body, triggering mandatory regulatory notification."
    - name: "weather_related"
      expr: weather_related
      comment: "Boolean indicating whether the SSO was weather-related, used to distinguish wet-weather vs. dry-weather SSOs."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period for regulatory SSO reporting."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the SSO event for accountability and corrective action tracking."
  measures:
    - name: "total_sso_events"
      expr: COUNT(1)
      comment: "Total number of SSO events. Primary regulatory performance indicator; high SSO counts trigger enforcement actions and consent orders."
    - name: "total_estimated_volume_gallons"
      expr: SUM(CAST(estimated_volume_gallons AS DOUBLE))
      comment: "Total estimated volume of sewage overflowed in gallons. Core environmental impact metric for regulatory reporting and public health risk assessment."
    - name: "total_volume_recovered_gallons"
      expr: SUM(CAST(volume_recovered_gallons AS DOUBLE))
      comment: "Total volume of overflow recovered in gallons. Measures effectiveness of spill response and environmental mitigation efforts."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of SSO events in minutes. Longer durations indicate slower detection or response, driving investment in SCADA and monitoring."
    - name: "surface_water_impact_event_count"
      expr: COUNT(CASE WHEN reached_surface_water = TRUE THEN 1 END)
      comment: "Number of SSO events that reached a surface water body. These events carry the highest regulatory and public health risk and require mandatory reporting."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties assessed for SSO events. Direct financial impact metric for executive risk management and compliance investment justification."
    - name: "weather_related_sso_count"
      expr: COUNT(CASE WHEN weather_related = TRUE THEN 1 END)
      comment: "Number of SSOs attributed to weather events. Informs wet-weather capacity improvement planning and I/I reduction investment decisions."
    - name: "public_notification_required_count"
      expr: COUNT(CASE WHEN public_notification_required = TRUE THEN 1 END)
      comment: "Number of SSO events requiring public notification. High counts indicate significant public health exposure and reputational risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewer_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure condition, capacity, and risk KPIs for the sewer pipe network. Used by asset managers, capital planners, and operations leadership to prioritize rehabilitation, manage capacity, and assess infrastructure risk."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewer_network`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of sewer segment (e.g., Gravity Main, Force Main, Interceptor) for infrastructure classification."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Structural condition grade of the sewer segment (e.g., Grade 1-5 per NASSCO PACP) for rehabilitation prioritization."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the sewer segment (e.g., Active, Abandoned, Proposed)."
    - name: "lining_type"
      expr: lining_type
      comment: "Type of lining applied to the segment for rehabilitation tracking and asset life extension analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the segment (Public/Private) for maintenance responsibility allocation."
    - name: "fog_risk_flag"
      expr: fog_risk_flag
      comment: "Flag indicating fats, oils, and grease (FOG) risk, used to prioritize FOG inspection and enforcement programs."
    - name: "hydrogen_sulfide_risk_flag"
      expr: hydrogen_sulfide_risk_flag
      comment: "Flag indicating hydrogen sulfide corrosion risk, used to prioritize corrosion protection investments."
    - name: "root_intrusion_flag"
      expr: root_intrusion_flag
      comment: "Flag indicating root intrusion presence, used to target root control maintenance programs."
  measures:
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of sewer network segments. Baseline infrastructure inventory metric."
    - name: "total_network_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of sewer network in feet. Core infrastructure scale metric for asset management and capital planning."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total estimated replacement cost of the sewer network in USD. Drives capital investment planning and rate-setting decisions."
    - name: "avg_design_capacity_mgd"
      expr: AVG(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Average design capacity of sewer segments in MGD. Benchmarks hydraulic capacity across the network."
    - name: "avg_average_daily_flow_mgd"
      expr: AVG(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Average daily flow across sewer segments in MGD. Compared against design capacity to identify capacity-constrained segments."
    - name: "high_risk_segment_count"
      expr: COUNT(CASE WHEN fog_risk_flag = TRUE OR hydrogen_sulfide_risk_flag = TRUE OR root_intrusion_flag = TRUE THEN 1 END)
      comment: "Number of segments with at least one active risk flag (FOG, H2S, root intrusion). Drives targeted maintenance and inspection prioritization."
    - name: "avg_slope_percent"
      expr: AVG(CAST(slope_percent AS DOUBLE))
      comment: "Average pipe slope percentage across the network. Low slope segments are prone to solids deposition and blockages, informing maintenance scheduling."
    - name: "total_peak_flow_gpm"
      expr: SUM(CAST(peak_flow_gpm AS DOUBLE))
      comment: "Total peak flow capacity across all sewer segments in GPM. Used for wet-weather capacity planning and SSO risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_industrial_user_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pretreatment program KPIs for industrial user permits. Used by pretreatment coordinators and compliance managers to monitor permit status, pollutant limit stringency, and industrial discharge risk to the collection system and WWTP."
  source: "`vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the industrial user permit (e.g., Active, Expired, Revoked) for compliance tracking."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of industrial user permit (e.g., Significant Industrial User, Minor Industrial User) for regulatory classification."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit for multi-jurisdiction pretreatment program management."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry code of the permitted facility for industrial sector risk analysis."
    - name: "categorical_standard_applicable"
      expr: categorical_standard_applicable
      comment: "Flag indicating whether a federal categorical pretreatment standard applies, indicating higher regulatory scrutiny."
    - name: "pretreatment_required"
      expr: pretreatment_required
      comment: "Flag indicating whether on-site pretreatment is required before discharge."
    - name: "compliance_schedule_required"
      expr: compliance_schedule_required
      comment: "Flag indicating whether a compliance schedule is in place, signaling known non-compliance."
    - name: "inspection_frequency"
      expr: inspection_frequency
      comment: "Required inspection frequency for the industrial user, used to manage inspection workload and compliance assurance."
  measures:
    - name: "total_permit_count"
      expr: COUNT(1)
      comment: "Total number of industrial user permits. Baseline pretreatment program scale metric."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active industrial user permits. Tracks the active regulated industrial user population."
    - name: "expired_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'Expired' THEN 1 END)
      comment: "Number of expired industrial user permits. Expired permits represent unregulated discharge risk and regulatory program deficiencies."
    - name: "avg_flow_limit_gpd"
      expr: AVG(CAST(flow_limit_gpd AS DOUBLE))
      comment: "Average permitted flow limit in gallons per day across industrial users. Contextualizes hydraulic loading from industrial sources."
    - name: "avg_tss_limit_mg_per_l"
      expr: AVG(CAST(tss_limit_mg_per_l AS DOUBLE))
      comment: "Average permitted TSS limit in mg/L across industrial users. Benchmarks solids loading limits for WWTP protection."
    - name: "avg_mercury_limit_mg_per_l"
      expr: AVG(CAST(mercury_limit_mg_per_l AS DOUBLE))
      comment: "Average permitted mercury limit in mg/L. Mercury is a priority pollutant; limit stringency reflects receiving water quality requirements."
    - name: "categorical_standard_permit_count"
      expr: COUNT(CASE WHEN categorical_standard_applicable = TRUE THEN 1 END)
      comment: "Number of permits subject to federal categorical pretreatment standards. These users carry the highest regulatory compliance burden and enforcement risk."
    - name: "compliance_schedule_permit_count"
      expr: COUNT(CASE WHEN compliance_schedule_required = TRUE THEN 1 END)
      comment: "Number of industrial users on a compliance schedule. Indicates known non-compliance requiring active regulatory oversight."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_manhole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure condition and risk KPIs for the manhole asset inventory. Used by asset managers and field operations to prioritize inspection, rehabilitation, and I/I reduction investments."
  source: "`vibe_water_utilities_v1`.`wastewater`.`manhole`"
  dimensions:
    - name: "manhole_type"
      expr: manhole_type
      comment: "Type of manhole structure (e.g., Standard, Drop, Junction) for asset classification."
    - name: "manhole_status"
      expr: manhole_status
      comment: "Current operational status of the manhole (e.g., Active, Abandoned, Requires Repair)."
    - name: "ownership"
      expr: ownership
      comment: "Ownership of the manhole (Public/Private) for maintenance responsibility allocation."
    - name: "basin_code"
      expr: basin_code
      comment: "Drainage basin code for geographic and hydraulic segmentation of the collection system."
    - name: "inflow_infiltration_flag"
      expr: inflow_infiltration_flag
      comment: "Flag indicating known inflow and infiltration (I/I) at the manhole, used to prioritize I/I reduction programs."
    - name: "sso_history_flag"
      expr: sso_history_flag
      comment: "Flag indicating the manhole has a history of SSO events, used to prioritize high-risk asset rehabilitation."
    - name: "scada_monitored_flag"
      expr: scada_monitored_flag
      comment: "Flag indicating whether the manhole is monitored by SCADA, used to assess real-time monitoring coverage."
    - name: "confined_space_flag"
      expr: confined_space_flag
      comment: "Flag indicating confined space classification, relevant for worker safety compliance and inspection cost estimation."
  measures:
    - name: "total_manhole_count"
      expr: COUNT(1)
      comment: "Total number of manholes in the asset inventory. Baseline infrastructure scale metric."
    - name: "inflow_infiltration_manhole_count"
      expr: COUNT(CASE WHEN inflow_infiltration_flag = TRUE THEN 1 END)
      comment: "Number of manholes with known I/I issues. I/I increases treatment costs and SSO risk; this metric drives rehabilitation investment prioritization."
    - name: "sso_history_manhole_count"
      expr: COUNT(CASE WHEN sso_history_flag = TRUE THEN 1 END)
      comment: "Number of manholes with a history of SSO events. High-risk assets requiring priority inspection and rehabilitation."
    - name: "avg_depth_feet"
      expr: AVG(CAST(depth_feet AS DOUBLE))
      comment: "Average manhole depth in feet. Deeper manholes have higher inspection and maintenance costs, informing O&M budget planning."
    - name: "scada_monitored_manhole_count"
      expr: COUNT(CASE WHEN scada_monitored_flag = TRUE THEN 1 END)
      comment: "Number of manholes with SCADA monitoring. Tracks real-time monitoring coverage for early SSO detection and operational response."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average manhole diameter in inches. Informs access equipment requirements and rehabilitation method selection."
$$;