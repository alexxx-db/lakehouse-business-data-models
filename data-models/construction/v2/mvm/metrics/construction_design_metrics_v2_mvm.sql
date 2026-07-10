-- Metric views for domain: design | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Information (RFI) performance and impact metrics tracking design clarification efficiency, response times, and cost/schedule impacts"
  source: "`vibe_construction_v1`.`design`.`rfi`"
  dimensions:
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI (open, closed, pending, etc.)"
    - name: "discipline"
      expr: discipline
      comment: "Engineering or design discipline associated with the RFI"
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFI (high, medium, low)"
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the RFI has cost implications"
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the RFI has schedule implications"
    - name: "raised_year"
      expr: YEAR(date_raised)
      comment: "Year the RFI was raised"
    - name: "raised_month"
      expr: DATE_TRUNC('MONTH', date_raised)
      comment: "Month the RFI was raised"
  measures:
    - name: "total_rfis"
      expr: COUNT(1)
      comment: "Total number of RFIs raised"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact amount across all RFIs in the filtered set"
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI"
    - name: "rfis_with_cost_impact"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Count of RFIs that have cost impact"
    - name: "rfis_with_schedule_impact"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Count of RFIs that have schedule impact"
    - name: "avg_response_time_days"
      expr: AVG(DATEDIFF(actual_response_date, date_raised))
      comment: "Average number of days from RFI raised to actual response"
    - name: "avg_closure_time_days"
      expr: AVG(DATEDIFF(closure_date, date_raised))
      comment: "Average number of days from RFI raised to closure"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Submittal approval performance metrics tracking review cycle times, approval rates, and cost/schedule impacts for construction submittals"
  source: "`vibe_construction_v1`.`design`.`submittal`"
  dimensions:
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (submitted, under review, approved, rejected, etc.)"
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (shop drawing, product data, sample, etc.)"
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Final approval disposition (approved, approved as noted, revise and resubmit, rejected)"
    - name: "discipline"
      expr: discipline
      comment: "Engineering or design discipline associated with the submittal"
    - name: "priority"
      expr: priority
      comment: "Priority level of the submittal"
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating whether the submittal has cost implications"
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the submittal has schedule implications"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the submittal requires regulatory compliance"
    - name: "submission_year"
      expr: YEAR(actual_submission_date)
      comment: "Year the submittal was actually submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', actual_submission_date)
      comment: "Month the submittal was actually submitted"
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total number of submittals in the filtered set"
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all submittals"
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per submittal"
    - name: "submittals_with_cost_impact"
      expr: COUNT(CASE WHEN cost_impact_flag = TRUE THEN 1 END)
      comment: "Count of submittals that have cost impact"
    - name: "submittals_with_schedule_impact"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Count of submittals that have schedule impact"
    - name: "avg_review_cycle_days"
      expr: AVG(DATEDIFF(actual_review_date, actual_submission_date))
      comment: "Average number of days from submittal submission to actual review"
    - name: "avg_closure_cycle_days"
      expr: AVG(DATEDIFF(closure_date, actual_submission_date))
      comment: "Average number of days from submittal submission to closure"
    - name: "approved_submittals"
      expr: COUNT(CASE WHEN approval_disposition IN ('Approved', 'Approved as Noted') THEN 1 END)
      comment: "Count of submittals with approved or approved-as-noted disposition"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drawing revision distribution and acknowledgment metrics tracking design change velocity, distribution effectiveness, and stakeholder engagement"
  source: "`vibe_construction_v1`.`design`.`revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the drawing revision"
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (design change, correction, clarification, etc.)"
    - name: "revision_year"
      expr: YEAR(revision_date)
      comment: "Year the revision was issued"
    - name: "revision_month"
      expr: DATE_TRUNC('MONTH', revision_date)
      comment: "Month the revision was issued"
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of drawing revisions in the filtered set"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design review effectiveness metrics tracking comment resolution, clash detection, regulatory compliance, and review cycle efficiency"
  source: "`vibe_construction_v1`.`design`.`review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the design review"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (design review, peer review, regulatory review, etc.)"
    - name: "discipline"
      expr: discipline
      comment: "Engineering or design discipline associated with the review"
    - name: "stage"
      expr: stage
      comment: "Project stage or phase during which the review occurred"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the review (approved, conditional approval, rejected, etc.)"
    - name: "clash_detection_performed"
      expr: clash_detection_performed
      comment: "Boolean flag indicating whether clash detection was performed"
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Boolean flag indicating whether client approval is required"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the review meets regulatory compliance requirements"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the review was conducted"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month the review was conducted"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of design reviews conducted"
    - name: "total_review_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total duration in hours across all reviews"
    - name: "avg_review_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration per review in hours"
    - name: "reviews_with_clash_detection"
      expr: COUNT(CASE WHEN clash_detection_performed = TRUE THEN 1 END)
      comment: "Count of reviews where clash detection was performed"
    - name: "reviews_requiring_client_approval"
      expr: COUNT(CASE WHEN client_approval_required = TRUE THEN 1 END)
      comment: "Count of reviews requiring client approval"
    - name: "reviews_meeting_regulatory_compliance"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of reviews that meet regulatory compliance requirements"
    - name: "avg_client_approval_lag_days"
      expr: AVG(DATEDIFF(client_approval_date, review_date))
      comment: "Average number of days from review date to client approval date"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workflow approval process performance metrics tracking SLA compliance, escalation rates, approval cycle times, and bottleneck identification"
  source: "`vibe_construction_v1`.`design`.`workflow_approval`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow approval process"
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of workflow (document approval, drawing approval, submittal approval, etc.)"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow (approved, rejected, conditional, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the workflow"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the workflow was escalated"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Boolean flag indicating whether the workflow met SLA targets"
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Boolean flag indicating whether the workflow is subject to regulatory requirements"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Boolean flag indicating whether notifications were sent"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the workflow was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the workflow was initiated"
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total number of workflow approvals in the filtered set"
    - name: "workflows_escalated"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of workflows that were escalated"
    - name: "workflows_meeting_sla"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of workflows that met SLA compliance targets"
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours taken to complete workflow approval"
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual hours across all workflow approvals"
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(outcome_date, initiated_date))
      comment: "Average number of days from workflow initiation to outcome"
    - name: "workflows_with_regulatory_requirement"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Count of workflows subject to regulatory requirements"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_bim_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BIM model quality and compliance metrics tracking model maturity, clash detection, ISO 19650 compliance, and coordination effectiveness"
  source: "`vibe_construction_v1`.`design`.`bim_model`"
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current status of the BIM model"
    - name: "model_type"
      expr: model_type
      comment: "Type of BIM model (architectural, structural, MEP, etc.)"
    - name: "discipline"
      expr: discipline
      comment: "Engineering or design discipline associated with the BIM model"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Project lifecycle stage of the BIM model"
    - name: "lod_classification"
      expr: lod_classification
      comment: "Level of Development (LOD) classification of the BIM model"
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Status of clash detection for the BIM model"
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Boolean flag indicating whether the BIM model complies with ISO 19650 standards"
    - name: "federation_role"
      expr: federation_role
      comment: "Role of the model in federated BIM coordination"
    - name: "authoring_software"
      expr: authoring_software
      comment: "Software used to author the BIM model"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the BIM model was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the BIM model was issued"
  measures:
    - name: "total_bim_models"
      expr: COUNT(1)
      comment: "Total number of BIM models in the filtered set"
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size in megabytes across all BIM models"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average file size per BIM model in megabytes"
    - name: "models_iso_19650_compliant"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Count of BIM models that comply with ISO 19650 standards"
    - name: "avg_origin_elevation_m"
      expr: AVG(CAST(origin_elevation_m AS DOUBLE))
      comment: "Average origin elevation in meters across BIM models"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_transmittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document transmittal effectiveness metrics tracking acknowledgment rates, delivery performance, and stakeholder communication efficiency"
  source: "`vibe_construction_v1`.`design`.`transmittal`"
  dimensions:
    - name: "transmittal_status"
      expr: transmittal_status
      comment: "Current status of the transmittal"
    - name: "purpose_of_issue"
      expr: purpose_of_issue
      comment: "Purpose for which the transmittal was issued (for approval, for information, for construction, etc.)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the transmittal (email, courier, portal, etc.)"
    - name: "discipline"
      expr: discipline
      comment: "Engineering or design discipline associated with the transmittal"
    - name: "priority"
      expr: priority
      comment: "Priority level of the transmittal"
    - name: "acknowledgement_required_flag"
      expr: acknowledgement_required_flag
      comment: "Boolean flag indicating whether acknowledgment is required"
    - name: "acknowledgement_status"
      expr: acknowledgement_status
      comment: "Status of acknowledgment (acknowledged, pending, overdue, etc.)"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the transmittal"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the transmittal was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the transmittal was issued"
  measures:
    - name: "total_transmittals"
      expr: COUNT(1)
      comment: "Total number of transmittals issued"
    - name: "transmittals_requiring_acknowledgement"
      expr: COUNT(CASE WHEN acknowledgement_required_flag = TRUE THEN 1 END)
      comment: "Count of transmittals that require acknowledgment"
    - name: "avg_acknowledgement_lag_days"
      expr: AVG(DATEDIFF(acknowledgement_date, issue_date))
      comment: "Average number of days from transmittal issue to acknowledgment"
    - name: "avg_delivery_lag_days"
      expr: AVG(DATEDIFF(due_date, issue_date))
      comment: "Average number of days from transmittal issue to due date"
$$;