-- Metric views for domain: quality | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality inspection metrics tracking lot-level inspection outcomes, pass/fail rates, and compliance performance across chemical products and materials"
  source: "`chemical_mfg_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot (e.g., In Progress, Completed, Released)"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition decision code for the inspection lot (e.g., Accept, Reject, Conditional)"
    - name: "inspection_source"
      expr: inspection_source
      comment: "Origin of the inspection requirement (e.g., Goods Receipt, Production, Customer Complaint)"
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of the lot being inspected (e.g., Raw Material, Finished Good, WIP)"
    - name: "gmp_compliant_flag"
      expr: gmp_compliant
      comment: "Indicates whether the lot meets Good Manufacturing Practice requirements"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the lot meets regulatory compliance standards"
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Binary pass/fail outcome of the inspection"
    - name: "oos_flag"
      expr: oos_flag
      comment: "Out-of-specification flag indicating results outside acceptable limits"
    - name: "oot_flag"
      expr: oot_flag
      comment: "Out-of-trend flag indicating unusual variation from historical patterns"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is currently on quality hold"
    - name: "inspection_year"
      expr: YEAR(inspection_start_timestamp)
      comment: "Year when inspection started"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_start_timestamp)
      comment: "Month when inspection started"
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Year when disposition decision was made"
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month when disposition decision was made"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed"
    - name: "total_quantity_inspected"
      expr: SUM(CAST(quantity_inspected AS DOUBLE))
      comment: "Total quantity of material inspected across all lots"
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total quantity of samples taken for inspection"
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection lots that passed quality standards"
    - name: "gmp_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots meeting Good Manufacturing Practice requirements"
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots meeting regulatory compliance standards"
    - name: "oos_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN oos_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots with out-of-specification results requiring investigation"
    - name: "oot_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN oot_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots with out-of-trend results indicating process variation"
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots placed on quality hold pending investigation"
    - name: "distinct_products_inspected"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products undergoing inspection"
    - name: "distinct_vendors_inspected"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors whose materials were inspected"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across all inspection lots"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_qc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed quality control test result metrics tracking individual test performance, specification conformance, and process capability at the characteristic level"
  source: "`chemical_mfg_ecm`.`quality`.`qc_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the QC test result (e.g., Pass, Fail, Pending, Retest)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement performed (e.g., Chemical, Physical, Microbiological)"
    - name: "retest_flag"
      expr: retest_flag
      comment: "Indicates whether this result is from a retest"
    - name: "is_control_sample"
      expr: is_control_sample
      comment: "Indicates whether this is a control sample result"
    - name: "spc_flag"
      expr: spc_flag
      comment: "Indicates whether this result is tracked under statistical process control"
    - name: "test_year"
      expr: YEAR(test_timestamp)
      comment: "Year when the test was performed"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month when the test was performed"
    - name: "test_week"
      expr: DATE_TRUNC('WEEK', test_timestamp)
      comment: "Week when the test was performed"
  measures:
    - name: "total_qc_tests"
      expr: COUNT(1)
      comment: "Total number of QC tests performed"
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN result_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC tests that passed specification limits"
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN retest_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests requiring retest due to initial failure or anomaly"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average test result value across all measurements"
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average absolute deviation from target specification"
    - name: "avg_deviation_percent"
      expr: AVG(CAST(deviation_percent AS DOUBLE))
      comment: "Average percentage deviation from target specification"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across tests"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across tests"
    - name: "distinct_inspection_lots_tested"
      expr: COUNT(DISTINCT inspection_lot_id)
      comment: "Number of unique inspection lots tested"
    - name: "distinct_test_methods_used"
      expr: COUNT(DISTINCT test_method_id)
      comment: "Number of unique test methods employed"
    - name: "distinct_characteristics_tested"
      expr: COUNT(DISTINCT inspection_characteristic_id)
      comment: "Number of unique quality characteristics tested"
    - name: "distinct_materials_tested"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials undergoing QC testing"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality deviation and non-conformance metrics tracking incidents, root causes, resolution effectiveness, and cost of quality across the manufacturing process"
  source: "`chemical_mfg_ecm`.`quality`.`quality_deviation`"
  dimensions:
    - name: "quality_deviation_status"
      expr: quality_deviation_status
      comment: "Current status of the quality deviation (e.g., Open, Under Investigation, Closed)"
    - name: "notification_type"
      expr: notification_type
      comment: "Type of quality notification (e.g., Complaint, Deviation, Non-Conformance)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the deviation (e.g., Critical, Major, Minor)"
    - name: "priority"
      expr: priority
      comment: "Priority level for resolution (e.g., High, Medium, Low)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of the root cause (e.g., Material, Process, Equipment, Human Error)"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where the deviation was detected (e.g., In-Process, Final Inspection, Customer)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the deviation resolution"
    - name: "ncr_disposition"
      expr: ncr_disposition
      comment: "Non-conformance report disposition decision (e.g., Use As Is, Rework, Scrap)"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Indicates whether the deviation must be reported to regulatory authorities"
    - name: "is_hold"
      expr: is_hold
      comment: "Indicates whether material is on hold due to this deviation"
    - name: "customer_complaint_type"
      expr: customer_complaint_type
      comment: "Type of customer complaint if deviation originated from customer"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year when the deviation event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the deviation event occurred"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year when the deviation was resolved"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when the deviation was resolved"
  measures:
    - name: "total_quality_deviations"
      expr: COUNT(1)
      comment: "Total number of quality deviations reported"
    - name: "total_cost_of_quality"
      expr: SUM(CAST(cost_of_quality AS DOUBLE))
      comment: "Total financial impact of quality deviations including rework, scrap, and investigation costs"
    - name: "avg_cost_per_deviation"
      expr: AVG(CAST(cost_of_quality AS DOUBLE))
      comment: "Average cost per quality deviation incident"
    - name: "total_impact_quantity"
      expr: SUM(CAST(impact_quantity AS DOUBLE))
      comment: "Total quantity of material impacted by quality deviations"
    - name: "critical_deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations classified as critical severity"
    - name: "regulatory_reportable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reportable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations requiring regulatory reporting"
    - name: "customer_complaint_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_complaint_type IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations originating from customer complaints"
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hold = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations resulting in material hold"
    - name: "distinct_products_affected"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products affected by quality deviations"
    - name: "distinct_vendors_affected"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors associated with quality deviations"
    - name: "distinct_customers_affected"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts affected by quality deviations"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics tracking action completion, cost, and quality improvement outcomes"
  source: "`chemical_mfg_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., Open, In Progress, Completed, Verified)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (e.g., Corrective, Preventive, Combined)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA (e.g., High, Medium, Low)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the underlying issue (e.g., Critical, Major, Minor)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of the root cause addressed by the CAPA"
    - name: "department"
      expr: department
      comment: "Department responsible for implementing the CAPA"
    - name: "rci_method"
      expr: rci_method
      comment: "Root cause investigation method used (e.g., 5 Why, Fishbone, FMEA)"
    - name: "effectiveness_outcome"
      expr: effectiveness_outcome
      comment: "Outcome of effectiveness verification (e.g., Effective, Ineffective, Partially Effective)"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of CAPA verification (e.g., Passed, Failed, Pending)"
    - name: "gmp_compliance"
      expr: gmp_compliance
      comment: "Indicates whether CAPA addresses GMP compliance issue"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when CAPA was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when CAPA was created"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion date"
    - name: "actual_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year of actual completion date"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "total_capa_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all CAPAs"
    - name: "total_capa_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred for completed CAPAs"
    - name: "avg_capa_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per CAPA"
    - name: "avg_capa_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per completed CAPA"
    - name: "capa_effectiveness_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN effectiveness_outcome = 'Effective' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs verified as effective in preventing recurrence"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_completion_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of CAPAs completed on or before target date"
    - name: "gmp_related_capa_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_compliance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs addressing GMP compliance issues"
    - name: "distinct_quality_deviations_addressed"
      expr: COUNT(DISTINCT quality_deviation_id)
      comment: "Number of unique quality deviations addressed by CAPAs"
    - name: "distinct_products_improved"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products improved through CAPA actions"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_usage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material disposition and usage decision metrics tracking release, hold, and rejection decisions with financial and compliance impact"
  source: "`chemical_mfg_ecm`.`quality`.`usage_decision`"
  dimensions:
    - name: "usage_decision_status"
      expr: usage_decision_status
      comment: "Status of the usage decision (e.g., Released, Held, Rejected, Pending)"
    - name: "decision_code"
      expr: decision_code
      comment: "Code representing the disposition decision (e.g., UR - Unrestricted Release, RJ - Reject, RW - Rework)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the usage decision"
    - name: "follow_up_action_code"
      expr: follow_up_action_code
      comment: "Code indicating required follow-up actions"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the material meets compliance requirements"
    - name: "is_conditional_release"
      expr: is_conditional_release
      comment: "Indicates whether release is conditional with restrictions"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year when usage decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when usage decision was made"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year when material was released"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when material was released"
  measures:
    - name: "total_usage_decisions"
      expr: COUNT(1)
      comment: "Total number of usage decisions made"
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity of material released for use"
    - name: "total_hold_quantity"
      expr: SUM(CAST(hold_quantity AS DOUBLE))
      comment: "Total quantity of material placed on hold"
    - name: "total_defect_quantity"
      expr: SUM(CAST(defect_quantity AS DOUBLE))
      comment: "Total quantity of material identified as defective"
    - name: "total_reprocess_quantity"
      expr: SUM(CAST(reprocess_quantity AS DOUBLE))
      comment: "Total quantity of material sent for reprocessing"
    - name: "release_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_code IN ('UR', 'RELEASE') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of usage decisions resulting in material release"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_code IN ('RJ', 'REJECT') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of usage decisions resulting in material rejection"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials meeting compliance requirements"
    - name: "conditional_release_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_conditional_release = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of releases that are conditional with restrictions"
    - name: "distinct_inspection_lots_decided"
      expr: COUNT(DISTINCT inspection_lot_id)
      comment: "Number of unique inspection lots with usage decisions"
    - name: "distinct_materials_decided"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials with usage decisions"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold metrics tracking material quarantine, hold duration, release effectiveness, and inventory impact of quality issues"
  source: "`chemical_mfg_ecm`.`quality`.`quality_hold`"
  dimensions:
    - name: "quality_hold_status"
      expr: quality_hold_status
      comment: "Current status of the quality hold (e.g., Active, Released, Escalated)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (e.g., Inspection Hold, Deviation Hold, Regulatory Hold)"
    - name: "reason_code"
      expr: reason_code
      comment: "Code indicating reason for the hold"
    - name: "release_outcome"
      expr: release_outcome
      comment: "Outcome when hold is released (e.g., Released, Rejected, Reworked)"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether hold is related to regulatory compliance issue"
    - name: "hold_year"
      expr: YEAR(hold_date)
      comment: "Year when hold was placed"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', hold_date)
      comment: "Month when hold was placed"
    - name: "expected_release_year"
      expr: YEAR(expected_release_date)
      comment: "Year of expected release date"
    - name: "actual_release_year"
      expr: YEAR(actual_release_date)
      comment: "Year of actual release date"
  measures:
    - name: "total_quality_holds"
      expr: COUNT(1)
      comment: "Total number of quality holds placed"
    - name: "total_quantity_held"
      expr: SUM(CAST(quantity_held AS DOUBLE))
      comment: "Total quantity of material under quality hold"
    - name: "avg_quantity_per_hold"
      expr: AVG(CAST(quantity_held AS DOUBLE))
      comment: "Average quantity of material per quality hold"
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds related to regulatory compliance issues"
    - name: "distinct_lots_held"
      expr: COUNT(DISTINCT lot_id)
      comment: "Number of unique lots placed on quality hold"
    - name: "distinct_products_held"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Number of unique chemical products placed on quality hold"
    - name: "distinct_materials_held"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials placed on quality hold"
    - name: "distinct_quality_deviations_causing_hold"
      expr: COUNT(DISTINCT quality_deviation_id)
      comment: "Number of unique quality deviations that triggered holds"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_coc_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate of Conformance and Certificate of Analysis metrics tracking documentation completeness, approval cycle time, and customer-specific compliance"
  source: "`chemical_mfg_ecm`.`quality`.`coc_record`"
  dimensions:
    - name: "coc_record_status"
      expr: coc_record_status
      comment: "Status of the certificate record (e.g., Draft, Approved, Released, Archived)"
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate (e.g., COA - Certificate of Analysis, COC - Certificate of Conformance)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall test result summary (e.g., Pass, Fail, Conditional)"
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Indicates whether certificate is customized for specific customer requirements"
    - name: "is_confidential"
      expr: is_confidential
      comment: "Indicates whether certificate contains confidential information"
    - name: "is_archived"
      expr: is_archived
      comment: "Indicates whether certificate has been archived"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year when certificate was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when certificate was issued"
    - name: "approved_year"
      expr: YEAR(approved_timestamp)
      comment: "Year when certificate was approved"
    - name: "released_year"
      expr: YEAR(released_timestamp)
      comment: "Year when certificate was released to customer"
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of certificates of conformance issued"
    - name: "total_batch_quantity_certified"
      expr: SUM(CAST(batch_quantity AS DOUBLE))
      comment: "Total quantity of material certified across all certificates"
    - name: "avg_batch_quantity"
      expr: AVG(CAST(batch_quantity AS DOUBLE))
      comment: "Average batch quantity per certificate"
    - name: "certificate_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates with passing overall results"
    - name: "customer_specific_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customer_specific = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates customized for specific customer requirements"
    - name: "distinct_customers_certified"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving certificates"
    - name: "distinct_products_certified"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products certified"
    - name: "distinct_shipments_certified"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Number of unique shipments with certificates"
    - name: "distinct_inspection_lots_certified"
      expr: COUNT(DISTINCT inspection_lot_id)
      comment: "Number of unique inspection lots certified"
$$;
