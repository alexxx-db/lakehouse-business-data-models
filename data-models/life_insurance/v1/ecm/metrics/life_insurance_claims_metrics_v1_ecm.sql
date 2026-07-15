-- Metric views for domain: claims | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim performance metrics tracking claim volumes, cycle times, approval rates, and financial exposure across claim types and statuses"
  source: "`life_insurance_ecm`.`claims`.`claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (death, living benefit, surrender, etc.)"
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (open, closed, pending, denied)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the claim (approved, denied, withdrawn)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for claim denial reason"
    - name: "contestability_period_flag"
      expr: contestability_period_flag
      comment: "Whether claim occurred within contestability period"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicator of potential fraud"
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Whether claim is in litigation"
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Whether claim requires investigation"
    - name: "reopened_flag"
      expr: reopened_flag
      comment: "Whether claim was reopened after initial closure"
    - name: "ibnr_flag"
      expr: ibnr_flag
      comment: "Incurred But Not Reported flag"
    - name: "date_reported_year"
      expr: YEAR(date_reported)
      comment: "Year claim was reported"
    - name: "date_reported_month"
      expr: DATE_TRUNC('MONTH', date_reported)
      comment: "Month claim was reported"
    - name: "closure_year"
      expr: YEAR(closure_date)
      comment: "Year claim was closed"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claims"
    - name: "total_amount_requested"
      expr: SUM(CAST(amount_requested AS DOUBLE))
      comment: "Total claim amount requested by claimants"
    - name: "total_amount_approved"
      expr: SUM(CAST(amount_approved AS DOUBLE))
      comment: "Total claim amount approved for payment"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total claim amount actually paid to beneficiaries"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amount held for claims"
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk (face amount minus reserves and reinsurance)"
    - name: "avg_amount_requested"
      expr: AVG(CAST(amount_requested AS DOUBLE))
      comment: "Average claim amount requested per claim"
    - name: "avg_amount_approved"
      expr: AVG(CAST(amount_approved AS DOUBLE))
      comment: "Average claim amount approved per claim"
    - name: "avg_amount_paid"
      expr: AVG(CAST(amount_paid AS DOUBLE))
      comment: "Average claim amount paid per claim"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims approved (approved claims / total claims)"
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition = 'denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims denied (denied claims / total claims)"
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims flagged for fraud"
    - name: "contestability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contestability_period_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims within contestability period"
    - name: "litigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN litigation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims in litigation"
    - name: "reopened_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reopened_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims that were reopened"
    - name: "distinct_policies"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with claims"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution metrics tracking disbursement volumes, amounts, methods, tax withholding, and payment cycle efficiency"
  source: "`life_insurance_ecm`.`claims`.`claim_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (pending, cleared, stopped, reissued)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (lump sum, installment, annuity, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment delivery (ACH, check, wire, etc.)"
    - name: "settlement_option"
      expr: settlement_option
      comment: "Settlement option elected by beneficiary"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of recurring payments"
    - name: "stop_payment_flag"
      expr: stop_payment_flag
      comment: "Whether payment was stopped"
    - name: "reissue_flag"
      expr: reissue_flag
      comment: "Whether payment was reissued"
    - name: "form_1099_reporting_flag"
      expr: form_1099_reporting_flag
      comment: "Whether payment requires 1099 reporting"
    - name: "direct_deposit_authorization_flag"
      expr: direct_deposit_authorization_flag
      comment: "Whether direct deposit was authorized"
    - name: "payment_date_year"
      expr: YEAR(payment_date)
      comment: "Year payment was made"
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month payment was made"
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of claim payments"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross payment amount before withholdings"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after withholdings"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal tax withheld from payments"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state tax withheld from payments"
    - name: "avg_gross_payment_amount"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross payment amount per payment"
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net payment amount per payment"
    - name: "avg_tax_withholding_pct"
      expr: AVG(CAST(tax_withholding_percentage AS DOUBLE))
      comment: "Average tax withholding percentage across payments"
    - name: "stop_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_payment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were stopped"
    - name: "reissue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reissue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were reissued"
    - name: "direct_deposit_adoption_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN direct_deposit_authorization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments using direct deposit"
    - name: "distinct_claims_paid"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims with payments"
    - name: "distinct_claimants_paid"
      expr: COUNT(DISTINCT claimant_id)
      comment: "Number of distinct claimants receiving payments"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reserve adequacy and development metrics tracking reserve establishment, changes, releases, and actuarial confidence intervals for financial planning"
  source: "`life_insurance_ecm`.`claims`.`claim_reserve`"
  dimensions:
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the reserve (active, released, closed)"
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (case reserve, IBNR, LAE, etc.)"
    - name: "reserve_basis"
      expr: reserve_basis
      comment: "Basis for reserve calculation (statutory, GAAP, etc.)"
    - name: "estimation_methodology"
      expr: estimation_methodology
      comment: "Methodology used to estimate reserve"
    - name: "reserve_adequacy_indicator"
      expr: reserve_adequacy_indicator
      comment: "Indicator of reserve adequacy (adequate, deficient, redundant)"
    - name: "catastrophic_event_flag"
      expr: catastrophic_event_flag
      comment: "Whether reserve is related to catastrophic event"
    - name: "actuarial_signoff_status"
      expr: actuarial_signoff_status
      comment: "Status of actuarial sign-off on reserve"
    - name: "reserve_establishment_year"
      expr: YEAR(reserve_establishment_date)
      comment: "Year reserve was established"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of reserve valuation"
  measures:
    - name: "total_reserves"
      expr: COUNT(1)
      comment: "Total number of reserve records"
    - name: "total_current_reserve_amount"
      expr: SUM(CAST(current_reserve_amount AS DOUBLE))
      comment: "Total current reserve amount held"
    - name: "total_initial_reserve_amount"
      expr: SUM(CAST(initial_reserve_amount AS DOUBLE))
      comment: "Total initial reserve amount established"
    - name: "total_reserve_change_amount"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Total reserve change amount (increases and decreases)"
    - name: "total_reserve_release_amount"
      expr: SUM(CAST(reserve_release_amount AS DOUBLE))
      comment: "Total reserve amount released"
    - name: "total_net_reserve_amount"
      expr: SUM(CAST(net_reserve_amount AS DOUBLE))
      comment: "Total net reserve amount after reinsurance"
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverable amount"
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk"
    - name: "avg_current_reserve_amount"
      expr: AVG(CAST(current_reserve_amount AS DOUBLE))
      comment: "Average current reserve amount per claim"
    - name: "avg_loss_development_factor"
      expr: AVG(CAST(loss_development_factor AS DOUBLE))
      comment: "Average loss development factor"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to reserves"
    - name: "avg_confidence_interval_lower"
      expr: AVG(CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average lower bound of reserve confidence interval"
    - name: "avg_confidence_interval_upper"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE))
      comment: "Average upper bound of reserve confidence interval"
    - name: "distinct_claims_reserved"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims with reserves"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication decision quality and compliance metrics tracking approval amounts, denial reasons, supervisor review rates, and regulatory compliance"
  source: "`life_insurance_ecm`.`claims`.`adjudication`"
  dimensions:
    - name: "outcome"
      expr: outcome
      comment: "Adjudication outcome (approved, denied, partial approval)"
    - name: "decision_basis"
      expr: decision_basis
      comment: "Basis for adjudication decision"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized denial reason code"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method of settlement (lump sum, installment, etc.)"
    - name: "authority_level"
      expr: authority_level
      comment: "Authority level of adjudicator"
    - name: "supervisor_review_flag"
      expr: supervisor_review_flag
      comment: "Whether adjudication required supervisor review"
    - name: "contestability_review_flag"
      expr: contestability_review_flag
      comment: "Whether contestability review was performed"
    - name: "fraud_investigation_flag"
      expr: fraud_investigation_flag
      comment: "Whether fraud investigation was conducted"
    - name: "reinsurance_recoverable_flag"
      expr: reinsurance_recoverable_flag
      comment: "Whether reinsurance recovery applies"
    - name: "doi_complaint_flag"
      expr: doi_complaint_flag
      comment: "Whether DOI complaint was filed"
    - name: "litigation_hold_flag"
      expr: litigation_hold_flag
      comment: "Whether litigation hold is in place"
    - name: "adjudication_year"
      expr: YEAR(adjudication_date)
      comment: "Year of adjudication"
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_date)
      comment: "Month of adjudication"
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total number of adjudications"
    - name: "total_benefit_amount_approved"
      expr: SUM(CAST(benefit_amount_approved AS DOUBLE))
      comment: "Total benefit amount approved in adjudications"
    - name: "avg_benefit_amount_approved"
      expr: AVG(CAST(benefit_amount_approved AS DOUBLE))
      comment: "Average benefit amount approved per adjudication"
    - name: "avg_federal_withholding_pct"
      expr: AVG(CAST(federal_withholding_percentage AS DOUBLE))
      comment: "Average federal withholding percentage"
    - name: "avg_state_withholding_pct"
      expr: AVG(CAST(state_withholding_percentage AS DOUBLE))
      comment: "Average state withholding percentage"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications resulting in approval"
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications resulting in denial"
    - name: "supervisor_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supervisor_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications requiring supervisor review"
    - name: "contestability_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contestability_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications with contestability review"
    - name: "fraud_investigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_investigation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications with fraud investigation"
    - name: "doi_complaint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN doi_complaint_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications with DOI complaints"
    - name: "litigation_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN litigation_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications under litigation hold"
    - name: "distinct_claims_adjudicated"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims adjudicated"
    - name: "distinct_adjudicators"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees performing adjudications"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeals effectiveness and resolution metrics tracking appeal volumes, overturn rates, cycle times, and escalation to litigation or arbitration"
  source: "`life_insurance_ecm`.`claims`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (internal, external, expedited)"
    - name: "decision"
      expr: decision
      comment: "Appeal decision (upheld, overturned, modified)"
    - name: "basis"
      expr: basis
      comment: "Basis for the appeal"
    - name: "exhaustion_status"
      expr: exhaustion_status
      comment: "Status of administrative exhaustion"
    - name: "doi_complaint_filed_flag"
      expr: doi_complaint_filed_flag
      comment: "Whether DOI complaint was filed"
    - name: "arbitration_filed_flag"
      expr: arbitration_filed_flag
      comment: "Whether arbitration was filed"
    - name: "litigation_filed_flag"
      expr: litigation_filed_flag
      comment: "Whether litigation was filed"
    - name: "additional_evidence_submitted_flag"
      expr: additional_evidence_submitted_flag
      comment: "Whether additional evidence was submitted"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year appeal was filed"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year appeal decision was made"
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeals"
    - name: "total_revised_amount_approved"
      expr: SUM(CAST(revised_claim_amount_approved AS DOUBLE))
      comment: "Total revised claim amount approved through appeals"
    - name: "total_revised_amount_paid"
      expr: SUM(CAST(revised_claim_amount_paid AS DOUBLE))
      comment: "Total revised claim amount paid through appeals"
    - name: "total_hours_spent"
      expr: SUM(CAST(hours_spent AS DOUBLE))
      comment: "Total hours spent on appeals processing"
    - name: "avg_revised_amount_approved"
      expr: AVG(CAST(revised_claim_amount_approved AS DOUBLE))
      comment: "Average revised claim amount approved per appeal"
    - name: "avg_hours_spent"
      expr: AVG(CAST(hours_spent AS DOUBLE))
      comment: "Average hours spent per appeal"
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'overturned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that overturned original decision"
    - name: "upheld_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'upheld' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that upheld original decision"
    - name: "doi_complaint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN doi_complaint_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals escalated to DOI complaint"
    - name: "arbitration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN arbitration_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals escalated to arbitration"
    - name: "litigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN litigation_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals escalated to litigation"
    - name: "additional_evidence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN additional_evidence_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals with additional evidence submitted"
    - name: "distinct_claims_appealed"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims with appeals"
    - name: "distinct_claimants_appealing"
      expr: COUNT(DISTINCT claimant_id)
      comment: "Number of distinct claimants filing appeals"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigation effectiveness and fraud detection metrics tracking investigation volumes, costs, findings, dispositions, and recovery amounts"
  source: "`life_insurance_ecm`.`claims`.`claim_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (fraud, contestability, medical, etc.)"
    - name: "investigation_disposition"
      expr: investigation_disposition
      comment: "Final disposition of investigation"
    - name: "investigation_reason"
      expr: investigation_reason
      comment: "Reason investigation was initiated"
    - name: "investigation_priority"
      expr: investigation_priority
      comment: "Priority level of investigation"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of investigation"
    - name: "external_vendor_used_flag"
      expr: external_vendor_used_flag
      comment: "Whether external vendor was used"
    - name: "field_investigation_performed_flag"
      expr: field_investigation_performed_flag
      comment: "Whether field investigation was performed"
    - name: "law_enforcement_referral_flag"
      expr: law_enforcement_referral_flag
      comment: "Whether case was referred to law enforcement"
    - name: "policy_rescission_recommended_flag"
      expr: policy_rescission_recommended_flag
      comment: "Whether policy rescission was recommended"
    - name: "stoli_indicator_flag"
      expr: stoli_indicator_flag
      comment: "Stranger-originated life insurance indicator"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "investigation_open_year"
      expr: YEAR(investigation_open_date)
      comment: "Year investigation was opened"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations"
    - name: "total_investigation_cost"
      expr: SUM(CAST(investigation_cost AS DOUBLE))
      comment: "Total cost of investigations"
    - name: "total_estimated_loss_amount"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated loss amount under investigation"
    - name: "total_benefit_reduction_amount"
      expr: SUM(CAST(benefit_reduction_amount AS DOUBLE))
      comment: "Total benefit reduction amount from investigations"
    - name: "avg_investigation_cost"
      expr: AVG(CAST(investigation_cost AS DOUBLE))
      comment: "Average cost per investigation"
    - name: "avg_fraud_indicator_score"
      expr: AVG(CAST(fraud_indicator_score AS DOUBLE))
      comment: "Average fraud indicator score"
    - name: "external_vendor_usage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_vendor_used_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations using external vendors"
    - name: "field_investigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_investigation_performed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations with field work"
    - name: "law_enforcement_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations referred to law enforcement"
    - name: "rescission_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN policy_rescission_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations recommending policy rescission"
    - name: "stoli_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stoli_indicator_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations with STOLI indicators"
    - name: "distinct_claims_investigated"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims under investigation"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_contestability_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contestability review outcomes and rescission metrics tracking material misrepresentation findings, rescission decisions, and premium refunds"
  source: "`life_insurance_ecm`.`claims`.`contestability_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of contestability review"
    - name: "rescission_decision"
      expr: rescission_decision
      comment: "Final rescission decision"
    - name: "material_misrepresentation_found_flag"
      expr: material_misrepresentation_found_flag
      comment: "Whether material misrepresentation was found"
    - name: "rescission_recommended_flag"
      expr: rescission_recommended_flag
      comment: "Whether rescission was recommended"
    - name: "within_contestability_flag"
      expr: within_contestability_flag
      comment: "Whether claim is within contestability period"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether appeal was filed"
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Whether legal review was required"
    - name: "medical_director_review_flag"
      expr: medical_director_review_flag
      comment: "Whether medical director review was performed"
    - name: "mib_discrepancy_found_flag"
      expr: mib_discrepancy_found_flag
      comment: "Whether MIB discrepancy was found"
    - name: "state_doi_notification_required_flag"
      expr: state_doi_notification_required_flag
      comment: "Whether state DOI notification is required"
    - name: "misrepresentation_category"
      expr: misrepresentation_category
      comment: "Category of misrepresentation found"
    - name: "review_initiated_year"
      expr: YEAR(review_initiated_date)
      comment: "Year contestability review was initiated"
  measures:
    - name: "total_contestability_reviews"
      expr: COUNT(1)
      comment: "Total number of contestability reviews"
    - name: "total_claim_denial_amount"
      expr: SUM(CAST(claim_denial_amount AS DOUBLE))
      comment: "Total claim amount denied through contestability reviews"
    - name: "total_premium_refund_amount"
      expr: SUM(CAST(premium_refund_amount AS DOUBLE))
      comment: "Total premium refund amount from rescissions"
    - name: "avg_claim_denial_amount"
      expr: AVG(CAST(claim_denial_amount AS DOUBLE))
      comment: "Average claim denial amount per review"
    - name: "avg_premium_refund_amount"
      expr: AVG(CAST(premium_refund_amount AS DOUBLE))
      comment: "Average premium refund amount per rescission"
    - name: "material_misrepresentation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN material_misrepresentation_found_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews finding material misrepresentation"
    - name: "rescission_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rescission_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews recommending rescission"
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in appeals"
    - name: "legal_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews requiring legal review"
    - name: "medical_director_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_director_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with medical director involvement"
    - name: "mib_discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mib_discrepancy_found_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews finding MIB discrepancies"
    - name: "distinct_claims_reviewed"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims under contestability review"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_fnol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "First Notice of Loss intake quality and efficiency metrics tracking notification channels, triage accuracy, fraud indicators, and SLA compliance"
  source: "`life_insurance_ecm`.`claims`.`fnol`"
  dimensions:
    - name: "fnol_status"
      expr: fnol_status
      comment: "Current status of FNOL"
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel through which loss was reported (phone, web, agent, etc.)"
    - name: "reporter_type"
      expr: reporter_type
      comment: "Type of person reporting the loss"
    - name: "reporter_relationship"
      expr: reporter_relationship
      comment: "Relationship of reporter to insured"
    - name: "loss_event_type"
      expr: loss_event_type
      comment: "Type of loss event"
    - name: "triage_classification"
      expr: triage_classification
      comment: "Triage classification assigned to FNOL"
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Whether fraud indicators were detected"
    - name: "contestability_flag"
      expr: contestability_flag
      comment: "Whether loss is within contestability period"
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Not In Good Order flag"
    - name: "notification_year"
      expr: YEAR(notification_date)
      comment: "Year loss was notified"
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_date)
      comment: "Month loss was notified"
  measures:
    - name: "total_fnols"
      expr: COUNT(1)
      comment: "Total number of first notices of loss"
    - name: "fraud_indicator_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FNOLs with fraud indicators"
    - name: "contestability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contestability_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FNOLs within contestability period"
    - name: "nigo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FNOLs not in good order"
    - name: "distinct_policies_reported"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with loss notifications"
    - name: "distinct_reporters"
      expr: COUNT(DISTINCT reporter_name)
      comment: "Number of distinct individuals reporting losses"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_siu_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special Investigation Unit referral and fraud recovery metrics tracking referral volumes, investigation outcomes, recovery amounts, and law enforcement escalations"
  source: "`life_insurance_ecm`.`claims`.`siu_referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of SIU referral"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of SIU referral"
    - name: "referral_reason_code"
      expr: referral_reason_code
      comment: "Reason code for SIU referral"
    - name: "fraud_indicator_type"
      expr: fraud_indicator_type
      comment: "Type of fraud indicator"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of SIU referral"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of referral"
    - name: "external_vendor_used_flag"
      expr: external_vendor_used_flag
      comment: "Whether external vendor was used"
    - name: "law_enforcement_referral_flag"
      expr: law_enforcement_referral_flag
      comment: "Whether case was referred to law enforcement"
    - name: "nicb_referral_flag"
      expr: nicb_referral_flag
      comment: "Whether case was referred to NICB"
    - name: "state_doi_referral_flag"
      expr: state_doi_referral_flag
      comment: "Whether case was referred to state DOI"
    - name: "claim_denial_recommended_flag"
      expr: claim_denial_recommended_flag
      comment: "Whether claim denial was recommended"
    - name: "policy_rescission_recommended_flag"
      expr: policy_rescission_recommended_flag
      comment: "Whether policy rescission was recommended"
    - name: "stoli_indicator_flag"
      expr: stoli_indicator_flag
      comment: "Stranger-originated life insurance indicator"
    - name: "referral_year"
      expr: YEAR(referral_date)
      comment: "Year of SIU referral"
  measures:
    - name: "total_siu_referrals"
      expr: COUNT(1)
      comment: "Total number of SIU referrals"
    - name: "total_actual_loss_amount"
      expr: SUM(CAST(actual_loss_amount AS DOUBLE))
      comment: "Total actual loss amount from SIU cases"
    - name: "total_estimated_loss_amount"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated loss amount under SIU investigation"
    - name: "total_investigation_cost"
      expr: SUM(CAST(investigation_cost AS DOUBLE))
      comment: "Total cost of SIU investigations"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered through SIU investigations"
    - name: "avg_fraud_indicator_score"
      expr: AVG(CAST(fraud_indicator_score AS DOUBLE))
      comment: "Average fraud indicator score"
    - name: "avg_investigation_cost"
      expr: AVG(CAST(investigation_cost AS DOUBLE))
      comment: "Average cost per SIU investigation"
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount AS DOUBLE))
      comment: "Average recovery amount per SIU case"
    - name: "law_enforcement_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SIU cases referred to law enforcement"
    - name: "nicb_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nicb_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SIU cases referred to NICB"
    - name: "state_doi_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN state_doi_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SIU cases referred to state DOI"
    - name: "claim_denial_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_denial_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SIU cases recommending claim denial"
    - name: "rescission_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN policy_rescission_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SIU cases recommending policy rescission"
    - name: "stoli_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stoli_indicator_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SIU cases with STOLI indicators"
    - name: "distinct_claims_referred"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims referred to SIU"
$$;
