-- Metric views for domain: wastewater | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_wwtp_operations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capacity metrics for wastewater treatment plants. Supports executive decisions on capacity planning, compliance posture, and capital investment prioritization."
  source: "`vibe_water_utilities_v1`.`wastewater`.`wwtp`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of wastewater treatment facility (e.g., activated sludge, lagoon, MBR) for benchmarking across facility classes."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the WWTP (e.g., active, offline, decommissioned) for filtering active vs. inactive assets."
    - name: "treatment_level"
      expr: treatment_level
      comment: "Level of treatment achieved (primary, secondary, tertiary/advanced) for regulatory and capacity analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current NPDES compliance status of the facility for regulatory risk dashboards."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the facility for multi-jurisdictional reporting."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Disinfection technology used (chlorination, UV, ozone) for operational benchmarking."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the WWTP is located for geographic performance analysis."
  measures:
    - name: "total_wwtp_count"
      expr: COUNT(1)
      comment: "Total number of wastewater treatment plants. Baseline for capacity and compliance portfolio analysis."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total permitted design treatment capacity in million gallons per day across all WWTPs. Critical for regional capacity planning and growth management decisions."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total actual average daily flow treated across all WWTPs in MGD. Compared against design capacity to assess system-wide utilization."
    - name: "avg_capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_flow_mgd AS DOUBLE) / NULLIF(CAST(design_capacity_mgd AS DOUBLE), 0)), 2)
      comment: "Average capacity utilization percentage across WWTPs. A value above 80% signals near-capacity conditions requiring capital investment; below 50% may indicate over-built infrastructure."
    - name: "total_peak_flow_mgd"
      expr: SUM(CAST(peak_flow_mgd AS DOUBLE))
      comment: "Total peak flow capacity across all WWTPs in MGD. Used for wet-weather planning and SSO/CSO risk assessment."
    - name: "avg_energy_consumption_kwh_per_mg"
      expr: AVG(CAST(energy_consumption_kwh_per_mg AS DOUBLE))
      comment: "Average energy intensity in kWh per million gallons treated. Key sustainability and cost-efficiency KPI; benchmarks against industry standard of 1,000-2,000 kWh/MG."
    - name: "compliant_wwtp_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of WWTPs currently in NPDES compliance. Directly informs regulatory risk exposure and enforcement action probability."
    - name: "non_compliant_wwtp_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of WWTPs currently out of NPDES compliance. Triggers immediate executive attention and regulatory response planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanitary sewer overflow event metrics for regulatory compliance, environmental risk management, and capital investment prioritization. SSOs are a primary regulatory and public health risk for wastewater utilities."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sso_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the SSO event (e.g., open, closed, under investigation) for active incident management."
    - name: "cause_category"
      expr: cause_category
      comment: "Root cause category of the SSO (e.g., blockage, capacity, structural failure) for targeted infrastructure investment decisions."
    - name: "overflow_location_type"
      expr: overflow_location_type
      comment: "Type of location where overflow occurred (manhole, cleanout, building backup) for asset-specific remediation planning."
    - name: "receiving_environment"
      expr: receiving_environment
      comment: "Environment receiving the overflow (surface water, storm drain, ground) for environmental impact severity classification."
    - name: "weather_related"
      expr: CAST(weather_related AS STRING)
      comment: "Whether the SSO was weather-related (wet weather vs. dry weather). Drives different capital improvement strategies."
    - name: "regulatory_notification_required"
      expr: CAST(regulatory_notification_required AS STRING)
      comment: "Whether regulatory notification was required, indicating reportable SSO events subject to enforcement."
    - name: "public_notification_required"
      expr: CAST(public_notification_required AS STRING)
      comment: "Whether public notification was required, indicating events with potential public health impact."
    - name: "reached_surface_water"
      expr: CAST(reached_surface_water AS STRING)
      comment: "Whether overflow reached a surface water body — the highest-severity environmental impact classification."
  measures:
    - name: "total_sso_events"
      expr: COUNT(1)
      comment: "Total number of SSO events. Primary regulatory KPI reported to EPA and state agencies; directly tied to enforcement risk."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(estimated_volume_gallons AS DOUBLE))
      comment: "Total estimated volume of sewage overflowed in gallons. Key environmental impact metric and regulatory reporting requirement."
    - name: "total_volume_recovered_gallons"
      expr: SUM(CAST(volume_recovered_gallons AS DOUBLE))
      comment: "Total volume of overflow recovered/contained in gallons. Measures effectiveness of emergency response operations."
    - name: "avg_event_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of SSO events in minutes. Longer durations indicate slower detection or response — drives investment in SCADA and monitoring."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties assessed for SSO events in USD. Direct financial impact metric for executive and board reporting."
    - name: "surface_water_impact_event_count"
      expr: COUNT(CASE WHEN reached_surface_water = TRUE THEN 1 END)
      comment: "Number of SSO events that reached surface water bodies. Highest-severity environmental impact category requiring immediate regulatory response."
    - name: "weather_related_sso_count"
      expr: COUNT(CASE WHEN weather_related = TRUE THEN 1 END)
      comment: "Number of SSOs attributable to wet weather events. Drives investment in I&I reduction programs and green infrastructure."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(UNIX_TIMESTAMP(response_timestamp) - UNIX_TIMESTAMP(discovery_timestamp) AS DOUBLE) / 60.0)
      comment: "Average time from SSO discovery to crew response in minutes. Operational efficiency KPI; faster response reduces overflow volume and environmental impact."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_cso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Combined sewer overflow event metrics for LTCP compliance tracking, environmental impact assessment, and capital program prioritization. CSOs are a major regulatory focus under EPA's CSO Policy."
  source: "`vibe_water_utilities_v1`.`wastewater`.`cso_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the CSO event for active incident management and regulatory reporting."
    - name: "cause_category"
      expr: cause_category
      comment: "Root cause category of the CSO event for LTCP investment targeting."
    - name: "receiving_water_body_classification"
      expr: receiving_water_body_classification
      comment: "Classification of the receiving water body (e.g., Class A, impaired) for environmental impact severity assessment."
    - name: "outfall_designation"
      expr: outfall_designation
      comment: "Regulatory outfall designation for permit-level compliance tracking."
    - name: "dmr_submitted"
      expr: CAST(dmr_submitted AS STRING)
      comment: "Whether the CSO event was reported on the DMR, indicating regulatory reporting compliance."
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether corrective action was required, flagging events needing follow-up capital or operational response."
    - name: "control_measure_active"
      expr: CAST(control_measure_active AS STRING)
      comment: "Whether an active control measure was in place during the event, for LTCP effectiveness evaluation."
  measures:
    - name: "total_cso_events"
      expr: COUNT(1)
      comment: "Total number of CSO events. Primary LTCP compliance metric reported to EPA; directly tied to consent decree milestones."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Total CSO overflow volume in gallons. Core environmental impact metric for LTCP progress reporting and permit compliance."
    - name: "total_overflow_volume_mgd"
      expr: SUM(CAST(overflow_volume_mgd AS DOUBLE))
      comment: "Total CSO overflow volume in million gallons per day equivalent. Used for permit limit comparison and DMR reporting."
    - name: "avg_event_duration_minutes"
      expr: AVG(CAST(event_duration_minutes AS DOUBLE))
      comment: "Average CSO event duration in minutes. Longer events indicate inadequate control measures or infrastructure deficiencies."
    - name: "avg_precipitation_amount_inches"
      expr: AVG(CAST(precipitation_amount_inches AS DOUBLE))
      comment: "Average precipitation depth triggering CSO events in inches. Used to calibrate design storm thresholds for LTCP infrastructure sizing."
    - name: "avg_bod_concentration_mg_l"
      expr: AVG(CAST(bod_concentration_mg_l AS DOUBLE))
      comment: "Average BOD concentration in CSO discharge in mg/L. Water quality impact metric for receiving water body assessment."
    - name: "avg_tss_concentration_mg_l"
      expr: AVG(CAST(tss_concentration_mg_l AS DOUBLE))
      comment: "Average TSS concentration in CSO discharge in mg/L. Sediment loading metric for receiving water quality compliance."
    - name: "events_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of CSO events requiring corrective action. Drives capital project prioritization and LTCP milestone tracking."
    - name: "avg_operator_response_time_minutes"
      expr: AVG(CAST(operator_response_time_minutes AS DOUBLE))
      comment: "Average operator response time to CSO events in minutes. Operational efficiency KPI; faster response reduces overflow volume and permit violations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_dmr_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Monitoring Report submission metrics for NPDES permit compliance tracking, regulatory timeliness, and enforcement risk management. DMR compliance is a primary regulatory obligation for all permitted WWTPs."
  source: "`vibe_water_utilities_v1`.`wastewater`.`dmr_submission`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the DMR submission for regulatory risk classification."
    - name: "submission_status"
      expr: submission_status
      comment: "Current submission status (e.g., submitted, accepted, rejected, pending) for workflow management."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of DMR submission (original, resubmission, amendment) for tracking correction patterns."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (NetDMR, paper, electronic) for modernization tracking."
    - name: "late_submission_flag"
      expr: CAST(late_submission_flag AS STRING)
      comment: "Whether the DMR was submitted late. Late submissions are a permit violation and trigger enforcement risk."
    - name: "enforcement_action_flag"
      expr: CAST(enforcement_action_flag AS STRING)
      comment: "Whether an enforcement action is associated with this DMR period."
    - name: "bypass_event_flag"
      expr: CAST(bypass_event_flag AS STRING)
      comment: "Whether a bypass event occurred during the reporting period, indicating a significant compliance event."
    - name: "no_discharge_flag"
      expr: CAST(no_discharge_flag AS STRING)
      comment: "Whether no discharge occurred during the reporting period (NODI submission)."
  measures:
    - name: "total_dmr_submissions"
      expr: COUNT(1)
      comment: "Total number of DMR submissions. Baseline for compliance portfolio tracking and regulatory reporting volume."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of DMRs submitted after the regulatory deadline. Each late submission is a permit violation; directly drives enforcement risk and penalty exposure."
    - name: "total_parameter_exceedances"
      expr: SUM(CAST(total_parameter_exceedances AS DOUBLE))
      comment: "Total number of permit parameter exceedances across all DMR submissions. Primary regulatory compliance KPI for NPDES permit management."
    - name: "avg_daily_flow_mgd"
      expr: AVG(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Average daily flow reported on DMRs in MGD. Tracks actual treatment load against permit limits over time."
    - name: "max_daily_flow_mgd"
      expr: MAX(CAST(maximum_daily_flow_mgd AS DOUBLE))
      comment: "Maximum daily flow reported across DMR submissions in MGD. Used for peak flow capacity planning and permit limit compliance."
    - name: "total_flow_volume_mg"
      expr: SUM(CAST(total_flow_volume_mg AS DOUBLE))
      comment: "Total flow volume treated and reported in million gallons. Cumulative throughput metric for operational and financial planning."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Number of DMR submissions rejected by the regulatory agency. Rejected submissions require resubmission and indicate data quality issues."
    - name: "enforcement_action_submission_count"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN 1 END)
      comment: "Number of DMR reporting periods associated with enforcement actions. Direct measure of regulatory enforcement exposure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_dmr_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Monitoring Report parameter-level result metrics for NPDES effluent limit compliance analysis. Enables permit parameter exceedance tracking, violation trend analysis, and enforcement risk quantification."
  source: "`vibe_water_utilities_v1`.`wastewater`.`dmr_result`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the monitored effluent parameter (e.g., BOD, TSS, ammonia) for parameter-specific compliance analysis."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Regulatory parameter code for cross-system compliance reporting and EPA ICIS-NPDES integration."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for each parameter result (compliant, exceedance, violation) for regulatory risk dashboards."
    - name: "permit_limit_type"
      expr: permit_limit_type
      comment: "Type of permit limit (daily maximum, monthly average, weekly average) for limit-specific compliance analysis."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of violation (e.g., TRC, SNC) for enforcement priority classification."
    - name: "exceedance_flag"
      expr: CAST(exceedance_flag AS STRING)
      comment: "Whether the result exceeded the permit limit, for filtering exceedance events."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (grab, composite, continuous) for data quality and method compliance analysis."
    - name: "statistical_base"
      expr: statistical_base
      comment: "Statistical basis for the reported value (daily max, monthly avg) for permit limit comparison."
  measures:
    - name: "total_results"
      expr: COUNT(1)
      comment: "Total number of DMR parameter results. Baseline for compliance monitoring coverage and data completeness assessment."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Total number of permit limit exceedances. Primary NPDES compliance KPI; each exceedance is a potential permit violation subject to enforcement."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceed permit limits. Severity indicator for enforcement prioritization; values above 20% typically trigger Significant Non-Compliance (SNC) designation."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum exceedance percentage observed. Identifies worst-case permit violations for immediate regulatory response."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured effluent parameter value. Tracks treatment performance trends against permit limits over time."
    - name: "avg_permit_limit_value"
      expr: AVG(CAST(permit_limit_value AS DOUBLE))
      comment: "Average permit limit value across results. Used as denominator context for compliance ratio calculations."
    - name: "enforcement_action_required_count"
      expr: COUNT(CASE WHEN enforcement_action_required = TRUE THEN 1 END)
      comment: "Number of results flagging enforcement action as required. Direct measure of regulatory enforcement pipeline and penalty exposure."
    - name: "data_quality_flagged_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Number of results with data quality flags. Data quality issues can invalidate DMR submissions and trigger regulatory scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_biosolids_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biosolids production and quality metrics for regulatory compliance (40 CFR Part 503), land application program management, and beneficial reuse optimization."
  source: "`vibe_water_utilities_v1`.`wastewater`.`biosolids_batch`"
  dimensions:
    - name: "pathogen_class"
      expr: pathogen_class
      comment: "Pathogen reduction class (Class A or Class B) determining allowable land application and reuse options. Class A commands premium beneficial reuse markets."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Biosolids treatment process type (anaerobic digestion, composting, thermal drying) for process performance benchmarking."
    - name: "disposition_method"
      expr: disposition_method
      comment: "Final disposition method (land application, landfill, incineration, beneficial reuse) for cost and sustainability analysis."
    - name: "exceptional_quality_flag"
      expr: CAST(exceptional_quality_flag AS STRING)
      comment: "Whether the batch meets Exceptional Quality (EQ) standards, enabling unrestricted beneficial reuse and premium market access."
    - name: "vector_attraction_reduction_method"
      expr: vector_attraction_reduction_method
      comment: "Method used for vector attraction reduction (VAR) compliance under 40 CFR 503."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of biosolids batches produced. Baseline for production volume tracking and regulatory reporting."
    - name: "total_dry_weight_tons"
      expr: SUM(CAST(dry_weight_tons AS DOUBLE))
      comment: "Total dry weight of biosolids produced in tons. Primary production volume metric for 503 annual reporting and land application program planning."
    - name: "total_wet_weight_tons"
      expr: SUM(CAST(wet_weight_tons AS DOUBLE))
      comment: "Total wet weight of biosolids produced in tons. Used for hauling cost estimation and disposal logistics planning."
    - name: "avg_percent_solids"
      expr: AVG(CAST(percent_solids AS DOUBLE))
      comment: "Average percent solids content of biosolids batches. Higher solids content reduces hauling costs and improves land application efficiency."
    - name: "avg_volatile_solids_reduction_pct"
      expr: AVG(CAST(volatile_solids_reduction_percent AS DOUBLE))
      comment: "Average volatile solids reduction percentage. Must meet 38% minimum for Class B or 83% for Class A under 40 CFR 503 — direct regulatory compliance metric."
    - name: "avg_total_nitrogen_pct"
      expr: AVG(CAST(total_nitrogen_percent AS DOUBLE))
      comment: "Average total nitrogen content percentage. Determines agronomic application rates and nutrient management plan requirements."
    - name: "exceptional_quality_batch_count"
      expr: COUNT(CASE WHEN exceptional_quality_flag = TRUE THEN 1 END)
      comment: "Number of batches meeting Exceptional Quality standards. EQ biosolids command higher beneficial reuse value and fewer land application restrictions."
    - name: "avg_fecal_coliform_density"
      expr: AVG(CAST(fecal_coliform_density_mpn_per_gram AS DOUBLE))
      comment: "Average fecal coliform density in MPN per gram. Must be below 1,000 MPN/g for Class B and below detection for Class A — direct 40 CFR 503 compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_collection_system_blockage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection system blockage metrics for infrastructure reliability management, SSO prevention, and maintenance program optimization. Blockages are a leading cause of SSOs and customer service failures."
  source: "`vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`"
  dimensions:
    - name: "blockage_type"
      expr: blockage_type
      comment: "Type of blockage (root intrusion, grease, debris, structural) for targeted maintenance program design."
    - name: "blockage_cause"
      expr: blockage_cause
      comment: "Root cause of the blockage for infrastructure investment prioritization and preventive maintenance scheduling."
    - name: "blockage_severity"
      expr: blockage_severity
      comment: "Severity classification of the blockage for response prioritization and resource allocation."
    - name: "clearance_method"
      expr: clearance_method
      comment: "Method used to clear the blockage (hydro-jetting, rodding, excavation) for cost and effectiveness benchmarking."
    - name: "sso_occurred_flag"
      expr: CAST(sso_occurred_flag AS STRING)
      comment: "Whether the blockage resulted in an SSO. Blockages causing SSOs are highest priority for preventive maintenance investment."
    - name: "repeat_blockage_flag"
      expr: CAST(repeat_blockage_flag AS STRING)
      comment: "Whether this is a repeat blockage at the same location. Repeat blockages indicate structural defects requiring capital rehabilitation."
    - name: "customer_impact_flag"
      expr: CAST(customer_impact_flag AS STRING)
      comment: "Whether the blockage caused customer impact (backups, service disruption) for customer satisfaction and liability tracking."
  measures:
    - name: "total_blockages"
      expr: COUNT(1)
      comment: "Total number of collection system blockages. Primary infrastructure reliability KPI; high blockage rates indicate aging infrastructure requiring capital investment."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of blockage response and clearance in USD. Drives O&M budget planning and cost-benefit analysis for preventive maintenance programs."
    - name: "avg_clearance_time_minutes"
      expr: AVG(CAST(clearance_time_minutes AS DOUBLE))
      comment: "Average time to clear blockages in minutes. Operational efficiency KPI; longer clearance times increase SSO risk and customer impact."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average crew response time to blockage events in minutes. Faster response reduces SSO probability and customer impact."
    - name: "sso_resulting_blockage_count"
      expr: COUNT(CASE WHEN sso_occurred_flag = TRUE THEN 1 END)
      comment: "Number of blockages that resulted in SSO events. Direct measure of blockage-to-SSO conversion rate; drives preventive maintenance investment decisions."
    - name: "total_sso_volume_gallons"
      expr: SUM(CAST(sso_volume_gallons AS DOUBLE))
      comment: "Total volume of SSO discharge resulting from blockages in gallons. Environmental impact and regulatory liability metric."
    - name: "repeat_blockage_count"
      expr: COUNT(CASE WHEN repeat_blockage_flag = TRUE THEN 1 END)
      comment: "Number of repeat blockages at previously affected locations. High repeat rates indicate structural defects requiring capital rehabilitation rather than continued O&M response."
    - name: "avg_total_duration_minutes"
      expr: AVG(CAST(total_duration_minutes AS DOUBLE))
      comment: "Average total event duration from report to resolution in minutes. End-to-end operational efficiency metric for blockage management program."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewer_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sewer inspection metrics for asset condition management, rehabilitation prioritization, and capital improvement program planning. Inspection data drives the CIP pipeline for sewer system renewal."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewer_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (CCTV, manhole, smoke test, dye test) for method-specific performance analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Inspection method used for technology benchmarking and data quality assessment."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (completed, pending review, rejected) for workflow management."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Overall condition grade assigned (PACP 1-5 scale) for asset condition portfolio analysis and CIP prioritization."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency classification for recommended action (immediate, short-term, long-term) for maintenance scheduling."
    - name: "structural_defect_flag"
      expr: CAST(structural_defect_flag AS STRING)
      comment: "Whether structural defects were observed, indicating assets requiring capital rehabilitation."
    - name: "critical_defect_flag"
      expr: CAST(critical_defect_flag AS STRING)
      comment: "Whether critical defects were found requiring immediate action to prevent failure or SSO."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Pipe material (clay, concrete, PVC, HDPE) for material-specific deterioration analysis and replacement planning."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of sewer inspections completed. Baseline for inspection program coverage and asset management maturity."
    - name: "total_inspection_length_feet"
      expr: SUM(CAST(inspection_length_feet AS DOUBLE))
      comment: "Total linear feet of sewer inspected. Coverage metric for asset management programs; utilities typically target 20% of network per year."
    - name: "avg_pacp_score"
      expr: AVG(CAST(pacp_score AS DOUBLE))
      comment: "Average PACP condition score across inspected segments. Portfolio-level asset health indicator; scores above 4 indicate critical condition requiring immediate rehabilitation."
    - name: "total_estimated_repair_cost_usd"
      expr: SUM(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Total estimated repair cost for defects identified in inspections in USD. Drives CIP budget development and capital needs assessment."
    - name: "critical_defect_inspection_count"
      expr: COUNT(CASE WHEN critical_defect_flag = TRUE THEN 1 END)
      comment: "Number of inspections identifying critical defects requiring immediate action. Drives emergency rehabilitation prioritization and SSO risk reduction."
    - name: "structural_defect_inspection_count"
      expr: COUNT(CASE WHEN structural_defect_flag = TRUE THEN 1 END)
      comment: "Number of inspections identifying structural defects. Feeds the capital rehabilitation pipeline for long-term asset renewal planning."
    - name: "infiltration_observed_count"
      expr: COUNT(CASE WHEN infiltration_observed_flag = TRUE THEN 1 END)
      comment: "Number of inspections where infiltration was observed. Drives I&I reduction program targeting and investment prioritization."
    - name: "avg_pipe_diameter_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average diameter of inspected pipe segments in inches. Used for rehabilitation cost estimation and hydraulic capacity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_effluent_parameter_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effluent parameter result metrics for NPDES permit compliance monitoring, treatment process performance evaluation, and regulatory reporting. Provides granular parameter-level compliance analytics."
  source: "`vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the effluent parameter monitored (BOD, TSS, ammonia, phosphorus, etc.) for parameter-specific compliance analysis."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Regulatory parameter code for EPA ICIS-NPDES reporting and cross-facility benchmarking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for each result (compliant, exceedance, violation) for regulatory risk classification."
    - name: "permit_limit_type"
      expr: permit_limit_type
      comment: "Type of permit limit (daily max, monthly avg, weekly avg) for limit-specific compliance analysis."
    - name: "sample_type"
      expr: sample_type
      comment: "Sample type (grab, composite, continuous) for data quality and method compliance verification."
    - name: "data_validation_status"
      expr: data_validation_status
      comment: "Data validation status for quality assurance tracking and regulatory data defensibility."
    - name: "quality_control_flag"
      expr: CAST(quality_control_flag AS STRING)
      comment: "Whether a quality control flag was raised on the result, indicating potential data quality issues."
  measures:
    - name: "total_results"
      expr: COUNT(1)
      comment: "Total number of effluent parameter results. Baseline for monitoring program completeness and regulatory reporting coverage."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured effluent parameter value. Tracks treatment process performance trends against permit limits."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceed permit limits. Severity indicator for SNC designation and enforcement prioritization."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum exceedance percentage observed. Identifies worst-case permit violations requiring immediate regulatory response."
    - name: "avg_flow_rate_mgd"
      expr: AVG(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Average effluent flow rate in MGD at time of sampling. Used for mass loading calculations and permit limit compliance."
    - name: "total_mass_loading_lbs_per_day"
      expr: SUM(CAST(mass_loading_lbs_per_day AS DOUBLE))
      comment: "Total mass loading of pollutants discharged in lbs/day. Cumulative environmental impact metric for receiving water quality assessment."
    - name: "avg_mass_loading_lbs_per_day"
      expr: AVG(CAST(mass_loading_lbs_per_day AS DOUBLE))
      comment: "Average daily mass loading of pollutants in lbs/day. Compared against permit mass-based limits for compliance determination."
    - name: "qc_flagged_result_count"
      expr: COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END)
      comment: "Number of results with quality control flags. High QC flag rates indicate laboratory or sampling process issues requiring corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_ii_flow_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infiltration and inflow (I&I) flow measurement metrics for sewer system capacity analysis, wet weather response planning, and I&I reduction program ROI evaluation."
  source: "`vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement`"
  dimensions:
    - name: "ii_type"
      expr: ii_type
      comment: "Type of I&I (infiltration vs. inflow) for targeted remediation strategy selection."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Flow measurement method used (flume, electromagnetic, ultrasonic) for data quality and accuracy assessment."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation status for quality assurance and regulatory defensibility of I&I measurements."
    - name: "data_quality_flag"
      expr: CAST(data_quality_flag AS STRING)
      comment: "Whether a data quality flag was raised on the measurement for filtering reliable vs. suspect data."
    - name: "alarm_triggered_flag"
      expr: CAST(alarm_triggered_flag AS STRING)
      comment: "Whether a SCADA alarm was triggered during the measurement period, indicating abnormal flow conditions."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during measurement for wet weather vs. dry weather I&I analysis."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of I&I flow measurements. Baseline for monitoring program coverage and data density assessment."
    - name: "avg_measured_flow_rate_mgd"
      expr: AVG(CAST(measured_flow_rate_mgd AS DOUBLE))
      comment: "Average measured flow rate in MGD. Tracks actual system flow against design capacity for capacity planning."
    - name: "avg_calculated_ii_volume_gallons"
      expr: AVG(CAST(calculated_ii_volume_gallons AS DOUBLE))
      comment: "Average calculated I&I volume per measurement event in gallons. Quantifies the magnitude of infiltration and inflow for program sizing."
    - name: "total_calculated_ii_volume_gallons"
      expr: SUM(CAST(calculated_ii_volume_gallons AS DOUBLE))
      comment: "Total calculated I&I volume across all measurements in gallons. Cumulative I&I burden on the collection system; drives I&I reduction program investment decisions."
    - name: "avg_peak_flow_rate_gpm"
      expr: AVG(CAST(peak_flow_rate_gpm AS DOUBLE))
      comment: "Average peak flow rate in gallons per minute. Used for hydraulic capacity analysis and SSO risk assessment during wet weather events."
    - name: "avg_dry_weather_baseline_gpm"
      expr: AVG(CAST(dry_weather_baseline_gpm AS DOUBLE))
      comment: "Average dry weather baseline flow in GPM. Establishes the baseline for calculating I&I volume above normal sanitary flow."
    - name: "avg_rainfall_depth_inches"
      expr: AVG(CAST(rainfall_depth_inches AS DOUBLE))
      comment: "Average rainfall depth associated with I&I measurements in inches. Used to develop rainfall-to-I&I response curves for hydraulic modeling."
    - name: "avg_pipe_depth_fill_pct"
      expr: AVG(CAST(pipe_depth_fill_percent AS DOUBLE))
      comment: "Average pipe depth-to-diameter fill percentage. Values above 75% indicate capacity-constrained segments at risk of surcharging and SSO."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_fog_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fats, oils, and grease (FOG) inspection metrics for pretreatment program compliance management, SSO prevention, and enforcement action tracking. FOG is a leading cause of collection system blockages."
  source: "`vibe_water_utilities_v1`.`wastewater`.`fog_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of FOG inspection (routine, complaint-based, follow-up) for program effectiveness analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (completed, pending, failed) for workflow management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the inspected establishment for enforcement prioritization."
    - name: "interceptor_type"
      expr: interceptor_type
      comment: "Type of grease interceptor (gravity, hydromechanical, outdoor) for technology-specific compliance analysis."
    - name: "violations_noted"
      expr: CAST(violations_noted AS STRING)
      comment: "Whether violations were noted during the inspection, for enforcement pipeline tracking."
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether corrective action was required, indicating non-compliant establishments needing follow-up."
    - name: "enforcement_action_recommended"
      expr: CAST(enforcement_action_recommended AS STRING)
      comment: "Whether enforcement action was recommended, for escalation tracking and legal action pipeline management."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity of violations found (minor, major, critical) for enforcement prioritization."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of FOG inspections conducted. Baseline for pretreatment program coverage and regulatory compliance."
    - name: "violation_inspection_count"
      expr: COUNT(CASE WHEN violations_noted = TRUE THEN 1 END)
      comment: "Number of inspections where violations were found. Primary FOG program compliance KPI; high violation rates indicate program effectiveness gaps."
    - name: "enforcement_action_recommended_count"
      expr: COUNT(CASE WHEN enforcement_action_recommended = TRUE THEN 1 END)
      comment: "Number of inspections resulting in enforcement action recommendations. Drives legal and regulatory enforcement pipeline management."
    - name: "avg_grease_depth_percentage"
      expr: AVG(CAST(grease_depth_percentage AS DOUBLE))
      comment: "Average grease accumulation as percentage of interceptor capacity. Values above 25% indicate inadequate pumping frequency and SSO risk."
    - name: "avg_grease_depth_inches"
      expr: AVG(CAST(grease_depth_inches AS DOUBLE))
      comment: "Average grease layer depth in inches across inspected interceptors. Operational condition metric for pumping frequency compliance."
    - name: "avg_solids_depth_inches"
      expr: AVG(CAST(solids_depth_inches AS DOUBLE))
      comment: "Average solids depth in inches across inspected interceptors. Combined with grease depth determines total interceptor loading and pumping compliance."
    - name: "bmp_compliant_count"
      expr: COUNT(CASE WHEN best_management_practices_compliant = TRUE THEN 1 END)
      comment: "Number of establishments found compliant with Best Management Practices. BMP compliance rate is a key FOG program performance indicator."
    - name: "re_inspection_required_count"
      expr: COUNT(CASE WHEN re_inspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring re-inspection due to violations. Drives follow-up inspection scheduling and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewer_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sewer network asset portfolio metrics for infrastructure condition management, capacity planning, and capital investment prioritization. Provides the asset base view for collection system management."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewer_network`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the sewer segment (active, abandoned, proposed) for active asset portfolio management."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of sewer segment (gravity main, force main, interceptor) for system-type specific analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (public, private, shared) for maintenance responsibility and capital planning."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Overall condition grade of the segment for asset health portfolio analysis and CIP prioritization."
    - name: "fog_risk_flag"
      expr: CAST(fog_risk_flag AS STRING)
      comment: "Whether the segment is flagged as high FOG risk for targeted cleaning and inspection scheduling."
    - name: "hydrogen_sulfide_risk_flag"
      expr: CAST(hydrogen_sulfide_risk_flag AS STRING)
      comment: "Whether the segment has hydrogen sulfide risk, indicating corrosion-accelerated deterioration requiring priority rehabilitation."
    - name: "lining_type"
      expr: lining_type
      comment: "Type of structural lining applied (CIPP, spray-on, slip-lining) for rehabilitation method performance tracking."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of sewer network segments in the asset registry. Baseline for collection system asset portfolio size."
    - name: "total_network_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total linear feet of sewer network. Primary asset portfolio size metric for benchmarking, rate-setting, and capital planning."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total replacement cost of the sewer network in USD. Asset replacement value for rate-setting, bond issuance, and long-term financial planning."
    - name: "avg_design_capacity_mgd"
      expr: AVG(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Average design capacity of sewer segments in MGD. Used for hydraulic capacity analysis and growth planning."
    - name: "avg_average_daily_flow_mgd"
      expr: AVG(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Average actual daily flow in sewer segments in MGD. Compared against design capacity to identify capacity-constrained segments."
    - name: "avg_slope_percent"
      expr: AVG(CAST(slope_percent AS DOUBLE))
      comment: "Average pipe slope percentage across the network. Low-slope segments are prone to solids deposition and blockages — drives targeted cleaning programs."
    - name: "h2s_risk_segment_count"
      expr: COUNT(CASE WHEN hydrogen_sulfide_risk_flag = TRUE THEN 1 END)
      comment: "Number of sewer segments with hydrogen sulfide risk. H2S causes accelerated concrete corrosion — these segments require priority inspection and rehabilitation."
    - name: "fog_risk_segment_count"
      expr: COUNT(CASE WHEN fog_risk_flag = TRUE THEN 1 END)
      comment: "Number of sewer segments flagged as high FOG risk. Drives targeted cleaning frequency and FOG source control program focus areas."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_watershed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Watershed management metrics for environmental compliance, stormwater program management, and MS4/NPDES permit tracking. Watersheds are the geographic unit for environmental impact assessment."
  source: "`vibe_water_utilities_v1`.`wastewater`.`watershed`"
  dimensions:
    - name: "watershed_type"
      expr: watershed_type
      comment: "Type of watershed (urban, agricultural, mixed) for land-use specific management strategy selection."
    - name: "watershed_status"
      expr: watershed_status
      comment: "Current management status of the watershed for active program tracking."
    - name: "land_use_category"
      expr: land_use_category
      comment: "Dominant land use category for pollutant loading characterization and BMP selection."
    - name: "pollution_level"
      expr: pollution_level
      comment: "Current pollution level classification for environmental risk prioritization and regulatory reporting."
    - name: "protected_status"
      expr: protected_status
      comment: "Whether the watershed has protected status (e.g., Outstanding National Resource Water) requiring enhanced protection measures."
    - name: "region"
      expr: region
      comment: "Geographic region of the watershed for multi-watershed portfolio management."
  measures:
    - name: "total_watersheds"
      expr: COUNT(1)
      comment: "Total number of watersheds under management. Baseline for environmental compliance portfolio scope."
    - name: "total_area_sq_km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total watershed area under management in square kilometers. Geographic scope metric for stormwater program planning and resource allocation."
    - name: "total_population_served"
      expr: SUM(CAST(population_served AS DOUBLE))
      comment: "Total population served within managed watersheds. Drives public health risk assessment and regulatory reporting requirements."
    - name: "avg_total_flow_cfs"
      expr: AVG(CAST(total_flow_cfs AS DOUBLE))
      comment: "Average total flow in cubic feet per second across watersheds. Hydrological baseline for CSO/SSO impact assessment and receiving water quality modeling."
    - name: "avg_average_precipitation_mm"
      expr: AVG(CAST(average_precipitation_mm AS DOUBLE))
      comment: "Average annual precipitation in millimeters across managed watersheds. Drives wet weather planning and I&I program sizing."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_industrial_user_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Industrial user permit metrics for pretreatment program management, categorical standard compliance, and enforcement action tracking. IUP compliance is a federal pretreatment program requirement under 40 CFR Part 403."
  source: "`vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the industrial user permit (active, expired, revoked, pending) for portfolio management."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of IUP (significant industrial user, categorical, non-significant) for regulatory classification and reporting."
    - name: "categorical_standard_applicable"
      expr: CAST(categorical_standard_applicable AS STRING)
      comment: "Whether a categorical pretreatment standard applies, indicating federally regulated industrial users."
    - name: "pretreatment_required"
      expr: CAST(pretreatment_required AS STRING)
      comment: "Whether pretreatment is required, for tracking industrial users with active pretreatment obligations."
    - name: "compliance_schedule_required"
      expr: CAST(compliance_schedule_required AS STRING)
      comment: "Whether a compliance schedule is required, indicating industrial users not yet meeting permit limits."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit (POTW, state, EPA) for jurisdictional compliance tracking."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of industrial user permits. Baseline for pretreatment program portfolio size and regulatory reporting."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active industrial user permits. Active permit count drives inspection scheduling and compliance monitoring resource allocation."
    - name: "avg_flow_limit_gpd"
      expr: AVG(CAST(flow_limit_gpd AS DOUBLE))
      comment: "Average permitted discharge flow limit in gallons per day. Used for hydraulic loading analysis and WWTP capacity planning."
    - name: "total_flow_limit_gpd"
      expr: SUM(CAST(flow_limit_gpd AS DOUBLE))
      comment: "Total permitted industrial discharge flow in gallons per day. Aggregate industrial loading on the collection system for capacity planning."
    - name: "avg_bod_limit_mg_per_l"
      expr: AVG(CAST(bod_limit_mg_per_l AS DOUBLE))
      comment: "Average BOD discharge limit across industrial user permits in mg/L. Benchmarks pretreatment program stringency against categorical standards."
    - name: "categorical_standard_permit_count"
      expr: COUNT(CASE WHEN categorical_standard_applicable = TRUE THEN 1 END)
      comment: "Number of permits subject to federal categorical pretreatment standards. Categorical IUs have the highest regulatory scrutiny and enforcement priority."
    - name: "compliance_schedule_permit_count"
      expr: COUNT(CASE WHEN compliance_schedule_required = TRUE THEN 1 END)
      comment: "Number of permits with active compliance schedules. Indicates industrial users not yet meeting permit limits — tracks pretreatment program improvement pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_facility_grant_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant allocation and expenditure metrics for wastewater facility capital funding management. Tracks SRF, WIFIA, and other grant program utilization against allocations for financial compliance and drawdown optimization."
  source: "`vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Grant compliance status for identifying allocations at risk of clawback or audit findings."
    - name: "project_phase"
      expr: project_phase
      comment: "Phase of the funded project (planning, design, construction, closeout) for grant lifecycle management."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Grant reporting period for periodic financial reporting and drawdown scheduling."
  measures:
    - name: "total_allocation_amount_usd"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total grant funds allocated to wastewater facilities in USD. Primary capital funding metric for financial planning and bond capacity analysis."
    - name: "total_expenditure_to_date_usd"
      expr: SUM(CAST(expenditure_to_date AS DOUBLE))
      comment: "Total grant funds expended to date in USD. Tracks drawdown progress against allocation; unexpended funds risk reversion to grantor."
    - name: "total_matching_funds_contributed_usd"
      expr: SUM(CAST(matching_funds_contributed AS DOUBLE))
      comment: "Total matching funds contributed by the utility in USD. Required for grant compliance; shortfalls can trigger grant clawback."
    - name: "avg_expenditure_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(expenditure_to_date AS DOUBLE) / NULLIF(CAST(allocation_amount AS DOUBLE), 0)), 2)
      comment: "Average grant expenditure rate as percentage of allocation. Low rates indicate drawdown risk; grantors typically require 80%+ utilization by project close."
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of grant allocations across facilities. Baseline for grant portfolio management and reporting workload."
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