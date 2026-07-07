-- Metric views for domain: claim | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core adjudication financial and operational KPIs. Tracks allowed amounts, cost-share components, net liability, and adjudication quality indicators to support medical cost management and operational efficiency decisions."
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication`"
  filter: is_active = TRUE
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Current status of the adjudication record (e.g., approved, denied, pended) — primary operational grouping dimension."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated (e.g., medical, pharmacy, dental) — used to segment cost and volume by line of business."
    - name: "allowed_amount_method"
      expr: allowed_amount_method
      comment: "Method used to determine the allowed amount (e.g., fee schedule, UCR, contracted rate) — informs reimbursement strategy analysis."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization associated with the adjudication — used to analyze PA compliance and its financial impact."
    - name: "cob_processing_result"
      expr: cob_processing_result
      comment: "Result of coordination of benefits processing — used to segment COB recovery performance."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service date — primary time dimension for trend analysis of claim costs."
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_timestamp)
      comment: "Month the claim was adjudicated — used to track processing throughput and timeliness trends."
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Indicates whether the claim was auto-adjudicated — used to measure automation rate and operational efficiency."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Indicates whether medical necessity was a factor in adjudication — used to track clinical review volume."
    - name: "timeliness_flag"
      expr: timeliness_flag
      comment: "Indicates whether the adjudication met timeliness SLA requirements — used for regulatory compliance monitoring."
    - name: "duplicate_claim_flag"
      expr: duplicate_claim_flag
      comment: "Indicates whether the claim was identified as a duplicate — used to measure duplicate detection effectiveness."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization was required for this claim — used to analyze PA compliance gaps."
  measures:
    - name: "total_adjudicated_claims"
      expr: COUNT(1)
      comment: "Total number of adjudication records — baseline volume KPI for operational throughput and capacity planning."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all adjudicated claims — primary medical cost exposure metric used in MLR and budget variance analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payment amount after all adjustments — represents actual plan liability and is critical for financial close and reserve setting."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total billed charge amount — used to compute discount yield (allowed vs. billed) and evaluate provider contract performance."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total member deductible applied across adjudicated claims — used to track accumulator utilization and member cost-share exposure."
    - name: "total_oop_amount"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket amount applied — used to monitor member financial burden and OOP maximum accumulation."
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted through coordination of benefits — measures COB recovery effectiveness and secondary payer offset."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total post-adjudication adjustment amount — used to track retroactive corrections and their financial impact."
    - name: "avg_allowed_amount_per_claim"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per adjudicated claim — used to benchmark unit cost trends and detect anomalous claim patterns."
    - name: "avg_net_amount_per_claim"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net payment per adjudicated claim — used to track per-claim cost trends and inform actuarial projections."
    - name: "total_auto_adjudicated_claims"
      expr: COUNT(CASE WHEN auto_adjudication_flag = TRUE THEN 1 END)
      comment: "Count of claims processed via auto-adjudication — numerator for auto-adjudication rate; measures operational automation effectiveness."
    - name: "total_timely_adjudications"
      expr: COUNT(CASE WHEN timeliness_flag = TRUE THEN 1 END)
      comment: "Count of adjudications meeting timeliness SLA — numerator for timeliness compliance rate; critical for regulatory reporting."
    - name: "total_duplicate_claims_detected"
      expr: COUNT(CASE WHEN duplicate_claim_flag = TRUE THEN 1 END)
      comment: "Count of duplicate claims identified during adjudication — used to measure fraud/waste detection and overpayment prevention."
    - name: "total_pa_required_claims"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END)
      comment: "Count of claims requiring prior authorization — used to analyze PA compliance and identify authorization gaps."
    - name: "total_accumulator_deductible_impact"
      expr: SUM(CAST(accumulator_deductible_impact AS DOUBLE))
      comment: "Total deductible accumulator impact across claims — used to project deductible exhaustion timing and member cost-share forecasting."
    - name: "total_accumulator_oop_impact"
      expr: SUM(CAST(accumulator_oop_impact AS DOUBLE))
      comment: "Total OOP accumulator impact across claims — used to project OOP maximum exhaustion and plan liability inflection points."
    - name: "distinct_members_adjudicated"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with adjudicated claims — used to measure utilization breadth and per-member cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim header-level operational and financial KPIs. Provides executive visibility into claim volume, financial throughput, processing timeliness, and quality — the primary steering dashboard for claims operations."
  source: "`vibe_health_insurance_v1`.`claim`.`header`"
  filter: is_active = TRUE
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g., paid, denied, pended, voided) — primary operational grouping for claims pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., professional, institutional, dental, pharmacy) — used to segment cost and volume by care category."
    - name: "lob"
      expr: lob
      comment: "Line of business (e.g., commercial, Medicare, Medicaid) — critical dimension for financial and regulatory segmentation."
    - name: "claim_source"
      expr: claim_source
      comment: "Source channel through which the claim was submitted (e.g., EDI, paper, portal) — used to analyze submission channel mix and automation rates."
    - name: "claim_received_month"
      expr: DATE_TRUNC('MONTH', claim_received_date)
      comment: "Month the claim was received — primary time dimension for claim intake volume trending."
    - name: "claim_paid_month"
      expr: DATE_TRUNC('MONTH', claim_paid_date)
      comment: "Month the claim was paid — used for cash flow analysis and payment cycle trending."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of inpatient admission — used to trend inpatient utilization and associated costs."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis-related group code — used to segment inpatient claims by clinical episode and benchmark payment rates."
    - name: "billing_type"
      expr: billing_type
      comment: "Billing type code indicating facility or professional billing — used to segment claims by provider billing category."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Indicates whether coordination of benefits applies — used to segment COB vs. primary claims for cost analysis."
    - name: "adjustment_flag"
      expr: adjustment_flag
      comment: "Indicates whether the claim has been adjusted — used to track adjustment volume and financial restatement impact."
    - name: "sla_met"
      expr: sla_met
      comment: "Indicates whether the claim processing SLA was met — used for operational performance and regulatory compliance reporting."
    - name: "is_mlr_excluded"
      expr: is_mlr_excluded
      comment: "Indicates whether the claim is excluded from MLR calculation — used to ensure accurate medical loss ratio reporting."
    - name: "is_suspended"
      expr: is_suspended
      comment: "Indicates whether the claim is currently suspended — used to monitor pended claim inventory and resolution throughput."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim headers — primary volume KPI for claims operations capacity and throughput management."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed (charged) amount across all claims — used to measure gross provider billing volume and compute discount yield."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all claims — represents contracted reimbursement ceiling and is a key input to MLR calculation."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to providers — primary medical cost metric used in financial close, budget variance, and MLR reporting."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim — used to benchmark unit cost trends and detect anomalous payment patterns."
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average billed amount per claim — used to track provider billing behavior and identify outlier billing patterns."
    - name: "total_sla_met_claims"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Count of claims where processing SLA was met — numerator for SLA compliance rate; critical for regulatory and contractual reporting."
    - name: "total_suspended_claims"
      expr: COUNT(CASE WHEN is_suspended = TRUE THEN 1 END)
      comment: "Count of currently suspended claims — measures pended claim inventory; high values indicate processing bottlenecks requiring intervention."
    - name: "total_adjusted_claims"
      expr: COUNT(CASE WHEN adjustment_flag = TRUE THEN 1 END)
      comment: "Count of claims that have been adjusted — used to track retroactive correction volume and associated financial restatement risk."
    - name: "total_cob_claims"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END)
      comment: "Count of claims with coordination of benefits — used to measure COB program scope and recovery opportunity."
    - name: "total_mlr_excluded_claims"
      expr: COUNT(CASE WHEN is_mlr_excluded = TRUE THEN 1 END)
      comment: "Count of claims excluded from MLR calculation — used to validate MLR reporting accuracy and regulatory compliance."
    - name: "distinct_members_with_claims"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with claims — used to measure utilization prevalence and compute per-member-per-month cost metrics."
    - name: "distinct_providers_billed"
      expr: COUNT(DISTINCT primary_billing_provider_id)
      comment: "Count of unique billing providers — used to measure provider network utilization breadth and identify high-volume providers."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs tracking denial volume, financial impact, and resolution outcomes. Critical for regulatory compliance, appeals management, and provider relations — directly impacts member access to care and plan financial performance."
  source: "`vibe_health_insurance_v1`.`claim`.`denial`"
  filter: is_active = TRUE
  dimensions:
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (e.g., upheld, overturned, pending appeal) — primary dimension for denial pipeline management."
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (e.g., medical necessity, authorization, eligibility, billing) — used to identify root causes and target improvement initiatives."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month the denial was issued — primary time dimension for denial trend analysis and regulatory reporting."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the denial was resolved — used to track resolution cycle time and appeals throughput."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Outcome of denial resolution (e.g., upheld, reversed, partially approved) — used to measure appeal success rates."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim adjustment reason code associated with the denial — used to categorize denial reasons for root cause analysis."
    - name: "denial_subtype"
      expr: subtype
      comment: "Sub-classification of the denial type — provides granular categorization for targeted denial reduction programs."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Indicates whether the denial was based on medical necessity — used to track clinical review denial volume."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Indicates whether the denial is eligible for appeal — used to measure appealable denial volume and member rights exposure."
    - name: "letter_generated_flag"
      expr: letter_generated_flag
      comment: "Indicates whether a denial letter was generated — used to monitor regulatory notice compliance."
    - name: "override_flag"
      expr: override_flag
      comment: "Indicates whether the denial was overridden — used to track manual override volume and authorization bypass patterns."
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of denial records — primary volume KPI for denial management operations and regulatory reporting."
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross amount denied — measures the financial scale of denied claims; critical for provider relations and appeals prioritization."
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net amount denied after adjustments — represents actual financial exposure from denials; used in financial risk and reserve analysis."
    - name: "total_denied_adjustment_amount"
      expr: SUM(CAST(denied_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount associated with denials — used to track financial corrections resulting from denial processing."
    - name: "avg_denied_net_amount"
      expr: AVG(CAST(denied_net_amount AS DOUBLE))
      comment: "Average net denied amount per denial — used to benchmark denial severity and prioritize high-value denial resolution."
    - name: "total_medical_necessity_denials"
      expr: COUNT(CASE WHEN medical_necessity_flag = TRUE THEN 1 END)
      comment: "Count of denials based on medical necessity — numerator for medical necessity denial rate; key metric for UM program effectiveness."
    - name: "total_appealable_denials"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of denials eligible for appeal — measures member rights exposure and potential financial reversal risk."
    - name: "total_overturned_denials"
      expr: COUNT(CASE WHEN resolution_status = 'OVERTURNED' THEN 1 END)
      comment: "Count of denials that were overturned upon review — measures initial denial accuracy; high overturn rates indicate process quality issues."
    - name: "total_override_denials"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Count of denials that were manually overridden — used to track exception handling volume and governance compliance."
    - name: "distinct_members_denied"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique members with denied claims — used to measure denial breadth and member access-to-care impact."
    - name: "distinct_providers_with_denials"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers with denied claims — used to identify high-denial providers for targeted education and contract review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution and reconciliation KPIs. Tracks payment volume, financial throughput, reconciliation status, and payment integrity — essential for treasury management, financial close, and fraud/waste detection."
  source: "`vibe_health_insurance_v1`.`claim`.`payment`"
  filter: is_active = TRUE
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., issued, cleared, returned, voided) — primary dimension for payment pipeline management."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., EFT, check, virtual card) — used to analyze payment channel mix and associated processing costs."
    - name: "payment_method"
      expr: method
      comment: "Payment delivery method — used to track electronic vs. paper payment adoption and optimize payment operations."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was issued — primary time dimension for cash flow analysis and payment cycle trending."
    - name: "gl_posting_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month the payment was posted to the general ledger — used for financial close reconciliation and period-end reporting."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payment recipient (e.g., provider, member, facility) — used to segment payment volume and amounts by payee category."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation — used to monitor outstanding reconciliation items and financial control compliance."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Indicates whether the payment has been reconciled — used to measure reconciliation completion rate."
    - name: "is_returned"
      expr: is_returned
      comment: "Indicates whether the payment was returned — used to track returned payment volume and recovery actions."
    - name: "is_voided"
      expr: is_voided
      comment: "Indicates whether the payment was voided — used to monitor void volume and associated financial restatement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — used for multi-currency financial reporting and FX exposure analysis."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions — primary volume KPI for payment operations throughput and treasury management."
    - name: "total_gross_amount_paid"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount issued — primary cash outflow metric for treasury management and financial close reporting."
    - name: "total_net_amount_paid"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after adjustments and taxes — represents actual cash disbursed; used for financial close and MLR calculation."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustment amount — measures the scale of post-issuance payment corrections; high values indicate upstream adjudication quality issues."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax withheld on payments — used for tax compliance reporting and provider 1099 reconciliation."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per transaction — used to benchmark payment size trends and detect anomalous payment patterns."
    - name: "total_returned_payments"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Count of returned payments — measures payment delivery failure rate; high values indicate address/banking data quality issues."
    - name: "total_voided_payments"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payments — measures payment cancellation volume; used to track financial restatement and operational error rates."
    - name: "total_unreconciled_payments"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Count of payments not yet reconciled — measures outstanding reconciliation backlog; critical for financial control and audit readiness."
    - name: "total_returned_amount"
      expr: SUM(CASE WHEN is_returned = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net amount of returned payments — measures financial exposure from undelivered payments requiring reissuance."
    - name: "distinct_payees"
      expr: COUNT(DISTINCT payee_provider_id)
      comment: "Count of unique provider payees receiving payments — used to measure payment distribution breadth and identify high-volume payees."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjustment and overpayment recovery KPIs. Tracks retroactive financial corrections, fraud indicators, and recovery performance — essential for financial integrity, audit compliance, and overpayment management."
  source: "`vibe_health_insurance_v1`.`claim`.`adjustment`"
  filter: is_active = TRUE
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., overpayment, underpayment, audit, COB) — primary dimension for adjustment root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., pending, completed, voided) — used to monitor adjustment pipeline and resolution throughput."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month the adjustment was initiated — primary time dimension for adjustment volume and financial impact trending."
    - name: "overpayment_type"
      expr: overpayment_type
      comment: "Classification of overpayment (e.g., duplicate, billing error, eligibility) — used to identify systemic overpayment root causes."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of overpayment recovery (e.g., recovered, outstanding, written-off) — used to track recovery program effectiveness."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover overpayment (e.g., offset, refund, demand letter) — used to optimize recovery strategy."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that triggered the adjustment (e.g., RAC, internal, external) — used to segment audit-driven financial corrections."
    - name: "initiator_role"
      expr: initiator_role
      comment: "Role of the party initiating the adjustment (e.g., plan, provider, member) — used to analyze adjustment initiation patterns."
    - name: "demand_lifecycle_stage"
      expr: demand_lifecycle_stage
      comment: "Current stage in the overpayment demand lifecycle — used to track demand progression and recovery pipeline management."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Indicates whether the adjustment is associated with a fraud finding — used to measure fraud-related financial exposure."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Indicates whether the adjustment is a claim reversal — used to track reversal volume and associated financial restatement."
    - name: "overpayment_indicator"
      expr: overpayment_indicator
      comment: "Indicates whether the adjustment represents an overpayment — used to segment overpayment vs. underpayment adjustments."
    - name: "compliance_60_day_rule"
      expr: compliance_60_day_rule
      comment: "Indicates compliance with the 60-day overpayment reporting rule — critical for CMS regulatory compliance monitoring."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of claim adjustments — primary volume KPI for adjustment operations and financial restatement scope."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total gross adjustment amount — measures the financial scale of claim corrections; used in financial close and reserve analysis."
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment amount after offsets — represents actual financial impact of adjustments on plan liability."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original claim amount before adjustment — used as denominator context for computing adjustment rate and financial restatement percentage."
    - name: "avg_net_adjustment_amount"
      expr: AVG(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Average net adjustment amount per record — used to benchmark adjustment severity and prioritize high-value recovery cases."
    - name: "total_overpayment_adjustments"
      expr: COUNT(CASE WHEN overpayment_indicator = TRUE THEN 1 END)
      comment: "Count of adjustments identified as overpayments — numerator for overpayment rate; key metric for payment integrity programs."
    - name: "total_fraud_adjustments"
      expr: COUNT(CASE WHEN is_fraud = TRUE THEN 1 END)
      comment: "Count of adjustments associated with fraud findings — measures fraud detection volume; critical for SIU program performance reporting."
    - name: "total_reversal_adjustments"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of claim reversals — measures retroactive claim cancellation volume; high values indicate upstream adjudication quality issues."
    - name: "total_60_day_compliant_adjustments"
      expr: COUNT(CASE WHEN compliance_60_day_rule = TRUE THEN 1 END)
      comment: "Count of adjustments compliant with the CMS 60-day overpayment reporting rule — numerator for regulatory compliance rate."
    - name: "total_fraud_adjusted_amount"
      expr: SUM(CASE WHEN is_fraud = TRUE THEN CAST(net_adjustment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net adjustment amount associated with fraud — measures financial recovery from fraud detection programs."
    - name: "distinct_providers_adjusted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers with claim adjustments — used to identify high-adjustment providers for targeted audit and education."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level service and financial KPIs. Provides granular visibility into procedure-level costs, utilization, and patient responsibility — used for provider contract analysis, benefit design, and cost-of-care management."
  source: "`vibe_health_insurance_v1`.`claim`.`line`"
  filter: is_active = TRUE
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the claim line (e.g., paid, denied, adjusted) — primary dimension for line-level processing pipeline analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of claim line (e.g., professional, facility, pharmacy) — used to segment service-level costs by care category."
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code billed on the claim line — used to analyze cost and utilization by specific service type."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code indicating care setting (e.g., office, ER, inpatient) — used to analyze site-of-care cost differentials."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for facility billing — used to segment facility claim costs by service category."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service on the claim line — primary time dimension for service-level utilization and cost trending."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for line-level denial — used to analyze denial patterns at the service level for targeted improvement."
    - name: "emergency_indicator"
      expr: emergency_indicator
      comment: "Indicates whether the service was an emergency — used to segment emergency vs. elective care costs."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary procedure modifier — used to analyze modifier usage patterns and their impact on reimbursement."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total number of claim lines — primary volume KPI for service-level utilization measurement."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount at the claim line level — used to measure gross provider billing volume by service type."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount at the claim line level — represents contracted reimbursement by service; used for provider contract performance analysis."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid amount at the claim line level — granular medical cost metric used for procedure-level cost-of-care analysis."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility amount — measures member cost-share burden at the service level; used in benefit design analysis."
    - name: "total_cob_paid_amount"
      expr: SUM(CAST(cob_paid_amount AS DOUBLE))
      comment: "Total amount paid by other payers through COB — measures secondary payer offset at the service level."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total line-level adjustment amount — measures retroactive corrections at the service level."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service billed — measures service utilization volume; used to compute cost-per-unit and detect overbilling."
    - name: "avg_paid_amount_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim line — used to benchmark unit reimbursement rates and detect anomalous payment patterns."
    - name: "total_emergency_lines"
      expr: COUNT(CASE WHEN emergency_indicator = TRUE THEN 1 END)
      comment: "Count of emergency service claim lines — numerator for emergency utilization rate; used to analyze avoidable ER utilization."
    - name: "total_emergency_paid_amount"
      expr: SUM(CASE WHEN emergency_indicator = TRUE THEN CAST(paid_amount AS DOUBLE) ELSE 0 END)
      comment: "Total paid amount for emergency services — measures emergency care cost burden; used to evaluate care management program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) financial and operational KPIs. Tracks primary payer payments, net liability after COB, and crossover claim processing — essential for maximizing COB recovery and minimizing plan overpayment."
  source: "`vibe_health_insurance_v1`.`claim`.`cob`"
  filter: is_active = TRUE
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB record (e.g., processed, pending, error) — primary dimension for COB pipeline management."
    - name: "cob_method"
      expr: method
      comment: "COB calculation method applied (e.g., standard, birthday rule, non-duplication) — used to analyze method mix and financial outcomes."
    - name: "msp_type"
      expr: msp_type
      comment: "Medicare Secondary Payer type — used to segment MSP claims for CMS compliance reporting."
    - name: "process_order"
      expr: process_order
      comment: "Order in which this plan processes the claim (primary, secondary, tertiary) — used to segment COB liability by payer order."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the COB record became effective — primary time dimension for COB volume and recovery trending."
    - name: "crossover_claim_flag"
      expr: crossover_claim_flag
      comment: "Indicates whether this is a Medicare/Medicaid crossover claim — used to segment crossover claim volume for regulatory reporting."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Indicates Medicare Secondary Payer applicability — used to identify MSP claims requiring special processing."
    - name: "medicaid_crossover_indicator"
      expr: medicaid_crossover_indicator
      comment: "Indicates Medicaid crossover claim status — used for Medicaid program compliance and cost reporting."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Indicates whether COB processing was manually overridden — used to track exception handling volume and governance compliance."
  measures:
    - name: "total_cob_records"
      expr: COUNT(1)
      comment: "Total number of COB records processed — primary volume KPI for COB program scope and operational throughput."
    - name: "total_primary_payer_paid_amount"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by the primary payer — used to compute net plan liability after COB and measure primary payer offset."
    - name: "total_primary_payer_allowed_amount"
      expr: SUM(CAST(primary_payer_allowed_amount AS DOUBLE))
      comment: "Total amount allowed by the primary payer — used to determine secondary plan liability under non-duplication COB methods."
    - name: "total_net_liability_amount"
      expr: SUM(CAST(net_liability_amount AS DOUBLE))
      comment: "Total net plan liability after COB adjustment — represents actual plan payment obligation; critical for financial close and reserve setting."
    - name: "total_cob_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total COB adjustment amount applied — measures the financial benefit of COB processing; used to evaluate COB program ROI."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total billed charge amount on COB claims — used as baseline for computing COB savings rate."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid across all payers on COB claims — used to verify total payment does not exceed allowed amount."
    - name: "avg_net_liability_per_cob_claim"
      expr: AVG(CAST(net_liability_amount AS DOUBLE))
      comment: "Average net plan liability per COB claim — used to benchmark COB claim cost and detect anomalous liability patterns."
    - name: "total_crossover_claims"
      expr: COUNT(CASE WHEN crossover_claim_flag = TRUE THEN 1 END)
      comment: "Count of Medicare/Medicaid crossover claims — measures crossover claim volume for regulatory reporting and dual-eligible program management."
    - name: "total_msp_claims"
      expr: COUNT(CASE WHEN msp_indicator = TRUE THEN 1 END)
      comment: "Count of Medicare Secondary Payer claims — measures MSP program scope; critical for CMS compliance and overpayment prevention."
    - name: "total_manual_override_cob"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END)
      comment: "Count of COB records with manual overrides — used to track exception handling volume and identify automation improvement opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_eob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Explanation of Benefits (EOB) delivery and financial summary KPIs. Tracks EOB generation, member financial responsibility, and delivery compliance — essential for member experience, regulatory compliance, and transparency requirements."
  source: "`vibe_health_insurance_v1`.`claim`.`eob`"
  filter: is_active = TRUE
  dimensions:
    - name: "eob_status"
      expr: eob_status
      comment: "Current status of the EOB (e.g., generated, delivered, suppressed) — primary dimension for EOB delivery pipeline management."
    - name: "eob_type"
      expr: eob_type
      comment: "Type of EOB document (e.g., medical, pharmacy, dental) — used to segment EOB volume by benefit category."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the EOB (e.g., mail, portal, email) — used to track digital adoption and paper suppression rates."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month the EOB was delivered — primary time dimension for EOB delivery volume trending."
    - name: "service_start_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month of service start date on the EOB — used to align EOB financial data with service period."
    - name: "member_responsibility_type"
      expr: member_responsibility_type
      comment: "Type of member financial responsibility (e.g., deductible, copay, coinsurance) — used to analyze member cost-share composition."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Indicates whether EOB delivery was suppressed — used to monitor suppression rates and ensure regulatory notice compliance."
    - name: "language_code"
      expr: language_code
      comment: "Language of the EOB document — used to track language access compliance and member communication equity."
  measures:
    - name: "total_eobs_generated"
      expr: COUNT(1)
      comment: "Total number of EOBs generated — primary volume KPI for EOB operations and regulatory notice compliance."
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total plan paid amount as reported on EOBs — used to reconcile EOB financial data with adjudication records."
    - name: "total_member_responsibility_amount"
      expr: SUM(CAST(member_responsibility_amount AS DOUBLE))
      comment: "Total member financial responsibility as reported on EOBs — measures aggregate member cost-share burden; used in benefit design and member experience analysis."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount as reported on EOBs — used to reconcile EOB allowed amounts with adjudication records."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount as reported on EOBs — used to compute discount yield and validate EOB financial accuracy."
    - name: "total_cob_adjustment_amount"
      expr: SUM(CAST(cob_adjustment_amount AS DOUBLE))
      comment: "Total COB adjustment amount reflected on EOBs — used to validate COB processing accuracy in member-facing documents."
    - name: "avg_member_responsibility_per_eob"
      expr: AVG(CAST(member_responsibility_amount AS DOUBLE))
      comment: "Average member financial responsibility per EOB — used to benchmark member cost-share levels and inform benefit design decisions."
    - name: "total_suppressed_eobs"
      expr: COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END)
      comment: "Count of suppressed EOBs — measures EOB suppression volume; used to monitor regulatory notice compliance and member communication gaps."
    - name: "distinct_members_with_eobs"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members who received EOBs — used to measure EOB delivery reach and identify members not receiving required notices."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim diagnosis coding KPIs. Tracks diagnosis code distribution, chronic condition prevalence, risk adjustment factors, and HCC categorization — essential for risk adjustment accuracy, population health management, and clinical program targeting."
  source: "`vibe_health_insurance_v1`.`claim`.`diagnosis`"
  filter: is_active = TRUE
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (e.g., principal, admitting, secondary) — used to segment diagnosis coding by clinical role."
    - name: "diagnosis_status"
      expr: diagnosis_status
      comment: "Status of the diagnosis record — used to filter active vs. historical diagnoses for risk adjustment analysis."
    - name: "icd10_code"
      expr: icd10_code
      comment: "ICD-10 diagnosis code — primary clinical dimension for disease burden analysis and risk adjustment validation."
    - name: "hcc_category"
      expr: hcc_category
      comment: "Hierarchical Condition Category assignment — used to segment members by risk tier for risk adjustment and care management targeting."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis-related group code — used to segment inpatient episodes by clinical complexity and benchmark payment rates."
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month of diagnosis — primary time dimension for disease incidence trending and risk adjustment period analysis."
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Indicates whether the diagnosis represents a chronic condition — used to measure chronic disease burden in the member population."
    - name: "poa_indicator"
      expr: poa_indicator
      comment: "Present on admission indicator — used for hospital quality reporting and HAC (hospital-acquired condition) analysis."
    - name: "icd_version"
      expr: icd_version
      comment: "ICD coding version (e.g., ICD-10, ICD-9) — used to ensure coding version consistency in longitudinal analysis."
  measures:
    - name: "total_diagnosis_records"
      expr: COUNT(1)
      comment: "Total number of diagnosis records — primary volume KPI for diagnosis coding completeness and risk adjustment data quality."
    - name: "total_risk_adjustment_factor"
      expr: SUM(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Total risk adjustment factor across all diagnosis records — measures aggregate risk score contribution; used in CMS risk adjustment reconciliation."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor per diagnosis — used to benchmark coding intensity and identify risk adjustment optimization opportunities."
    - name: "total_chronic_condition_diagnoses"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END)
      comment: "Count of chronic condition diagnoses — measures chronic disease burden in the claims population; used for care management program targeting."
    - name: "distinct_icd10_codes_used"
      expr: COUNT(DISTINCT icd10_code)
      comment: "Count of unique ICD-10 codes appearing in claims — measures coding breadth and supports risk adjustment completeness analysis."
    - name: "distinct_hcc_categories"
      expr: COUNT(DISTINCT hcc_category)
      comment: "Count of unique HCC categories represented — measures risk tier diversity in the member population; used for risk adjustment program scope analysis."
    - name: "distinct_claims_with_diagnoses"
      expr: COUNT(DISTINCT claim_header_id)
      comment: "Count of unique claims with diagnosis records — used to measure diagnosis coding completeness across the claims population."
$$;