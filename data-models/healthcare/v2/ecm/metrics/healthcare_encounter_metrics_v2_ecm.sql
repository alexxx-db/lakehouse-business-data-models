-- Metric views for domain: encounter | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_readmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission tracking KPIs supporting HRRP penalty management and preventability analysis."
  source: "`vibe_healthcare_v1`.`encounter`.`readmission`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Type of readmission for classification and reporting."
    - name: "readmission_status"
      expr: readmission_status
      comment: "Status of the readmission review workflow."
    - name: "hrrp_measure_category"
      expr: hrrp_measure_category
      comment: "HRRP measure category for penalty-cohort analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category to prioritize prevention initiatives."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for payer-specific readmission analysis."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of readmission for trend monitoring."
  measures:
    - name: "Total Readmissions"
      expr: COUNT(1)
      comment: "Total readmission events — baseline for penalty and quality tracking."
    - name: "Distinct Patients Readmitted"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients readmitted — measures affected population."
    - name: "Total Estimated Penalty Amount"
      expr: SUM(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Total estimated HRRP penalty exposure — direct financial risk indicator."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average readmission risk score — targets high-risk intervention."
    - name: "Avg Excess Readmission Ratio"
      expr: AVG(CAST(hrrp_excess_readmission_ratio AS DOUBLE))
      comment: "Average HRRP excess readmission ratio — the core CMS penalty metric."
    - name: "HRRP Applicable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hrrp_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of readmissions subject to HRRP — scopes penalty exposure."
    - name: "Med Reconciliation Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed medication reconciliation — preventability lever."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed management and patient-flow KPIs for capacity utilization and throughput steering."
  source: "`vibe_healthcare_v1`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "bed_type"
      expr: bed_type
      comment: "Type of bed for capacity-mix analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the bed assignment for occupancy analysis."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class (inpatient/observation) for flow segmentation."
    - name: "unit_name"
      expr: unit_name
      comment: "Nursing unit name for unit-level utilization."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for capacity trending."
  measures:
    - name: "Total Bed Assignments"
      expr: COUNT(1)
      comment: "Total bed assignments — baseline for occupancy and turnover."
    - name: "Distinct Patients Assigned"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with bed assignments — census reach."
    - name: "Avg Length of Stay Days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average length of stay in days — throughput and capacity efficiency driver."
    - name: "Isolation Bed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_isolation_bed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments to isolation beds — infection-control capacity indicator."
    - name: "Observation Status Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_observation_status = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent in observation status — revenue integrity and status-management indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization KPIs for denial management and revenue-cycle steering."
  source: "`vibe_healthcare_v1`.`encounter`.`encounter_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the authorization for approval/denial funnel analysis."
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization for workflow segmentation."
    - name: "service_type"
      expr: service_type
      comment: "Service type requiring authorization for service-line analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the authorization request."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_submitted_timestamp)
      comment: "Month of authorization request for trend monitoring."
  measures:
    - name: "Total Authorizations"
      expr: COUNT(1)
      comment: "Total authorization requests — baseline for revenue-cycle volume."
    - name: "Total Authorized Amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized dollar amount — approved reimbursement pipeline."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_status = 'Denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations denied — direct revenue-leakage indicator."
    - name: "Peer To Peer Review Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN peer_to_peer_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent requiring peer-to-peer review — administrative burden indicator."
    - name: "Extension Requested Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN extension_requested_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with extension requests — length-of-stay authorization pressure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge documentation KPIs for care-transition quality and timeliness steering."
  source: "`vibe_healthcare_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "summary_status"
      expr: summary_status
      comment: "Status of the discharge summary for completion tracking."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for post-acute transition analysis."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge for trended reporting."
  measures:
    - name: "Total Discharge Summaries"
      expr: COUNT(1)
      comment: "Total discharge summaries — baseline documentation volume."
    - name: "Avg Time To Completion Hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average hours to complete discharge summary — documentation timeliness and compliance driver."
    - name: "Med Reconciliation Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed medication reconciliation — care-transition safety metric."
    - name: "Follow Up Scheduled Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_scheduled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with scheduled follow-up — readmission-prevention transition quality."
    - name: "Care Transition Plan Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_transition_plan_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed care-transition plans — CMS transition-of-care compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency department triage KPIs for acuity, throughput, and left-without-being-seen steering."
  source: "`vibe_healthcare_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index level for acuity-mix analysis."
    - name: "triage_category"
      expr: triage_category
      comment: "Triage category for volume and staffing analysis."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of arrival for operational planning."
    - name: "triage_status"
      expr: triage_status
      comment: "Status of the triage assessment."
    - name: "triage_month"
      expr: DATE_TRUNC('MONTH', triage_timestamp)
      comment: "Month of triage for ED volume trending."
  measures:
    - name: "Total Triage Assessments"
      expr: COUNT(1)
      comment: "Total triage assessments — baseline ED throughput volume."
    - name: "LWBS Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lwbs_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent leaving without being seen — key ED access and lost-revenue indicator."
    - name: "Sepsis Alert Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sepsis_alert_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent triggering sepsis alerts — clinical quality and rapid-response indicator."
    - name: "Trauma Activation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN trauma_activation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with trauma activations — resource-intensive case indicator."
    - name: "Avg Pain Score"
      expr: AVG(CAST(spo2_percent AS DOUBLE))
      comment: "Average SpO2 percent at triage — respiratory acuity monitoring signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_transfer_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient transfer KPIs for EMTALA compliance and transfer-cycle-time steering."
  source: "`vibe_healthcare_v1`.`encounter`.`transfer_request`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the transfer request for workflow analysis."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer for operational segmentation."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Acuity level for resource-planning analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month of transfer request for trend monitoring."
  measures:
    - name: "Total Transfer Requests"
      expr: COUNT(1)
      comment: "Total transfer requests — baseline transfer volume."
    - name: "EMTALA Compliant Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN emtala_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of EMTALA-compliant transfers — regulatory risk indicator."
    - name: "Bed Availability Confirmed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN bed_availability_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with confirmed destination bed — transfer-readiness operational metric."
    - name: "Patient Consent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with obtained patient consent — compliance and quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment KPIs for case-mix index, reimbursement, and CDI steering."
  source: "`vibe_healthcare_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the DRG assignment."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of DRG assignment for workflow analysis."
    - name: "patient_type"
      expr: patient_type
      comment: "Patient type for case-mix segmentation."
    - name: "mdc_description"
      expr: mdc_description
      comment: "Major diagnostic category description for service-line analysis."
    - name: "grouping_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "Month of DRG grouping for trend reporting."
  measures:
    - name: "Total DRG Assignments"
      expr: COUNT(1)
      comment: "Total DRG assignments — baseline coding volume."
    - name: "Avg DRG Weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight (case-mix index) — core acuity and reimbursement driver."
    - name: "Total Expected Reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected reimbursement — revenue pipeline indicator."
    - name: "Total Outlier Payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total outlier payment — high-cost case reimbursement tracking."
    - name: "CC MCC Capture Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cc_mcc_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with CC/MCC — CDI documentation-capture quality metric."
    - name: "DRG Changed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN drg_changed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of DRGs changed after review — CDI intervention effectiveness."
$$;