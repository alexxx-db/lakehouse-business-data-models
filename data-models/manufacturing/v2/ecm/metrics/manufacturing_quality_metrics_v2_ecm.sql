-- Metric views for domain: quality | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance Report (NCR) metrics tracking volume, severity, and closure performance of nonconforming material and process events across the manufacturing enterprise."
  source: "`vibe_manufacturing_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_type"
      expr: ncr_type
      comment: "Type of nonconformance (incoming, in-process, outgoing, field) for segmenting defect origin."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current workflow status of the NCR (open, under review, closed) for pipeline analysis."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance for risk-based prioritisation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause bucket (design, process, supplier, human error) for Pareto analysis."
    - name: "defect_code"
      expr: defect_code
      comment: "Standardised defect code enabling trend analysis by failure type."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (incoming inspection, SPC, customer return) to evaluate detection effectiveness."
    - name: "is_8d_required"
      expr: is_8d_required
      comment: "Flag indicating whether an 8D structured problem-solving report is mandated."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag for NCRs that must be reported to a regulatory body, driving compliance risk tracking."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month of detection for trend and seasonality analysis."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of NCRs raised; baseline volume KPI for quality performance dashboards."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Count of NCRs currently open; high values signal backlog risk and resource pressure."
    - name: "total_nonconforming_qty"
      expr: SUM(CAST(nonconforming_qty AS DOUBLE))
      comment: "Total quantity of nonconforming units across all NCRs; directly tied to scrap and rework cost exposure."
    - name: "avg_nonconforming_qty_per_ncr"
      expr: AVG(CAST(nonconforming_qty AS DOUBLE))
      comment: "Average nonconforming quantity per NCR; spikes indicate systemic process failures rather than isolated events."
    - name: "regulatory_reportable_ncr_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of NCRs with regulatory reporting obligation; a leading indicator of compliance exposure."
    - name: "ncr_requiring_8d_count"
      expr: COUNT(CASE WHEN is_8d_required = TRUE THEN 1 END)
      comment: "Count of NCRs requiring 8D root-cause analysis; measures depth of quality problem-solving workload."
    - name: "distinct_defect_codes"
      expr: COUNT(DISTINCT defect_code)
      comment: "Number of unique defect codes observed; breadth of defect variety signals systemic vs. isolated quality issues."
    - name: "avg_closure_cycle_days"
      expr: AVG(DATEDIFF(actual_closure_date, reported_timestamp))
      comment: "Average days from NCR detection to closure; a key quality responsiveness KPI tracked in QMS reviews."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics measuring effectiveness, timeliness, and systemic quality improvement across the enterprise."
  source: "`vibe_manufacturing_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Distinguishes corrective (reactive) from preventive (proactive) actions for strategic quality investment analysis."
    - name: "capa_status"
      expr: capa_status
      comment: "Current CAPA lifecycle status (open, in-progress, closed, overdue) for workload and compliance tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA; enables risk-based resource allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for Pareto analysis of systemic quality drivers."
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used (5-Why, Fishbone, FMEA) to understand analytical rigour applied."
    - name: "source_type"
      expr: source_type
      comment: "Origin of the CAPA (NCR, customer complaint, audit, SPC) for source-based quality trend analysis."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the CAPA was verified as effective; the ultimate quality outcome measure."
    - name: "ppap_impact_flag"
      expr: ppap_impact_flag
      comment: "Flag indicating PPAP re-submission is required; drives customer notification and supply risk."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flag for CAPAs with regulatory compliance implications; critical for audit readiness."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month CAPA was initiated for trend and backlog analysis."
  measures:
    - name: "total_capa_count"
      expr: COUNT(1)
      comment: "Total CAPAs raised; baseline volume metric for quality management system health."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open CAPAs; high open counts signal quality system backlog and compliance risk."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') AND target_closure_date < CURRENT_TIMESTAMP() THEN 1 END)
      comment: "CAPAs past their target closure date; a direct audit finding risk indicator."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Count of CAPAs confirmed effective; measures quality system's ability to eliminate root causes."
    - name: "ppap_impacted_capa_count"
      expr: COUNT(CASE WHEN ppap_impact_flag = TRUE THEN 1 END)
      comment: "CAPAs requiring PPAP re-submission; drives customer communication and supply continuity risk."
    - name: "regulatory_impacted_capa_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "CAPAs with regulatory impact; critical for compliance reporting and audit preparation."
    - name: "avg_capa_closure_days"
      expr: AVG(DATEDIFF(actual_closure_date, initiated_date))
      comment: "Average days from CAPA initiation to closure; a key QMS responsiveness KPI."
    - name: "recurrence_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs flagged as recurrences; high recurrence rate signals ineffective root cause elimination."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics measuring incoming, in-process, and outgoing quality performance including yield, disposition rates, and nonconformance volumes."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type_code"
      expr: inspection_type_code
      comment: "Type of inspection (incoming goods, in-process, final, customer return) for stage-specific quality analysis."
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inspection lot (accepted, rejected, under inspection, quarantine)."
    - name: "overall_result"
      expr: overall_result
      comment: "Final inspection verdict (pass/fail/conditional) for yield and acceptance rate calculations."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition decision (use-as-is, rework, scrap, return-to-supplier) for material flow analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Inspection method applied (AQL sampling, 100% inspection, skip-lot) for cost and coverage analysis."
    - name: "ncr_triggered"
      expr: ncr_triggered
      comment: "Whether the lot triggered an NCR; links inspection outcomes to quality event management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where inspection was performed for site-level quality benchmarking."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_start_timestamp)
      comment: "Month of inspection start for trend analysis."
  measures:
    - name: "total_lots_inspected"
      expr: COUNT(1)
      comment: "Total inspection lots processed; baseline throughput metric for quality operations capacity."
    - name: "lots_passed"
      expr: COUNT(CASE WHEN overall_result = 'Pass' THEN 1 END)
      comment: "Count of lots that passed inspection; numerator for first-pass yield rate."
    - name: "lots_failed"
      expr: COUNT(CASE WHEN overall_result = 'Fail' THEN 1 END)
      comment: "Count of lots that failed inspection; drives scrap, rework, and supplier corrective action workload."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity of units across all inspection lots; denominator for defect rate calculations."
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Total nonconforming units identified; directly tied to scrap cost and customer risk exposure."
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS DOUBLE))
      comment: "Average sample size per lot; monitors sampling plan compliance and inspection coverage."
    - name: "ncr_triggered_lot_count"
      expr: COUNT(CASE WHEN ncr_triggered = TRUE THEN 1 END)
      comment: "Lots that triggered an NCR; measures the rate at which inspection findings escalate to formal quality events."
    - name: "avg_inspection_duration_hours"
      expr: AVG(DATEDIFF(inspection_end_timestamp, inspection_start_timestamp) * 24)
      comment: "Average inspection cycle time in hours; a key quality operations efficiency metric."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics providing granular characteristic-level quality performance including process capability indices, out-of-spec rates, and SPC signals."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of quality characteristic (dimensional, functional, visual, chemical) for defect category analysis."
    - name: "result_status"
      expr: result_status
      comment: "Pass/fail/conditional status of the individual inspection result."
    - name: "is_out_of_spec"
      expr: is_out_of_spec
      comment: "Flag for results outside specification limits; primary quality signal for process control."
    - name: "is_out_of_control"
      expr: is_out_of_control
      comment: "Flag for SPC out-of-control signals; indicates process instability requiring immediate intervention."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (incoming, in-process, final) for stage-specific quality analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for measurement; enables gauge and method performance comparison."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where measurement was taken for site-level quality benchmarking."
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift during which measurement was taken; enables shift-level quality comparison."
    - name: "spc_chart_type"
      expr: spc_chart_type
      comment: "Type of SPC chart applied (Xbar-R, Xbar-S, p-chart) for control methodology analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection for trend analysis."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total inspection measurements recorded; baseline volume for quality data density assessment."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_out_of_spec = TRUE THEN 1 END)
      comment: "Count of measurements outside specification limits; primary defect volume KPI."
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN is_out_of_control = TRUE THEN 1 END)
      comment: "Count of SPC out-of-control signals; drives immediate process investigation and containment."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all results; monitors process centering relative to nominal."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average process capability index (Cpk); the primary process capability KPI used in PPAP and customer scorecards."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average process potential index (Cp); measures inherent process spread relative to specification width."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk across all characteristics; identifies the worst-performing process characteristic requiring priority attention."
    - name: "distinct_characteristics_measured"
      expr: COUNT(DISTINCT inspection_characteristic_id)
      comment: "Number of unique characteristics measured; monitors inspection plan coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FMEA (Failure Mode and Effects Analysis) metrics tracking risk prioritisation, action completion, and risk reduction effectiveness across design and process FMEAs."
  source: "`vibe_manufacturing_v1`.`quality`.`fmea`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "FMEA type (Design FMEA, Process FMEA, System FMEA) for risk analysis segmentation."
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current FMEA lifecycle status (draft, approved, under review, obsolete)."
    - name: "action_priority"
      expr: action_priority
      comment: "Action priority level (high, medium, low) derived from RPN for resource allocation decisions."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Flag for failure modes with safety implications; drives mandatory escalation and regulatory reporting."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag for failure modes with regulatory compliance implications."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Specific failure mode description for Pareto analysis of top risk contributors."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the FMEA for site-level risk benchmarking."
    - name: "fmea_initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month FMEA was initiated for portfolio trend analysis."
  measures:
    - name: "total_fmea_count"
      expr: COUNT(1)
      comment: "Total FMEAs in the portfolio; baseline for risk management coverage assessment."
    - name: "safety_critical_fmea_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Count of FMEAs with safety-critical failure modes; a mandatory executive risk KPI."
    - name: "high_priority_action_count"
      expr: COUNT(CASE WHEN action_priority = 'High' THEN 1 END)
      comment: "Count of high-priority action items requiring immediate attention; drives resource allocation decisions."
    - name: "overdue_fmea_count"
      expr: COUNT(CASE WHEN fmea_status NOT IN ('Approved', 'Closed', 'Obsolete') AND target_completion_date < CURRENT_TIMESTAMP() THEN 1 END)
      comment: "FMEAs past their target completion date; a compliance and product launch risk indicator."
    - name: "avg_days_to_fmea_approval"
      expr: AVG(DATEDIFF(approved_date, initiated_date))
      comment: "Average days from FMEA initiation to approval; measures engineering quality process efficiency."
    - name: "distinct_failure_modes"
      expr: COUNT(DISTINCT failure_mode)
      comment: "Number of unique failure modes identified across all FMEAs; breadth of risk landscape visibility."
    - name: "regulatory_flagged_fmea_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "FMEAs with regulatory compliance implications; critical for product certification and market access."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control plan metrics measuring coverage, critical characteristic management, and SPC deployment across manufacturing processes."
  source: "`vibe_manufacturing_v1`.`quality`.`control_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Control plan type (prototype, pre-launch, production) aligned to APQP phase."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the control plan (active, draft, obsolete) for governance tracking."
    - name: "characteristic_class"
      expr: characteristic_class
      comment: "Characteristic classification (critical, significant, major, minor) for risk-based control prioritisation."
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic (dimensional, functional, visual) for control method analysis."
    - name: "is_ctq"
      expr: is_ctq
      comment: "Critical-to-Quality flag; CTQ characteristics require the highest level of control and monitoring."
    - name: "is_safety_characteristic"
      expr: is_safety_characteristic
      comment: "Safety characteristic flag; drives mandatory control requirements and regulatory compliance."
    - name: "is_regulatory_requirement"
      expr: is_regulatory_requirement
      comment: "Flag for characteristics mandated by regulatory standards."
    - name: "control_method"
      expr: control_method
      comment: "Control method applied (SPC, attribute inspection, error-proofing) for method effectiveness analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the control plan is applied for site-level coverage benchmarking."
  measures:
    - name: "total_control_plan_characteristics"
      expr: COUNT(1)
      comment: "Total control plan characteristic entries; measures breadth of process control coverage."
    - name: "ctq_characteristic_count"
      expr: COUNT(CASE WHEN is_ctq = TRUE THEN 1 END)
      comment: "Count of Critical-to-Quality characteristics under control; a key product quality assurance KPI."
    - name: "safety_characteristic_count"
      expr: COUNT(CASE WHEN is_safety_characteristic = TRUE THEN 1 END)
      comment: "Count of safety-critical characteristics; mandatory for regulatory compliance and product liability management."
    - name: "spc_enabled_characteristic_count"
      expr: COUNT(CASE WHEN spc_chart_type IS NOT NULL THEN 1 END)
      comment: "Count of characteristics with SPC charts deployed; measures statistical process control coverage."
    - name: "avg_nominal_value"
      expr: AVG(CAST(nominal_value AS DOUBLE))
      comment: "Average nominal target value across control plan characteristics; used for process centering analysis."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit; used in aggregate tolerance analysis."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit; used in aggregate tolerance analysis."
    - name: "distinct_process_steps"
      expr: COUNT(DISTINCT process_step_name)
      comment: "Number of unique process steps covered by control plans; measures process control completeness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_spc`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) metrics measuring process capability, control limit performance, and chart deployment across manufacturing operations."
  source: "`vibe_manufacturing_v1`.`quality`.`spc`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "SPC chart type (Xbar-R, Xbar-S, p-chart, c-chart) for methodology coverage analysis."
    - name: "chart_status"
      expr: chart_status
      comment: "Current status of the SPC chart (active, suspended, archived) for deployment health monitoring."
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic being monitored (variable, attribute) for SPC method appropriateness."
    - name: "characteristic_criticality"
      expr: characteristic_criticality
      comment: "Criticality level of the monitored characteristic for risk-based SPC prioritisation."
    - name: "nelson_rules_enabled"
      expr: nelson_rules_enabled
      comment: "Whether Nelson rules are active; indicates level of statistical rigour applied."
    - name: "western_electric_rules_enabled"
      expr: western_electric_rules_enabled
      comment: "Whether Western Electric rules are active; standard for automotive and aerospace SPC compliance."
    - name: "auto_recalculate_limits"
      expr: auto_recalculate_limits
      comment: "Whether control limits are automatically recalculated; indicates SPC system maturity."
    - name: "capability_assessment_month"
      expr: DATE_TRUNC('month', capability_assessment_date)
      comment: "Month of last capability assessment for trend analysis."
  measures:
    - name: "total_spc_charts"
      expr: COUNT(1)
      comment: "Total SPC charts deployed; baseline for statistical process control coverage assessment."
    - name: "active_spc_charts"
      expr: COUNT(CASE WHEN chart_status = 'Active' THEN 1 END)
      comment: "Count of currently active SPC charts; measures live process monitoring coverage."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Cpk across all SPC charts; the primary process capability KPI for manufacturing quality."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Cp (process potential) across all charts; measures inherent process spread vs. specification."
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Ppk (process performance) across all charts; used for PPAP submissions and customer reporting."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk across all active SPC charts; identifies the most at-risk process characteristic."
    - name: "charts_below_cpk_threshold"
      expr: COUNT(CASE WHEN cpk_index < 1.33 THEN 1 END)
      comment: "Count of SPC charts with Cpk below 1.33 (automotive minimum); drives immediate process improvement action."
    - name: "avg_subgroup_size"
      expr: AVG(CAST(subgroup_size AS DOUBLE))
      comment: "Average subgroup size across SPC charts; monitors sampling plan adequacy for statistical validity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP (Production Part Approval Process) submission metrics tracking approval rates, submission timeliness, and customer acceptance performance for new product launches."
  source: "`vibe_manufacturing_v1`.`quality`.`ppap_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current PPAP submission status (submitted, approved, rejected, interim approval) for launch readiness tracking."
    - name: "submission_level"
      expr: submission_level
      comment: "PPAP submission level (1-5) indicating depth of documentation required by the customer."
    - name: "submission_reason"
      expr: submission_reason
      comment: "Reason for PPAP submission (new part, engineering change, tooling change) for change management analysis."
    - name: "psw_disposition"
      expr: psw_disposition
      comment: "Part Submission Warrant disposition (approved, rejected, interim) — the ultimate customer acceptance decision."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase at time of submission for launch timeline analysis."
    - name: "is_safety_critical_part"
      expr: is_safety_critical_part
      comment: "Flag for safety-critical parts requiring enhanced PPAP scrutiny."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the submission for market access risk tracking."
    - name: "manufacturing_site"
      expr: manufacturing_site
      comment: "Manufacturing site for the submitted part; enables site-level PPAP performance benchmarking."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of PPAP submission for launch pipeline trend analysis."
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total PPAP submissions; baseline volume for new product launch pipeline management."
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Count of approved PPAP submissions; numerator for first-time approval rate."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected submissions; drives rework cost and launch delay risk analysis."
    - name: "interim_approval_count"
      expr: COUNT(CASE WHEN psw_disposition = 'Interim' THEN 1 END)
      comment: "Count of parts on interim approval; interim approvals represent supply continuity risk requiring active management."
    - name: "safety_critical_submission_count"
      expr: COUNT(CASE WHEN is_safety_critical_part = TRUE THEN 1 END)
      comment: "Count of safety-critical PPAP submissions; requires executive visibility for product liability management."
    - name: "avg_cpk_minimum"
      expr: AVG(CAST(cpk_minimum AS DOUBLE))
      comment: "Average minimum Cpk committed in PPAP submissions; monitors process capability commitments to customers."
    - name: "avg_days_to_customer_approval"
      expr: AVG(DATEDIFF(customer_approval_date, submission_date))
      comment: "Average days from PPAP submission to customer approval; a key launch timeline KPI."
    - name: "resubmission_required_count"
      expr: COUNT(CASE WHEN resubmission_due_date IS NOT NULL THEN 1 END)
      comment: "Count of submissions requiring resubmission; measures first-time quality of PPAP packages."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics measuring external quality performance, complaint resolution speed, and customer satisfaction risk across the product portfolio."
  source: "`vibe_manufacturing_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (product defect, delivery, documentation, service) for category-based quality analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current complaint lifecycle status (open, under investigation, closed) for resolution pipeline management."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (field return, warranty, direct customer) for source analysis."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode reported by the customer; enables Pareto analysis of top external quality issues."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic quality improvement prioritisation."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for complaints requiring regulatory reporting; critical for compliance and product safety management."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag for safety-related complaints; drives mandatory escalation and potential recall assessment."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the complaint was resolved (replacement, repair, credit, no-fault) for cost and satisfaction analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the complained product for site-level quality accountability."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month complaint was received for trend and seasonality analysis."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total customer complaints received; primary external quality KPI tracked in executive dashboards."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open complaints; high open counts signal customer satisfaction risk and resource pressure."
    - name: "safety_related_complaints"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Count of safety-related complaints; mandatory executive KPI for product liability and recall risk management."
    - name: "regulatory_reportable_complaints"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting; drives compliance action and potential market withdrawal decisions."
    - name: "avg_severity_level"
      expr: AVG(CAST(severity_level AS DOUBLE))
      comment: "Average complaint severity score; monitors overall external quality risk level over time."
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, received_timestamp))
      comment: "Average days from complaint receipt to closure; a key customer satisfaction and QMS responsiveness KPI."
    - name: "distinct_failure_modes"
      expr: COUNT(DISTINCT failure_mode)
      comment: "Number of unique failure modes reported by customers; breadth of external quality issues requiring systemic action."
    - name: "complaints_with_8d"
      expr: COUNT(CASE WHEN eight_d_report_number IS NOT NULL THEN 1 END)
      comment: "Count of complaints with 8D reports issued; measures structured problem-solving response rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics measuring audit programme execution, findings severity, CAPA response rates, and overall quality management system compliance performance."
  source: "`vibe_manufacturing_v1`.`quality`.`quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Audit type (internal, external, certification, surveillance) for programme coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit lifecycle status (planned, in-progress, closed, overdue) for programme execution tracking."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome (conforming, minor NC, major NC, critical NC) for compliance performance benchmarking."
    - name: "audit_category"
      expr: audit_category
      comment: "Audit category (process, product, system, supplier) for scope-based analysis."
    - name: "audit_method"
      expr: audit_method
      comment: "Audit method (on-site, remote, document review) for resource and coverage analysis."
    - name: "capa_required"
      expr: capa_required
      comment: "Whether the audit finding requires a CAPA; links audit performance to corrective action workload."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Whether a re-audit is required; indicates unresolved compliance gaps."
    - name: "audited_entity_type"
      expr: audited_entity_type
      comment: "Type of entity audited (department, process, supplier, product line) for scope analysis."
    - name: "standard"
      expr: standard
      comment: "Quality standard audited against (ISO 9001, IATF 16949, AS9100) for certification management."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month audit was planned to start for programme scheduling analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total quality audits conducted; baseline for audit programme execution completeness."
    - name: "audits_with_major_ncr"
      expr: COUNT(CASE WHEN CAST(major_ncr_count AS DOUBLE) > 0 THEN 1 END)
      comment: "Count of audits with major nonconformances; a critical compliance risk KPI requiring executive attention."
    - name: "total_major_ncr_count"
      expr: SUM(CAST(major_ncr_count AS DOUBLE))
      comment: "Total major NCRs raised across all audits; aggregate compliance gap measure for QMS health assessment."
    - name: "total_minor_ncr_count"
      expr: SUM(CAST(minor_ncr_count AS DOUBLE))
      comment: "Total minor NCRs raised; monitors cumulative compliance improvement opportunities."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all completed audits; primary QMS performance benchmark for executive reporting."
    - name: "avg_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average audit duration in days; monitors audit resource efficiency and planning accuracy."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of audits requiring CAPA; measures corrective action workload generated by the audit programme."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Count of audits requiring re-audit; indicates unresolved compliance gaps and certification risk."
    - name: "avg_total_checklist_items"
      expr: AVG(CAST(total_checklist_items AS DOUBLE))
      comment: "Average number of checklist items per audit; monitors audit depth and coverage consistency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_supplier_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality audit metrics measuring supplier compliance performance, audit scores, CAPA response rates, and qualification status across the supply base."
  source: "`vibe_manufacturing_v1`.`quality`.`supplier_quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Supplier audit type (initial qualification, surveillance, re-qualification, PPAP) for supply base management."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status for programme execution tracking."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome for supplier performance benchmarking and approved vendor list management."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Standard audited against (ISO 9001, IATF 16949, AS9100) for certification compliance tracking."
    - name: "capa_required"
      expr: capa_required
      comment: "Whether the audit requires supplier CAPA; drives supplier development workload."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Whether a re-audit is required; indicates unresolved supplier quality gaps."
    - name: "ppap_assessment_included"
      expr: ppap_assessment_included
      comment: "Whether PPAP assessment was included; indicates depth of supplier quality evaluation."
    - name: "supplier_facility_country"
      expr: supplier_facility_country
      comment: "Country of audited supplier facility for geographic supply risk analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month audit was planned for programme scheduling and trend analysis."
  measures:
    - name: "total_supplier_audits"
      expr: COUNT(1)
      comment: "Total supplier quality audits conducted; baseline for supply base quality oversight coverage."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average supplier audit score; primary supplier quality performance KPI for approved vendor list decisions."
    - name: "min_audit_score"
      expr: MIN(audit_score)
      comment: "Minimum supplier audit score; identifies the lowest-performing supplier requiring immediate development action."
    - name: "total_major_ncr_count"
      expr: SUM(CAST(major_ncr_count AS DOUBLE))
      comment: "Total major NCRs raised across supplier audits; aggregate supply base compliance gap measure."
    - name: "total_minor_ncr_count"
      expr: SUM(CAST(minor_ncr_count AS DOUBLE))
      comment: "Total minor NCRs raised across supplier audits; monitors cumulative supplier improvement opportunities."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average supplier audit duration; monitors audit resource efficiency and planning accuracy."
    - name: "capa_required_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of supplier audits requiring CAPA; measures supplier corrective action workload."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Count of suppliers requiring re-audit; a leading indicator of supply base qualification risk."
    - name: "avg_supplier_qualification_level"
      expr: AVG(CAST(supplier_qualification_level AS DOUBLE))
      comment: "Average supplier qualification level score; monitors overall supply base quality maturity."
    - name: "distinct_suppliers_audited"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers audited; measures supply base quality oversight breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_apqp_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APQP (Advanced Product Quality Planning) project metrics tracking new product launch quality readiness, gate review status, and PPAP approval performance."
  source: "`vibe_manufacturing_v1`.`quality`.`apqp_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current APQP project status for launch pipeline management."
    - name: "project_type"
      expr: project_type
      comment: "Type of APQP project (new product, engineering change, platform) for portfolio segmentation."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase (1-5) for launch readiness stage-gate tracking."
    - name: "ppap_status"
      expr: ppap_status
      comment: "PPAP approval status for customer launch readiness assessment."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for new product launch gate management."
    - name: "risk_level_band"
      expr: CASE WHEN risk_level >= 8 THEN 'High' WHEN risk_level >= 4 THEN 'Medium' ELSE 'Low' END
      comment: "Risk level banding (High/Medium/Low) for portfolio risk prioritisation."
    - name: "lessons_learned_documented"
      expr: lessons_learned_documented
      comment: "Whether lessons learned were documented; measures knowledge management compliance."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month project was planned to start for launch pipeline trend analysis."
  measures:
    - name: "total_apqp_projects"
      expr: COUNT(1)
      comment: "Total APQP projects in the portfolio; baseline for new product launch pipeline management."
    - name: "active_projects"
      expr: COUNT(CASE WHEN project_status NOT IN ('Closed', 'Cancelled', 'Completed') THEN 1 END)
      comment: "Count of active APQP projects; measures current new product launch workload."
    - name: "ppap_approved_count"
      expr: COUNT(CASE WHEN ppap_status = 'Approved' THEN 1 END)
      comment: "Count of projects with approved PPAP; measures launch readiness achievement rate."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level >= 8 THEN 1 END)
      comment: "Count of high-risk APQP projects; drives executive escalation and resource reallocation decisions."
    - name: "avg_risk_level"
      expr: AVG(CAST(risk_level AS DOUBLE))
      comment: "Average risk level across the APQP portfolio; monitors overall new product launch risk exposure."
    - name: "avg_ppap_level"
      expr: AVG(CAST(ppap_level AS DOUBLE))
      comment: "Average PPAP submission level across projects; indicates depth of customer quality requirements."
    - name: "avg_days_planned_to_actual_completion"
      expr: AVG(DATEDIFF(actual_completion_date, planned_completion_date))
      comment: "Average schedule variance in days (positive = late); key launch timeline performance KPI."
    - name: "lessons_learned_documented_count"
      expr: COUNT(CASE WHEN lessons_learned_documented = TRUE THEN 1 END)
      comment: "Count of projects with documented lessons learned; measures organisational learning compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_measurement_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measurement System Analysis (MSA) metrics tracking gauge R&R performance, calibration compliance, and measurement system capability across the quality infrastructure."
  source: "`vibe_manufacturing_v1`.`quality`.`measurement_system`"
  dimensions:
    - name: "gauge_type"
      expr: gauge_type
      comment: "Type of measurement gauge (CMM, calliper, torque wrench, vision system) for equipment category analysis."
    - name: "system_type"
      expr: system_type
      comment: "Measurement system type for technology-based performance benchmarking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the measurement system (active, retired, under calibration) for asset management."
    - name: "is_capable"
      expr: is_capable
      comment: "Whether the measurement system is deemed capable (Gauge R&R < 10%); primary MSA acceptance flag."
    - name: "calibration_status"
      expr: CAST(calibration_status AS STRING)
      comment: "Current calibration status for compliance monitoring."
    - name: "msa_method"
      expr: msa_method
      comment: "MSA study method applied (crossed, nested, expanded) for study methodology analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the measurement system is deployed for site-level calibration compliance tracking."
    - name: "last_calibration_month"
      expr: DATE_TRUNC('month', last_calibration_date)
      comment: "Month of last calibration for compliance trend analysis."
  measures:
    - name: "total_measurement_systems"
      expr: COUNT(1)
      comment: "Total measurement systems in the quality infrastructure; baseline for MSA programme coverage."
    - name: "capable_systems_count"
      expr: COUNT(CASE WHEN is_capable = TRUE THEN 1 END)
      comment: "Count of measurement systems deemed capable; numerator for MSA capability rate."
    - name: "overdue_calibration_count"
      expr: COUNT(CASE WHEN calibration_due_date < CURRENT_TIMESTAMP() THEN 1 END)
      comment: "Count of measurement systems with overdue calibration; a direct audit finding and measurement validity risk."
    - name: "avg_gage_rr_percent"
      expr: AVG(CAST(gage_rr_percent AS DOUBLE))
      comment: "Average Gauge R&R percentage across all measurement systems; primary MSA performance KPI (target < 10%)."
    - name: "avg_gauge_rr_repeatability"
      expr: AVG(CAST(gauge_rr_repeatability AS DOUBLE))
      comment: "Average repeatability component of Gauge R&R; identifies equipment variation contribution."
    - name: "avg_gauge_rr_reproducibility"
      expr: AVG(CAST(gauge_rr_reproducibility AS DOUBLE))
      comment: "Average reproducibility component of Gauge R&R; identifies appraiser variation contribution."
    - name: "avg_ndc_value"
      expr: AVG(CAST(ndc_value AS DOUBLE))
      comment: "Average Number of Distinct Categories (NDC); NDC >= 5 is required for a capable measurement system."
    - name: "avg_calibration_interval_days"
      expr: AVG(CAST(calibration_interval_days AS DOUBLE))
      comment: "Average calibration interval in days; monitors calibration programme frequency adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_rma_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RMA disposition metrics measuring return material volumes, disposition decisions, credit exposure, and supplier responsibility rates for returned goods management."
  source: "`vibe_manufacturing_v1`.`quality`.`rma_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition decision (scrap, rework, return-to-supplier, use-as-is) for material recovery analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current disposition status for RMA pipeline management."
    - name: "rma_type"
      expr: rma_type
      comment: "RMA type (warranty, commercial, quality) for cost allocation and trend analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardised return reason code for Pareto analysis of top return drivers."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic quality improvement prioritisation."
    - name: "supplier_responsibility_flag"
      expr: supplier_responsibility_flag
      comment: "Whether the supplier is responsible for the defect; drives supplier chargeback and corrective action."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the return is a warranty claim; drives warranty cost accrual and product reliability analysis."
    - name: "scrap_disposition_flag"
      expr: scrap_disposition_flag
      comment: "Whether the material was scrapped; directly tied to material write-off cost."
    - name: "receiving_plant_code"
      expr: receiving_plant_code
      comment: "Plant receiving the returned material for site-level RMA volume tracking."
    - name: "return_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month return was received for trend and seasonality analysis."
  measures:
    - name: "total_rma_dispositions"
      expr: COUNT(1)
      comment: "Total RMA dispositions processed; baseline volume for returns management operations."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of units returned; primary volume KPI for warranty and quality cost management."
    - name: "total_quantity_disposed"
      expr: SUM(CAST(quantity_disposed AS DOUBLE))
      comment: "Total quantity of units formally disposed; measures disposition throughput vs. return volume."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued for returned goods; a direct financial impact KPI for quality cost management."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA disposition; monitors per-return financial exposure."
    - name: "supplier_responsible_count"
      expr: COUNT(CASE WHEN supplier_responsibility_flag = TRUE THEN 1 END)
      comment: "Count of dispositions where supplier is responsible; drives supplier chargeback recovery and corrective action."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of warranty claims; primary input for warranty cost accrual and product reliability analysis."
    - name: "scrap_disposition_count"
      expr: COUNT(CASE WHEN scrap_disposition_flag = TRUE THEN 1 END)
      comment: "Count of dispositions resulting in scrap; directly tied to material write-off cost exposure."
    - name: "avg_days_to_disposition"
      expr: AVG(DATEDIFF(disposition_timestamp, received_timestamp))
      comment: "Average days from return receipt to disposition decision; a key returns processing efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_compliance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance test metrics tracking regulatory and customer specification test performance, certification status, and retest rates across the product portfolio."
  source: "`vibe_manufacturing_v1`.`quality`.`compliance_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of compliance test (EMC, safety, environmental, chemical) for regulatory coverage analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current test status (planned, in-progress, passed, failed, pending certificate) for launch readiness tracking."
    - name: "test_result"
      expr: test_result
      comment: "Test outcome (pass/fail/conditional) for compliance performance benchmarking."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flag for tests with regulatory compliance implications; drives mandatory escalation."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required following the test; links test failures to quality improvement actions."
    - name: "retest_required"
      expr: retest_required
      comment: "Whether a retest is required; measures first-time pass rate and associated cost."
    - name: "laboratory_name"
      expr: laboratory_name
      comment: "Testing laboratory for lab performance and accreditation management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the tested product for site-level compliance tracking."
    - name: "test_start_month"
      expr: DATE_TRUNC('month', test_start_date)
      comment: "Month test was started for compliance programme trend analysis."
  measures:
    - name: "total_compliance_tests"
      expr: COUNT(1)
      comment: "Total compliance tests conducted; baseline for regulatory testing programme coverage."
    - name: "tests_passed"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of tests that passed; numerator for first-time pass rate calculation."
    - name: "tests_failed"
      expr: COUNT(CASE WHEN test_result = 'Fail' THEN 1 END)
      comment: "Count of failed tests; drives corrective action workload and launch delay risk."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Count of tests requiring retest; measures first-time pass rate and associated cost impact."
    - name: "regulatory_impacted_test_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of tests with regulatory implications; critical for market access and certification management."
    - name: "total_test_cost"
      expr: SUM(CAST(test_cost_amount AS DOUBLE))
      comment: "Total compliance testing cost; a key quality cost of conformance KPI for budget management."
    - name: "avg_test_cost"
      expr: AVG(CAST(test_cost_amount AS DOUBLE))
      comment: "Average cost per compliance test; monitors testing efficiency and laboratory cost management."
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(test_completion_date, test_start_date))
      comment: "Average test cycle time in days; a key launch timeline and laboratory throughput KPI."
$$;