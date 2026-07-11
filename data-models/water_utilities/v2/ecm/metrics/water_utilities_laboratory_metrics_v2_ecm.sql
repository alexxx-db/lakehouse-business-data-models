-- Metric views for domain: laboratory | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_analytical_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core analytical testing performance metrics tracking test throughput, result quality, QC compliance, and detection efficiency across the laboratory. Used by lab directors and quality managers to steer testing operations, accreditation readiness, and regulatory defensibility."
  source: "`vibe_water_utilities_v1`.`laboratory`.`analytical_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the analytical test (e.g., pending, complete, rejected) for filtering and grouping test pipeline health."
    - name: "matrix_type"
      expr: matrix_type
      comment: "Sample matrix type (e.g., drinking water, wastewater, soil) enabling performance analysis by matrix category."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program driving the test (e.g., SDWA, NPDES) for compliance-oriented performance segmentation."
    - name: "test_priority"
      expr: test_priority
      comment: "Priority level of the test (e.g., rush, routine) for workload and turnaround analysis."
    - name: "test_start_month"
      expr: DATE_TRUNC('month', test_start_timestamp)
      comment: "Month the test was initiated, enabling trend analysis of testing volume and quality over time."
    - name: "hold_time_compliant_flag"
      expr: hold_time_compliant_flag
      comment: "Whether the sample was analyzed within required hold time — critical dimension for regulatory defensibility segmentation."
    - name: "reanalysis_required_flag"
      expr: reanalysis_required_flag
      comment: "Whether the test required reanalysis, used to segment rework volume from routine throughput."
  measures:
    - name: "total_analytical_tests"
      expr: COUNT(1)
      comment: "Total number of analytical tests performed. Baseline throughput KPI used by lab directors to assess capacity utilization and workload trends."
    - name: "avg_percent_recovery"
      expr: AVG(CAST(percent_recovery AS DOUBLE))
      comment: "Average matrix spike percent recovery across all tests. A key QC indicator — values outside 70-130% signal method or instrument issues requiring corrective action."
    - name: "avg_relative_percent_difference"
      expr: AVG(CAST(relative_percent_difference AS DOUBLE))
      comment: "Average relative percent difference (RPD) between duplicate analyses. Measures analytical precision; high RPD triggers QC investigation and potential data rejection."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average analytical result value across tests. Used to monitor contaminant concentration trends and flag potential exceedances requiring regulatory action."
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average method detection limit achieved across tests. Lower values indicate better instrument sensitivity; tracked for accreditation and regulatory compliance."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied during analysis. High dilution factors may indicate matrix interference issues affecting result accuracy."
    - name: "reanalysis_required_count"
      expr: SUM(CASE WHEN reanalysis_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests requiring reanalysis. Directly measures rework volume — high counts signal QC failures, instrument problems, or sample integrity issues driving cost and delay."
    - name: "hold_time_noncompliant_count"
      expr: SUM(CASE WHEN hold_time_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of tests where hold time was exceeded. Hold time violations invalidate results for regulatory reporting — a critical compliance risk metric."
    - name: "distinct_analytes_tested"
      expr: COUNT(DISTINCT analyte_id)
      comment: "Number of distinct analytes tested. Measures breadth of analytical capability and scope of monitoring programs active in the period."
    - name: "distinct_qc_batches"
      expr: COUNT(DISTINCT qc_batch_id)
      comment: "Number of distinct QC batches processed. Used to assess QC batch throughput and ensure adequate QC coverage relative to sample volume."
    - name: "avg_uncertainty_value"
      expr: AVG(CAST(uncertainty_value AS DOUBLE))
      comment: "Average measurement uncertainty across analytical tests. Tracks analytical method reliability — high uncertainty values may disqualify results for regulatory submissions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test result quality and compliance metrics tracking result values, detection rates, regulatory threshold adherence, and QC performance. Primary KPI layer for water quality compliance reporting and laboratory performance management."
  source: "`vibe_water_utilities_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the test result (e.g., approved, rejected, pending review) for pipeline health and data release tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the result is compliant with regulatory thresholds — the primary dimension for regulatory reporting dashboards."
    - name: "detection_status"
      expr: detection_status
      comment: "Whether the analyte was detected above the detection limit — used for occurrence analysis and risk assessment."
    - name: "reporting_unit"
      expr: reporting_unit
      comment: "Unit of measure for reported results, enabling cross-analyte comparisons and unit-specific trend analysis."
    - name: "result_qualifier"
      expr: result_qualifier
      comment: "Data qualifier code applied to the result (e.g., J, U, B) — qualifiers affect regulatory defensibility and must be tracked for compliance submissions."
    - name: "result_month"
      expr: DATE_TRUNC('month', reporting_timestamp)
      comment: "Month the result was reported, enabling monthly compliance trend analysis and regulatory reporting period alignment."
    - name: "proficiency_test_flag"
      expr: proficiency_test_flag
      comment: "Whether the result is from a proficiency test sample — used to separate PT performance from routine analytical results."
    - name: "reanalysis_flag"
      expr: reanalysis_flag
      comment: "Whether this result is a reanalysis — used to track rework rates and distinguish original from corrected results."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results generated. Baseline throughput metric for laboratory output and regulatory reporting completeness."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average analytical result value. Tracks contaminant concentration trends over time — rising averages may signal treatment or source water issues requiring intervention."
    - name: "max_result_value"
      expr: MAX(CAST(result_value AS DOUBLE))
      comment: "Maximum result value observed. Identifies peak contaminant concentrations — critical for MCL exceedance detection and public health risk assessment."
    - name: "avg_regulatory_threshold_value"
      expr: AVG(CAST(regulatory_threshold_value AS DOUBLE))
      comment: "Average regulatory threshold (MCL/AL) applicable to results in the view. Used as a reference baseline for compliance gap analysis."
    - name: "avg_method_detection_limit"
      expr: AVG(CAST(method_detection_limit AS DOUBLE))
      comment: "Average MDL achieved across results. Lower MDLs indicate better analytical sensitivity — tracked for accreditation maintenance and regulatory acceptance."
    - name: "avg_reporting_limit"
      expr: AVG(CAST(reporting_limit AS DOUBLE))
      comment: "Average practical quantitation limit (PQL/RL) across results. Ensures reporting limits meet regulatory requirements for each analyte and program."
    - name: "avg_matrix_spike_recovery_pct"
      expr: AVG(CAST(matrix_spike_recovery_percent AS DOUBLE))
      comment: "Average matrix spike recovery percentage. A primary QC acceptance criterion — values outside 70-130% indicate matrix interference or method failure requiring corrective action."
    - name: "avg_duplicate_rpd"
      expr: AVG(CAST(duplicate_relative_percent_difference AS DOUBLE))
      comment: "Average duplicate RPD across results. Measures analytical precision — high RPD values trigger data qualification or rejection, impacting regulatory reporting."
    - name: "avg_uncertainty_estimate"
      expr: AVG(CAST(uncertainty_estimate AS DOUBLE))
      comment: "Average measurement uncertainty estimate. Tracks analytical reliability — required for ISO 17025 accreditation and increasingly required in regulatory submissions."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied. High dilution factors raise effective detection limits and may cause results to be reported as non-detect when contamination is present."
    - name: "reanalysis_result_count"
      expr: SUM(CASE WHEN reanalysis_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reanalysis results. Measures rework volume driven by QC failures — high counts indicate systemic analytical problems increasing cost and turnaround time."
    - name: "approved_result_count"
      expr: SUM(CASE WHEN approved_result_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of results with approved status. Tracks data release pipeline health — low approval rates signal validation bottlenecks delaying regulatory reporting."
    - name: "distinct_contaminants_detected"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants with results. Measures monitoring program breadth and identifies emerging contaminant detection patterns."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_qc_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "QC batch acceptance and analytical quality control performance metrics. Used by quality managers and lab directors to monitor QC acceptance rates, identify systematic method failures, and maintain accreditation compliance."
  source: "`vibe_water_utilities_v1`.`laboratory`.`qc_batch`"
  dimensions:
    - name: "batch_type"
      expr: batch_type
      comment: "Type of QC batch (e.g., routine, compliance, proficiency) for segmenting QC performance by batch category."
    - name: "overall_batch_acceptance_status"
      expr: overall_batch_acceptance_status
      comment: "Overall acceptance status of the QC batch — the primary KPI dimension for batch pass/fail analysis."
    - name: "method_blank_acceptance_status"
      expr: method_blank_acceptance_status
      comment: "Acceptance status of the method blank QC check — blank failures indicate contamination in reagents or equipment."
    - name: "lcs_acceptance_status"
      expr: lcs_acceptance_status
      comment: "Laboratory control sample acceptance status — LCS failures indicate method or instrument performance issues independent of matrix effects."
    - name: "matrix_spike_acceptance_status"
      expr: matrix_spike_acceptance_status
      comment: "Matrix spike acceptance status — failures indicate sample matrix interference affecting analytical accuracy."
    - name: "batch_preparation_month"
      expr: DATE_TRUNC('month', batch_preparation_datetime)
      comment: "Month the QC batch was prepared, enabling monthly QC performance trend analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required for the batch — used to track QC failure rates requiring intervention."
  measures:
    - name: "total_qc_batches"
      expr: COUNT(1)
      comment: "Total number of QC batches processed. Baseline metric for QC throughput and workload management."
    - name: "avg_lcs_percent_recovery"
      expr: AVG(CAST(lcs_percent_recovery AS DOUBLE))
      comment: "Average LCS percent recovery across batches. The primary method performance indicator — values outside 70-130% signal method failure requiring corrective action and potential data rejection."
    - name: "avg_matrix_spike_recovery"
      expr: AVG(CAST(matrix_spike_percent_recovery AS DOUBLE))
      comment: "Average matrix spike percent recovery. Measures matrix interference effects — critical for validating results from complex sample matrices like wastewater or soil."
    - name: "avg_msd_recovery"
      expr: AVG(CAST(msd_percent_recovery AS DOUBLE))
      comment: "Average matrix spike duplicate percent recovery. Used alongside matrix spike recovery to assess both accuracy and precision of spiked sample analysis."
    - name: "avg_duplicate_rpd"
      expr: AVG(CAST(duplicate_relative_percent_difference AS DOUBLE))
      comment: "Average duplicate RPD across QC batches. Measures analytical precision at the batch level — high RPD indicates inconsistent analytical performance."
    - name: "avg_msd_rpd"
      expr: AVG(CAST(msd_relative_percent_difference AS DOUBLE))
      comment: "Average MSD relative percent difference. Tracks precision of matrix spike duplicate analysis — a key QC acceptance criterion for many regulatory methods."
    - name: "avg_method_blank_result"
      expr: AVG(CAST(method_blank_result AS DOUBLE))
      comment: "Average method blank result value. Blank contamination above detection limits invalidates associated sample results — a critical contamination control metric."
    - name: "avg_surrogate_recovery"
      expr: AVG(CAST(surrogate_percent_recovery AS DOUBLE))
      comment: "Average surrogate compound percent recovery. Surrogates track extraction efficiency for organic methods — failures indicate extraction problems affecting all results in the batch."
    - name: "corrective_action_batch_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of QC batches requiring corrective action. Directly measures QC failure frequency — high counts signal systemic analytical problems requiring management intervention."
    - name: "lcs_included_batch_count"
      expr: SUM(CASE WHEN lcs_included = TRUE THEN 1 ELSE 0 END)
      comment: "Number of batches with LCS included. Tracks QC completeness — batches without LCS may not meet regulatory or accreditation requirements."
    - name: "method_blank_included_count"
      expr: SUM(CASE WHEN method_blank_included = TRUE THEN 1 ELSE 0 END)
      comment: "Number of batches with method blank included. Ensures contamination control QC coverage — required for most regulatory analytical methods."
    - name: "avg_lcs_expected_value"
      expr: AVG(CAST(lcs_expected_value AS DOUBLE))
      comment: "Average expected LCS concentration. Used as denominator context for recovery calculations and to verify standard preparation accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_lab_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory sample intake, processing, and compliance metrics. Used by lab managers and compliance officers to track sample volume, hold time compliance, QC coverage, and regulatory program completeness."
  source: "`vibe_water_utilities_v1`.`laboratory`.`lab_sample`"
  dimensions:
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the lab sample (e.g., received, in analysis, complete, rejected) for pipeline health monitoring."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample (e.g., routine, duplicate, blank, spike) for QC coverage analysis and compliance reporting."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix (e.g., drinking water, wastewater, groundwater) for program-level throughput analysis."
    - name: "compliance_program"
      expr: compliance_program
      comment: "Regulatory compliance program driving the sample (e.g., TCR, LCR, UCMR) — primary dimension for regulatory reporting completeness."
    - name: "priority"
      expr: priority
      comment: "Sample priority level (e.g., rush, routine) for turnaround time management and resource allocation."
    - name: "qc_level"
      expr: qc_level
      comment: "QC level assigned to the sample — used to ensure appropriate QC coverage by sample category."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_datetime)
      comment: "Month the sample was received — enables monthly intake volume trend analysis and seasonal pattern detection."
    - name: "sample_origin"
      expr: sample_origin
      comment: "Origin of the sample (e.g., distribution system, source water, treatment plant) for spatial compliance analysis."
  measures:
    - name: "total_samples_received"
      expr: COUNT(1)
      comment: "Total number of lab samples received. Primary throughput metric for laboratory capacity planning and regulatory program completeness assessment."
    - name: "avg_sample_volume_ml"
      expr: AVG(CAST(sample_volume_ml AS DOUBLE))
      comment: "Average sample volume in milliliters. Tracks sample adequacy — insufficient volumes prevent required analyses and may cause regulatory reporting gaps."
    - name: "avg_container_volume_ml"
      expr: AVG(CAST(container_volume_ml AS DOUBLE))
      comment: "Average container volume. Used alongside sample volume to assess container utilization and identify collection protocol deviations."
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field pH at sample collection. Tracks source water and distribution system chemistry trends — pH excursions affect treatment efficacy and corrosion control."
    - name: "avg_field_chlorine_residual"
      expr: AVG(CAST(field_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average field chlorine residual at collection point. Directly measures disinfection coverage in the distribution system — a primary public health protection metric."
    - name: "avg_field_temperature_c"
      expr: AVG(CAST(field_temperature_c AS DOUBLE))
      comment: "Average field temperature at sample collection. Temperature affects microbial growth and disinfection efficacy — tracked for seasonal risk assessment."
    - name: "avg_sample_temperature_c"
      expr: AVG(CAST(sample_temperature_c AS DOUBLE))
      comment: "Average sample temperature at receipt. Samples received above 10°C may have compromised integrity — tracks cold chain compliance for sample acceptance decisions."
    - name: "distinct_dma_zones_sampled"
      expr: COUNT(DISTINCT dma_id)
      comment: "Number of distinct district metered areas sampled. Measures spatial coverage of monitoring programs — gaps in DMA coverage may indicate regulatory monitoring deficiencies."
    - name: "distinct_pressure_zones_sampled"
      expr: COUNT(DISTINCT pressure_zone_id)
      comment: "Number of distinct pressure zones sampled. Ensures monitoring coverage across the distribution system — required for TCR and LCR compliance."
    - name: "distinct_work_orders"
      expr: COUNT(DISTINCT lab_work_order_id)
      comment: "Number of distinct lab work orders associated with samples. Measures work order throughput and links sample volume to billing and cost tracking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_lab_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory work order financial, operational, and compliance metrics. Used by lab directors and finance managers to track testing costs, billing performance, turnaround compliance, and regulatory program workload."
  source: "`vibe_water_utilities_v1`.`laboratory`.`lab_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the lab work order (e.g., open, complete, invoiced) for pipeline and billing health monitoring."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., compliance, research, commercial) for cost and revenue segmentation."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program driving the work order — primary dimension for compliance cost allocation and program-level reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the work order (e.g., rush, routine) for turnaround time and resource allocation analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the work order is billable to an external customer — used to separate revenue-generating from internal cost work."
    - name: "compliance_monitoring_flag"
      expr: compliance_monitoring_flag
      comment: "Whether the work order is for regulatory compliance monitoring — used to track compliance program workload and cost."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the work order was submitted — enables monthly workload trend analysis and seasonal demand planning."
    - name: "requesting_entity_type"
      expr: requesting_entity_type
      comment: "Type of entity requesting the work (e.g., internal, external, regulatory) for customer segmentation and billing analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of lab work orders. Baseline throughput metric for laboratory capacity planning and demand forecasting."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of laboratory work orders in USD. Primary financial metric for laboratory cost management, budget variance analysis, and cost recovery tracking."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost across work orders. Used alongside actual cost to measure cost estimation accuracy and identify systematic under/over-estimation."
    - name: "avg_actual_cost_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per work order. Tracks unit cost trends — rising averages may indicate inefficiency, reagent cost increases, or method complexity growth."
    - name: "avg_estimated_cost_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost per work order. Baseline for cost estimation accuracy assessment and pricing model calibration."
    - name: "hold_time_noncompliant_count"
      expr: SUM(CASE WHEN holding_time_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of work orders with hold time violations. Hold time failures invalidate results for regulatory use — a direct compliance risk and potential regulatory penalty trigger."
    - name: "billable_work_order_count"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of billable work orders. Tracks revenue-generating workload — used for laboratory cost recovery analysis and commercial service performance."
    - name: "compliance_monitoring_work_order_count"
      expr: SUM(CASE WHEN compliance_monitoring_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of work orders for regulatory compliance monitoring. Measures regulatory program workload — used for compliance cost allocation and regulatory reporting completeness."
    - name: "distinct_customers_served"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customer accounts served. Measures laboratory customer base breadth and commercial service reach."
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers charged. Tracks cost allocation breadth across the organization — used for departmental cost reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_certified_analyst`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certified analyst workforce metrics tracking certification status, expiration risk, and signatory authority coverage. Used by lab directors and HR to manage analyst qualification compliance, accreditation readiness, and succession planning."
  source: "`vibe_water_utilities_v1`.`laboratory`.`certified_analyst`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (e.g., active, expired, suspended) — primary dimension for workforce compliance risk assessment."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of analyst certification (e.g., drinking water, wastewater, environmental) for program-specific workforce planning."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level (e.g., I, II, III, IV) for workforce capability tier analysis and succession planning."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification — used to track accreditation body relationships and renewal requirements."
    - name: "signatory_authority"
      expr: signatory_authority
      comment: "Whether the analyst has signatory authority for result release — critical for data release capacity planning."
    - name: "is_active"
      expr: is_active
      comment: "Whether the analyst is currently active — used to filter active workforce for capacity and coverage analysis."
    - name: "laboratory_assignment"
      expr: laboratory_assignment
      comment: "Laboratory to which the analyst is assigned — enables per-laboratory workforce coverage analysis."
  measures:
    - name: "total_certified_analysts"
      expr: COUNT(1)
      comment: "Total number of certified analysts on record. Baseline workforce metric for laboratory staffing adequacy and accreditation scope coverage."
    - name: "active_certified_analyst_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active certified analysts. Measures available analytical workforce — insufficient active analysts risk accreditation scope limitations and regulatory non-compliance."
    - name: "signatory_authority_analyst_count"
      expr: SUM(CASE WHEN signatory_authority = TRUE THEN 1 ELSE 0 END)
      comment: "Number of analysts with signatory authority. Tracks data release capacity — too few signatories create bottlenecks in result approval and regulatory reporting timelines."
    - name: "avg_continuing_education_hours"
      expr: AVG(CAST(continuing_education_hours AS DOUBLE))
      comment: "Average continuing education hours per analyst. Tracks professional development compliance — insufficient CEU hours may result in certification lapse and accreditation scope loss."
    - name: "expiring_certification_count"
      expr: SUM(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of analyst certifications expiring within 90 days. A leading indicator of workforce compliance risk — enables proactive renewal management before accreditation is impacted."
    - name: "expired_certification_count"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of analyst certifications already expired. Expired certifications invalidate results signed by that analyst — a critical compliance and accreditation risk requiring immediate action."
    - name: "distinct_specialty_areas_count"
      expr: COUNT(DISTINCT specialty_areas)
      comment: "Number of distinct specialty areas covered by the analyst workforce. Measures analytical capability breadth — gaps in specialty coverage may limit accreditation scope."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_method_detection_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Method detection limit (MDL) and minimum reporting level (MRL) performance metrics. Used by quality managers and accreditation coordinators to track analytical sensitivity, regulatory acceptance, and MDL study compliance."
  source: "`vibe_water_utilities_v1`.`laboratory`.`method_detection_limit`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Status of the MDL study (e.g., approved, pending review, rejected) for study pipeline management."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program for which the MDL was determined — enables program-specific sensitivity compliance analysis."
    - name: "regulatory_acceptance_status"
      expr: regulatory_acceptance_status
      comment: "Whether the MDL has been accepted by the regulatory authority — primary dimension for accreditation compliance tracking."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix for which the MDL was determined — MDLs vary by matrix and must be tracked separately for each."
    - name: "acceptance_criteria_met_flag"
      expr: acceptance_criteria_met_flag
      comment: "Whether the MDL study met all acceptance criteria — used to track study pass rates and identify methods needing re-study."
    - name: "study_month"
      expr: DATE_TRUNC('month', CAST(study_date AS TIMESTAMP))
      comment: "Month the MDL study was conducted — enables trend analysis of detection limit improvements over time."
    - name: "lims_integration_flag"
      expr: lims_integration_flag
      comment: "Whether the MDL is integrated into the LIMS — unintegrated MDLs may not be applied to results automatically, creating reporting errors."
  measures:
    - name: "total_mdl_studies"
      expr: COUNT(1)
      comment: "Total number of MDL studies conducted. Tracks analytical method validation activity — required annually or upon significant method/instrument changes."
    - name: "avg_calculated_mdl"
      expr: AVG(CAST(calculated_mdl AS DOUBLE))
      comment: "Average calculated MDL across studies. Tracks analytical sensitivity trends — lower MDLs indicate improved instrument performance and method optimization."
    - name: "avg_calculated_mrl"
      expr: AVG(CAST(calculated_mrl AS DOUBLE))
      comment: "Average calculated minimum reporting level. MRLs must be at or below regulatory reporting thresholds — tracks compliance with reporting limit requirements."
    - name: "avg_mean_recovery"
      expr: AVG(CAST(mean_recovery AS DOUBLE))
      comment: "Average mean recovery across MDL studies. Measures accuracy of the analytical method at low concentrations — critical for validating detection capability near regulatory limits."
    - name: "avg_standard_deviation"
      expr: AVG(CAST(standard_deviation AS DOUBLE))
      comment: "Average standard deviation of MDL replicate measurements. Measures analytical precision at the detection limit — high SD values result in higher MDLs and reduced sensitivity."
    - name: "avg_relative_std_dev_pct"
      expr: AVG(CAST(relative_standard_deviation_percent AS DOUBLE))
      comment: "Average relative standard deviation percentage. Measures method precision as a percentage — used to compare precision across methods and analytes."
    - name: "avg_spike_concentration"
      expr: AVG(CAST(spike_concentration AS DOUBLE))
      comment: "Average spike concentration used in MDL studies. Ensures spike levels are appropriate (1-5x expected MDL) — improper spike levels invalidate the study."
    - name: "acceptance_criteria_failure_count"
      expr: SUM(CASE WHEN acceptance_criteria_met_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of MDL studies failing acceptance criteria. Failed studies require re-study — high failure rates indicate systematic method or instrument performance issues."
    - name: "distinct_analytes_with_mdl"
      expr: COUNT(DISTINCT analyte_id)
      comment: "Number of distinct analytes with MDL studies. Measures analytical scope coverage — analytes without current MDLs may not be reportable for regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_lab_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory accreditation status, cost, and compliance metrics. Used by lab directors and quality managers to track accreditation health, renewal timelines, corrective action obligations, and accreditation investment."
  source: "`vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (e.g., accredited, suspended, revoked, pending) — primary dimension for accreditation risk management."
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., ISO 17025, NELAP, state primacy) for program-specific compliance tracking."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required — used to identify accreditations at risk and prioritize remediation efforts."
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of laboratory accreditations maintained. Baseline metric for accreditation portfolio management."
    - name: "total_accreditation_cost_usd"
      expr: SUM(CAST(accreditation_cost_usd AS DOUBLE))
      comment: "Total cost of laboratory accreditations in USD. Tracks accreditation investment — used for budget planning and cost-benefit analysis of accreditation scope decisions."
    - name: "avg_accreditation_cost_usd"
      expr: AVG(CAST(accreditation_cost_usd AS DOUBLE))
      comment: "Average cost per accreditation. Benchmarks accreditation cost efficiency and identifies high-cost accreditations for scope rationalization."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accreditations with open corrective action requirements. Unresolved corrective actions risk accreditation suspension — a critical compliance risk metric."
    - name: "expiring_accreditation_count"
      expr: SUM(CASE WHEN next_assessment_due_date <= DATE_ADD(CURRENT_DATE(), 90) AND next_assessment_due_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of accreditations with assessments due within 90 days. Leading indicator for accreditation renewal workload — enables proactive preparation to avoid lapses."
    - name: "distinct_laboratories_accredited"
      expr: COUNT(DISTINCT laboratory_id)
      comment: "Number of distinct laboratories with accreditations. Measures accreditation coverage across the laboratory network."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_result_validation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Result validation throughput, quality, and compliance metrics. Used by data managers and quality officers to track validation pipeline health, rejection rates, regulatory defensibility, and data release performance."
  source: "`vibe_water_utilities_v1`.`laboratory`.`result_validation`"
  dimensions:
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status (e.g., approved, rejected, pending) — primary dimension for data release pipeline health."
    - name: "validation_level"
      expr: validation_level
      comment: "Level of validation applied (e.g., Level I, II, III, IV) — higher levels require more rigorous review for regulatory submissions."
    - name: "validation_disposition"
      expr: validation_disposition
      comment: "Final disposition of the validation (e.g., usable, qualified, rejected) — determines whether results can be used for regulatory reporting."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program for which results are being validated — enables program-specific validation performance analysis."
    - name: "regulatory_defensibility_flag"
      expr: regulatory_defensibility_flag
      comment: "Whether the validated results are considered regulatory defensible — critical for compliance reporting and enforcement defense."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether supervisor approval is required for this validation — used to track approval bottlenecks in the data release pipeline."
    - name: "validation_month"
      expr: DATE_TRUNC('month', validation_timestamp)
      comment: "Month validation was performed — enables monthly throughput trend analysis and backlog management."
  measures:
    - name: "total_validations"
      expr: COUNT(1)
      comment: "Total number of result validations performed. Baseline throughput metric for data management workload and pipeline capacity."
    - name: "regulatory_defensible_count"
      expr: SUM(CASE WHEN regulatory_defensibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of validations producing regulatory defensible results. Tracks the proportion of data suitable for regulatory submissions — low rates signal systemic QC or method issues."
    - name: "qc_criteria_met_count"
      expr: SUM(CASE WHEN qc_acceptance_criteria_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of validations where all QC acceptance criteria were met. Measures overall QC compliance rate — a primary laboratory quality performance indicator."
    - name: "hold_time_compliant_count"
      expr: SUM(CASE WHEN holding_time_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of validations with hold time compliance confirmed. Tracks sample integrity compliance — required for regulatory defensibility of results."
    - name: "chain_of_custody_verified_count"
      expr: SUM(CASE WHEN chain_of_custody_verified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of validations with chain of custody verified. COC verification is required for regulatory and legal defensibility — gaps create compliance risk."
    - name: "calibration_verified_count"
      expr: SUM(CASE WHEN calibration_verification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of validations with instrument calibration verified. Calibration verification is a prerequisite for result acceptance — unverified calibrations invalidate associated results."
    - name: "method_compliant_count"
      expr: SUM(CASE WHEN method_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of validations confirming method compliance. Method deviations must be documented and may require data qualification — tracks method adherence across the analytical program."
    - name: "distinct_validation_batches"
      expr: COUNT(DISTINCT validation_batch_id)
      comment: "Number of distinct validation batches processed. Measures validation throughput at the batch level for workload and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_calibration_curve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration curve quality and performance metrics. Used by quality managers and instrument technicians to track calibration accuracy, curve linearity, and instrument performance trends."
  source: "`vibe_water_utilities_v1`.`laboratory`.`calibration_curve`"
  dimensions:
    - name: "calibration_curve_status"
      expr: calibration_curve_status
      comment: "Current status of the calibration curve (e.g., active, expired, superseded) for instrument readiness management."
    - name: "curve_type"
      expr: curve_type
      comment: "Type of calibration curve (e.g., linear, quadratic, external standard) for method-specific performance analysis."
    - name: "calibration_method"
      expr: calibration_method
      comment: "Calibration method used — enables performance comparison across calibration approaches."
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the calibration curve has been verified — unverified curves should not be used for regulatory sample analysis."
    - name: "calibration_month"
      expr: DATE_TRUNC('month', CAST(calibration_date AS TIMESTAMP))
      comment: "Month of calibration — enables trend analysis of calibration frequency and instrument performance over time."
  measures:
    - name: "total_calibration_curves"
      expr: COUNT(1)
      comment: "Total number of calibration curves generated. Tracks calibration activity volume — used for instrument utilization and QC workload analysis."
    - name: "avg_r_squared"
      expr: AVG(CAST(r_squared AS DOUBLE))
      comment: "Average R-squared (coefficient of determination) across calibration curves. The primary linearity metric — values below 0.995 typically fail regulatory acceptance criteria and require recalibration."
    - name: "min_r_squared"
      expr: MIN(CAST(r_squared AS DOUBLE))
      comment: "Minimum R-squared observed. Identifies worst-case calibration performance — values below acceptance thresholds invalidate all results analyzed using that curve."
    - name: "avg_standard_deviation"
      expr: AVG(CAST(standard_deviation AS DOUBLE))
      comment: "Average standard deviation of calibration curve points. Measures calibration precision — high SD indicates instrument instability or standard preparation errors."
    - name: "avg_reference_value"
      expr: AVG(CAST(reference_value AS DOUBLE))
      comment: "Average reference standard value used in calibration. Tracks standard concentration levels — used to verify appropriate calibration range coverage for expected sample concentrations."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average laboratory temperature during calibration. Temperature affects instrument response — tracking temperature during calibration helps diagnose environmental sources of calibration variability."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity during calibration. Humidity affects certain analytical instruments — tracked to correlate environmental conditions with calibration performance."
    - name: "verified_curve_count"
      expr: SUM(CASE WHEN is_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of verified calibration curves. Only verified curves should be used for regulatory sample analysis — tracks verification compliance rate."
    - name: "distinct_instruments_calibrated"
      expr: COUNT(DISTINCT lab_instrument_id)
      comment: "Number of distinct instruments with calibration curves. Measures calibration program coverage — instruments without current calibration curves cannot be used for regulatory analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_analyst_method_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyst method qualification status and proficiency metrics. Used by lab directors and quality managers to ensure analysts are qualified for the methods they perform, manage qualification expiration risk, and maintain accreditation compliance."
  source: "`vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g., qualified, expired, suspended) — primary dimension for workforce compliance risk assessment."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of method qualification (e.g., trainee, qualified, senior) for capability tier analysis."
    - name: "proficiency_test_status"
      expr: proficiency_test_status
      comment: "Status of the most recent proficiency test for this method qualification — used to identify analysts needing PT remediation."
    - name: "signatory_authority"
      expr: signatory_authority
      comment: "Whether the analyst has signatory authority for this method — tracks data release capacity by method."
    - name: "certification_month"
      expr: DATE_TRUNC('month', CAST(certification_date AS TIMESTAMP))
      comment: "Month the qualification was certified — enables cohort analysis of qualification activity and renewal cycles."
  measures:
    - name: "total_method_qualifications"
      expr: COUNT(1)
      comment: "Total number of analyst-method qualifications on record. Measures analytical workforce capability breadth — each qualification represents a certified analyst-method combination."
    - name: "avg_continuing_education_hours"
      expr: AVG(CAST(continuing_education_hours AS DOUBLE))
      comment: "Average continuing education hours per qualification. Tracks professional development compliance — insufficient CEU hours may result in qualification lapse."
    - name: "expiring_qualification_count"
      expr: SUM(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of method qualifications expiring within 90 days. Leading indicator for workforce compliance risk — enables proactive renewal before analytical capability gaps occur."
    - name: "expired_qualification_count"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of expired method qualifications. Expired qualifications mean analysts cannot legally perform those methods for regulatory samples — a direct accreditation and compliance risk."
    - name: "signatory_qualified_count"
      expr: SUM(CASE WHEN signatory_authority = TRUE THEN 1 ELSE 0 END)
      comment: "Number of method qualifications with signatory authority. Tracks data release capacity by method — insufficient signatories create bottlenecks in regulatory reporting."
    - name: "distinct_methods_covered"
      expr: COUNT(DISTINCT test_method_id)
      comment: "Number of distinct test methods with qualified analysts. Measures analytical method coverage — methods without qualified analysts cannot be used for regulatory compliance testing."
    - name: "distinct_qualified_analysts"
      expr: COUNT(DISTINCT certified_analyst_id)
      comment: "Number of distinct analysts with at least one method qualification. Tracks qualified workforce size for capacity planning and accreditation scope maintenance."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_reagent_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent and reference standard inventory, cost, and compliance metrics. Used by lab managers and procurement teams to track reagent stock levels, expiration risk, and chemical inventory costs."
  source: "`vibe_water_utilities_v1`.`laboratory`.`reagent_standard`"
  dimensions:
    - name: "reagent_standard_status"
      expr: reagent_standard_status
      comment: "Current status of the reagent or standard (e.g., active, expired, depleted) for inventory health monitoring."
    - name: "reagent_type"
      expr: reagent_type
      comment: "Type of reagent or standard (e.g., primary standard, reagent grade, certified reference material) for inventory categorization."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the reagent — used for safety compliance tracking and hazardous material inventory reporting."
    - name: "certified_reference_material_flag"
      expr: certified_reference_material_flag
      comment: "Whether the standard is a certified reference material (CRM) — CRMs are required for certain regulatory methods and must be tracked separately."
    - name: "preparation_month"
      expr: DATE_TRUNC('month', CAST(preparation_date AS TIMESTAMP))
      comment: "Month the reagent was prepared — enables trend analysis of reagent consumption and preparation frequency."
  measures:
    - name: "total_reagent_standards"
      expr: COUNT(1)
      comment: "Total number of reagent and standard records. Baseline inventory metric for chemical management and procurement planning."
    - name: "total_current_stock_quantity"
      expr: SUM(CAST(current_stock_quantity AS DOUBLE))
      comment: "Total current stock quantity across all reagents. Tracks overall inventory levels — used for procurement planning and ensuring adequate supply for analytical programs."
    - name: "avg_concentration_value"
      expr: AVG(CAST(concentration_value AS DOUBLE))
      comment: "Average concentration of reagents and standards. Used to verify standard preparation accuracy and track concentration trends across lots."
    - name: "avg_reorder_threshold"
      expr: AVG(CAST(reorder_threshold AS DOUBLE))
      comment: "Average reorder threshold quantity. Used alongside current stock to identify reagents approaching reorder points and prevent analytical program disruptions."
    - name: "below_reorder_threshold_count"
      expr: SUM(CASE WHEN current_stock_quantity <= reorder_threshold THEN 1 ELSE 0 END)
      comment: "Number of reagents at or below reorder threshold. Directly identifies procurement actions needed — running out of critical reagents halts analytical programs and risks regulatory non-compliance."
    - name: "expiring_reagent_count"
      expr: SUM(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiry_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of reagents expiring within 30 days. Expired reagents cannot be used for regulatory analysis — proactive tracking prevents analytical disruptions and waste."
    - name: "expired_reagent_count"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of already-expired reagents still in inventory. Expired reagents in active inventory represent a compliance risk — must be quarantined and disposed of per regulatory requirements."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors supplying reagents and standards. Tracks supply chain diversity — over-reliance on single vendors creates supply disruption risk for critical analytical programs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_analyst_grant_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant labor cost and effort allocation KPIs"
  source: "`vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation`"
  dimensions:
    - name: "grant_id"
      expr: grant_id
      comment: "Identifier of the associated grant"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category for the allocation"
    - name: "grant_role"
      expr: grant_role
      comment: "Role of the analyst within the grant"
    - name: "allocation_period_start_date"
      expr: allocation_period_start_date
      comment: "Start date of the allocation period"
    - name: "allocation_period_end_date"
      expr: allocation_period_end_date
      comment: "End date of the allocation period"
  measures:
    - name: "total_labor_cost_allocation"
      expr: SUM(CAST(labor_cost_allocation AS DOUBLE))
      comment: "Total labor cost allocated across grants"
    - name: "total_effort_percentage"
      expr: SUM(CAST(effort_percentage AS DOUBLE))
      comment: "Aggregate effort percentage allocated"
    - name: "allocation_record_count"
      expr: COUNT(1)
      comment: "Number of grant allocation records"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`laboratory_lab_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument cost and utilization overview"
  source: "`vibe_water_utilities_v1`.`laboratory`.`lab_instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type/category of the laboratory instrument"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer"
    - name: "lab_location"
      expr: lab_location
      comment: "Physical location of the instrument within the lab"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year the instrument entered service"
  measures:
    - name: "average_annual_service_cost"
      expr: AVG(CAST(annual_service_cost AS DOUBLE))
      comment: "Average annual service cost per instrument"
    - name: "active_instrument_count"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of instruments currently marked as active"
$$;