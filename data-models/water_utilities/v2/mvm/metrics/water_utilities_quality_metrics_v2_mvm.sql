-- Metric views for domain: quality | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_analytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analytical water quality testing results — tracks contaminant detection, MCL compliance, and laboratory performance across all analytical samples. Core KPI layer for regulatory compliance and water quality assurance."
  source: "`vibe_water_utilities_v1`.`quality`.`analytical_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the laboratory analysis was performed — used for trend analysis and regulatory period reporting."
    - name: "analytical_method"
      expr: analytical_method
      comment: "Laboratory analytical method used — enables method-level quality benchmarking and regulatory method compliance tracking."
    - name: "result_status"
      expr: result_status
      comment: "Status of the analytical result (e.g., accepted, rejected, pending) — used to filter valid results for compliance reporting."
    - name: "compliance_exceeded"
      expr: compliance_exceeded
      comment: "Boolean flag indicating whether the result exceeded the applicable regulatory limit — primary compliance dimension."
    - name: "data_validation_level"
      expr: data_validation_level
      comment: "Level of data validation applied to the result — used to assess data quality and reliability of reported values."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Matrix type of the sample (e.g., drinking water, wastewater effluent) — enables cross-matrix performance comparison."
    - name: "qualifier_code"
      expr: qualifier_code
      comment: "Laboratory qualifier code indicating result conditions (e.g., below detection limit, estimated) — critical for regulatory interpretation."
    - name: "hold_time_compliant"
      expr: hold_time_compliant
      comment: "Boolean indicating whether sample hold time requirements were met — non-compliant hold times invalidate results."
    - name: "reporting_required"
      expr: reporting_required
      comment: "Boolean flag indicating whether this result must be reported to a regulatory authority — scopes regulatory reporting workload."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result value — ensures dimensional consistency in aggregations."
  measures:
    - name: "total_analytical_results"
      expr: COUNT(1)
      comment: "Total number of analytical results — baseline volume metric for laboratory throughput and monitoring program scale."
    - name: "compliance_exceedance_count"
      expr: COUNT(CASE WHEN compliance_exceeded = TRUE THEN 1 END)
      comment: "Number of analytical results that exceeded the applicable regulatory limit — primary regulatory risk indicator driving enforcement and public notification decisions."
    - name: "compliance_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_exceeded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analytical results exceeding regulatory limits — key water quality KPI used by executives to assess systemic compliance risk and prioritize treatment investments."
    - name: "hold_time_non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_time_compliant = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with hold time violations — laboratory operational quality KPI; high rates indicate sample handling failures that invalidate results and trigger re-sampling costs."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured contaminant concentration across all analytical results — used to track trending contaminant levels relative to MCL thresholds over time."
    - name: "avg_percent_recovery"
      expr: AVG(CAST(percent_recovery AS DOUBLE))
      comment: "Average laboratory percent recovery — quality control KPI measuring analytical accuracy; values outside 70–130% indicate method or instrument issues requiring corrective action."
    - name: "avg_relative_percent_difference"
      expr: AVG(CAST(relative_percent_difference AS DOUBLE))
      comment: "Average relative percent difference between duplicate analyses — measures laboratory precision; high RPD values signal reproducibility problems affecting data defensibility."
    - name: "avg_mcl_value"
      expr: AVG(CAST(mcl_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level applicable to results in scope — provides regulatory threshold context for compliance rate interpretation."
    - name: "reporting_required_count"
      expr: COUNT(CASE WHEN reporting_required = TRUE THEN 1 END)
      comment: "Number of results requiring regulatory reporting — drives regulatory submission workload planning and ensures no reportable results are missed."
    - name: "results_below_detection_limit_count"
      expr: COUNT(CASE WHEN result_value < detection_limit THEN 1 END)
      comment: "Number of results where the measured value is below the laboratory detection limit — indicates non-detect frequency, relevant for contaminant occurrence assessments and CCR reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_bacteriological_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bacteriological water quality testing results — tracks coliform, E. coli, and fecal indicator detections, MCL exceedances, and public notification triggers. Critical for Total Coliform Rule (TCR) and Revised Total Coliform Rule (RTCR) compliance."
  source: "`vibe_water_utilities_v1`.`quality`.`bacteriological_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the bacteriological analysis was performed — used for temporal trend analysis and regulatory period compliance tracking."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of bacteriological sample (e.g., routine, repeat, special) — distinguishes routine monitoring from triggered repeat sampling."
    - name: "test_type"
      expr: test_type
      comment: "Bacteriological test type performed (e.g., presence/absence, MPN, membrane filtration) — used for method-level quality analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the bacteriological result — primary dimension for compliance dashboards and regulatory reporting."
    - name: "result_status"
      expr: result_status
      comment: "Operational status of the result record (e.g., final, invalidated, pending) — filters valid results for compliance calculations."
    - name: "mcl_exceeded_flag"
      expr: mcl_exceeded_flag
      comment: "Boolean flag indicating MCL exceedance — primary regulatory alert dimension for bacteriological compliance."
    - name: "public_notification_required_flag"
      expr: public_notification_required_flag
      comment: "Boolean flag indicating whether a public notification is required — directly tied to regulatory public health obligations."
    - name: "rtcr_assessment_level"
      expr: rtcr_assessment_level
      comment: "RTCR assessment level triggered by the result — indicates severity of bacteriological finding under the Revised Total Coliform Rule."
    - name: "repeat_sample_required_flag"
      expr: repeat_sample_required_flag
      comment: "Boolean flag indicating whether a repeat sample is required — drives operational follow-up workload and compliance timeline management."
    - name: "sample_collection_date"
      expr: sample_collection_date
      comment: "Date the bacteriological sample was collected in the field — used for collection-to-analysis turnaround time analysis."
  measures:
    - name: "total_bacteriological_results"
      expr: COUNT(1)
      comment: "Total number of bacteriological test results — baseline monitoring volume metric for TCR/RTCR program scale assessment."
    - name: "mcl_exceedance_count"
      expr: COUNT(CASE WHEN mcl_exceeded_flag = TRUE THEN 1 END)
      comment: "Number of bacteriological results exceeding the MCL — primary public health risk indicator; any exceedance triggers mandatory regulatory response and potential public notification."
    - name: "mcl_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mcl_exceeded_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bacteriological samples exceeding the MCL — executive-level water safety KPI; elevated rates signal systemic distribution system contamination requiring immediate intervention."
    - name: "public_notification_required_count"
      expr: COUNT(CASE WHEN public_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of results triggering mandatory public notification — regulatory obligation tracker; missed notifications result in significant regulatory penalties and public trust damage."
    - name: "total_coliform_positive_count"
      expr: COUNT(CASE WHEN total_coliform_result = 'Positive' THEN 1 END)
      comment: "Number of samples with total coliform detected — indicator of distribution system integrity; used to identify contamination patterns and prioritize flushing or main rehabilitation."
    - name: "e_coli_positive_count"
      expr: COUNT(CASE WHEN e_coli_result = 'Positive' THEN 1 END)
      comment: "Number of samples with E. coli detected — most critical bacteriological safety indicator; any E. coli positive is an acute health risk requiring immediate regulatory notification and corrective action."
    - name: "repeat_sample_trigger_count"
      expr: COUNT(CASE WHEN repeat_sample_required_flag = TRUE THEN 1 END)
      comment: "Number of results requiring repeat sampling — operational workload driver; high repeat rates indicate systemic distribution system issues and increase monitoring program costs."
    - name: "avg_total_coliform_cfu"
      expr: AVG(CAST(total_coliform_cfu AS DOUBLE))
      comment: "Average total coliform colony-forming units per sample — quantitative bacteriological load indicator used to assess distribution system hygiene trends over time."
    - name: "avg_e_coli_cfu"
      expr: AVG(CAST(e_coli_cfu AS DOUBLE))
      comment: "Average E. coli colony-forming units per sample — quantitative fecal contamination indicator; trending upward values signal deteriorating source water or treatment effectiveness."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of bacteriological results requiring regulatory agency reporting — compliance obligation volume metric used to manage reporting deadlines and avoid late-reporting violations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_lead_copper_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead and Copper Rule (LCR) monitoring results — tracks 90th percentile sampling, action level exceedances, customer notifications, and corrosion control treatment status. Directly supports EPA Lead and Copper Rule compliance and public health protection."
  source: "`vibe_water_utilities_v1`.`quality`.`lead_copper_result`"
  dimensions:
    - name: "sample_collection_date"
      expr: sample_collection_date
      comment: "Date the lead/copper sample was collected — used for monitoring period compliance and 90th percentile calculation period scoping."
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the lead/copper sample was analyzed — used for laboratory turnaround time tracking and regulatory submission timeliness."
    - name: "lead_action_level_exceeded"
      expr: lead_action_level_exceeded
      comment: "Boolean flag indicating lead action level exceedance — primary LCR compliance dimension; exceedances trigger mandatory corrosion control and public notification requirements."
    - name: "copper_action_level_exceeded"
      expr: copper_action_level_exceeded
      comment: "Boolean flag indicating copper action level exceedance — LCR compliance dimension for copper; exceedances require corrosion control treatment review."
    - name: "site_tier"
      expr: site_tier
      comment: "LCR site tier classification (Tier 1, 2, 3) — determines sampling priority and regulatory weight; Tier 1 sites (highest risk) are most critical for 90th percentile calculations."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line at the sampling site (e.g., lead, galvanized, copper) — key risk stratification dimension for LCR compliance and service line replacement programs."
    - name: "corrosion_control_treatment_status"
      expr: corrosion_control_treatment_status
      comment: "Status of corrosion control treatment at the sampling site — indicates whether treatment is in place, optimized, or under review; directly linked to lead/copper action level outcomes."
    - name: "included_in_90th_percentile"
      expr: included_in_90th_percentile
      comment: "Boolean flag indicating whether the sample is included in the 90th percentile calculation — scopes the regulatory compliance sample set."
    - name: "customer_notification_sent"
      expr: customer_notification_sent
      comment: "Boolean flag indicating whether the customer was notified of an exceedance — tracks regulatory notification obligation fulfillment."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of the lead/copper result — filters valid results for regulatory calculations and identifies samples requiring re-analysis."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting for this result — tracks submission completeness and identifies overdue regulatory reports."
  measures:
    - name: "total_lcr_samples"
      expr: COUNT(1)
      comment: "Total number of Lead and Copper Rule samples collected — baseline metric for LCR monitoring program completeness and sampling plan adherence."
    - name: "lead_action_level_exceedance_count"
      expr: COUNT(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 END)
      comment: "Number of samples exceeding the lead action level (15 ppb) — primary LCR public health KPI; any exceedance triggers mandatory corrosion control review, public notification, and potential service line replacement program."
    - name: "lead_action_level_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LCR samples exceeding the lead action level — executive-level public health risk KPI; used to assess whether the 90th percentile threshold is at risk and to justify corrosion control investment."
    - name: "copper_action_level_exceedance_count"
      expr: COUNT(CASE WHEN copper_action_level_exceeded = TRUE THEN 1 END)
      comment: "Number of samples exceeding the copper action level (1.3 mg/L) — LCR compliance indicator for copper; exceedances require corrosion control treatment optimization."
    - name: "avg_lead_result_ppb"
      expr: AVG(CAST(lead_result_ppb AS DOUBLE))
      comment: "Average lead concentration in ppb across all LCR samples — quantitative lead exposure indicator; trending values inform corrosion control effectiveness and service line replacement prioritization."
    - name: "avg_copper_result_ppb"
      expr: AVG(CAST(copper_result_ppb AS DOUBLE))
      comment: "Average copper concentration in ppb across all LCR samples — quantitative copper exposure indicator used to assess corrosion control treatment performance."
    - name: "customer_notification_pending_count"
      expr: COUNT(CASE WHEN lead_action_level_exceeded = TRUE AND customer_notification_sent = FALSE THEN 1 END)
      comment: "Number of lead action level exceedances where customer notification has not yet been sent — regulatory obligation gap metric; unresolved notifications represent immediate compliance risk and potential enforcement action."
    - name: "samples_in_90th_percentile_count"
      expr: COUNT(CASE WHEN included_in_90th_percentile = TRUE THEN 1 END)
      comment: "Number of samples included in the 90th percentile regulatory calculation — ensures the required sample set size is met for valid LCR compliance determination."
    - name: "lead_service_line_site_count"
      expr: COUNT(CASE WHEN service_line_material = 'Lead' THEN 1 END)
      comment: "Number of LCR sampling sites with confirmed lead service lines — critical infrastructure risk metric driving service line replacement program prioritization and capital investment decisions."
    - name: "avg_stagnation_time_hours"
      expr: AVG(CAST(stagnation_time_hours AS DOUBLE))
      comment: "Average stagnation time in hours for LCR samples — sampling protocol quality metric; insufficient stagnation time invalidates first-draw samples and undermines 90th percentile compliance calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_exceedance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water quality regulatory exceedances — tracks all instances where analytical or bacteriological results exceeded applicable contaminant limits. Central compliance risk register for regulatory enforcement, violation tracking, and corrective action management."
  source: "`vibe_water_utilities_v1`.`quality`.`exceedance`"
  dimensions:
    - name: "exceedance_id"
      expr: exceedance_id
      comment: "Primary key of the exceedance record — used for unique exceedance identification and cross-system traceability."
    - name: "contaminant_id"
      expr: contaminant_id
      comment: "Foreign key to the contaminant that was exceeded — enables exceedance analysis by contaminant type and regulatory program."
    - name: "contaminant_limit_id"
      expr: contaminant_limit_id
      comment: "Foreign key to the specific contaminant limit that was exceeded — links exceedances to the applicable regulatory standard for compliance reporting."
    - name: "sampling_point_id"
      expr: sampling_point_id
      comment: "Foreign key to the sampling point where the exceedance was detected — enables geographic and infrastructure-level exceedance hotspot analysis."
  measures:
    - name: "total_exceedances"
      expr: COUNT(1)
      comment: "Total number of regulatory exceedances recorded — primary compliance risk volume metric; used by executives to track overall regulatory violation exposure and trend direction."
    - name: "distinct_contaminants_exceeded"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants with at least one exceedance — breadth-of-risk indicator; a high count signals systemic water quality issues across multiple regulatory programs rather than isolated incidents."
    - name: "distinct_sampling_points_with_exceedances"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling points with at least one exceedance — geographic risk spread indicator; used to identify contamination hotspots and prioritize infrastructure rehabilitation investments."
    - name: "distinct_contaminant_limits_exceeded"
      expr: COUNT(DISTINCT contaminant_limit_id)
      comment: "Number of distinct contaminant limits exceeded — regulatory program breadth metric; indicates how many separate regulatory standards are being violated, informing compliance program prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_water_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water sample collection and field measurement metrics — tracks sample collection volumes, field parameter quality, hold time compliance, and sampling program operational performance. Supports both regulatory compliance and operational water quality management."
  source: "`vibe_water_utilities_v1`.`quality`.`water_sample`"
  dimensions:
    - name: "sample_collection_date"
      expr: DATE(collection_timestamp)
      comment: "Date the water sample was collected — primary time dimension for sampling program trend analysis and regulatory period reporting."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of water sample (e.g., routine, repeat, special investigation) — distinguishes regulatory monitoring samples from operational and investigative samples."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix type (e.g., drinking water, raw water, wastewater) — enables cross-matrix water quality comparison and regulatory program scoping."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (e.g., collected, submitted, analyzed, rejected) — tracks sample lifecycle and identifies bottlenecks in the analytical workflow."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample collection (e.g., compliance monitoring, operational, investigative) — enables purpose-driven performance analysis and cost allocation."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the sample was collected (e.g., TCR, LCR, Surface Water Treatment Rule) — enables program-level compliance monitoring and reporting."
    - name: "quality_control_flag"
      expr: quality_control_flag
      comment: "Boolean flag indicating whether the sample has a quality control issue — used to filter valid samples for compliance calculations and identify QC failure patterns."
    - name: "requested_analysis_group"
      expr: requested_analysis_group
      comment: "Group of analyses requested for the sample (e.g., metals, organics, microbiology) — enables workload analysis by analytical category and laboratory capacity planning."
  measures:
    - name: "total_samples_collected"
      expr: COUNT(1)
      comment: "Total number of water samples collected — baseline sampling program volume metric used to assess monitoring program completeness against regulatory requirements."
    - name: "qc_flagged_sample_count"
      expr: COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END)
      comment: "Number of samples flagged for quality control issues — operational quality KPI; high QC flag rates indicate field collection or chain-of-custody problems that invalidate results and require costly re-sampling."
    - name: "qc_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with quality control flags — sampling program quality rate KPI; used by operations managers to assess field team performance and identify systemic collection protocol failures."
    - name: "avg_field_turbidity_ntu"
      expr: AVG(CAST(field_turbidity_ntu AS DOUBLE))
      comment: "Average field turbidity in NTU at time of sample collection — real-time water quality indicator; elevated turbidity signals treatment or distribution system issues and may indicate regulatory threshold risk."
    - name: "avg_field_chlorine_residual_mg_l"
      expr: AVG(CAST(field_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average free chlorine residual in mg/L at sample collection — disinfection effectiveness KPI; low residuals indicate distribution system vulnerability to bacteriological contamination."
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field pH at sample collection — water chemistry stability indicator; pH outside the 6.5–8.5 range triggers regulatory action and affects corrosion control treatment effectiveness."
    - name: "avg_field_temperature_c"
      expr: AVG(CAST(field_temperature_c AS DOUBLE))
      comment: "Average field water temperature in Celsius at sample collection — operational parameter affecting disinfection efficacy, bacteriological growth risk, and chemical reaction rates in distribution."
    - name: "distinct_sampling_schedules_served"
      expr: COUNT(DISTINCT sampling_schedule_id)
      comment: "Number of distinct sampling schedules served by collected samples — monitoring program coverage metric; gaps indicate schedules with missing samples that may constitute regulatory monitoring violations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_sampling_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling schedule compliance and program management metrics — tracks monitoring schedule adherence, compliance deadlines, budget utilization, and violation flags across all regulatory sampling programs. Supports proactive compliance management and resource planning."
  source: "`vibe_water_utilities_v1`.`quality`.`sampling_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the sampling schedule (e.g., active, completed, suspended) — primary operational dimension for schedule management and compliance oversight."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of sampling schedule (e.g., routine, triggered, special) — distinguishes regulatory monitoring types for program-level performance analysis."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency (e.g., daily, weekly, quarterly, annual) — used to assess schedule intensity and resource allocation requirements."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the sampling schedule — primary compliance dimension; non-compliant schedules represent active regulatory violations."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Boolean flag indicating a monitoring violation on this schedule — direct regulatory risk indicator; any flagged schedule requires immediate corrective action."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the sampling schedule — used to triage resource allocation and ensure high-priority regulatory schedules are fulfilled first."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Boolean flag indicating whether the schedule has a seasonal adjustment — used for seasonal workload planning and regulatory waiver tracking."
    - name: "monitoring_period_start_date"
      expr: monitoring_period_start_date
      comment: "Start date of the monitoring period — used to scope schedule performance analysis to specific regulatory monitoring periods."
    - name: "monitoring_period_end_date"
      expr: monitoring_period_end_date
      comment: "End date of the monitoring period — used with start date to define regulatory monitoring windows for compliance assessment."
  measures:
    - name: "total_sampling_schedules"
      expr: COUNT(1)
      comment: "Total number of sampling schedules — baseline metric for monitoring program scale and regulatory obligation inventory."
    - name: "violation_flagged_schedule_count"
      expr: COUNT(CASE WHEN violation_flag = TRUE THEN 1 END)
      comment: "Number of sampling schedules with active monitoring violations — primary regulatory risk KPI; each flagged schedule represents a potential regulatory enforcement action and financial penalty exposure."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sampling schedules with monitoring violations — executive-level compliance program health KPI; used to assess systemic monitoring program failures and prioritize corrective investments."
    - name: "total_annual_budget_allocation"
      expr: SUM(CAST(annual_budget_allocation AS DOUBLE))
      comment: "Total annual budget allocated across all sampling schedules — financial planning KPI for water quality monitoring program cost management and budget justification."
    - name: "avg_cost_per_sample"
      expr: AVG(CAST(cost_per_sample AS DOUBLE))
      comment: "Average cost per sample across all sampling schedules — operational efficiency KPI; used to benchmark laboratory and field costs, identify high-cost programs, and optimize monitoring program economics."
    - name: "non_compliant_schedule_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of sampling schedules in non-compliant status — regulatory enforcement risk metric; non-compliant schedules require immediate management attention to avoid escalating violations and penalties."
    - name: "overdue_sample_schedule_count"
      expr: COUNT(CASE WHEN next_scheduled_sample_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END)
      comment: "Number of active sampling schedules where the next scheduled sample date has passed without collection — operational compliance gap metric; overdue samples directly constitute monitoring violations under most regulatory programs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_sampling_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling point network metrics — tracks the distribution, status, and operational characteristics of water quality monitoring locations across the distribution system. Supports monitoring network adequacy assessment, regulatory coverage analysis, and infrastructure planning."
  source: "`vibe_water_utilities_v1`.`quality`.`sampling_point`"
  dimensions:
    - name: "sampling_point_status"
      expr: sampling_point_status
      comment: "Operational status of the sampling point (e.g., active, decommissioned, suspended) — primary dimension for network availability analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of sampling location (e.g., entry point, distribution, source water) — used to analyze monitoring coverage by system zone and regulatory requirement."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source served by the sampling point (e.g., surface water, groundwater) — regulatory program applicability dimension; different source types have different monitoring requirements."
    - name: "primary_contaminant_group"
      expr: primary_contaminant_group
      comment: "Primary contaminant group monitored at this point (e.g., microbiology, inorganics, disinfection byproducts) — used to assess monitoring network coverage by contaminant category."
    - name: "regulatory_zone"
      expr: regulatory_zone
      comment: "Regulatory zone designation of the sampling point — used for zone-level compliance analysis and regulatory reporting boundary management."
    - name: "treatment_stage"
      expr: treatment_stage
      comment: "Treatment stage at which the sampling point is located (e.g., raw, post-treatment, distribution) — enables treatment effectiveness analysis by monitoring stage."
    - name: "ccr_reporting_flag"
      expr: ccr_reporting_flag
      comment: "Boolean flag indicating whether this sampling point is included in Consumer Confidence Report (CCR) reporting — scopes CCR compliance monitoring network."
    - name: "dmr_reporting_flag"
      expr: dmr_reporting_flag
      comment: "Boolean flag indicating whether this sampling point is included in Discharge Monitoring Report (DMR) reporting — scopes NPDES compliance monitoring network."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency at this point — used for monitoring workload planning and schedule adequacy assessment."
  measures:
    - name: "total_sampling_points"
      expr: COUNT(1)
      comment: "Total number of sampling points in the monitoring network — baseline network scale metric for regulatory coverage adequacy assessment."
    - name: "active_sampling_point_count"
      expr: COUNT(CASE WHEN sampling_point_status = 'Active' THEN 1 END)
      comment: "Number of currently active sampling points — operational network availability metric; declining active counts may indicate monitoring network gaps requiring regulatory attention."
    - name: "ccr_reporting_point_count"
      expr: COUNT(CASE WHEN ccr_reporting_flag = TRUE THEN 1 END)
      comment: "Number of sampling points included in CCR reporting — Consumer Confidence Report coverage metric; ensures all required monitoring locations are represented in annual public reporting."
    - name: "dmr_reporting_point_count"
      expr: COUNT(CASE WHEN dmr_reporting_flag = TRUE THEN 1 END)
      comment: "Number of sampling points included in DMR/NPDES reporting — discharge monitoring coverage metric; ensures all permitted discharge monitoring locations are tracked for NPDES compliance."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute across sampling points — hydraulic characterization metric used to assess representative sampling conditions and identify low-flow points with elevated contamination risk."
    - name: "avg_residence_time_hours"
      expr: AVG(CAST(residence_time_hours AS DOUBLE))
      comment: "Average water residence time in hours at sampling points — distribution system water age indicator; high residence times correlate with disinfectant decay, bacteriological regrowth risk, and DBP formation."
    - name: "overdue_for_sampling_count"
      expr: COUNT(CASE WHEN next_scheduled_sample_date < CURRENT_DATE() AND sampling_point_status = 'Active' THEN 1 END)
      comment: "Number of active sampling points past their next scheduled sample date — monitoring compliance gap metric; overdue points represent potential monitoring violations and regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_contaminant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contaminant regulatory profile metrics — tracks the portfolio of regulated contaminants, MCL/MCLG thresholds, treatment technique requirements, and public notification obligations. Supports regulatory program management, CCR reporting, and treatment investment prioritization."
  source: "`vibe_water_utilities_v1`.`quality`.`contaminant`"
  dimensions:
    - name: "contaminant_type"
      expr: contaminant_type
      comment: "Type of contaminant (e.g., microbiological, inorganic, organic, radiological) — primary regulatory classification dimension for program-level analysis."
    - name: "contaminant_status"
      expr: contaminant_status
      comment: "Regulatory status of the contaminant (e.g., regulated, proposed, unregulated) — used to scope active regulatory obligations versus emerging contaminant monitoring."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program governing this contaminant (e.g., SDWA, NPDES, RCRA) — enables program-level compliance portfolio analysis."
    - name: "health_effect_category"
      expr: health_effect_category
      comment: "Category of health effect associated with the contaminant (e.g., carcinogenic, neurological, gastrointestinal) — risk prioritization dimension for public health impact assessment."
    - name: "treatment_technique_required"
      expr: treatment_technique_required
      comment: "Boolean flag indicating whether a treatment technique is required instead of an MCL — identifies contaminants requiring operational treatment controls rather than numeric limits."
    - name: "ccr_reporting_required"
      expr: ccr_reporting_required
      comment: "Boolean flag indicating whether this contaminant must be reported in the Consumer Confidence Report — scopes annual public disclosure obligations."
    - name: "public_notification_tier"
      expr: public_notification_tier
      comment: "Public notification tier (Tier 1, 2, 3) for this contaminant — indicates urgency of public notification required upon exceedance; Tier 1 requires immediate notification within 24 hours."
    - name: "source_category"
      expr: source_category
      comment: "Source category of the contaminant (e.g., industrial, agricultural, naturally occurring) — used for source water protection program prioritization and watershed management."
    - name: "wastewater_parameter"
      expr: wastewater_parameter
      comment: "Boolean flag indicating whether this contaminant is a wastewater monitoring parameter — distinguishes drinking water from wastewater regulatory obligations."
    - name: "monitoring_frequency_code"
      expr: monitoring_frequency_code
      comment: "Required monitoring frequency code for this contaminant — used for monitoring program workload planning and schedule generation."
  measures:
    - name: "total_regulated_contaminants"
      expr: COUNT(1)
      comment: "Total number of contaminants in the regulatory portfolio — baseline metric for regulatory obligation scope; used to assess monitoring program comprehensiveness and resource requirements."
    - name: "treatment_technique_required_count"
      expr: COUNT(CASE WHEN treatment_technique_required = TRUE THEN 1 END)
      comment: "Number of contaminants requiring treatment techniques rather than MCL compliance — operational treatment obligation metric; drives treatment plant design, operational protocol, and capital investment decisions."
    - name: "ccr_reportable_contaminant_count"
      expr: COUNT(CASE WHEN ccr_reporting_required = TRUE THEN 1 END)
      comment: "Number of contaminants requiring Consumer Confidence Report disclosure — annual public reporting obligation scope metric; ensures all required contaminants are included in CCR submissions."
    - name: "tier1_notification_contaminant_count"
      expr: COUNT(CASE WHEN public_notification_tier = 'Tier 1' THEN 1 END)
      comment: "Number of contaminants requiring Tier 1 (immediate, within 24 hours) public notification upon exceedance — highest-urgency public health risk portfolio metric; used to ensure emergency notification protocols are in place."
    - name: "avg_mcl_value"
      expr: AVG(CAST(mcl_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level across regulated contaminants — regulatory threshold benchmark; used in conjunction with monitoring results to assess portfolio-level compliance margin."
    - name: "avg_action_level_value"
      expr: AVG(CAST(action_level_value AS DOUBLE))
      comment: "Average action level value across contaminants with action levels — regulatory action threshold benchmark used for LCR and other action-level-based compliance program management."
$$;