-- Metric views for domain: consent | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent capture session KPIs measuring completion, understanding confirmation, interpreter usage, and channel/modality mix. Steers operational efficiency and compliance quality of the consenting workflow."
  source: "`vibe_healthcare_v1`.`consent`.`consent_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Lifecycle status of the consent session (e.g. completed, in-progress, cancelled)."
    - name: "session_channel"
      expr: session_channel
      comment: "Channel through which the session was conducted (portal, in-person, phone)."
    - name: "session_mode"
      expr: session_mode
      comment: "Mode of the consent session (electronic, paper, verbal)."
    - name: "session_type"
      expr: session_type
      comment: "Type/category of consent session."
    - name: "session_outcome"
      expr: session_outcome
      comment: "Recorded outcome of the consent session."
    - name: "language_code"
      expr: language_code
      comment: "Language in which the session was conducted."
    - name: "behavioral_health_protected"
      expr: behavioral_health_protected_flag
      comment: "Whether the session involves 42 CFR Part 2 / behavioral health protected data."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month bucket of session date for trending."
  measures:
    - name: "Consent Session Count"
      expr: COUNT(1)
      comment: "Total number of consent sessions — volume baseline for consenting throughput."
    - name: "Distinct Patients Consented"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients engaged in consent sessions — reach of consent operations."
    - name: "Understanding Confirmed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_understanding_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of sessions where patient understanding was confirmed — quality/compliance signal for informed consent."
    - name: "Signature Capture Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of sessions with a captured signature — completion quality of the consent process."
    - name: "Interpreter Utilization Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN interpreter_used = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of sessions using an interpreter — language access / health equity indicator."
    - name: "Witness Present Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN witness_present = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of sessions with a witness present — regulatory documentation completeness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_hipaa_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA authorization KPIs measuring signature obtainment, active vs expired posture, personal representative use, and behavioral-health protected mix. Steers privacy compliance and audit readiness."
  source: "`vibe_healthcare_v1`.`consent`.`hipaa_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the HIPAA authorization."
    - name: "authorization_purpose"
      expr: authorization_purpose
      comment: "Purpose category of the authorization (treatment, research, marketing)."
    - name: "phi_category"
      expr: phi_category
      comment: "Category of PHI covered by the authorization."
    - name: "signature_method"
      expr: signature_method
      comment: "Method used to obtain signature (electronic, wet)."
    - name: "behavioral_health_protected"
      expr: behavioral_health_protected_flag
      comment: "Whether authorization covers behavioral health protected data (42 CFR Part 2)."
    - name: "signed_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month bucket of the signed date for trending."
  measures:
    - name: "HIPAA Authorization Count"
      expr: COUNT(1)
      comment: "Total HIPAA authorizations — volume baseline for privacy authorization workload."
    - name: "Distinct Authorized Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with a HIPAA authorization — coverage of authorized disclosure."
    - name: "Signature Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations with signature obtained — compliance completeness of authorization capture."
    - name: "Expired Authorization Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiration_date < CURRENT_DATE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations already past expiration — risk indicator for disclosures against expired consent."
    - name: "Personal Representative Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN personal_representative_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations executed by a personal representative — verification/audit focus area."
    - name: "Behavioral Health Protected Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN behavioral_health_protected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations touching 42 CFR Part 2 protected data — elevated compliance scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_disclosure_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PHI disclosure KPIs measuring accounting-of-disclosures obligations, minimum-necessary adherence, TPO vs non-TPO mix, and patient notification. Core HIPAA accountability metrics."
  source: "`vibe_healthcare_v1`.`consent`.`disclosure_log`"
  dimensions:
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure event."
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "Category of disclosure purpose (treatment, payment, operations, legal)."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient receiving the PHI."
    - name: "disclosure_method"
      expr: disclosure_method
      comment: "Method of disclosure (electronic, fax, mail)."
    - name: "behavioral_health_protected"
      expr: behavioral_health_protected_flag
      comment: "Whether the disclosure involved behavioral health protected data."
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_date)
      comment: "Month bucket of disclosure date for trending."
  measures:
    - name: "Disclosure Event Count"
      expr: COUNT(1)
      comment: "Total PHI disclosure events — baseline for disclosure volume and audit scope."
    - name: "Distinct Patients Disclosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients whose PHI was disclosed — breadth of disclosure activity."
    - name: "Accounting Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_accounting_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of disclosures requiring accounting-of-disclosures — HIPAA reporting obligation load."
    - name: "Minimum Necessary Applied Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN minimum_necessary_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of disclosures where minimum-necessary standard was applied — privacy compliance quality."
    - name: "Non TPO Disclosure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_tpo_disclosure = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of disclosures that are NOT treatment/payment/operations — these generally require patient authorization and carry higher risk."
    - name: "Patient Notification Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of disclosures requiring patient notification — tracks notification obligation backlog."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent documentation deficiency KPIs measuring open backlog, escalations, resolution posture, and overdue items. Steers HIM/compliance remediation operations."
  source: "`vibe_healthcare_v1`.`consent`.`deficiency`"
  dimensions:
    - name: "deficiency_status"
      expr: deficiency_status
      comment: "Current status of the deficiency (open, resolved, escalated)."
    - name: "deficiency_type"
      expr: deficiency_type
      comment: "Type/category of documentation deficiency."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the deficiency."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution state of the deficiency."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month bucket of when the deficiency was identified for trending."
  measures:
    - name: "Deficiency Count"
      expr: COUNT(1)
      comment: "Total consent documentation deficiencies — remediation workload baseline."
    - name: "Escalated Deficiency Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deficiencies escalated — signals severity and process breakdown."
    - name: "Resolved Deficiency Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deficiencies with a resolution date — closure/throughput of remediation."
    - name: "Overdue Deficiency Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_date < CURRENT_DATE AND resolution_date IS NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deficiencies past due date and still unresolved — compliance risk backlog."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_revocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent revocation KPIs measuring volume, enforcement timeliness (data access restriction, disclosure halting), legal review, and patient notification. Steers privacy enforcement responsiveness."
  source: "`vibe_healthcare_v1`.`consent`.`revocation`"
  dimensions:
    - name: "revocation_status"
      expr: revocation_status
      comment: "Status of the revocation request."
    - name: "revocation_reason"
      expr: revocation_reason
      comment: "Stated reason for the revocation."
    - name: "method"
      expr: method
      comment: "Method by which the revocation was submitted."
    - name: "behavioral_health_protected"
      expr: behavioral_health_protected_flag
      comment: "Whether the revocation involves behavioral health protected data."
    - name: "revocation_month"
      expr: DATE_TRUNC('MONTH', revocation_date)
      comment: "Month bucket of revocation date for trending."
  measures:
    - name: "Revocation Count"
      expr: COUNT(1)
      comment: "Total consent revocations — baseline for revocation volume and enforcement demand."
    - name: "Distinct Patients Revoking"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients who revoked consent — patient trust / churn signal."
    - name: "Disclosures Halted Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disclosures_halted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of revocations where disclosures were halted — enforcement effectiveness."
    - name: "Data Access Restricted Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_access_restricted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of revocations resulting in restricted data access — enforcement completeness."
    - name: "Legal Review Completed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of revocations with completed legal review — governance oversight coverage."
    - name: "Patient Notification Sent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of revocations where patient notification was sent — closing-the-loop compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_restriction_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient restriction-request KPIs measuring approval outcomes, out-of-pocket payment verification, system enforcement, and behavioral-health protection. Steers HIPAA right-to-restrict operations."
  source: "`vibe_healthcare_v1`.`consent`.`restriction_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Status of the restriction request."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction requested."
    - name: "organization_decision"
      expr: organization_decision
      comment: "Organization's decision on the restriction request."
    - name: "restricted_phi_category"
      expr: restricted_phi_category
      comment: "PHI category subject to the restriction."
    - name: "behavioral_health_protected"
      expr: behavioral_health_protected_flag
      comment: "Whether the restriction covers behavioral health protected data."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month bucket of request date for trending."
  measures:
    - name: "Restriction Request Count"
      expr: COUNT(1)
      comment: "Total restriction requests — baseline demand for right-to-restrict processing."
    - name: "Distinct Patients Requesting"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients requesting restrictions — reach of restriction activity."
    - name: "Out Of Pocket Payment Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_pocket_payment_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of restrictions with verified out-of-pocket payment — mandatory-restriction eligibility validation."
    - name: "System Enforced Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN system_enforcement_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of restrictions enforced by system controls — automation/enforcement effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_substance_use_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "42 CFR Part 2 substance-use disclosure consent KPIs measuring Part 2 coverage, active/revoked posture, redisclosure notice compliance. Steers SUD confidentiality governance."
  source: "`vibe_healthcare_v1`.`consent`.`substance_use_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Status of the substance-use disclosure consent."
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Purpose of the authorized disclosure."
    - name: "expiration_condition"
      expr: expiration_condition
      comment: "Condition governing consent expiration."
    - name: "signed_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month bucket of the signed date for trending."
  measures:
    - name: "Substance Use Consent Count"
      expr: COUNT(1)
      comment: "Total substance-use disclosure consents — baseline for 42 CFR Part 2 consent volume."
    - name: "Distinct SUD Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with substance-use disclosure consent — protected population size."
    - name: "Part 2 Covered Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN part2_covered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents covered under 42 CFR Part 2 — scope of heightened confidentiality controls."
    - name: "Redisclosure Notice Provided Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN redisclosure_notice_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents where redisclosure notice was provided — mandatory Part 2 compliance element."
    - name: "Revoked Consent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revocation_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of substance-use consents that have been revoked — revocation posture for SUD data sharing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_research_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research consent KPIs measuring reconsent obligations, comprehension assessment, LAR usage, and biospecimen/genetic authorizations. Steers IRB and research compliance."
  source: "`vibe_healthcare_v1`.`consent`.`research_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Status of the research consent."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain research consent."
    - name: "study_arm"
      expr: study_arm
      comment: "Study arm associated with the consent."
    - name: "signed_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month bucket of the signed date for trending."
  measures:
    - name: "Research Consent Count"
      expr: COUNT(1)
      comment: "Total research consents — baseline for study enrollment consent volume."
    - name: "Distinct Research Subjects"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients consented to research — subject reach across studies."
    - name: "Reconsent Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconsent_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents flagged for reconsent — protocol amendment / risk-change follow-up load."
    - name: "Comprehension Assessed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subject_comprehension_assessed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents where subject comprehension was assessed — informed-consent quality indicator."
    - name: "LAR Used Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lar_used = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents obtained via legally authorized representative — vulnerable-population oversight."
    - name: "Biospecimen Authorized Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN biospecimen_collection_authorized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents authorizing biospecimen collection — biobank/genomics pipeline sizing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_amendment_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Record-amendment request KPIs measuring acceptance rate, HIPAA amendment share, and review throughput. Steers HIPAA right-to-amend operations."
  source: "`vibe_healthcare_v1`.`consent`.`amendment_request`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment request."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of record amendment requested."
    - name: "decision"
      expr: decision
      comment: "Decision rendered on the amendment request."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month bucket of request date for trending."
  measures:
    - name: "Amendment Request Count"
      expr: COUNT(1)
      comment: "Total record-amendment requests — baseline for right-to-amend workload."
    - name: "Distinct Patients Amending"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients requesting record amendments — reach of amendment activity."
    - name: "Amendment Accepted Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of amendment requests accepted — approval outcome and data-quality signal."
    - name: "HIPAA Amendment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_amendment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests classified as HIPAA amendments — regulatory scope of amendment activity."
    - name: "Decision Rendered Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests with a decision rendered — throughput of amendment review process."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_npp_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Notice of Privacy Practices acknowledgment KPIs measuring signature capture, good-faith-effort fallbacks, and first-service compliance. Steers HIPAA NPP obligation adherence."
  source: "`vibe_healthcare_v1`.`consent`.`npp_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of the NPP acknowledgment."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method used to obtain the acknowledgment."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method by which the NPP was delivered to the patient."
    - name: "language_code"
      expr: language_code
      comment: "Language of the acknowledgment."
    - name: "acknowledgment_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_date)
      comment: "Month bucket of acknowledgment date for trending."
  measures:
    - name: "NPP Acknowledgment Count"
      expr: COUNT(1)
      comment: "Total NPP acknowledgments — baseline for privacy notice acknowledgment volume."
    - name: "Distinct Patients Acknowledging"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients acknowledging the NPP — reach of privacy notice distribution."
    - name: "Signature Captured Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of acknowledgments with signature captured — documentation completeness."
    - name: "First Service Acknowledgment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_first_service_acknowledgment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent captured at first service — timeliness against HIPAA first-encounter requirement."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_expiration_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent expiration alert KPIs measuring renewal initiation and notification delivery to prevent lapses. Steers proactive consent lifecycle management."
  source: "`vibe_healthcare_v1`.`consent`.`expiration_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Status of the expiration alert."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of expiration alert."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify about the impending expiration."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient receiving the alert."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_date)
      comment: "Month bucket of alert date for trending."
  measures:
    - name: "Expiration Alert Count"
      expr: COUNT(1)
      comment: "Total consent expiration alerts — baseline for lifecycle risk monitoring."
    - name: "Distinct Patients Alerted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with expiring consents — population at risk of consent lapse."
    - name: "Renewal Initiated Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_initiated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts that triggered renewal initiation — proactive lifecycle management effectiveness."
    - name: "Notification Sent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts with a notification sent — outreach execution coverage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Decision-making capacity assessment KPIs measuring surrogate requirement, reassessment recommendations, and determination mix. Steers informed-consent integrity for vulnerable patients."
  source: "`vibe_healthcare_v1`.`consent`.`capacity_assessment`"
  dimensions:
    - name: "assessment_result"
      expr: assessment_result
      comment: "Result of the capacity assessment."
    - name: "capacity_determination"
      expr: capacity_determination
      comment: "Final capacity determination."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment performed."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month bucket of assessment date for trending."
  measures:
    - name: "Capacity Assessment Count"
      expr: COUNT(1)
      comment: "Total capacity assessments — baseline for decision-capacity evaluation volume."
    - name: "Distinct Patients Assessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients assessed for decision-making capacity — reach of capacity evaluation."
    - name: "Surrogate Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN surrogate_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments requiring a surrogate decision-maker — substituted-judgment workload."
    - name: "Reassessment Recommended Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reassessment_recommended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments recommending reassessment — ongoing monitoring demand."
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