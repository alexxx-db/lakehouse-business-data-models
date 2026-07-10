-- Metric views for domain: claim | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial and operational metrics tracking claim volume, revenue cycle performance, and adjudication outcomes"
  source: "`vibe_healthcare_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim in the adjudication lifecycle"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (professional, institutional, dental, pharmacy, etc.)"
    - name: "bill_type"
      expr: bill_type
      comment: "UB-04 bill type code for institutional claims"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating where services were rendered"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the claim (EDI, paper, portal, etc.)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Primary reason code for claim denial"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicator whether an appeal has been filed for this claim"
    - name: "coordination_of_benefits_flag"
      expr: coordination_of_benefits_flag
      comment: "Indicator whether coordination of benefits applies"
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Indicator whether this payer is the primary payer"
    - name: "rac_audit_flag"
      expr: rac_audit_flag
      comment: "Indicator whether claim is subject to Recovery Audit Contractor audit"
    - name: "submission_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year the claim was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the claim was submitted"
    - name: "adjudication_year"
      expr: YEAR(adjudication_timestamp)
      comment: "Year the claim was adjudicated"
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_timestamp)
      comment: "Month the claim was adjudicated"
    - name: "service_year"
      expr: YEAR(service_from_date)
      comment: "Year services were provided"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Month services were provided"
  measures:
    - name: "total_claim_count"
      expr: COUNT(1)
      comment: "Total number of claims"
    - name: "unique_claim_count"
      expr: COUNT(DISTINCT claim_id)
      comment: "Distinct count of claims"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed across all claims"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total amount allowed by payer after adjudication"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid by payer to provider"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount (contractual and other adjustments)"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility amount (copay, coinsurance, deductible)"
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average amount billed per claim"
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(total_paid_amount AS DOUBLE))
      comment: "Average amount paid per claim"
    - name: "avg_patient_responsibility_per_claim"
      expr: AVG(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Average patient responsibility per claim"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management metrics tracking denial volume, financial impact, appeal outcomes, and root cause analysis"
  source: "`vibe_healthcare_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (clinical, administrative, technical, etc.)"
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code from payer"
    - name: "rarc_code"
      expr: rarc_code
      comment: "Remittance Advice Remark Code providing additional detail"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Internal root cause code for denial prevention analysis"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current status of denial resolution workflow"
    - name: "appeal_level"
      expr: appeal_level
      comment: "Level of appeal (first, second, third, external review)"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of appeal process (overturned, upheld, partial, pending)"
    - name: "is_preventable"
      expr: is_preventable
      comment: "Indicator whether denial was preventable through process improvement"
    - name: "is_rac_audit"
      expr: is_rac_audit
      comment: "Indicator whether denial resulted from RAC audit"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for denial resolution"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for denial work queue"
    - name: "denial_year"
      expr: YEAR(denial_date)
      comment: "Year the denial was issued"
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month the denial was issued"
    - name: "appeal_outcome_year"
      expr: YEAR(appeal_outcome_date)
      comment: "Year the appeal outcome was determined"
  measures:
    - name: "total_denial_count"
      expr: COUNT(1)
      comment: "Total number of denials"
    - name: "unique_denial_count"
      expr: COUNT(DISTINCT denial_id)
      comment: "Distinct count of denials"
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total amount denied by payers"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount originally billed for denied claims"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total amount allowed for denied claims"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered through appeals and resubmissions"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "avg_denied_amount_per_denial"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average amount denied per denial record"
    - name: "preventable_denial_count"
      expr: COUNT(CASE WHEN is_preventable = TRUE THEN 1 END)
      comment: "Count of denials flagged as preventable"
    - name: "rac_audit_denial_count"
      expr: COUNT(CASE WHEN is_rac_audit = TRUE THEN 1 END)
      comment: "Count of denials resulting from RAC audits"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics tracking approval rates, turnaround time, utilization management, and appeal outcomes"
  source: "`vibe_healthcare_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of prior authorization request"
    - name: "authorization_source"
      expr: authorization_source
      comment: "Source system or channel for authorization request"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for authorization denial"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of authorization request (standard, expedited, urgent)"
    - name: "service_setting"
      expr: service_setting
      comment: "Setting where authorized services will be provided"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (commercial, Medicare, Medicaid, etc.)"
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Indicator whether peer review was required"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicator whether an appeal was filed for denied authorization"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of authorization appeal"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the authorization was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the authorization was submitted"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the authorization decision was made"
  measures:
    - name: "total_authorization_count"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests"
    - name: "unique_authorization_count"
      expr: COUNT(DISTINCT prior_authorization_id)
      comment: "Distinct count of prior authorization requests"
    - name: "total_requested_units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units requested across all authorizations"
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units approved across all authorizations"
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total units consumed from approved authorizations"
    - name: "avg_requested_units"
      expr: AVG(CAST(requested_units AS DOUBLE))
      comment: "Average units requested per authorization"
    - name: "avg_approved_units"
      expr: AVG(CAST(approved_units AS DOUBLE))
      comment: "Average units approved per authorization"
    - name: "peer_review_count"
      expr: COUNT(CASE WHEN peer_review_required_flag = TRUE THEN 1 END)
      comment: "Count of authorizations requiring peer review"
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Count of authorizations with appeals filed"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance and payment metrics tracking cash flow, payment reconciliation, and payer payment performance"
  source: "`vibe_healthcare_v1`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of remittance processing"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation to claims"
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Method of payment (check, EFT, ACH, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for payment amounts"
    - name: "provider_adjustment_reason_code"
      expr: provider_adjustment_reason_code
      comment: "Reason code for provider-level adjustments"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year the payment was posted to accounts"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the payment was posted to accounts"
    - name: "coverage_period_start_year"
      expr: YEAR(coverage_period_start_date)
      comment: "Year of coverage period start"
  measures:
    - name: "total_remittance_count"
      expr: COUNT(1)
      comment: "Total number of remittance advices"
    - name: "unique_remittance_count"
      expr: COUNT(DISTINCT remittance_id)
      comment: "Distinct count of remittance advices"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount received from payers"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed on remitted claims"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total amount allowed on remitted claims"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount on remitted claims"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility on remitted claims"
    - name: "total_provider_adjustment"
      expr: SUM(CAST(provider_adjustment_amount AS DOUBLE))
      comment: "Total provider-level adjustments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per remittance"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal management metrics tracking appeal volume, overturn rates, financial recovery, and resolution performance"
  source: "`vibe_healthcare_v1`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of appeal in workflow"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (reconsideration, redetermination, hearing, etc.)"
    - name: "outcome_code"
      expr: outcome_code
      comment: "Code representing the appeal outcome"
    - name: "service_type_code"
      expr: service_type_code
      comment: "Type of service being appealed"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the appeal"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicator whether appeal is high priority"
    - name: "external_review_requested_flag"
      expr: external_review_requested_flag
      comment: "Indicator whether external review was requested"
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Indicator whether peer review is required"
    - name: "prior_authorization_issue_flag"
      expr: prior_authorization_issue_flag
      comment: "Indicator whether appeal relates to prior authorization issue"
    - name: "coordination_of_benefits_issue_flag"
      expr: coordination_of_benefits_issue_flag
      comment: "Indicator whether appeal relates to COB issue"
    - name: "rac_audit_related_flag"
      expr: rac_audit_related_flag
      comment: "Indicator whether appeal is related to RAC audit"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the appeal was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the appeal was submitted"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year the appeal was resolved"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the appeal was resolved"
  measures:
    - name: "total_appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals"
    - name: "unique_appeal_count"
      expr: COUNT(DISTINCT appeal_id)
      comment: "Distinct count of appeals"
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total amount originally denied that is being appealed"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested in appeals"
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total amount overturned in favor of provider through appeals"
    - name: "total_original_claim_amount"
      expr: SUM(CAST(original_claim_amount AS DOUBLE))
      comment: "Total original claim amount for appealed claims"
    - name: "avg_denied_amount_per_appeal"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average denied amount per appeal"
    - name: "avg_overturn_amount_per_appeal"
      expr: AVG(CAST(overturn_amount AS DOUBLE))
      comment: "Average overturn amount per appeal"
    - name: "priority_appeal_count"
      expr: COUNT(CASE WHEN priority_flag = TRUE THEN 1 END)
      comment: "Count of high-priority appeals"
    - name: "external_review_count"
      expr: COUNT(CASE WHEN external_review_requested_flag = TRUE THEN 1 END)
      comment: "Count of appeals with external review requested"
    - name: "rac_audit_appeal_count"
      expr: COUNT(CASE WHEN rac_audit_related_flag = TRUE THEN 1 END)
      comment: "Count of appeals related to RAC audits"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level metrics tracking service-level revenue, adjustments, and payment performance by procedure and service type"
  source: "`vibe_healthcare_v1`.`claim`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of claim line in adjudication"
    - name: "procedure_code"
      expr: procedure_code
      comment: "CPT/HCPCS procedure code for service"
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code for institutional claims"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for line-level denial"
    - name: "modifier_1"
      expr: modifier_1
      comment: "First procedure modifier"
    - name: "modifier_2"
      expr: modifier_2
      comment: "Second procedure modifier"
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code for pharmacy claims"
    - name: "drug_unit_of_measure"
      expr: drug_unit_of_measure
      comment: "Unit of measure for drug quantity"
    - name: "coordination_of_benefits_indicator"
      expr: coordination_of_benefits_indicator
      comment: "Indicator of COB status at line level"
    - name: "service_year"
      expr: YEAR(service_from_date)
      comment: "Year services were provided"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Month services were provided"
    - name: "adjudication_year"
      expr: YEAR(adjudication_date)
      comment: "Year the line was adjudicated"
    - name: "paid_year"
      expr: YEAR(paid_date)
      comment: "Year the line was paid"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of claim lines"
    - name: "unique_line_count"
      expr: COUNT(DISTINCT line_id)
      comment: "Distinct count of claim lines"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed at line level"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total amount allowed at line level"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid at line level"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount at line level"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility at line level"
    - name: "total_outlier_payment"
      expr: SUM(CAST(outlier_payment_amount AS DOUBLE))
      comment: "Total outlier payment amount for high-cost cases"
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service provided"
    - name: "total_drug_quantity"
      expr: SUM(CAST(drug_quantity AS DOUBLE))
      comment: "Total drug quantity dispensed"
    - name: "avg_billed_amount_per_line"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average amount billed per claim line"
    - name: "avg_paid_amount_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average amount paid per claim line"
    - name: "avg_units_per_line"
      expr: AVG(CAST(units_of_service AS DOUBLE))
      comment: "Average units of service per claim line"
$$;