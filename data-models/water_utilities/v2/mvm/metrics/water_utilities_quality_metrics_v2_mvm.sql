-- Metric views for domain: quality | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_analytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core water quality analytical result metrics tracking compliance, detection performance, and contaminant measurement outcomes across all sampling events. Drives regulatory compliance monitoring and lab performance management."
  source: "`vibe_water_utilities_v1`.`quality`.`analytical_result`"
  dimensions:
    - name: "analytical_result_status"
      expr: analytical_result_status
      comment: "Current status of the analytical result (e.g., Accepted, Rejected, Pending) for filtering valid vs. invalid results."
    - name: "result_status"
      expr: result_status
      comment: "Regulatory or lab result status classification used to segment compliant vs. non-compliant results."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Type of sample matrix (e.g., drinking water, groundwater, surface water) for cross-matrix quality comparison."
    - name: "analytical_method"
      expr: analytical_method
      comment: "Laboratory analytical method used, enabling method-level performance benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for result values, ensuring dimensional consistency in aggregations."
    - name: "compliance_exceeded"
      expr: compliance_exceeded
      comment: "Boolean flag indicating whether the result exceeded the applicable compliance limit — primary compliance dimension."
    - name: "hold_time_compliant"
      expr: hold_time_compliant
      comment: "Boolean flag indicating whether sample hold time requirements were met, affecting result validity."
    - name: "data_validation_level"
      expr: data_validation_level
      comment: "Level of data validation applied to the result (e.g., Level 1, Level 2, Level 4) for data quality segmentation."
    - name: "reporting_required"
      expr: reporting_required
      comment: "Boolean flag indicating whether this result must be reported to a regulatory agency."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month of analysis for trend analysis of compliance and detection rates over time."
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year of analysis for annual regulatory reporting and year-over-year compliance trend analysis."
    - name: "qualifier_code"
      expr: qualifier_code
      comment: "Laboratory qualifier code (e.g., U=non-detect, J=estimated) indicating result reliability and usability."
  measures:
    - name: "total_analytical_results"
      expr: COUNT(1)
      comment: "Total number of analytical results processed. Baseline volume metric for lab throughput and sampling program completeness."
    - name: "compliance_exceedance_count"
      expr: COUNT(CASE WHEN compliance_exceeded = TRUE THEN 1 END)
      comment: "Number of analytical results that exceeded the applicable compliance limit. Critical regulatory KPI — directly triggers public notification and corrective action obligations."
    - name: "hold_time_violation_count"
      expr: COUNT(CASE WHEN hold_time_compliant = FALSE THEN 1 END)
      comment: "Number of results where sample hold time was not met, invalidating the result. Drives lab logistics and chain-of-custody process improvement."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured contaminant concentration across all results. Tracks systemic contamination trends and informs treatment optimization decisions."
    - name: "max_result_value"
      expr: MAX(CAST(result_value AS DOUBLE))
      comment: "Maximum detected contaminant concentration. Identifies worst-case exposure events requiring immediate executive and regulatory attention."
    - name: "avg_percent_recovery"
      expr: AVG(CAST(percent_recovery AS DOUBLE))
      comment: "Average laboratory percent recovery across all results. Key lab QA/QC KPI — low recovery indicates method or matrix interference problems affecting result accuracy."
    - name: "avg_relative_percent_difference"
      expr: AVG(CAST(relative_percent_difference AS DOUBLE))
      comment: "Average relative percent difference (RPD) between duplicate samples. Measures analytical precision — high RPD signals lab reproducibility issues requiring corrective action."
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average method detection limit across results. Tracks analytical sensitivity — higher detection limits may mask low-level contamination relevant to health-based standards."
    - name: "results_below_detection_limit"
      expr: COUNT(CASE WHEN result_value < detection_limit THEN 1 END)
      comment: "Number of results where the measured value was below the method detection limit (non-detects). Informs contaminant prevalence assessment and regulatory non-detect handling."
    - name: "avg_mcl_value"
      expr: AVG(CAST(mcl_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level (MCL) applicable to results in the selected segment. Provides regulatory threshold context for compliance gap analysis."
    - name: "total_results_requiring_reporting"
      expr: COUNT(CASE WHEN reporting_required = TRUE THEN 1 END)
      comment: "Number of results that require regulatory reporting. Drives compliance reporting workload planning and ensures no reportable results are missed."
    - name: "distinct_contaminants_detected"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants detected across results. Measures breadth of contamination — a rising count signals emerging multi-contaminant risk requiring strategic response."
    - name: "distinct_sampling_points_tested"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling points with analytical results. Measures spatial coverage of the monitoring program — gaps indicate under-monitored zones."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_exceedance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory exceedance event metrics tracking the frequency, severity, resolution, and financial impact of water quality limit violations. Central KPI domain for regulatory risk management, public notification compliance, and corrective action performance."
  source: "`vibe_water_utilities_v1`.`quality`.`exceedance`"
  dimensions:
    - name: "exceedance_type"
      expr: exceedance_type
      comment: "Type of exceedance (e.g., MCL, Treatment Technique, Monitoring) for regulatory category analysis."
    - name: "exceedance_status"
      expr: exceedance_status
      comment: "Current status of the exceedance (e.g., Open, Resolved, Under Review) for active vs. closed exceedance tracking."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the exceedance (e.g., Critical, High, Medium, Low) for risk prioritization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the exceedance for operational response triage."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the exceedance (e.g., Resolved, Pending, Escalated) for corrective action pipeline management."
    - name: "category"
      expr: category
      comment: "Exceedance category (e.g., Chemical, Microbial, Radiological) for contaminant class-level risk analysis."
    - name: "classification"
      expr: classification
      comment: "Regulatory classification of the exceedance for compliance reporting segmentation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction associated with the exceedance for multi-jurisdiction compliance management."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework (e.g., SDWA, EU DWD) under which the exceedance is classified."
    - name: "public_notification_required_flag"
      expr: public_notification_required_flag
      comment: "Boolean flag indicating whether public notification is required — critical for regulatory deadline tracking."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Boolean flag indicating whether a corrective action is mandated for this exceedance."
    - name: "resolved_flag"
      expr: resolved_flag
      comment: "Boolean flag indicating whether the exceedance has been fully resolved."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the exceedance is currently active and unresolved."
    - name: "exceedance_detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month of exceedance detection for trend analysis of violation frequency over time."
    - name: "exceedance_detection_year"
      expr: YEAR(detection_date)
      comment: "Year of exceedance detection for annual regulatory reporting and year-over-year violation trend analysis."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of regulatory limit exceeded (e.g., MCL, Action Level, Treatment Technique) for limit-category analysis."
  measures:
    - name: "total_exceedances"
      expr: COUNT(1)
      comment: "Total number of regulatory exceedance events. Primary compliance risk KPI — directly reported to regulators and boards."
    - name: "active_exceedances"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active (unresolved) exceedances. Operational risk KPI — drives immediate resource allocation and regulatory response prioritization."
    - name: "resolved_exceedances"
      expr: COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END)
      comment: "Number of exceedances that have been fully resolved. Measures corrective action effectiveness and regulatory closure performance."
    - name: "public_notification_required_count"
      expr: COUNT(CASE WHEN public_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of exceedances requiring public notification. Regulatory obligation KPI — missed notifications trigger additional violations and penalties."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of exceedances requiring formal corrective action. Drives capital and O&M investment planning for compliance restoration."
    - name: "total_exceedance_financial_impact_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total financial impact (fines, penalties, remediation costs) associated with exceedances in USD. Directly informs regulatory risk reserve and compliance investment decisions."
    - name: "avg_exceedance_financial_impact_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average financial impact per exceedance event in USD. Benchmarks cost-per-violation for risk-adjusted compliance investment analysis."
    - name: "avg_detected_value"
      expr: AVG(CAST(detected_value AS DOUBLE))
      comment: "Average detected contaminant concentration at time of exceedance. Measures typical exceedance magnitude — higher averages indicate systemic treatment or source water issues."
    - name: "max_detected_value"
      expr: MAX(CAST(detected_value AS DOUBLE))
      comment: "Maximum detected contaminant concentration across all exceedances. Identifies worst-case public health exposure events for executive and regulatory escalation."
    - name: "avg_exceedance_ratio"
      expr: AVG(CAST(ratio AS DOUBLE))
      comment: "Average ratio of detected value to regulatory limit across exceedances. Measures how far above the limit violations typically occur — high ratios signal severe systemic non-compliance."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average percentage exceedance above the regulatory limit. Provides normalized severity measure for cross-contaminant and cross-jurisdiction comparison."
    - name: "distinct_contaminants_exceeded"
      expr: COUNT(DISTINCT contaminant_limit_id)
      comment: "Number of distinct contaminant limits exceeded. Measures breadth of compliance failure — a high count signals multi-parameter systemic risk."
    - name: "distinct_facilities_with_exceedances"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with at least one exceedance. Identifies geographic and operational concentration of compliance risk for targeted investment."
    - name: "distinct_sampling_points_with_exceedances"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling points where exceedances were detected. Maps spatial distribution of water quality failures for infrastructure prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_water_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water sampling program operational metrics tracking sample collection volume, field measurement quality, and sampling program completeness. Drives monitoring program compliance and field operations management."
  source: "`vibe_water_utilities_v1`.`quality`.`water_sample`"
  dimensions:
    - name: "water_sample_status"
      expr: water_sample_status
      comment: "Current status of the water sample (e.g., Collected, Submitted, Analyzed, Rejected) for pipeline stage analysis."
    - name: "sample_status"
      expr: sample_status
      comment: "Operational status of the sample for workflow management and completeness tracking."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample (e.g., Routine, Repeat, Confirmation, QC) for monitoring program composition analysis."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix type (e.g., drinking water, raw water, treated effluent) for source-stage quality comparison."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample collection (e.g., Compliance, Operational, Investigative) for program-type performance analysis."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the sample was collected (e.g., TCR, LCR, UCMR) for program-level compliance tracking."
    - name: "quality_control_flag"
      expr: quality_control_flag
      comment: "Boolean flag indicating whether the sample is a quality control sample (blank, spike, duplicate)."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of collection — enables correlation of weather events with water quality anomalies."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of sample collection for temporal trend analysis of sampling program activity."
    - name: "collection_year"
      expr: YEAR(collection_timestamp)
      comment: "Year of sample collection for annual program compliance and year-over-year volume comparison."
  measures:
    - name: "total_samples_collected"
      expr: COUNT(1)
      comment: "Total number of water samples collected. Baseline monitoring program volume KPI — compared against required sample counts to assess program completeness."
    - name: "avg_field_turbidity_ntu"
      expr: AVG(CAST(field_turbidity_ntu AS DOUBLE))
      comment: "Average field turbidity in NTU across all samples. Key treatment performance indicator — elevated turbidity signals filtration issues and potential pathogen risk."
    - name: "max_field_turbidity_ntu"
      expr: MAX(CAST(field_turbidity_ntu AS DOUBLE))
      comment: "Maximum field turbidity recorded. Identifies worst-case turbidity events that may trigger regulatory action or treatment process review."
    - name: "avg_field_chlorine_residual_mg_l"
      expr: AVG(CAST(field_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average field chlorine residual in mg/L. Primary disinfection effectiveness KPI — low residuals indicate distribution system vulnerability to microbial contamination."
    - name: "min_field_chlorine_residual_mg_l"
      expr: MIN(CAST(field_chlorine_residual_mg_l AS DOUBLE))
      comment: "Minimum field chlorine residual recorded. Identifies distribution system dead-ends or demand hotspots with inadequate disinfection protection."
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field pH across samples. Tracks corrosion control effectiveness — pH outside optimal range accelerates pipe corrosion and lead/copper leaching."
    - name: "avg_field_temperature_c"
      expr: AVG(CAST(field_temperature_c AS DOUBLE))
      comment: "Average field water temperature in Celsius. Elevated temperatures accelerate microbial growth and disinfectant decay — critical for seasonal risk management."
    - name: "avg_field_dissolved_oxygen_mg_l"
      expr: AVG(CAST(field_dissolved_oxygen_mg_l AS DOUBLE))
      comment: "Average dissolved oxygen level in mg/L. Indicator of source water quality and biological activity relevant to treatment process optimization."
    - name: "avg_field_conductivity_us_cm"
      expr: AVG(CAST(field_conductivity_us_cm AS DOUBLE))
      comment: "Average field conductivity in µS/cm. Tracks total dissolved solids trends — rising conductivity may indicate source water quality degradation or contamination events."
    - name: "distinct_sampling_points_sampled"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling points with collected samples. Measures spatial coverage of the monitoring program — gaps indicate under-monitored distribution zones."
    - name: "distinct_facilities_sampled"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities from which samples were collected. Ensures all treatment and distribution facilities are included in the monitoring program."
    - name: "qc_sample_count"
      expr: COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END)
      comment: "Number of quality control samples collected. Measures QA/QC program rigor — insufficient QC samples undermine the defensibility of compliance results."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_lead_copper_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead and Copper Rule (LCR) compliance metrics tracking action level exceedances, 90th percentile performance, and customer notification compliance. Directly supports regulatory reporting under the Lead and Copper Rule and its revisions (LCRR/LCRI)."
  source: "`vibe_water_utilities_v1`.`quality`.`lead_copper_result`"
  dimensions:
    - name: "lead_copper_result_status"
      expr: lead_copper_result_status
      comment: "Status of the lead/copper result (e.g., Valid, Rejected, Pending) for filtering analytically valid results."
    - name: "site_tier"
      expr: site_tier
      comment: "LCR site tier classification (Tier 1, Tier 2, Tier 3) — higher tiers represent higher-risk sites (e.g., homes with lead service lines) and are weighted in 90th percentile calculations."
    - name: "lead_action_level_exceeded"
      expr: lead_action_level_exceeded
      comment: "Boolean flag indicating whether the lead action level was exceeded at this site. Primary LCR compliance KPI dimension."
    - name: "copper_action_level_exceeded"
      expr: copper_action_level_exceeded
      comment: "Boolean flag indicating whether the copper action level was exceeded at this site."
    - name: "action_level_exceeded_flag"
      expr: action_level_exceeded_flag
      comment: "Combined boolean flag for any action level exceedance (lead or copper) — used for overall LCR compliance status reporting."
    - name: "ninetieth_percentile_flag"
      expr: ninetieth_percentile_flag
      comment: "Boolean flag indicating whether this result is included in the 90th percentile calculation — the regulatory compliance threshold metric."
    - name: "customer_notification_sent"
      expr: customer_notification_sent
      comment: "Boolean flag indicating whether the required customer notification was sent following an action level exceedance."
    - name: "corrosion_control_treatment_status"
      expr: corrosion_control_treatment_status
      comment: "Status of corrosion control treatment at the sampled site — links LCR results to treatment effectiveness."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of the lead/copper result for data quality filtering."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting for this result — tracks whether results have been submitted to the primacy agency."
    - name: "sample_collection_month"
      expr: DATE_TRUNC('MONTH', sample_collection_date)
      comment: "Month of sample collection for LCR monitoring period trend analysis."
    - name: "sample_collection_year"
      expr: YEAR(sample_collection_date)
      comment: "Year of sample collection for annual LCR compliance period reporting."
    - name: "holding_time_compliant"
      expr: holding_time_compliant
      comment: "Boolean flag indicating whether sample holding time requirements were met — invalid samples cannot be used for LCR compliance calculations."
  measures:
    - name: "total_lcr_samples"
      expr: COUNT(1)
      comment: "Total number of Lead and Copper Rule samples collected. Baseline LCR monitoring program completeness KPI — compared against required sample counts per monitoring period."
    - name: "lead_action_level_exceedance_count"
      expr: COUNT(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 END)
      comment: "Number of sites where the lead action level (15 µg/L) was exceeded. Primary LCR compliance KPI — exceedances trigger mandatory corrosion control, public education, and service line replacement programs."
    - name: "copper_action_level_exceedance_count"
      expr: COUNT(CASE WHEN copper_action_level_exceeded = TRUE THEN 1 END)
      comment: "Number of sites where the copper action level (1.3 mg/L) was exceeded. Triggers corrosion control treatment review and public notification obligations."
    - name: "avg_lead_concentration_mg_l"
      expr: AVG(CAST(lead_concentration_mg_l AS DOUBLE))
      comment: "Average lead concentration in mg/L across all LCR samples. Tracks systemic lead exposure levels — rising averages signal deteriorating corrosion control effectiveness."
    - name: "max_lead_concentration_mg_l"
      expr: MAX(CAST(lead_concentration_mg_l AS DOUBLE))
      comment: "Maximum lead concentration detected in mg/L. Identifies highest-risk individual sites for priority service line replacement and customer notification."
    - name: "avg_copper_concentration_mg_l"
      expr: AVG(CAST(copper_concentration_mg_l AS DOUBLE))
      comment: "Average copper concentration in mg/L across all LCR samples. Monitors corrosion control program effectiveness for copper."
    - name: "max_copper_concentration_mg_l"
      expr: MAX(CAST(copper_concentration_mg_l AS DOUBLE))
      comment: "Maximum copper concentration detected in mg/L. Identifies worst-case corrosion events requiring immediate treatment response."
    - name: "avg_lead_result_ppb"
      expr: AVG(CAST(lead_result_ppb AS DOUBLE))
      comment: "Average lead result in parts per billion (ppb). Standard LCR reporting unit — directly comparable to the 15 ppb action level for executive compliance dashboards."
    - name: "avg_copper_result_ppb"
      expr: AVG(CAST(copper_result_ppb AS DOUBLE))
      comment: "Average copper result in parts per billion (ppb). Standard LCR reporting unit for copper compliance monitoring."
    - name: "customer_notification_sent_count"
      expr: COUNT(CASE WHEN customer_notification_sent = TRUE THEN 1 END)
      comment: "Number of customers notified following lead/copper action level exceedances. Regulatory obligation KPI — failure to notify triggers additional violations and penalties."
    - name: "sites_included_in_90th_percentile"
      expr: COUNT(CASE WHEN ninetieth_percentile_flag = TRUE THEN 1 END)
      comment: "Number of sites included in the 90th percentile calculation. Validates that the correct number of sites are used in the regulatory compliance determination."
    - name: "avg_90th_percentile_included_value"
      expr: AVG(CAST(included_in_90th_percentile AS DOUBLE))
      comment: "Average value of results included in the 90th percentile calculation. Tracks the 90th percentile trend — the regulatory compliance threshold that determines system-wide LCR status."
    - name: "distinct_service_lines_sampled"
      expr: COUNT(DISTINCT service_line_id)
      comment: "Number of distinct service lines sampled under the LCR program. Measures service line inventory coverage — critical for LCRR service line replacement program planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_sampling_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling program planning and compliance metrics tracking schedule adherence, monitoring completeness, and cost performance. Drives regulatory monitoring program management and resource allocation decisions."
  source: "`vibe_water_utilities_v1`.`quality`.`sampling_schedule`"
  dimensions:
    - name: "sampling_schedule_status"
      expr: sampling_schedule_status
      comment: "Current status of the sampling schedule (e.g., Active, Suspended, Completed) for program lifecycle management."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Operational status of the schedule for workflow and compliance tracking."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of sampling schedule (e.g., Routine, Triggered, Reduced) for monitoring program composition analysis."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency (e.g., Monthly, Quarterly, Annual) for compliance period planning."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample required by the schedule (e.g., Compliance, QC, Investigative)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the sampling schedule (e.g., Compliant, Deficient, Waived) — primary regulatory monitoring KPI dimension."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Boolean flag indicating whether a monitoring violation exists for this schedule — directly triggers regulatory reporting obligations."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Boolean flag indicating whether seasonal adjustments apply to this schedule — relevant for source water quality seasonal risk management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the sampling schedule for resource allocation and scheduling conflict resolution."
    - name: "monitoring_period_start_month"
      expr: DATE_TRUNC('MONTH', monitoring_period_start_date)
      comment: "Start month of the monitoring period for temporal compliance tracking."
    - name: "monitoring_period_end_year"
      expr: YEAR(monitoring_period_end_date)
      comment: "Year of monitoring period end for annual compliance program reporting."
  measures:
    - name: "total_sampling_schedules"
      expr: COUNT(1)
      comment: "Total number of active sampling schedules. Baseline monitoring program scope KPI — measures regulatory monitoring obligation inventory."
    - name: "monitoring_violation_count"
      expr: COUNT(CASE WHEN violation_flag = TRUE THEN 1 END)
      comment: "Number of sampling schedules with monitoring violations. Critical regulatory KPI — monitoring violations are directly reportable to primacy agencies and trigger enforcement actions."
    - name: "total_annual_budget_allocation_usd"
      expr: SUM(CAST(annual_budget_allocation AS DOUBLE))
      comment: "Total annual budget allocated across all sampling schedules in USD. Drives monitoring program financial planning and cost optimization decisions."
    - name: "avg_cost_per_sample_usd"
      expr: AVG(CAST(cost_per_sample AS DOUBLE))
      comment: "Average cost per sample across all schedules in USD. Benchmarks sampling program efficiency — enables cost optimization through method consolidation and lab contract management."
    - name: "total_cost_per_sample_usd"
      expr: SUM(CAST(cost_per_sample AS DOUBLE))
      comment: "Total cost per sample summed across all schedules. Provides aggregate cost baseline for monitoring program budget forecasting."
    - name: "avg_sample_volume_ml"
      expr: AVG(CAST(sample_volume_ml AS DOUBLE))
      comment: "Average required sample volume in mL across schedules. Informs field logistics planning for sample container procurement and transport capacity."
    - name: "schedules_with_compliance_deadline_approaching"
      expr: COUNT(CASE WHEN compliance_deadline_date <= DATE_ADD(CURRENT_DATE(), 30) AND compliance_deadline_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of sampling schedules with compliance deadlines within the next 30 days. Operational urgency KPI — drives immediate field scheduling and resource deployment decisions."
    - name: "distinct_contaminants_scheduled"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants covered by active sampling schedules. Measures regulatory monitoring program breadth — gaps indicate unmonitored contaminants posing compliance risk."
    - name: "distinct_facilities_scheduled"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities covered by sampling schedules. Ensures all regulated facilities are included in the monitoring program."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_ccr_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Confidence Report (CCR) compliance and publication metrics tracking report completion, violation counts, and regulatory submission status. Supports annual CCR regulatory obligation management and public transparency reporting."
  source: "`vibe_water_utilities_v1`.`quality`.`ccr_period`"
  dimensions:
    - name: "ccr_period_status"
      expr: ccr_period_status
      comment: "Current status of the CCR period (e.g., Draft, Published, Submitted) for report lifecycle management."
    - name: "report_status"
      expr: report_status
      comment: "Status of the CCR report (e.g., Complete, Incomplete, Under Review) for compliance deadline tracking."
    - name: "published_flag"
      expr: published_flag
      comment: "Boolean flag indicating whether the CCR has been published and distributed to customers — primary CCR compliance KPI."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used to distribute the CCR to customers (e.g., Mail, Online, Direct Delivery) for distribution compliance analysis."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of CCR distribution to customers — tracks whether distribution obligations have been fulfilled."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction for the CCR period — enables multi-jurisdiction compliance management."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the CCR (e.g., US SDWA, EU DWD) for framework-level compliance analysis."
    - name: "eu_dwd_article_17_compliant"
      expr: eu_dwd_article_17_compliant
      comment: "Boolean flag indicating EU Drinking Water Directive Article 17 compliance for European regulatory reporting."
    - name: "health_effects_language_included_flag"
      expr: health_effects_language_included_flag
      comment: "Boolean flag indicating whether required health effects language is included in the CCR — mandatory regulatory content requirement."
    - name: "lead_copper_educational_information_flag"
      expr: lead_copper_educational_information_flag
      comment: "Boolean flag indicating whether lead and copper educational information is included — required under LCR for systems exceeding action levels."
    - name: "report_year"
      expr: report_year
      comment: "Reporting year of the CCR for annual compliance trend analysis."
    - name: "period_start_year"
      expr: YEAR(period_start_date)
      comment: "Year of the CCR reporting period start for temporal compliance tracking."
  measures:
    - name: "total_ccr_periods"
      expr: COUNT(1)
      comment: "Total number of CCR reporting periods. Baseline CCR program scope KPI — one per regulated system per year under SDWA."
    - name: "published_ccr_count"
      expr: COUNT(CASE WHEN published_flag = TRUE THEN 1 END)
      comment: "Number of CCRs that have been published and distributed. Primary CCR compliance KPI — unpublished CCRs represent regulatory violations with potential enforcement consequences."
    - name: "unpublished_ccr_count"
      expr: COUNT(CASE WHEN published_flag = FALSE OR published_flag IS NULL THEN 1 END)
      comment: "Number of CCRs not yet published. Identifies compliance gaps requiring immediate action to meet annual distribution deadlines."
    - name: "eu_dwd_compliant_count"
      expr: COUNT(CASE WHEN eu_dwd_article_17_compliant = TRUE THEN 1 END)
      comment: "Number of CCR periods compliant with EU Drinking Water Directive Article 17. Tracks EU regulatory compliance for utilities operating under European frameworks."
    - name: "ccr_with_health_effects_language_count"
      expr: COUNT(CASE WHEN health_effects_language_included_flag = TRUE THEN 1 END)
      comment: "Number of CCRs that include required health effects language. Mandatory content compliance KPI — missing health effects language is a reportable CCR deficiency."
    - name: "ccr_with_lead_copper_education_count"
      expr: COUNT(CASE WHEN lead_copper_educational_information_flag = TRUE THEN 1 END)
      comment: "Number of CCRs including lead and copper educational information. Required for systems with LCR action level exceedances — tracks compliance with mandatory public education obligations."
    - name: "distinct_facilities_with_ccr"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with CCR periods. Ensures all regulated facilities are meeting annual CCR publication requirements."
    - name: "distinct_compliance_permits_with_ccr"
      expr: COUNT(DISTINCT compliance_permit_id)
      comment: "Number of distinct compliance permits (PWSIDs) with CCR periods. Validates that all permitted water systems are fulfilling CCR obligations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_contaminant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contaminant regulatory profile metrics tracking the composition of the regulated contaminant inventory, PFAS compound prevalence, treatment technology requirements, and health-based limit benchmarks. Supports strategic treatment investment planning and regulatory compliance program design."
  source: "`vibe_water_utilities_v1`.`quality`.`contaminant`"
  dimensions:
    - name: "contaminant_type"
      expr: contaminant_type
      comment: "Type of contaminant (e.g., Chemical, Microbial, Radiological, Physical) for regulatory program category analysis."
    - name: "category"
      expr: category
      comment: "Contaminant category for grouping related contaminants in compliance and treatment planning."
    - name: "contaminant_status"
      expr: contaminant_status
      comment: "Regulatory status of the contaminant (e.g., Regulated, Unregulated, Candidate) for monitoring program scoping."
    - name: "health_effect_category"
      expr: health_effect_category
      comment: "Health effect category (e.g., Carcinogen, Neurotoxin, Endocrine Disruptor) for public health risk prioritization."
    - name: "is_pfas_compound"
      expr: is_pfas_compound
      comment: "Boolean flag identifying PFAS compounds — the highest-priority emerging contaminant class under current US EPA and EU DWD regulations."
    - name: "pfas_compound_class"
      expr: pfas_compound_class
      comment: "PFAS compound class (e.g., PFOA, PFOS, GenX) for PFAS-specific regulatory compliance and treatment planning."
    - name: "eu_dwd_regulated_flag"
      expr: eu_dwd_regulated_flag
      comment: "Boolean flag indicating EU Drinking Water Directive regulation status for European compliance program management."
    - name: "us_regulated_flag"
      expr: us_regulated_flag
      comment: "Boolean flag indicating US EPA regulation status under the Safe Drinking Water Act."
    - name: "treatment_technique_required"
      expr: treatment_technique_required
      comment: "Boolean flag indicating whether a treatment technique (rather than an MCL) is required — affects compliance monitoring approach."
    - name: "primary_treatment_technology"
      expr: primary_treatment_technology
      comment: "Primary treatment technology required for removal (e.g., GAC, RO, Ion Exchange) — drives capital investment planning."
    - name: "ccr_reporting_required"
      expr: ccr_reporting_required
      comment: "Boolean flag indicating whether this contaminant must be disclosed in the Consumer Confidence Report."
    - name: "hazard_index_member"
      expr: hazard_index_member
      comment: "Boolean flag indicating whether the contaminant is a member of the US EPA PFAS Hazard Index group — subject to combined MCL compliance."
  measures:
    - name: "total_regulated_contaminants"
      expr: COUNT(1)
      comment: "Total number of contaminants in the regulatory inventory. Baseline compliance program scope KPI — measures the breadth of monitoring and treatment obligations."
    - name: "pfas_compound_count"
      expr: COUNT(CASE WHEN is_pfas_compound = TRUE THEN 1 END)
      comment: "Number of PFAS compounds in the regulated inventory. Strategic KPI — PFAS regulation is the highest-priority emerging contaminant challenge, driving major treatment capital investment decisions."
    - name: "eu_dwd_regulated_count"
      expr: COUNT(CASE WHEN eu_dwd_regulated_flag = TRUE THEN 1 END)
      comment: "Number of contaminants regulated under the EU Drinking Water Directive. Tracks EU compliance program scope for utilities operating under European regulatory frameworks."
    - name: "us_regulated_count"
      expr: COUNT(CASE WHEN us_regulated_flag = TRUE THEN 1 END)
      comment: "Number of contaminants regulated under US EPA SDWA. Tracks US compliance program scope and monitoring obligation inventory."
    - name: "treatment_technique_required_count"
      expr: COUNT(CASE WHEN treatment_technique_required = TRUE THEN 1 END)
      comment: "Number of contaminants requiring treatment technique compliance rather than MCL measurement. Informs treatment operations complexity and compliance monitoring approach."
    - name: "avg_mcl_value"
      expr: AVG(CAST(mcl_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level across regulated contaminants. Provides regulatory stringency benchmark for treatment performance target-setting."
    - name: "avg_us_epa_mcl_ng_l"
      expr: AVG(CAST(us_epa_mcl_ng_l AS DOUBLE))
      comment: "Average US EPA MCL in ng/L (nanograms per liter) — the standard unit for PFAS and ultra-trace contaminant limits. Tracks regulatory stringency trends as new PFAS MCLs are promulgated."
    - name: "avg_gac_removal_efficiency_pct"
      expr: AVG(CAST(gac_removal_efficiency_pct AS DOUBLE))
      comment: "Average GAC (Granular Activated Carbon) removal efficiency percentage across contaminants. Informs GAC treatment investment decisions — lower average efficiency signals need for alternative or supplemental treatment."
    - name: "avg_ion_exchange_removal_efficiency_pct"
      expr: AVG(CAST(ion_exchange_removal_efficiency_pct AS DOUBLE))
      comment: "Average ion exchange removal efficiency percentage. Benchmarks ion exchange treatment effectiveness for PFAS and other ionic contaminants — supports technology selection decisions."
    - name: "hazard_index_member_count"
      expr: COUNT(CASE WHEN hazard_index_member = TRUE THEN 1 END)
      comment: "Number of contaminants that are members of the US EPA PFAS Hazard Index. Tracks the scope of combined-MCL compliance obligations under the 2024 PFAS National Primary Drinking Water Rule."
    - name: "ccr_reportable_contaminant_count"
      expr: COUNT(CASE WHEN ccr_reporting_required = TRUE THEN 1 END)
      comment: "Number of contaminants requiring CCR disclosure. Drives annual CCR content planning and ensures all mandatory disclosures are included."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_contaminant_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contaminant regulatory limit inventory metrics tracking limit types, compliance status, variance/waiver usage, and detection requirements. Supports regulatory compliance program management and limit supersession tracking."
  source: "`vibe_water_utilities_v1`.`quality`.`contaminant_limit`"
  dimensions:
    - name: "contaminant_limit_status"
      expr: contaminant_limit_status
      comment: "Current status of the contaminant limit (e.g., Active, Superseded, Proposed) for current vs. historical limit analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against this limit (e.g., Compliant, Non-Compliant, Pending) — primary regulatory compliance KPI dimension."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of regulatory limit (e.g., MCL, Action Level, Treatment Technique, MCLG) for limit category analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction for the limit (e.g., Federal, State, EU) for multi-jurisdiction compliance management."
    - name: "jurisdiction_authority"
      expr: jurisdiction_authority
      comment: "Specific regulatory authority issuing the limit (e.g., US EPA, State DEP, EU Commission) for authority-level compliance tracking."
    - name: "health_effect_category"
      expr: health_effect_category
      comment: "Health effect category associated with the limit for public health risk prioritization."
    - name: "variance_waiver_flag"
      expr: variance_waiver_flag
      comment: "Boolean flag indicating whether a variance or waiver applies to this limit — variances represent temporary relief from compliance obligations."
    - name: "ccr_reporting_required"
      expr: ccr_reporting_required
      comment: "Boolean flag indicating whether this limit must be reported in the Consumer Confidence Report."
    - name: "public_notification_tier"
      expr: public_notification_tier
      comment: "Public notification tier (Tier 1, 2, 3) associated with violations of this limit — determines notification urgency and method."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the limit value — ensures dimensional consistency in limit vs. result comparisons."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the limit became effective — tracks regulatory limit evolution and identifies recently promulgated limits requiring immediate compliance action."
  measures:
    - name: "total_contaminant_limits"
      expr: COUNT(1)
      comment: "Total number of contaminant limits in the regulatory inventory. Baseline compliance obligation scope KPI."
    - name: "non_compliant_limit_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of contaminant limits currently in non-compliant status. Critical regulatory risk KPI — each non-compliant limit represents an active violation requiring corrective action."
    - name: "variance_waiver_count"
      expr: COUNT(CASE WHEN variance_waiver_flag = TRUE THEN 1 END)
      comment: "Number of limits with active variances or waivers. Tracks regulatory relief usage — high counts may indicate systemic treatment capability gaps requiring capital investment."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average regulatory limit value across all contaminant limits. Provides regulatory stringency benchmark for treatment performance target-setting."
    - name: "avg_detection_limit_required"
      expr: AVG(CAST(detection_limit_required AS DOUBLE))
      comment: "Average required method detection limit across all contaminant limits. Informs laboratory capability requirements — if lab detection limits exceed regulatory requirements, compliance results are invalid."
    - name: "limits_expiring_within_90_days"
      expr: COUNT(CASE WHEN variance_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND variance_expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of variance/waiver limits expiring within 90 days. Operational urgency KPI — expiring variances require immediate compliance restoration planning or renewal applications."
    - name: "superseded_limit_count"
      expr: COUNT(CASE WHEN superseded_date IS NOT NULL AND superseded_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of limits that have been superseded by newer regulatory requirements. Tracks regulatory update compliance — superseded limits must be replaced with current requirements in monitoring programs."
    - name: "distinct_contaminants_with_limits"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants with defined regulatory limits. Measures regulatory coverage completeness — contaminants without limits may still require monitoring under unregulated contaminant programs."
$$;