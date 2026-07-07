-- Metric views for domain: encounter | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed assignment and capacity KPIs for length of stay, isolation burden, and bed placement efficiency."
  source: "`vibe_healthcare_v1`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "unit_name"
      expr: unit_name
      comment: "Nursing unit name for capacity and occupancy grouping."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed type for capacity segmentation."
    - name: "bed_class"
      expr: bed_class
      comment: "Bed class for acuity/level-of-care analysis."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class (inpatient/observation) for utilization mix."
    - name: "assignment_status"
      expr: bed_assignment_status
      comment: "Assignment status for active/closed bed cohorting."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Admission month bucket for trend analysis."
  measures:
    - name: "Bed Assignment Count"
      expr: COUNT(1)
      comment: "Total bed assignments — placement volume."
    - name: "Avg Length Of Stay Days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average length of stay per bed assignment — capacity and cost driver."
    - name: "Total Length Of Stay Days"
      expr: SUM(CAST(los_days AS DOUBLE))
      comment: "Total bed-days consumed — occupancy and capacity planning."
    - name: "Isolation Bed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_isolation_bed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments to isolation beds — infection-control capacity monitoring."
    - name: "Private Room Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_private_room = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments to private rooms — patient experience and capacity mix."
    - name: "Observation Status Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_observation_status = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments in observation status — utilization/revenue-cycle steering."
    - name: "Distinct Patients Placed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients placed in beds — reach sizing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment KPIs for case-mix index, reimbursement, outlier rates, and CDI impact steering."
  source: "`vibe_healthcare_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "mdc_description"
      expr: mdc_description
      comment: "Major diagnostic category for service-line grouping."
    - name: "drg_description"
      expr: drg_description
      comment: "DRG description for reimbursement analysis."
    - name: "patient_type"
      expr: patient_type
      comment: "Patient type for case-mix segmentation."
    - name: "assignment_status"
      expr: drg_assignment_status
      comment: "DRG assignment status for finalized/pending cohorting."
    - name: "grouping_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "DRG grouping month for trend analysis."
  measures:
    - name: "DRG Assignment Count"
      expr: COUNT(1)
      comment: "Total DRG assignments — coded inpatient volume."
    - name: "Avg DRG Weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight — case-mix index, key reimbursement/acuity KPI."
    - name: "Total Expected Reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected reimbursement — revenue forecasting."
    - name: "Total Base Payment Rate"
      expr: SUM(CAST(base_payment_rate AS DOUBLE))
      comment: "Sum of base DRG payment rates — baseline reimbursement."
    - name: "Total Outlier Payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total outlier payments — high-cost case financial exposure."
    - name: "Avg Actual LOS"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual LOS — efficiency vs geometric-mean benchmark."
    - name: "Avg Geometric Mean LOS"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average DRG geometric-mean LOS benchmark — utilization comparison."
    - name: "Outlier Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_outlier = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases flagged as outliers — cost/utilization risk."
    - name: "CC MCC Capture Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cc_mcc_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases with CC/MCC — coding completeness and reimbursement steering."
    - name: "DRG Change Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN drg_changed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of DRGs changed after initial grouping — CDI impact monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_readmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission KPIs for HRRP exposure, penalty estimation, risk stratification, and preventability steering."
  source: "`vibe_healthcare_v1`.`encounter`.`readmission`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Readmission type for classification analysis."
    - name: "hrrp_measure_category"
      expr: hrrp_measure_category
      comment: "HRRP measure category for CMS penalty program grouping."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for reimbursement/penalty segmentation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for preventability analysis."
    - name: "readmission_status"
      expr: readmission_status
      comment: "Readmission review status for workflow cohorting."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Readmission admission month for trend analysis."
  measures:
    - name: "Readmission Count"
      expr: COUNT(1)
      comment: "Total readmission events — core quality/penalty volume."
    - name: "Total Estimated Penalty Amount"
      expr: SUM(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Total estimated HRRP penalty — direct financial exposure."
    - name: "Avg HRRP Excess Readmission Ratio"
      expr: AVG(CAST(hrrp_excess_readmission_ratio AS DOUBLE))
      comment: "Average excess readmission ratio — CMS penalty driver KPI."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average readmission risk score — population risk stratification."
    - name: "HRRP Applicable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hrrp_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of readmissions subject to HRRP — penalty program exposure."
    - name: "Med Reconciliation Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed med reconciliation — transitions-of-care quality driver."
    - name: "Transition Of Care Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transition_of_care_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed transition-of-care — readmission-prevention effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ED triage KPIs for acuity mix, LWBS, sepsis/stroke/trauma alerting, and clinical safety steering."
  source: "`vibe_healthcare_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index level for acuity grouping."
    - name: "triage_category"
      expr: triage_category
      comment: "Triage category for prioritization analysis."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Arrival mode for ED throughput segmentation."
    - name: "triage_status"
      expr: triage_status
      comment: "Triage status for workflow cohorting."
    - name: "triage_month"
      expr: DATE_TRUNC('MONTH', triage_timestamp)
      comment: "Triage month for trend analysis."
  measures:
    - name: "Triage Assessment Count"
      expr: COUNT(1)
      comment: "Total triage assessments — ED throughput volume."
    - name: "LWBS Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lwbs_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Left-without-being-seen rate — ED access and revenue-loss KPI."
    - name: "Sepsis Alert Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sepsis_alert_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with sepsis alert — early-recognition clinical quality."
    - name: "Stroke Alert Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN stroke_alert_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with stroke alert — time-critical care activation monitoring."
    - name: "Trauma Activation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN trauma_activation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with trauma activation — trauma-center resource demand."
    - name: "Interpreter Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent requiring interpreter — health-equity and access planning."
    - name: "Mental Health Flag Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mental_health_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with behavioral health concern — BH service demand steering."
    - name: "Distinct ED Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients triaged — ED reach sizing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge summary KPIs for documentation timeliness, med reconciliation, and transitions-of-care compliance."
  source: "`vibe_healthcare_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for transitions analysis."
    - name: "discharge_condition"
      expr: discharge_condition
      comment: "Patient condition at discharge for outcome grouping."
    - name: "summary_status"
      expr: summary_status
      comment: "Summary status for documentation-workflow cohorting."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Discharge month for trend analysis."
  measures:
    - name: "Discharge Summary Count"
      expr: COUNT(1)
      comment: "Total discharge summaries — discharge documentation volume."
    - name: "Avg Time To Completion Hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average hours to complete summary — documentation timeliness KPI."
    - name: "Med Reconciliation Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed med reconciliation — safety and readmission-prevention driver."
    - name: "Follow Up Scheduled Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_scheduled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with follow-up scheduled — transitions-of-care quality."
    - name: "Care Transition Plan Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_transition_plan_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed care-transition plan — continuity-of-care monitoring."
    - name: "Home Health Referral Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN home_health_referral_made = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with home-health referral — post-acute care coordination."
    - name: "Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of summaries meeting compliance criteria — regulatory documentation quality."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Encounter authorization KPIs for denial rates, authorized dollars, and peer-to-peer/appeal steering."
  source: "`vibe_healthcare_v1`.`encounter`.`encounter_authorization`"
  dimensions:
    - name: "authorization_type"
      expr: authorization_type
      comment: "Authorization type for utilization-management grouping."
    - name: "authorization_status"
      expr: encounter_authorization_status
      comment: "Authorization status for approved/denied cohorting."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level for prioritization analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for root-cause analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_submitted_timestamp)
      comment: "Request submission month for trend analysis."
  measures:
    - name: "Authorization Count"
      expr: COUNT(1)
      comment: "Total authorization requests — utilization-management volume."
    - name: "Total Authorized Amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized dollars — revenue-cycle exposure."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN encounter_authorization_status = 'DENIED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations denied — denial-management KPI driving appeals."
    - name: "Peer To Peer Review Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN peer_to_peer_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent escalated to peer-to-peer review — UM effort/cost monitoring."
    - name: "Distinct Authorized Visits"
      expr: COUNT(DISTINCT visit_id)
      comment: "Unique visits with authorization activity — coverage reach."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_transfer_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient transfer KPIs for EMTALA compliance, denial/cancellation rates, and transfer coordination steering."
  source: "`vibe_healthcare_v1`.`encounter`.`transfer_request`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Transfer type for coordination analysis."
    - name: "transfer_status"
      expr: transfer_request_status
      comment: "Transfer request status for workflow cohorting."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Acuity level for resource/risk segmentation."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Transfer reason code for root-cause analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Transfer request month for trend analysis."
  measures:
    - name: "Transfer Request Count"
      expr: COUNT(1)
      comment: "Total transfer requests — inter-facility coordination volume."
    - name: "EMTALA Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN emtala_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transfers EMTALA-compliant — regulatory risk KPI."
    - name: "EMTALA Certification Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN emtala_certification_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed EMTALA certification — documentation compliance."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with patient consent — patient-rights compliance."
    - name: "Bed Availability Confirmation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN bed_availability_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with confirmed bed availability — transfer readiness."
    - name: "Medical Records Sent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_records_sent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with records sent — care-continuity completeness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit diagnosis KPIs for HCC/HAI capture, POA rates, and coding-quality steering."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Diagnosis type (principal/secondary) for coding grouping."
    - name: "diagnosis_source"
      expr: diagnosis_source
      comment: "Diagnosis source for provenance analysis."
    - name: "coding_status"
      expr: coding_status
      comment: "Coding status for workflow cohorting."
    - name: "hcc_category_code"
      expr: hcc_category_code
      comment: "HCC category code for risk-adjustment analysis."
    - name: "coded_month"
      expr: DATE_TRUNC('MONTH', coded_date)
      comment: "Coded month for trend analysis."
  measures:
    - name: "Diagnosis Count"
      expr: COUNT(1)
      comment: "Total coded diagnoses — coding volume."
    - name: "HCC Capture Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hcc_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged as HCC — risk-adjustment revenue capture KPI."
    - name: "HAI Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hai_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged as hospital-acquired infection — patient-safety quality KPI."
    - name: "Chronic Condition Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent chronic conditions — population-health complexity."
    - name: "Quality Measure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_measure_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent tied to a quality measure — value-based-care reporting."
    - name: "SDOH Flag Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with social-determinant codes — health-equity/z-code capture."
    - name: "Distinct Diagnosed Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with coded diagnoses — reach sizing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit procedure KPIs for RVU productivity, charges, complication rates, and surgical safety steering."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Procedure type for service-line grouping."
    - name: "procedure_status"
      expr: visit_procedure_status
      comment: "Procedure status for completed/cancelled cohorting."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for OR resource analysis."
    - name: "asa_class"
      expr: asa_class
      comment: "ASA physical status class for surgical risk segmentation."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Procedure month for trend analysis."
  measures:
    - name: "Procedure Count"
      expr: COUNT(1)
      comment: "Total procedures — surgical/procedural volume."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total procedure charges — revenue-cycle KPI."
    - name: "Total Work RVU"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs — provider productivity measure."
    - name: "Total RVU"
      expr: SUM(CAST(rvu_total AS DOUBLE))
      comment: "Total RVUs — resource intensity and productivity."
    - name: "Complication Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN complication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with complications — surgical-quality/safety KPI."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cancelled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of procedures cancelled — OR efficiency and access."
    - name: "Timeout Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_performed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with surgical timeout performed — patient-safety compliance."
    - name: "Implant Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN implant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent involving implants — device cost and recall exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit provider KPIs for provider productivity, telehealth adoption, and credentialing compliance."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_provider`"
  dimensions:
    - name: "provider_role"
      expr: provider_role
      comment: "Provider role for care-team analysis."
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type for workforce segmentation."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type for staffing analysis."
    - name: "specialty_at_assignment"
      expr: specialty_at_assignment
      comment: "Specialty at assignment for service-line grouping."
    - name: "assignment_status"
      expr: visit_provider_status
      comment: "Assignment status for active/closed cohorting."
  measures:
    - name: "Visit Provider Count"
      expr: COUNT(1)
      comment: "Total provider assignments to visits — staffing volume."
    - name: "Total Work RVU Units"
      expr: SUM(CAST(rvu_work_units AS DOUBLE))
      comment: "Total work RVU units — provider productivity KPI."
    - name: "Telehealth Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments via telehealth — virtual-care adoption KPI."
    - name: "Credentialing Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with verified credentialing — compliance/patient-safety KPI."
    - name: "Locum Tenens Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN locum_tenens_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments filled by locum tenens — staffing-gap and cost monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit coverage KPIs for eligibility verification, in-network rates, and patient financial responsibility steering."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_coverage`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Insurance plan name for payer-mix grouping."
    - name: "network_status"
      expr: network_status
      comment: "Network status (in/out) for reimbursement analysis."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status for coverage-verification cohorting."
    - name: "coverage_status"
      expr: visit_coverage_status
      comment: "Coverage record status for active/terminated grouping."
  measures:
    - name: "Coverage Record Count"
      expr: COUNT(1)
      comment: "Total visit coverage records — coverage volume."
    - name: "Total Copay Amount"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay dollars — patient financial responsibility."
    - name: "Avg Deductible Met Amount"
      expr: AVG(CAST(deductible_met_amount AS DOUBLE))
      comment: "Average deductible met — patient out-of-pocket progression."
    - name: "Total Out Of Pocket Met"
      expr: SUM(CAST(out_of_pocket_met_amount AS DOUBLE))
      comment: "Total out-of-pocket met — collectibility/financial-clearance steering."
    - name: "In Network Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN network_status = 'IN_NETWORK' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent in-network — reimbursement optimization KPI."
    - name: "Eligibility Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN eligibility_status = 'VERIFIED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with verified eligibility — front-end revenue-cycle KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_adt_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADT event KPIs for bed-turnaround timeliness, isolation burden, AMA rate, and EMTALA transfer compliance."
  source: "`vibe_healthcare_v1`.`encounter`.`adt_event`"
  dimensions:
    - name: "event_type_description"
      expr: event_type_description
      comment: "ADT event type description for movement analysis."
    - name: "patient_class_code"
      expr: patient_class_code
      comment: "Patient class code for utilization grouping."
    - name: "level_of_care_code"
      expr: level_of_care_code
      comment: "Level of care for acuity analysis."
    - name: "event_status"
      expr: event_status
      comment: "Event status for workflow cohorting."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "ADT event month for trend analysis."
  measures:
    - name: "ADT Event Count"
      expr: COUNT(1)
      comment: "Total ADT events — patient-movement volume."
    - name: "AMA Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ama_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Against-medical-advice rate — patient-safety and readmission-risk KPI."
    - name: "Isolation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN isolation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events involving isolation — infection-control capacity monitoring."
    - name: "Readmission Risk Flag Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN readmission_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged high readmission risk — proactive intervention targeting."
    - name: "EMTALA Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN emtala_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transfer events EMTALA-compliant — regulatory risk KPI."
    - name: "Distinct Visits Moved"
      expr: COUNT(DISTINCT visit_id)
      comment: "Unique visits with ADT activity — movement reach."
$$;