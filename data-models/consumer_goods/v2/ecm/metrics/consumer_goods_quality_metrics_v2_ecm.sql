-- Metric views for domain: quality | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) performance metrics tracking closure rates, cost impact, regulatory exposure, and cycle times — core quality system KPIs for executive steering."
  source: "`vibe_consumer_goods_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current lifecycle status of the CAPA (Open, In Progress, Closed, etc.) for pipeline analysis."
    - name: "capa_type"
      expr: capa_type
      comment: "Classification of the CAPA (Corrective, Preventive, Improvement) to segment action types."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the CAPA issue, enabling risk-stratified performance analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA for workload and escalation analysis."
    - name: "process_area"
      expr: process_area
      comment: "Manufacturing or business process area where the CAPA originated, for root-cause hotspot analysis."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for CAPA resolution, enabling departmental performance benchmarking."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the CAPA has regulatory reporting obligations, for compliance risk segmentation."
    - name: "source_type"
      expr: source_type
      comment: "Origin source of the CAPA (audit finding, complaint, deviation, etc.) for trend analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the CAPA was initiated, for trend and aging analysis over time."
    - name: "closure_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month the CAPA was closed, for throughput and backlog trend analysis."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records — baseline volume metric for quality system load assessment."
    - name: "open_capas"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of CAPAs currently open or in progress — key backlog indicator for quality leadership."
    - name: "regulatory_reportable_capas"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with regulatory reporting obligations — critical compliance exposure metric."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial impact of all CAPAs — quantifies the cost of quality failures for executive review."
    - name: "avg_cost_impact_per_capa"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average financial impact per CAPA — benchmarks cost severity and prioritizes high-impact resolution."
    - name: "customer_impacting_capas"
      expr: COUNT(CASE WHEN customer_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with confirmed customer impact — directly tied to customer satisfaction and retention risk."
    - name: "gmp_deviation_capas"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs arising from GMP deviations — regulatory compliance health indicator."
    - name: "capas_with_overdue_target"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of open CAPAs past their target completion date — operational urgency and SLA breach indicator."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance event metrics tracking defect volumes, financial impact, severity distribution, and disposition outcomes — essential for quality cost management and supplier/process performance."
  source: "`vibe_consumer_goods_v1`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance record for pipeline and backlog analysis."
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification of the defect type (Critical, Major, Minor) for risk-stratified quality analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the nonconformance event for prioritization and escalation tracking."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (incoming inspection, production, customer, etc.) for process control analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of nonconformance event for categorical trend analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of the nonconforming material (Accept, Reject, Rework, Scrap) for yield and waste analysis."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the nonconformance, enabling departmental quality benchmarking."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Flags nonconformances with regulatory reporting requirements for compliance risk monitoring."
    - name: "detected_month"
      expr: DATE_TRUNC('month', detected_timestamp)
      comment: "Month the nonconformance was detected, for trend analysis and seasonal quality patterns."
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total nonconformance events — baseline quality defect volume for trend and benchmarking."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by nonconformances — measures production yield loss and waste."
    - name: "avg_affected_quantity"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average quantity affected per nonconformance event — benchmarks typical defect batch size."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial cost of nonconformances — quantifies cost of poor quality for executive decision-making."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance — benchmarks cost severity across defect types."
    - name: "regulatory_reportable_nonconformances"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of nonconformances requiring regulatory reporting — compliance exposure and risk indicator."
    - name: "open_nonconformances"
      expr: COUNT(CASE WHEN nonconformance_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of unresolved nonconformances — operational backlog and quality system health indicator."
    - name: "distinct_skus_affected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with nonconformances — breadth of product quality issues across the portfolio."
    - name: "distinct_suppliers_with_nonconformances"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers generating nonconformances — supplier quality risk breadth indicator."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_product_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer and trade product complaint metrics tracking complaint volumes, severity, regulatory exposure, and investigation cycle times — directly linked to brand reputation, regulatory risk, and customer satisfaction."
  source: "`vibe_consumer_goods_v1`.`quality`.`product_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (Open, Under Investigation, Closed) for pipeline management."
    - name: "complaint_category"
      expr: complaint_category
      comment: "High-level category of the complaint (Safety, Quality, Labeling, etc.) for strategic issue analysis."
    - name: "complaint_subcategory"
      expr: complaint_subcategory
      comment: "Detailed subcategory for granular root-cause and trend analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the complaint for risk-stratified prioritization and escalation."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (consumer, retailer, regulator) for source analysis."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates regulatory reporting obligation — critical for compliance risk monitoring."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the complaint investigation for workload and SLA tracking."
    - name: "sample_returned_flag"
      expr: sample_returned_flag
      comment: "Whether a product sample was returned with the complaint — affects investigation quality and root cause."
    - name: "complaint_received_month"
      expr: DATE_TRUNC('month', complaint_received_timestamp)
      comment: "Month the complaint was received, for trend analysis and seasonal pattern detection."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total product complaints received — primary consumer quality signal for brand and regulatory risk."
    - name: "regulatory_reportable_complaints"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Complaints requiring regulatory reporting — direct compliance obligation and risk exposure metric."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of unresolved complaints — operational backlog and customer experience risk indicator."
    - name: "complaints_with_sample_returned"
      expr: COUNT(CASE WHEN sample_returned_flag = TRUE THEN 1 END)
      comment: "Complaints where a product sample was returned — enables physical investigation and root cause confirmation."
    - name: "distinct_skus_complained"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs receiving complaints — breadth of product quality issues across the portfolio."
    - name: "distinct_suppliers_complained"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers linked to complaints — supplier quality risk breadth."
    - name: "complaints_with_regulatory_case"
      expr: COUNT(CASE WHEN regulatory_case_number IS NOT NULL THEN 1 END)
      comment: "Complaints that have escalated to a formal regulatory case — highest-severity compliance risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics tracking inspection throughput, pass/fail rates, defect volumes, and regulatory holds — core incoming and in-process quality control KPIs."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection lot (In Progress, Completed, Rejected, etc.) for pipeline analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Incoming, In-Process, Final Release) for stage-specific quality analysis."
    - name: "usage_decision"
      expr: usage_decision
      comment: "Final usage decision for the lot (Accept, Reject, Rework) — yield and disposition analysis."
    - name: "disposition_outcome"
      expr: disposition_outcome
      comment: "Outcome of the disposition process for material flow and waste analysis."
    - name: "inspection_priority"
      expr: inspection_priority
      comment: "Priority level of the inspection for workload management and SLA compliance."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Whether the inspection lot is GMP compliant — regulatory quality gate indicator."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether the lot is under regulatory hold — compliance risk and inventory impact indicator."
    - name: "lot_origin_type"
      expr: lot_origin_type
      comment: "Origin type of the lot (manufactured, purchased, returned) for source-specific quality analysis."
    - name: "inspection_start_month"
      expr: DATE_TRUNC('month', inspection_start_date)
      comment: "Month inspection started, for throughput trend analysis."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total inspection lots processed — baseline throughput metric for quality operations capacity planning."
    - name: "lots_under_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently under regulatory hold — compliance risk and supply chain impact indicator."
    - name: "gmp_non_compliant_lots"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Lots failing GMP compliance — regulatory risk and manufacturing quality indicator."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity of product across all inspection lots — volume of product under quality control."
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total sample quantity drawn for inspection — quality control resource consumption metric."
    - name: "avg_lot_quantity"
      expr: AVG(CAST(lot_quantity AS DOUBLE))
      comment: "Average lot size under inspection — benchmarks typical batch size for capacity planning."
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defects identified across all inspection lots — aggregate defect volume for quality trend analysis."
    - name: "distinct_skus_inspected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs passing through inspection — breadth of quality control coverage."
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with lots under inspection — supplier quality monitoring breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release metrics tracking release volumes, quantities, rejection rates, and GMP compliance — critical for supply availability, regulatory compliance, and manufacturing quality performance."
  source: "`vibe_consumer_goods_v1`.`quality`.`batch_release`"
  dimensions:
    - name: "release_decision"
      expr: release_decision
      comment: "Final release decision (Released, Rejected, Conditionally Released) — primary batch disposition outcome."
    - name: "qc_inspection_status"
      expr: qc_inspection_status
      comment: "QC inspection status at time of release decision for quality gate analysis."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Whether the batch met GMP compliance requirements — regulatory quality gate indicator."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether a CAPA was required for this batch — links release quality to corrective action workload."
    - name: "regulatory_hold_status"
      expr: regulatory_hold_status
      comment: "Regulatory hold status of the batch — compliance risk and supply availability indicator."
    - name: "regulatory_market"
      expr: regulatory_market
      comment: "Target regulatory market for the batch — enables market-specific compliance performance analysis."
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month of batch release, for supply throughput and release cycle trend analysis."
    - name: "production_month"
      expr: DATE_TRUNC('month', production_date)
      comment: "Month of production, for manufacturing-to-release cycle time analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total batch release records — baseline production throughput metric."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity of product released to market — primary supply availability metric."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected during batch release — measures yield loss and cost of poor quality."
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size_quantity AS DOUBLE))
      comment: "Average batch size — benchmarks production scale and capacity utilization."
    - name: "total_batch_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Total batch quantity processed through release — aggregate production volume metric."
    - name: "gmp_non_compliant_batches"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Batches failing GMP compliance — regulatory risk and manufacturing quality indicator."
    - name: "batches_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Batches that triggered a CAPA requirement — links production quality to corrective action workload."
    - name: "distinct_skus_released"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs released — breadth of product portfolio passing through quality release."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_gmp_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GMP audit performance metrics tracking audit outcomes, findings severity, CAPA triggers, and regulatory compliance — essential for manufacturing quality governance and regulatory inspection readiness."
  source: "`vibe_consumer_goods_v1`.`quality`.`gmp_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the GMP audit (Planned, In Progress, Completed, Closed) for pipeline management."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of GMP audit (Internal, External, Regulatory) for audit program analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating outcome — primary quality compliance performance indicator."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the audit for backlog and follow-up tracking."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether the audit triggered a CAPA requirement — links audit outcomes to corrective action workload."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit was required — indicates severity of findings and compliance gaps."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting or referenced in the audit — for regulatory body-specific compliance analysis."
    - name: "audit_scheduled_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month the audit was scheduled, for audit program cadence and planning analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total GMP audits conducted — baseline audit program activity metric."
    - name: "audits_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Audits that triggered CAPA requirements — measures audit-driven corrective action workload."
    - name: "audits_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END)
      comment: "Audits requiring follow-up — indicates proportion of audits with unresolved compliance gaps."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings across all audits — highest-severity compliance risk indicator."
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total major findings across all audits — significant compliance gap volume metric."
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total minor findings across all audits — lower-severity compliance observation volume."
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average critical findings per audit — benchmarks audit severity and facility compliance maturity."
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS DOUBLE))
      comment: "Total findings across all audits — aggregate compliance gap volume for quality system health assessment."
    - name: "distinct_facilities_audited"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of distinct manufacturing facilities audited — coverage breadth of the GMP audit program."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_supplier_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality assessment metrics tracking scores, compliance ratings, CAPA requirements, and approval status — essential for supplier qualification, risk management, and procurement decisions."
  source: "`vibe_consumer_goods_v1`.`quality`.`supplier_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the supplier assessment for pipeline and completion tracking."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (Initial Qualification, Periodic Review, For Cause) for program analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Supplier approval status outcome — primary supplier qualification decision metric."
    - name: "asl_status"
      expr: asl_status
      comment: "Approved Supplier List status — regulatory and procurement qualification indicator."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier — drives procurement and quality monitoring intensity."
    - name: "certification_status"
      expr: certification_status
      comment: "Supplier certification status for quality system and regulatory compliance analysis."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether the assessment triggered a CAPA requirement — links supplier performance to corrective actions."
    - name: "improvement_trend"
      expr: improvement_trend
      comment: "Trend direction of supplier quality improvement — strategic supplier development indicator."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment, for supplier quality trend analysis over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total supplier assessments conducted — baseline supplier quality program activity metric."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier quality score — primary supplier performance benchmark for procurement decisions."
    - name: "avg_gmp_compliance_score"
      expr: AVG(CAST(gmp_compliance_score AS DOUBLE))
      comment: "Average GMP compliance score across suppliers — regulatory quality standard adherence benchmark."
    - name: "avg_quality_system_score"
      expr: AVG(CAST(quality_system_score AS DOUBLE))
      comment: "Average quality system score — measures supplier quality management maturity."
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score — supplier regulatory risk benchmark for sourcing decisions."
    - name: "assessments_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Assessments that triggered CAPA requirements — measures supplier-driven corrective action workload."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings across supplier assessments — highest-severity supplier risk indicator."
    - name: "distinct_suppliers_assessed"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers assessed — coverage breadth of the supplier quality program."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics tracking measured values, specification conformance, control chart violations, and defect rates — operational quality control KPIs for process capability and product conformance."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Pass/Fail/Pending status of the inspection result — primary conformance indicator."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the inspection result for quality sign-off tracking."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of any defect identified — risk-stratified quality analysis."
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Whether the result triggered a control chart rule violation — statistical process control indicator."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the result has regulatory reporting implications — compliance risk indicator."
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Whether this result is a retest — measures first-pass yield and rework burden."
    - name: "coa_inclusion_flag"
      expr: coa_inclusion_flag
      comment: "Whether the result is included on the Certificate of Analysis — customer-facing quality documentation."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection, for quality trend analysis over time."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total inspection results recorded — baseline quality testing throughput metric."
    - name: "failing_results"
      expr: COUNT(CASE WHEN result_status = 'Fail' THEN 1 END)
      comment: "Number of failing inspection results — primary product conformance failure volume metric."
    - name: "control_chart_violations"
      expr: COUNT(CASE WHEN control_chart_violation_flag = TRUE THEN 1 END)
      comment: "Number of results triggering control chart violations — statistical process out-of-control indicator."
    - name: "retest_results"
      expr: COUNT(CASE WHEN retest_indicator = TRUE THEN 1 END)
      comment: "Number of retest results — measures first-pass yield failure rate and rework burden."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results — process centering and capability indicator."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty — laboratory and instrument precision quality indicator."
    - name: "regulatory_reportable_results"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Results with regulatory reporting obligations — compliance risk volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability study metrics tracking study status, shelf-life commitments, out-of-specification rates, and regulatory compliance — critical for product registration, shelf-life claims, and regulatory submissions."
  source: "`vibe_consumer_goods_v1`.`quality`.`quality_stability_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the stability study (Active, Completed, Discontinued) for portfolio management."
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study (Real-Time, Accelerated, Stress) for regulatory and scientific analysis."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition under which the study is conducted — key variable for shelf-life determination."
    - name: "ich_climatic_zone"
      expr: ich_climatic_zone
      comment: "ICH climatic zone for the study — regulatory market-specific stability requirement indicator."
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Regulatory region for which the study supports registration — market access planning dimension."
    - name: "out_of_specification_flag"
      expr: out_of_specification_flag
      comment: "Whether the study has out-of-specification results — product quality and shelf-life risk indicator."
    - name: "out_of_trend_flag"
      expr: out_of_trend_flag
      comment: "Whether the study shows out-of-trend results — early warning indicator for shelf-life risk."
    - name: "stability_commitment_flag"
      expr: stability_commitment_flag
      comment: "Whether the study is a regulatory commitment — compliance obligation tracking."
    - name: "study_start_month"
      expr: DATE_TRUNC('month', study_start_date)
      comment: "Month the stability study started, for portfolio aging and commitment timeline analysis."
  measures:
    - name: "total_stability_studies"
      expr: COUNT(1)
      comment: "Total stability studies in the portfolio — baseline regulatory commitment and R&D investment metric."
    - name: "out_of_specification_studies"
      expr: COUNT(CASE WHEN out_of_specification_flag = TRUE THEN 1 END)
      comment: "Studies with OOS results — product quality risk and potential shelf-life reduction indicator."
    - name: "out_of_trend_studies"
      expr: COUNT(CASE WHEN out_of_trend_flag = TRUE THEN 1 END)
      comment: "Studies showing OOT results — early warning metric for emerging shelf-life and quality risks."
    - name: "regulatory_commitment_studies"
      expr: COUNT(CASE WHEN stability_commitment_flag = TRUE THEN 1 END)
      comment: "Studies that are regulatory commitments — compliance obligation volume for regulatory affairs management."
    - name: "distinct_skus_in_study"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs under stability study — breadth of product portfolio with active stability data."
    - name: "avg_storage_temperature"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across studies — validates study condition distribution for regulatory coverage."
    - name: "avg_storage_humidity"
      expr: AVG(CAST(storage_humidity_pct AS DOUBLE))
      comment: "Average storage humidity across studies — validates humidity condition coverage for regulatory submissions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_control_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical process control metrics tracking process capability indices, control limit performance, and chart status — essential for manufacturing quality engineering and continuous improvement decisions."
  source: "`vibe_consumer_goods_v1`.`quality`.`control_chart`"
  dimensions:
    - name: "chart_status"
      expr: chart_status
      comment: "Current status of the control chart (Active, Suspended, Archived) for SPC program management."
    - name: "chart_type"
      expr: chart_type
      comment: "Type of control chart (X-bar R, CUSUM, EWMA, etc.) for statistical method analysis."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Whether the control chart meets GMP documentation requirements — regulatory compliance indicator."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the control chart — enables departmental SPC performance benchmarking."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the control chart became effective, for SPC program evolution analysis."
  measures:
    - name: "total_control_charts"
      expr: COUNT(1)
      comment: "Total active control charts — baseline SPC program coverage metric."
    - name: "avg_cpk"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk process capability index — primary process capability metric; Cpk < 1.33 signals intervention needed."
    - name: "avg_cp"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp process potential index — measures inherent process spread relative to specification width."
    - name: "avg_ppk"
      expr: AVG(CAST(ppk_value AS DOUBLE))
      comment: "Average Ppk process performance index — long-term process performance including all variation sources."
    - name: "charts_below_cpk_threshold"
      expr: COUNT(CASE WHEN cpk_value < 1.33 THEN 1 END)
      comment: "Control charts with Cpk below 1.33 — identifies processes requiring immediate capability improvement."
    - name: "gmp_non_compliant_charts"
      expr: COUNT(CASE WHEN gmp_compliant_flag = FALSE THEN 1 END)
      comment: "Control charts not meeting GMP documentation requirements — regulatory compliance gap indicator."
    - name: "avg_center_line"
      expr: AVG(CAST(center_line AS DOUBLE))
      comment: "Average process center line value — process centering benchmark across monitored characteristics."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_regulatory_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory hold metrics tracking hold volumes, financial impact, duration, and release rates — critical for supply chain risk management, compliance exposure, and inventory availability decisions."
  source: "`vibe_consumer_goods_v1`.`quality`.`regulatory_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the regulatory hold (Active, Released, Escalated) for supply chain impact assessment."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of regulatory hold (Quality, Regulatory, Safety) for risk categorization."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Coded reason for the hold — enables root cause pattern analysis across hold events."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the hold — drives prioritization and escalation decisions."
    - name: "release_decision"
      expr: release_decision
      comment: "Final release decision for the held material — disposition outcome analysis."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required — compliance obligation and reporting burden indicator."
    - name: "hold_start_month"
      expr: DATE_TRUNC('month', hold_start_date)
      comment: "Month the hold was initiated, for trend analysis and seasonal compliance pattern detection."
  measures:
    - name: "total_regulatory_holds"
      expr: COUNT(1)
      comment: "Total regulatory holds — baseline compliance event volume for risk management."
    - name: "active_regulatory_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Currently active regulatory holds — real-time supply chain risk and inventory availability indicator."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product under regulatory hold — supply chain impact and inventory risk metric."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of regulatory holds — quantifies compliance cost for executive decision-making."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per regulatory hold — benchmarks cost severity of compliance events."
    - name: "holds_requiring_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Holds requiring regulatory notification — compliance obligation volume for regulatory affairs."
    - name: "distinct_skus_on_hold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs under regulatory hold — breadth of product portfolio compliance risk."
    - name: "distinct_suppliers_on_hold"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with materials under regulatory hold — supplier compliance risk breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit finding KPIs for executive oversight of audit effectiveness and timeliness"
  source: "`vibe_consumer_goods_v1`.`quality`.`audit_finding`"
  dimensions:
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the finding"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., Open, Closed)"
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the finding (e.g., Critical, Major, Minor)"
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded"
    - name: "closed_audit_findings"
      expr: SUM(CASE WHEN finding_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of audit findings that have been closed"
    - name: "average_closure_days"
      expr: AVG(DATEDIFF(closure_date, finding_date))
      comment: "Average number of days between finding date and closure date for closed findings"
$$;