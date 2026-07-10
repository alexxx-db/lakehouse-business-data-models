-- Metric views for domain: quality | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_analytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core water quality analytical results KPIs tracking compliance rates, detection frequencies, and result quality for regulatory reporting and operational decision-making."
  source: "`vibe_water_utilities_v1`.`quality`.`analytical_result`"
  dimensions:
    - name: "analytical_method"
      expr: analytical_method
      comment: "Analytical method used for the test — enables comparison of compliance rates and detection limits across methods."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Matrix type of the sample (e.g., drinking water, groundwater, surface water) — critical for segmenting compliance results."
    - name: "result_status"
      expr: result_status
      comment: "Validation/acceptance status of the result — used to filter actionable vs. rejected results."
    - name: "data_validation_level"
      expr: data_validation_level
      comment: "Level of QA/QC validation applied to the result — drives confidence in compliance determinations."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month of analysis — enables trend analysis of compliance rates over time."
    - name: "compliance_exceeded_flag"
      expr: compliance_exceeded
      comment: "Whether the result exceeded the regulatory limit — primary compliance segmentation dimension."
    - name: "reporting_required_flag"
      expr: reporting_required
      comment: "Whether the result triggers a regulatory reporting obligation — used to prioritize follow-up actions."
  measures:
    - name: "total_analytical_results"
      expr: COUNT(1)
      comment: "Total number of analytical results — baseline volume metric for laboratory throughput and monitoring program coverage."
    - name: "exceedance_count"
      expr: SUM(CASE WHEN compliance_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results that exceeded regulatory limits — primary compliance risk indicator driving enforcement and public notification decisions."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_exceeded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analytical results exceeding regulatory limits — key compliance KPI for executive dashboards and regulatory submissions."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured contaminant concentration — tracks systemic contamination trends and informs treatment optimization decisions."
    - name: "avg_mcl_utilization_pct"
      expr: ROUND(100.0 * AVG(result_value / NULLIF(mcl_value, 0)), 2)
      comment: "Average result value as a percentage of the MCL — early warning indicator showing how close the system is operating to regulatory limits."
    - name: "avg_percent_recovery"
      expr: AVG(CAST(percent_recovery AS DOUBLE))
      comment: "Average QC percent recovery across analytical results — measures laboratory accuracy and method performance for QA/QC oversight."
    - name: "hold_time_non_compliant_count"
      expr: SUM(CASE WHEN hold_time_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Number of results with non-compliant hold times — identifies sample integrity failures that may invalidate compliance determinations."
    - name: "reporting_required_count"
      expr: SUM(CASE WHEN reporting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results requiring regulatory reporting — drives workload planning for compliance reporting staff."
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average detection limit across results — monitors analytical sensitivity and method capability for regulatory program adequacy."
    - name: "distinct_contaminants_tested"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants tested — measures breadth of monitoring program coverage against regulatory requirements."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_bacteriological_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bacteriological monitoring KPIs for RTCR compliance, coliform detection rates, and public health risk indicators — directly tied to regulatory reporting and public notification triggers."
  source: "`vibe_water_utilities_v1`.`quality`.`bacteriological_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the bacteriological result — primary dimension for compliance reporting."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of bacteriological sample (routine, repeat, special) — essential for RTCR compliance tracking."
    - name: "test_type"
      expr: test_type
      comment: "Bacteriological test type (P/A, MPN, membrane filtration) — affects interpretation of results."
    - name: "rtcr_assessment_level"
      expr: rtcr_assessment_level
      comment: "RTCR assessment level triggered by the result — drives corrective action and public notification requirements."
    - name: "result_status"
      expr: result_status
      comment: "Validation status of the bacteriological result — used to filter actionable results."
    - name: "sample_collection_month"
      expr: DATE_TRUNC('MONTH', sample_collection_date)
      comment: "Month of sample collection — enables seasonal trend analysis of bacteriological contamination."
    - name: "mcl_exceeded_flag"
      expr: mcl_exceeded_flag
      comment: "Whether the MCL was exceeded — primary public health risk indicator."
  measures:
    - name: "total_bacteriological_samples"
      expr: COUNT(1)
      comment: "Total bacteriological samples analyzed — baseline for monitoring program completeness vs. required sample counts."
    - name: "total_coliform_positive_count"
      expr: SUM(CASE WHEN total_coliform_result = 'Positive' THEN 1 ELSE 0 END)
      comment: "Number of total coliform positive results — primary RTCR compliance trigger metric."
    - name: "total_coliform_positive_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN total_coliform_result = 'Positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with total coliform positive — key RTCR compliance KPI; exceeding 5% triggers Level 1 Assessment."
    - name: "e_coli_positive_count"
      expr: SUM(CASE WHEN e_coli_result = 'Positive' THEN 1 ELSE 0 END)
      comment: "Number of E. coli positive results — immediate public health emergency indicator requiring Tier 1 public notification."
    - name: "mcl_exceedance_count"
      expr: SUM(CASE WHEN mcl_exceeded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results exceeding the MCL — drives enforcement actions and public notification obligations."
    - name: "public_notification_required_count"
      expr: SUM(CASE WHEN public_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results triggering public notification requirements — critical public health compliance metric."
    - name: "repeat_sample_required_count"
      expr: SUM(CASE WHEN repeat_sample_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results requiring repeat sampling — measures RTCR follow-up workload and compliance response burden."
    - name: "avg_total_coliform_cfu"
      expr: AVG(CAST(total_coliform_cfu AS DOUBLE))
      comment: "Average total coliform CFU concentration — tracks systemic bacteriological contamination levels over time."
    - name: "avg_e_coli_cfu"
      expr: AVG(CAST(e_coli_cfu AS DOUBLE))
      comment: "Average E. coli CFU concentration — monitors fecal contamination severity for treatment optimization."
    - name: "regulatory_reporting_required_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results requiring state/primacy agency reporting — drives compliance reporting workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_ccr_detected_contaminant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Confidence Report (CCR) contaminant detection KPIs — tracks detected contaminant levels vs. MCLs, violation rates, and public notification requirements for annual CCR publication."
  source: "`vibe_water_utilities_v1`.`quality`.`contaminant`"
  dimensions:
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the contaminant is monitored (SDWA, LCR, DBP Rule) — enables program-level compliance tracking."
  measures:
    - name: "total_detected_contaminants"
      expr: COUNT(1)
      comment: "Total number of detected contaminant records in CCR — measures breadth of contamination detected in the distribution system."
    - name: "distinct_contaminants_detected"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants detected — measures contamination diversity and monitoring program scope."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_ct_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disinfection CT (concentration × time) calculation KPIs for Surface Water Treatment Rule compliance — tracks log inactivation credits, CT ratios, and disinfection adequacy at treatment facilities."
  source: "`vibe_water_utilities_v1`.`quality`.`ct_calculation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "CT compliance status — primary SWTR compliance dimension for regulatory reporting."
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant used (chlorine, chloramine, UV, ozone) — affects CT requirements and inactivation credit calculations."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the CT calculation — ensures only validated data drives compliance determinations."
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_timestamp)
      comment: "Month of CT calculation — enables seasonal trend analysis of disinfection performance."
    - name: "mor_reporting_period"
      expr: mor_reporting_period
      comment: "Monthly Operating Report period — aligns CT metrics with regulatory reporting cycles."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the CT calculation — used to filter out suspect data from compliance reporting."
  measures:
    - name: "total_ct_calculations"
      expr: COUNT(1)
      comment: "Total CT calculations performed — baseline for monitoring program completeness and SCADA data availability."
    - name: "ct_non_compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of CT calculations failing compliance — primary SWTR violation indicator requiring immediate operational response."
    - name: "ct_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CT calculations meeting SWTR requirements — key treatment performance KPI for regulatory submissions and executive dashboards."
    - name: "avg_ct_ratio_giardia"
      expr: AVG(CAST(ct_ratio_giardia AS DOUBLE))
      comment: "Average CT ratio for Giardia inactivation — measures disinfection margin above the 3-log requirement; values below 1.0 indicate compliance risk."
    - name: "avg_ct_ratio_virus"
      expr: AVG(CAST(ct_ratio_virus AS DOUBLE))
      comment: "Average CT ratio for virus inactivation — measures disinfection margin above the 4-log requirement for surface water systems."
    - name: "avg_log_inactivation_giardia"
      expr: AVG(CAST(log_inactivation_giardia AS DOUBLE))
      comment: "Average log inactivation credit achieved for Giardia — direct SWTR compliance metric; must meet or exceed 3-log."
    - name: "avg_log_inactivation_virus"
      expr: AVG(CAST(log_inactivation_virus AS DOUBLE))
      comment: "Average log inactivation credit achieved for viruses — direct SWTR compliance metric; must meet or exceed 4-log."
    - name: "avg_calculated_ct_value"
      expr: AVG(CAST(calculated_ct_value_mg_min_l AS DOUBLE))
      comment: "Average calculated CT value (mg·min/L) — operational benchmark for disinfection dose adequacy across treatment facilities."
    - name: "avg_water_temperature_c"
      expr: AVG(CAST(water_temperature_c AS DOUBLE))
      comment: "Average water temperature during CT calculations — critical operational parameter as lower temperatures require higher CT values for equivalent inactivation."
    - name: "min_ct_ratio_giardia"
      expr: MIN(ct_ratio_giardia)
      comment: "Minimum CT ratio for Giardia — identifies worst-case disinfection performance periods requiring immediate operational intervention."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_dbp_monitoring_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disinfection Byproduct (DBP) monitoring KPIs for TTHM and HAA5 LRAA compliance under the Stage 2 DBP Rule — tracks running annual averages, MCL exceedances, and compliance status."
  source: "`vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event`"
  dimensions:
    - name: "tthm_compliance_status"
      expr: tthm_compliance_status
      comment: "TTHM LRAA compliance status — primary Stage 2 DBP Rule compliance dimension for TTHM."
    - name: "haa5_compliance_status"
      expr: haa5_compliance_status
      comment: "HAA5 LRAA compliance status — primary Stage 2 DBP Rule compliance dimension for HAA5."
    - name: "sample_type"
      expr: sample_type
      comment: "Sample type (routine, special, confirmation) — affects how results are used in LRAA calculations."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency — enables compliance gap analysis against monitoring schedules."
    - name: "monitoring_period_start_month"
      expr: DATE_TRUNC('MONTH', monitoring_period_start_date)
      comment: "Start of monitoring period — enables quarterly and annual trend analysis of DBP levels."
    - name: "reported_to_state_flag"
      expr: reported_to_state_flag
      comment: "Whether the result has been reported to the state primacy agency — tracks regulatory reporting compliance."
  measures:
    - name: "total_dbp_monitoring_events"
      expr: COUNT(1)
      comment: "Total DBP monitoring events — baseline for monitoring program completeness vs. required sampling frequency."
    - name: "tthm_mcl_exceedance_count"
      expr: SUM(CASE WHEN tthm_compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of monitoring events with TTHM LRAA exceeding the MCL (80 µg/L) — primary Stage 2 DBP Rule violation indicator."
    - name: "haa5_mcl_exceedance_count"
      expr: SUM(CASE WHEN haa5_compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of monitoring events with HAA5 LRAA exceeding the MCL (60 µg/L) — primary Stage 2 DBP Rule violation indicator."
    - name: "avg_tthm_lraa_ug_l"
      expr: AVG(CAST(tthm_lraa_ug_l AS DOUBLE))
      comment: "Average TTHM Locational Running Annual Average — tracks system-wide TTHM trend relative to the 80 µg/L MCL."
    - name: "avg_haa5_lraa_ug_l"
      expr: AVG(CAST(haa5_lraa_ug_l AS DOUBLE))
      comment: "Average HAA5 Locational Running Annual Average — tracks system-wide HAA5 trend relative to the 60 µg/L MCL."
    - name: "max_tthm_lraa_ug_l"
      expr: MAX(tthm_lraa_ug_l)
      comment: "Maximum TTHM LRAA across all monitoring locations — identifies highest-risk locations for targeted treatment optimization."
    - name: "max_haa5_lraa_ug_l"
      expr: MAX(haa5_lraa_ug_l)
      comment: "Maximum HAA5 LRAA across all monitoring locations — identifies highest-risk locations for targeted treatment optimization."
    - name: "avg_tthm_mcl_utilization_pct"
      expr: ROUND(100.0 * AVG(tthm_lraa_ug_l / NULLIF(tthm_mcl_ug_l, 0)), 2)
      comment: "Average TTHM LRAA as percentage of MCL — early warning indicator of proximity to regulatory limit across the distribution system."
    - name: "avg_haa5_mcl_utilization_pct"
      expr: ROUND(100.0 * AVG(haa5_lraa_ug_l / NULLIF(haa5_mcl_ug_l, 0)), 2)
      comment: "Average HAA5 LRAA as percentage of MCL — early warning indicator of proximity to regulatory limit across the distribution system."
    - name: "unreported_to_state_count"
      expr: SUM(CASE WHEN reported_to_state_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of DBP monitoring events not yet reported to the state — identifies regulatory reporting backlog requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_effluent_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wastewater effluent quality KPIs for NPDES permit compliance — tracks permit limit exceedances, pollutant concentrations, and DMR reporting status for discharge monitoring."
  source: "`vibe_water_utilities_v1`.`quality`.`effluent_quality`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "NPDES permit compliance status for the effluent discharge — primary regulatory compliance dimension."
    - name: "sample_type"
      expr: sample_type
      comment: "Sample type (composite, grab, continuous) — affects regulatory validity of the measurement."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period — aligns effluent metrics with monthly NPDES reporting cycles."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge — enables seasonal trend analysis of effluent quality."
    - name: "npdes_permit_number"
      expr: npdes_permit_number
      comment: "NPDES permit number — enables permit-level compliance tracking across multiple discharge points."
  measures:
    - name: "total_effluent_samples"
      expr: COUNT(1)
      comment: "Total effluent quality samples — baseline for monitoring program completeness vs. NPDES permit requirements."
    - name: "permit_exceedance_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of effluent samples exceeding NPDES permit limits — primary permit compliance violation indicator driving enforcement risk."
    - name: "permit_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of effluent samples meeting all NPDES permit limits — key WWTP performance KPI for regulatory submissions and executive reporting."
    - name: "avg_bod5_mg_l"
      expr: AVG(CAST(bod5_mg_l AS DOUBLE))
      comment: "Average BOD5 concentration in effluent — primary organic loading indicator for WWTP treatment performance."
    - name: "avg_tss_mg_l"
      expr: AVG(CAST(tss_mg_l AS DOUBLE))
      comment: "Average TSS concentration in effluent — key solids removal performance indicator for NPDES compliance."
    - name: "avg_total_nitrogen_mg_l"
      expr: AVG(CAST(total_nitrogen_mg_l AS DOUBLE))
      comment: "Average total nitrogen in effluent — nutrient loading indicator for receiving water quality and permit compliance."
    - name: "avg_total_phosphorus_mg_l"
      expr: AVG(CAST(total_phosphorus_mg_l AS DOUBLE))
      comment: "Average total phosphorus in effluent — nutrient loading indicator critical for eutrophication prevention and permit compliance."
    - name: "avg_flow_rate_mgd"
      expr: AVG(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Average effluent flow rate (MGD) — operational capacity utilization metric for WWTP planning and permit compliance."
    - name: "bod5_permit_exceedance_count"
      expr: SUM(CASE WHEN bod5_mg_l > bod5_permit_limit_mg_l THEN 1 ELSE 0 END)
      comment: "Number of samples where BOD5 exceeded the permit limit — specific permit parameter violation count for enforcement tracking."
    - name: "tss_permit_exceedance_count"
      expr: SUM(CASE WHEN tss_mg_l > tss_permit_limit_mg_l THEN 1 ELSE 0 END)
      comment: "Number of samples where TSS exceeded the permit limit — specific permit parameter violation count for enforcement tracking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_lead_copper_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead and Copper Rule (LCR) monitoring KPIs — tracks 90th percentile exceedances, action level violations, customer notification compliance, and service line material risk for public health protection."
  source: "`vibe_water_utilities_v1`.`quality`.`lead_copper_result`"
  dimensions:
    - name: "site_tier"
      expr: site_tier
      comment: "LCR sampling site tier (Tier 1, 2, 3) — higher tiers represent higher-risk sites; required for 90th percentile calculation."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Service line material (lead, galvanized, copper, unknown) — primary risk stratification dimension for LCR compliance and LSL replacement planning."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of the result — used to filter valid results for 90th percentile calculations."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Regulatory reporting status — tracks submission completeness to primacy agency."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month of analysis — enables monitoring period trend analysis."
    - name: "lead_action_level_exceeded_flag"
      expr: lead_action_level_exceeded
      comment: "Whether the lead action level (15 ppb) was exceeded — primary LCR compliance flag."
    - name: "copper_action_level_exceeded_flag"
      expr: copper_action_level_exceeded
      comment: "Whether the copper action level (1,300 ppb) was exceeded — primary LCR compliance flag."
  measures:
    - name: "total_lcr_samples"
      expr: COUNT(1)
      comment: "Total LCR samples collected — baseline for monitoring program completeness vs. required sample counts per monitoring period."
    - name: "lead_action_level_exceedance_count"
      expr: SUM(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of samples exceeding the lead action level (15 ppb) — primary LCR violation indicator triggering corrosion control and public notification requirements."
    - name: "copper_action_level_exceedance_count"
      expr: SUM(CASE WHEN copper_action_level_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of samples exceeding the copper action level (1,300 ppb) — LCR violation indicator for corrosion control evaluation."
    - name: "avg_lead_result_ppb"
      expr: AVG(CAST(lead_result_ppb AS DOUBLE))
      comment: "Average lead concentration across all LCR samples — tracks systemic lead exposure risk and corrosion control effectiveness."
    - name: "avg_copper_result_ppb"
      expr: AVG(CAST(copper_result_ppb AS DOUBLE))
      comment: "Average copper concentration across all LCR samples — tracks corrosion control treatment effectiveness."
    - name: "max_lead_result_ppb"
      expr: MAX(lead_result_ppb)
      comment: "Maximum lead concentration detected — identifies highest-risk individual sites requiring priority remediation."
    - name: "customer_notification_sent_count"
      expr: SUM(CASE WHEN customer_notification_sent = TRUE THEN 1 ELSE 0 END)
      comment: "Number of customers notified of lead exceedances — tracks compliance with LCR customer notification requirements."
    - name: "customer_notification_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_sent = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of lead exceedances where customer notification was sent — measures compliance with mandatory notification requirements."
    - name: "included_in_90th_percentile_count"
      expr: SUM(CASE WHEN included_in_90th_percentile = TRUE THEN 1 ELSE 0 END)
      comment: "Number of samples included in the 90th percentile calculation — validates sample set completeness for regulatory 90th percentile determination."
    - name: "hold_time_non_compliant_count"
      expr: SUM(CASE WHEN holding_time_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Number of LCR samples with non-compliant hold times — identifies sample integrity failures that may invalidate regulatory results."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_turbidity_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turbidity monitoring KPIs for Surface Water Treatment Rule and LT2 compliance — tracks filter performance, exceedance rates, and alarm events at treatment facilities."
  source: "`vibe_water_utilities_v1`.`quality`.`turbidity_reading`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Turbidity compliance status — primary SWTR/LT2 compliance dimension."
    - name: "measurement_location_type"
      expr: measurement_location_type
      comment: "Location type of turbidity measurement (combined filter effluent, individual filter, source water) — determines applicable regulatory limits."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Turbidity measurement method (nephelometric, online, grab) — affects regulatory validity of readings."
    - name: "data_quality_code"
      expr: data_quality_code
      comment: "Data quality code for the reading — used to filter suspect data from compliance calculations."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of turbidity measurement — enables seasonal trend analysis and monthly compliance reporting."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the turbidity reading exceeded the regulatory limit — primary compliance flag."
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Whether the reading triggered an operational alarm — measures frequency of treatment process upsets."
  measures:
    - name: "total_turbidity_readings"
      expr: COUNT(1)
      comment: "Total turbidity readings — baseline for monitoring program completeness and SCADA data availability."
    - name: "exceedance_count"
      expr: SUM(CASE WHEN exceedance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of turbidity readings exceeding regulatory limits — primary SWTR compliance violation indicator."
    - name: "turbidity_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exceedance_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of turbidity readings within regulatory limits — key treatment performance KPI; SWTR requires 95% of readings ≤0.3 NTU."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_value_ntu AS DOUBLE))
      comment: "Average turbidity value (NTU) — tracks overall filtration performance and treatment process stability."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_value_ntu)
      comment: "Maximum turbidity reading — identifies worst-case filter performance events requiring immediate operational response."
    - name: "alarm_triggered_count"
      expr: SUM(CASE WHEN alarm_triggered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of turbidity alarm events — measures frequency of treatment process upsets requiring operator intervention."
    - name: "avg_regulatory_limit_ntu"
      expr: AVG(CAST(regulatory_limit_ntu AS DOUBLE))
      comment: "Average applicable regulatory turbidity limit — contextualizes measured values against applicable standards."
    - name: "avg_turbidity_pct_of_limit"
      expr: ROUND(100.0 * AVG(turbidity_value_ntu / NULLIF(regulatory_limit_ntu, 0)), 2)
      comment: "Average turbidity as percentage of regulatory limit — early warning indicator of proximity to compliance threshold."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_sampling_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitoring program scheduling KPIs — tracks sampling compliance rates, budget utilization, and schedule adherence for regulatory monitoring programs."
  source: "`vibe_water_utilities_v1`.`quality`.`sampling_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the sampling schedule (active, suspended, completed) — primary operational status dimension."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of sampling schedule (routine, special, triggered) — enables analysis by monitoring program type."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency — enables compliance gap analysis by monitoring frequency tier."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the sampling schedule — used to triage resource allocation for monitoring programs."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the sampling schedule — primary regulatory compliance dimension."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Whether the schedule has a monitoring violation — identifies schedules requiring immediate corrective action."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Whether the schedule has seasonal adjustments — enables analysis of seasonal monitoring program variations."
  measures:
    - name: "total_sampling_schedules"
      expr: COUNT(1)
      comment: "Total active sampling schedules — baseline for monitoring program scope and regulatory obligation coverage."
    - name: "violation_schedule_count"
      expr: SUM(CASE WHEN violation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sampling schedules with monitoring violations — primary compliance risk indicator requiring immediate regulatory response."
    - name: "monitoring_violation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN violation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sampling schedules with monitoring violations — measures overall monitoring program compliance health."
    - name: "total_annual_budget_allocation"
      expr: SUM(CAST(annual_budget_allocation AS DOUBLE))
      comment: "Total annual budget allocated across all sampling schedules — drives monitoring program budget planning and cost management."
    - name: "avg_cost_per_sample"
      expr: AVG(CAST(cost_per_sample AS DOUBLE))
      comment: "Average cost per sample across monitoring schedules — benchmarks laboratory and field sampling efficiency."
    - name: "avg_sample_volume_ml"
      expr: AVG(CAST(sample_volume_ml AS DOUBLE))
      comment: "Average required sample volume — operational planning metric for sample container and preservation logistics."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_water_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water sample collection and chain-of-custody KPIs — tracks sample quality, field measurement conditions, and collection program performance for laboratory and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`quality`.`water_sample`"
  dimensions:
    - name: "sample_type"
      expr: sample_type
      comment: "Type of water sample (routine, repeat, special, QC) — primary classification for regulatory compliance tracking."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix (drinking water, groundwater, surface water, wastewater) — determines applicable regulatory standards."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (collected, in-transit, received, analyzed) — tracks sample lifecycle for chain-of-custody compliance."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample collection (compliance, operational, investigative) — enables analysis by monitoring program type."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program the sample supports (SDWA, NPDES, LCR) — enables program-level sample volume and compliance tracking."
    - name: "quality_control_flag"
      expr: quality_control_flag
      comment: "Whether the sample passed QC checks — used to filter valid samples for compliance calculations."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of sample collection — enables trend analysis of sampling program activity."
  measures:
    - name: "total_water_samples"
      expr: COUNT(1)
      comment: "Total water samples collected — baseline for monitoring program throughput and regulatory sample count compliance."
    - name: "qc_passed_count"
      expr: SUM(CASE WHEN quality_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of samples passing QC checks — measures sample integrity and laboratory quality management effectiveness."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of water samples passing QC — key laboratory quality KPI; low rates indicate field or laboratory process failures."
    - name: "avg_field_turbidity_ntu"
      expr: AVG(CAST(field_turbidity_ntu AS DOUBLE))
      comment: "Average field turbidity at time of collection — operational indicator of source water quality conditions during sampling."
    - name: "avg_field_chlorine_residual_mg_l"
      expr: AVG(CAST(field_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average field chlorine residual at sample collection — tracks distribution system disinfection maintenance at sampling locations."
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field pH at sample collection — monitors distribution system water chemistry for corrosion control compliance."
    - name: "avg_field_temperature_c"
      expr: AVG(CAST(field_temperature_c AS DOUBLE))
      comment: "Average field water temperature at collection — critical parameter for bacteriological sample validity and hold time compliance."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate at sample collection point — operational context for interpreting sample results."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_source_water_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source water quality KPIs for raw water characterization, treatment optimization, and source water protection — tracks key parameters affecting treatment requirements and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`quality`.`source_water_quality`"
  dimensions:
    - name: "source_type"
      expr: source_type
      comment: "Type of water source (surface water, groundwater, purchased) — determines applicable treatment requirements and monitoring obligations."
    - name: "season"
      expr: season
      comment: "Season of measurement — enables seasonal trend analysis of source water quality for treatment planning."
    - name: "quality_control_passed_flag"
      expr: quality_control_passed
      comment: "Whether the measurement passed QC — filters valid data for compliance and treatment optimization analysis."
    - name: "regulatory_exceedance_flag"
      expr: regulatory_exceedance
      comment: "Whether a regulatory threshold was exceeded — primary source water compliance flag."
    - name: "cyanotoxin_detected_flag"
      expr: cyanotoxin_detected
      comment: "Whether cyanotoxins were detected — critical public health risk indicator for HAB response planning."
    - name: "treatment_adjustment_required_flag"
      expr: treatment_adjustment_required
      comment: "Whether treatment adjustments were required based on source water quality — operational response indicator."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement — enables seasonal and annual trend analysis of source water quality."
  measures:
    - name: "total_source_water_measurements"
      expr: COUNT(1)
      comment: "Total source water quality measurements — baseline for monitoring program coverage and data completeness."
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Number of source water measurements exceeding regulatory thresholds — primary source water compliance risk indicator."
    - name: "treatment_adjustment_required_count"
      expr: SUM(CASE WHEN treatment_adjustment_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of measurements requiring treatment adjustments — measures frequency of source water quality-driven operational interventions."
    - name: "cyanotoxin_detection_count"
      expr: SUM(CASE WHEN cyanotoxin_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Number of measurements with cyanotoxin detections — tracks harmful algal bloom (HAB) frequency for public health risk management."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average source water turbidity — primary treatment challenge indicator; high turbidity increases disinfection demand and CT requirements."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_ntu)
      comment: "Maximum source water turbidity — identifies peak treatment challenge events for capacity planning."
    - name: "avg_toc_mg_per_l"
      expr: AVG(CAST(toc_mg_per_l AS DOUBLE))
      comment: "Average total organic carbon — key DBP precursor indicator; high TOC drives enhanced coagulation requirements and DBP formation potential."
    - name: "avg_nitrate_mg_per_l"
      expr: AVG(CAST(nitrate_mg_per_l AS DOUBLE))
      comment: "Average nitrate concentration in source water — tracks agricultural runoff impact and treatment requirements for MCL compliance."
    - name: "avg_flow_rate_mgd"
      expr: AVG(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Average source water flow rate — operational capacity metric for treatment plant loading and production planning."
    - name: "avg_cyanotoxin_concentration_ug_per_l"
      expr: AVG(CAST(cyanotoxin_concentration_ug_per_l AS DOUBLE))
      comment: "Average cyanotoxin concentration — tracks HAB severity for treatment response and public health risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_monitoring_waiver`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitoring waiver program KPIs — tracks waiver coverage, expiration risk, and reduced monitoring frequency benefits for regulatory program optimization."
  source: "`vibe_water_utilities_v1`.`quality`.`monitoring_waiver`"
  dimensions:
    - name: "waiver_status"
      expr: waiver_status
      comment: "Current status of the monitoring waiver (active, expired, revoked, pending) — primary operational status dimension."
    - name: "waiver_type"
      expr: waiver_type
      comment: "Type of monitoring waiver (chemical, radiological, VOC) — enables analysis by regulatory program."
    - name: "contaminant_group"
      expr: contaminant_group
      comment: "Contaminant group covered by the waiver — enables analysis of waiver coverage by contaminant category."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the waiver requires renewal — identifies waivers needing proactive management to avoid monitoring gaps."
    - name: "primacy_agency_name"
      expr: primacy_agency_name
      comment: "Primacy agency that approved the waiver — enables analysis by regulatory jurisdiction."
  measures:
    - name: "total_monitoring_waivers"
      expr: COUNT(1)
      comment: "Total monitoring waivers — baseline for waiver program scope and monitoring cost reduction potential."
    - name: "active_waiver_count"
      expr: SUM(CASE WHEN waiver_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active monitoring waivers — measures current monitoring cost reduction from waiver program."
    - name: "expired_waiver_count"
      expr: SUM(CASE WHEN waiver_status = 'Expired' THEN 1 ELSE 0 END)
      comment: "Number of expired waivers — identifies monitoring obligations that have reverted to full frequency, increasing compliance costs."
    - name: "revoked_waiver_count"
      expr: SUM(CASE WHEN waiver_status = 'Revoked' THEN 1 ELSE 0 END)
      comment: "Number of revoked waivers — tracks compliance failures that resulted in waiver revocation and increased monitoring obligations."
    - name: "avg_waiver_duration_years"
      expr: AVG(CAST(waiver_duration_years AS DOUBLE))
      comment: "Average waiver duration in years — informs renewal planning and long-term monitoring budget forecasting."
    - name: "renewal_required_count"
      expr: SUM(CASE WHEN renewal_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of waivers requiring renewal — drives proactive regulatory engagement workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_iup_monitoring_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Industrial User Pretreatment (IUP) monitoring KPIs — tracks industrial discharge compliance, local limit exceedances, and enforcement triggers for pretreatment program management."
  source: "`vibe_water_utilities_v1`.`quality`.`iup_monitoring_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the IUP monitoring result — primary pretreatment program compliance dimension."
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of IUP monitoring (self-monitoring, compliance sampling, surveillance) — affects regulatory weight of the result."
    - name: "sample_type"
      expr: sample_type
      comment: "Sample type (composite, grab) — affects regulatory validity for different parameters."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the monitored parameter — enables analysis of compliance rates by pollutant."
    - name: "dmr_reporting_required_flag"
      expr: dmr_reporting_required
      comment: "Whether the result requires DMR reporting — tracks regulatory reporting obligations."
    - name: "enforcement_action_triggered_flag"
      expr: enforcement_action_triggered
      comment: "Whether the result triggered an enforcement action — primary pretreatment program enforcement indicator."
    - name: "sampling_month"
      expr: DATE_TRUNC('MONTH', sampling_date)
      comment: "Month of IUP sampling — enables trend analysis of industrial discharge compliance."
  measures:
    - name: "total_iup_monitoring_results"
      expr: COUNT(1)
      comment: "Total IUP monitoring results — baseline for pretreatment program monitoring coverage."
    - name: "exceedance_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of IUP results exceeding local limits — primary pretreatment program violation indicator driving enforcement actions."
    - name: "iup_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IUP monitoring results in compliance — key pretreatment program performance KPI for regulatory reporting."
    - name: "enforcement_action_triggered_count"
      expr: SUM(CASE WHEN enforcement_action_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results triggering enforcement actions — measures pretreatment program enforcement activity and industrial user compliance culture."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which local limits were exceeded — measures severity of industrial discharge violations for enforcement prioritization."
    - name: "distinct_industrial_users_monitored"
      expr: COUNT(DISTINCT industrial_user_id)
      comment: "Number of distinct industrial users monitored — measures pretreatment program coverage across the industrial user base."
    - name: "avg_daily_flow_mgd"
      expr: AVG(CAST(daily_flow_mgd AS DOUBLE))
      comment: "Average industrial user daily flow — tracks industrial discharge loading on the collection system and WWTP."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_sampling_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling point network KPIs — tracks monitoring location coverage, operational status, and sampling program readiness across the distribution and collection system."
  source: "`vibe_water_utilities_v1`.`quality`.`quality_sampling_point`"
  dimensions:
    - name: "sampling_point_status"
      expr: sampling_point_status
      comment: "Operational status of the sampling point (active, inactive, decommissioned) — primary status dimension for monitoring network management."
    - name: "location_type"
      expr: location_type
      comment: "Type of sampling location (entry point, distribution, source water, treatment) — enables analysis by monitoring program type."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source at the sampling point — enables analysis by source water category."
    - name: "treatment_stage"
      expr: treatment_stage
      comment: "Treatment stage at the sampling point (raw, settled, filtered, finished) — enables treatment process performance analysis."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency at this point — enables analysis of monitoring intensity by location."
    - name: "ccr_reporting_flag"
      expr: ccr_reporting_flag
      comment: "Whether results from this point are included in CCR reporting — identifies CCR-relevant monitoring locations."
    - name: "dmr_reporting_flag"
      expr: dmr_reporting_flag
      comment: "Whether results from this point are included in DMR reporting — identifies NPDES-relevant monitoring locations."
  measures:
    - name: "total_sampling_points"
      expr: COUNT(1)
      comment: "Total sampling points in the monitoring network — baseline for monitoring network coverage assessment."
    - name: "active_sampling_point_count"
      expr: SUM(CASE WHEN sampling_point_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active sampling points — measures current monitoring network operational capacity."
    - name: "ccr_reporting_point_count"
      expr: SUM(CASE WHEN ccr_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sampling points contributing to CCR reporting — validates CCR monitoring network completeness."
    - name: "dmr_reporting_point_count"
      expr: SUM(CASE WHEN dmr_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sampling points contributing to DMR reporting — validates NPDES monitoring network completeness."
    - name: "avg_residence_time_hours"
      expr: AVG(CAST(residence_time_hours AS DOUBLE))
      comment: "Average water residence time at sampling points — operational parameter for disinfection residual maintenance and DBP formation analysis."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate at sampling points — operational context for interpreting monitoring results."
    - name: "avg_elevation_ft"
      expr: AVG(CAST(elevation_ft AS DOUBLE))
      comment: "Average elevation of sampling points — spatial context for pressure zone and distribution system analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_residual_chlorine_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chlorine residual monitoring KPIs for distribution system disinfection maintenance — tracks residual compliance, corrective action rates, and disinfection adequacy across the distribution network."
  source: "`vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading`"
  dimensions:
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant (free chlorine, chloramine, chlorine dioxide) — determines applicable regulatory limits and monitoring requirements."
    - name: "sample_location_type"
      expr: sample_location_type
      comment: "Location type of the residual measurement (entry point, distribution, storage) — enables analysis by system zone."
    - name: "data_source"
      expr: data_source
      comment: "Source of the residual reading (SCADA, manual, online instrument) — enables data quality stratification."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the residual reading meets regulatory requirements — primary compliance dimension."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required
      comment: "Whether corrective action was required — measures frequency of distribution system disinfection failures."
    - name: "regulatory_monitoring_flag"
      expr: regulatory_monitoring_flag
      comment: "Whether the reading is part of regulatory monitoring — filters for compliance-relevant readings."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement — enables trend analysis of distribution system disinfection performance."
  measures:
    - name: "total_residual_readings"
      expr: COUNT(1)
      comment: "Total chlorine residual readings — baseline for monitoring program completeness and SCADA data availability."
    - name: "non_compliant_reading_count"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of non-compliant residual readings — primary distribution system disinfection failure indicator."
    - name: "residual_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of residual readings meeting regulatory requirements — key distribution system disinfection KPI for regulatory reporting."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of readings requiring corrective action — measures frequency of distribution system disinfection interventions."
    - name: "avg_residual_value_mg_per_l"
      expr: AVG(CAST(residual_value_mg_per_l AS DOUBLE))
      comment: "Average chlorine residual concentration — tracks distribution system disinfection maintenance effectiveness."
    - name: "min_residual_value_mg_per_l"
      expr: MIN(residual_value_mg_per_l)
      comment: "Minimum chlorine residual detected — identifies worst-case disinfection maintenance locations requiring targeted intervention."
    - name: "avg_minimum_required_residual_mg_per_l"
      expr: AVG(CAST(minimum_required_residual_mg_per_l AS DOUBLE))
      comment: "Average minimum required residual — contextualizes measured values against applicable regulatory minimums."
    - name: "avg_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH at residual measurement points — critical parameter for chloramine stability and disinfection effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_fog_monitoring_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fats, Oils, and Grease (FOG) monitoring KPIs for pretreatment program compliance — tracks grease interceptor inspection results, compliance rates, and SSO risk from FOG accumulation."
  source: "`vibe_water_utilities_v1`.`quality`.`fog_monitoring_event`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "FOG compliance status of the establishment — primary pretreatment program compliance dimension."
    - name: "establishment_type"
      expr: establishment_type
      comment: "Type of food service establishment (restaurant, school, hospital) — enables risk-based inspection prioritization."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of FOG inspection (routine, follow-up, complaint) — enables analysis by inspection trigger."
    - name: "interceptor_condition"
      expr: interceptor_condition
      comment: "Physical condition of the grease interceptor — drives maintenance and replacement decisions."
    - name: "sso_risk_level"
      expr: sso_risk_level
      comment: "SSO risk level associated with the FOG monitoring event — primary risk stratification dimension for collection system protection."
    - name: "enforcement_action_triggered_flag"
      expr: enforcement_action_triggered
      comment: "Whether an enforcement action was triggered — measures pretreatment program enforcement activity."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of FOG inspection — enables trend analysis of compliance rates over time."
  measures:
    - name: "total_fog_inspections"
      expr: COUNT(1)
      comment: "Total FOG monitoring events — baseline for pretreatment program inspection coverage."
    - name: "non_compliant_establishment_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Number of non-compliant FOG establishments — primary pretreatment program violation indicator."
    - name: "fog_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FOG inspections with compliant establishments — key pretreatment program performance KPI."
    - name: "enforcement_action_count"
      expr: SUM(CASE WHEN enforcement_action_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of FOG inspections triggering enforcement actions — measures pretreatment program enforcement intensity."
    - name: "reinspection_required_count"
      expr: SUM(CASE WHEN reinspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of establishments requiring reinspection — measures follow-up workload from non-compliant FOG inspections."
    - name: "avg_grease_accumulation_pct"
      expr: AVG(CAST(grease_accumulation_percentage AS DOUBLE))
      comment: "Average grease accumulation percentage in interceptors — tracks FOG loading severity and pump-out frequency adequacy."
    - name: "pump_out_non_compliant_count"
      expr: SUM(CASE WHEN pump_out_frequency_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Number of establishments with non-compliant pump-out frequency — identifies highest-risk FOG sources for SSO prevention."
    - name: "ordinance_threshold_exceeded_count"
      expr: SUM(CASE WHEN ordinance_threshold_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections where FOG ordinance thresholds were exceeded — primary enforcement trigger metric for pretreatment program."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_exceedance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory exceedance KPIs — tracks the frequency and distribution of contaminant limit exceedances across sampling points and contaminants for compliance risk management."
  source: "`vibe_water_utilities_v1`.`quality`.`exceedance`"
  dimensions:
    - name: "contaminant_id_dim"
      expr: contaminant_id
      comment: "Contaminant associated with the exceedance — enables analysis of exceedance frequency by contaminant for regulatory prioritization."
    - name: "quality_sampling_point_id_dim"
      expr: quality_sampling_point_id
      comment: "Sampling point where the exceedance occurred — enables spatial analysis of compliance risk hotspots."
  measures:
    - name: "total_exceedances"
      expr: COUNT(1)
      comment: "Total number of regulatory exceedances — primary compliance risk volume metric for executive reporting and regulatory submissions."
    - name: "distinct_contaminants_exceeded"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants with exceedances — measures breadth of compliance risk across the monitoring program."
    - name: "distinct_sampling_points_with_exceedances"
      expr: COUNT(DISTINCT quality_sampling_point_id)
      comment: "Number of distinct sampling points with exceedances — identifies spatial extent of compliance risk for targeted remediation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_instrument_calibration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online instrument calibration KPIs — tracks calibration program coverage and technician workload for QA/QC compliance of continuous monitoring instruments."
  source: "`vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration`"
  dimensions:
    - name: "online_instrument_id_dim"
      expr: online_instrument_id
      comment: "Online instrument being calibrated — enables analysis of calibration frequency and compliance by instrument."
    - name: "employee_id_dim"
      expr: employee_id
      comment: "Employee who performed the calibration — enables workload analysis and technician performance tracking."
  measures:
    - name: "total_calibration_events"
      expr: COUNT(1)
      comment: "Total instrument calibration events — baseline for calibration program completeness and QA/QC audit trail coverage."
    - name: "distinct_instruments_calibrated"
      expr: COUNT(DISTINCT online_instrument_id)
      comment: "Number of distinct instruments calibrated — measures calibration program coverage across the online monitoring network."
    - name: "distinct_calibration_technicians"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct technicians performing calibrations — measures workforce capacity for instrument QA/QC program."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_ccr_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Confidence Report (CCR) period KPIs — tracks CCR publication compliance, violation counts, and public communication effectiveness for annual regulatory reporting."
  source: "`vibe_water_utilities_v1`.`quality`.`ccr_period`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the CCR report (draft, published, submitted) — primary CCR compliance status dimension."
    - name: "report_year"
      expr: report_year
      comment: "CCR report year — enables year-over-year compliance trend analysis."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used to distribute the CCR (mail, electronic, newspaper) — tracks compliance with distribution requirements."
    - name: "language_accessibility_provided_flag"
      expr: language_accessibility_provided_flag
      comment: "Whether language accessibility was provided — tracks compliance with multilingual notification requirements."
    - name: "health_effects_language_included_flag"
      expr: health_effects_language_included_flag
      comment: "Whether required health effects language was included — tracks compliance with mandatory CCR content requirements."
  measures:
    - name: "total_ccr_periods"
      expr: COUNT(1)
      comment: "Total CCR reporting periods — baseline for CCR program history and compliance tracking."
    - name: "published_ccr_count"
      expr: SUM(CASE WHEN report_status = 'Published' THEN 1 ELSE 0 END)
      comment: "Number of CCR periods with published reports — measures CCR publication compliance rate."
    - name: "language_accessible_ccr_count"
      expr: SUM(CASE WHEN language_accessibility_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of CCR periods with language accessibility — tracks compliance with multilingual notification requirements for diverse communities."
    - name: "lead_copper_educational_info_count"
      expr: SUM(CASE WHEN lead_copper_educational_information_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of CCR periods including lead/copper educational information — tracks compliance with LCR public education requirements."
$$;