-- Metric views for domain: quality | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance and compliance metrics for management system effectiveness"
  source: "`vibe_semiconductors_v1`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, supplier, customer, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Status of audit (planned, in progress, completed, closed)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of audit (pass, fail, conditional)"
    - name: "applicable_standard"
      expr: applicable_standard
      comment: "Standard audited against (ISO 9001, IATF 16949, etc.)"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month when audit was conducted"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month when audit was scheduled"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "unique_suppliers_audited"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers audited"
    - name: "unique_facilities_audited"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of unique facilities audited"
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all audits"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_audit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit execution and timeliness metrics for executive quality oversight"
  source: "`vibe_semiconductors_v1`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Internal, External)"
    - name: "audit_month"
      expr: DATE_TRUNC('month', record_audit_created)
      comment: "Month of audit record creation"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits recorded"
    - name: "completed_audit_count"
      expr: SUM(CASE WHEN audit_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of audits that reached Completed status"
    - name: "average_audit_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average duration of audits in days"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA creation and closure efficiency metrics for quality improvement"
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of corrective action (e.g., Process, Design)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the CAPA"
    - name: "priority"
      expr: priority
      comment: "Priority of the CAPA"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the CAPA record was created"
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of CAPA records created"
    - name: "closed_capa_records"
      expr: SUM(CASE WHEN capa_record_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of CAPA records that have been closed"
    - name: "average_time_to_close_days"
      expr: AVG(DATEDIFF(closure_date, created_timestamp))
      comment: "Average number of days from CAPA creation to closure"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and preventive action effectiveness metrics for quality improvement"
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, or both)"
    - name: "capa_status"
      expr: capa_status
      comment: "Status of CAPA record (open, closed, in progress)"
    - name: "priority"
      expr: priority
      comment: "Priority level of CAPA"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with issue"
    - name: "severity"
      expr: severity
      comment: "Severity of issue requiring CAPA"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where issue was detected"
    - name: "detection_source"
      expr: detection_source
      comment: "Source of issue detection (audit, inspection, customer, etc.)"
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Method used for root cause analysis (5-why, fishbone, etc.)"
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status for CAPA closure"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of effectiveness verification"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month when issue was detected"
    - name: "closure_month"
      expr: DATE_TRUNC('MONTH', closure_date)
      comment: "Month when CAPA was closed"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "unique_products_with_capa"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products with CAPA records"
    - name: "unique_lots_with_capa"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of unique lots with CAPA records"
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA implementation"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of CAPA implementation"
    - name: "avg_actual_cost"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per CAPA"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control plan coverage, DPPM performance, and specification compliance metrics. Drives process control system effectiveness and quality gate management."
  source: "`vibe_semiconductors_v1`.`quality`.`control_plan`"
  dimensions:
    - name: "control_plan_type"
      expr: control_plan_type
      comment: "Type of control plan (e.g., pre-launch, production, prototype) for NPI and production quality management."
    - name: "control_plan_status"
      expr: control_plan_status
      comment: "Current status of the control plan for active coverage management."
    - name: "plan_status"
      expr: plan_status
      comment: "Workflow status of the control plan record."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the control plan for governance compliance."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the control plan for prioritized review and update management."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the control plan covers a critical process step — drives mandatory review frequency."
    - name: "control_method"
      expr: control_method
      comment: "Control method used (e.g., SPC, inspection, poka-yoke) for control strategy analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month control plan became effective for coverage timeline management."
  measures:
    - name: "total_control_plans"
      expr: COUNT(1)
      comment: "Total control plans — measures process quality control coverage breadth."
    - name: "avg_dppm_actual"
      expr: AVG(CAST(dppm_actual AS DOUBLE))
      comment: "Average actual DPPM across control plans — measures process quality performance against control plan targets."
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average DPPM target across control plans for quality commitment benchmarking."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target parameter value across control plans for process centering analysis."
    - name: "avg_tolerance_lower"
      expr: AVG(CAST(tolerance_lower AS DOUBLE))
      comment: "Average lower tolerance limit across control plans for process window analysis."
    - name: "avg_tolerance_upper"
      expr: AVG(CAST(tolerance_upper AS DOUBLE))
      comment: "Average upper tolerance limit across control plans for process window analysis."
    - name: "critical_control_plan_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical control plans — measures coverage of high-risk process steps requiring mandatory quality controls."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint tracking and resolution metrics for customer satisfaction management"
  source: "`vibe_semiconductors_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (quality, delivery, documentation, etc.)"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of complaint for trend analysis"
    - name: "complaint_status"
      expr: complaint_status
      comment: "Status of complaint (open, closed, pending investigation)"
    - name: "severity"
      expr: severity
      comment: "Severity level of complaint (critical, high, medium, low)"
    - name: "priority"
      expr: priority
      comment: "Priority level for complaint resolution"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of complaint resolution"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of complaint"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which complaint was received"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Flag indicating if complaint includes warranty claim"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when complaint was received"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when complaint was resolved"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints"
    - name: "unique_customers_with_complaints"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with complaints"
    - name: "unique_products_with_complaints"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with complaints"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost impact of customer complaints"
    - name: "avg_cost_per_complaint"
      expr: AVG(CAST(cost_net AS DOUBLE))
      comment: "Average net cost per customer complaint"
    - name: "avg_dppm_impact"
      expr: AVG(CAST(dppm_impact AS DOUBLE))
      comment: "Average DPPM impact of complaints"
    - name: "complaints_with_escalation"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints that were escalated"
    - name: "complaints_with_regulatory_report"
      expr: SUM(CASE WHEN regulatory_report_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints requiring regulatory reporting"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect cluster spatial analysis metrics for equipment fingerprinting, process excursion detection, and yield loss attribution to specific tools or process steps."
  source: "`vibe_semiconductors_v1`.`quality`.`defect_cluster`"
  dimensions:
    - name: "cluster_type"
      expr: cluster_type
      comment: "Type of defect cluster (e.g., random, systematic, edge) for yield loss mechanism classification."
    - name: "cluster_pattern_type"
      expr: cluster_pattern_type
      comment: "Pattern type of the cluster for equipment fingerprinting and root cause identification."
    - name: "cluster_classification"
      expr: cluster_classification
      comment: "Classification of the cluster for risk tiering and corrective action prioritization."
    - name: "defect_cluster_status"
      expr: defect_cluster_status
      comment: "Current status of the defect cluster record for investigation management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the cluster for systemic process improvement tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the defect cluster for risk-tiered escalation."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the cluster is classified as critical for yield — drives immediate process intervention."
    - name: "is_customer_reported"
      expr: is_customer_reported
      comment: "Whether the cluster was reported by a customer — signals field quality escape requiring urgent action."
    - name: "cluster_creation_date_month"
      expr: DATE_TRUNC('month', cluster_creation_date)
      comment: "Month of cluster creation for excursion trend analysis."
  measures:
    - name: "total_defect_clusters"
      expr: COUNT(1)
      comment: "Total defect clusters identified — measures systematic defect occurrence frequency for process health monitoring."
    - name: "avg_cluster_area_mm2"
      expr: AVG(CAST(cluster_area_mm2 AS DOUBLE))
      comment: "Average defect cluster area in mm² — quantifies spatial extent of systematic defects for yield impact estimation."
    - name: "avg_density"
      expr: AVG(CAST(density AS DOUBLE))
      comment: "Average defect density within clusters — measures defect concentration severity for process control."
    - name: "avg_impact_yield_percent"
      expr: AVG(CAST(impact_yield_percent AS DOUBLE))
      comment: "Average yield impact percentage per cluster — directly quantifies yield loss attributable to systematic defects."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM associated with defect clusters — links spatial defect patterns to customer-facing quality metrics."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value associated with clusters for process parameter correlation analysis."
    - name: "critical_cluster_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical defect clusters — drives immediate process intervention and equipment qualification actions."
    - name: "customer_reported_cluster_count"
      expr: COUNT(CASE WHEN is_customer_reported = TRUE THEN 1 END)
      comment: "Customer-reported defect clusters — measures field quality escape rate from systematic defects."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect tracking and yield impact metrics for wafer and die-level quality analysis"
  source: "`vibe_semiconductors_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_type"
      expr: defect_type
      comment: "Classification of defect (particle, scratch, void, etc.)"
    - name: "defect_category"
      expr: defect_category
      comment: "High-level defect category for trend analysis"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of defect (critical, major, minor)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect (optical, e-beam, etc.)"
    - name: "defect_layer"
      expr: defect_layer
      comment: "Process layer where defect was detected"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for defective material"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of defect"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when defect was detected"
    - name: "detection_week"
      expr: DATE_TRUNC('WEEK', detection_timestamp)
      comment: "Week when defect was detected"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "unique_wafers_with_defects"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with detected defects"
    - name: "unique_lots_with_defects"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of unique lots with detected defects"
    - name: "avg_defect_size_um"
      expr: AVG(CAST(defect_size_um AS DOUBLE))
      comment: "Average defect size in micrometers"
    - name: "avg_defect_density_per_zone"
      expr: AVG(CAST(defect_density_per_zone AS DOUBLE))
      comment: "Average defect density per wafer zone"
    - name: "total_defect_area_um2"
      expr: SUM(CAST(defect_area_um2 AS DOUBLE))
      comment: "Total defect area across all records in square micrometers"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_dppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defective parts per million tracking for customer quality and compliance"
  source: "`vibe_semiconductors_v1`.`quality`.`dppm_record`"
  dimensions:
    - name: "measurement_period"
      expr: measurement_period
      comment: "Time period for DPPM measurement (monthly, quarterly, etc.)"
    - name: "dppm_record_status"
      expr: dppm_record_status
      comment: "Status of DPPM record (open, closed, under review)"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance status for this DPPM record"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of DPPM issue"
    - name: "notification_type"
      expr: notification_type
      comment: "Type of quality notification associated with DPPM"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month when measurement period started"
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', period_end_date)
      comment: "Month when measurement period ended"
  measures:
    - name: "total_dppm_records"
      expr: COUNT(1)
      comment: "Total number of DPPM records"
    - name: "unique_customers_with_dppm"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with DPPM issues"
    - name: "unique_products_with_dppm"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with DPPM issues"
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defective parts per million across all records"
    - name: "total_defective_units"
      expr: SUM(CAST(defective_units AS BIGINT))
      comment: "Total count of defective units reported"
    - name: "total_units_shipped"
      expr: SUM(CAST(total_units_shipped AS BIGINT))
      comment: "Total count of units shipped in measurement period"
    - name: "avg_target_dppm"
      expr: AVG(CAST(target_dppm AS DOUBLE))
      comment: "Average target DPPM threshold"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_failure_analysis_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure analysis report cycle time, failure mechanism distribution, and closure metrics. Drives root cause resolution speed and product reliability improvement."
  source: "`vibe_semiconductors_v1`.`quality`.`failure_analysis_report`"
  dimensions:
    - name: "failure_analysis_report_status"
      expr: failure_analysis_report_status
      comment: "Current status of the failure analysis report for cycle time and backlog management."
    - name: "report_type"
      expr: report_type
      comment: "Type of failure analysis report (e.g., field return, reliability, process) for program segmentation."
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism identified (e.g., electromigration, oxide breakdown) for reliability physics analysis."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode classification for FMEA correlation and design improvement prioritization."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity of the failure for risk-tiered investigation resource allocation."
    - name: "analysis_technique"
      expr: analysis_technique
      comment: "Analytical technique used (e.g., SEM, TEM, FIB) for capability and resource planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the report for release and customer communication management."
    - name: "report_status"
      expr: report_status
      comment: "Publication status of the failure analysis report."
    - name: "analysis_date_month"
      expr: DATE_TRUNC('month', analysis_date)
      comment: "Month of failure analysis for trend and backlog analysis."
  measures:
    - name: "total_failure_analysis_reports"
      expr: COUNT(1)
      comment: "Total failure analysis reports — measures FA throughput and quality issue investigation capacity."
    - name: "open_fa_report_count"
      expr: COUNT(CASE WHEN failure_analysis_report_status NOT IN ('Closed', 'Approved', 'Cancelled') THEN 1 END)
      comment: "Open failure analysis reports — measures FA backlog and unresolved quality risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_fmea_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis (FMEA) risk metrics for proactive quality risk management, design and process robustness assessment, and qualification readiness."
  source: "`vibe_semiconductors_v1`.`quality`.`fmea_record`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (e.g., DFMEA, PFMEA) for design vs. process risk segmentation."
    - name: "fmea_record_status"
      expr: fmea_record_status
      comment: "Current status of the FMEA record for program completeness tracking."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the failure mode for risk portfolio management."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the failure effect for risk prioritization."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Identified failure mode for cross-product failure pattern analysis."
    - name: "failure_effect"
      expr: failure_effect
      comment: "Effect of the failure mode on the product or customer for impact assessment."
    - name: "detection_method"
      expr: detection_method
      comment: "Detection method for the failure mode, informing test and inspection strategy."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the failure mode is classified as critical — drives mandatory corrective action and design review."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month FMEA became effective for program timeline tracking."
  measures:
    - name: "total_fmea_records"
      expr: COUNT(1)
      comment: "Total FMEA records — measures risk analysis coverage across products and processes."
    - name: "critical_failure_mode_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical failure modes identified — directly drives design and process improvement investment priorities."
    - name: "open_fmea_count"
      expr: COUNT(CASE WHEN fmea_record_status NOT IN ('Closed', 'Approved', 'Cancelled') THEN 1 END)
      comment: "Open FMEA records requiring action — measures risk management backlog and qualification readiness gaps."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics for incoming and in-process quality control"
  source: "`vibe_semiconductors_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final, etc.)"
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection in manufacturing flow"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of inspection (pass, fail, conditional)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for inspected lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot inspected"
    - name: "material_type"
      expr: material_type
      comment: "Type of material inspected"
    - name: "kgd_certified"
      expr: kgd_certified
      comment: "Known Good Die certification flag"
    - name: "iso_9001_compliant"
      expr: iso_9001_compliant
      comment: "ISO 9001 compliance flag"
    - name: "iatf_16949_compliant"
      expr: iatf_16949_compliant
      comment: "IATF 16949 compliance flag"
    - name: "jedec_reliability_compliant"
      expr: jedec_reliability_compliant
      comment: "JEDEC reliability compliance flag"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when inspection was performed"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "unique_products_inspected"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products inspected"
    - name: "unique_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with inspected material"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS BIGINT))
      comment: "Average lot size inspected"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inspection lots"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across inspection lots"
    - name: "avg_wafer_size_mm"
      expr: AVG(CAST(wafer_size_mm AS DOUBLE))
      comment: "Average wafer size in millimeters"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_mrb_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Review Board (MRB) meeting volume, disposition decision, and throughput metrics. Drives nonconforming material disposition cycle time and quality governance effectiveness."
  source: "`vibe_semiconductors_v1`.`quality`.`mrb_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of MRB meeting (e.g., regular, emergency, virtual) for meeting cadence analysis."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Current status of the MRB meeting for governance tracking."
    - name: "mrb_meeting_status"
      expr: mrb_meeting_status
      comment: "Workflow status of the MRB meeting record."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision made (e.g., scrap, rework, use-as-is) for material cost impact analysis."
    - name: "meeting_date_month"
      expr: DATE_TRUNC('month', meeting_date)
      comment: "Month of MRB meeting for governance cadence and throughput trend analysis."
  measures:
    - name: "total_mrb_meetings"
      expr: COUNT(1)
      comment: "Total MRB meetings held — measures quality governance activity and nonconforming material disposition throughput."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance tracking and corrective action metrics for quality management"
  source: "`vibe_semiconductors_v1`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "nonconformance_type"
      expr: nonconformance_type
      comment: "Type of nonconformance (material, process, documentation, etc.)"
    - name: "ncr_status"
      expr: ncr_status
      comment: "Status of nonconformance report (open, closed, pending)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of nonconformance (critical, major, minor)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for nonconforming material (scrap, rework, use-as-is, etc.)"
    - name: "detection_point"
      expr: detection_point
      comment: "Point in process where nonconformance was detected"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "mrb_decision"
      expr: mrb_decision
      comment: "Material Review Board decision"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Flag indicating if customer notification is required"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month when nonconformance was detected"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month when NCR was reported"
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports"
    - name: "unique_lots_with_ncr"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of unique lots with nonconformances"
    - name: "unique_products_with_ncr"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with nonconformances"
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances"
    - name: "avg_impact_amount"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance"
    - name: "ncrs_with_customer_impact"
      expr: SUM(CASE WHEN is_customer_impact = TRUE THEN 1 ELSE 0 END)
      comment: "Count of NCRs with customer impact"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_qualification_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product qualification report outcomes, yield, and DPPM metrics. Drives new product introduction (NPI) gate decisions and customer qualification approval management."
  source: "`vibe_semiconductors_v1`.`quality`.`qualification_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of qualification report (e.g., initial qualification, re-qualification, customer-specific) for program segmentation."
    - name: "qualification_report_status"
      expr: qualification_report_status
      comment: "Current status of the qualification report for NPI gate management."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall qualification result (pass/fail/conditional) for go/no-go decision support."
    - name: "qualification_result"
      expr: qualification_result
      comment: "Detailed qualification result for compliance documentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the qualification report for release management."
    - name: "report_date_month"
      expr: DATE_TRUNC('month', report_date)
      comment: "Month of qualification report for NPI pipeline timeline tracking."
    - name: "report_status"
      expr: report_status
      comment: "Publication status of the report for document management."
  measures:
    - name: "total_qualification_reports"
      expr: COUNT(1)
      comment: "Total qualification reports issued — measures NPI qualification throughput and program velocity."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage in qualification reports — primary NPI quality gate metric for product release decisions."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM in qualification reports — customer-facing quality commitment metric for product release approval."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit finding severity, recurrence, and closure metrics. Drives quality system improvement prioritization and regulatory compliance risk management."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g., major nonconformance, minor nonconformance, observation) for risk tiering."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding for systemic quality issue pattern analysis."
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the finding for compliance reporting."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding for closure rate management."
    - name: "quality_audit_finding_status"
      expr: quality_audit_finding_status
      comment: "Workflow status of the audit finding record."
    - name: "severity"
      expr: severity
      comment: "Severity of the finding for risk-tiered corrective action prioritization."
    - name: "severity_level"
      expr: severity_level
      comment: "Detailed severity level for granular risk analysis."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that generated the finding for audit program effectiveness analysis."
    - name: "is_repeat_issue"
      expr: is_repeat_issue
      comment: "Whether the finding is a repeat issue — repeat findings signal systemic quality system failures."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the finding for corrective action completion tracking."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit finding for trend and recurrence analysis."
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total audit findings — primary quality system gap metric for compliance program management."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score associated with findings — measures quality system performance level."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_issue = TRUE THEN 1 END)
      comment: "Number of repeat audit findings — high repeat rate signals ineffective corrective actions and systemic quality system weakness."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN finding_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Open audit findings requiring corrective action — measures compliance risk backlog."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Findings requiring corrective action — drives CAPA workload planning and quality system improvement investment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold volume, duration, and affected quantity metrics. Drives material flow risk management, hold resolution cycle time, and compliance with quality gate requirements."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (e.g., process, material, customer) for hold category analysis."
    - name: "hold_category"
      expr: hold_category
      comment: "Category of the hold for Pareto-driven hold reduction programs."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold for active hold management."
    - name: "quality_hold_status"
      expr: quality_hold_status
      comment: "Workflow status of the quality hold record."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized reason code for the hold, enabling systemic hold cause analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the hold for resolution urgency management."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the hold for closure rate tracking."
    - name: "hold_placed_timestamp_month"
      expr: DATE_TRUNC('month', hold_placed_timestamp)
      comment: "Month hold was placed for hold volume trend analysis."
    - name: "affected_entity_type"
      expr: affected_entity_type
      comment: "Type of entity affected by the hold (e.g., wafer lot, finished good) for impact scoping."
  measures:
    - name: "total_quality_holds"
      expr: COUNT(1)
      comment: "Total quality holds placed — primary material flow risk KPI. High hold volume signals systemic quality issues."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total units/lots affected by quality holds — quantifies material at risk and potential revenue impact."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN hold_status NOT IN ('Released', 'Cancelled') THEN 1 END)
      comment: "Number of active quality holds — measures current material flow obstruction and quality risk exposure."
    - name: "kgd_certified_hold_count"
      expr: COUNT(CASE WHEN is_kgd_certified = TRUE THEN 1 END)
      comment: "Quality holds on KGD-certified material — critical for die bank availability and customer shipment risk management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_kgd_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Known Good Die (KGD) certification metrics for die-level quality assurance, customer qualification compliance, and die bank inventory quality management."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_kgd_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current KGD certification status (e.g., certified, expired, pending) for die bank eligibility management."
    - name: "quality_kgd_certification_status"
      expr: quality_kgd_certification_status
      comment: "Workflow status of the KGD certification record."
    - name: "kgd_grade"
      expr: kgd_grade
      comment: "KGD quality grade for die tiering and customer allocation decisions."
    - name: "kgd_level"
      expr: kgd_level
      comment: "KGD certification level for compliance tier management."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Applicable certification standard (e.g., JEDEC, customer-specific) for compliance reporting."
    - name: "test_type"
      expr: test_type
      comment: "Type of test used for KGD certification (e.g., burn-in, parametric screen) for methodology analysis."
    - name: "burn_in_status"
      expr: burn_in_status
      comment: "Burn-in test status for infant mortality screening effectiveness tracking."
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade of the certified die for customer-facing quality communication."
    - name: "certification_date_month"
      expr: DATE_TRUNC('month', certification_date)
      comment: "Month of KGD certification for certification volume trend analysis."
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "Whether the certification meets JEDEC standards — critical for industry-standard compliance reporting."
  measures:
    - name: "total_kgd_certifications"
      expr: COUNT(1)
      comment: "Total KGD certifications issued — measures die bank quality certification throughput."
    - name: "avg_kgd_yield_percent"
      expr: AVG(CAST(kgd_yield_percent AS DOUBLE))
      comment: "Average KGD yield percentage — primary die-level quality KPI for die bank value and customer supply planning."
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average DPPM value for KGD-certified die — customer-facing quality metric for die supply agreements."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage — measures thoroughness of KGD screening for quality assurance."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average KGD test duration in hours for certification cycle time and capacity planning."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature for KGD certification, used to validate stress condition compliance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality metrology measurement accuracy, specification compliance, and process centering metrics. Drives process control effectiveness and measurement system analysis."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (e.g., CD, overlay, film thickness) for parameter-level quality analysis."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the measured parameter for process control coverage analysis."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for dimensional analysis and cross-tool comparison."
    - name: "quality_metrology_measurement_status"
      expr: quality_metrology_measurement_status
      comment: "Status of the measurement record for data quality management."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail status of the measurement against specification limits."
    - name: "in_spec_flag"
      expr: in_spec_flag
      comment: "Whether the measurement is within specification — primary quality gate flag."
    - name: "within_spec_flag"
      expr: within_spec_flag
      comment: "Secondary in-specification flag for cross-validation of measurement compliance."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Measurement mode (e.g., inline, offline) for measurement strategy analysis."
    - name: "site_map_type"
      expr: site_map_type
      comment: "Type of site map used for measurement, enabling spatial measurement coverage analysis."
    - name: "measurement_timestamp_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement for process centering trend analysis."
  measures:
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value — primary process centering metric for SPC and process control."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value for cross-validation and process window analysis."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for measurements, used to assess process centering against design intent."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across measurements for process window analysis."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit for process window and capability analysis."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty — critical for gauge R&R and measurement system analysis (MSA)."
    - name: "out_of_spec_measurement_count"
      expr: COUNT(CASE WHEN in_spec_flag = FALSE THEN 1 END)
      comment: "Number of out-of-specification measurements — primary quality gate failure metric driving process intervention."
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total metrology measurements taken — measures inspection coverage and data density for process control."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality notification volume, escalation, and resolution metrics for quality event management and customer impact tracking."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_notification`"
  dimensions:
    - name: "notification_type"
      expr: notification_type
      comment: "Type of quality notification (e.g., process excursion, customer complaint, supplier issue) for event categorization."
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the notification for pipeline management."
    - name: "quality_notification_status"
      expr: quality_notification_status
      comment: "Workflow status of the quality notification record."
    - name: "severity"
      expr: severity
      comment: "Severity of the quality event for risk-tiered escalation management."
    - name: "priority"
      expr: priority
      comment: "Priority of the notification for resolution urgency management."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the notification for executive visibility management."
    - name: "is_customer_impact"
      expr: is_customer_impact
      comment: "Whether the notification has customer impact — drives customer communication and satisfaction risk management."
    - name: "is_repeat_issue"
      expr: is_repeat_issue
      comment: "Whether this is a repeat quality issue — signals systemic quality system failures."
    - name: "notification_date_month"
      expr: DATE_TRUNC('month', notification_date)
      comment: "Month of notification for quality event trend analysis."
  measures:
    - name: "total_quality_notifications"
      expr: COUNT(1)
      comment: "Total quality notifications — primary quality event volume KPI for quality system activity monitoring."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in PPM from quality notifications — links event management to quantitative quality performance."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value from quality notifications for process parameter excursion analysis."
    - name: "customer_impact_notification_count"
      expr: COUNT(CASE WHEN is_customer_impact = TRUE THEN 1 END)
      comment: "Notifications with customer impact — drives customer communication prioritization and satisfaction risk management."
    - name: "repeat_issue_notification_count"
      expr: COUNT(CASE WHEN is_repeat_issue = TRUE THEN 1 END)
      comment: "Repeat issue notifications — measures systemic quality problem recurrence rate for corrective action effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_qualification_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality qualification program status, yield performance, DPPM targets, and budget metrics. Drives NPI investment decisions and qualification program portfolio management."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_qualification_program`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification program (e.g., JEDEC, AEC-Q100, customer-specific) for compliance portfolio management."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the qualification program for NPI pipeline management."
    - name: "quality_qualification_program_status"
      expr: quality_qualification_program_status
      comment: "Workflow status of the qualification program record."
    - name: "program_category"
      expr: program_category
      comment: "Category of the qualification program for portfolio segmentation."
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Applicable qualification standard for compliance coverage analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the qualification program for resource prioritization."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the program for portfolio health management."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned program start for NPI timeline planning."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall program health status for executive dashboard reporting."
  measures:
    - name: "total_qualification_programs"
      expr: COUNT(1)
      comment: "Total qualification programs — measures NPI qualification pipeline breadth and program portfolio size."
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across qualification programs — primary NPI quality performance KPI."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage for qualification programs, used to assess performance against plan."
    - name: "avg_dppm_actual"
      expr: AVG(CAST(dppm_actual AS DOUBLE))
      comment: "Average actual DPPM across qualification programs — customer-facing quality metric for product release decisions."
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average DPPM target for qualification programs, used to assess quality commitment achievement."
    - name: "total_program_budget_usd"
      expr: SUM(CAST(program_budget_usd AS DOUBLE))
      comment: "Total qualification program budget in USD — drives R&D and NPI investment planning decisions."
    - name: "avg_program_budget_usd"
      expr: AVG(CAST(program_budget_usd AS DOUBLE))
      comment: "Average qualification program budget for cost benchmarking and resource allocation."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status NOT IN ('Completed', 'Cancelled', 'On Hold') THEN 1 END)
      comment: "Number of active qualification programs — measures NPI pipeline activity and qualification capacity demand."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality specification coverage, tolerance window, and compliance metrics. Drives specification management effectiveness and process capability assessment."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_spec`"
  dimensions:
    - name: "spec_type"
      expr: spec_type
      comment: "Type of quality specification (e.g., electrical, mechanical, visual) for specification portfolio management."
    - name: "quality_spec_status"
      expr: quality_spec_status
      comment: "Current status of the quality specification for active coverage management."
    - name: "spec_status"
      expr: spec_status
      comment: "Publication status of the specification for document management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the specification for governance compliance."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the quality parameter specified for parameter-level coverage analysis."
    - name: "process_node"
      expr: process_node
      comment: "Technology node the specification applies to for node-level quality requirement management."
    - name: "product_family"
      expr: product_family
      comment: "Product family the specification covers for product-level quality management."
    - name: "test_type"
      expr: test_type
      comment: "Test type associated with the specification for test coverage analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month specification became effective for specification lifecycle management."
  measures:
    - name: "total_quality_specs"
      expr: COUNT(1)
      comment: "Total quality specifications — measures specification coverage breadth across products and processes."
    - name: "avg_nominal_value"
      expr: AVG(CAST(nominal_value AS DOUBLE))
      comment: "Average nominal specification value for process centering benchmarking."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit for process window analysis."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit for process window analysis."
    - name: "avg_lower_limit"
      expr: AVG(CAST(lower_limit AS DOUBLE))
      comment: "Average lower limit across specifications for tolerance window analysis."
    - name: "avg_upper_limit"
      expr: AVG(CAST(upper_limit AS DOUBLE))
      comment: "Average upper limit across specifications for tolerance window analysis."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across specifications for process centering goal management."
    - name: "avg_measurement_accuracy_percent"
      expr: AVG(CAST(measurement_accuracy_percent AS DOUBLE))
      comment: "Average measurement accuracy percentage — measures metrology system capability relative to specification requirements."
    - name: "avg_measurement_variance_percent"
      expr: AVG(CAST(measurement_variance_percent AS DOUBLE))
      comment: "Average measurement variance percentage for gauge R&R and measurement system analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_reliability_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test performance and failure analysis metrics for product qualification"
  source: "`vibe_semiconductors_v1`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, HAST, TC, etc.)"
    - name: "test_status"
      expr: test_status
      comment: "Status of reliability test (in progress, completed, failed)"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, process change, etc.)"
    - name: "test_standard"
      expr: test_standard
      comment: "Standard used for reliability testing (JEDEC, AEC, etc.)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure observed in test"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Mechanism of failure"
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade assigned based on test results"
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "JEDEC compliance flag"
    - name: "compliance_iso_9001"
      expr: compliance_iso_9001
      comment: "ISO 9001 compliance flag"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_execution_timestamp)
      comment: "Month when test was executed"
  measures:
    - name: "total_reliability_tests"
      expr: COUNT(1)
      comment: "Total number of reliability tests"
    - name: "unique_products_tested"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with reliability tests"
    - name: "unique_lots_tested"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of unique lots with reliability tests"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "avg_test_humidity_percent"
      expr: AVG(CAST(test_humidity_percent AS DOUBLE))
      comment: "Average test humidity percentage"
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average failures in time rate"
    - name: "avg_weibull_shape"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter for failure distribution"
    - name: "avg_weibull_scale"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter for failure distribution"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_spc_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) chart metrics for process stability monitoring, Cpk trending, and out-of-control event management. Core process quality steering KPI."
  source: "`vibe_semiconductors_v1`.`quality`.`spc_chart`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "SPC chart type (e.g., X-bar R, CUSUM, EWMA) for control methodology analysis."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter being monitored (e.g., CD, thickness, resistivity) for parameter-level SPC coverage."
    - name: "spc_chart_status"
      expr: spc_chart_status
      comment: "Current status of the SPC chart for active monitoring coverage management."
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Whether the chart has an active out-of-control signal — primary SPC alert dimension."
    - name: "assignable_cause_code"
      expr: assignable_cause_code
      comment: "Assignable cause code for out-of-control events, enabling root cause pattern analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Measurement method used for SPC data collection."
    - name: "shift"
      expr: shift
      comment: "Production shift for shift-level process stability comparison."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the SPC chart became effective for control plan coverage trending."
    - name: "is_baseline"
      expr: is_baseline
      comment: "Whether this chart represents the baseline control limits for process capability benchmarking."
  measures:
    - name: "avg_cpk"
      expr: AVG(CAST(cpk AS DOUBLE))
      comment: "Average process capability index (Cpk) — primary process quality KPI. Cpk < 1.33 triggers process improvement investment."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value from the cpk_value column for cross-validation of process capability."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value for process centering analysis."
    - name: "avg_center_line"
      expr: AVG(CAST(center_line AS DOUBLE))
      comment: "Average SPC center line value, used to assess process mean stability over time."
    - name: "avg_upper_control_limit"
      expr: AVG(CAST(upper_control_limit AS DOUBLE))
      comment: "Average upper control limit across charts, used for control limit consistency auditing."
    - name: "avg_lower_control_limit"
      expr: AVG(CAST(lower_control_limit AS DOUBLE))
      comment: "Average lower control limit across charts for process window analysis."
    - name: "out_of_control_event_count"
      expr: COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END)
      comment: "Number of out-of-control SPC events — primary process excursion KPI driving immediate corrective action."
    - name: "total_spc_charts"
      expr: COUNT(1)
      comment: "Total SPC charts in the system — measures SPC coverage breadth across the process flow."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_supplier_quality_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality performance metrics for vendor management and development"
  source: "`vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of supplier scorecard (active, archived, under review)"
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Period covered by scorecard (monthly, quarterly, annual)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall supplier rating (excellent, good, acceptable, poor)"
    - name: "rating_grade"
      expr: rating_grade
      comment: "Letter grade assigned to supplier"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Supplier tier classification (tier 1, tier 2, etc.)"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (material, equipment, service, etc.)"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend direction of supplier performance (improving, stable, declining)"
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start)
      comment: "Month when evaluation period started"
    - name: "evaluation_period_end_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_end)
      comment: "Month when evaluation period ended"
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Total number of supplier scorecards"
    - name: "unique_suppliers_scored"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with scorecards"
    - name: "avg_overall_quality_score"
      expr: AVG(CAST(overall_quality_score AS DOUBLE))
      comment: "Average overall quality score across suppliers"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality component score"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery component score"
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defective parts per million from suppliers"
    - name: "avg_on_time_delivery_percent"
      expr: AVG(CAST(on_time_delivery_percent AS DOUBLE))
      comment: "Average on-time delivery percentage"
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts per million defect rate"
    - name: "total_cost_of_poor_quality"
      expr: SUM(CAST(kpi_cost_of_poor_quality AS DOUBLE))
      comment: "Total cost of poor quality from suppliers"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer map yield and die distribution metrics for spatial quality analysis"
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_map`"
  dimensions:
    - name: "map_status"
      expr: map_status
      comment: "Status of wafer map (active, archived, superseded)"
    - name: "map_type"
      expr: map_type
      comment: "Type of wafer map (probe, final test, etc.)"
    - name: "map_format"
      expr: map_format
      comment: "Format of wafer map data"
    - name: "flat_orientation"
      expr: flat_orientation
      comment: "Orientation of wafer flat"
    - name: "kgd_certified"
      expr: is_kgd_certified
      comment: "Known Good Die certification flag"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance flag"
    - name: "compliance_iatf16949"
      expr: compliance_iatf16949
      comment: "IATF 16949 compliance flag"
    - name: "map_generation_month"
      expr: DATE_TRUNC('MONTH', map_generation_timestamp)
      comment: "Month when wafer map was generated"
  measures:
    - name: "total_wafer_maps"
      expr: COUNT(1)
      comment: "Total number of wafer maps"
    - name: "unique_wafers_mapped"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with maps"
    - name: "unique_lots_mapped"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of unique lots with wafer maps"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across wafer maps"
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage"
    - name: "avg_defect_density_per_sqmm"
      expr: AVG(CAST(defect_density_per_sqmm AS DOUBLE))
      comment: "Average defect density per square millimeter"
    - name: "avg_edge_exclusion_zone_mm"
      expr: AVG(CAST(edge_exclusion_zone_mm AS DOUBLE))
      comment: "Average edge exclusion zone in millimeters"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer zone-level yield and defect density metrics for spatial process analysis, enabling identification of radial yield patterns and equipment-induced defect signatures."
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of wafer zone (e.g., center, edge, ring) for spatial yield pattern analysis."
    - name: "zone_name"
      expr: zone_name
      comment: "Name of the wafer zone for human-readable spatial reporting."
    - name: "wafer_zone_status"
      expr: wafer_zone_status
      comment: "Current status of the wafer zone record."
    - name: "zone_status"
      expr: zone_status
      comment: "Operational status of the zone for active monitoring management."
    - name: "radial_position"
      expr: radial_position
      comment: "Radial position classification of the zone for center-to-edge yield gradient analysis."
    - name: "radius_band"
      expr: radius_band
      comment: "Radius band grouping for aggregated radial yield analysis."
    - name: "shape"
      expr: shape
      comment: "Geometric shape of the zone (e.g., annular, rectangular) for spatial analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the zone is designated as critical for yield — drives inspection frequency and process control priority."
    - name: "process_step"
      expr: process_step
      comment: "Process step associated with the zone measurement for step-level spatial yield attribution."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month zone definition became effective for historical spatial yield trending."
  measures:
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage by wafer zone — enables spatial yield gradient analysis to identify process non-uniformity."
    - name: "avg_zone_yield_percent"
      expr: AVG(CAST(zone_yield_percent AS DOUBLE))
      comment: "Average zone-specific yield percentage for granular spatial quality reporting."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density per zone — identifies high-defect zones for targeted process improvement."
    - name: "avg_typical_defect_density"
      expr: AVG(CAST(typical_defect_density AS DOUBLE))
      comment: "Average typical defect density baseline per zone, used to detect excursions above historical norms."
    - name: "avg_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average zone area in square micrometers for yield normalization and die count estimation."
    - name: "avg_inner_radius_mm"
      expr: AVG(CAST(inner_radius_mm AS DOUBLE))
      comment: "Average inner radius of wafer zones for process window and exclusion zone optimization."
    - name: "avg_outer_radius_mm"
      expr: AVG(CAST(outer_radius_mm AS DOUBLE))
      comment: "Average outer radius of wafer zones for spatial coverage analysis."
    - name: "critical_zone_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical wafer zones under active monitoring — measures spatial quality control coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer and lot yield performance metrics for manufacturing efficiency analysis"
  source: "`vibe_semiconductors_v1`.`quality`.`yield_record`"
  dimensions:
    - name: "yield_stage"
      expr: yield_stage
      comment: "Stage of manufacturing where yield was measured (probe, final test, etc.)"
    - name: "yield_type"
      expr: yield_type
      comment: "Type of yield measurement (parametric, functional, etc.)"
    - name: "process_node"
      expr: process_node
      comment: "Technology node for yield analysis"
    - name: "fab_line"
      expr: fab_line
      comment: "Fabrication line where wafer was processed"
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage where measurement was taken"
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint for yield assessment"
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Category of yield loss for root cause analysis"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month when yield was measured"
    - name: "measurement_week"
      expr: DATE_TRUNC('WEEK', measurement_date)
      comment: "Week when yield was measured"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "unique_wafers_measured"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with yield measurements"
    - name: "unique_lots_measured"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of unique lots with yield measurements"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across all measurements"
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS BIGINT))
      comment: "Total count of good die across all wafers"
    - name: "total_die_measured"
      expr: SUM(CAST(total_die_count AS BIGINT))
      comment: "Total count of die measured across all wafers"
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter"
$$;
