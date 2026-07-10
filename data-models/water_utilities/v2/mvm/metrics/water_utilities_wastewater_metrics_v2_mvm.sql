-- Metric views for domain: wastewater | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_collection_system_blockage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for sewer collection system blockage events. Supports executive oversight of SSO risk, response performance, clearance efficiency, and cost exposure across the collection network."
  source: "`vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`"
  dimensions:
    - name: "blockage_cause"
      expr: blockage_cause
      comment: "Root cause category of the blockage (e.g., grease, roots, debris) — used to prioritize prevention programs."
    - name: "blockage_severity"
      expr: blockage_severity
      comment: "Severity classification of the blockage event — drives urgency of response and resource allocation."
    - name: "blockage_type"
      expr: blockage_type
      comment: "Type of blockage (e.g., partial, full) — informs clearance method selection and capacity risk."
    - name: "clearance_method"
      expr: clearance_method
      comment: "Method used to clear the blockage (e.g., hydro-jetting, rodding) — supports equipment and crew planning."
    - name: "basin_code"
      expr: basin_code
      comment: "Drainage basin identifier — enables geographic clustering of blockage hotspots."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather at time of blockage — used to correlate rainfall-driven infiltration/inflow with blockage frequency."
    - name: "repeat_blockage_flag"
      expr: repeat_blockage_flag
      comment: "Indicates whether this location has experienced prior blockages — key signal for targeted rehabilitation."
    - name: "sso_occurred_flag"
      expr: sso_occurred_flag
      comment: "Indicates whether the blockage resulted in a sanitary sewer overflow — critical regulatory and environmental dimension."
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Indicates whether the blockage caused customer service disruption — links operational events to customer experience."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the blockage caused an environmental impact — drives regulatory notification and remediation tracking."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Flags events requiring regulatory notification — essential for compliance monitoring and reporting."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of blockage event — enables trend analysis and seasonal pattern detection."
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year of blockage event — supports annual performance benchmarking."
  measures:
    - name: "total_blockage_events"
      expr: COUNT(1)
      comment: "Total number of blockage events recorded. Baseline volume metric for trend monitoring and resource planning."
    - name: "sso_event_count"
      expr: COUNT(CASE WHEN sso_occurred_flag = TRUE THEN 1 END)
      comment: "Number of blockage events that resulted in a sanitary sewer overflow. Directly tied to regulatory compliance risk and penalty exposure."
    - name: "repeat_blockage_count"
      expr: COUNT(CASE WHEN repeat_blockage_flag = TRUE THEN 1 END)
      comment: "Number of blockages at locations with prior blockage history. High repeat rates signal need for targeted pipe rehabilitation investment."
    - name: "total_sso_volume_gallons"
      expr: SUM(CAST(sso_volume_gallons AS DOUBLE))
      comment: "Total volume of sanitary sewer overflow in gallons. Key environmental and regulatory KPI — directly informs permit compliance status."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time from blockage report to crew response. Measures operational responsiveness and adherence to service level targets."
    - name: "avg_clearance_time_minutes"
      expr: AVG(CAST(clearance_time_minutes AS DOUBLE))
      comment: "Average time to clear a blockage after crew arrival. Indicates crew efficiency and complexity of blockage events."
    - name: "avg_total_duration_minutes"
      expr: AVG(CAST(total_duration_minutes AS DOUBLE))
      comment: "Average end-to-end duration of a blockage event from discovery to resolution. Composite measure of response and clearance efficiency."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of blockage events. Drives budget planning, cost-of-poor-quality analysis, and rehabilitation ROI calculations."
    - name: "avg_estimated_cost_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average cost per blockage event. Benchmarks operational efficiency and supports cost-per-event trend analysis."
    - name: "avg_rainfall_amount_inches"
      expr: AVG(CAST(rainfall_amount_inches AS DOUBLE))
      comment: "Average rainfall at time of blockage events. Quantifies the correlation between wet weather and blockage frequency for I/I analysis."
    - name: "customer_impacted_event_count"
      expr: COUNT(CASE WHEN customer_impact_flag = TRUE THEN 1 END)
      comment: "Number of blockage events with confirmed customer impact. Directly linked to customer satisfaction scores and service reliability KPIs."
    - name: "regulatory_notification_event_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of blockage events requiring regulatory notification. Tracks compliance obligation volume and associated administrative burden."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for sanitary sewer overflow (SSO) events. Supports executive oversight of environmental compliance, regulatory penalty exposure, overflow volume trends, and corrective action effectiveness."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sso_event`"
  dimensions:
    - name: "cause_category"
      expr: cause_category
      comment: "High-level cause category of the SSO (e.g., blockage, capacity, structural) — drives prevention investment prioritization."
    - name: "cause_code"
      expr: cause_code
      comment: "Specific cause code for the SSO — supports detailed root cause analysis and regulatory reporting."
    - name: "overflow_location_type"
      expr: overflow_location_type
      comment: "Type of location where overflow occurred (e.g., manhole, cleanout, building) — informs infrastructure risk mapping."
    - name: "receiving_environment"
      expr: receiving_environment
      comment: "Environment receiving the overflow (e.g., storm drain, surface water, ground) — determines environmental severity and regulatory response."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the SSO event (e.g., open, closed, under investigation) — tracks resolution progress."
    - name: "weather_related"
      expr: weather_related
      comment: "Indicates whether the SSO was weather-related — used to separate wet-weather vs. dry-weather SSO trends for capacity planning."
    - name: "reached_surface_water"
      expr: reached_surface_water
      comment: "Indicates whether overflow reached a surface water body — highest-severity environmental impact flag for regulatory escalation."
    - name: "public_notification_required"
      expr: public_notification_required
      comment: "Indicates whether public notification was required — tracks compliance with public health notification obligations."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Indicates whether regulatory agency notification was required — core compliance tracking dimension."
    - name: "dmr_reported"
      expr: dmr_reported
      comment: "Indicates whether the SSO was reported on a Discharge Monitoring Report — tracks DMR compliance completeness."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "Reporting period for DMR submission — enables period-over-period regulatory compliance comparison."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month of SSO event start — enables monthly trend analysis and seasonal pattern identification."
    - name: "event_year"
      expr: YEAR(event_start_timestamp)
      comment: "Year of SSO event — supports annual regulatory reporting and year-over-year performance benchmarking."
  measures:
    - name: "total_sso_events"
      expr: COUNT(1)
      comment: "Total number of SSO events. Primary regulatory KPI — regulators and executives track SSO frequency as a core system performance indicator."
    - name: "surface_water_sso_count"
      expr: COUNT(CASE WHEN reached_surface_water = TRUE THEN 1 END)
      comment: "Number of SSO events that reached surface water. Highest-severity environmental impact metric — directly drives regulatory enforcement risk."
    - name: "total_estimated_volume_gallons"
      expr: SUM(CAST(estimated_volume_gallons AS DOUBLE))
      comment: "Total estimated volume of all SSO discharges in gallons. Core environmental KPI reported to regulators and used for permit compliance assessment."
    - name: "total_volume_recovered_gallons"
      expr: SUM(CAST(volume_recovered_gallons AS DOUBLE))
      comment: "Total volume of SSO discharge recovered/contained in gallons. Measures effectiveness of emergency response and spill containment operations."
    - name: "avg_sso_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of SSO events in minutes. Longer durations indicate slower detection or response — drives investment in SCADA and monitoring."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalty amounts assessed for SSO events. Direct financial risk KPI — tracked by CFO and compliance leadership."
    - name: "avg_penalty_amount_usd"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty per SSO event. Benchmarks penalty severity and informs cost-benefit analysis of prevention investments."
    - name: "weather_related_sso_count"
      expr: COUNT(CASE WHEN weather_related = TRUE THEN 1 END)
      comment: "Number of SSOs attributed to weather events. Quantifies wet-weather capacity risk and supports capital planning for I/I reduction."
    - name: "avg_rainfall_at_sso_inches"
      expr: AVG(CAST(rainfall_amount_inches AS DOUBLE))
      comment: "Average rainfall amount at time of SSO events. Establishes rainfall thresholds that trigger overflows — informs capacity upgrade triggers."
    - name: "distinct_sso_locations"
      expr: COUNT(DISTINCT manhole_id)
      comment: "Number of distinct manhole locations with SSO events. Identifies geographic concentration of overflow risk for targeted infrastructure investment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_effluent_discharge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and operational KPIs for effluent discharge events at wastewater treatment plants. Supports executive oversight of permit compliance, discharge volume, violation frequency, and DMR reporting obligations."
  source: "`vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event`"
  dimensions:
    - name: "discharge_type"
      expr: discharge_type
      comment: "Type of discharge event (e.g., permitted, bypass, emergency) — determines regulatory treatment and reporting requirements."
    - name: "discharge_status"
      expr: discharge_status
      comment: "Current status of the discharge event — tracks open vs. resolved discharge incidents."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the discharge event relative to permit limits — core regulatory KPI dimension."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Indicates whether the discharge event constitutes a permit violation — primary compliance risk flag."
    - name: "treatment_level_achieved"
      expr: treatment_level_achieved
      comment: "Level of treatment achieved during the discharge event — measures treatment process effectiveness."
    - name: "receiving_water_body_classification"
      expr: receiving_water_body_classification
      comment: "Classification of the receiving water body — determines applicable permit limits and environmental sensitivity."
    - name: "bypass_reason_code"
      expr: bypass_reason_code
      comment: "Reason code for bypass events — supports root cause analysis of treatment bypass incidents."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during discharge — used to correlate wet-weather events with bypass frequency."
    - name: "dmr_submitted_flag"
      expr: dmr_submitted_flag
      comment: "Indicates whether the Discharge Monitoring Report was submitted — tracks DMR compliance completeness."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period — enables period-over-period compliance comparison."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_start_timestamp)
      comment: "Month of discharge event start — enables monthly trend analysis of discharge volumes and violations."
    - name: "discharge_year"
      expr: YEAR(discharge_start_timestamp)
      comment: "Year of discharge event — supports annual permit compliance reporting."
  measures:
    - name: "total_discharge_events"
      expr: COUNT(1)
      comment: "Total number of effluent discharge events. Baseline volume metric for permit compliance tracking and operational reporting."
    - name: "violation_event_count"
      expr: COUNT(CASE WHEN violation_flag = TRUE THEN 1 END)
      comment: "Number of discharge events with permit violations. Core regulatory compliance KPI — directly tied to enforcement risk and permit renewal outcomes."
    - name: "total_discharge_volume_mgd"
      expr: SUM(CAST(discharge_volume_mgd AS DOUBLE))
      comment: "Total effluent discharge volume in million gallons per day. Tracks permitted discharge utilization and capacity headroom against permit limits."
    - name: "avg_discharge_flow_rate_gpm"
      expr: AVG(CAST(discharge_flow_rate_gpm AS DOUBLE))
      comment: "Average discharge flow rate in gallons per minute. Benchmarks treatment plant throughput against design capacity."
    - name: "avg_discharge_duration_hours"
      expr: AVG(CAST(discharge_duration_hours AS DOUBLE))
      comment: "Average duration of discharge events in hours. Longer durations may indicate operational issues or capacity constraints."
    - name: "total_rainfall_at_discharge_inches"
      expr: SUM(CAST(rainfall_amount_inches AS DOUBLE))
      comment: "Total rainfall associated with discharge events. Quantifies wet-weather contribution to discharge volume for I/I and capacity planning."
    - name: "dmr_submitted_count"
      expr: COUNT(CASE WHEN dmr_submitted_flag = TRUE THEN 1 END)
      comment: "Number of discharge events with DMR submitted. Tracks regulatory reporting compliance — missing DMRs are a direct permit violation."
    - name: "distinct_wwtps_with_violations"
      expr: COUNT(DISTINCT CASE WHEN violation_flag = TRUE THEN wwtp_id END)
      comment: "Number of distinct WWTPs with at least one discharge violation. Identifies facilities requiring compliance intervention or capital investment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_effluent_parameter_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analytical KPIs for effluent parameter test results. Supports compliance officers and plant managers in tracking permit limit exceedances, mass loading trends, and laboratory data quality across discharge monitoring programs."
  source: "`vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the parameter result relative to permit limits — primary regulatory classification dimension."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., grab, composite) — affects regulatory validity and comparability of results."
    - name: "analysis_method"
      expr: analysis_method
      comment: "Analytical method used for parameter measurement — ensures method-appropriate comparison of results."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the parameter result — required for correct interpretation and comparison against permit limits."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period for the result — enables period-over-period compliance trend analysis."
    - name: "dmr_submission_status"
      expr: dmr_submission_status
      comment: "Status of DMR submission for this result — tracks regulatory reporting completeness."
    - name: "data_validation_status"
      expr: data_validation_status
      comment: "Validation status of the laboratory result — ensures only validated data is used in compliance determinations."
    - name: "quality_control_flag"
      expr: quality_control_flag
      comment: "Indicates whether the result has a quality control issue — flags data requiring review before regulatory use."
    - name: "result_qualifier"
      expr: result_qualifier
      comment: "Qualifier code for the result (e.g., estimated, below detection) — provides context for regulatory interpretation."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency overseeing this parameter result — enables agency-specific compliance reporting."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', CAST(analysis_date AS TIMESTAMP))
      comment: "Month of analysis — enables monthly trend analysis of parameter compliance rates."
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year of analysis — supports annual permit compliance reporting and trend benchmarking."
  measures:
    - name: "total_parameter_results"
      expr: COUNT(1)
      comment: "Total number of effluent parameter results. Baseline measure for monitoring program completeness and sampling frequency compliance."
    - name: "exceedance_result_count"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Number of parameter results exceeding permit limits. Core compliance KPI — directly drives regulatory enforcement and permit renewal risk."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceed permit limits. Quantifies severity of non-compliance — high values indicate systemic treatment deficiencies."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum exceedance percentage observed. Identifies worst-case compliance events for regulatory escalation and root cause investigation."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value. Tracks central tendency of effluent quality over time — used to assess treatment process stability."
    - name: "total_mass_loading_lbs_per_day"
      expr: SUM(CAST(mass_loading_lbs_per_day AS DOUBLE))
      comment: "Total mass loading of parameters in pounds per day. Tracks pollutant load discharged to receiving waters — key environmental impact metric."
    - name: "avg_mass_loading_lbs_per_day"
      expr: AVG(CAST(mass_loading_lbs_per_day AS DOUBLE))
      comment: "Average daily mass loading per result. Benchmarks typical pollutant loading against permit mass-based limits."
    - name: "avg_flow_rate_mgd"
      expr: AVG(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Average flow rate at time of sampling in MGD. Contextualizes parameter concentrations within hydraulic loading conditions."
    - name: "qc_flagged_result_count"
      expr: COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END)
      comment: "Number of results with quality control flags. Tracks laboratory data quality issues that could invalidate compliance determinations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_wwtp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic asset and capacity KPIs for wastewater treatment plants. Supports capital planning, compliance oversight, and operational benchmarking across the WWTP portfolio."
  source: "`vibe_water_utilities_v1`.`wastewater`.`wwtp`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the WWTP (e.g., active, offline, decommissioned) — drives asset availability and capacity planning."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the WWTP — primary regulatory risk dimension for executive oversight."
    - name: "treatment_level"
      expr: treatment_level
      comment: "Level of treatment provided (e.g., primary, secondary, tertiary) — determines applicable permit limits and upgrade investment needs."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of wastewater treatment facility — enables portfolio segmentation for benchmarking and capital planning."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Disinfection technology used (e.g., chlorination, UV) — informs chemical cost benchmarking and technology upgrade planning."
    - name: "biosolids_management_method"
      expr: biosolids_management_method
      comment: "Method used to manage biosolids (e.g., land application, landfill) — drives biosolids program cost and regulatory compliance."
    - name: "biosolids_class"
      expr: biosolids_class
      comment: "Class of biosolids produced (Class A or Class B) — determines allowable reuse options and regulatory requirements."
    - name: "receiving_water_classification"
      expr: receiving_water_classification
      comment: "Classification of the receiving water body — determines stringency of applicable effluent limits."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the WWTP is located — enables geographic portfolio analysis and regulatory jurisdiction grouping."
    - name: "operator_certification_level"
      expr: operator_certification_level
      comment: "Certification level of the plant operator — tracks workforce compliance with regulatory operator certification requirements."
  measures:
    - name: "total_wwtp_count"
      expr: COUNT(1)
      comment: "Total number of wastewater treatment plants in the portfolio. Baseline asset inventory metric for capacity and compliance program planning."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total permitted design treatment capacity in MGD across all WWTPs. Defines the system-wide treatment ceiling for growth and capacity planning."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total average daily flow across all WWTPs in MGD. Measures actual system-wide hydraulic loading — compared against design capacity to assess headroom."
    - name: "avg_capacity_utilization_pct"
      expr: AVG(ROUND(100.0 * CAST(average_daily_flow_mgd AS DOUBLE) / NULLIF(CAST(design_capacity_mgd AS DOUBLE), 0), 2))
      comment: "Average capacity utilization percentage per WWTP (actual flow / design capacity). Identifies plants approaching capacity limits requiring capital expansion."
    - name: "total_peak_flow_mgd"
      expr: SUM(CAST(peak_flow_mgd AS DOUBLE))
      comment: "Total peak flow capacity across all WWTPs in MGD. Measures wet-weather hydraulic capacity — critical for SSO prevention and permit compliance."
    - name: "avg_energy_consumption_kwh_per_mg"
      expr: AVG(CAST(energy_consumption_kwh_per_mg AS DOUBLE))
      comment: "Average energy consumption in kWh per million gallons treated. Benchmarks energy efficiency across the WWTP portfolio — drives energy reduction programs."
    - name: "non_compliant_wwtp_count"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Number of WWTPs with non-compliant status. Tracks facilities at regulatory risk — drives prioritization of compliance improvement investments."
    - name: "operator_cert_required_count"
      expr: COUNT(CASE WHEN operator_certification_required = TRUE THEN 1 END)
      comment: "Number of WWTPs requiring certified operators. Tracks workforce certification compliance obligations across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewer_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset condition, capacity, and risk KPIs for the sewer pipe network. Supports capital planning, rehabilitation prioritization, and operational risk management across the collection system infrastructure."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewer_network`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the sewer segment (e.g., active, abandoned, under repair) — drives asset availability and maintenance planning."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of sewer segment (e.g., gravity main, force main, interceptor) — enables type-specific capacity and risk analysis."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade of the sewer segment from inspection — primary driver of rehabilitation prioritization and capital planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the segment (e.g., public, private) — determines maintenance responsibility and capital investment eligibility."
    - name: "lining_type"
      expr: lining_type
      comment: "Type of pipe lining applied — tracks rehabilitation coverage and informs future lining program planning."
    - name: "fog_risk_flag"
      expr: fog_risk_flag
      comment: "Indicates segments at risk of fats, oils, and grease accumulation — drives targeted FOG inspection and cleaning programs."
    - name: "hydrogen_sulfide_risk_flag"
      expr: hydrogen_sulfide_risk_flag
      comment: "Indicates segments at risk of hydrogen sulfide corrosion — drives corrosion protection investment and safety protocols."
    - name: "root_intrusion_flag"
      expr: root_intrusion_flag
      comment: "Indicates segments with root intrusion — drives targeted root control and pipe rehabilitation programs."
    - name: "traffic_impact_level"
      expr: traffic_impact_level
      comment: "Level of traffic impact for maintenance access — informs scheduling and cost estimation for rehabilitation projects."
    - name: "installation_year"
      expr: installation_year
      comment: "Year of pipe installation — enables age-based risk segmentation and end-of-life replacement planning."
  measures:
    - name: "total_pipe_segments"
      expr: COUNT(1)
      comment: "Total number of sewer pipe segments in the network. Baseline asset inventory metric for network coverage and maintenance program sizing."
    - name: "total_network_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of sewer network in feet. Defines the physical scale of the collection system — drives maintenance crew sizing and inspection program scope."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total hydraulic design capacity of the sewer network in MGD. Measures system-wide capacity headroom against current and projected flows."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total average daily flow through the sewer network in MGD. Tracks actual hydraulic loading — compared against design capacity to identify capacity-constrained segments."
    - name: "avg_slope_percent"
      expr: AVG(CAST(slope_percent AS DOUBLE))
      comment: "Average pipe slope percentage across the network. Low slope segments are prone to solids deposition and blockages — informs targeted cleaning programs."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total estimated replacement cost of the sewer network in USD. Quantifies the capital asset value at risk — essential for asset management and rate-setting decisions."
    - name: "fog_risk_segment_count"
      expr: COUNT(CASE WHEN fog_risk_flag = TRUE THEN 1 END)
      comment: "Number of sewer segments flagged as FOG risk. Drives the scope and budget of fats, oils, and grease control programs."
    - name: "h2s_risk_segment_count"
      expr: COUNT(CASE WHEN hydrogen_sulfide_risk_flag = TRUE THEN 1 END)
      comment: "Number of segments at hydrogen sulfide corrosion risk. Quantifies corrosion exposure across the network — informs corrosion protection investment prioritization."
    - name: "avg_peak_flow_gpm"
      expr: AVG(CAST(peak_flow_gpm AS DOUBLE))
      comment: "Average peak flow rate in gallons per minute across network segments. Benchmarks wet-weather hydraulic stress — identifies segments most vulnerable to SSO during storm events."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewer_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection program performance and asset condition KPIs for sewer infrastructure. Supports asset managers and compliance officers in tracking inspection coverage, defect rates, rehabilitation needs, and program cost exposure."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewer_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., CCTV, visual, smoke test) — enables method-specific performance analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Specific inspection method used — supports technology benchmarking and method effectiveness analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection record (e.g., complete, pending review) — tracks program completion and backlog."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Overall condition grade assigned from inspection — primary driver of rehabilitation prioritization."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency classification for recommended action — drives work order prioritization and emergency response planning."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended remediation action from inspection — informs rehabilitation program scope and budget."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the inspected pipe — enables material-specific failure rate analysis and replacement planning."
    - name: "structural_defect_flag"
      expr: structural_defect_flag
      comment: "Indicates presence of structural defects — highest-priority rehabilitation trigger for asset integrity management."
    - name: "critical_defect_flag"
      expr: critical_defect_flag
      comment: "Indicates presence of critical defects requiring immediate action — drives emergency work order generation."
    - name: "root_intrusion_flag"
      expr: root_intrusion_flag
      comment: "Indicates root intrusion observed during inspection — drives root control treatment program targeting."
    - name: "infiltration_observed_flag"
      expr: infiltration_observed_flag
      comment: "Indicates infiltration observed during inspection — quantifies I/I contribution points for flow reduction programs."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', CAST(inspection_date AS TIMESTAMP))
      comment: "Month of inspection — enables monthly inspection program throughput tracking."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection — supports annual inspection program coverage reporting."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of sewer inspections completed. Baseline measure for inspection program throughput and coverage tracking."
    - name: "critical_defect_inspection_count"
      expr: COUNT(CASE WHEN critical_defect_flag = TRUE THEN 1 END)
      comment: "Number of inspections identifying critical defects. Directly drives emergency rehabilitation work orders and capital budget prioritization."
    - name: "structural_defect_inspection_count"
      expr: COUNT(CASE WHEN structural_defect_flag = TRUE THEN 1 END)
      comment: "Number of inspections identifying structural defects. Quantifies structural rehabilitation backlog — key input to capital improvement program planning."
    - name: "infiltration_observed_count"
      expr: COUNT(CASE WHEN infiltration_observed_flag = TRUE THEN 1 END)
      comment: "Number of inspections with observed infiltration. Quantifies I/I entry points — drives targeted rehabilitation to reduce wet-weather flow and SSO risk."
    - name: "total_inspection_length_feet"
      expr: SUM(CAST(inspection_length_feet AS DOUBLE))
      comment: "Total length of sewer pipe inspected in feet. Measures inspection program coverage — compared against total network length to track inspection completeness."
    - name: "avg_pipe_diameter_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average diameter of inspected pipes in inches. Contextualizes inspection program scope and informs capacity analysis."
    - name: "total_estimated_repair_cost_usd"
      expr: SUM(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Total estimated repair cost identified through inspections in USD. Quantifies the rehabilitation liability discovered — essential for capital improvement program budgeting."
    - name: "avg_estimated_repair_cost_usd"
      expr: AVG(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Average estimated repair cost per inspection. Benchmarks per-segment rehabilitation cost — informs unit cost assumptions for capital planning."
    - name: "root_intrusion_inspection_count"
      expr: COUNT(CASE WHEN root_intrusion_flag = TRUE THEN 1 END)
      comment: "Number of inspections with root intrusion observed. Quantifies root intrusion prevalence — drives root control chemical treatment program scope and budget."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_industrial_user_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pretreatment program KPIs for industrial user permits. Supports compliance managers in tracking permit status, pollutant limit coverage, pretreatment requirements, and inspection frequency across the industrial pretreatment program."
  source: "`vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the industrial user permit (e.g., active, expired, revoked) — primary compliance program management dimension."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of industrial user permit (e.g., significant industrial user, minor) — determines monitoring and reporting obligations."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry classification code — enables industry-sector analysis of pretreatment compliance performance."
    - name: "sic_code"
      expr: sic_code
      comment: "SIC industry classification code — supports categorical standard applicability analysis."
    - name: "pretreatment_required"
      expr: pretreatment_required
      comment: "Indicates whether pretreatment is required — tracks pretreatment program coverage across industrial users."
    - name: "categorical_standard_applicable"
      expr: categorical_standard_applicable
      comment: "Indicates whether a federal categorical pretreatment standard applies — determines regulatory stringency of permit limits."
    - name: "compliance_schedule_required"
      expr: compliance_schedule_required
      comment: "Indicates whether a compliance schedule is required — tracks industrial users under active compliance improvement programs."
    - name: "inspection_frequency"
      expr: inspection_frequency
      comment: "Required inspection frequency for the industrial user — drives inspection program scheduling and resource planning."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency for the industrial user — determines sampling program scope and laboratory cost."
    - name: "permit_expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year of permit expiration — enables proactive permit renewal planning and workload forecasting."
  measures:
    - name: "total_industrial_user_permits"
      expr: COUNT(1)
      comment: "Total number of industrial user permits in the pretreatment program. Baseline measure for program scale and compliance oversight workload."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active industrial user permits. Tracks the active compliance monitoring universe — drives inspection and sampling program sizing."
    - name: "pretreatment_required_count"
      expr: COUNT(CASE WHEN pretreatment_required = TRUE THEN 1 END)
      comment: "Number of industrial users required to have pretreatment systems. Quantifies the pretreatment program scope — informs inspection staffing and technical assistance needs."
    - name: "avg_flow_limit_gpd"
      expr: AVG(CAST(flow_limit_gpd AS DOUBLE))
      comment: "Average permitted discharge flow limit in gallons per day. Benchmarks hydraulic loading allowances across the industrial user portfolio."
    - name: "total_flow_limit_gpd"
      expr: SUM(CAST(flow_limit_gpd AS DOUBLE))
      comment: "Total permitted industrial discharge flow in gallons per day. Quantifies the aggregate hydraulic and pollutant loading capacity allocated to industrial users."
    - name: "avg_bod_limit_mg_per_l"
      expr: AVG(CAST(bod_limit_mg_per_l AS DOUBLE))
      comment: "Average BOD permit limit in mg/L across industrial users. Benchmarks organic loading limits — informs WWTP treatment capacity planning."
    - name: "avg_tss_limit_mg_per_l"
      expr: AVG(CAST(tss_limit_mg_per_l AS DOUBLE))
      comment: "Average TSS permit limit in mg/L across industrial users. Benchmarks solids loading limits — informs WWTP solids handling capacity planning."
    - name: "compliance_schedule_required_count"
      expr: COUNT(CASE WHEN compliance_schedule_required = TRUE THEN 1 END)
      comment: "Number of industrial users under a compliance schedule. Tracks the volume of active compliance improvement cases requiring regulatory oversight."
    - name: "categorical_standard_permit_count"
      expr: COUNT(CASE WHEN categorical_standard_applicable = TRUE THEN 1 END)
      comment: "Number of permits subject to federal categorical pretreatment standards. Quantifies the most stringently regulated industrial users in the program."
$$;