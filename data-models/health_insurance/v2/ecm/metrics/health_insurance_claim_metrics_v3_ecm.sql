-- Metric views for domain: claim | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial performance metrics tracking volume, payment accuracy, denial rates, and processing efficiency across all claim types. Used by CFO, CMO, and VP of Claims Operations for steering decisions on cost, quality, and throughput."
  source: "`vibe_health_insurance_v1`.`claim`.`header`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (medical, dental, pharmacy, etc.) for segmenting financial and operational KPIs."
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the claim (paid, denied, pending, suspended) for pipeline analysis."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (commercial, Medicare, Medicaid) for regulatory and financial segmentation."
    - name: "billing_type"
      expr: billing_type
      comment: "Billing type (institutional, professional) for cost and utilization segmentation."
    - name: "place_of_service"
      expr: place_of_service_code
      comment: "Place of service code (inpatient, outpatient, office) for site-of-care cost analysis."
    - name: "claim_source"
      expr: claim_source
      comment: "Source system or channel through which the claim was submitted for operational routing analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of service admission date for trend analysis of claim volume and cost over time."
    - name: "sla_met_flag"
      expr: sla_met
      comment: "Whether the claim was processed within SLA for compliance and operational performance tracking."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits indicator to segment claims with secondary payer involvement."
    - name: "is_mlr_excluded"
      expr: is_mlr_excluded
      comment: "Whether the claim is excluded from MLR calculation, relevant for regulatory reporting."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claims submitted. Baseline volume KPI used to track throughput and workload."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total gross billed amount across all claims. Represents provider charge exposure before adjudication."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount across all claims. Drives plan liability and network adequacy decisions."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total net amount paid to providers. Core medical cost KPI used in MLR and budget variance analysis."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim. Tracks unit cost trends and flags anomalies in payment patterns."
    - name: "claim_discount_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(billed_amount AS DOUBLE)) - SUM(CAST(allowed_amount AS DOUBLE))) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount from billed to allowed amount. Measures network contract effectiveness and negotiation leverage."
    - name: "denied_claims"
      expr: COUNT(CASE WHEN claim_status = 'DENIED' THEN 1 END)
      comment: "Count of denied claims. High denial rates signal authorization gaps, coding issues, or provider contract problems."
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'DENIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims denied. Key quality and compliance KPI — high rates trigger operational and clinical review."
    - name: "suspended_claims"
      expr: COUNT(CASE WHEN is_suspended = TRUE THEN 1 END)
      comment: "Count of suspended claims requiring manual intervention. Drives staffing and workflow prioritization decisions."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims processed within SLA. Regulatory and contractual compliance KPI for claims operations."
    - name: "cob_claims"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END)
      comment: "Count of claims with coordination of benefits. Tracks secondary payer recovery opportunity volume."
    - name: "avg_length_of_stay"
      expr: AVG(CAST(DATEDIFF(discharge_date, admission_date) AS DOUBLE))
      comment: "Average inpatient length of stay in days. Clinical efficiency KPI used in utilization management and DRG analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication quality and financial accuracy metrics tracking auto-adjudication rates, edit outcomes, medical necessity decisions, and cost impact. Used by VP of Claims, Chief Medical Officer, and Compliance for quality and cost stewardship."
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated for segmenting quality and cost metrics."
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Final adjudication outcome status for pipeline and resolution analysis."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs out-of-network status affecting allowed amount calculations and member cost-sharing."
    - name: "edit_outcome"
      expr: edit_outcome
      comment: "Outcome of adjudication edits (pass, fail, override) for quality and compliance monitoring."
    - name: "allowed_amount_method"
      expr: allowed_amount_method
      comment: "Method used to calculate allowed amount (fee schedule, UCR, capitation) for payment accuracy analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for trend analysis of adjudication volume and financial outcomes."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Prior authorization status to analyze PA compliance and its impact on adjudication outcomes."
    - name: "cob_processing_result"
      expr: cob_processing_result
      comment: "COB processing result for secondary payer coordination effectiveness analysis."
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total adjudication records processed. Baseline throughput KPI for claims operations capacity planning."
    - name: "auto_adjudication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_adjudication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims auto-adjudicated without manual intervention. Key operational efficiency KPI — higher rates reduce unit cost."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across adjudicated claims. Core plan liability measure for financial forecasting."
    - name: "total_paid_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payment amount after all adjustments. Actual cash outflow measure for medical cost management."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts applied to members. Tracks member cost-sharing and benefit design effectiveness."
    - name: "total_oop_applied"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts applied. Monitors member financial exposure and benefit adequacy."
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total amount recovered or adjusted through COB. Measures secondary payer recovery effectiveness."
    - name: "edit_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edit_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudication edits that were overridden. High rates signal compliance risk and require audit review."
    - name: "medical_necessity_denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_necessity_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications failing medical necessity. Clinical quality KPI driving UM policy and provider education."
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims requiring prior authorization. Informs UM program scope and authorization policy design."
    - name: "avg_total_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average total charge amount per adjudication. Tracks provider billing patterns and charge inflation trends."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied during adjudication. Measures payment correction volume and financial accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management metrics tracking denial volume, financial impact, appeal eligibility, and resolution outcomes. Critical for VP of Claims, CMO, and Compliance to reduce denial rates and recover revenue."
  source: "`vibe_health_insurance_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (clinical, administrative, billing) for root cause analysis and targeted remediation."
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (open, resolved, appealed) for pipeline management."
    - name: "denial_subtype"
      expr: subtype
      comment: "Denial subtype for granular categorization of denial reasons."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code — standardized denial reason for benchmarking and trend analysis."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether denial was based on medical necessity — key clinical quality and UM policy indicator."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the denial is eligible for appeal — drives appeal workload forecasting."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month of denial for trend analysis of denial volume and financial impact over time."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome of the denial for measuring overturn rates and recovery effectiveness."
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of denials issued. Baseline volume KPI for denial management program sizing."
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross dollar amount denied. Measures financial exposure from denials and recovery opportunity."
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net dollar amount denied after adjustments. Actual financial impact of denial decisions."
    - name: "avg_denied_amount_per_denial"
      expr: AVG(CAST(denied_net_amount AS DOUBLE))
      comment: "Average net denied amount per denial record. Tracks unit cost of denials for prioritization of appeal efforts."
    - name: "medical_necessity_denial_count"
      expr: COUNT(CASE WHEN medical_necessity_flag = TRUE THEN 1 END)
      comment: "Count of denials based on medical necessity. Drives UM policy review and clinical criteria updates."
    - name: "appeal_eligible_denial_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of denials eligible for appeal. Informs appeal staffing and member/provider outreach strategy."
    - name: "appeal_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials eligible for appeal. High rates indicate systemic denial issues requiring process improvement."
    - name: "letter_generated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN letter_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials with letters generated. Regulatory compliance KPI — all denials require timely written notice."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials overridden. High override rates signal inconsistent denial criteria or staff training gaps."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims payment execution metrics tracking payment volume, amounts, reconciliation status, and return rates. Used by CFO, VP of Finance, and Claims Operations to manage cash flow, reconciliation, and payment integrity."
  source: "`vibe_health_insurance_v1`.`claim`.`payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (EFT, check, virtual card) for payment channel optimization and cost analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (issued, cleared, returned, voided) for cash management and reconciliation."
    - name: "payment_method"
      expr: method
      comment: "Payment method for channel mix analysis and electronic payment adoption tracking."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (provider, member, vendor) for payment flow analysis by recipient category."
    - name: "payment_cycle"
      expr: cycle
      comment: "Payment cycle for cash flow forecasting and batch processing performance analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for identifying unreconciled payments requiring financial close action."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting for financial period analysis and cash flow trend reporting."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the payment was voided — tracks payment integrity and reissuance workload."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume KPI for payment operations capacity and throughput."
    - name: "total_gross_paid_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount issued. Core cash outflow KPI for medical cost and financial close management."
    - name: "total_net_paid_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after adjustments and taxes. Actual cash disbursed for financial reporting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustment amounts. Tracks retroactive corrections and their financial impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts withheld on payments. Regulatory compliance and tax reporting KPI."
    - name: "returned_payment_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Count of returned payments. High return rates indicate address/banking data quality issues requiring remediation."
    - name: "returned_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned. Operational quality KPI — high rates increase administrative cost and delay provider payment."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payments. Tracks payment integrity issues and reissuance workload."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Count of payments not yet reconciled. Financial close risk KPI — unreconciled items delay period-end reporting."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments successfully reconciled. Financial operations quality KPI for GL accuracy and audit readiness."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per transaction. Tracks unit payment size trends for cash flow forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims adjustment and overpayment recovery metrics tracking adjustment volume, financial impact, fraud indicators, and recovery status. Used by VP of Payment Integrity, CFO, and Compliance for cost recovery and fraud management."
  source: "`vibe_health_insurance_v1`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (overpayment, underpayment, audit, fraud) for categorizing financial corrections."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment for pipeline management and recovery tracking."
    - name: "overpayment_type"
      expr: overpayment_type
      comment: "Type of overpayment (billing error, fraud, duplicate) for root cause analysis and prevention."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of overpayment recovery (pending, collected, written-off) for financial forecasting."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover overpayments (offset, refund, demand letter) for process optimization."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that triggered the adjustment for program effectiveness analysis."
    - name: "initiator_role"
      expr: initiator_role
      comment: "Role that initiated the adjustment for accountability and workflow analysis."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment became effective for trend analysis of correction activity."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Whether the adjustment is fraud-related for FWA program performance tracking."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the adjustment requires regulatory reporting for compliance monitoring."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of claim adjustments. Baseline volume KPI for payment integrity program sizing."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total gross adjustment amount. Measures financial scale of payment corrections and recovery opportunity."
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment amount after offsets. Actual financial impact of payment integrity activities."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original claim amounts subject to adjustment. Denominator for calculating adjustment rate."
    - name: "overpayment_count"
      expr: COUNT(CASE WHEN overpayment_indicator = TRUE THEN 1 END)
      comment: "Count of overpayment adjustments. Core payment integrity KPI driving recovery program investment decisions."
    - name: "fraud_adjustment_count"
      expr: COUNT(CASE WHEN is_fraud = TRUE THEN 1 END)
      comment: "Count of fraud-related adjustments. FWA program effectiveness KPI for compliance and legal escalation."
    - name: "fraud_adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraud = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments flagged as fraud. Tracks FWA exposure and program detection effectiveness."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of claim reversals. High reversal rates indicate adjudication quality issues requiring process review."
    - name: "duplicate_adjustment_count"
      expr: COUNT(CASE WHEN is_duplicate = TRUE THEN 1 END)
      comment: "Count of duplicate claim adjustments. Tracks duplicate payment exposure and detection effectiveness."
    - name: "avg_net_adjustment_amount"
      expr: AVG(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Average net adjustment amount per record. Tracks unit recovery size for prioritizing high-value cases."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit accumulator metrics tracking deductible and out-of-pocket accumulation, limit utilization, and benefit period performance. Used by VP of Benefits, Actuarial, and Member Services to manage benefit design and member financial exposure."
  source: "`vibe_health_insurance_v1`.`claim`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, OOP max, benefit limit) for benefit design analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator for member benefit tracking and customer service."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category (medical, pharmacy, dental) for cross-benefit accumulation analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for regulatory and financial segmentation of accumulator data."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (in-network, out-of-network) for tiered benefit design performance analysis."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Whether the accumulator record is an adjustment for tracking correction volume."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start)
      comment: "Benefit period start month for annual accumulator reset and trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency benefit plan analysis."
  measures:
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total accumulated amount across all accumulators. Tracks aggregate member cost-sharing and benefit utilization."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total benefit limit amounts. Denominator for calculating benefit utilization rates."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining benefit balance across members. Tracks aggregate remaining plan liability exposure."
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per accumulator record. Tracks typical member cost-sharing burden for benefit design review."
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining benefit balance per accumulator. Informs actuarial projections of remaining plan liability."
    - name: "benefit_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_amount AS DOUBLE)) / NULLIF(SUM(CAST(limit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of benefit limit consumed. Core benefit design KPI — high utilization rates drive premium and benefit redesign decisions."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of accumulator reversals. Tracks data quality and correction volume in benefit tracking systems."
    - name: "distinct_members_with_accumulators"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with active accumulators. Measures benefit program reach and member engagement."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_ibnr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IBNR (Incurred But Not Reported) reserve metrics tracking reserve adequacy, development factors, and MLR allocation. Used by CFO, Chief Actuary, and Finance to manage reserve accuracy and regulatory capital requirements."
  source: "`vibe_health_insurance_v1`.`claim`.`ibnr`"
  dimensions:
    - name: "ibnr_status"
      expr: ibnr_status
      comment: "Status of the IBNR reserve record for tracking active vs. closed reserve positions."
    - name: "actuarial_method"
      expr: actuarial_method
      comment: "Actuarial method used (chain-ladder, Bornhuetter-Ferguson) for methodology consistency analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for segmenting reserve adequacy by product and regulatory reporting."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for reserve analysis by product design and risk profile."
    - name: "service_category"
      expr: service_category
      comment: "Service category (medical, pharmacy, behavioral) for granular reserve development analysis."
    - name: "incurred_month"
      expr: DATE_TRUNC('MONTH', incurred_month)
      comment: "Month claims were incurred for development triangle analysis and reserve run-off tracking."
    - name: "reserve_run_month"
      expr: DATE_TRUNC('MONTH', reserve_run_date)
      comment: "Month the reserve was calculated for tracking reserve development over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency reserve reporting."
  measures:
    - name: "total_estimated_ibnr"
      expr: SUM(CAST(estimated_ibnr_amount AS DOUBLE))
      comment: "Total estimated IBNR reserve amount. Core actuarial KPI for balance sheet adequacy and regulatory capital compliance."
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total claims paid to date against incurred periods. Used to calculate reserve development and run-off patterns."
    - name: "total_prior_period_reserve"
      expr: SUM(CAST(prior_period_reserve_amount AS DOUBLE))
      comment: "Total prior period reserve amounts. Baseline for measuring reserve development and actuarial accuracy."
    - name: "total_reserve_change"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Total change in reserves period-over-period. Tracks reserve strengthening or release and its P&L impact."
    - name: "total_mlr_numerator_allocation"
      expr: SUM(CAST(mlr_numerator_allocation AS DOUBLE))
      comment: "Total IBNR allocated to MLR numerator. Regulatory compliance KPI for ACA MLR reporting accuracy."
    - name: "avg_completion_factor"
      expr: AVG(CAST(completion_factor AS DOUBLE))
      comment: "Average completion factor across reserve records. Actuarial quality KPI — deviations from expected factors trigger reserve review."
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average development factor used in IBNR calculations. Tracks actuarial assumption stability over time."
    - name: "reserve_to_paid_ratio"
      expr: ROUND(SUM(CAST(estimated_ibnr_amount AS DOUBLE)) / NULLIF(SUM(CAST(paid_to_date_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of estimated IBNR to paid-to-date claims. Reserve adequacy KPI — ratios outside expected range trigger actuarial review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) metrics tracking secondary payer recovery, crossover claims, and COB processing effectiveness. Used by VP of Claims and CFO to maximize secondary payer recovery and reduce plan liability."
  source: "`vibe_health_insurance_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current COB processing status for pipeline management and recovery tracking."
    - name: "cob_method"
      expr: method
      comment: "COB coordination method (birthday rule, non-duplication) for methodology analysis."
    - name: "other_insurance_type"
      expr: other_insurance_type
      comment: "Type of other insurance (Medicare, commercial, Medicaid) for secondary payer mix analysis."
    - name: "msp_type"
      expr: msp_type
      comment: "Medicare Secondary Payer type for CMS compliance and crossover claim management."
    - name: "crossover_claim_flag"
      expr: crossover_claim_flag
      comment: "Whether the claim is a Medicare/Medicaid crossover for regulatory reporting segmentation."
    - name: "cob_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month COB became effective for trend analysis of secondary payer recovery."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Medicare Secondary Payer indicator for CMS compliance monitoring."
  measures:
    - name: "total_cob_claims"
      expr: COUNT(1)
      comment: "Total COB records processed. Baseline volume KPI for secondary payer program scope."
    - name: "total_primary_payer_paid"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by primary payer. Measures primary payer contribution and plan secondary liability."
    - name: "total_secondary_payer_paid"
      expr: SUM(CAST(secondary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by secondary payer. Measures COB recovery and reduction in plan net liability."
    - name: "total_net_liability"
      expr: SUM(CAST(net_liability_amount AS DOUBLE))
      comment: "Total net plan liability after COB coordination. Core financial KPI for plan cost management."
    - name: "total_cob_adjustment"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total COB adjustment amounts applied. Measures financial impact of secondary payer coordination."
    - name: "cob_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(secondary_payer_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total charges recovered through secondary payer. COB program effectiveness KPI."
    - name: "crossover_claim_count"
      expr: COUNT(CASE WHEN crossover_claim_flag = TRUE THEN 1 END)
      comment: "Count of Medicare/Medicaid crossover claims. Regulatory compliance KPI for dual-eligible member management."
    - name: "manual_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COB records requiring manual override. High rates indicate automation gaps in COB processing."
    - name: "avg_primary_payer_allowed"
      expr: AVG(CAST(primary_payer_allowed_amount AS DOUBLE))
      comment: "Average primary payer allowed amount. Benchmarks primary payer generosity and informs secondary liability estimates."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_subrogation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subrogation recovery metrics tracking third-party liability recovery, settlement outcomes, and lien management. Used by VP of Payment Integrity and CFO to maximize third-party recovery and reduce net medical costs."
  source: "`vibe_health_insurance_v1`.`claim`.`subrogation`"
  dimensions:
    - name: "subrogation_status"
      expr: subrogation_status
      comment: "Current subrogation case status for pipeline management and recovery forecasting."
    - name: "subrogation_type"
      expr: subrogation_type
      comment: "Type of subrogation (auto accident, workers comp, liability) for program segmentation."
    - name: "liability_type"
      expr: liability_type
      comment: "Type of third-party liability for legal strategy and recovery method selection."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover subrogation amounts (settlement, lien, demand) for process optimization."
    - name: "lien_status"
      expr: lien_status
      comment: "Status of any lien applied for tracking lien-based recovery pipeline."
    - name: "accident_state"
      expr: accident_state_code
      comment: "State where accident occurred for jurisdictional analysis of subrogation laws and recovery rates."
    - name: "accident_month"
      expr: DATE_TRUNC('MONTH', accident_date)
      comment: "Month of accident for aging analysis of subrogation cases and recovery timelines."
    - name: "is_settlement_agreed"
      expr: is_settlement_agreed
      comment: "Whether a settlement has been agreed for tracking settlement conversion rates."
  measures:
    - name: "total_subrogation_cases"
      expr: COUNT(1)
      comment: "Total subrogation cases. Baseline volume KPI for program capacity and staffing decisions."
    - name: "total_demand_amount"
      expr: SUM(CAST(demand_amount AS DOUBLE))
      comment: "Total demand amounts sent to third parties. Measures gross recovery opportunity in the subrogation pipeline."
    - name: "total_gross_recovery"
      expr: SUM(CAST(gross_recovery_amount AS DOUBLE))
      comment: "Total gross recovery amounts collected. Core subrogation program ROI KPI."
    - name: "total_net_recovery"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery after legal fees. Actual financial benefit of subrogation program to the plan."
    - name: "total_legal_fees"
      expr: SUM(CAST(legal_fees_amount AS DOUBLE))
      comment: "Total legal fees incurred in subrogation. Cost efficiency KPI for make-vs-buy decisions on legal strategy."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts agreed. Tracks negotiated recovery outcomes vs. demand amounts."
    - name: "recovery_to_demand_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(demand_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of demanded amounts actually recovered. Subrogation program effectiveness KPI for legal strategy review."
    - name: "net_recovery_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_recovery_amount AS DOUBLE)), 0), 2)
      comment: "Net recovery as percentage of gross recovery after legal fees. Measures cost efficiency of recovery operations."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_settlement_agreed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases reaching settlement. Tracks negotiation effectiveness and case resolution efficiency."
    - name: "lien_applied_count"
      expr: COUNT(CASE WHEN is_lien_applied = TRUE THEN 1 END)
      comment: "Count of cases with liens applied. Tracks lien strategy utilization for maximizing recovery leverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level financial and utilization metrics tracking service-level costs, units, and payment patterns. Used by VP of Medical Management and Actuarial for granular cost analysis, utilization review, and benefit design."
  source: "`vibe_health_insurance_v1`.`claim`.`line`"
  dimensions:
    - name: "line_type"
      expr: line_type
      comment: "Type of claim line (professional, institutional, pharmacy) for service-level cost segmentation."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the claim line for pipeline and payment tracking."
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code for service-level utilization and cost analysis by clinical category."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for site-of-care cost analysis and network adequacy assessment."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for institutional claim line categorization and cost center analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code at line level for granular denial root cause analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for trend analysis of utilization and cost at line level."
    - name: "emergency_indicator"
      expr: emergency_indicator
      comment: "Whether the service was emergency for cost and utilization analysis of emergency vs. elective care."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total claim lines processed. Baseline utilization volume KPI for service-level throughput analysis."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount at line level. Gross charge exposure before adjudication for cost trend analysis."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount at line level. Contractual plan liability for service-level cost management."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid amount at line level. Actual medical cost disbursed for service-level financial analysis."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility amounts. Tracks member cost-sharing burden at service level."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service rendered. Core utilization KPI for measuring service volume and intensity."
    - name: "avg_allowed_per_unit"
      expr: ROUND(SUM(CAST(allowed_amount AS DOUBLE)) / NULLIF(SUM(CAST(units_of_service AS DOUBLE)), 0), 2)
      comment: "Average allowed amount per unit of service. Unit cost KPI for benchmarking provider efficiency and fee schedule adequacy."
    - name: "avg_paid_amount_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim line. Tracks unit cost trends for actuarial pricing and benefit design."
    - name: "line_discount_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(billed_amount AS DOUBLE)) - SUM(CAST(allowed_amount AS DOUBLE))) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount from billed to allowed at line level. Measures network contract effectiveness by procedure."
    - name: "cob_paid_amount"
      expr: SUM(CAST(cob_paid_amount AS DOUBLE))
      comment: "Total COB paid amount at line level. Tracks secondary payer contribution at service granularity."
$$;