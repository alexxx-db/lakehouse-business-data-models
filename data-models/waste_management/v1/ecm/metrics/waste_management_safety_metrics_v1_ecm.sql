-- Metric views for domain: safety | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety incident metrics tracking frequency, severity, and operational impact of workplace incidents across facilities, routes, and equipment"
  source: "`waste_management_ecm`.`safety`.`incident`"
  dimensions:
    - name: "incident_date"
      expr: incident_date
      comment: "Date when the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence for trend analysis"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident occurrence"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident"
    - name: "classification"
      expr: classification
      comment: "Incident classification category"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation during which incident occurred"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident investigation and resolution"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether incident meets OSHA recordability criteria"
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the incident"
    - name: "corrective_actions_required_flag"
      expr: corrective_actions_required_flag
      comment: "Whether corrective actions are required"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents reported"
    - name: "osha_recordable_incidents"
      expr: SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable incidents for regulatory reporting"
    - name: "incidents_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_actions_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring corrective action"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days employees were away from work due to incidents"
    - name: "total_days_restricted_work"
      expr: SUM(CAST(days_of_restricted_work AS DOUBLE))
      comment: "Total days employees worked with restrictions due to incidents"
    - name: "total_estimated_incident_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated financial cost of all incidents"
    - name: "avg_estimated_incident_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per incident"
    - name: "unique_affected_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with reported incidents"
    - name: "unique_affected_vehicles"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles involved in incidents"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_osha_recordable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA recordable case metrics for regulatory compliance tracking and lost-time analysis"
  source: "`waste_management_ecm`.`safety`.`osha_recordable`"
  dimensions:
    - name: "injury_illness_date"
      expr: injury_illness_date
      comment: "Date of injury or illness"
    - name: "injury_illness_month"
      expr: DATE_TRUNC('MONTH', injury_illness_date)
      comment: "Month of injury or illness for trend analysis"
    - name: "injury_illness_year"
      expr: YEAR(injury_illness_date)
      comment: "Year of injury or illness"
    - name: "osha_case_type"
      expr: osha_case_type
      comment: "OSHA case classification type"
    - name: "injury_nature"
      expr: injury_nature
      comment: "Nature of the injury sustained"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by injury or illness"
    - name: "event_exposure_type"
      expr: event_exposure_type
      comment: "Type of event or exposure that caused the injury"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the OSHA case"
    - name: "death_flag"
      expr: death_flag
      comment: "Whether the case resulted in a fatality"
    - name: "loss_of_consciousness_flag"
      expr: loss_of_consciousness_flag
      comment: "Whether the case involved loss of consciousness"
    - name: "osha_300a_reporting_year"
      expr: osha_300a_reporting_year
      comment: "OSHA 300A reporting year for annual summary"
  measures:
    - name: "total_osha_recordable_cases"
      expr: COUNT(1)
      comment: "Total number of OSHA recordable cases"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days away from work across all OSHA cases"
    - name: "total_days_job_transfer_restriction"
      expr: SUM(CAST(days_of_job_transfer_or_restriction AS DOUBLE))
      comment: "Total days of job transfer or restriction"
    - name: "fatality_count"
      expr: SUM(CASE WHEN death_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fatalities - critical safety metric"
    - name: "cases_with_days_away"
      expr: SUM(CASE WHEN CAST(days_away_from_work AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of cases resulting in days away from work"
    - name: "cases_with_job_restriction"
      expr: SUM(CASE WHEN CAST(days_of_job_transfer_or_restriction AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of cases resulting in job transfer or restriction"
    - name: "avg_days_away_per_case"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away from work per OSHA case"
    - name: "unique_affected_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with OSHA recordable cases"
    - name: "unique_affected_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with OSHA recordable cases"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_near_miss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Near miss event metrics for proactive safety management and leading indicator analysis"
  source: "`waste_management_ecm`.`safety`.`near_miss`"
  dimensions:
    - name: "incident_date"
      expr: incident_date
      comment: "Date when near miss occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of near miss for trend analysis"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of near miss occurrence"
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard identified in near miss"
    - name: "potential_severity"
      expr: potential_severity
      comment: "Potential severity if near miss had resulted in incident"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation during near miss"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of near miss investigation"
    - name: "osha_recordable_potential_flag"
      expr: osha_recordable_potential_flag
      comment: "Whether near miss had potential to be OSHA recordable"
    - name: "ppe_adequate_flag"
      expr: ppe_adequate_flag
      comment: "Whether PPE was adequate during near miss"
  measures:
    - name: "total_near_misses"
      expr: COUNT(1)
      comment: "Total number of near miss events reported - leading safety indicator"
    - name: "near_misses_with_osha_potential"
      expr: SUM(CASE WHEN osha_recordable_potential_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of near misses that could have been OSHA recordable"
    - name: "near_misses_with_inadequate_ppe"
      expr: SUM(CASE WHEN ppe_adequate_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of near misses where PPE was inadequate"
    - name: "unique_affected_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities reporting near misses"
    - name: "unique_affected_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes with near miss events"
    - name: "unique_affected_vehicles"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of distinct vehicles involved in near misses"
    - name: "unique_reporting_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees reporting near misses - engagement indicator"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety training completion and effectiveness metrics for compliance and workforce readiness"
  source: "`waste_management_ecm`.`safety`.`safety_training_record`"
  dimensions:
    - name: "training_date"
      expr: training_date
      comment: "Date training was completed"
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month of training completion"
    - name: "training_year"
      expr: YEAR(training_date)
      comment: "Year of training completion"
    - name: "training_type"
      expr: training_type
      comment: "Type of safety training provided"
    - name: "training_course_name"
      expr: training_course_name
      comment: "Name of the training course"
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery"
    - name: "dot_required_flag"
      expr: dot_required_flag
      comment: "Whether training is DOT-required"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether training is OSHA-required"
    - name: "certificate_expiration_date"
      expr: certificate_expiration_date
      comment: "Date when training certificate expires"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of safety training records"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total hours of safety training delivered"
    - name: "avg_training_hours_per_record"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration per record"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total cost of safety training programs"
    - name: "avg_training_cost_per_record"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average cost per training record"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training - effectiveness indicator"
    - name: "unique_trained_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees who received safety training"
    - name: "unique_trained_drivers"
      expr: COUNT(DISTINCT driver_id)
      comment: "Number of distinct drivers who received safety training"
    - name: "dot_required_training_count"
      expr: SUM(CASE WHEN dot_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DOT-required training completions"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety audit performance metrics tracking compliance, findings, and corrective action effectiveness"
  source: "`waste_management_ecm`.`safety`.`audit`"
  dimensions:
    - name: "audit_date"
      expr: audit_date
      comment: "Date audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit for trend analysis"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of safety audit conducted"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation audited"
    - name: "rating"
      expr: rating
      comment: "Overall audit rating"
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Whether corrective actions are required"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Whether audit findings are regulatory reportable"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safety audits conducted"
    - name: "avg_audit_score"
      expr: AVG(CAST(overall_audit_score AS DOUBLE))
      comment: "Average audit score - overall safety performance indicator"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total minor findings across all audits"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS DOUBLE))
      comment: "Total findings across all audits"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_actions_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring corrective actions"
    - name: "regulatory_reportable_audits"
      expr: SUM(CASE WHEN regulatory_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits with regulatory reportable findings"
    - name: "unique_audited_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities audited"
    - name: "unique_audited_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes audited"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness metrics tracking closure rates, costs, and timeliness"
  source: "`waste_management_ecm`.`safety`.`corrective_action`"
  dimensions:
    - name: "target_completion_date"
      expr: target_completion_date
      comment: "Target date for corrective action completion"
    - name: "actual_completion_date"
      expr: actual_completion_date
      comment: "Actual date corrective action was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month of corrective action completion"
    - name: "completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year of corrective action completion"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of corrective action"
    - name: "action_category"
      expr: action_category
      comment: "Category of corrective action"
    - name: "action_priority"
      expr: action_priority
      comment: "Priority level of corrective action"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category identified"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Effectiveness rating of corrective action"
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether corrective action is regulatory-required"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action"
    - name: "regulatory_required_actions"
      expr: SUM(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of regulatory-required corrective actions"
    - name: "unique_affected_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with corrective actions"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety observation metrics for behavior-based safety program effectiveness and proactive hazard identification"
  source: "`waste_management_ecm`.`safety`.`observation`"
  dimensions:
    - name: "observation_date"
      expr: observation_date
      comment: "Date observation was made"
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', observation_date)
      comment: "Month of observation"
    - name: "observation_year"
      expr: YEAR(observation_date)
      comment: "Year of observation"
    - name: "observation_type"
      expr: observation_type
      comment: "Type of safety observation"
    - name: "observation_category"
      expr: observation_category
      comment: "Category of observation"
    - name: "observation_status"
      expr: observation_status
      comment: "Current status of observation"
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard observed"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of observation"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation during observation"
    - name: "ppe_compliance_flag"
      expr: ppe_compliance_flag
      comment: "Whether PPE compliance was observed"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "bbs_program_flag"
      expr: bbs_program_flag
      comment: "Whether observation is part of behavior-based safety program"
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total number of safety observations - leading indicator of safety culture"
    - name: "observations_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of observations requiring corrective action"
    - name: "ppe_non_compliance_observations"
      expr: SUM(CASE WHEN ppe_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of observations with PPE non-compliance"
    - name: "bbs_program_observations"
      expr: SUM(CASE WHEN bbs_program_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of behavior-based safety program observations"
    - name: "unique_observers"
      expr: COUNT(DISTINCT observation_observer_employee_id)
      comment: "Number of distinct employees making observations - engagement indicator"
    - name: "unique_observed_employees"
      expr: COUNT(DISTINCT observation_observed_employee_id)
      comment: "Number of distinct employees observed"
    - name: "unique_affected_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with observations"
    - name: "unique_affected_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes with observations"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`safety_medical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical case management metrics tracking treatment costs, lost time, and workers compensation claims"
  source: "`waste_management_ecm`.`safety`.`medical_case`"
  dimensions:
    - name: "initial_treatment_date"
      expr: initial_treatment_date
      comment: "Date of initial medical treatment"
    - name: "treatment_month"
      expr: DATE_TRUNC('MONTH', initial_treatment_date)
      comment: "Month of initial treatment"
    - name: "treatment_year"
      expr: YEAR(initial_treatment_date)
      comment: "Year of initial treatment"
    - name: "case_status"
      expr: case_status
      comment: "Current status of medical case"
    - name: "osha_case_classification"
      expr: osha_case_classification
      comment: "OSHA classification of the medical case"
    - name: "injury_nature"
      expr: injury_nature
      comment: "Nature of the injury"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by injury"
    - name: "treatment_type"
      expr: treatment_type
      comment: "Type of medical treatment provided"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether case is OSHA recordable"
    - name: "hospitalization_required_flag"
      expr: hospitalization_required_flag
      comment: "Whether hospitalization was required"
    - name: "surgery_required_flag"
      expr: surgery_required_flag
      comment: "Whether surgery was required"
    - name: "workers_comp_claim_status"
      expr: workers_comp_claim_status
      comment: "Status of workers compensation claim"
  measures:
    - name: "total_medical_cases"
      expr: COUNT(1)
      comment: "Total number of medical cases"
    - name: "total_actual_medical_cost"
      expr: SUM(CAST(actual_medical_cost AS DOUBLE))
      comment: "Total actual medical costs - key financial impact metric"
    - name: "total_estimated_medical_cost"
      expr: SUM(CAST(estimated_medical_cost AS DOUBLE))
      comment: "Total estimated medical costs"
    - name: "avg_actual_medical_cost"
      expr: AVG(CAST(actual_medical_cost AS DOUBLE))
      comment: "Average actual medical cost per case"
    - name: "total_days_away"
      expr: SUM(CAST(total_days_away AS DOUBLE))
      comment: "Total days away from work across all medical cases"
    - name: "total_days_restricted"
      expr: SUM(CAST(total_days_restricted AS DOUBLE))
      comment: "Total days with work restrictions"
    - name: "avg_days_away_per_case"
      expr: AVG(CAST(total_days_away AS DOUBLE))
      comment: "Average days away from work per medical case"
    - name: "cases_requiring_hospitalization"
      expr: SUM(CASE WHEN hospitalization_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases requiring hospitalization"
    - name: "cases_requiring_surgery"
      expr: SUM(CASE WHEN surgery_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases requiring surgery"
    - name: "osha_recordable_medical_cases"
      expr: SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable medical cases"
    - name: "unique_affected_employees"
      expr: COUNT(DISTINCT primary_medical_employee_id)
      comment: "Number of distinct employees with medical cases"
$$;
