-- Metric views for domain: claim | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial and operational performance metrics including revenue cycle, denial rates, and processing efficiency"
  source: "`vibe_healthcare_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g., submitted, adjudicated, paid, denied)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., professional, institutional, pharmacy)"
    - name: "bill_type"
      expr: bill_type
      comment: "UB-04 bill type code for institutional claims"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating where services were rendered"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the claim (e.g., EDI, paper, portal)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code indicating reason for claim denial if applicable"
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Indicates whether this is the primary payer for the claim"
    - name: "coordination_of_benefits_flag"
      expr: coordination_of_benefits_flag
      comment: "Indicates whether coordination of benefits applies"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether an appeal has been filed for this claim"
    - name: "rac_audit_flag"
      expr: rac_audit_flag
      comment: "Indicates whether claim is subject to Recovery Audit Contractor audit"
    - name: "service_year"
      expr: YEAR(service_from_date)
      comment: "Year when services were provided"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Month when services were provided"
    - name: "submission_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year when claim was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when claim was submitted"
    - name: "adjudication_year"
      expr: YEAR(adjudication_timestamp)
      comment: "Year when claim was adjudicated"
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_timestamp)
      comment: "Month when claim was adjudicated"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claims submitted"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed across all claims - key revenue cycle metric"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total amount allowed by payers - indicates contracted reimbursement"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount actually paid by payers - realized revenue"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to claims - indicates contractual write-offs"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total amount patients are responsible for - key A/R metric"
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average amount billed per claim - indicates case mix and pricing"
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(total_paid_amount AS DOUBLE))
      comment: "Average reimbursement per claim - key profitability indicator"
    - name: "collection_rate_numerator"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Numerator for collection rate calculation - total collected"
    - name: "collection_rate_denominator"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Denominator for collection rate calculation - total billed"
    - name: "contractual_adjustment_rate_numerator"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Numerator for contractual adjustment rate - total adjustments"
    - name: "contractual_adjustment_rate_denominator"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Denominator for contractual adjustment rate - total billed"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with claims - patient volume metric"
    - name: "distinct_rendering_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique providers rendering services - capacity utilization"
    - name: "claims_with_appeals"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of claims with appeals filed - quality and denial management metric"
    - name: "claims_with_denials"
      expr: SUM(CASE WHEN denial_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of claims with denials - key quality and revenue cycle metric"
    - name: "rac_audit_claims"
      expr: SUM(CASE WHEN rac_audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of claims subject to RAC audit - compliance risk metric"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management and recovery performance metrics tracking denial rates, root causes, and appeal outcomes"
  source: "`vibe_healthcare_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (e.g., technical, clinical, authorization)"
    - name: "category"
      expr: category
      comment: "Denial category for grouping and analysis"
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code - standardized denial reason"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for denial - used for process improvement"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current status of denial resolution (e.g., pending, appealed, resolved)"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of appeal if filed (e.g., overturned, upheld, partial)"
    - name: "is_preventable"
      expr: is_preventable
      comment: "Indicates whether denial was preventable - key quality metric"
    - name: "is_rac_audit"
      expr: is_rac_audit
      comment: "Indicates whether denial resulted from RAC audit"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the denial - accountability metric"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for denial resolution"
    - name: "denial_year"
      expr: YEAR(denial_date)
      comment: "Year when denial occurred"
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month when denial occurred"
    - name: "appeal_outcome_year"
      expr: YEAR(appeal_outcome_date)
      comment: "Year when appeal outcome was determined"
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of denials - key volume metric for denial management"
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total amount denied - revenue at risk metric"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount originally billed for denied claims"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered through appeals - key recovery performance metric"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off - unrecoverable revenue loss"
    - name: "avg_denied_amount"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average amount denied per denial - indicates denial severity"
    - name: "recovery_rate_numerator"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Numerator for recovery rate - total recovered"
    - name: "recovery_rate_denominator"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Denominator for recovery rate - total denied"
    - name: "preventable_denials"
      expr: SUM(CASE WHEN is_preventable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of preventable denials - key quality improvement metric"
    - name: "preventable_denied_amount"
      expr: SUM(CASE WHEN is_preventable = TRUE THEN CAST(denied_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount denied due to preventable causes - opportunity cost"
    - name: "rac_audit_denials"
      expr: SUM(CASE WHEN is_rac_audit = TRUE THEN 1 ELSE 0 END)
      comment: "Number of denials from RAC audits - compliance metric"
    - name: "rac_audit_denied_amount"
      expr: SUM(CASE WHEN is_rac_audit = TRUE THEN CAST(denied_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount denied through RAC audits - compliance risk exposure"
    - name: "denials_with_appeals"
      expr: SUM(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of denials with appeals filed - appeal activity metric"
    - name: "successful_appeals"
      expr: SUM(CASE WHEN appeal_outcome IN ('overturned', 'partial') THEN 1 ELSE 0 END)
      comment: "Number of successful appeals - appeal effectiveness metric"
    - name: "distinct_patients_denied"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with denials - patient impact metric"
    - name: "distinct_providers_denied"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique providers with denials - provider performance metric"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization performance metrics tracking approval rates, turnaround times, and utilization management effectiveness"
  source: "`vibe_healthcare_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of prior authorization (e.g., approved, denied, pending)"
    - name: "authorization_source"
      expr: authorization_source
      comment: "Source of authorization (e.g., payer portal, phone, fax)"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer requiring authorization (e.g., commercial, Medicare, Medicaid)"
    - name: "service_setting"
      expr: service_setting
      comment: "Setting where service will be provided (e.g., inpatient, outpatient, home health)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of authorization request (e.g., urgent, routine, emergent)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code indicating reason for authorization denial if applicable"
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Indicates whether peer review was required"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether an appeal was filed for denied authorization"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of authorization appeal if filed"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when authorization was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when authorization was submitted"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year when authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when authorization decision was made"
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests - volume metric"
    - name: "approved_authorizations"
      expr: SUM(CASE WHEN authorization_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Number of approved authorizations - approval volume"
    - name: "denied_authorizations"
      expr: SUM(CASE WHEN authorization_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Number of denied authorizations - denial volume"
    - name: "pending_authorizations"
      expr: SUM(CASE WHEN authorization_status = 'pending' THEN 1 ELSE 0 END)
      comment: "Number of pending authorizations - backlog metric"
    - name: "total_requested_units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units requested across all authorizations"
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units approved - utilization management metric"
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total units actually consumed - utilization tracking"
    - name: "avg_requested_units"
      expr: AVG(CAST(requested_units AS DOUBLE))
      comment: "Average units requested per authorization"
    - name: "avg_approved_units"
      expr: AVG(CAST(approved_units AS DOUBLE))
      comment: "Average units approved per authorization"
    - name: "approval_rate_numerator"
      expr: SUM(CASE WHEN authorization_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Numerator for approval rate - approved count"
    - name: "approval_rate_denominator"
      expr: COUNT(1)
      comment: "Denominator for approval rate - total requests"
    - name: "unit_approval_rate_numerator"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Numerator for unit approval rate - approved units"
    - name: "unit_approval_rate_denominator"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Denominator for unit approval rate - requested units"
    - name: "utilization_rate_numerator"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Numerator for utilization rate - consumed units"
    - name: "utilization_rate_denominator"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Denominator for utilization rate - approved units"
    - name: "peer_review_required_count"
      expr: SUM(CASE WHEN peer_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of authorizations requiring peer review - complexity metric"
    - name: "appeals_filed"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of authorization denials appealed - appeal activity"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients requiring prior authorization"
    - name: "distinct_requesting_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique providers requesting authorizations"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance and payment reconciliation metrics tracking cash flow, payment timing, and payer performance"
  source: "`vibe_healthcare_v1`.`claim`.`remittance`"
  dimensions:
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Method of payment (e.g., check, EFT, ACH)"
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of remittance processing"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation - key A/R metric"
    - name: "payer_name"
      expr: payee_name
      comment: "Name of payer issuing remittance"
    - name: "provider_adjustment_reason_code"
      expr: provider_adjustment_reason_code
      comment: "Reason code for provider-level adjustments"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year when payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when payment was made"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year when payment was posted to accounts"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when payment was posted to accounts"
    - name: "received_year"
      expr: YEAR(received_timestamp)
      comment: "Year when remittance was received"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month when remittance was received"
  measures:
    - name: "total_remittances"
      expr: COUNT(1)
      comment: "Total number of remittance advices received"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount received - key cash flow metric"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed on remitted claims"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total amount allowed by payers on remitted claims"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments on remitted claims - contractual write-offs"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility on remitted claims - A/R to collect"
    - name: "total_provider_adjustment"
      expr: SUM(CAST(provider_adjustment_amount AS DOUBLE))
      comment: "Total provider-level adjustments - non-claim-specific adjustments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per remittance"
    - name: "payment_to_billed_numerator"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Numerator for payment-to-billed ratio - total paid"
    - name: "payment_to_billed_denominator"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Denominator for payment-to-billed ratio - total billed"
    - name: "payment_to_allowed_numerator"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Numerator for payment-to-allowed ratio - total paid"
    - name: "payment_to_allowed_denominator"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Denominator for payment-to-allowed ratio - total allowed"
    - name: "reconciled_remittances"
      expr: SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END)
      comment: "Number of fully reconciled remittances - reconciliation efficiency"
    - name: "unreconciled_remittances"
      expr: SUM(CASE WHEN reconciliation_status != 'reconciled' THEN 1 ELSE 0 END)
      comment: "Number of unreconciled remittances - backlog metric"
    - name: "distinct_payers"
      expr: COUNT(DISTINCT payee_name)
      comment: "Number of unique payers issuing remittances"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique providers receiving payments"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal management and overturn performance metrics tracking appeal outcomes, recovery amounts, and process effectiveness"
  source: "`vibe_healthcare_v1`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of appeal (e.g., submitted, under review, resolved)"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., reconsideration, redetermination, ALJ hearing)"
    - name: "level"
      expr: level
      comment: "Appeal level (e.g., first level, second level, external review)"
    - name: "outcome_code"
      expr: outcome_code
      comment: "Code indicating appeal outcome"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Original denial reason code being appealed"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit appeal"
    - name: "external_review_requested_flag"
      expr: external_review_requested_flag
      comment: "Indicates whether external review was requested"
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Indicates whether peer review was required for appeal"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates whether appeal was marked as priority"
    - name: "rac_audit_related_flag"
      expr: rac_audit_related_flag
      comment: "Indicates whether appeal is related to RAC audit"
    - name: "prior_authorization_issue_flag"
      expr: prior_authorization_issue_flag
      comment: "Indicates whether appeal involves prior authorization issue"
    - name: "coordination_of_benefits_issue_flag"
      expr: coordination_of_benefits_issue_flag
      comment: "Indicates whether appeal involves coordination of benefits issue"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when appeal was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when appeal was submitted"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year when appeal was resolved"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when appeal was resolved"
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeals filed - appeal volume metric"
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total amount originally denied - revenue at risk"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested through appeals"
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total amount overturned through appeals - key recovery metric"
    - name: "total_original_claim_amount"
      expr: SUM(CAST(original_claim_amount AS DOUBLE))
      comment: "Total original claim amount for appealed claims"
    - name: "avg_denied_amount"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average amount denied per appeal"
    - name: "avg_overturn_amount"
      expr: AVG(CAST(overturn_amount AS DOUBLE))
      comment: "Average amount overturned per appeal"
    - name: "overturn_rate_numerator"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Numerator for overturn rate - total overturned"
    - name: "overturn_rate_denominator"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Denominator for overturn rate - total denied"
    - name: "successful_appeals"
      expr: SUM(CASE WHEN CAST(overturn_amount AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Number of appeals with positive overturn - success count"
    - name: "appeal_success_rate_numerator"
      expr: SUM(CASE WHEN CAST(overturn_amount AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Numerator for appeal success rate - successful appeals"
    - name: "appeal_success_rate_denominator"
      expr: COUNT(1)
      comment: "Denominator for appeal success rate - total appeals"
    - name: "external_review_appeals"
      expr: SUM(CASE WHEN external_review_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals escalated to external review"
    - name: "priority_appeals"
      expr: SUM(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of priority appeals - urgent case volume"
    - name: "rac_audit_appeals"
      expr: SUM(CASE WHEN rac_audit_related_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals related to RAC audits - compliance metric"
    - name: "prior_auth_issue_appeals"
      expr: SUM(CASE WHEN prior_authorization_issue_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals involving prior authorization issues"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with appeals"
    - name: "distinct_claims"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of unique claims with appeals"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility verification performance metrics tracking verification success rates, coverage status, and payer responsiveness"
  source: "`vibe_healthcare_v1`.`claim`.`eligibility`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of eligibility verification (e.g., verified, failed, pending)"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Patient coverage status (e.g., active, inactive, terminated)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (e.g., medical, dental, vision, pharmacy)"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Level of coverage (e.g., individual, family, employee plus spouse)"
    - name: "network_status"
      expr: network_status
      comment: "Network status (e.g., in-network, out-of-network)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify eligibility (e.g., real-time, batch, phone)"
    - name: "response_code"
      expr: response_code
      comment: "Response code from eligibility verification"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for verification rejection if applicable"
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization is required"
    - name: "referral_required"
      expr: referral_required
      comment: "Indicates whether referral is required"
    - name: "coordination_of_benefits_order"
      expr: coordination_of_benefits_order
      comment: "Order of benefits for coordination (e.g., primary, secondary)"
    - name: "verification_year"
      expr: YEAR(verification_date)
      comment: "Year when eligibility was verified"
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_date)
      comment: "Month when eligibility was verified"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year of service for which eligibility was verified"
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total number of eligibility verifications performed"
    - name: "successful_verifications"
      expr: SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END)
      comment: "Number of successful verifications - verification effectiveness"
    - name: "failed_verifications"
      expr: SUM(CASE WHEN verification_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Number of failed verifications - process issue indicator"
    - name: "verification_success_rate_numerator"
      expr: SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END)
      comment: "Numerator for verification success rate - successful count"
    - name: "verification_success_rate_denominator"
      expr: COUNT(1)
      comment: "Denominator for verification success rate - total verifications"
    - name: "active_coverage_count"
      expr: SUM(CASE WHEN coverage_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of verifications with active coverage"
    - name: "inactive_coverage_count"
      expr: SUM(CASE WHEN coverage_status IN ('inactive', 'terminated') THEN 1 ELSE 0 END)
      comment: "Number of verifications with inactive coverage - denial risk"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across verifications"
    - name: "total_deductible_met"
      expr: SUM(CAST(deductible_met_amount AS DOUBLE))
      comment: "Total deductible amounts already met - patient financial status"
    - name: "total_deductible_remaining"
      expr: SUM(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Total deductible amounts remaining - patient responsibility forecast"
    - name: "total_out_of_pocket_max"
      expr: SUM(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Total out-of-pocket maximums across verifications"
    - name: "total_out_of_pocket_met"
      expr: SUM(CAST(out_of_pocket_met_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts already met"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount - patient cost sharing indicator"
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage - patient cost sharing indicator"
    - name: "prior_auth_required_count"
      expr: SUM(CASE WHEN prior_authorization_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of verifications requiring prior authorization - workflow impact"
    - name: "referral_required_count"
      expr: SUM(CASE WHEN referral_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of verifications requiring referral - workflow impact"
    - name: "in_network_count"
      expr: SUM(CASE WHEN network_status = 'in-network' THEN 1 ELSE 0 END)
      comment: "Number of in-network verifications - reimbursement indicator"
    - name: "out_of_network_count"
      expr: SUM(CASE WHEN network_status = 'out-of-network' THEN 1 ELSE 0 END)
      comment: "Number of out-of-network verifications - lower reimbursement risk"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT eligibility_patient_mpi_record_id)
      comment: "Number of unique patients with eligibility verifications"
    - name: "distinct_coverages"
      expr: COUNT(DISTINCT insurance_coverage_id)
      comment: "Number of unique insurance coverages verified"
$$;
