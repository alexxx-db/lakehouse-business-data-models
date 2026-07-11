-- Metric views for domain: care | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:17:51

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_barrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Barrier business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`barrier`"
  dimensions:
    - name: "Care Manager Assigned Date"
      expr: care_manager_assigned_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Barrier Description"
      expr: barrier_description
    - name: "Documentation Source"
      expr: documentation_source
    - name: "Expected Resolution Date"
      expr: expected_resolution_date
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Geographic Location"
      expr: geographic_location
    - name: "Hcc Impact"
      expr: hcc_impact
    - name: "Identification Source"
      expr: identification_source
    - name: "Identification Timestamp"
      expr: identification_timestamp
    - name: "Intervention Applied"
      expr: intervention_applied
    - name: "Intervention Type"
      expr: intervention_type
    - name: "Is Critical"
      expr: is_critical
    - name: "Notes"
      expr: notes
    - name: "Resolution Date"
      expr: resolution_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Barrier"
      expr: COUNT(DISTINCT barrier_id)
    - name: "Total Impact Score"
      expr: SUM(impact_score)
    - name: "Average Impact Score"
      expr: AVG(impact_score)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cahps Survey business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`cahps_survey`"
  dimensions:
    - name: "Administration Method"
      expr: administration_method
    - name: "Composite Score Flag"
      expr: composite_score_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "External Survey Code"
      expr: external_survey_code
    - name: "Is Test Survey"
      expr: is_test_survey
    - name: "Member Age"
      expr: member_age
    - name: "Member Gender"
      expr: member_gender
    - name: "Member State"
      expr: member_state
    - name: "Member Zip"
      expr: member_zip
    - name: "Notes"
      expr: notes
    - name: "Regulatory Reporting Flag"
      expr: regulatory_reporting_flag
    - name: "Response Deadline"
      expr: response_deadline
    - name: "Sample Size"
      expr: sample_size
    - name: "Sampling Frame"
      expr: sampling_frame
    - name: "Survey End Date"
      expr: survey_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cahps Survey"
      expr: COUNT(DISTINCT cahps_survey_id)
    - name: "Total Customer Service Score"
      expr: SUM(customer_service_score)
    - name: "Average Customer Service Score"
      expr: AVG(customer_service_score)
    - name: "Total Doctor Communication Score"
      expr: SUM(doctor_communication_score)
    - name: "Average Doctor Communication Score"
      expr: AVG(doctor_communication_score)
    - name: "Total Getting Care Quickly Score"
      expr: SUM(getting_care_quickly_score)
    - name: "Average Getting Care Quickly Score"
      expr: AVG(getting_care_quickly_score)
    - name: "Total Getting Needed Care Score"
      expr: SUM(getting_needed_care_score)
    - name: "Average Getting Needed Care Score"
      expr: AVG(getting_needed_care_score)
    - name: "Total Overall Satisfaction Score"
      expr: SUM(overall_satisfaction_score)
    - name: "Average Overall Satisfaction Score"
      expr: AVG(overall_satisfaction_score)
    - name: "Total Response Rate"
      expr: SUM(response_rate)
    - name: "Average Response Rate"
      expr: AVG(response_rate)
    - name: "Total Star Rating Impact Score"
      expr: SUM(star_rating_impact_score)
    - name: "Average Star Rating Impact Score"
      expr: AVG(star_rating_impact_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care Enrollment business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`care_enrollment`"
  dimensions:
    - name: "Acuity Level"
      expr: acuity_level
    - name: "Care Manager Assigned Date"
      expr: care_manager_assigned_date
    - name: "Consent Status"
      expr: consent_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disenrollment Date"
      expr: disenrollment_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Notes"
      expr: notes
    - name: "Program Tier"
      expr: program_tier
    - name: "Reason"
      expr: reason
    - name: "Status Reason"
      expr: status_reason
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Care Enrollment"
      expr: COUNT(DISTINCT care_enrollment_id)
    - name: "Total Hcc Score"
      expr: SUM(hcc_score)
    - name: "Average Hcc Score"
      expr: AVG(hcc_score)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care Plan business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "Barriers To Care"
      expr: barriers_to_care
    - name: "Creation Timestamp"
      expr: creation_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "High Risk Flag"
      expr: high_risk_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Plan Name"
      expr: plan_name
    - name: "Plan Number"
      expr: plan_number
    - name: "Plan Type"
      expr: plan_type
    - name: "Privacy Consent Flag"
      expr: privacy_consent_flag
    - name: "Progress Notes"
      expr: progress_notes
    - name: "Care Plan Status"
      expr: care_plan_status
    - name: "Version"
      expr: version
    - name: "Creation Timestamp Month"
      expr: DATE_TRUNC('MONTH', creation_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Care Plan"
      expr: COUNT(DISTINCT care_plan_id)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition Registry business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Condition Category"
      expr: condition_category
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Description"
      expr: condition_description
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hcc Code"
      expr: hcc_code
    - name: "Identification Date"
      expr: identification_date
    - name: "Identification Method"
      expr: identification_method
    - name: "Is Chronic"
      expr: is_chronic
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Notes"
      expr: notes
    - name: "Onset Date"
      expr: onset_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Condition Registry"
      expr: COUNT(DISTINCT condition_registry_id)
    - name: "Total Raf Score"
      expr: SUM(raf_score)
    - name: "Average Raf Score"
      expr: AVG(raf_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordinator business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`coordinator`"
  dimensions:
    - name: "Assigned Lob"
      expr: assigned_lob
    - name: "Caseload Capacity"
      expr: caseload_capacity
    - name: "Certification Codes"
      expr: certification_codes
    - name: "Current Caseload Count"
      expr: current_caseload_count
    - name: "Email Address"
      expr: email_address
    - name: "Employment Status"
      expr: employment_status
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
    - name: "Hire Date"
      expr: hire_date
    - name: "Last Name"
      expr: last_name
    - name: "Last Training Date"
      expr: last_training_date
    - name: "Notes"
      expr: notes
    - name: "Organization Unit"
      expr: organization_unit
    - name: "Phone Number"
      expr: phone_number
    - name: "Primary Contact Method"
      expr: primary_contact_method
    - name: "Record Audit Created"
      expr: record_audit_created
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coordinator"
      expr: COUNT(DISTINCT coordinator_id)
    - name: "Total Caseload Weight"
      expr: SUM(caseload_weight)
    - name: "Average Caseload Weight"
      expr: AVG(caseload_weight)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordinator Assignment business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`coordinator_assignment`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Priority"
      expr: assignment_priority
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Assignment Source"
      expr: assignment_source
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Notes"
      expr: notes
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coordinator Assignment"
      expr: COUNT(DISTINCT coordinator_assignment_id)
    - name: "Total Caseload Weight"
      expr: SUM(caseload_weight)
    - name: "Average Caseload Weight"
      expr: AVG(caseload_weight)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_dme_coordination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dme Coordination business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`dme_coordination`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Coordination Reason"
      expr: coordination_reason
    - name: "Coordination Status"
      expr: coordination_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Dme Model"
      expr: dme_model
    - name: "Dme Serial Number"
      expr: dme_serial_number
    - name: "Dme Type"
      expr: dme_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Notes"
      expr: follow_up_notes
    - name: "Last Status Change Timestamp"
      expr: last_status_change_timestamp
    - name: "Notes"
      expr: notes
    - name: "Order Date"
      expr: order_date
    - name: "Prior Authorization Number"
      expr: prior_authorization_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dme Coordination"
      expr: COUNT(DISTINCT dme_coordination_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gap business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "Actual Resolution Date"
      expr: actual_resolution_date
    - name: "Clinical Category"
      expr: clinical_category
    - name: "Close Date"
      expr: close_date
    - name: "Closure Method"
      expr: closure_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Gap Description"
      expr: gap_description
    - name: "Documentation Status"
      expr: documentation_status
    - name: "Hedis Measure Code"
      expr: hedis_measure_code
    - name: "Is Critical"
      expr: is_critical
    - name: "Open Date"
      expr: open_date
    - name: "Priority Level"
      expr: priority_level
    - name: "Gap Status"
      expr: gap_status
    - name: "Target Date"
      expr: target_date
    - name: "Gap Type"
      expr: gap_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Actual Resolution Date Month"
      expr: DATE_TRUNC('MONTH', actual_resolution_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gap"
      expr: COUNT(DISTINCT gap_id)
    - name: "Total Measure Target Value"
      expr: SUM(measure_target_value)
    - name: "Average Measure Target Value"
      expr: AVG(measure_target_value)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gap Obligation business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`gap_obligation`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Reporting Period"
      expr: reporting_period
    - name: "Reporting Period Month"
      expr: DATE_TRUNC('MONTH', reporting_period)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gap Obligation"
      expr: COUNT(DISTINCT gap_obligation_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hedis Measure business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`hedis_measure`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Collection Methodology"
      expr: data_collection_methodology
    - name: "Denominator Definition"
      expr: denominator_definition
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligible Population Criteria"
      expr: eligible_population_criteria
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measure Code"
      expr: measure_code
    - name: "Measure Denominator Logic"
      expr: measure_denominator_logic
    - name: "Measure Description"
      expr: measure_description
    - name: "Measure Domain"
      expr: measure_domain
    - name: "Measure Exclusion Logic"
      expr: measure_exclusion_logic
    - name: "Measure Last Reviewed Date"
      expr: measure_last_reviewed_date
    - name: "Measure Last Updated By"
      expr: measure_last_updated_by
    - name: "Measure Name"
      expr: measure_name
    - name: "Measure Notes"
      expr: measure_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hedis Measure"
      expr: COUNT(DISTINCT hedis_measure_id)
    - name: "Total Measure National Benchmark"
      expr: SUM(measure_national_benchmark)
    - name: "Average Measure National Benchmark"
      expr: AVG(measure_national_benchmark)
    - name: "Total Measure State Benchmark"
      expr: SUM(measure_state_benchmark)
    - name: "Average Measure State Benchmark"
      expr: AVG(measure_state_benchmark)
    - name: "Total Measure Target Value"
      expr: SUM(measure_target_value)
    - name: "Average Measure Target Value"
      expr: AVG(measure_target_value)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hedis Result business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "Audit Created"
      expr: audit_created
    - name: "Audit Updated"
      expr: audit_updated
    - name: "Collection Method"
      expr: collection_method
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Data Source"
      expr: data_source
    - name: "Denominator Criteria Met"
      expr: denominator_criteria_met
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Exclusion Reason"
      expr: exclusion_reason
    - name: "Is Excluded"
      expr: is_excluded
    - name: "Measure Category"
      expr: measure_category
    - name: "Measure Type"
      expr: measure_type
    - name: "Measure Version"
      expr: measure_version
    - name: "Measurement Year"
      expr: measurement_year
    - name: "Numerator Criteria Met"
      expr: numerator_criteria_met
    - name: "Result Timestamp"
      expr: result_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hedis Result"
      expr: COUNT(DISTINCT hedis_result_id)
    - name: "Total Measure Score"
      expr: SUM(measure_score)
    - name: "Average Measure Score"
      expr: AVG(measure_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hra business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`hra`"
  dimensions:
    - name: "Answered Questions"
      expr: answered_questions
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Assessment Version"
      expr: assessment_version
    - name: "Community Resource Referrals"
      expr: community_resource_referrals
    - name: "Completion Channel"
      expr: completion_channel
    - name: "Compliance Cms Required"
      expr: compliance_cms_required
    - name: "Compliance Ncqa Required"
      expr: compliance_ncqa_required
    - name: "Identified Health Risks"
      expr: identified_health_risks
    - name: "Notes"
      expr: notes
    - name: "Questionnaire Version"
      expr: questionnaire_version
    - name: "Recommended Programs"
      expr: recommended_programs
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Risk Tier"
      expr: risk_tier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hra"
      expr: COUNT(DISTINCT hra_id)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Risk Score Percentile"
      expr: SUM(risk_score_percentile)
    - name: "Average Risk Score Percentile"
      expr: AVG(risk_score_percentile)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_measure_obligation_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measure Obligation Mapping business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`measure_obligation_mapping`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Reporting Year"
      expr: reporting_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Measure Obligation Mapping"
      expr: COUNT(DISTINCT measure_obligation_mapping_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Outreach business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`member_outreach`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Compliance Consent Obtained"
      expr: compliance_consent_obtained
    - name: "Consent Obtained Date"
      expr: consent_obtained_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Follow Up Due Date"
      expr: follow_up_due_date
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Is Automated"
      expr: is_automated
    - name: "Language Preference"
      expr: language_preference
    - name: "Outcome"
      expr: outcome
    - name: "Outcome Timestamp"
      expr: outcome_timestamp
    - name: "Outreach Duration Seconds"
      expr: outreach_duration_seconds
    - name: "Outreach Notes"
      expr: outreach_notes
    - name: "Outreach Timestamp"
      expr: outreach_timestamp
    - name: "Purpose"
      expr: purpose
    - name: "Member Outreach Status"
      expr: member_outreach_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Outreach"
      expr: COUNT(DISTINCT member_outreach_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_risk_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Risk Tier business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`member_risk_tier`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Chronic Condition Flag"
      expr: chronic_condition_flag
    - name: "Claims Count Last Year"
      expr: claims_count_last_year
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Demographic Group"
      expr: demographic_group
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Inclusion Criteria"
      expr: inclusion_criteria
    - name: "Is Current"
      expr: is_current
    - name: "Model Type"
      expr: model_type
    - name: "Next Reassessment Date"
      expr: next_reassessment_date
    - name: "Notes"
      expr: notes
    - name: "Pmpm Cost Band"
      expr: pmpm_cost_band
    - name: "Recommended Care Program"
      expr: recommended_care_program
    - name: "Risk Score Source"
      expr: risk_score_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Risk Tier"
      expr: COUNT(DISTINCT member_risk_tier_id)
    - name: "Total Hcc Score"
      expr: SUM(hcc_score)
    - name: "Average Hcc Score"
      expr: AVG(hcc_score)
    - name: "Total Risk Factor Weight"
      expr: SUM(risk_factor_weight)
    - name: "Average Risk Factor Weight"
      expr: AVG(risk_factor_weight)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan Goal business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`plan_goal`"
  dimensions:
    - name: "Actual Date"
      expr: actual_date
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Goal Category"
      expr: goal_category
    - name: "Goal Code"
      expr: goal_code
    - name: "Goal Name"
      expr: goal_name
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Priority"
      expr: priority
    - name: "Progress Notes"
      expr: progress_notes
    - name: "Plan Goal Status"
      expr: plan_goal_status
    - name: "Target Date"
      expr: target_date
    - name: "Target Unit"
      expr: target_unit
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Actual Date Month"
      expr: DATE_TRUNC('MONTH', actual_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plan Goal"
      expr: COUNT(DISTINCT plan_goal_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_population_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population Segment business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`population_segment`"
  dimensions:
    - name: "Audit Created By"
      expr: audit_created_by
    - name: "Audit Updated By"
      expr: audit_updated_by
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Inclusion Criteria Description"
      expr: inclusion_criteria_description
    - name: "Is Default"
      expr: is_default
    - name: "Last Run Timestamp"
      expr: last_run_timestamp
    - name: "Last Run User"
      expr: last_run_user
    - name: "Pmpm Cost Band"
      expr: pmpm_cost_band
    - name: "Recommended Care Program"
      expr: recommended_care_program
    - name: "Risk Tier"
      expr: risk_tier
    - name: "Segment Code"
      expr: segment_code
    - name: "Segment Description"
      expr: segment_description
    - name: "Segment Name"
      expr: segment_name
    - name: "Segment Owner Role"
      expr: segment_owner_role
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Population Segment"
      expr: COUNT(DISTINCT population_segment_id)
    - name: "Total Average Pmpm Cost"
      expr: SUM(average_pmpm_cost)
    - name: "Average Average Pmpm Cost"
      expr: AVG(average_pmpm_cost)
    - name: "Total Population Count"
      expr: SUM(population_count)
    - name: "Average Population Count"
      expr: AVG(population_count)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`program`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Program Category"
      expr: program_category
    - name: "Clinical Protocol"
      expr: clinical_protocol
    - name: "Program Code"
      expr: program_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Program Description"
      expr: program_description
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Date"
      expr: end_date
    - name: "Enrollment End Date"
      expr: enrollment_end_date
    - name: "Enrollment Start Date"
      expr: enrollment_start_date
    - name: "Evidence Source"
      expr: evidence_source
    - name: "Hcc Included"
      expr: hcc_included
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program"
      expr: COUNT(DISTINCT program_id)
    - name: "Total Enrollment Cap"
      expr: SUM(enrollment_cap)
    - name: "Average Enrollment Cap"
      expr: AVG(enrollment_cap)
    - name: "Total Enrollment Current"
      expr: SUM(enrollment_current)
    - name: "Average Enrollment Current"
      expr: AVG(enrollment_current)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Accreditation business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`program_accreditation`"
  dimensions:
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Accreditation Type"
      expr: accreditation_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Accreditation"
      expr: COUNT(DISTINCT program_accreditation_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Enrollment business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`program_enrollment`"
  dimensions:
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Enrollment"
      expr: COUNT(DISTINCT program_enrollment_id)
    - name: "Total Enrollment Cap"
      expr: SUM(enrollment_cap)
    - name: "Average Enrollment Cap"
      expr: AVG(enrollment_cap)
    - name: "Total Participation Rate"
      expr: SUM(participation_rate)
    - name: "Average Participation Rate"
      expr: AVG(participation_rate)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_obligation_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Obligation Mapping business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`program_obligation_mapping`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Obligation Mapping"
      expr: COUNT(DISTINCT program_obligation_mapping_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_question_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Question Set business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`question_set`"
  dimensions:
    - name: "Administration Mode"
      expr: administration_mode
    - name: "Approval Date"
      expr: approval_date
    - name: "Branching Logic Flag"
      expr: branching_logic_flag
    - name: "Question Set Category"
      expr: question_set_category
    - name: "Clinical Domain"
      expr: clinical_domain
    - name: "Question Set Code"
      expr: question_set_code
    - name: "Consent Required Flag"
      expr: consent_required_flag
    - name: "Question Set Description"
      expr: question_set_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Estimated Completion Minutes"
      expr: estimated_completion_minutes
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Frequency Requirement"
      expr: frequency_requirement
    - name: "Hcc Raf Relevance Flag"
      expr: hcc_raf_relevance_flag
    - name: "Hedis Measure Alignment"
      expr: hedis_measure_alignment
    - name: "Hipaa Sensitivity Level"
      expr: hipaa_sensitivity_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Question Set"
      expr: COUNT(DISTINCT question_set_id)
    - name: "Total Maximum Score"
      expr: SUM(maximum_score)
    - name: "Average Maximum Score"
      expr: AVG(maximum_score)
    - name: "Total Minimum Score"
      expr: SUM(minimum_score)
    - name: "Average Minimum Score"
      expr: AVG(minimum_score)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_questionnaire`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Questionnaire business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`questionnaire`"
  dimensions:
    - name: "Approval By"
      expr: approval_by
    - name: "Approval Comments"
      expr: approval_comments
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Questionnaire Code"
      expr: questionnaire_code
    - name: "Questionnaire Description"
      expr: questionnaire_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Assessment"
      expr: is_assessment
    - name: "Is Current"
      expr: is_current
    - name: "Is Customizable"
      expr: is_customizable
    - name: "Is Default"
      expr: is_default
    - name: "Is Form"
      expr: is_form
    - name: "Is Legacy"
      expr: is_legacy
    - name: "Is Obsolete"
      expr: is_obsolete
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Questionnaire"
      expr: COUNT(DISTINCT questionnaire_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_sdoh_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sdoh Assessment business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`sdoh_assessment`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Version"
      expr: assessment_version
    - name: "Confidentiality Consent Flag"
      expr: confidentiality_consent_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Follow Up Due Date"
      expr: follow_up_due_date
    - name: "Follow Up Status"
      expr: follow_up_status
    - name: "Notes"
      expr: notes
    - name: "Referral Made Flag"
      expr: referral_made_flag
    - name: "Referral Resource"
      expr: referral_resource
    - name: "Risk Level"
      expr: risk_level
    - name: "Screening Tool"
      expr: screening_tool
    - name: "Sdoh Domain"
      expr: sdoh_domain
    - name: "Sdoh Assessment Status"
      expr: sdoh_assessment_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assessment Date Month"
      expr: DATE_TRUNC('MONTH', assessment_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sdoh Assessment"
      expr: COUNT(DISTINCT sdoh_assessment_id)
    - name: "Total Assessment Score"
      expr: SUM(assessment_score)
    - name: "Average Assessment Score"
      expr: AVG(assessment_score)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_snf_stay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Snf Stay business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`snf_stay`"
  dimensions:
    - name: "Admission Diagnosis Code"
      expr: admission_diagnosis_code
    - name: "Admission Diagnosis Description"
      expr: admission_diagnosis_description
    - name: "Admission Timestamp"
      expr: admission_timestamp
    - name: "Care Gap Flag"
      expr: care_gap_flag
    - name: "Concurrent Review Schedule Date"
      expr: concurrent_review_schedule_date
    - name: "Currency Code"
      expr: currency_code
    - name: "Discharge Destination"
      expr: discharge_destination
    - name: "Discharge Planning Status"
      expr: discharge_planning_status
    - name: "Discharge Timestamp"
      expr: discharge_timestamp
    - name: "Drg Code"
      expr: drg_code
    - name: "Is Eligible For Medicare"
      expr: is_eligible_for_medicare
    - name: "Is Eligible For Medicare Advantage"
      expr: is_eligible_for_medicare_advantage
    - name: "Length Of Stay Days"
      expr: length_of_stay_days
    - name: "Notes"
      expr: notes
    - name: "Patient Condition At Admission"
      expr: patient_condition_at_admission
    - name: "Readmission Reason"
      expr: readmission_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Snf Stay"
      expr: COUNT(DISTINCT snf_stay_id)
    - name: "Total Hcc Score"
      expr: SUM(hcc_score)
    - name: "Average Hcc Score"
      expr: AVG(hcc_score)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
    - name: "Total Total Adjustment Amount"
      expr: SUM(total_adjustment_amount)
    - name: "Average Total Adjustment Amount"
      expr: AVG(total_adjustment_amount)
    - name: "Total Total Charge Amount"
      expr: SUM(total_charge_amount)
    - name: "Average Total Charge Amount"
      expr: AVG(total_charge_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_star_rating_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Star Rating Result business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`star_rating_result`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Domain Star Score"
      expr: domain_star_score
    - name: "Improvement Measure Flag"
      expr: improvement_measure_flag
    - name: "Measure Name"
      expr: measure_name
    - name: "Measurement Year"
      expr: measurement_year
    - name: "Notes"
      expr: notes
    - name: "Overall Star Rating"
      expr: overall_star_rating
    - name: "Plan Type"
      expr: plan_type
    - name: "Quality Bonus Eligible"
      expr: quality_bonus_eligible
    - name: "Rating Name"
      expr: rating_name
    - name: "Rating Status"
      expr: rating_status
    - name: "Star Domain"
      expr: star_domain
    - name: "Star Score"
      expr: star_score
    - name: "Trend Direction"
      expr: trend_direction
    - name: "Trend Star Score"
      expr: trend_star_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Star Rating Result"
      expr: COUNT(DISTINCT star_rating_result_id)
    - name: "Total Cutpoint 1 Star"
      expr: SUM(cutpoint_1_star)
    - name: "Average Cutpoint 1 Star"
      expr: AVG(cutpoint_1_star)
    - name: "Total Cutpoint 2 Star"
      expr: SUM(cutpoint_2_star)
    - name: "Average Cutpoint 2 Star"
      expr: AVG(cutpoint_2_star)
    - name: "Total Cutpoint 3 Star"
      expr: SUM(cutpoint_3_star)
    - name: "Average Cutpoint 3 Star"
      expr: AVG(cutpoint_3_star)
    - name: "Total Cutpoint 4 Star"
      expr: SUM(cutpoint_4_star)
    - name: "Average Cutpoint 4 Star"
      expr: AVG(cutpoint_4_star)
    - name: "Total Cutpoint 5 Star"
      expr: SUM(cutpoint_5_star)
    - name: "Average Cutpoint 5 Star"
      expr: AVG(cutpoint_5_star)
    - name: "Total Measure Weight"
      expr: SUM(measure_weight)
    - name: "Average Measure Weight"
      expr: AVG(measure_weight)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`team`"
  dimensions:
    - name: "Audit Created By"
      expr: audit_created_by
    - name: "Audit Updated By"
      expr: audit_updated_by
    - name: "Behavioral Health Provider Count"
      expr: behavioral_health_provider_count
    - name: "Team Code"
      expr: team_code
    - name: "Communication Preference"
      expr: communication_preference
    - name: "Community Health Worker Count"
      expr: community_health_worker_count
    - name: "Consent Obtained Date"
      expr: consent_obtained_date
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Method"
      expr: contact_method
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hcc Included"
      expr: hcc_included
    - name: "Hcc Version"
      expr: hcc_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team"
      expr: COUNT(DISTINCT team_id)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transition business metrics"
  source: "`vibe_health_insurance_v1`.`care`.`transition`"
  dimensions:
    - name: "Care Gap Flag"
      expr: care_gap_flag
    - name: "Compliance Consent Obtained"
      expr: compliance_consent_obtained
    - name: "Concurrent Review Schedule Date"
      expr: concurrent_review_schedule_date
    - name: "Consent Obtained Date"
      expr: consent_obtained_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discharge Planning Status"
      expr: discharge_planning_status
    - name: "Dme Coordination Status"
      expr: dme_coordination_status
    - name: "Dme Delivery Date"
      expr: dme_delivery_date
    - name: "Dme Equipment Type"
      expr: dme_equipment_type
    - name: "Dme Order Date"
      expr: dme_order_date
    - name: "Dme Ordering Supplier Npi"
      expr: dme_ordering_supplier_npi
    - name: "Duration Days"
      expr: duration_days
    - name: "Follow Up Schedule Date"
      expr: follow_up_schedule_date
    - name: "From Setting"
      expr: from_setting
    - name: "Is Critical Transition"
      expr: is_critical_transition
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transition"
      expr: COUNT(DISTINCT transition_id)
    - name: "Total Hcc Risk Factor"
      expr: SUM(hcc_risk_factor)
    - name: "Average Hcc Risk Factor"
      expr: AVG(hcc_risk_factor)
    - name: "Total Readmission Risk Score"
      expr: SUM(readmission_risk_score)
    - name: "Average Readmission Risk Score"
      expr: AVG(readmission_risk_score)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;