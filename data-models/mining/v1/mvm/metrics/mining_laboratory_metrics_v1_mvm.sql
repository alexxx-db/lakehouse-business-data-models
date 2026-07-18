-- Metric views for domain: laboratory | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_assay_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core assay analytics covering grade quality, detection limits, QAQC compliance, and analytical accuracy across all assay results. Drives resource estimation confidence, process control decisions, and laboratory performance management."
  source: "`mining_ecm`.`laboratory`.`assay_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the assay analysis was performed — used for trending grade quality and throughput over time."
    - name: "reported_date"
      expr: reported_date
      comment: "Date the assay result was formally reported — used for turnaround and SLA analysis."
    - name: "qaqc_sample_type"
      expr: qaqc_sample_type
      comment: "Type of QAQC sample (blank, duplicate, standard, field duplicate) — used to segment quality control performance."
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "QAQC outcome status (pass, fail, warning) — used to filter and group results by quality compliance."
    - name: "result_status"
      expr: result_status
      comment: "Current status of the assay result (approved, pending, rejected) — used for workflow and governance reporting."
    - name: "grade_unit"
      expr: grade_unit
      comment: "Unit of measure for the reported grade (e.g. %, g/t, ppm) — essential for cross-commodity grade comparisons."
    - name: "approved_by"
      expr: approved_by
      comment: "Person who approved the assay result — used for accountability and audit trail analysis."
    - name: "below_detection_flag"
      expr: below_detection_flag
      comment: "Indicates whether the result is below the instrument detection limit — used to assess analytical sensitivity issues."
    - name: "over_limit_flag"
      expr: over_limit_flag
      comment: "Indicates whether the reported grade exceeds the upper analytical limit — flags potential dilution or re-assay requirements."
    - name: "certified_result_flag"
      expr: certified_result_flag
      comment: "Indicates whether the result has been formally certified — used to distinguish certified from provisional results in resource estimation."
  measures:
    - name: "total_assay_results"
      expr: COUNT(1)
      comment: "Total number of assay results — baseline throughput measure for laboratory capacity and workload management."
    - name: "avg_reported_grade"
      expr: AVG(CAST(reported_grade AS DOUBLE))
      comment: "Average reported grade across all assay results — key indicator of ore quality and resource grade trends used in mine planning."
    - name: "avg_expected_grade"
      expr: AVG(CAST(expected_grade AS DOUBLE))
      comment: "Average expected grade based on geological models — used alongside avg_reported_grade to assess grade prediction accuracy."
    - name: "avg_accuracy_percent"
      expr: AVG(CAST(accuracy_percent AS DOUBLE))
      comment: "Average analytical accuracy percentage across assay results — measures how closely reported values match certified reference values; drives method validation decisions."
    - name: "avg_precision_percent"
      expr: AVG(CAST(precision_percent AS DOUBLE))
      comment: "Average analytical precision (repeatability) percentage — measures consistency of the analytical method; critical for JORC-compliant resource estimation."
    - name: "below_detection_result_count"
      expr: COUNT(CASE WHEN below_detection_flag = TRUE THEN 1 END)
      comment: "Count of assay results below the instrument detection limit — high counts indicate analytical sensitivity issues or low-grade material requiring method review."
    - name: "over_limit_result_count"
      expr: COUNT(CASE WHEN over_limit_flag = TRUE THEN 1 END)
      comment: "Count of assay results exceeding the upper analytical limit — flags samples requiring dilution or re-assay, impacting turnaround and cost."
    - name: "qaqc_fail_count"
      expr: COUNT(CASE WHEN qaqc_status = 'FAIL' THEN 1 END)
      comment: "Count of assay results that failed QAQC checks — directly informs batch rejection decisions and laboratory performance reviews."
    - name: "certified_result_count"
      expr: COUNT(CASE WHEN certified_result_flag = TRUE THEN 1 END)
      comment: "Count of formally certified assay results — measures the volume of results available for resource estimation and regulatory reporting."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied during analysis — elevated averages indicate systematic over-range issues affecting analytical accuracy."
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average detection limit across assay results — tracks instrument sensitivity over time; rising limits may indicate instrument degradation or method drift."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_qaqc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "QAQC performance analytics covering bias, precision, contamination, and control limit compliance. Provides the primary quality governance dashboard for laboratory accreditation, JORC compliance, and resource estimation integrity."
  source: "`mining_ecm`.`laboratory`.`qaqc_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the QAQC analysis was performed — used for trending quality performance over time."
    - name: "control_sample_type"
      expr: control_sample_type
      comment: "Type of control sample used (CRM, blank, duplicate, field duplicate) — segments QAQC performance by control type."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Overall pass/fail outcome of the QAQC check — primary filter for quality compliance dashboards."
    - name: "bias_flag"
      expr: bias_flag
      comment: "Indicates systematic bias detected in the analytical result — used to identify method or instrument drift requiring corrective action."
    - name: "precision_flag"
      expr: precision_flag
      comment: "Indicates precision failure in the analytical result — used to identify repeatability issues in the analytical process."
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Indicates contamination detected in the control sample — used to trigger batch investigation and chain-of-custody review."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action has been raised for this QAQC failure — used to track remediation workload."
    - name: "resource_estimation_approved"
      expr: resource_estimation_approved
      comment: "Indicates whether the result has been approved for use in resource estimation — critical governance dimension for JORC compliance."
    - name: "reviewed_by"
      expr: reviewed_by
      comment: "Person who reviewed the QAQC result — used for accountability and audit trail reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the QAQC result values — used to ensure consistent cross-method comparisons."
  measures:
    - name: "total_qaqc_checks"
      expr: COUNT(1)
      comment: "Total number of QAQC checks performed — baseline measure for quality program coverage and laboratory workload."
    - name: "qaqc_pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'PASS' THEN 1 END)
      comment: "Count of QAQC checks that passed — numerator for pass rate calculation; tracks overall laboratory quality compliance."
    - name: "qaqc_fail_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'FAIL' THEN 1 END)
      comment: "Count of QAQC checks that failed — triggers batch investigation and potential re-assay; directly impacts resource estimation timelines."
    - name: "bias_failure_count"
      expr: COUNT(CASE WHEN bias_flag = TRUE THEN 1 END)
      comment: "Count of results with systematic bias detected — high counts indicate method drift or instrument calibration issues requiring urgent intervention."
    - name: "contamination_failure_count"
      expr: COUNT(CASE WHEN contamination_flag = TRUE THEN 1 END)
      comment: "Count of results with contamination detected — drives chain-of-custody investigations and sample preparation process reviews."
    - name: "precision_failure_count"
      expr: COUNT(CASE WHEN precision_flag = TRUE THEN 1 END)
      comment: "Count of results with precision failures — indicates repeatability issues in the analytical method; informs method revalidation decisions."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of QAQC failures requiring corrective action — measures remediation workload and laboratory quality management burden."
    - name: "resource_estimation_approved_count"
      expr: COUNT(CASE WHEN resource_estimation_approved = TRUE THEN 1 END)
      comment: "Count of QAQC results approved for resource estimation — measures the volume of quality-assured data available for JORC-compliant mineral resource reporting."
    - name: "avg_percent_relative_difference"
      expr: AVG(CAST(percent_relative_difference AS DOUBLE))
      comment: "Average percent relative difference between reported and expected values — key precision metric used in JORC Table 1 reporting and laboratory accreditation reviews."
    - name: "avg_z_score"
      expr: AVG(CAST(z_score AS DOUBLE))
      comment: "Average Z-score across QAQC results — measures how many standard deviations results deviate from certified values; values outside ±2 trigger investigation."
    - name: "avg_absolute_difference"
      expr: AVG(CAST(absolute_difference AS DOUBLE))
      comment: "Average absolute difference between reported and expected values — provides a scale-aware measure of analytical error for method performance benchmarking."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_sample_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample batch throughput, turnaround, and QAQC compliance analytics. Drives laboratory capacity planning, SLA management, and quality program governance across all batch types and priorities."
  source: "`mining_ecm`.`laboratory`.`sample_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the sample batch (submitted, in-progress, completed, rejected) — primary workflow dimension for batch management dashboards."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of sample batch (routine, rush, reanalysis, QAQC) — used to segment throughput and cost by batch category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the batch (routine, high, urgent) — used to assess SLA compliance by priority tier."
    - name: "sample_origin_type"
      expr: sample_origin_type
      comment: "Origin of the samples in the batch (exploration, grade control, process, environmental) — used to allocate laboratory costs and capacity by business function."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department that submitted the batch — used for internal cost allocation and demand forecasting."
    - name: "external_laboratory_flag"
      expr: external_laboratory_flag
      comment: "Indicates whether the batch was sent to an external laboratory — used to track outsourcing volumes and associated costs."
    - name: "reanalysis_flag"
      expr: reanalysis_flag
      comment: "Indicates whether the batch is a reanalysis of a previously failed batch — used to measure rework rates and quality failure costs."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the batch was completed within the agreed SLA turnaround time — primary KPI for laboratory service level management."
    - name: "qaqc_compliance_flag"
      expr: qaqc_compliance_flag
      comment: "Indicates whether the batch met QAQC insertion rate requirements — used for quality program compliance reporting."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the batch was submitted to the laboratory — used for time-series throughput and backlog analysis."
    - name: "actual_completion_date"
      expr: actual_completion_date
      comment: "Date the batch analysis was completed — used alongside submission_date to calculate actual turnaround times."
    - name: "mine_site_code"
      expr: mine_site_code
      comment: "Code identifying the mine site that originated the batch — used to compare laboratory performance across sites."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of sample batches — baseline throughput measure for laboratory capacity planning and demand management."
    - name: "sla_compliant_batch_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of batches completed within SLA — numerator for SLA compliance rate; directly measures laboratory service delivery performance."
    - name: "sla_breach_batch_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Count of batches that breached SLA turnaround commitments — drives escalation and laboratory capacity investment decisions."
    - name: "qaqc_compliant_batch_count"
      expr: COUNT(CASE WHEN qaqc_compliance_flag = TRUE THEN 1 END)
      comment: "Count of batches meeting QAQC insertion rate requirements — measures quality program compliance across the laboratory operation."
    - name: "reanalysis_batch_count"
      expr: COUNT(CASE WHEN reanalysis_flag = TRUE THEN 1 END)
      comment: "Count of reanalysis batches — measures rework volume driven by quality failures; high counts indicate systemic analytical issues."
    - name: "external_laboratory_batch_count"
      expr: COUNT(CASE WHEN external_laboratory_flag = TRUE THEN 1 END)
      comment: "Count of batches dispatched to external laboratories — tracks outsourcing volume for cost management and capacity planning."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average actual turnaround time in hours across all batches — primary laboratory efficiency KPI used in SLA negotiations and capacity reviews."
    - name: "total_batch_weight_kg"
      expr: SUM(CAST(batch_weight_kg AS DOUBLE))
      comment: "Total weight of samples processed across all batches in kilograms — measures physical throughput capacity utilisation."
    - name: "avg_qaqc_insertion_rate_percent"
      expr: AVG(CAST(qaqc_insertion_rate_percent AS DOUBLE))
      comment: "Average QAQC sample insertion rate as a percentage of total samples — measures adherence to quality program requirements; typically benchmarked at 5-10% for industry standards."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_metallurgical_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metallurgical test performance analytics covering recovery rates, product grades, comminution indices, and leach efficiency. Directly informs process plant design, flowsheet optimisation, and feasibility study economics."
  source: "`mining_ecm`.`laboratory`.`metallurgical_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of metallurgical test (flotation, leach, comminution, gravity) — primary segmentation dimension for process performance analysis."
    - name: "test_subtype"
      expr: test_subtype
      comment: "Sub-type of the metallurgical test providing finer classification — used for detailed process flowsheet analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test (in-progress, completed, approved, rejected) — used for workflow and reporting completeness tracking."
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type or domain tested (oxide, sulphide, transitional, fresh) — critical dimension for understanding metallurgical variability across the orebody."
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "QAQC status of the metallurgical test result — used to filter approved results for feasibility and process design studies."
    - name: "test_start_date"
      expr: test_start_date
      comment: "Date the metallurgical test commenced — used for time-series analysis of test program progress."
    - name: "test_completion_date"
      expr: test_completion_date
      comment: "Date the metallurgical test was completed — used to calculate test duration and program milestone tracking."
    - name: "leach_solution_type"
      expr: leach_solution_type
      comment: "Type of leach solution used (cyanide, acid, alkaline) — used to compare recovery performance across leach chemistry variants."
    - name: "flotation_reagent_type"
      expr: flotation_reagent_type
      comment: "Type of flotation reagent used — used to compare recovery and grade performance across reagent schemes."
    - name: "approved_by"
      expr: approved_by
      comment: "Person who approved the metallurgical test result — used for governance and competent person accountability tracking."
  measures:
    - name: "total_metallurgical_tests"
      expr: COUNT(1)
      comment: "Total number of metallurgical tests conducted — baseline measure for test program progress and laboratory capacity utilisation."
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average metallurgical recovery rate as a percentage — the single most important KPI for process plant economics; directly drives revenue forecasts in feasibility studies."
    - name: "avg_product_grade_percent"
      expr: AVG(CAST(product_grade_percent AS DOUBLE))
      comment: "Average concentrate or product grade percentage — determines product saleability and offtake contract compliance; key input to revenue modelling."
    - name: "avg_feed_grade_percent"
      expr: AVG(CAST(feed_grade_percent AS DOUBLE))
      comment: "Average feed grade percentage across metallurgical tests — used to normalise recovery performance and assess grade-recovery relationships."
    - name: "avg_tailings_grade_percent"
      expr: AVG(CAST(tailings_grade_percent AS DOUBLE))
      comment: "Average tailings grade percentage — measures metal losses to tailings; high values indicate recovery inefficiency and lost revenue."
    - name: "avg_bond_work_index_kwh_per_tonne"
      expr: AVG(CAST(bond_work_index_kwh_per_tonne AS DOUBLE))
      comment: "Average Bond Work Index in kWh/tonne — primary comminution hardness parameter used to size grinding circuits and estimate processing energy costs."
    - name: "avg_extraction_rate_percent"
      expr: AVG(CAST(extraction_rate_percent AS DOUBLE))
      comment: "Average extraction rate percentage for leach tests — measures the efficiency of hydrometallurgical processes; critical for heap leach and tank leach project economics."
    - name: "avg_reagent_consumption_g_per_tonne"
      expr: AVG(CAST(reagent_consumption_g_per_tonne AS DOUBLE))
      comment: "Average reagent consumption in grams per tonne — directly impacts operating cost estimates; high consumption drives reagent cost sensitivity analysis."
    - name: "avg_grind_size_p80_microns"
      expr: AVG(CAST(grind_size_p80_microns AS DOUBLE))
      comment: "Average P80 grind size in microns — determines the optimal liberation size for the ore; used to balance energy cost against recovery performance."
    - name: "total_concentrate_mass_kg"
      expr: SUM(CAST(concentrate_mass_kg AS DOUBLE))
      comment: "Total concentrate mass produced across all metallurgical tests in kilograms — measures the scale of test work and provides input to mass balance calculations."
    - name: "avg_abrasion_index"
      expr: AVG(CAST(abrasion_index AS DOUBLE))
      comment: "Average abrasion index across tests — measures ore abrasiveness; high values indicate elevated liner and media wear costs in the processing plant."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory instrument fleet analytics covering calibration compliance, operational status, and utilisation. Drives instrument maintenance scheduling, calibration governance, and capital replacement planning."
  source: "`mining_ecm`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of analytical instrument (ICP-MS, XRF, AAS, fire assay furnace) — used to segment calibration compliance and utilisation by instrument category."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument (operational, under maintenance, decommissioned, out of calibration) — primary dimension for fleet availability dashboards."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status of the instrument (current, overdue, failed) — critical for laboratory accreditation compliance and result validity."
    - name: "last_calibration_result"
      expr: last_calibration_result
      comment: "Outcome of the most recent calibration (pass, fail, conditional) — used to identify instruments with recurring calibration failures."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer — used to analyse reliability and maintenance cost patterns by vendor."
    - name: "location"
      expr: location
      comment: "Physical location of the instrument within the laboratory — used for spatial capacity planning and workflow optimisation."
    - name: "last_calibration_date"
      expr: last_calibration_date
      comment: "Date of the most recent calibration — used to identify instruments approaching or exceeding calibration frequency requirements."
    - name: "next_calibration_due_date"
      expr: next_calibration_due_date
      comment: "Date the next calibration is due — used for proactive calibration scheduling and accreditation compliance management."
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date the instrument was acquired — used for fleet age analysis and capital replacement planning."
  measures:
    - name: "total_instruments"
      expr: COUNT(1)
      comment: "Total number of instruments in the laboratory fleet — baseline measure for fleet size and capital asset management."
    - name: "operational_instrument_count"
      expr: COUNT(CASE WHEN operational_status = 'OPERATIONAL' THEN 1 END)
      comment: "Count of instruments currently in operational status — measures available analytical capacity; low counts trigger capacity risk escalation."
    - name: "calibration_overdue_count"
      expr: COUNT(CASE WHEN calibration_status = 'OVERDUE' THEN 1 END)
      comment: "Count of instruments with overdue calibrations — directly threatens laboratory accreditation; zero tolerance KPI for quality governance."
    - name: "total_usage_hours"
      expr: SUM(CAST(usage_hours AS DOUBLE))
      comment: "Total accumulated usage hours across all instruments — measures fleet utilisation and informs preventive maintenance scheduling and capital replacement timing."
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per instrument — used to identify over-utilised instruments at risk of failure and under-utilised instruments representing excess capacity."
    - name: "avg_measurement_range_lower"
      expr: AVG(CAST(measurement_range_lower AS DOUBLE))
      comment: "Average lower measurement range limit across instruments — used to assess fleet-wide analytical sensitivity for low-grade ore characterisation."
    - name: "avg_measurement_range_upper"
      expr: AVG(CAST(measurement_range_upper AS DOUBLE))
      comment: "Average upper measurement range limit across instruments — used to assess fleet-wide capacity for high-grade sample analysis without dilution."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_sample_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample dispatch logistics analytics covering turnaround compliance, transport costs, and chain-of-custody performance. Drives external laboratory management, logistics cost control, and sample integrity governance."
  source: "`mining_ecm`.`laboratory`.`sample_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the sample dispatch (dispatched, in-transit, received, rejected) — primary workflow dimension for logistics tracking."
    - name: "dispatch_purpose"
      expr: dispatch_purpose
      comment: "Purpose of the dispatch (routine assay, check assay, umpire assay, metallurgical test) — used to segment dispatch volumes and costs by business purpose."
    - name: "laboratory_type"
      expr: laboratory_type
      comment: "Type of destination laboratory (internal, external, umpire) — used to compare performance and cost between laboratory types."
    - name: "transport_method"
      expr: transport_method
      comment: "Method of transport used (courier, road freight, air freight) — used to analyse cost and transit time trade-offs."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispatch (routine, urgent, rush) — used to assess whether priority dispatches are receiving appropriate service levels."
    - name: "sample_condition_on_receipt"
      expr: sample_condition_on_receipt
      comment: "Condition of samples upon receipt at the destination laboratory (intact, damaged, compromised) — used to assess packaging and handling quality."
    - name: "dispatch_date"
      expr: dispatch_date
      comment: "Date samples were dispatched — used for time-series analysis of dispatch volumes and logistics planning."
    - name: "actual_receipt_date"
      expr: actual_receipt_date
      comment: "Date samples were received at the destination laboratory — used alongside dispatch_date to calculate actual transit times."
    - name: "courier_name"
      expr: courier_name
      comment: "Name of the courier or freight provider — used to compare service level and cost performance across logistics vendors."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample dispatched (pulp, core, reject, whole rock) — used to segment dispatch logistics by sample category."
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total number of sample dispatches — baseline measure for external laboratory workload and logistics volume management."
    - name: "total_dispatch_cost_estimate"
      expr: SUM(CAST(dispatch_cost_estimate AS DOUBLE))
      comment: "Total estimated dispatch cost across all dispatches — measures logistics expenditure for cost control and budget variance analysis."
    - name: "avg_dispatch_cost_estimate"
      expr: AVG(CAST(dispatch_cost_estimate AS DOUBLE))
      comment: "Average dispatch cost per shipment — used to benchmark logistics efficiency and negotiate courier contracts."
    - name: "total_sample_weight_dispatched_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of samples dispatched in kilograms — measures physical logistics volume and informs freight cost modelling."
    - name: "damaged_sample_dispatch_count"
      expr: COUNT(CASE WHEN sample_condition_on_receipt = 'DAMAGED' THEN 1 END)
      comment: "Count of dispatches where samples arrived damaged — measures packaging and handling failure rate; damaged samples require re-sampling, adding cost and delay."
    - name: "distinct_destination_laboratories"
      expr: COUNT(DISTINCT laboratory_id)
      comment: "Count of distinct destination laboratories used — measures the breadth of the external laboratory network and vendor concentration risk."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_sample_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample program governance analytics covering budget performance, QAQC insertion rates, and regulatory compliance. Provides strategic oversight of sampling campaigns supporting resource estimation, grade control, and environmental monitoring."
  source: "`mining_ecm`.`laboratory`.`sample_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of sample program (exploration, grade control, process, environmental, geotechnical) — primary segmentation for program portfolio management."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the sample program (planned, active, completed, suspended) — used for program pipeline and resource allocation management."
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard applied to the program (JORC, NI 43-101, SAMREC) — used to ensure regulatory compliance and investor reporting alignment."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the program meets all applicable regulatory requirements — critical governance dimension for tenement and licence compliance."
    - name: "turnaround_priority"
      expr: turnaround_priority
      comment: "Priority level for sample turnaround (routine, high, urgent) — used to allocate laboratory capacity and manage program timelines."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the program budget — used for multi-currency budget consolidation and reporting."
    - name: "start_date"
      expr: start_date
      comment: "Planned start date of the sample program — used for program timeline and resource scheduling analysis."
    - name: "end_date"
      expr: end_date
      comment: "Planned end date of the sample program — used for program completion tracking and resource release planning."
    - name: "sample_security_level"
      expr: sample_security_level
      comment: "Security classification of the sample program (standard, confidential, restricted) — used for data governance and access control reporting."
  measures:
    - name: "total_sample_programs"
      expr: COUNT(1)
      comment: "Total number of sample programs — baseline measure for sampling portfolio size and organisational sampling activity."
    - name: "total_program_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted expenditure across all sample programs — primary financial measure for sampling investment portfolio management and capital allocation decisions."
    - name: "avg_program_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per sample program — used to benchmark program investment levels and identify outliers requiring additional scrutiny."
    - name: "regulatory_compliant_program_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of programs meeting all regulatory compliance requirements — measures the organisation's regulatory risk exposure across its sampling portfolio."
    - name: "avg_qaqc_insertion_rate_percent"
      expr: AVG(CAST(qaqc_insertion_rate_percent AS DOUBLE))
      comment: "Average QAQC insertion rate across sample programs as a percentage — measures adherence to quality program design standards; benchmarked against JORC and industry best practice."
    - name: "avg_blank_insertion_rate_percent"
      expr: AVG(CAST(blank_insertion_rate_percent AS DOUBLE))
      comment: "Average blank sample insertion rate across programs — measures contamination detection coverage; low rates indicate inadequate quality control design."
    - name: "avg_duplicate_insertion_rate_percent"
      expr: AVG(CAST(duplicate_insertion_rate_percent AS DOUBLE))
      comment: "Average duplicate sample insertion rate across programs — measures precision monitoring coverage; used to assess sampling and analytical repeatability governance."
    - name: "avg_standard_insertion_rate_percent"
      expr: AVG(CAST(standard_insertion_rate_percent AS DOUBLE))
      comment: "Average certified reference material insertion rate across programs — measures accuracy monitoring coverage; critical for JORC-compliant resource estimation data quality."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_analytical_method`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analytical method performance and governance analytics covering accuracy, precision, cost, and accreditation status. Drives method selection, validation scheduling, and laboratory accreditation management."
  source: "`mining_ecm`.`laboratory`.`analytical_method`"
  dimensions:
    - name: "method_category"
      expr: method_category
      comment: "Category of the analytical method (fire assay, ICP, XRF, wet chemistry) — used to segment method performance and cost by analytical technique."
    - name: "method_type"
      expr: method_type
      comment: "Type of analytical method (quantitative, semi-quantitative, qualitative) — used to filter methods appropriate for resource estimation versus process control."
    - name: "method_status"
      expr: method_status
      comment: "Current status of the method (active, deprecated, under validation, suspended) — used to manage the active method portfolio."
    - name: "approved_for_resource_estimation"
      expr: approved_for_resource_estimation
      comment: "Indicates whether the method is approved for use in JORC-compliant resource estimation — critical governance dimension for mineral resource reporting."
    - name: "approved_for_process_control"
      expr: approved_for_process_control
      comment: "Indicates whether the method is approved for real-time process control applications — used to manage method fitness-for-purpose."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument used by the method — used to assess method-instrument dependencies and capacity planning."
    - name: "matrix_applicability"
      expr: matrix_applicability
      comment: "Sample matrix types the method is applicable to (rock, soil, pulp, solution) — used to match methods to sample types in program design."
    - name: "accreditation_standard"
      expr: accreditation_standard
      comment: "Accreditation standard under which the method is certified (ISO 17025, NATA) — used for regulatory compliance and laboratory accreditation reporting."
    - name: "last_validation_date"
      expr: last_validation_date
      comment: "Date of the most recent method validation — used to identify methods approaching revalidation due dates."
    - name: "next_validation_due_date"
      expr: next_validation_due_date
      comment: "Date the next method validation is due — used for proactive validation scheduling and accreditation compliance management."
  measures:
    - name: "total_analytical_methods"
      expr: COUNT(1)
      comment: "Total number of analytical methods in the method register — baseline measure for method portfolio size and governance coverage."
    - name: "resource_estimation_approved_method_count"
      expr: COUNT(CASE WHEN approved_for_resource_estimation = TRUE THEN 1 END)
      comment: "Count of methods approved for resource estimation — measures the breadth of the JORC-compliant analytical capability available to the organisation."
    - name: "avg_cost_per_sample"
      expr: AVG(CAST(cost_per_sample AS DOUBLE))
      comment: "Average cost per sample across all analytical methods — used to benchmark method economics and optimise analytical suite selection for cost-effective sampling programs."
    - name: "avg_accuracy_bias_percent"
      expr: AVG(CAST(accuracy_bias_percent AS DOUBLE))
      comment: "Average accuracy bias percentage across all methods — measures systematic error in the method portfolio; high bias values indicate methods requiring revalidation or replacement."
    - name: "avg_precision_rsd_percent"
      expr: AVG(CAST(precision_rsd_percent AS DOUBLE))
      comment: "Average precision relative standard deviation percentage across methods — measures repeatability of the method portfolio; used in JORC Table 1 reporting and method selection decisions."
    - name: "avg_detection_limit_lower"
      expr: AVG(CAST(detection_limit_lower AS DOUBLE))
      comment: "Average lower detection limit across all methods — measures the fleet-wide analytical sensitivity; critical for low-grade ore characterisation and trace element analysis."
    - name: "total_method_cost_per_sample"
      expr: SUM(CAST(cost_per_sample AS DOUBLE))
      comment: "Sum of cost per sample across all methods in the register — used as a denominator component for weighted average cost calculations in program budgeting."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_qaqc_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "QAQC sample design and performance analytics covering bias, insertion ratios, and investigation rates. Provides the quality assurance foundation for JORC-compliant resource estimation and laboratory accreditation management."
  source: "`mining_ecm`.`laboratory`.`qaqc_sample`"
  dimensions:
    - name: "qaqc_sample_type"
      expr: qaqc_sample_type
      comment: "Type of QAQC sample (CRM, blank, field duplicate, preparation duplicate) — primary segmentation for quality program performance analysis."
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "QAQC outcome status (pass, fail, warning, investigation) — used to measure quality program compliance rates."
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the QAQC sample was analysed — used for time-series quality performance trending."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the QAQC sample was submitted — used for turnaround analysis and batch scheduling."
    - name: "investigation_required"
      expr: investigation_required
      comment: "Indicates whether the QAQC result requires investigation — used to measure the investigation workload generated by quality failures."
    - name: "batch_reanalysis_required"
      expr: batch_reanalysis_required
      comment: "Indicates whether the associated batch requires reanalysis due to this QAQC failure — measures the operational impact of quality failures."
    - name: "tolerance_type"
      expr: tolerance_type
      comment: "Type of tolerance applied to the QAQC assessment (absolute, relative, z-score) — used to understand the stringency of quality control criteria."
    - name: "preparation_method"
      expr: preparation_method
      comment: "Sample preparation method applied to the QAQC sample — used to assess whether preparation method affects quality control performance."
    - name: "expected_grade_unit"
      expr: expected_grade_unit
      comment: "Unit of measure for the expected grade value — used to ensure consistent cross-method QAQC comparisons."
  measures:
    - name: "total_qaqc_samples"
      expr: COUNT(1)
      comment: "Total number of QAQC samples submitted — measures the scale of the quality assurance program and insertion coverage."
    - name: "qaqc_pass_count"
      expr: COUNT(CASE WHEN qaqc_status = 'PASS' THEN 1 END)
      comment: "Count of QAQC samples that passed quality criteria — numerator for pass rate calculation; primary measure of analytical quality compliance."
    - name: "investigation_required_count"
      expr: COUNT(CASE WHEN investigation_required = TRUE THEN 1 END)
      comment: "Count of QAQC samples requiring investigation — measures the quality failure investigation workload; high counts indicate systemic analytical issues."
    - name: "batch_reanalysis_required_count"
      expr: COUNT(CASE WHEN batch_reanalysis_required = TRUE THEN 1 END)
      comment: "Count of QAQC failures triggering batch reanalysis — measures the operational and cost impact of quality failures on laboratory throughput."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average bias percentage across all QAQC samples — measures systematic error in the analytical process; used in JORC Table 1 reporting and method performance reviews."
    - name: "avg_absolute_difference"
      expr: AVG(CAST(absolute_difference AS DOUBLE))
      comment: "Average absolute difference between assay result and expected grade — provides a scale-aware measure of analytical error for method benchmarking."
    - name: "avg_insertion_ratio"
      expr: AVG(CAST(insertion_ratio AS DOUBLE))
      comment: "Average QAQC sample insertion ratio — measures the proportion of QAQC samples relative to total samples; used to verify adherence to quality program design specifications."
    - name: "avg_assay_result"
      expr: AVG(CAST(assay_result AS DOUBLE))
      comment: "Average assay result across QAQC samples — used alongside avg expected grade to assess systematic bias at the program level."
    - name: "avg_expected_grade"
      expr: AVG(CAST(expected_grade AS DOUBLE))
      comment: "Average expected grade across QAQC samples — used as the reference benchmark for assessing analytical accuracy at the program level."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory entity performance and governance analytics covering accreditation status, quality ratings, cost benchmarks, and turnaround commitments. Drives laboratory selection, contract management, and vendor performance reviews."
  source: "`mining_ecm`.`laboratory`.`laboratory`"
  dimensions:
    - name: "laboratory_type"
      expr: laboratory_type
      comment: "Type of laboratory (internal, external, umpire, commercial) — primary segmentation for laboratory portfolio management."
    - name: "laboratory_status"
      expr: laboratory_status
      comment: "Current operational status of the laboratory (active, suspended, decommissioned) — used to filter the active laboratory network."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the laboratory (company-owned, contracted, joint venture) — used to segment cost and performance by ownership model."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body that certified the laboratory (NATA, UKAS, A2LA) — used to assess the credibility and regulatory acceptance of laboratory results."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the laboratory (A, B, C or equivalent) — primary dimension for laboratory performance benchmarking and preferred supplier selection."
    - name: "preferred_laboratory_flag"
      expr: preferred_laboratory_flag
      comment: "Indicates whether the laboratory is on the preferred supplier list — used to track preferred versus non-preferred laboratory usage."
    - name: "country_code"
      expr: country_code
      comment: "Country where the laboratory is located — used for geographic analysis of laboratory network coverage and logistics cost drivers."
    - name: "accreditation_expiry_date"
      expr: accreditation_expiry_date
      comment: "Date the laboratory accreditation expires — used to proactively manage accreditation renewal and avoid using non-accredited laboratories."
    - name: "last_audit_date"
      expr: last_audit_date
      comment: "Date of the most recent laboratory audit — used to identify laboratories overdue for audit and assess audit program coverage."
  measures:
    - name: "total_laboratories"
      expr: COUNT(1)
      comment: "Total number of laboratories in the network — baseline measure for laboratory network size and vendor management scope."
    - name: "preferred_laboratory_count"
      expr: COUNT(CASE WHEN preferred_laboratory_flag = TRUE THEN 1 END)
      comment: "Count of preferred laboratories in the network — measures the size of the approved preferred supplier panel for laboratory services."
    - name: "active_laboratory_count"
      expr: COUNT(CASE WHEN laboratory_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active laboratories — measures available analytical capacity across the laboratory network."
    - name: "avg_cost_per_sample_standard"
      expr: AVG(CAST(cost_per_sample_standard AS DOUBLE))
      comment: "Average standard cost per sample across all laboratories — used to benchmark laboratory pricing and identify cost outliers in contract negotiations."
    - name: "total_cost_per_sample_standard"
      expr: SUM(CAST(cost_per_sample_standard AS DOUBLE))
      comment: "Sum of standard cost per sample across all laboratories — used as a portfolio-level cost benchmark for laboratory network spend analysis."
$$;
