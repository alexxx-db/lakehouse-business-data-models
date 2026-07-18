-- Metric views for domain: quality | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) metrics tracking defect volumes, severity distribution, closure performance, and nonconforming quantities to drive quality improvement decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (open, closed, under review) for pipeline analysis."
    - name: "ncr_type"
      expr: ncr_type
      comment: "Classification of the non-conformance (incoming, in-process, customer return) for root-cause segmentation."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the non-conformance to prioritize escalation and resource allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause bucket (material, process, design, supplier) for Pareto analysis."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the defect was detected (incoming inspection, in-process, field) to measure escape rate by gate."
    - name: "defect_code"
      expr: defect_code
      comment: "Specific defect code for granular failure mode analysis."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month of detection for trend analysis over time."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag indicating whether the NCR must be reported to a regulatory body, for compliance risk tracking."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of NCRs raised; baseline volume metric for quality performance dashboards."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Count of NCRs currently open; drives workload and backlog management decisions."
    - name: "total_nonconforming_qty"
      expr: SUM(CAST(nonconforming_qty AS DOUBLE))
      comment: "Total nonconforming quantity across all NCRs; directly measures material waste and scrap exposure."
    - name: "avg_nonconforming_qty_per_ncr"
      expr: AVG(CAST(nonconforming_qty AS DOUBLE))
      comment: "Average nonconforming quantity per NCR; indicates typical defect batch size for process control."
    - name: "regulatory_reportable_ncr_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of NCRs flagged as regulatory reportable; critical compliance risk indicator for legal and quality leadership."
    - name: "ncr_with_8d_required_count"
      expr: COUNT(CASE WHEN is_8d_required = TRUE THEN 1 END)
      comment: "Count of NCRs requiring an 8D corrective action report; measures severity of systemic quality failures."
    - name: "closed_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END)
      comment: "Count of closed NCRs; used with total count to compute closure rate in BI."
    - name: "distinct_affected_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers associated with NCRs; identifies supplier quality concentration risk."
    - name: "distinct_affected_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs affected by NCRs; highlights product lines with systemic quality issues."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics measuring effectiveness, closure timeliness, recurrence, and regulatory impact to steer quality system performance."
  source: "`vibe_manufacturing_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current CAPA lifecycle status (initiated, in-progress, closed, overdue) for pipeline management."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of action (corrective vs. preventive) to measure proactive vs. reactive quality posture."
    - name: "priority"
      expr: priority
      comment: "CAPA priority level (critical, high, medium, low) for resource prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic trend analysis and process improvement targeting."
    - name: "source_type"
      expr: source_type
      comment: "Origin of the CAPA (customer complaint, audit, NCR, internal) to identify leading quality signals."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the corrective action was verified as effective; key quality system maturity indicator."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month CAPA was initiated for trend and aging analysis."
    - name: "ppap_impact_flag"
      expr: ppap_impact_flag
      comment: "Flag indicating CAPA impacts a PPAP submission; critical for new product launch risk management."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flag indicating regulatory impact; drives compliance escalation decisions."
  measures:
    - name: "total_capa_count"
      expr: COUNT(1)
      comment: "Total CAPAs raised; baseline quality system activity metric."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open CAPAs; measures quality backlog and systemic risk exposure."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Count of CAPAs with verified effectiveness; numerator for CAPA effectiveness rate in BI."
    - name: "recurrence_flag_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs flagged as recurrences; measures quality system failure to prevent repeat defects — a critical leadership KPI."
    - name: "regulatory_impact_capa_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with regulatory impact; drives compliance risk reporting to executives."
    - name: "ppap_impact_capa_count"
      expr: COUNT(CASE WHEN ppap_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs affecting PPAP submissions; critical for new product launch readiness decisions."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Count of CAPAs requiring customer notification; measures customer-facing quality risk exposure."
    - name: "distinct_affected_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active CAPAs; identifies supplier quality concentration risk."
    - name: "distinct_affected_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with CAPAs; highlights product lines with systemic quality issues."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics measuring pass/fail rates, nonconforming quantities, NCR trigger rates, and lot disposition to drive incoming and in-process quality decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inspection lot (accepted, rejected, under inspection) for disposition tracking."
    - name: "overall_result"
      expr: overall_result
      comment: "Final inspection outcome (pass, fail, conditional) for yield analysis."
    - name: "inspection_type_code"
      expr: inspection_type_code
      comment: "Type of inspection (incoming, in-process, final, customer return) for gate-level quality analysis."
    - name: "inspection_level"
      expr: inspection_level
      comment: "Sampling level applied (normal, tightened, reduced) to assess inspection stringency trends."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Material disposition decision (use-as-is, rework, scrap, return to supplier) for cost impact analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where inspection occurred for site-level quality benchmarking."
    - name: "ncr_triggered"
      expr: ncr_triggered
      comment: "Whether the lot triggered an NCR; key indicator of defect escape rate."
    - name: "inspection_start_month"
      expr: DATE_TRUNC('month', inspection_start_timestamp)
      comment: "Month inspection started for trend analysis."
  measures:
    - name: "total_lots_inspected"
      expr: COUNT(1)
      comment: "Total inspection lots processed; baseline throughput metric for quality operations."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity of units submitted for inspection; measures inspection volume for capacity planning."
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Total nonconforming units across all lots; directly measures defect volume and scrap/rework exposure."
    - name: "avg_nonconforming_quantity_per_lot"
      expr: AVG(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Average nonconforming quantity per lot; indicates typical defect density for process control benchmarking."
    - name: "total_sample_size"
      expr: SUM(CAST(sample_size AS DOUBLE))
      comment: "Total units sampled across all lots; used with nonconforming quantity to compute defect rate in BI."
    - name: "ncr_triggered_lot_count"
      expr: COUNT(CASE WHEN ncr_triggered = TRUE THEN 1 END)
      comment: "Count of lots that triggered an NCR; measures defect escape rate through inspection gates."
    - name: "failed_lot_count"
      expr: COUNT(CASE WHEN overall_result = 'Fail' THEN 1 END)
      comment: "Count of lots that failed inspection; numerator for first-pass yield calculation in BI."
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with inspection lots; measures supplier quality coverage breadth."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics measuring process capability (Cp/Cpk), out-of-spec rates, and defect counts at the characteristic level to drive SPC and process improvement decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Pass/fail/conditional status of the individual inspection result for yield analysis."
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic measured (dimensional, functional, visual) for quality characteristic segmentation."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (incoming, in-process, final) for gate-level quality analysis."
    - name: "is_out_of_spec"
      expr: is_out_of_spec
      comment: "Flag indicating the measured value is outside specification limits; key defect indicator."
    - name: "is_out_of_control"
      expr: is_out_of_control
      comment: "Flag indicating the process is out of statistical control; triggers SPC investigation."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where measurement was taken for site-level process capability benchmarking."
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift for shift-level quality analysis and operator performance tracking."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection for trend analysis of process capability over time."
    - name: "spc_chart_type"
      expr: spc_chart_type
      comment: "Type of SPC chart used (Xbar-R, Xbar-S, p-chart) for control chart performance segmentation."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total inspection results recorded; baseline measurement volume metric."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_out_of_spec = TRUE THEN 1 END)
      comment: "Count of results outside specification limits; numerator for defect rate calculation in BI."
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN is_out_of_control = TRUE THEN 1 END)
      comment: "Count of results indicating out-of-control process conditions; drives SPC escalation decisions."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results; tracks process centering relative to nominal."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average process capability index (Cpk) across characteristics; primary process capability KPI for executive quality dashboards."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average process potential index (Cp) across characteristics; measures process spread relative to specification width."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk across all characteristics; identifies the worst-performing process for targeted improvement."
    - name: "total_defect_count_numeric"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all inspection results; measures overall defect volume for quality cost analysis. Note: defect_count stored as STRING — cast required."
    - name: "distinct_work_centers_measured"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers with inspection results; measures quality monitoring coverage breadth."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics measuring complaint volumes, severity, resolution timeliness, and safety-related issues to drive customer satisfaction and quality improvement decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, in-progress, closed) for pipeline and SLA management."
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint (product defect, delivery, documentation) for root-cause segmentation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the complaint (critical, major, minor) for escalation prioritization."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (field, portal, direct) for intake analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for Pareto analysis and systemic improvement targeting."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag for safety-related complaints; critical for regulatory reporting and product liability risk management."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for complaints requiring regulatory reporting; drives compliance escalation."
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_date)
      comment: "Month complaint was reported for trend analysis and seasonal pattern detection."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the complaint was resolved (replacement, credit, repair) for cost and satisfaction analysis."
  measures:
    - name: "total_complaint_count"
      expr: COUNT(1)
      comment: "Total customer complaints received; primary customer quality KPI for executive dashboards."
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open complaints; measures unresolved customer quality risk exposure."
    - name: "safety_related_complaint_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Count of safety-related complaints; critical product liability and regulatory risk KPI for C-level review."
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting; drives compliance action and legal risk management."
    - name: "capa_linked_complaint_count"
      expr: COUNT(CASE WHEN capa_id IS NOT NULL THEN 1 END)
      comment: "Count of complaints with an associated CAPA; measures systemic quality response rate."
    - name: "distinct_affected_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with customer complaints; identifies product lines with customer-facing quality issues."
    - name: "distinct_complaining_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers who filed complaints; measures breadth of customer quality dissatisfaction."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP submission metrics measuring approval rates, submission levels, and new product launch quality readiness to support production part approval decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`ppap_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current PPAP submission status (submitted, approved, rejected, interim) for launch readiness tracking."
    - name: "submission_level"
      expr: submission_level
      comment: "PPAP submission level (1-5) indicating depth of documentation required by the customer."
    - name: "psw_disposition"
      expr: psw_disposition
      comment: "Part Submission Warrant disposition (approved, interim, rejected) for launch gate decisions."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase at time of submission for new product development quality tracking."
    - name: "is_safety_critical_part"
      expr: is_safety_critical_part
      comment: "Flag for safety-critical parts requiring heightened PPAP scrutiny."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of PPAP submission for launch pipeline trend analysis."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the submission for compliance risk tracking."
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total PPAP submissions; baseline new product launch quality activity metric."
    - name: "approved_ppap_count"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Count of approved PPAP submissions; numerator for PPAP first-pass approval rate in BI."
    - name: "rejected_ppap_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected PPAP submissions; measures new product launch quality failures requiring rework."
    - name: "interim_approval_count"
      expr: COUNT(CASE WHEN psw_disposition = 'Interim' THEN 1 END)
      comment: "Count of interim PPAP approvals; measures launch risk from parts not yet fully qualified."
    - name: "safety_critical_submission_count"
      expr: COUNT(CASE WHEN is_safety_critical_part = TRUE THEN 1 END)
      comment: "Count of PPAP submissions for safety-critical parts; drives heightened review and resource allocation."
    - name: "avg_cpk_minimum"
      expr: AVG(CAST(cpk_minimum AS DOUBLE))
      comment: "Average minimum Cpk required across PPAP submissions; measures process capability standards set by customers."
    - name: "distinct_customers_with_ppap"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with PPAP submissions; measures new product launch breadth across customer base."
    - name: "distinct_skus_in_ppap"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs undergoing PPAP; measures new product launch pipeline size."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_spc`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) chart metrics measuring process capability indices, control limit performance, and chart coverage to drive process improvement and manufacturing excellence decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`spc`"
  dimensions:
    - name: "chart_status"
      expr: chart_status
      comment: "Current status of the SPC chart (active, suspended, archived) for monitoring coverage analysis."
    - name: "chart_type"
      expr: chart_type
      comment: "Type of SPC chart (Xbar-R, p-chart, c-chart) for control methodology segmentation."
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic being controlled (dimensional, functional) for quality characteristic analysis."
    - name: "characteristic_criticality"
      expr: characteristic_criticality
      comment: "Criticality level of the characteristic (safety, regulatory, key) for prioritized monitoring."
    - name: "ppap_submission_level"
      expr: ppap_submission_level
      comment: "PPAP level associated with the SPC chart for new product launch quality linkage."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month SPC chart became effective for monitoring coverage trend analysis."
    - name: "nelson_rules_enabled"
      expr: nelson_rules_enabled
      comment: "Whether Nelson rules are enabled for this chart; indicates advanced SPC monitoring maturity."
    - name: "western_electric_rules_enabled"
      expr: western_electric_rules_enabled
      comment: "Whether Western Electric rules are enabled; indicates SPC rigor level for process control."
  measures:
    - name: "total_spc_charts"
      expr: COUNT(1)
      comment: "Total active SPC charts; measures breadth of statistical process control coverage across manufacturing."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Cpk across all SPC charts; primary process capability KPI for manufacturing excellence dashboards."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Cp (process potential) across all SPC charts; measures process spread relative to specification width."
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Ppk (process performance) across all SPC charts; measures long-term process performance for customer reporting."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk across all SPC charts; identifies the worst-performing process requiring immediate improvement action."
    - name: "charts_below_cpk_threshold"
      expr: COUNT(CASE WHEN cpk_index < min_cpk_required THEN 1 END)
      comment: "Count of SPC charts where actual Cpk falls below the required minimum; critical process risk indicator for quality leadership."
    - name: "avg_min_cpk_required"
      expr: AVG(CAST(min_cpk_required AS DOUBLE))
      comment: "Average minimum Cpk requirement across all charts; measures customer and regulatory process capability standards."
    - name: "distinct_work_centers_with_spc"
      expr: COUNT(DISTINCT work_center_id)
      comment: "Number of distinct work centers with active SPC charts; measures statistical process control coverage breadth."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics measuring audit scores, finding rates, CAPA response rates, and re-audit requirements to drive quality management system effectiveness decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`quality_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit lifecycle status (planned, in-progress, closed) for audit pipeline management."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, customer, regulatory) for audit program segmentation."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome (conforming, major NC, minor NC, observation) for quality system health assessment."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (process, product, system) for targeted quality improvement analysis."
    - name: "audited_entity_type"
      expr: audited_entity_type
      comment: "Type of entity audited (department, process, supplier) for audit scope analysis."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating a re-audit is required; measures quality system failure rate."
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating CAPA is required from audit findings; measures systemic quality issue rate."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month audit was planned to start for audit program scheduling analysis."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total quality audits conducted; baseline quality management system activity metric."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all quality audits; primary quality management system health KPI for executive review."
    - name: "min_audit_score"
      expr: MIN(score)
      comment: "Minimum audit score recorded; identifies worst-performing area requiring immediate quality intervention."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average audit duration in days; measures audit efficiency and resource utilization."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of audits requiring CAPA; measures rate of systemic quality findings driving corrective action."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Count of audits requiring re-audit; measures quality system failure to achieve conformance on first audit."
    - name: "total_major_ncr_count"
      expr: SUM(CAST(major_ncr_count AS DOUBLE))
      comment: "Total major non-conformances found across all audits; critical quality system risk indicator. Note: major_ncr_count stored as STRING — cast required."
    - name: "total_minor_ncr_count"
      expr: SUM(CAST(minor_ncr_count AS DOUBLE))
      comment: "Total minor non-conformances found across all audits; measures quality system finding volume."
    - name: "distinct_audited_entities"
      expr: COUNT(DISTINCT audited_entity_name)
      comment: "Number of distinct entities audited; measures audit program coverage breadth."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_supplier_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality audit metrics measuring supplier audit scores, finding rates, PPAP assessment coverage, and re-audit requirements to drive supplier quality management decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`supplier_quality_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the supplier audit (planned, in-progress, closed) for audit pipeline management."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of supplier audit (initial qualification, surveillance, re-qualification) for supplier lifecycle analysis."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome (approved, conditional, rejected) for supplier qualification decisions."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (process, system, product) for targeted supplier improvement analysis."
    - name: "supplier_qualification_level"
      expr: supplier_qualification_level
      comment: "Supplier qualification tier resulting from the audit for approved vendor list management."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating re-audit is required; measures supplier quality failure rate."
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating CAPA is required from supplier audit findings; measures systemic supplier quality issues."
    - name: "ppap_assessment_included"
      expr: ppap_assessment_included
      comment: "Flag indicating PPAP assessment was included in the audit; measures new product launch quality coverage."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month supplier audit was planned for audit program scheduling analysis."
  measures:
    - name: "total_supplier_audits"
      expr: COUNT(1)
      comment: "Total supplier quality audits conducted; baseline supplier quality management activity metric."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average supplier audit score; primary supplier quality KPI for procurement and quality leadership decisions."
    - name: "min_audit_score"
      expr: MIN(audit_score)
      comment: "Minimum supplier audit score; identifies highest-risk suppliers requiring immediate quality intervention."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average supplier audit duration in days; measures audit efficiency and resource planning."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of supplier audits requiring CAPA; measures rate of systemic supplier quality failures."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Count of supplier audits requiring re-audit; measures supplier quality non-conformance rate."
    - name: "total_major_ncr_count"
      expr: SUM(CAST(major_ncr_count AS DOUBLE))
      comment: "Total major non-conformances found in supplier audits; critical supplier risk indicator. Note: major_ncr_count stored as STRING — cast required."
    - name: "ppap_assessment_included_count"
      expr: COUNT(CASE WHEN ppap_assessment_included = TRUE THEN 1 END)
      comment: "Count of supplier audits that included PPAP assessment; measures new product launch supplier quality coverage."
    - name: "distinct_suppliers_audited"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers audited; measures supplier quality monitoring coverage breadth."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis (FMEA) metrics measuring risk priority numbers, safety-critical failure modes, and action completion rates to drive design and process risk reduction decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`fmea`"
  dimensions:
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current FMEA lifecycle status (draft, approved, obsolete) for document control tracking."
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (design DFMEA, process PFMEA) for risk analysis segmentation."
    - name: "action_priority"
      expr: action_priority
      comment: "Priority of recommended actions (high, medium, low) for resource allocation decisions."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Flag for safety-critical failure modes; drives mandatory review and regulatory compliance actions."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag for failure modes with regulatory compliance implications; drives compliance risk management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the FMEA for site-level risk analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month FMEA was initiated for new product development risk tracking."
  measures:
    - name: "total_fmea_count"
      expr: COUNT(1)
      comment: "Total FMEAs created; baseline risk management activity metric."
    - name: "safety_critical_fmea_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Count of FMEAs with safety-critical failure modes; critical product liability and regulatory risk KPI."
    - name: "regulatory_compliance_fmea_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of FMEAs with regulatory compliance implications; drives compliance risk reporting to leadership."
    - name: "action_completed_fmea_count"
      expr: COUNT(CASE WHEN action_taken IS NOT NULL AND action_taken != '' THEN 1 END)
      comment: "Count of FMEAs with completed recommended actions; measures risk mitigation execution rate."
    - name: "distinct_skus_with_fmea"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with FMEAs; measures risk analysis coverage across product portfolio."
    - name: "distinct_suppliers_in_fmea"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers referenced in FMEAs; measures supplier risk analysis coverage."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_rma_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RMA disposition metrics measuring return volumes, credit amounts, warranty claim rates, and supplier responsibility to drive returns management and quality cost decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`rma_disposition`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current RMA status (received, inspected, dispositioned, closed) for returns pipeline management."
    - name: "rma_type"
      expr: rma_type
      comment: "Type of RMA (warranty, non-warranty, field return) for returns cost segmentation."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of returned material (scrap, repair, return to stock, return to supplier) for cost analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the return for systemic quality improvement targeting."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Flag indicating a warranty claim is associated; drives warranty cost and liability analysis."
    - name: "supplier_responsibility_flag"
      expr: supplier_responsibility_flag
      comment: "Flag indicating supplier is responsible for the defect; drives supplier chargeback and corrective action."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating CAPA is required from the RMA; measures systemic quality issue rate from returns."
    - name: "return_initiated_month"
      expr: DATE_TRUNC('month', return_initiated_date)
      comment: "Month return was initiated for trend analysis of return volumes over time."
  measures:
    - name: "total_rma_dispositions"
      expr: COUNT(1)
      comment: "Total RMA dispositions processed; baseline returns management activity metric."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total units returned across all RMAs; measures return volume for quality cost and inventory impact analysis."
    - name: "avg_quantity_returned"
      expr: AVG(CAST(quantity_returned AS DOUBLE))
      comment: "Average quantity returned per RMA; measures typical return batch size for logistics planning."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for RMAs; measures financial impact of product returns on revenue."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA; measures typical financial exposure per return event."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of RMAs with warranty claims; measures warranty liability exposure for financial planning."
    - name: "supplier_responsibility_count"
      expr: COUNT(CASE WHEN supplier_responsibility_flag = TRUE THEN 1 END)
      comment: "Count of RMAs where supplier is responsible; drives supplier chargeback recovery and corrective action."
    - name: "capa_required_rma_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of RMAs requiring CAPA; measures systemic quality failure rate from field returns."
    - name: "distinct_customers_with_rma"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with RMA dispositions; measures breadth of customer-facing quality issues."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_apqp_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Product Quality Planning (APQP) project metrics measuring launch readiness, PPAP approval rates, and on-time delivery of quality milestones to drive new product introduction decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`apqp_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current APQP project status (active, on-hold, completed, cancelled) for launch pipeline management."
    - name: "project_type"
      expr: project_type
      comment: "Type of APQP project (new product, engineering change, resourcing) for portfolio segmentation."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase (1-5) for launch readiness stage-gate tracking."
    - name: "ppap_status"
      expr: ppap_status
      comment: "PPAP approval status for the project; critical new product launch gate indicator."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP submission level required by the customer for documentation depth analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk level (high, medium, low) for resource prioritization and executive escalation."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for the APQP project; drives launch go/no-go decisions."
    - name: "lessons_learned_documented"
      expr: lessons_learned_documented
      comment: "Flag indicating lessons learned were documented; measures organizational learning maturity."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month project was planned to start for launch pipeline trend analysis."
  measures:
    - name: "total_apqp_projects"
      expr: COUNT(1)
      comment: "Total APQP projects in the portfolio; baseline new product launch pipeline metric."
    - name: "active_apqp_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Count of active APQP projects; measures current new product launch workload."
    - name: "ppap_approved_count"
      expr: COUNT(CASE WHEN ppap_status = 'Approved' THEN 1 END)
      comment: "Count of APQP projects with approved PPAP; numerator for PPAP first-pass approval rate in BI."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of high-risk APQP projects; drives executive escalation and resource reallocation decisions."
    - name: "customer_approved_project_count"
      expr: COUNT(CASE WHEN customer_approval_status = 'Approved' THEN 1 END)
      comment: "Count of projects with customer approval; measures new product launch readiness rate."
    - name: "lessons_learned_documented_count"
      expr: COUNT(CASE WHEN lessons_learned_documented = TRUE THEN 1 END)
      comment: "Count of projects with documented lessons learned; measures organizational quality learning maturity."
    - name: "distinct_customers_in_apqp"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active APQP projects; measures new product launch breadth across customer base."
    - name: "distinct_skus_in_apqp"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs in APQP pipeline; measures new product introduction portfolio size."
$$;
