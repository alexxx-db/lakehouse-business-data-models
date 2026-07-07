-- Metric views for domain: encounter | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_adt_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adt Event business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`adt_event`"
  dimensions:
    - name: "Accepting Provider Npi"
      expr: accepting_provider_npi
    - name: "Admission Source Code"
      expr: admission_source_code
    - name: "Adt Event Status"
      expr: adt_event_status
    - name: "Ama Flag"
      expr: ama_flag
    - name: "Bed Assigned Timestamp"
      expr: bed_assigned_timestamp
    - name: "Bed Request Timestamp"
      expr: bed_request_timestamp
    - name: "Cancel Reason"
      expr: cancel_reason
    - name: "Clinical Reason For Transfer"
      expr: clinical_reason_for_transfer
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discharge Disposition Code"
      expr: discharge_disposition_code
    - name: "Drg Type"
      expr: drg_type
    - name: "Emtala Compliant"
      expr: emtala_compliant
    - name: "Emtala Transfer Form Completed"
      expr: emtala_transfer_form_completed
    - name: "Event Recorded Timestamp"
      expr: event_recorded_timestamp
    - name: "Event Status"
      expr: event_status
    - name: "Event Timestamp"
      expr: event_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adt Event"
      expr: COUNT(DISTINCT adt_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed Assignment business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "Admission Date"
      expr: admission_date
    - name: "Admission Source Code"
      expr: admission_source_code
    - name: "Adt Event Type"
      expr: adt_event_type
    - name: "Assignment End Timestamp"
      expr: assignment_end_timestamp
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Assignment Start Timestamp"
      expr: assignment_start_timestamp
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Bed Assignment Status"
      expr: bed_assignment_status
    - name: "Bed Class"
      expr: bed_class
    - name: "Bed Gender Designation"
      expr: bed_gender_designation
    - name: "Bed Hold Reason"
      expr: bed_hold_reason
    - name: "Bed Request Source"
      expr: bed_request_source
    - name: "Bed Type"
      expr: bed_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discharge Date"
      expr: discharge_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bed Assignment"
      expr: COUNT(DISTINCT bed_assignment_id)
    - name: "Total Los Days"
      expr: SUM(los_days)
    - name: "Average Los Days"
      expr: AVG(los_days)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Summary business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "Activity Restrictions"
      expr: activity_restrictions
    - name: "Care Transition Plan Completed"
      expr: care_transition_plan_completed
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diet Instructions"
      expr: diet_instructions
    - name: "Discharge Condition"
      expr: discharge_condition
    - name: "Discharge Date"
      expr: discharge_date
    - name: "Discharge Disposition"
      expr: discharge_disposition
    - name: "Discharge Disposition Code"
      expr: discharge_disposition_code
    - name: "Discharge Instructions Issued"
      expr: discharge_instructions_issued
    - name: "Discharge Instructions Text"
      expr: discharge_instructions_text
    - name: "Discharge Medications Prescribed"
      expr: discharge_medications_prescribed
    - name: "Discharge Summary Number"
      expr: discharge_summary_number
    - name: "Discharge Summary Status"
      expr: discharge_summary_status
    - name: "Discharge Timestamp"
      expr: discharge_timestamp
    - name: "Discharging Provider Npi"
      expr: discharging_provider_npi
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Discharge Summary"
      expr: COUNT(DISTINCT discharge_summary_id)
    - name: "Total Time To Completion Hours"
      expr: SUM(time_to_completion_hours)
    - name: "Average Time To Completion Hours"
      expr: AVG(time_to_completion_hours)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drg Assignment business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "Admit Source Code"
      expr: admit_source_code
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Cc Mcc Flag"
      expr: cc_mcc_flag
    - name: "Cdi Query Count"
      expr: cdi_query_count
    - name: "Cdi Query Response Flag"
      expr: cdi_query_response_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discharge Status Code"
      expr: discharge_status_code
    - name: "Drg Assignment Status"
      expr: drg_assignment_status
    - name: "Drg Changed Flag"
      expr: drg_changed_flag
    - name: "Drg Description"
      expr: drg_description
    - name: "Drg Version"
      expr: drg_version
    - name: "Drg Version Number"
      expr: drg_version_number
    - name: "Finalized Timestamp"
      expr: finalized_timestamp
    - name: "Grouper Software"
      expr: grouper_software
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drg Assignment"
      expr: COUNT(DISTINCT drg_assignment_id)
    - name: "Total Actual Los"
      expr: SUM(actual_los)
    - name: "Average Actual Los"
      expr: AVG(actual_los)
    - name: "Total Arithmetic Mean Los"
      expr: SUM(arithmetic_mean_los)
    - name: "Average Arithmetic Mean Los"
      expr: AVG(arithmetic_mean_los)
    - name: "Total Base Payment Rate"
      expr: SUM(base_payment_rate)
    - name: "Average Base Payment Rate"
      expr: AVG(base_payment_rate)
    - name: "Total Drg Weight"
      expr: SUM(drg_weight)
    - name: "Average Drg Weight"
      expr: AVG(drg_weight)
    - name: "Total Expected Reimbursement"
      expr: SUM(expected_reimbursement)
    - name: "Average Expected Reimbursement"
      expr: AVG(expected_reimbursement)
    - name: "Total Geometric Mean Los"
      expr: SUM(geometric_mean_los)
    - name: "Average Geometric Mean Los"
      expr: AVG(geometric_mean_los)
    - name: "Total Initial Drg Weight"
      expr: SUM(initial_drg_weight)
    - name: "Average Initial Drg Weight"
      expr: AVG(initial_drg_weight)
    - name: "Total Outlier Payment"
      expr: SUM(outlier_payment)
    - name: "Average Outlier Payment"
      expr: AVG(outlier_payment)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Triage Assessment business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "Acuity Change Reason"
      expr: acuity_change_reason
    - name: "Ama Flag"
      expr: ama_flag
    - name: "Arrival Mode"
      expr: arrival_mode
    - name: "Chief Complaint"
      expr: chief_complaint
    - name: "Chief Complaint Code"
      expr: chief_complaint_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diastolic Bp Mmhg"
      expr: diastolic_bp_mmhg
    - name: "Door Arrival Timestamp"
      expr: door_arrival_timestamp
    - name: "Esi Level"
      expr: esi_level
    - name: "Glasgow Coma Score"
      expr: glasgow_coma_score
    - name: "Heart Rate Bpm"
      expr: heart_rate_bpm
    - name: "Interpreter Language"
      expr: interpreter_language
    - name: "Interpreter Required Flag"
      expr: interpreter_required_flag
    - name: "Isolation Required Flag"
      expr: isolation_required_flag
    - name: "Isolation Type"
      expr: isolation_type
    - name: "Lwbs Flag"
      expr: lwbs_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Triage Assessment"
      expr: COUNT(DISTINCT triage_assessment_id)
    - name: "Total Spo2 Percent"
      expr: SUM(spo2_percent)
    - name: "Average Spo2 Percent"
      expr: AVG(spo2_percent)
    - name: "Total Temperature Celsius"
      expr: SUM(temperature_celsius)
    - name: "Average Temperature Celsius"
      expr: AVG(temperature_celsius)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`visit`"
  dimensions:
    - name: "Admission Source"
      expr: admission_source
    - name: "Admission Timestamp"
      expr: admission_timestamp
    - name: "Admission Type"
      expr: admission_type
    - name: "Admitting Diagnosis Code"
      expr: admitting_diagnosis_code
    - name: "Care Setting"
      expr: care_setting
    - name: "Care Transition Plan Completed"
      expr: care_transition_plan_completed
    - name: "Consent Obtained"
      expr: consent_obtained
    - name: "Converted To Inpatient"
      expr: converted_to_inpatient
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discharge Disposition"
      expr: discharge_disposition
    - name: "Discharge Instructions Issued"
      expr: discharge_instructions_issued
    - name: "Discharge Timestamp"
      expr: discharge_timestamp
    - name: "Drg Type"
      expr: drg_type
    - name: "Emtala Compliant"
      expr: emtala_compliant
    - name: "Encounter Number"
      expr: encounter_number
    - name: "Financial Class"
      expr: financial_class
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Visit"
      expr: COUNT(DISTINCT visit_id)
    - name: "Total Drg Weight"
      expr: SUM(drg_weight)
    - name: "Average Drg Weight"
      expr: AVG(drg_weight)
    - name: "Total Expected Los Days"
      expr: SUM(expected_los_days)
    - name: "Average Expected Los Days"
      expr: AVG(expected_los_days)
    - name: "Total Observation Hours"
      expr: SUM(observation_hours)
    - name: "Average Observation Hours"
      expr: AVG(observation_hours)
    - name: "Total Readmission Risk Score"
      expr: SUM(readmission_risk_score)
    - name: "Average Readmission Risk Score"
      expr: AVG(readmission_risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit Diagnosis business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`visit_diagnosis`"
  dimensions:
    - name: "Bill Indicator"
      expr: bill_indicator
    - name: "Cc Mcc Indicator"
      expr: cc_mcc_indicator
    - name: "Chronic Condition Flag"
      expr: chronic_condition_flag
    - name: "Coded Date"
      expr: coded_date
    - name: "Coding Provider Npi"
      expr: coding_provider_npi
    - name: "Coding Status"
      expr: coding_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diagnosis Rank"
      expr: diagnosis_rank
    - name: "Diagnosis Seq Num"
      expr: diagnosis_seq_num
    - name: "Diagnosis Source"
      expr: diagnosis_source
    - name: "Diagnosis Type"
      expr: diagnosis_type
    - name: "Drg Code"
      expr: drg_code
    - name: "Drg Relevance Flag"
      expr: drg_relevance_flag
    - name: "Drg Type"
      expr: drg_type
    - name: "Encounter Diagnosis Comment"
      expr: encounter_diagnosis_comment
    - name: "Encounter Diagnosis Source Code"
      expr: encounter_diagnosis_source_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Visit Diagnosis"
      expr: COUNT(DISTINCT visit_diagnosis_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_insurance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit Insurance business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`visit_insurance`"
  dimensions:
    - name: "Authorization Effective Date"
      expr: authorization_effective_date
    - name: "Authorization Expiration Date"
      expr: authorization_expiration_date
    - name: "Authorization Number"
      expr: authorization_number
    - name: "Authorization Status"
      expr: authorization_status
    - name: "Billing Npi"
      expr: billing_npi
    - name: "Claim Form Type"
      expr: claim_form_type
    - name: "Cob Notes"
      expr: cob_notes
    - name: "Coverage Effective Date"
      expr: coverage_effective_date
    - name: "Coverage Sequence"
      expr: coverage_sequence
    - name: "Coverage Termination Date"
      expr: coverage_termination_date
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Eligibility Verification Method"
      expr: eligibility_verification_method
    - name: "Eligibility Verified Date"
      expr: eligibility_verified_date
    - name: "Financial Class"
      expr: financial_class
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Visit Insurance"
      expr: COUNT(DISTINCT visit_insurance_id)
    - name: "Total Coinsurance Rate"
      expr: SUM(coinsurance_rate)
    - name: "Average Coinsurance Rate"
      expr: AVG(coinsurance_rate)
    - name: "Total Copay Amount"
      expr: SUM(copay_amount)
    - name: "Average Copay Amount"
      expr: AVG(copay_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Deductible Met Amount"
      expr: SUM(deductible_met_amount)
    - name: "Average Deductible Met Amount"
      expr: AVG(deductible_met_amount)
    - name: "Total Out Of Pocket Max"
      expr: SUM(out_of_pocket_max)
    - name: "Average Out Of Pocket Max"
      expr: AVG(out_of_pocket_max)
    - name: "Total Out Of Pocket Met Amount"
      expr: SUM(out_of_pocket_met_amount)
    - name: "Average Out Of Pocket Met Amount"
      expr: AVG(out_of_pocket_met_amount)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit Procedure business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "Anesthesia Type"
      expr: anesthesia_type
    - name: "Asa Class"
      expr: asa_class
    - name: "Body Site"
      expr: body_site
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Charge Code"
      expr: charge_code
    - name: "Complication Description"
      expr: complication_description
    - name: "Complication Flag"
      expr: complication_flag
    - name: "Consent Obtained Flag"
      expr: consent_obtained_flag
    - name: "Cpt Code"
      expr: cpt_code
    - name: "Cpt Modifier 1"
      expr: cpt_modifier_1
    - name: "Cpt Modifier 2"
      expr: cpt_modifier_2
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drg Relevant Flag"
      expr: drg_relevant_flag
    - name: "Hcpcs Code"
      expr: hcpcs_code
    - name: "Icd10 Pcs Code"
      expr: icd10_pcs_code
    - name: "Implant Flag"
      expr: implant_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Visit Procedure"
      expr: COUNT(DISTINCT visit_procedure_id)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
    - name: "Total Rvu Total"
      expr: SUM(rvu_total)
    - name: "Average Rvu Total"
      expr: AVG(rvu_total)
    - name: "Total Rvu Work"
      expr: SUM(rvu_work)
    - name: "Average Rvu Work"
      expr: AVG(rvu_work)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit Provider business metrics"
  source: "`vibe_healthcare_v1`.`encounter`.`visit_provider`"
  dimensions:
    - name: "Admission Source Role"
      expr: admission_source_role
    - name: "Assignment End Timestamp"
      expr: assignment_end_timestamp
    - name: "Assignment Start Timestamp"
      expr: assignment_start_timestamp
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Billing Provider Npi"
      expr: billing_provider_npi
    - name: "Care Setting"
      expr: care_setting
    - name: "Care Team Sequence"
      expr: care_team_sequence
    - name: "Comments"
      expr: comments
    - name: "Cosignature Required"
      expr: cosignature_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Verified Flag"
      expr: credentialing_verified_flag
    - name: "Drg Attribution Flag"
      expr: drg_attribution_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Handoff Reference"
      expr: handoff_reference
    - name: "Is Attending Of Record"
      expr: is_attending_of_record
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Visit Provider"
      expr: COUNT(DISTINCT visit_provider_id)
    - name: "Total Rvu Work Units"
      expr: SUM(rvu_work_units)
    - name: "Average Rvu Work Units"
      expr: AVG(rvu_work_units)
$$;