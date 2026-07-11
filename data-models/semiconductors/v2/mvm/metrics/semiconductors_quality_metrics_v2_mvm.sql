-- Metric views for domain: quality | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect tracking and density metrics for wafer and die-level quality analysis, supporting root cause analysis and yield improvement initiatives."
  source: "`vibe_semiconductors_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_classification"
      expr: defect_classification
      comment: "Type classification of the defect (e.g., particle, scratch, pattern defect)"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of the defect (critical, major, minor)"
    - name: "defect_layer"
      expr: defect_layer
      comment: "Process layer where defect was detected"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect (optical inspection, e-beam, etc.)"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the defect"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defect (scrap, rework, use-as-is)"
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect record"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when defect was detected"
    - name: "detection_quarter"
      expr: DATE_TRUNC('QUARTER', event_timestamp)
      comment: "Quarter when defect was detected"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "unique_wafers_with_defects"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Count of unique wafers with at least one defect"
    - name: "avg_defect_size_nm"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers"
    - name: "avg_defect_area_um2"
      expr: AVG(CAST(defect_area_um2 AS DOUBLE))
      comment: "Average defect area in square micrometers"
    - name: "total_defect_area_um2"
      expr: SUM(CAST(defect_area_um2 AS DOUBLE))
      comment: "Total defect area across all defects in square micrometers"
    - name: "avg_defect_density_per_zone"
      expr: AVG(CAST(defect_density_per_zone AS DOUBLE))
      comment: "Average defect density per zone"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield performance metrics for wafer fabrication and test, enabling yield analysis, gap identification, and process optimization."
  source: "`vibe_semiconductors_v1`.`quality`.`yield_record`"
  dimensions:
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage where yield was measured (wafer probe, final test, etc.)"
    - name: "process_node"
      expr: process_node
      comment: "Technology node of the process"
    - name: "lot_status"
      expr: lot_status
      comment: "Status of the lot at measurement time"
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Category of yield loss (systematic, random, parametric)"
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint identifier"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect contributing to yield loss"
    - name: "yield_record_status"
      expr: yield_record_status
      comment: "Status of the yield record"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when yield was measured"
    - name: "event_quarter"
      expr: DATE_TRUNC('QUARTER', event_timestamp)
      comment: "Quarter when yield was measured"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across all records"
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target percentage"
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total count of good die across all records"
    - name: "total_die_tested"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total count of die tested across all records"
    - name: "total_defects"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all yield records"
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter"
    - name: "unique_wafers_measured"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Count of unique wafers with yield measurements"
    - name: "unique_lots_measured"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Count of unique wafer lots with yield measurements"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_dppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defective parts per million (DPPM) metrics for customer quality tracking, regulatory compliance, and supplier quality management."
  source: "`vibe_semiconductors_v1`.`quality`.`dppm_record`"
  dimensions:
    - name: "notification_type"
      expr: notification_type
      comment: "Type of DPPM notification (customer return, field failure, etc.)"
    - name: "closure_status"
      expr: closure_status
      comment: "Status of the DPPM issue closure"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the quality issue"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle status at time of issue"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether the product was Known Good Die certified"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance status"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when DPPM event occurred"
    - name: "event_quarter"
      expr: DATE_TRUNC('QUARTER', event_timestamp)
      comment: "Quarter when DPPM event occurred"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_start_date)
      comment: "Month when defective units were shipped"
  measures:
    - name: "total_dppm_records"
      expr: COUNT(1)
      comment: "Total number of DPPM records"
    - name: "total_defective_units"
      expr: SUM(CAST(defective_units AS DOUBLE))
      comment: "Total count of defective units reported"
    - name: "total_units_shipped"
      expr: SUM(CAST(total_units_shipped AS DOUBLE))
      comment: "Total count of units shipped in the period"
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defective parts per million rate"
    - name: "unique_customers_affected"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of unique customers with DPPM issues"
    - name: "unique_suppliers_involved"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of unique suppliers involved in DPPM issues"
    - name: "unique_products_affected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs with DPPM issues"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint tracking and resolution metrics for quality management, customer satisfaction, and corrective action effectiveness."
  source: "`vibe_semiconductors_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (quality, delivery, documentation, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint"
    - name: "priority"
      expr: priority
      comment: "Priority level for complaint resolution"
    - name: "customer_complaint_status"
      expr: customer_complaint_status
      comment: "Current status of the complaint"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of complaint resolution"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Coded root cause of the complaint"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether complaint was escalated"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether complaint resulted in warranty claim"
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_timestamp)
      comment: "Month when complaint was received"
    - name: "complaint_quarter"
      expr: DATE_TRUNC('QUARTER', complaint_timestamp)
      comment: "Quarter when complaint was received"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints"
    - name: "unique_customers_complaining"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of unique customers who filed complaints"
    - name: "unique_products_complained"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique products with complaints"
    - name: "total_complaint_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost amount associated with complaints"
    - name: "total_cost_adjustments"
      expr: SUM(CAST(cost_adjustments AS DOUBLE))
      comment: "Total cost adjustments from complaints"
    - name: "total_net_cost"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost impact of complaints"
    - name: "avg_dppm_impact"
      expr: AVG(CAST(dppm_impact AS DOUBLE))
      comment: "Average DPPM impact per complaint"
    - name: "escalated_complaints"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints that were escalated"
    - name: "warranty_claims"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints resulting in warranty claims"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance tracking and material review board (MRB) decision metrics for quality control and compliance management."
  source: "`vibe_semiconductors_v1`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "nonconformance_report_status"
      expr: nonconformance_report_status
      comment: "Current status of the nonconformance report"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the nonconformance"
    - name: "priority"
      expr: priority
      comment: "Priority level for resolution"
    - name: "detection_point"
      expr: detection_point
      comment: "Point in process where nonconformance was detected"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "MRB disposition decision (use-as-is, rework, scrap, return)"
    - name: "mrb_decision"
      expr: mrb_decision
      comment: "Material Review Board decision"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "is_customer_impact"
      expr: is_customer_impact
      comment: "Whether nonconformance impacts customer"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold placed on material"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard violated or referenced"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month when nonconformance was reported"
    - name: "report_quarter"
      expr: DATE_TRUNC('QUARTER', report_timestamp)
      comment: "Quarter when nonconformance was reported"
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports"
    - name: "unique_suppliers_with_ncr"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of unique suppliers with nonconformances"
    - name: "unique_products_with_ncr"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique products with nonconformances"
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances"
    - name: "customer_impacting_ncrs"
      expr: SUM(CASE WHEN is_customer_impact = TRUE THEN 1 ELSE 0 END)
      comment: "Count of nonconformances impacting customers"
    - name: "ncrs_requiring_customer_notification"
      expr: SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of NCRs requiring customer notification"
    - name: "unique_wafers_on_hold"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Count of unique wafers placed on hold due to NCR"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics for quality system improvement and compliance management."
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, or both)"
    - name: "capa_record_status"
      expr: capa_record_status
      comment: "Current status of the CAPA record"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity level of the issue addressed by CAPA"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the issue"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where issue was detected"
    - name: "detection_source"
      expr: detection_source
      comment: "Source of issue detection (audit, complaint, inspection, etc.)"
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Method used for root cause analysis (5-Why, Fishbone, etc.)"
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status of CAPA closure"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of effectiveness verification"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month when issue was detected"
    - name: "detection_quarter"
      expr: DATE_TRUNC('QUARTER', detection_date)
      comment: "Quarter when issue was detected"
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "unique_suppliers_with_capa"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of unique suppliers with CAPA actions"
    - name: "unique_products_with_capa"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique products with CAPA actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of CAPA actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA actions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per CAPA"
    - name: "avg_actual_cost"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_reliability_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test results and failure rate metrics for product qualification, JEDEC compliance, and field reliability prediction."
  source: "`vibe_semiconductors_v1`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, HAST, TC, etc.)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the reliability test"
    - name: "test_result"
      expr: test_result
      comment: "Result of the reliability test (pass, fail, conditional)"
    - name: "overall_status"
      expr: overall_status
      comment: "Overall qualification status"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, process change, etc.)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Observed failure mode"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism"
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade assigned to product"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether product is Known Good Die certified"
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "JEDEC standard compliance status"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_execution_timestamp)
      comment: "Month when test was executed"
    - name: "test_quarter"
      expr: DATE_TRUNC('QUARTER', test_execution_timestamp)
      comment: "Quarter when test was executed"
  measures:
    - name: "total_reliability_tests"
      expr: COUNT(1)
      comment: "Total number of reliability tests conducted"
    - name: "unique_products_tested"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique products undergoing reliability testing"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours"
    - name: "total_test_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test hours across all reliability tests"
    - name: "avg_failure_time_hours"
      expr: AVG(CAST(failure_time_hours AS DOUBLE))
      comment: "Average time to failure in hours"
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average Failures In Time rate (failures per billion device-hours)"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "avg_weibull_shape"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter (beta) for failure distribution"
    - name: "avg_weibull_scale"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter (eta) for failure distribution"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics for incoming, in-process, and final inspection with compliance tracking and disposition analysis."
  source: "`vibe_semiconductors_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final, audit)"
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage in process where inspection occurred"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of inspection (pass, fail, conditional)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the lot"
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot"
    - name: "material_type"
      expr: material_type
      comment: "Type of material inspected"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (production, qualification, engineering)"
    - name: "kgd_certified"
      expr: kgd_certified
      comment: "Whether lot is Known Good Die certified"
    - name: "iso_9001_compliant"
      expr: iso_9001_compliant
      comment: "ISO 9001 compliance status"
    - name: "iatf_16949_compliant"
      expr: iatf_16949_compliant
      comment: "IATF 16949 compliance status"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when inspection was performed"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "unique_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of unique suppliers with inspected material"
    - name: "unique_products_inspected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique products inspected"
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total size of all inspection lots"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inspection lots"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across inspection lots"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value for inspected parameter"
    - name: "kgd_certified_lots"
      expr: SUM(CASE WHEN kgd_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lots with Known Good Die certification"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_failure_analysis_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure analysis report metrics for root cause identification, failure mechanism analysis, and corrective action effectiveness."
  source: "`vibe_semiconductors_v1`.`quality`.`failure_analysis_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of failure analysis report"
    - name: "failure_analysis_report_status"
      expr: failure_analysis_report_status
      comment: "Current status of the failure analysis report"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the report"
    - name: "analysis_technique"
      expr: analysis_technique
      comment: "Technique used for failure analysis (SEM, TEM, FIB, etc.)"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Identified failure mechanism"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the failure"
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity level of the failure"
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code classification"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_start_timestamp)
      comment: "Month when analysis was started"
    - name: "analysis_quarter"
      expr: DATE_TRUNC('QUARTER', analysis_start_timestamp)
      comment: "Quarter when analysis was started"
  measures:
    - name: "total_failure_analysis_reports"
      expr: COUNT(1)
      comment: "Total number of failure analysis reports"
    - name: "unique_products_analyzed"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Count of unique products undergoing failure analysis"
    - name: "unique_customers_with_failures"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of unique customers with failure analysis"
    - name: "unique_suppliers_with_failures"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of unique suppliers with failure analysis"
    - name: "unique_wafers_analyzed"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Count of unique wafers undergoing failure analysis"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer map yield and defect pattern metrics for spatial analysis, bin distribution, and Known Good Die certification tracking."
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_map`"
  dimensions:
    - name: "map_status"
      expr: map_status
      comment: "Status of the wafer map"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect observed on wafer map"
    - name: "defect_zone"
      expr: defect_zone
      comment: "Zone of wafer where defects are concentrated"
    - name: "flat_orientation"
      expr: flat_orientation
      comment: "Orientation of wafer flat/notch"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether wafer is Known Good Die certified"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance status"
    - name: "compliance_iatf16949"
      expr: compliance_iatf16949
      comment: "IATF 16949 compliance status"
    - name: "map_generation_month"
      expr: DATE_TRUNC('MONTH', map_generation_timestamp)
      comment: "Month when wafer map was generated"
    - name: "map_generation_quarter"
      expr: DATE_TRUNC('QUARTER', map_generation_timestamp)
      comment: "Quarter when wafer map was generated"
  measures:
    - name: "total_wafer_maps"
      expr: COUNT(1)
      comment: "Total number of wafer maps"
    - name: "unique_wafers_mapped"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Count of unique wafers with maps"
    - name: "unique_products_mapped"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Count of unique products with wafer maps"
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across wafer maps"
    - name: "avg_defect_density_per_sqmm"
      expr: AVG(CAST(defect_density_per_sqmm AS DOUBLE))
      comment: "Average defect density per square millimeter"
    - name: "avg_edge_exclusion_zone_mm"
      expr: AVG(CAST(edge_exclusion_zone_mm AS DOUBLE))
      comment: "Average edge exclusion zone in millimeters"
    - name: "kgd_certified_wafers"
      expr: SUM(CASE WHEN is_kgd_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of wafers with Known Good Die certification"
$$;