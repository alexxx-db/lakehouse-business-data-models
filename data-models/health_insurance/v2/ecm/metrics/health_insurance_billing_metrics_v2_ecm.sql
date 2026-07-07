-- Metric views for domain: billing | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account KPIs: current balance, payment due amounts, credit limits, auto-pay enrollment, and account status for customer account management and credit risk."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., active, suspended, closed, delinquent)"
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., individual, group, COBRA, direct bill)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the account (e.g., current, past due, in collections, written off)"
    - name: "billing_method"
      expr: billing_method
      comment: "Billing method for the account (e.g., invoice, auto-pay, payroll deduction)"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the account (e.g., monthly, quarterly, annual)"
    - name: "auto_pay_enrollment"
      expr: auto_pay_enrollment
      comment: "Flag indicating whether the account is enrolled in auto-pay"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the account is set for auto-renewal"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether the account is tax-exempt"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether the account requires regulatory reporting"
    - name: "last_invoice_month"
      expr: DATE_TRUNC('MONTH', last_invoice_date)
      comment: "Last invoice date month for account activity trending"
    - name: "last_payment_month"
      expr: DATE_TRUNC('MONTH', last_payment_date)
      comment: "Last payment date month for payment behavior analysis"
  measures:
    - name: "Total Current Balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all accounts — primary accounts receivable and cash collection metric"
    - name: "Total Payment Due Amount"
      expr: SUM(CAST(payment_due_amount AS DOUBLE))
      comment: "Total payment due amount across all accounts — immediate cash collection target"
    - name: "Total Credit Limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to accounts — credit risk exposure metric"
    - name: "Total APTC Amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total APTC (Advance Premium Tax Credit) amount across accounts — tracks government subsidy exposure"
    - name: "Total Subsidy Amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount across accounts — tracks all subsidy types and government program support"
    - name: "Total Last Payment Amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total last payment amount across accounts — recent payment activity indicator"
    - name: "Account Count"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique billing accounts — customer base and billing population metric"
    - name: "Auto-Pay Enrollment Count"
      expr: SUM(CASE WHEN auto_pay_enrollment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts enrolled in auto-pay — payment automation and collections efficiency metric"
    - name: "Avg Current Balance Per Account"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account — account balance size and credit risk indicator"
    - name: "Avg Credit Limit Per Account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — credit policy and risk tolerance indicator"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_suspense_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspense account metrics tracking unmatched and unapplied payments — critical for cash management, operational efficiency, and financial close timeliness."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the suspense amount."
  measures:
    - name: "suspense_item_count"
      expr: COUNT(1)
      comment: "Total suspense items — operational backlog indicator for payment processing team."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over APTC subsidy records — tracks federal subsidy utilization, CMS reconciliation status, and year-to-date subsidy application to manage ACA marketplace financial risk."
  source: "`vibe_health_insurance_v1`.`billing`.`aptc_subsidy`"
  dimensions:
    - name: "aptc_subsidy_status"
      expr: aptc_subsidy_status
      comment: "Current status of the APTC subsidy (e.g., active, terminated, suspended) — primary dimension for subsidy portfolio management."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for the subsidy — tracks federal reconciliation exposure and potential clawback risk."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (e.g., APTC, CSR) — used to segment federal subsidy programs."
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-sharing reduction variant — used to segment CSR-eligible populations for actuarial and compliance analysis."
    - name: "exchange_code"
      expr: exchange_code
      comment: "Exchange through which the subsidy was granted — used to segment federal vs. state exchange subsidy populations."
    - name: "subsidy_effective_month"
      expr: DATE_TRUNC('MONTH', subsidy_effective_date)
      comment: "Month the subsidy became effective — enables monthly subsidy enrollment trend analysis."
    - name: "qhp_plan_code"
      expr: qhp_plan_code
      comment: "Qualified Health Plan code associated with the subsidy — used to analyze subsidy distribution across plan offerings."
  measures:
    - name: "total_aptc_subsidy_records"
      expr: COUNT(1)
      comment: "Total number of APTC subsidy records — baseline count for ACA marketplace enrollment monitoring."
    - name: "total_monthly_aptc_amount"
      expr: SUM(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Total monthly APTC subsidy amounts — primary federal subsidy cash flow metric for ACA financial management."
    - name: "total_annual_aptc_cap"
      expr: SUM(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Total annual APTC cap across all subsidy records — measures maximum federal subsidy exposure for the plan year."
    - name: "total_ytd_aptc_applied"
      expr: SUM(CAST(ytd_aptc_applied AS DOUBLE))
      comment: "Total year-to-date APTC applied — used to track subsidy utilization against annual caps and forecast CMS reconciliation."
    - name: "avg_monthly_aptc_per_member"
      expr: AVG(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Average monthly APTC subsidy per member — used to benchmark subsidy levels and assess affordability program effectiveness."
    - name: "active_subsidy_count"
      expr: COUNT(CASE WHEN aptc_subsidy_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active APTC subsidies — measures active ACA marketplace subsidized enrollment."
    - name: "unreconciled_subsidy_count"
      expr: COUNT(CASE WHEN cms_reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Count of subsidies not yet reconciled with CMS — measures federal reconciliation risk exposure."
    - name: "distinct_subsidized_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members receiving APTC subsidies — measures ACA marketplace subsidized population size."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cms_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over CMS remittance records — tracks federal payment flows, risk adjustment amounts, MLR rebate offsets, and reconciliation status to manage CMS financial settlement performance."
  source: "`vibe_health_insurance_v1`.`billing`.`cms_remittance`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of CMS payment (e.g., capitation, risk adjustment, MLR rebate) — used to segment federal payment flows by program."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current status of the remittance (e.g., received, reconciled, disputed) — primary dimension for CMS payment management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the remittance — tracks CMS payment reconciliation completeness."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission associated with the remittance — used to segment by program (e.g., EDGE, RAPS, HEDIS)."
    - name: "payment_period_start_month"
      expr: DATE_TRUNC('MONTH', payment_period_start)
      comment: "Month the CMS payment period begins — enables monthly federal payment trend analysis."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for CMS payment adjustment — used to categorize and resolve CMS payment discrepancies."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the remittance record is eligible for payment — used to scope payable CMS remittances."
  measures:
    - name: "total_remittance_records"
      expr: COUNT(1)
      comment: "Total number of CMS remittance records — baseline volume metric for CMS payment management."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross CMS payment amount — primary federal revenue metric for government program financial management."
    - name: "total_net_remittance_amount"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net CMS remittance after offsets — represents actual federal cash received for financial reporting."
    - name: "total_risk_adjustment_amount"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment amounts in CMS remittances — measures ACA risk adjustment program financial impact."
    - name: "total_mlr_rebate_offset_amount"
      expr: SUM(CAST(mlr_rebate_offset_amount AS DOUBLE))
      comment: "Total MLR rebate offsets applied to CMS remittances — measures MLR rebate impact on federal payment flows."
    - name: "avg_net_remittance_per_record"
      expr: AVG(CAST(net_remittance_amount AS DOUBLE))
      comment: "Average net CMS remittance per record — used to benchmark per-member federal payment levels."
    - name: "unreconciled_remittance_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Count of CMS remittances not yet reconciled — measures federal payment reconciliation risk."
    - name: "distinct_health_plans_in_remittance"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans receiving CMS remittances — measures CMS payment coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cobra_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over COBRA billing records — tracks COBRA premium collection, compliance with DOL/ERISA requirements, retroactive adjustments, and coverage continuity to manage COBRA program performance."
  source: "`vibe_health_insurance_v1`.`billing`.`cobra_billing`"
  dimensions:
    - name: "cobra_status"
      expr: cobra_status
      comment: "Current COBRA coverage status (e.g., active, terminated, lapsed) — primary dimension for COBRA portfolio management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for the COBRA billing cycle — used to identify delinquent COBRA participants."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for COBRA premium — used to analyze COBRA payment channel mix."
    - name: "billing_cycle_month"
      expr: billing_cycle_month
      comment: "Billing cycle month for the COBRA record — used for monthly COBRA billing trend analysis."
    - name: "compliance_flag_dol"
      expr: compliance_flag_dol
      comment: "DOL compliance flag — indicates whether COBRA administration meets Department of Labor requirements."
    - name: "compliance_flag_erisa"
      expr: compliance_flag_erisa
      comment: "ERISA compliance flag — indicates whether COBRA administration meets ERISA requirements."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Whether a retroactive adjustment was applied — used to identify COBRA billing corrections."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month COBRA coverage began — used for COBRA enrollment trend analysis."
  measures:
    - name: "total_cobra_billing_records"
      expr: COUNT(1)
      comment: "Total number of COBRA billing records — baseline volume metric for COBRA program management."
    - name: "total_cobra_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total COBRA premium billed — primary revenue metric for COBRA program financial management."
    - name: "total_cobra_premium_base"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total base COBRA premium (before admin fee) — used to validate COBRA premium calculation accuracy."
    - name: "total_admin_fee_amount"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total COBRA administrative fees collected — COBRA allows up to 2% admin fee; used to track fee revenue."
    - name: "total_retroactive_adjustment_amount"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive COBRA billing adjustments — high values signal enrollment data quality issues."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total COBRA refunds issued — used to track COBRA billing error rates and overpayment resolution."
    - name: "dol_non_compliant_count"
      expr: COUNT(CASE WHEN compliance_flag_dol = FALSE THEN 1 END)
      comment: "Count of COBRA records with DOL compliance issues — regulatory risk metric requiring immediate remediation."
    - name: "erisa_non_compliant_count"
      expr: COUNT(CASE WHEN compliance_flag_erisa = FALSE THEN 1 END)
      comment: "Count of COBRA records with ERISA compliance issues — regulatory risk metric requiring immediate remediation."
    - name: "distinct_cobra_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members on COBRA coverage — measures COBRA program enrollment size."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_collection_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over premium collection cases — tracks delinquency exposure, write-off rates, recovery performance, and reinstatement eligibility to steer revenue cycle and member retention programs."
  source: "`vibe_health_insurance_v1`.`billing`.`collection_case`"
  dimensions:
    - name: "collection_case_status"
      expr: collection_case_status
      comment: "Current status of the collection case (e.g., open, closed, referred to agency) — primary dimension for collections pipeline management."
    - name: "last_action_type"
      expr: last_action_type
      comment: "Most recent action taken on the collection case — used to track collections activity and escalation patterns."
    - name: "final_resolution"
      expr: final_resolution
      comment: "Final resolution outcome of the collection case — used to measure recovery success rates."
    - name: "reinstatement_eligibility_flag"
      expr: reinstatement_eligibility_flag
      comment: "Whether the member is eligible for reinstatement — used to identify members who can be retained after delinquency resolution."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_timestamp)
      comment: "Month the collection case was opened — enables monthly delinquency trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delinquent amount — used for multi-currency financial reporting."
  measures:
    - name: "total_collection_cases"
      expr: COUNT(1)
      comment: "Total number of collection cases — baseline volume metric for collections operations."
    - name: "total_delinquent_amount"
      expr: SUM(CAST(delinquent_amount AS DOUBLE))
      comment: "Total delinquent premium amount across all collection cases — primary financial exposure metric for revenue cycle leadership."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after adjustments — represents actual outstanding receivable balance in collections."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable — a key bad debt metric that directly impacts financial results."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to collection cases — used to track billing corrections within the collections process."
    - name: "avg_delinquent_amount_per_case"
      expr: AVG(CAST(delinquent_amount AS DOUBLE))
      comment: "Average delinquent amount per collection case — used to benchmark case severity and prioritize collection efforts."
    - name: "reinstatement_eligible_case_count"
      expr: COUNT(CASE WHEN reinstatement_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of collection cases where member is eligible for reinstatement — measures member retention opportunity in collections."
    - name: "distinct_members_in_collections"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with active collection cases — measures breadth of premium delinquency problem."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over billing disputes — tracks dispute volume, financial exposure, resolution rates, and regulatory reporting to steer member experience and billing accuracy programs."
  source: "`vibe_health_insurance_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, resolved, escalated) — primary dimension for dispute pipeline management."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute (e.g., premium amount, coverage, payment application) — used to identify systemic billing issues."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g., upheld, reversed, settled) — used to measure dispute outcome patterns."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the dispute (e.g., member, employer, provider) — used to segment dispute sources and root causes."
    - name: "open_timestamp_month"
      expr: DATE_TRUNC('MONTH', open_timestamp)
      comment: "Month the dispute was opened — enables monthly dispute volume trend analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the dispute requires regulatory reporting — scopes compliance reporting population."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount — used for multi-currency financial reporting."
  measures:
    - name: "total_disputes_opened"
      expr: COUNT(1)
      comment: "Total number of billing disputes opened — baseline volume metric; high counts signal billing quality issues."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount under dispute — primary financial exposure metric for billing dispute management."
    - name: "avg_disputed_amount_per_case"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case — used to benchmark dispute severity and prioritize resolution resources."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'OPEN' THEN 1 END)
      comment: "Count of currently open disputes — key operational metric for dispute resolution team capacity planning."
    - name: "resolved_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'RESOLVED' THEN 1 END)
      comment: "Count of resolved disputes — used to measure dispute resolution throughput."
    - name: "distinct_members_with_disputes"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of distinct subscribers with active or historical disputes — measures breadth of billing quality issues affecting members."
    - name: "regulatory_reportable_dispute_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of disputes requiring regulatory reporting — used to scope compliance filing obligations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over premium grace periods — tracks grace period utilization, APTC-eligible grace exposure, and termination risk to manage member retention and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`billing`.`grace_period`"
  dimensions:
    - name: "grace_period_status"
      expr: grace_period_status
      comment: "Current status of the grace period (e.g., active, expired, resolved) — primary dimension for grace period pipeline management."
    - name: "grace_period_type"
      expr: grace_period_type
      comment: "Type of grace period (e.g., standard, APTC, COBRA) — used to segment grace period populations by regulatory requirement."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the grace period (e.g., payment received, terminated, reinstated) — used to measure grace period resolution patterns."
    - name: "state_code"
      expr: state_code
      comment: "State associated with the grace period — state regulations vary on grace period length and requirements."
    - name: "is_eligible_for_aptc"
      expr: is_eligible_for_aptc
      comment: "Whether the grace period is for an APTC-eligible member — ACA requires 90-day grace periods for APTC recipients."
    - name: "extension_flag"
      expr: extension_flag
      comment: "Whether the grace period has been extended — used to track regulatory accommodations and hardship extensions."
    - name: "termination_warning_issued"
      expr: termination_warning_issued
      comment: "Whether a termination warning has been issued — used to track compliance with required member notifications."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the grace period began — enables monthly grace period trend analysis."
  measures:
    - name: "total_grace_periods"
      expr: COUNT(1)
      comment: "Total number of grace periods — baseline volume metric; high counts signal premium collection challenges."
    - name: "total_subsidy_amount_at_risk"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts associated with grace periods — measures federal subsidy at risk of clawback during grace periods."
    - name: "active_grace_period_count"
      expr: COUNT(CASE WHEN grace_period_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active grace periods — measures real-time member termination risk exposure."
    - name: "aptc_eligible_grace_period_count"
      expr: COUNT(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 END)
      comment: "Count of grace periods for APTC-eligible members — ACA mandates 90-day grace periods for this population; compliance metric."
    - name: "termination_warning_issued_count"
      expr: COUNT(CASE WHEN termination_warning_issued = TRUE THEN 1 END)
      comment: "Count of grace periods where termination warning was issued — measures compliance with required member notification obligations."
    - name: "distinct_members_in_grace"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members currently in or having had a grace period — measures breadth of premium delinquency risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level metrics providing granular premium billing analysis by coverage tier, rate type, and member — enables per-member premium analytics and employer/employee contribution tracking."
  source: "`vibe_health_insurance_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier of the invoice line (e.g., Employee Only, Employee+Spouse, Family)."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied (e.g., Age-Rated, Community-Rated, Composite)."
    - name: "premium_status"
      expr: premium_status
      comment: "Status of the premium line item (e.g., Active, Adjusted, Cancelled)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice line (e.g., Paid, Unpaid, Partial)."
    - name: "is_refund"
      expr: is_refund
      comment: "Whether this line represents a refund."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Whether this line is a retroactive adjustment."
    - name: "premium_currency"
      expr: premium_currency
      comment: "Currency of the premium amount."
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Billing period month for the invoice line."
    - name: "premium_reconciliation_flag"
      expr: premium_reconciliation_flag
      comment: "Whether this line has been reconciled."
  measures:
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across invoice lines — granular premium revenue."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer contribution to premiums — tracks employer share of premium funding."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee contribution to premiums — tracks member out-of-pocket premium burden."
    - name: "total_aptc_subsidy_amount"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy applied at the line level — ACA marketplace subsidy tracking."
    - name: "total_csr_adjustment"
      expr: SUM(CAST(csr_adjustment_amount AS DOUBLE))
      comment: "Total Cost Sharing Reduction adjustments — ACA CSR variant tracking."
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount across all invoice lines including taxes and adjustments."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total invoice line items — granularity indicator for billing detail."
    - name: "avg_premium_per_line"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per invoice line — per-member premium level indicator."
    - name: "retroactive_line_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retroactive adjustment lines — indicator of enrollment change churn impacting billing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_mlr_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over Medical Loss Ratio rebate records — tracks MLR compliance, rebate liability, and quality improvement spend to steer ACA regulatory compliance and financial planning."
  source: "`vibe_health_insurance_v1`.`billing`.`mlr_rebate`"
  dimensions:
    - name: "mlr_rebate_status"
      expr: mlr_rebate_status
      comment: "Current status of the MLR rebate (e.g., calculated, filed, disbursed) — primary dimension for rebate lifecycle management."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the MLR calculation (e.g., Individual, Small Group, Large Group) — ACA requires separate MLR calculations by market segment."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for the MLR calculation — used for regulatory segmentation and rebate liability allocation."
    - name: "state_code"
      expr: state_code
      comment: "State for which the MLR rebate applies — state-level MLR compliance is a regulatory requirement."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the MLR calculation — used for year-over-year MLR trend analysis."
    - name: "hhs_submission_status"
      expr: hhs_submission_status
      comment: "Status of HHS submission for the MLR rebate — tracks regulatory filing compliance."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used to disburse the rebate (e.g., check, premium credit) — used for operational planning of rebate distribution."
    - name: "eligibility_flag"
      expr: eligibility_flag
      comment: "Whether the plan is eligible for an MLR rebate — used to scope rebate liability population."
  measures:
    - name: "total_mlr_rebate_records"
      expr: COUNT(1)
      comment: "Total number of MLR rebate records — baseline count for compliance reporting."
    - name: "total_rebate_amount_due"
      expr: SUM(CAST(rebate_amount_due AS DOUBLE))
      comment: "Total MLR rebate liability — the primary financial exposure metric for ACA compliance; drives reserve planning."
    - name: "total_premium_earned"
      expr: SUM(CAST(total_premium_earned AS DOUBLE))
      comment: "Total premium earned used in MLR denominator — validates the premium base for MLR calculations."
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims used in MLR numerator — the primary cost driver in MLR compliance calculations."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses — QI spend counts toward MLR numerator and reduces rebate liability."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across plans — the headline ACA compliance metric; must meet 80% (individual/small group) or 85% (large group) thresholds."
    - name: "plans_below_mlr_threshold"
      expr: COUNT(CASE WHEN eligibility_flag = TRUE THEN 1 END)
      comment: "Count of plans with MLR rebate eligibility (below threshold) — measures regulatory compliance exposure breadth."
    - name: "distinct_health_plans_in_mlr"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans with MLR calculations — measures MLR reporting coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over payment allocation records — tracks payment application accuracy, overpayment exposure, suspense resolution, and variance management to steer cash application operations."
  source: "`vibe_health_insurance_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the payment allocation (e.g., applied, pending, reversed) — primary dimension for cash application pipeline management."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., premium, fee, tax) — used to segment payment application by component."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used — used to analyze allocation patterns by payment channel."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received — used to analyze cash application efficiency by channel."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the allocation — tracks GL reconciliation completeness."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation applied — used to segment reconciliation workload."
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Whether the allocation represents an overpayment — used to identify and manage overpayment recovery."
    - name: "is_suspense_resolution"
      expr: is_suspense_resolution
      comment: "Whether the allocation resolves a suspense item — used to track suspense clearance performance."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of payment allocation — enables monthly cash application trend analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of payment allocations — baseline volume metric for cash application operations."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoices — primary cash application volume metric."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed AS DOUBLE))
      comment: "Total billed amount associated with allocations — used to calculate collection rate."
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected AS DOUBLE))
      comment: "Total collected amount across allocations — used to measure cash collection effectiveness."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between billed and collected amounts — high variance signals payment application errors."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied during payment allocation — used to track pricing concession financial impact."
    - name: "total_adjustments_applied"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied during payment allocation — used to track billing correction volume."
    - name: "overpayment_allocation_count"
      expr: COUNT(CASE WHEN is_overpayment = TRUE THEN 1 END)
      comment: "Count of overpayment allocations — measures overpayment recovery workload."
    - name: "suspense_resolution_count"
      expr: COUNT(CASE WHEN is_suspense_resolution = TRUE THEN 1 END)
      comment: "Count of allocations resolving suspense items — measures suspense clearance throughput."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over premium invoices — tracks billed premium volume, subsidy utilization, collection health, and retroactive adjustment exposure across health plans and employer groups."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., issued, paid, overdue, voided) — primary operational segmentation for AR aging."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., regular, COBRA, retro) — used to segment premium billing by product line."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the invoice (e.g., Individual, Small Group, Medicare Advantage) — critical for regulatory and financial segmentation."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month the billing period begins — enables monthly premium revenue trend analysis."
    - name: "billing_period_end_month"
      expr: DATE_TRUNC('MONTH', billing_period_end)
      comment: "Month the billing period ends — used for period-over-period premium comparisons."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the invoice (e.g., current, delinquent, written-off) — drives AR management and collections prioritization."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied (e.g., APTC, CSR) — used to measure subsidy dependency and ACA compliance exposure."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice was delivered (e.g., electronic, paper) — used to track digital adoption and reduce print/mail costs."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether the invoice is subject to regulatory reporting — used to scope compliance reporting populations."
  measures:
    - name: "total_invoices_issued"
      expr: COUNT(1)
      comment: "Total number of premium invoices issued — baseline volume metric for billing operations throughput."
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total gross premium billed across all invoices — primary revenue exposure metric for finance and actuarial review."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after discounts and subsidies — represents actual receivable balance for AR management."
    - name: "total_subsidy_applied"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total APTC/CSR subsidy amounts applied across invoices — measures federal subsidy dependency and ACA program exposure."
    - name: "total_retroactive_adjustment_amount"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive billing adjustments — high values signal enrollment data quality issues or late eligibility changes."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts billed — used for tax liability reporting and regulatory compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to invoices — tracks pricing concessions and their financial impact."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued against invoices — elevated refund volume may indicate billing errors or retroactive terminations."
    - name: "avg_net_amount_due_per_invoice"
      expr: AVG(CAST(net_amount_due AS DOUBLE))
      comment: "Average net amount due per invoice — used to benchmark per-member billing levels and detect anomalies."
    - name: "subsidy_eligible_invoice_count"
      expr: COUNT(CASE WHEN is_eligible_for_subsidy = TRUE THEN 1 END)
      comment: "Count of invoices eligible for APTC/CSR subsidy — measures ACA marketplace enrollment scale."
    - name: "distinct_members_billed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members billed — measures billing reach and identifies gaps in premium collection."
    - name: "distinct_groups_billed"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups billed — used for group billing portfolio management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over premium payment transactions — tracks cash collection performance, suspense resolution, NSF rates, and payment channel mix to steer revenue cycle operations."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_payment`"
  dimensions:
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current status of the payment (e.g., posted, reversed, suspense, NSF) — primary dimension for payment health monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, check, credit card) — used to analyze payment channel mix and associated processing costs."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g., online portal, lockbox, EDI) — drives digital payment adoption strategy."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (e.g., regular, adjustment, reversal) — used to isolate net cash collections from adjustments."
    - name: "suspense_status"
      expr: suspense_status
      comment: "Suspense resolution status — identifies unresolved payments that cannot be applied to member accounts."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Whether the payment has been reconciled to the GL — critical for financial close accuracy."
    - name: "payment_timestamp_month"
      expr: DATE_TRUNC('MONTH', payment_timestamp)
      comment: "Month of payment receipt — enables monthly cash collection trend analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer making the payment (e.g., employer, individual, government) — used to segment collection performance by payer category."
  measures:
    - name: "total_payments_received"
      expr: COUNT(1)
      comment: "Total number of premium payment transactions — baseline volume metric for payment operations."
    - name: "total_payment_amount_collected"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross premium payments collected — primary cash collection KPI for finance leadership."
    - name: "total_net_amount_collected"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments — represents actual cash applied to member accounts."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments — high values indicate billing corrections or retroactive enrollment changes."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment amounts sitting in suspense — a key AR risk metric; high balances signal operational failures."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees — used to evaluate payment channel cost efficiency."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Count of NSF (non-sufficient funds) payments — elevated NSF rates signal member financial distress or billing errors."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average premium payment amount per transaction — used to benchmark per-member payment levels."
    - name: "distinct_members_paying"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members making payments — measures active premium-paying population size."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Count of payments not yet reconciled to the GL — drives financial close risk management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over premium reconciliation records — tracks reconciliation completeness, variance exposure, APTC subsidy accuracy, and MLR input quality to support financial close and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_reconciliation`"
  dimensions:
    - name: "premium_reconciliation_status"
      expr: premium_reconciliation_status
      comment: "Status of the reconciliation (e.g., pending, finalized, disputed) — primary dimension for reconciliation pipeline management."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., monthly, annual, CMS) — used to segment reconciliation workload by process type."
    - name: "state_code"
      expr: state_code
      comment: "State associated with the reconciliation — used for state-level regulatory reporting and market performance analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month the reconciliation period begins — enables monthly reconciliation trend analysis."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the reconciliation has been finalized — used to track financial close progress."
    - name: "mlr_input_flag"
      expr: mlr_input_flag
      comment: "Whether this reconciliation feeds into MLR calculations — scopes the MLR-eligible reconciliation population."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this reconciliation is subject to regulatory reporting — used to scope compliance populations."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for reconciliation variance — used to categorize and prioritize variance resolution."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of reconciliation records — baseline volume metric for reconciliation operations."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total premium billed across reconciliation periods — used to validate billing completeness."
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected_amount AS DOUBLE))
      comment: "Total premium collected across reconciliation periods — primary cash collection confirmation metric."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance (billed vs collected) — high variance signals billing or payment processing failures requiring investigation."
    - name: "total_aptc_subsidy_amount"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts reconciled — used to validate federal subsidy accuracy and CMS reconciliation exposure."
    - name: "total_adjustments_amount"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total adjustment amounts applied during reconciliation — high values indicate retroactive enrollment or rate changes."
    - name: "total_net_premium_amount"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after adjustments and subsidies — the definitive earned premium figure for financial reporting."
    - name: "avg_variance_per_reconciliation"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance per reconciliation record — used to benchmark reconciliation quality and set tolerance thresholds."
    - name: "finalized_reconciliation_count"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN 1 END)
      comment: "Count of finalized reconciliations — measures financial close completeness."
    - name: "mlr_eligible_reconciliation_count"
      expr: COUNT(CASE WHEN mlr_input_flag = TRUE THEN 1 END)
      comment: "Count of reconciliations feeding MLR calculations — used to validate MLR reporting population completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over premium refund records — tracks refund volume, financial exposure, approval rates, and regulatory reporting to manage billing accuracy and member satisfaction."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_refund`"
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g., overpayment, retroactive termination, MLR rebate) — used to categorize refund root causes."
    - name: "refund_reason_code"
      expr: refund_reason_code
      comment: "Reason code for the refund — used to identify systemic billing issues driving refund volume."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the refund (e.g., pending, approved, denied) — used to track refund processing pipeline."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g., check, ACH, premium credit) — used for refund operations planning."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the refund (e.g., initiated, processed, cleared) — used to track refund processing completeness."
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Whether the refund is partial — used to identify cases where full refund was not issued."
    - name: "is_tax_refund"
      expr: is_tax_refund
      comment: "Whether the refund includes a tax component — used for tax liability reporting."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the refund requires regulatory reporting — scopes compliance reporting population."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the refund was issued — enables monthly refund trend analysis."
  measures:
    - name: "total_refunds_issued"
      expr: COUNT(1)
      comment: "Total number of premium refunds issued — baseline volume metric; high counts signal billing accuracy issues."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total premium refund amount — primary financial exposure metric for billing accuracy management."
    - name: "total_original_payment_amount"
      expr: SUM(CAST(original_payment_amount AS DOUBLE))
      comment: "Total original payment amounts associated with refunds — used to calculate refund rate as a percentage of collected premiums."
    - name: "total_refund_processing_fee"
      expr: SUM(CAST(refund_processing_fee AS DOUBLE))
      comment: "Total refund processing fees — used to assess operational cost of billing errors."
    - name: "total_tax_refund_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts refunded — used for tax liability reconciliation."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per record — used to benchmark refund severity and identify outliers."
    - name: "pending_approval_refund_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Count of refunds pending approval — measures refund processing backlog and operational efficiency."
    - name: "distinct_members_receiving_refunds"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members receiving refunds — measures breadth of billing accuracy issues affecting members."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over premium rate schedules — tracks rate schedule coverage, filing compliance, wellness and tobacco surcharge adoption, and rate level benchmarks to support actuarial and regulatory rate management."
  source: "`vibe_health_insurance_v1`.`billing`.`rate_schedule`"
  dimensions:
    - name: "rate_schedule_status"
      expr: rate_schedule_status
      comment: "Current status of the rate schedule (e.g., active, expired, pending approval) — primary dimension for rate schedule lifecycle management."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for the rate schedule (e.g., Individual, Small Group, Large Group) — used for regulatory rate segmentation."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area — ACA requires rating area-based premium rates; used for geographic rate analysis."
    - name: "rating_method"
      expr: rating_method
      comment: "Rating methodology used (e.g., community rating, experience rating) — used to segment rate development approaches."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage the rate schedule applies to — used to segment rate schedules by product type."
    - name: "filing_status"
      expr: filing_status
      comment: "DOI filing status of the rate schedule — tracks regulatory rate filing compliance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate schedule becomes effective — used for rate change trend analysis."
    - name: "tobacco_surcharge_flag"
      expr: tobacco_surcharge_flag
      comment: "Whether a tobacco surcharge applies — used to measure tobacco surcharge program adoption."
    - name: "wellness_discount_flag"
      expr: wellness_discount_flag
      comment: "Whether a wellness discount applies — used to measure wellness incentive program adoption."
    - name: "is_default_schedule"
      expr: is_default_schedule
      comment: "Whether this is the default rate schedule — used to identify the primary rate schedule for each plan."
  measures:
    - name: "total_rate_schedules"
      expr: COUNT(1)
      comment: "Total number of rate schedules — baseline count for rate schedule portfolio management."
    - name: "total_base_rate_amount"
      expr: SUM(CAST(rate_amount AS DOUBLE))
      comment: "Sum of base rate amounts across all schedules — used to benchmark overall rate level portfolio."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average premium rate amount — used to benchmark rate levels across markets and rating areas."
    - name: "avg_employee_contribution_rate"
      expr: AVG(CAST(employee_contribution_rate AS DOUBLE))
      comment: "Average employee contribution rate — used to assess member affordability and benefit design competitiveness."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate — used to assess employer cost burden and group benefit competitiveness."
    - name: "avg_tobacco_surcharge_rate"
      expr: AVG(CAST(tobacco_surcharge_rate AS DOUBLE))
      comment: "Average tobacco surcharge rate — used to evaluate tobacco surcharge program design and ACA compliance."
    - name: "avg_wellness_discount_rate"
      expr: AVG(CAST(wellness_discount_rate AS DOUBLE))
      comment: "Average wellness discount rate — used to evaluate wellness incentive program financial impact."
    - name: "active_rate_schedule_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active rate schedules — measures active rate schedule portfolio size."
    - name: "filed_rate_schedule_count"
      expr: COUNT(CASE WHEN filing_status = 'FILED' THEN 1 END)
      comment: "Count of rate schedules with DOI filing status of FILED — measures regulatory rate filing compliance."
    - name: "distinct_health_plans_with_rates"
      expr: COUNT(DISTINCT rate_health_plan_id)
      comment: "Number of distinct health plans with active rate schedules — measures rate schedule coverage completeness."
$$;
