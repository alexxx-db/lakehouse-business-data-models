-- Metric views for domain: consent | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent records — the SSOT for patient consent lifecycle. Enables leadership to monitor consent capture completeness, revocation rates, witness/interpreter compliance, and HIPAA authorization coverage that directly drive regulatory risk and care-access decisions."
  source: "`vibe_healthcare_v1`.`consent`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Lifecycle state of the consent (active, expired, revoked, pending) — primary segmentation for compliance dashboards."
    - name: "consent_type"
      expr: consent_type
      comment: "Type/category of consent (treatment, research, HIPAA, etc.) used to compare capture and revocation across consent programs."
    - name: "consent_decision"
      expr: consent_decision
      comment: "Patient's recorded decision (granted/declined) — used to track opt-in vs opt-out rates."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (electronic, wet signature, verbal) — steers e-signature adoption programs."
    - name: "consent_obtained_month"
      expr: DATE_TRUNC('MONTH', consent_obtained_datetime)
      comment: "Month consent was obtained — trend axis for consent volume and compliance over time."
  measures:
    - name: "Total Consent Records"
      expr: COUNT(1)
      comment: "Total number of consent records — denominator for all consent compliance and coverage rates."
    - name: "Distinct Patients With Consent"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients who have at least one consent record — measures consent coverage across the patient population."
    - name: "Revoked Consent Count"
      expr: COUNT(CASE WHEN consent_revocation_datetime IS NOT NULL THEN 1 END)
      comment: "Consents that have been revoked — a leading indicator of patient trust and data-sharing risk."
    - name: "Revocation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_revocation_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of consents revoked — leadership watches this to intervene on communication or trust issues."
    - name: "HIPAA Authorization Coverage Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_authorization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of consents carrying a valid HIPAA authorization — direct compliance KPI for privacy audits."
    - name: "Witness Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN witness_required_flag = TRUE AND witness_signature_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN witness_required_flag = TRUE THEN 1 END),0),2)
      comment: "Of consents requiring a witness, percent that captured a witness signature — closes a common audit gap."
    - name: "Capacity Assessment Completion Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_assessment_performed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of consents with a documented capacity assessment — flags decisional-capacity documentation risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_revocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent revocations. Revocation processing speed and legal-review completeness are operational risk indicators leadership uses to ensure disclosures are halted and data access restricted promptly."
  source: "`vibe_healthcare_v1`.`consent`.`revocation`"
  dimensions:
    - name: "revocation_status"
      expr: revocation_status
      comment: "Processing status of the revocation — segments backlog vs completed work."
    - name: "revocation_reason"
      expr: reason
      comment: "Stated reason for revocation — informs root-cause analysis of why patients withdraw consent."
    - name: "revocation_month"
      expr: DATE_TRUNC('MONTH', revocation_date)
      comment: "Month of revocation — trend axis for revocation volume."
  measures:
    - name: "Total Revocations"
      expr: COUNT(1)
      comment: "Total revocation requests — baseline volume for revocation operations."
    - name: "Data Access Restricted Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_access_restricted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of revocations where downstream data access was actually restricted — critical enforcement KPI."
    - name: "Disclosures Halted Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disclosures_halted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of revocations that halted ongoing disclosures — measures follow-through on patient wishes."
    - name: "Legal Review Completion Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_required_flag = TRUE AND legal_review_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END),0),2)
      comment: "Of revocations requiring legal review, percent completed — surfaces legal bottlenecks."
    - name: "Patient Notification Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of revocations where the patient was notified of processing — patient-experience compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_expiration_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent expiration alerts. SLA breach and resolution rates drive staffing and workflow decisions to prevent care-impacting consent lapses."
  source: "`vibe_healthcare_v1`.`consent`.`expiration_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the expiration alert — separates open, escalated, and resolved work."
    - name: "alert_priority"
      expr: alert_priority
      comment: "Priority tier of the alert — used to focus staff on high-urgency consent expirations."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of expiration alert — segments alert volume by trigger category."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_generation_date)
      comment: "Month the alert was generated — trend axis for alert workload."
  measures:
    - name: "Total Alerts"
      expr: COUNT(1)
      comment: "Total expiration alerts generated — baseline workload for consent renewal operations."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of alerts breaching SLA — directly triggers staffing and workflow escalation decisions."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of alerts escalated — signals process friction and unresolved consent risk."
    - name: "Care Impact Alert Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of alerts flagged as care-impacting — prioritizes clinically urgent consent lapses."
    - name: "Notification Delivery Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of alerts with a notification sent — measures outreach reliability for renewals."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent documentation deficiencies. Remediation and escalation rates are quality/compliance KPIs that surface systemic documentation gaps for corrective action."
  source: "`vibe_healthcare_v1`.`consent`.`deficiency`"
  dimensions:
    - name: "deficiency_status"
      expr: deficiency_status
      comment: "Status of the deficiency — separates open, remediated, and waived items."
    - name: "deficiency_type"
      expr: deficiency_type
      comment: "Type of deficiency — categorizes documentation gaps for root-cause review."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the deficiency — used to prioritize remediation effort."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the deficiency was discovered — trend axis for quality monitoring."
  measures:
    - name: "Total Deficiencies"
      expr: COUNT(1)
      comment: "Total documented consent deficiencies — baseline quality volume."
    - name: "Remediation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE AND remediation_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END),0),2)
      comment: "Of deficiencies requiring remediation, percent remediated — measures closure of compliance gaps."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of deficiencies requiring escalation — flags severity of documentation problems."
    - name: "Patient Safety Impact Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of deficiencies with patient-safety impact — high-priority signal for leadership intervention."
    - name: "Regulatory Impact Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of deficiencies with regulatory impact — quantifies audit/regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_disclosure_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over PHI disclosure logging. Minimum-necessary application and accounting-of-disclosure rates are core HIPAA compliance KPIs for privacy governance."
  source: "`vibe_healthcare_v1`.`consent`.`disclosure_log`"
  dimensions:
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure record — segments processing state."
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "Category of disclosure purpose (TPO vs non-TPO) — key privacy segmentation."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient receiving PHI — used to monitor external vs internal disclosures."
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_date)
      comment: "Month of disclosure — trend axis for disclosure volume."
  measures:
    - name: "Total Disclosures"
      expr: COUNT(1)
      comment: "Total PHI disclosures logged — baseline for privacy monitoring."
    - name: "Distinct Patients Disclosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients whose PHI was disclosed — measures breadth of disclosure exposure."
    - name: "Minimum Necessary Applied Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN minimum_necessary_applied = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of disclosures applying the minimum-necessary standard — core HIPAA compliance KPI."
    - name: "Accounting Required Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_accounting_required = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of disclosures requiring accounting-of-disclosure — sizes the accounting obligation."
    - name: "Non TPO Disclosure Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_tpo_disclosure = FALSE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of disclosures that are NOT for treatment/payment/operations — these carry higher authorization risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent verification checks at point of care/exchange. Compliance and override rates directly measure whether active consents are honored before PHI use."
  source: "`vibe_healthcare_v1`.`consent`.`consent_verification`"
  dimensions:
    - name: "verification_result"
      expr: verification_result
      comment: "Outcome of the verification check — passes vs fails segmentation."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify consent — compares automated vs manual verification."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent being verified — segments verification by consent program."
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_timestamp)
      comment: "Month of verification — trend axis for verification activity."
  measures:
    - name: "Total Verifications"
      expr: COUNT(1)
      comment: "Total consent verification checks — baseline volume for point-of-use enforcement."
    - name: "Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of verifications flagged compliant — headline consent-enforcement KPI."
    - name: "Override Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of verifications overridden — overrides bypass consent and are a governance red flag."
    - name: "Restriction Encounter Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restriction_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of verifications hitting a patient restriction — sizes operational impact of restrictions."
    - name: "Avg Verification Duration Seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average verification latency in seconds — measures friction the consent check adds to workflows."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent-collection sessions. Completion rate and interpreter usage steer patient-experience and language-access (Title VI) investments."
  source: "`vibe_healthcare_v1`.`consent`.`consent_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the consent session — completed vs abandoned segmentation."
    - name: "session_type"
      expr: session_type
      comment: "Type of consent session — segments by workflow context."
    - name: "consent_collection_channel"
      expr: consent_collection_channel
      comment: "Channel used to collect consent (portal, kiosk, in-person) — steers digital consent adoption."
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month the session started — trend axis for session volume."
  measures:
    - name: "Total Sessions"
      expr: COUNT(1)
      comment: "Total consent-collection sessions — baseline throughput of consent operations."
    - name: "All Consents Obtained Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN all_consents_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of sessions where all required consents were captured — session completion KPI."
    - name: "Interpreter Required Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of sessions requiring an interpreter — sizes language-access demand for staffing."
    - name: "Regulatory Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of sessions meeting regulatory compliance — surfaces process gaps for remediation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_translation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over consent translation/interpretation services. Cost, LEP compliance, and Title VI compliance rates inform language-access budget and vendor decisions."
  source: "`vibe_healthcare_v1`.`consent`.`consent_translation`"
  dimensions:
    - name: "interpreter_type"
      expr: interpreter_type
      comment: "Type of interpreter/translation service — compares in-person vs remote vs vendor."
    - name: "target_language_name"
      expr: target_language_name
      comment: "Target language of translation — identifies highest-demand languages for resourcing."
    - name: "translation_method"
      expr: translation_method
      comment: "Method of translation — segments delivery approach."
    - name: "translation_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of translation service — trend axis for language-access demand."
  measures:
    - name: "Total Translations"
      expr: COUNT(1)
      comment: "Total translation/interpretation events — baseline language-access volume."
    - name: "Total Translation Cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of translation services — direct spend leadership manages for language access."
    - name: "Avg Translation Cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per translation event — unit-economics input for vendor negotiations."
    - name: "Avg Duration Minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per translation session — capacity-planning input."
    - name: "Title VI Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN title_vi_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of translations meeting Title VI compliance — civil-rights compliance KPI."
    - name: "LEP Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lep_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of translations meeting Limited-English-Proficiency compliance — regulatory access KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_amendment_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over patient record amendment requests (HIPAA right to amend). Approval/denial and extension rates measure responsiveness to patient rights requests."
  source: "`vibe_healthcare_v1`.`consent`.`amendment_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Status of the amendment request — open, decided, withdrawn segmentation."
    - name: "organization_decision"
      expr: organization_decision
      comment: "Organization's decision on the amendment (approved/denied) — outcome segmentation."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment requested — categorizes request drivers."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of request — trend axis for patient-rights request volume."
  measures:
    - name: "Total Amendment Requests"
      expr: COUNT(1)
      comment: "Total record amendment requests — baseline for patient-rights workload."
    - name: "Extension Granted Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of requests where a response extension was granted — signals throughput/timeliness pressure."
    - name: "Third Party Notification Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_notification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of amendments requiring third-party notification — sizes downstream propagation effort."
    - name: "Distinct Patients Requesting"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients submitting amendment requests — measures reach of the patient-rights process."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over decisional capacity assessments. Reassessment and surrogate-engagement rates are clinical-ethics KPIs ensuring consent is obtained from capable decision-makers."
  source: "`vibe_healthcare_v1`.`consent`.`capacity_assessment`"
  dimensions:
    - name: "capacity_determination"
      expr: capacity_determination
      comment: "Outcome of the capacity assessment (has capacity / lacks capacity) — core clinical segmentation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment — completed vs pending."
    - name: "assessment_tool_used"
      expr: assessment_tool_used
      comment: "Standardized tool used for the assessment — supports methodology consistency review."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — trend axis for capacity-assessment volume."
  measures:
    - name: "Total Assessments"
      expr: COUNT(1)
      comment: "Total capacity assessments performed — baseline clinical-ethics workload."
    - name: "Avg Capacity Score"
      expr: AVG(CAST(capacity_score AS DOUBLE))
      comment: "Average standardized capacity score — trends decisional-capacity of the assessed population."
    - name: "Surrogate Engaged Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN surrogate_decision_maker_engaged_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of assessments engaging a surrogate decision-maker — ensures proper consent chain for incapacitated patients."
    - name: "Reassessment Recommended Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reassessment_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of assessments recommending reassessment — drives follow-up scheduling and workload forecasting."
    - name: "Ethics Consultation Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethics_consultation_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of assessments obtaining ethics consultation — sizes complex-case ethics involvement."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy inventory metrics to monitor consent policy lifecycle and governance."
  source: "`vibe_healthcare_v1`.`consent`.`consent_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (e.g., Active, Inactive)."
    - name: "consent_category"
      expr: consent_category
      comment: "High‑level category of the consent (e.g., Treatment, Research)."
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_date)
      comment: "Date the policy became effective."
    - name: "expiration_date"
      expr: DATE_TRUNC('day', expiration_date)
      comment: "Date the policy expires."
    - name: "applicable_facility_types"
      expr: applicable_facility_types
      comment: "Facility types to which the policy applies."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of consent policies defined."
    - name: "active_policies"
      expr: SUM(CASE WHEN policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of policies currently active."
    - name: "revocation_allowed_policies"
      expr: SUM(CASE WHEN revocation_allowed_flag THEN 1 ELSE 0 END)
      comment: "Policies that allow revocation by the patient."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_research_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research consent participation metrics to gauge patient enrollment in studies."
  source: "`vibe_healthcare_v1`.`consent`.`research_consent`"
  dimensions:
    - name: "research_study_id"
      expr: research_study_id
      comment: "Identifier of the research study associated with the consent."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the research consent was recorded."
  measures:
    - name: "total_research_consents"
      expr: COUNT(1)
      comment: "Total research consent records captured."
    - name: "patients_with_consent"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients who have provided research consent."
$$;