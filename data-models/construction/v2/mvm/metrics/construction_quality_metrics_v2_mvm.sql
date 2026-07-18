-- Metric views for domain: quality | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-conformance report metrics tracking quality defects, cost impacts, schedule delays, and resolution effectiveness across construction projects"
  source: "`vibe_construction_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current status of the non-conformance report (open, closed, pending, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the non-conformance (critical, major, minor)"
    - name: "category"
      expr: ncr_category
      comment: "Category of non-conformance (material, workmanship, design, etc.)"
    - name: "discipline"
      expr: discipline
      comment: "Engineering or construction discipline associated with the NCR"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision (accept, reject, rework, repair, use-as-is)"
    - name: "hold_status"
      expr: hold_status
      comment: "Whether work is on hold due to this NCR"
    - name: "client_notification_required"
      expr: client_notification_required
      comment: "Whether client notification is required for this NCR"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month when the non-conformance was identified"
    - name: "closure_month"
      expr: DATE_TRUNC('MONTH', closure_date)
      comment: "Month when the NCR was closed"
    - name: "reported_by_organization"
      expr: reported_by_organization
      comment: "Organization that reported the non-conformance"
  measures:
    - name: "total_ncrs"
      expr: COUNT(ncr_id)
      comment: "Total number of non-conformance reports raised"
    - name: "total_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of all non-conformances"
    - name: "avg_cost_impact_per_ncr"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average cost impact per non-conformance report"
    - name: "total_schedule_impact_days"
      expr: SUM(CAST(schedule_impact_days AS DOUBLE))
      comment: "Total schedule delay days caused by non-conformances"
    - name: "avg_schedule_impact_days"
      expr: AVG(CAST(schedule_impact_days AS DOUBLE))
      comment: "Average schedule delay per non-conformance in days"
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of materials or work affected by non-conformances"
    - name: "ncrs_on_hold"
      expr: COUNT(CASE WHEN hold_status = TRUE THEN ncr_id END)
      comment: "Number of NCRs currently holding work"
    - name: "ncrs_requiring_client_notification"
      expr: COUNT(CASE WHEN client_notification_required = TRUE THEN ncr_id END)
      comment: "Number of NCRs requiring client notification"
    - name: "critical_severity_ncrs"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN ncr_id END)
      comment: "Number of critical severity non-conformances"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality inspection metrics tracking pass rates, defect identification, reinspection requirements, and inspection efficiency across construction activities"
  source: "`vibe_construction_v1`.`quality`.`inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (scheduled, completed, cancelled)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (hold point, witness point, surveillance, final)"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall outcome of the inspection (pass, fail, conditional)"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where inspection was performed"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on inspection findings"
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Whether a non-conformance report was raised from this inspection"
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether reinspection is required"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when the inspection was performed"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(inspection_id)
      comment: "Total number of inspections performed"
    - name: "total_items_passed"
      expr: SUM(CAST(items_passed AS DOUBLE))
      comment: "Total number of inspection items that passed"
    - name: "total_items_failed"
      expr: SUM(CAST(items_failed AS DOUBLE))
      comment: "Total number of inspection items that failed"
    - name: "total_check_items"
      expr: SUM(CAST(total_check_items AS DOUBLE))
      comment: "Total number of items checked across all inspections"
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN inspection_id END)
      comment: "Number of inspections requiring corrective action"
    - name: "inspections_with_ncr_raised"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN inspection_id END)
      comment: "Number of inspections that resulted in NCR being raised"
    - name: "inspections_requiring_reinspection"
      expr: COUNT(CASE WHEN reinspection_required = TRUE THEN inspection_id END)
      comment: "Number of inspections requiring reinspection"
    - name: "total_defects_identified"
      expr: SUM(CAST(defects_identified AS DOUBLE))
      comment: "Total number of defects identified across all inspections"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during inspections in Celsius"
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity during inspections as percentage"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list item metrics tracking deficiency closure rates, cost impacts, and completion performance for project handover readiness"
  source: "`vibe_construction_v1`.`quality`.`punch_item`"
  dimensions:
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (open, closed, in progress, rejected)"
    - name: "category"
      expr: punch_item_category
      comment: "Category of punch item (cosmetic, functional, safety, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch item (high, medium, low)"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item"
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Whether the punch item is deferred to defect liability period"
    - name: "location"
      expr: location
      comment: "Physical location of the punch item"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month when the punch item was identified"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month when the punch item was completed"
  measures:
    - name: "total_punch_items"
      expr: COUNT(punch_item_id)
      comment: "Total number of punch list items"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total cost impact of all punch items"
    - name: "avg_cost_impact_per_item"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per punch item"
    - name: "items_deferred_to_dlp"
      expr: COUNT(CASE WHEN deferred_to_dlp = TRUE THEN punch_item_id END)
      comment: "Number of punch items deferred to defect liability period"
    - name: "high_priority_items"
      expr: COUNT(CASE WHEN priority = 'High' THEN punch_item_id END)
      comment: "Number of high priority punch items"
    - name: "closed_items"
      expr: COUNT(CASE WHEN punch_item_status = 'Closed' THEN punch_item_id END)
      comment: "Number of closed punch items"
    - name: "open_items"
      expr: COUNT(CASE WHEN punch_item_status = 'Open' THEN punch_item_id END)
      comment: "Number of open punch items"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action metrics tracking resolution effectiveness, cost performance, schedule adherence, and systemic issue prevention"
  source: "`vibe_construction_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (open, in progress, completed, verified)"
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (immediate, preventive, systemic)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action"
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Whether the corrective action addresses a systemic issue"
    - name: "requires_client_approval"
      expr: requires_client_approval
      comment: "Whether client approval is required for this corrective action"
    - name: "requires_design_change"
      expr: requires_design_change
      comment: "Whether the corrective action requires a design change"
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review (effective, ineffective, partially effective)"
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month when the corrective action was assigned"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month when the corrective action was completed"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(corrective_action_id)
      comment: "Total number of corrective actions initiated"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all corrective actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action"
    - name: "total_schedule_impact_days"
      expr: SUM(CAST(schedule_impact_days AS DOUBLE))
      comment: "Total schedule impact in days from corrective actions"
    - name: "systemic_issues"
      expr: COUNT(CASE WHEN is_systemic_issue = TRUE THEN corrective_action_id END)
      comment: "Number of corrective actions addressing systemic issues"
    - name: "actions_requiring_client_approval"
      expr: COUNT(CASE WHEN requires_client_approval = TRUE THEN corrective_action_id END)
      comment: "Number of corrective actions requiring client approval"
    - name: "actions_requiring_design_change"
      expr: COUNT(CASE WHEN requires_design_change = TRUE THEN corrective_action_id END)
      comment: "Number of corrective actions requiring design changes"
    - name: "completed_actions"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN corrective_action_id END)
      comment: "Number of completed corrective actions"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_concrete_pour_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour quality metrics tracking volume, temperature compliance, slump test results, and acceptance rates for structural integrity assurance"
  source: "`vibe_construction_v1`.`quality`.`concrete_pour_record`"
  dimensions:
    - name: "pour_status"
      expr: pour_status
      comment: "Status of the concrete pour (planned, in progress, completed, rejected)"
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the concrete pour (accepted, rejected, conditional)"
    - name: "concrete_grade"
      expr: concrete_grade
      comment: "Grade specification of the concrete (e.g., C30, C40)"
    - name: "element_type"
      expr: element_type
      comment: "Type of structural element being poured (slab, column, beam, wall)"
    - name: "curing_method"
      expr: curing_method
      comment: "Method used for curing the concrete"
    - name: "slump_test_passed"
      expr: slump_test_passed
      comment: "Whether the slump test passed specification"
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Whether a non-conformance report was raised for this pour"
    - name: "pour_month"
      expr: DATE_TRUNC('MONTH', pour_date)
      comment: "Month when the concrete pour occurred"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during the pour"
    - name: "level"
      expr: concrete_pour_record_level
      comment: "Building level or elevation where pour occurred"
  measures:
    - name: "total_pours"
      expr: COUNT(concrete_pour_record_id)
      comment: "Total number of concrete pours recorded"
    - name: "total_pour_volume_m3"
      expr: SUM(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Total volume of concrete poured in cubic meters"
    - name: "avg_pour_volume_m3"
      expr: AVG(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Average pour volume per record in cubic meters"
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature in Celsius across pours"
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature in Celsius during pours"
    - name: "pours_with_slump_test_passed"
      expr: COUNT(CASE WHEN slump_test_passed = TRUE THEN concrete_pour_record_id END)
      comment: "Number of pours where slump test passed"
    - name: "pours_with_ncr_raised"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN concrete_pour_record_id END)
      comment: "Number of pours that resulted in NCR being raised"
    - name: "total_trucks_used"
      expr: SUM(CAST(number_of_trucks AS DOUBLE))
      comment: "Total number of concrete trucks used across all pours"
    - name: "total_samples_taken"
      expr: SUM(CAST(number_of_samples_taken AS DOUBLE))
      comment: "Total number of concrete samples taken for testing"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_test_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material test certificate metrics tracking pass/fail rates, certificate validity, and compliance with specifications for quality assurance"
  source: "`vibe_construction_v1`.`quality`.`test_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the test certificate (valid, expired, pending, rejected)"
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of test certificate (mill test, material test, calibration, etc.)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the test"
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested (steel, concrete, aggregate, etc.)"
    - name: "test_method"
      expr: test_method
      comment: "Test method used for certification"
    - name: "test_standard"
      expr: test_standard
      comment: "Industry standard applied for testing (ASTM, BS, ISO, etc.)"
    - name: "issuing_laboratory"
      expr: issuing_laboratory
      comment: "Laboratory that issued the test certificate"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body for the testing laboratory"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', certificate_issue_date)
      comment: "Month when the certificate was issued"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month when the test was performed"
  measures:
    - name: "total_certificates"
      expr: COUNT(test_certificate_id)
      comment: "Total number of test certificates issued"
    - name: "certificates_passed"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN test_certificate_id END)
      comment: "Number of test certificates with pass status"
    - name: "certificates_failed"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN test_certificate_id END)
      comment: "Number of test certificates with fail status"
    - name: "expired_certificates"
      expr: COUNT(CASE WHEN certificate_status = 'Expired' THEN test_certificate_id END)
      comment: "Number of expired test certificates"
    - name: "valid_certificates"
      expr: COUNT(CASE WHEN certificate_status = 'Valid' THEN test_certificate_id END)
      comment: "Number of currently valid test certificates"
$$;
