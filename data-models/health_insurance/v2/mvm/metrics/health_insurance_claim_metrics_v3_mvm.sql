-- Metric views for domain: claim | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim adjudication financial and operational KPIs tracking allowed amounts, cost-sharing, network performance, and auto-adjudication efficiency"
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication`"
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Current adjudication status (e.g., approved, denied, pending)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., medical, pharmacy, dental)"
    - name: "network_status"
      expr: network_status
      comment: "Network participation status (in-network, out-of-network)"
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Whether claim was auto-adjudicated (True) or manually reviewed (False)"
    - name: "edit_outcome"
      expr: edit_outcome
      comment: "Result of claim edit processing (pass, fail, override)"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Prior authorization status for the claim"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year of service for trend analysis"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for trend analysis"
    - name: "admission_year_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Admission month for inpatient claim analysis"
  measures:
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all adjudicated claims - primary financial metric for plan liability"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total billed charges before adjudication - baseline for discount analysis"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payment amount after all adjustments and COB"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible applied to member cost-sharing"
    - name: "total_oop_amount"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket member responsibility (copay, coinsurance, deductible)"
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total coordination of benefits adjustments from other payers"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total claim adjustments (reductions from billed to allowed)"
    - name: "avg_allowed_amount_per_claim"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per claim - unit cost metric for benchmarking"
    - name: "claim_count"
      expr: COUNT(adjudication_id)
      comment: "Total number of adjudicated claims"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct member count for utilization and penetration analysis"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct provider count for network breadth analysis"
    - name: "auto_adjudication_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_adjudication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjudication_id), 0), 2)
      comment: "Percentage of claims auto-adjudicated - operational efficiency KPI"
    - name: "duplicate_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN duplicate_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjudication_id), 0), 2)
      comment: "Percentage of duplicate claims - quality and fraud detection metric"
    - name: "edit_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edit_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjudication_id), 0), 2)
      comment: "Percentage of claims with edit overrides - policy compliance metric"
    - name: "avg_discount_rate"
      expr: ROUND(100.0 * AVG(CAST(total_adjustment_amount AS DOUBLE) / NULLIF(CAST(total_charge_amount AS DOUBLE), 0)), 2)
      comment: "Average discount from billed charges to allowed amount - network savings metric"
    - name: "member_cost_share_ratio"
      expr: ROUND(100.0 * SUM(CAST(oop_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)), 0), 2)
      comment: "Member out-of-pocket as percentage of allowed amount - benefit design effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim denial performance metrics tracking denial rates, appeal outcomes, and financial impact for quality improvement and revenue cycle optimization"
  source: "`vibe_health_insurance_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (e.g., clinical, administrative, eligibility)"
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (active, appealed, overturned, upheld)"
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code - standardized denial reason"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the denial is eligible for appeal"
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether denial was due to medical necessity determination"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether the denial was overridden"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Final resolution status of the denial"
    - name: "denial_year_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month of denial for trend analysis"
    - name: "resolution_year_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month of resolution for cycle time analysis"
  measures:
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net amount denied - primary financial impact metric for revenue cycle"
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross amount denied before adjustments"
    - name: "denial_count"
      expr: COUNT(denial_id)
      comment: "Total number of denials for volume tracking"
    - name: "unique_claims_denied"
      expr: COUNT(DISTINCT claim_header_id)
      comment: "Distinct claims with denials - claim-level denial rate denominator"
    - name: "avg_denied_amount_per_denial"
      expr: AVG(CAST(denied_net_amount AS DOUBLE))
      comment: "Average denied amount per denial - unit impact metric"
    - name: "appeal_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(denial_id), 0), 2)
      comment: "Percentage of denials eligible for appeal - member rights metric"
    - name: "override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(denial_id), 0), 2)
      comment: "Percentage of denials overridden - quality and accuracy metric"
    - name: "medical_necessity_denial_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_necessity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(denial_id), 0), 2)
      comment: "Percentage of denials due to medical necessity - utilization management effectiveness"
    - name: "letter_generation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN letter_generated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(denial_id), 0), 2)
      comment: "Percentage of denials with member notification letters - compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim header-level operational and financial KPIs tracking claim volume, financial totals, SLA performance, and claim lifecycle metrics"
  source: "`vibe_health_insurance_v1`.`claim`.`header`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current claim processing status"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (institutional, professional, pharmacy)"
    - name: "claim_source"
      expr: claim_source
      comment: "Source system or channel of claim submission"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code for setting analysis"
    - name: "lob"
      expr: lob
      comment: "Line of business (commercial, Medicare, Medicaid)"
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Whether claim has coordination of benefits"
    - name: "adjustment_flag"
      expr: adjustment_flag
      comment: "Whether claim is an adjustment to a prior claim"
    - name: "is_suspended"
      expr: is_suspended
      comment: "Whether claim is currently suspended for review"
    - name: "sla_met"
      expr: sla_met
      comment: "Whether claim processing met SLA target"
    - name: "service_year_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Service month for incurred date analysis"
    - name: "received_year_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Received month for lag analysis"
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed charges submitted by providers - baseline financial metric"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount after adjudication - plan liability metric"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to providers - cash outflow metric"
    - name: "claim_count"
      expr: COUNT(header_id)
      comment: "Total number of claim headers - volume metric"
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average billed amount per claim - unit cost metric"
    - name: "avg_allowed_amount_per_claim"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per claim - unit cost after adjudication"
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim - unit payment metric"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(header_id), 0), 2)
      comment: "Percentage of claims meeting SLA - operational performance KPI"
    - name: "suspension_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_suspended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(header_id), 0), 2)
      comment: "Percentage of claims suspended for review - quality and complexity metric"
    - name: "cob_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cob_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(header_id), 0), 2)
      comment: "Percentage of claims with coordination of benefits - complexity metric"
    - name: "adjustment_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adjustment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(header_id), 0), 2)
      comment: "Percentage of claims that are adjustments - rework and accuracy metric"
    - name: "avg_discount_rate"
      expr: ROUND(100.0 * AVG((CAST(billed_amount AS DOUBLE) - CAST(allowed_amount AS DOUBLE)) / NULLIF(CAST(billed_amount AS DOUBLE), 0)), 2)
      comment: "Average discount from billed to allowed - network savings effectiveness"
    - name: "avg_lines_per_claim"
      expr: AVG(CAST(claim_line_count AS DOUBLE))
      comment: "Average number of service lines per claim - complexity metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing and reconciliation KPIs tracking payment volume, accuracy, reconciliation status, and payment cycle efficiency"
  source: "`vibe_health_insurance_v1`.`claim`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (issued, cleared, voided, returned)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (claim, capitation, incentive)"
    - name: "payment_method"
      expr: method
      comment: "Payment method (check, EFT, virtual card)"
    - name: "channel"
      expr: channel
      comment: "Payment channel or system"
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (provider, member, vendor)"
    - name: "is_voided"
      expr: is_voided
      comment: "Whether payment was voided"
    - name: "is_returned"
      expr: is_returned
      comment: "Whether payment was returned"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status"
    - name: "payment_year_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month for cash flow analysis"
    - name: "gl_posting_year_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "GL posting month for financial reporting"
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount before adjustments - baseline cash outflow"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after adjustments - actual cash outflow metric"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments (offsets, recoveries)"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax withheld on payments"
    - name: "payment_count"
      expr: COUNT(payment_id)
      comment: "Total number of payments issued - volume metric"
    - name: "unique_payees"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct payee count for disbursement breadth"
    - name: "avg_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount - unit disbursement metric"
    - name: "void_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(payment_id), 0), 2)
      comment: "Percentage of payments voided - payment accuracy metric"
    - name: "return_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(payment_id), 0), 2)
      comment: "Percentage of payments returned - payment quality and address accuracy"
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_reconciled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(payment_id), 0), 2)
      comment: "Percentage of payments reconciled with bank - financial control metric"
    - name: "avg_adjustment_rate"
      expr: ROUND(100.0 * AVG(CAST(adjustment_amount AS DOUBLE) / NULLIF(CAST(gross_amount AS DOUBLE), 0)), 2)
      comment: "Average adjustment as percentage of gross payment - offset effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjustment and recovery KPIs tracking overpayment identification, recovery effectiveness, audit findings, and compliance with 60-day rule"
  source: "`vibe_health_insurance_v1`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (overpayment, underpayment, correction)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery process (pending, collected, written off)"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method of recovery (offset, demand, voluntary)"
    - name: "overpayment_indicator"
      expr: overpayment_indicator
      comment: "Whether adjustment represents an overpayment"
    - name: "overpayment_type"
      expr: overpayment_type
      comment: "Type of overpayment (duplicate, incorrect payment, policy)"
    - name: "is_fraud"
      expr: is_fraud
      comment: "Whether adjustment is related to fraud"
    - name: "compliance_60_day_rule"
      expr: compliance_60_day_rule
      comment: "Whether adjustment complies with CMS 60-day rule"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether adjustment requires regulatory reporting"
    - name: "adjustment_year_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Adjustment month for trend analysis"
  measures:
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total adjustment amount - primary financial impact metric"
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment after offsets and recoveries"
    - name: "adjustment_count"
      expr: COUNT(adjustment_id)
      comment: "Total number of adjustments - volume metric"
    - name: "unique_claims_adjusted"
      expr: COUNT(DISTINCT claim_header_id)
      comment: "Distinct claims with adjustments - claim-level adjustment rate denominator"
    - name: "unique_providers_adjusted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with adjustments - provider quality metric"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average adjustment amount per adjustment - unit impact metric"
    - name: "overpayment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overpayment_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjustment_id), 0), 2)
      comment: "Percentage of adjustments that are overpayments - payment accuracy metric"
    - name: "fraud_adjustment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjustment_id), 0), 2)
      comment: "Percentage of adjustments related to fraud - fraud detection effectiveness"
    - name: "compliance_60_day_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_60_day_rule = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjustment_id), 0), 2)
      comment: "Percentage of adjustments compliant with CMS 60-day rule - regulatory compliance metric"
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(adjustment_id), 0), 2)
      comment: "Percentage of adjustments requiring regulatory reporting - compliance burden metric"
    - name: "total_overpayment_amount"
      expr: SUM(CASE WHEN overpayment_indicator = TRUE THEN CAST(adjusted_amount AS DOUBLE) ELSE 0 END)
      comment: "Total overpayment amount identified - recovery opportunity metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diagnosis and risk adjustment KPIs tracking HCC prevalence, chronic condition burden, risk scores, and diagnosis coding quality"
  source: "`vibe_health_insurance_v1`.`claim`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (primary, secondary, admitting)"
    - name: "diagnosis_status"
      expr: diagnosis_status
      comment: "Status of diagnosis (active, resolved, chronic)"
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Whether diagnosis represents a chronic condition"
    - name: "hcc_category"
      expr: hcc_category
      comment: "Hierarchical Condition Category for risk adjustment"
    - name: "icd_version"
      expr: icd_version
      comment: "ICD code version (ICD-9, ICD-10)"
    - name: "poa_indicator"
      expr: poa_indicator
      comment: "Present on admission indicator"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code"
    - name: "diagnosis_year_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Diagnosis month for trend analysis"
  measures:
    - name: "diagnosis_count"
      expr: COUNT(diagnosis_id)
      comment: "Total number of diagnosis records - volume metric"
    - name: "unique_members_with_diagnosis"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with diagnoses - prevalence denominator"
    - name: "unique_claims_with_diagnosis"
      expr: COUNT(DISTINCT claim_header_id)
      comment: "Distinct claims with diagnoses - coding completeness metric"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor - population risk severity metric"
    - name: "total_risk_score"
      expr: SUM(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Total risk score across all diagnoses - aggregate risk burden"
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(diagnosis_id), 0), 2)
      comment: "Percentage of diagnoses that are chronic conditions - disease burden metric"
    - name: "hcc_capture_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hcc_category IS NOT NULL THEN diagnosis_id END) / NULLIF(COUNT(diagnosis_id), 0), 2)
      comment: "Percentage of diagnoses mapped to HCC categories - risk adjustment completeness"
    - name: "avg_diagnoses_per_claim"
      expr: AVG(CAST(line_quantity AS DOUBLE))
      comment: "Average number of diagnoses per claim - coding intensity metric"
$$;