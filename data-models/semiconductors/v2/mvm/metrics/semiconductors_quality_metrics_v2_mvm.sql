-- Metric views for domain: quality | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect detection and classification metrics for wafer and die-level quality analysis, supporting root cause analysis and yield improvement initiatives."
  source: "`vibe_semiconductors_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect detected (e.g., particle, scratch, pattern defect)"
    - name: "defect_category"
      expr: defect_category
      comment: "High-level defect category for grouping similar defect types"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of the defect (e.g., critical, major, minor)"
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification of defect for analysis and trending"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect (e.g., optical inspection, e-beam)"
    - name: "defect_layer"
      expr: defect_layer
      comment: "Fabrication layer where defect was detected"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the defect"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for defective material (e.g., scrap, rework, use-as-is)"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when defect was detected for time-series analysis"
    - name: "detection_week"
      expr: DATE_TRUNC('WEEK', detection_timestamp)
      comment: "Week when defect was detected for short-term trending"
    - name: "edge_exclusion_zone_flag"
      expr: edge_exclusion_zone_flag
      comment: "Whether defect occurred in edge exclusion zone"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records detected"
    - name: "unique_wafers_with_defects"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with at least one defect"
    - name: "avg_defect_size_um"
      expr: AVG(CAST(defect_size_um AS DOUBLE))
      comment: "Average defect size in micrometers"
    - name: "avg_defect_density_per_zone"
      expr: AVG(CAST(defect_density_per_zone AS DOUBLE))
      comment: "Average defect density per zone across all records"
    - name: "total_defect_area_um2"
      expr: SUM(CAST(defect_area_um2 AS DOUBLE))
      comment: "Total defect area in square micrometers"
    - name: "max_defect_size_um"
      expr: MAX(CAST(defect_size_um AS DOUBLE))
      comment: "Maximum defect size detected in micrometers"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer and lot yield performance metrics for manufacturing efficiency analysis and process optimization."
  source: "`vibe_semiconductors_v1`.`quality`.`yield_record`"
  dimensions:
    - name: "yield_stage"
      expr: yield_stage
      comment: "Manufacturing stage where yield was measured (e.g., probe, final test)"
    - name: "yield_type"
      expr: yield_type
      comment: "Type of yield measurement (e.g., parametric, functional, sort)"
    - name: "fab_line"
      expr: fab_line
      comment: "Fabrication line where wafer was processed"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot"
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage in process flow where measurement was taken"
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Category of yield loss for Pareto analysis"
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint identifier"
    - name: "shift"
      expr: shift
      comment: "Manufacturing shift when yield was recorded"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of yield measurement for trending"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month when yield record was created"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across all records"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage (alternate field) across all records"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS BIGINT))
      comment: "Total count of good die across all wafers"
    - name: "total_die_tested"
      expr: SUM(CAST(total_die_count AS BIGINT))
      comment: "Total count of die tested across all wafers"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across all yield records"
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter"
    - name: "total_defects"
      expr: SUM(CAST(defect_count AS BIGINT))
      comment: "Total defect count across all yield records"
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield"
    - name: "unique_wafers_measured"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with yield measurements"
    - name: "unique_lots_measured"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Number of unique wafer lots with yield measurements"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint tracking and resolution metrics for quality feedback loop and customer satisfaction management."
  source: "`vibe_semiconductors_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (e.g., quality, delivery, documentation)"
    - name: "complaint_category"
      expr: complaint_category
      comment: "High-level category for complaint classification"
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., open, investigating, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint"
    - name: "priority"
      expr: priority
      comment: "Priority level for complaint resolution"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the complaint"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the complaint"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which complaint was received"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether complaint was escalated"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether complaint resulted in warranty claim"
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_timestamp)
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
      comment: "Number of unique customers who filed complaints"
    - name: "total_complaint_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost associated with customer complaints"
    - name: "total_cost_adjustments"
      expr: SUM(CAST(cost_adjustments AS DOUBLE))
      comment: "Total cost adjustments made due to complaints"
    - name: "total_net_cost"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost impact of complaints after adjustments"
    - name: "avg_dppm_impact"
      expr: AVG(CAST(dppm_impact AS DOUBLE))
      comment: "Average defects per million parts impact from complaints"
    - name: "total_defect_quantity"
      expr: SUM(CAST(defect_quantity AS BIGINT))
      comment: "Total quantity of defective units reported in complaints"
    - name: "avg_complaint_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per customer complaint"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance tracking and material review board metrics for quality control and compliance management."
  source: "`vibe_semiconductors_v1`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "nonconformance_type"
      expr: nonconformance_type
      comment: "Type of nonconformance detected"
    - name: "severity"
      expr: severity
      comment: "Severity level of the nonconformance"
    - name: "severity_level"
      expr: severity_level
      comment: "Alternate severity level classification"
    - name: "priority"
      expr: priority
      comment: "Priority for nonconformance resolution"
    - name: "disposition"
      expr: disposition
      comment: "Material disposition decision (e.g., scrap, rework, use-as-is)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Detailed disposition decision from MRB"
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
      comment: "Whether customer notification is required"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold placed on material"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month when nonconformance was detected"
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports"
    - name: "unique_wafers_with_ncr"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with nonconformance reports"
    - name: "unique_lots_with_ncr"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Number of unique lots with nonconformance reports"
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances"
    - name: "avg_impact_amount"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action effectiveness metrics for continuous improvement and compliance management."
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs preventive action)"
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA"
    - name: "priority"
      expr: priority
      comment: "Priority level for CAPA completion"
    - name: "severity"
      expr: severity
      comment: "Severity of the issue requiring CAPA"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the issue"
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Method used for root cause analysis (e.g., 5-Why, Fishbone)"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where issue was detected"
    - name: "detection_source"
      expr: detection_source
      comment: "Source of issue detection"
    - name: "department"
      expr: department
      comment: "Department responsible for CAPA"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of effectiveness verification"
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status for CAPA closure"
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
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost for all CAPAs"
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred for CAPAs"
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
  comment: "Product reliability and qualification test metrics for long-term quality assurance and customer confidence."
  source: "`vibe_semiconductors_v1`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (e.g., HTOL, HAST, TC, ELFR)"
    - name: "test_standard"
      expr: test_standard
      comment: "Industry standard followed for test (e.g., JEDEC, AEC-Q100)"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., new product, change control)"
    - name: "test_result"
      expr: test_result
      comment: "Overall test result (pass/fail)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test"
    - name: "overall_status"
      expr: overall_status
      comment: "Overall reliability test program status"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Observed failure mode during test"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical mechanism causing failure"
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade achieved (e.g., Grade 1, Grade 2)"
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "Whether test is JEDEC compliant"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether product achieved Known Good Die certification"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_execution_timestamp)
      comment: "Month when test was executed"
  measures:
    - name: "total_reliability_tests"
      expr: COUNT(1)
      comment: "Total number of reliability test records"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours"
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average Failures In Time rate (failures per billion device hours)"
    - name: "avg_failure_time_hours"
      expr: AVG(CAST(failure_time_hours AS DOUBLE))
      comment: "Average time to failure in hours"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "avg_test_humidity_percent"
      expr: AVG(CAST(test_humidity_percent AS DOUBLE))
      comment: "Average test humidity percentage"
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage in volts"
    - name: "avg_weibull_shape"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter (beta) for failure distribution"
    - name: "avg_weibull_scale"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter (eta) for failure distribution"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level spatial defect and yield pattern metrics for process excursion detection and yield learning."
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_map`"
  dimensions:
    - name: "map_type"
      expr: map_type
      comment: "Type of wafer map (e.g., bin map, defect map)"
    - name: "map_status"
      expr: map_status
      comment: "Status of the wafer map"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect shown on map"
    - name: "defect_zone"
      expr: defect_zone
      comment: "Zone of wafer where defects are concentrated"
    - name: "flat_orientation"
      expr: flat_orientation
      comment: "Wafer flat orientation for spatial reference"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether wafer achieved Known Good Die certification"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "Whether wafer map meets ISO 9001 compliance"
    - name: "map_generation_month"
      expr: DATE_TRUNC('MONTH', map_generation_timestamp)
      comment: "Month when wafer map was generated"
  measures:
    - name: "total_wafer_maps"
      expr: COUNT(1)
      comment: "Total number of wafer maps generated"
    - name: "unique_wafers_mapped"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers with maps"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average die yield percentage across wafer maps"
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage (alternate field)"
    - name: "avg_defect_density_per_sqmm"
      expr: AVG(CAST(defect_density_per_sqmm AS DOUBLE))
      comment: "Average defect density per square millimeter"
    - name: "avg_edge_exclusion_zone_mm"
      expr: AVG(CAST(edge_exclusion_zone_mm AS DOUBLE))
      comment: "Average edge exclusion zone width in millimeters"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot acceptance and sampling metrics for incoming, in-process, and final quality control."
  source: "`vibe_semiconductors_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., incoming, in-process, final)"
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage in manufacturing where inspection occurred"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of inspection (e.g., accept, reject, conditional)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for inspected lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot inspected"
    - name: "material_type"
      expr: material_type
      comment: "Type of material inspected"
    - name: "iso_9001_compliant"
      expr: iso_9001_compliant
      comment: "Whether inspection meets ISO 9001 requirements"
    - name: "iatf_16949_compliant"
      expr: iatf_16949_compliant
      comment: "Whether inspection meets IATF 16949 automotive requirements"
    - name: "jedec_reliability_compliant"
      expr: jedec_reliability_compliant
      comment: "Whether inspection meets JEDEC reliability standards"
    - name: "kgd_certified"
      expr: kgd_certified
      comment: "Whether lot achieved Known Good Die certification"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when inspection measurement was taken"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS BIGINT))
      comment: "Total size of all inspected lots"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS BIGINT))
      comment: "Average lot size for inspections"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across inspection lots"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage for inspected lots"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across inspections"
    - name: "avg_wafer_size_mm"
      expr: AVG(CAST(wafer_size_mm AS DOUBLE))
      comment: "Average wafer size in millimeters"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold and release cycle time metrics for material flow control and containment effectiveness."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (e.g., engineering, quality, customer)"
    - name: "hold_category"
      expr: hold_category
      comment: "Category of quality hold"
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold"
    - name: "reason_code"
      expr: reason_code
      comment: "Code identifying reason for hold"
    - name: "priority"
      expr: priority
      comment: "Priority level for hold resolution"
    - name: "affected_entity_type"
      expr: affected_entity_type
      comment: "Type of entity under hold (e.g., wafer, lot, tool)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of hold resolution"
    - name: "compliance_iso_9001_flag"
      expr: compliance_iso_9001_flag
      comment: "Whether hold follows ISO 9001 procedures"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether held material was KGD certified"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', hold_timestamp)
      comment: "Month when hold was placed"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_timestamp)
      comment: "Month when hold was released"
  measures:
    - name: "total_quality_holds"
      expr: COUNT(1)
      comment: "Total number of quality holds placed"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS BIGINT))
      comment: "Total quantity of material under quality hold"
    - name: "avg_affected_quantity"
      expr: AVG(CAST(affected_quantity AS BIGINT))
      comment: "Average quantity affected per hold"
    - name: "unique_lots_on_hold"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Number of unique wafer lots under quality hold"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_failure_analysis_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure analysis findings and root cause metrics for deep-dive quality investigations and design feedback."
  source: "`vibe_semiconductors_v1`.`quality`.`failure_analysis_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of failure analysis report"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the FA report"
    - name: "analysis_technique"
      expr: analysis_technique
      comment: "Technique used for failure analysis (e.g., SEM, FIB, TEM)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Observed failure mode"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical mechanism causing failure"
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity of the failure"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause from analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the FA report"
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code assigned from analysis"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month when failure analysis was performed"
  measures:
    - name: "total_fa_reports"
      expr: COUNT(1)
      comment: "Total number of failure analysis reports"
    - name: "unique_products_analyzed"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with failure analysis"
    - name: "unique_wafers_analyzed"
      expr: COUNT(DISTINCT wafer_probe_run_id)
      comment: "Number of unique wafer probe runs analyzed"
$$;