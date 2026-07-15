-- Metric views for domain: billing | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core premium billing KPIs tracking invoice amounts, subsidy utilization, collection effectiveness, and revenue realization across billing periods and member segments."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the premium invoice (e.g., issued, paid, overdue, cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., initial, renewal, adjustment, retroactive)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the invoice (e.g., Individual, Small Group, Large Group, Medicare, Medicaid)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status indicating payment progress (e.g., current, delinquent, in grace period, written off)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment is expected or received (e.g., online, mail, auto-pay, agent)"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied to the invoice (e.g., APTC, CSR, state subsidy, employer subsidy)"
    - name: "is_eligible_for_subsidy"
      expr: is_eligible_for_subsidy
      comment: "Boolean flag indicating whether the invoice is eligible for subsidy assistance"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Boolean flag indicating whether this invoice must be included in regulatory reporting"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the billing period start date for time-series analysis"
    - name: "billing_period_year"
      expr: YEAR(billing_period_start)
      comment: "Year of the billing period start date for annual trending"
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of the invoice due date for cash flow forecasting"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month when the invoice was issued for operational tracking"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of premium invoices issued"
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total gross premium amount billed before subsidies and adjustments"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount applied across all invoices (APTC, CSR, etc.)"
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due from members after subsidies and adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "total_retroactive_adjustment"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustment amount applied to invoices for prior period corrections"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued to members"
    - name: "avg_premium_per_invoice"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average gross premium amount per invoice"
    - name: "avg_net_due_per_invoice"
      expr: AVG(CAST(net_amount_due AS DOUBLE))
      comment: "Average net amount due per invoice after subsidies"
    - name: "subsidy_penetration_rate"
      expr: ROUND(100.0 * SUM(CAST(subsidy_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total premium covered by subsidies, indicating subsidy program utilization"
    - name: "member_responsibility_rate"
      expr: ROUND(100.0 * SUM(CAST(net_amount_due AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total premium that is member responsibility after subsidies"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members with invoices in the period"
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique billing accounts with invoices in the period"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment realization and cash collection KPIs tracking payment amounts, channels, reconciliation status, and suspense resolution effectiveness."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_payment`"
  dimensions:
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current status of the payment (e.g., posted, pending, failed, reversed, refunded)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g., online portal, ACH, check, credit card, agent)"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer making the payment (e.g., member, employer, government, third-party)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (e.g., premium payment, refund, adjustment, reversal)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation to invoices (e.g., reconciled, pending, unmatched, disputed)"
    - name: "suspense_status"
      expr: suspense_status
      comment: "Status of payment in suspense (e.g., in suspense, resolved, escalated, written off)"
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Boolean flag indicating non-sufficient funds (NSF) or payment failure"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_timestamp)
      comment: "Month when payment was received for cash flow analysis"
    - name: "payment_year"
      expr: YEAR(payment_timestamp)
      comment: "Year when payment was received for annual trending"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of suspense resolution (e.g., applied, refunded, written off, pending)"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions received"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount received from all payers"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees charged on payments (e.g., processing fees, convenience fees)"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to payments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount included in payments"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices (in suspense or pending allocation)"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "nsf_payment_count"
      expr: SUM(CASE WHEN nsf_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payments that failed due to non-sufficient funds"
    - name: "nsf_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nsf_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that failed due to NSF, indicating payment risk"
    - name: "fee_burden_rate"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payment amount consumed by fees, indicating payment channel cost efficiency"
    - name: "unapplied_payment_rate"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payment amount not yet applied to invoices, indicating reconciliation backlog"
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_account_number)
      comment: "Number of unique payer accounts making payments in the period"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members associated with payments in the period"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment-to-invoice matching and reconciliation KPIs tracking allocation effectiveness, variance resolution, and cash application accuracy."
  source: "`vibe_health_insurance_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the payment allocation (e.g., allocated, pending, reversed, adjusted)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., standard, partial, overpayment, underpayment, suspense resolution)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of reconciliation between payment and invoice (e.g., reconciled, variance, disputed, pending)"
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation performed (e.g., automatic, manual, batch, exception)"
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Boolean flag indicating whether the allocation represents an overpayment"
    - name: "is_suspense_resolution"
      expr: is_suspense_resolution
      comment: "Boolean flag indicating whether the allocation resolves a suspense item"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was received"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., ACH, credit card, check, wire transfer)"
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for variance between payment and invoice amount (e.g., partial payment, overpayment, discount, adjustment)"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month when the allocation was performed for operational tracking"
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year when the allocation was performed for annual trending"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of payment allocation transactions"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated from payments to invoices"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed AS DOUBLE))
      comment: "Total invoice amount that was billed"
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected AS DOUBLE))
      comment: "Total amount collected through allocations"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount between billed and collected amounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied during allocation"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount included in allocations"
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustment amount applied during allocation"
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average amount allocated per transaction"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(total_collected AS DOUBLE)) / NULLIF(SUM(CAST(total_billed AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount successfully collected, indicating collection effectiveness"
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount represented by variance, indicating reconciliation accuracy"
    - name: "overpayment_count"
      expr: SUM(CASE WHEN is_overpayment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of allocations representing overpayments requiring refund or credit"
    - name: "suspense_resolution_count"
      expr: SUM(CASE WHEN is_suspense_resolution = TRUE THEN 1 ELSE 0 END)
      comment: "Count of allocations that resolved suspense items, indicating reconciliation backlog clearance"
    - name: "distinct_invoice_line_count"
      expr: COUNT(DISTINCT invoice_line_id)
      comment: "Number of unique invoice lines receiving payment allocations"
    - name: "distinct_payment_count"
      expr: COUNT(DISTINCT premium_payment_id)
      comment: "Number of unique payments allocated to invoices"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace period management and coverage continuity KPIs tracking grace period utilization, resolution outcomes, and termination risk."
  source: "`vibe_health_insurance_v1`.`billing`.`grace_period`"
  dimensions:
    - name: "grace_period_status"
      expr: grace_period_status
      comment: "Current status of the grace period (e.g., active, resolved, expired, extended, terminated)"
    - name: "grace_period_type"
      expr: grace_period_type
      comment: "Type of grace period (e.g., standard, extended, regulatory, special enrollment)"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the grace period (e.g., payment received, coverage terminated, subsidy applied, waived)"
    - name: "extension_flag"
      expr: extension_flag
      comment: "Boolean flag indicating whether the grace period was extended beyond standard duration"
    - name: "termination_warning_issued"
      expr: termination_warning_issued
      comment: "Boolean flag indicating whether a termination warning was issued to the member"
    - name: "is_eligible_for_aptc"
      expr: is_eligible_for_aptc
      comment: "Boolean flag indicating whether the member is eligible for APTC subsidy during grace period"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Boolean flag indicating whether this grace period must be included in regulatory reporting"
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction code for the grace period, relevant for state-specific regulations"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for entering grace period (e.g., non-payment, late payment, system error)"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the grace period started for trend analysis"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year when the grace period started for annual trending"
  measures:
    - name: "total_grace_period_count"
      expr: COUNT(1)
      comment: "Total number of grace period events"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount applied during grace periods"
    - name: "avg_subsidy_per_grace_period"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per grace period event"
    - name: "extension_count"
      expr: SUM(CASE WHEN extension_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of grace periods that were extended beyond standard duration"
    - name: "extension_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN extension_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods that required extension, indicating payment difficulty"
    - name: "termination_warning_count"
      expr: SUM(CASE WHEN termination_warning_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of grace periods where termination warnings were issued"
    - name: "termination_warning_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN termination_warning_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods requiring termination warnings, indicating coverage risk"
    - name: "aptc_eligible_count"
      expr: SUM(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 ELSE 0 END)
      comment: "Count of grace periods where member was eligible for APTC subsidy"
    - name: "aptc_eligibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods with APTC eligibility, indicating subsidy program reach"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members entering grace periods"
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique billing accounts entering grace periods"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Premium Tax Credit (APTC) subsidy program KPIs tracking subsidy utilization, reconciliation status, and annual cap management."
  source: "`vibe_health_insurance_v1`.`billing`.`aptc_subsidy`"
  dimensions:
    - name: "aptc_subsidy_status"
      expr: aptc_subsidy_status
      comment: "Current status of the APTC subsidy (e.g., active, suspended, terminated, reconciled)"
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "Status of CMS reconciliation for the subsidy (e.g., pending, reconciled, variance, disputed)"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (e.g., APTC, CSR, state subsidy, special program)"
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-Sharing Reduction variant level (e.g., 73%, 87%, 94%)"
    - name: "exchange_code"
      expr: exchange_code
      comment: "Health insurance exchange code where subsidy was issued"
    - name: "qhp_plan_code"
      expr: qhp_plan_code
      comment: "Qualified Health Plan code associated with the subsidy"
    - name: "subsidy_effective_month"
      expr: DATE_TRUNC('MONTH', subsidy_effective_date)
      comment: "Month when subsidy became effective for trend analysis"
    - name: "subsidy_effective_year"
      expr: YEAR(subsidy_effective_date)
      comment: "Year when subsidy became effective for annual trending"
  measures:
    - name: "total_subsidy_count"
      expr: COUNT(1)
      comment: "Total number of APTC subsidy records"
    - name: "total_aptc_monthly_amount"
      expr: SUM(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Total monthly APTC subsidy amount across all members"
    - name: "total_annual_aptc_cap"
      expr: SUM(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Total annual APTC cap amount across all members"
    - name: "total_ytd_aptc_applied"
      expr: SUM(CAST(ytd_aptc_applied AS DOUBLE))
      comment: "Total year-to-date APTC amount applied across all members"
    - name: "avg_aptc_monthly_amount"
      expr: AVG(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Average monthly APTC subsidy amount per member"
    - name: "avg_annual_aptc_cap"
      expr: AVG(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Average annual APTC cap per member"
    - name: "aptc_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(ytd_aptc_applied AS DOUBLE)) / NULLIF(SUM(CAST(annual_aptc_cap AS DOUBLE)), 0), 2)
      comment: "Percentage of annual APTC cap utilized year-to-date, indicating subsidy consumption pace"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members receiving APTC subsidies"
    - name: "distinct_plan_election_count"
      expr: COUNT(DISTINCT plan_election_id)
      comment: "Number of unique plan elections with APTC subsidies"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cms_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS payment and risk adjustment remittance KPIs tracking government payments, risk adjustment amounts, MLR rebate offsets, and reconciliation status."
  source: "`vibe_health_insurance_v1`.`billing`.`cms_remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current status of the CMS remittance (e.g., received, pending, reconciled, disputed)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of reconciliation between remittance and internal records (e.g., reconciled, variance, pending)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of CMS payment (e.g., premium subsidy, risk adjustment, reinsurance, MLR rebate)"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission that triggered the remittance (e.g., enrollment, RAPS, EDGE, HEDIS)"
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for payment adjustment (e.g., risk score change, enrollment correction, retroactive adjustment)"
    - name: "is_eligible"
      expr: is_eligible
      comment: "Boolean flag indicating whether the remittance is eligible for payment"
    - name: "payment_period_month"
      expr: DATE_TRUNC('MONTH', payment_period_start)
      comment: "Month of the payment period start date for trend analysis"
    - name: "payment_period_year"
      expr: YEAR(payment_period_start)
      comment: "Year of the payment period start date for annual trending"
    - name: "remittance_month"
      expr: DATE_TRUNC('MONTH', remittance_timestamp)
      comment: "Month when remittance was received for cash flow analysis"
  measures:
    - name: "total_remittance_count"
      expr: COUNT(1)
      comment: "Total number of CMS remittance transactions"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross payment amount received from CMS before adjustments"
    - name: "total_net_remittance_amount"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net remittance amount received from CMS after all adjustments"
    - name: "total_risk_adjustment_amount"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment amount (positive or negative) applied to remittances"
    - name: "total_mlr_rebate_offset"
      expr: SUM(CAST(mlr_rebate_offset_amount AS DOUBLE))
      comment: "Total Medical Loss Ratio rebate offset amount deducted from remittances"
    - name: "avg_gross_payment"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross payment amount per remittance transaction"
    - name: "avg_net_remittance"
      expr: AVG(CAST(net_remittance_amount AS DOUBLE))
      comment: "Average net remittance amount per transaction after adjustments"
    - name: "risk_adjustment_impact_rate"
      expr: ROUND(100.0 * SUM(CAST(risk_adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage impact of risk adjustment on gross payment, indicating risk score accuracy"
    - name: "mlr_rebate_offset_rate"
      expr: ROUND(100.0 * SUM(CAST(mlr_rebate_offset_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payment offset by MLR rebate obligations"
    - name: "net_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(net_remittance_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payment realized as net remittance after all adjustments"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members associated with CMS remittances"
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique billing accounts associated with CMS remittances"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account health and portfolio KPIs tracking account balances, payment behavior, auto-pay adoption, and credit risk."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., active, suspended, closed, delinquent)"
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., individual, family, group, employer-sponsored)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the account (e.g., current, past due, in collections, written off)"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing for the account (e.g., monthly, quarterly, annual)"
    - name: "billing_method"
      expr: billing_method
      comment: "Method of billing (e.g., electronic, paper, email, portal)"
    - name: "billing_cycle_type"
      expr: billing_cycle_type
      comment: "Type of billing cycle (e.g., calendar month, anniversary, custom)"
    - name: "auto_pay_enrollment"
      expr: auto_pay_enrollment
      comment: "Boolean flag indicating whether account is enrolled in auto-pay"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean flag indicating whether account is set for auto-renewal"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Boolean flag indicating whether account is tax-exempt"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Boolean flag indicating whether account must be included in regulatory reporting"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the account (e.g., net 30, due on receipt, installment)"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when account was created for cohort analysis"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when account was created for annual trending"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all accounts, indicating outstanding receivables"
    - name: "total_payment_due_amount"
      expr: SUM(CAST(payment_due_amount AS DOUBLE))
      comment: "Total payment amount currently due across all accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total amount of last payments received across all accounts"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount applied across all accounts"
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total APTC subsidy amount across all accounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate across accounts"
    - name: "avg_apr_rate"
      expr: AVG(CAST(apr_rate AS DOUBLE))
      comment: "Average annual percentage rate (APR) across accounts with financing"
    - name: "auto_pay_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_pay_enrollment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts enrolled in auto-pay, indicating payment automation adoption"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts set for auto-renewal, indicating retention likelihood"
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of credit limit utilized across accounts, indicating credit risk exposure"
    - name: "subsidy_penetration_rate"
      expr: ROUND(100.0 * SUM(CAST(subsidy_amount AS DOUBLE)) / NULLIF(SUM(CAST(pmpm_rate AS DOUBLE)), 0), 2)
      comment: "Percentage of PMPM rate covered by subsidies, indicating subsidy program reach"
$$;
