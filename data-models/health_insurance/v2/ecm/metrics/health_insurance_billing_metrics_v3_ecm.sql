-- Metric views for domain: billing | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium invoice KPIs tracking billing volume, revenue, collection efficiency, and subsidy impact across health plans and member populations"
  source: "`vibe_health_insurance_v1`.`billing`.`premium_invoice`"
  dimensions:
    - name: "invoice_year_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Invoice issue month for time-series trending"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (paid, pending, overdue, etc.)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, adjustment, supplemental)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status indicating payment progress"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, credit card, check, etc.)"
    - name: "is_subsidy_eligible"
      expr: is_eligible_for_subsidy
      comment: "Whether invoice is eligible for APTC or other subsidies"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Billing period start month for coverage analysis"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of premium invoices issued"
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount billed across all invoices"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount (APTC, CSR) applied to invoices"
    - name: "total_net_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after subsidies and adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "total_retro_adjustment"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustment amount applied to invoices"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued on invoices"
    - name: "avg_premium_per_invoice"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium amount per invoice"
    - name: "avg_net_due_per_invoice"
      expr: AVG(CAST(net_amount_due AS DOUBLE))
      comment: "Average net amount due per invoice after adjustments"
    - name: "subsidy_penetration_pct"
      expr: ROUND(100.0 * SUM(CAST(subsidy_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total premium covered by subsidies"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total premium reduced by discounts"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members invoiced"
    - name: "distinct_group_count"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups invoiced"
    - name: "distinct_plan_count"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans invoiced"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium payment KPIs tracking collection performance, payment velocity, suspense resolution, and cash flow efficiency"
  source: "`vibe_health_insurance_v1`.`billing`.`premium_payment`"
  dimensions:
    - name: "payment_year_month"
      expr: DATE_TRUNC('MONTH', payment_timestamp)
      comment: "Payment received month for cash flow trending"
    - name: "payment_status"
      expr: premium_payment_status
      comment: "Current status of the payment (cleared, pending, failed, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, credit card, check, wire)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (online, mail, phone, agent)"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (member, employer, government, third-party)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status indicating whether payment is matched to invoice"
    - name: "suspense_status"
      expr: suspense_status
      comment: "Suspense status for unallocated or mismatched payments"
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Whether payment was returned for non-sufficient funds"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (payment, refund, adjustment)"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of premium payments received"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount received"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees charged"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to payments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount included in payments"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet allocated to invoices"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "nsf_payment_count"
      expr: SUM(CASE WHEN nsf_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payments returned for non-sufficient funds"
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN nsf_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned for NSF"
    - name: "fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Payment processing fee as percentage of payment amount"
    - name: "unapplied_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payment amount not yet allocated to invoices"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members making payments"
    - name: "distinct_group_count"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups making payments"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT premium_invoice_id)
      comment: "Distinct count of invoices receiving payments"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium reconciliation KPIs tracking billing accuracy, variance analysis, and financial close efficiency across billing periods"
  source: "`vibe_health_insurance_v1`.`billing`.`premium_reconciliation`"
  dimensions:
    - name: "reconciliation_year_month"
      expr: DATE_TRUNC('MONTH', reconciliation_timestamp)
      comment: "Reconciliation completion month for close cycle trending"
    - name: "reconciliation_status"
      expr: premium_reconciliation_status
      comment: "Current status of reconciliation (pending, approved, rejected)"
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (monthly, quarterly, annual, ad-hoc)"
    - name: "period_year_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Billing period start month being reconciled"
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether reconciliation has been finalized and locked"
    - name: "mlr_input_flag"
      expr: mlr_input_flag
      comment: "Whether reconciliation feeds into MLR calculation"
    - name: "state_code"
      expr: state_code
      comment: "State code for regulatory reporting segmentation"
  measures:
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of premium reconciliations performed"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total premium amount billed in reconciliation period"
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected_amount AS DOUBLE))
      comment: "Total premium amount collected in reconciliation period"
    - name: "total_adjustments_amount"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total adjustment amount applied during reconciliation"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between billed and collected amounts"
    - name: "total_net_premium"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after all adjustments and subsidies"
    - name: "total_aptc_subsidy"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amount reconciled"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_collected_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed premium successfully collected"
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Variance as percentage of billed amount"
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_adjustments_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Adjustments as percentage of billed amount"
    - name: "avg_variance_per_reconciliation"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance amount per reconciliation"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members included in reconciliation"
    - name: "distinct_group_count"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups included in reconciliation"
    - name: "distinct_plan_count"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans included in reconciliation"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_collection_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection case KPIs tracking delinquency management, recovery performance, and write-off efficiency"
  source: "`vibe_health_insurance_v1`.`billing`.`collection_case`"
  dimensions:
    - name: "case_open_year_month"
      expr: DATE_TRUNC('MONTH', case_open_timestamp)
      comment: "Month when collection case was opened"
    - name: "case_status"
      expr: collection_case_status
      comment: "Current status of collection case (open, closed, escalated, resolved)"
    - name: "final_resolution"
      expr: final_resolution
      comment: "Final resolution outcome (paid, written off, payment plan, etc.)"
    - name: "last_action_type"
      expr: last_action_type
      comment: "Type of last action taken on case (call, letter, legal, etc.)"
    - name: "delinquency_age_bucket"
      expr: CASE WHEN CAST(delinquency_age_days AS INT) <= 30 THEN '0-30 days' WHEN CAST(delinquency_age_days AS INT) <= 60 THEN '31-60 days' WHEN CAST(delinquency_age_days AS INT) <= 90 THEN '61-90 days' ELSE '90+ days' END
      comment: "Delinquency age bucket for aging analysis"
    - name: "reinstatement_eligibility_flag"
      expr: reinstatement_eligibility_flag
      comment: "Whether member is eligible for reinstatement after payment"
  measures:
    - name: "case_count"
      expr: COUNT(1)
      comment: "Total number of collection cases"
    - name: "total_delinquent_amount"
      expr: SUM(CAST(delinquent_amount AS DOUBLE))
      comment: "Total delinquent amount across all collection cases"
    - name: "total_net_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to collection cases"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "avg_delinquent_amount"
      expr: AVG(CAST(delinquent_amount AS DOUBLE))
      comment: "Average delinquent amount per collection case"
    - name: "avg_delinquency_age_days"
      expr: AVG(CAST(delinquency_age_days AS INT))
      comment: "Average age of delinquency in days"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(delinquent_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of delinquent amount written off"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(delinquent_amount AS DOUBLE)) - SUM(CAST(net_amount_due AS DOUBLE))) / NULLIF(SUM(CAST(delinquent_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of delinquent amount recovered"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with collection cases"
    - name: "distinct_case_owner_count"
      expr: COUNT(DISTINCT case_owner_employee_id)
      comment: "Distinct count of employees managing collection cases"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_mlr_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MLR rebate KPIs tracking medical loss ratio compliance, rebate liability, and regulatory filing performance"
  source: "`vibe_health_insurance_v1`.`billing`.`mlr_rebate`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Calendar year for which MLR is calculated and reported"
    - name: "mlr_rebate_status"
      expr: mlr_rebate_status
      comment: "Current status of MLR rebate (calculated, approved, disbursed)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Individual, Small Group, Large Group)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Exchange, Off-Exchange, Employer)"
    - name: "state_code"
      expr: state_code
      comment: "State code for regulatory jurisdiction"
    - name: "eligibility_flag"
      expr: eligibility_flag
      comment: "Whether plan is eligible for MLR rebate calculation"
    - name: "hhs_submission_status"
      expr: hhs_submission_status
      comment: "Status of HHS submission (pending, submitted, accepted, rejected)"
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method of rebate disbursement (check, premium credit, direct deposit)"
  measures:
    - name: "rebate_count"
      expr: COUNT(1)
      comment: "Total number of MLR rebate calculations"
    - name: "total_premium_earned"
      expr: SUM(CAST(total_premium_earned AS DOUBLE))
      comment: "Total premium earned for MLR calculation"
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims for MLR calculation"
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses included in MLR"
    - name: "total_rebate_due"
      expr: SUM(CAST(rebate_amount_due AS DOUBLE))
      comment: "Total rebate amount due to members"
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across all calculations"
    - name: "avg_rebate_per_calculation"
      expr: AVG(CAST(rebate_amount_due AS DOUBLE))
      comment: "Average rebate amount per MLR calculation"
    - name: "rebate_liability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rebate_amount_due AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_earned AS DOUBLE)), 0), 2)
      comment: "Rebate liability as percentage of premium earned"
    - name: "claims_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(total_incurred_claims AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_earned AS DOUBLE)), 0), 2)
      comment: "Incurred claims as percentage of premium earned (MLR numerator)"
    - name: "distinct_plan_count"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans with MLR rebate calculations"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cobra_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA billing KPIs tracking continuation coverage billing, compliance, and payment performance"
  source: "`vibe_health_insurance_v1`.`billing`.`cobra_billing`"
  dimensions:
    - name: "billing_year_month"
      expr: DATE_TRUNC('MONTH', billing_issue_timestamp)
      comment: "Month when COBRA billing was issued"
    - name: "cobra_status"
      expr: cobra_status
      comment: "Current status of COBRA coverage (active, terminated, grace period)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (paid, pending, overdue, defaulted)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, check, credit card)"
    - name: "compliance_flag_dol"
      expr: compliance_flag_dol
      comment: "Whether billing meets DOL compliance requirements"
    - name: "compliance_flag_erisa"
      expr: compliance_flag_erisa
      comment: "Whether billing meets ERISA compliance requirements"
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Whether billing includes retroactive adjustments"
    - name: "coverage_year_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month when COBRA coverage started"
  measures:
    - name: "cobra_billing_count"
      expr: COUNT(1)
      comment: "Total number of COBRA billing records"
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total COBRA premium amount billed"
    - name: "total_admin_fee"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total administrative fee charged for COBRA administration"
    - name: "total_billing_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total COBRA billing amount including premium and fees"
    - name: "total_retro_adjustment"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustment amount applied to COBRA billing"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued for COBRA overpayments"
    - name: "avg_premium_per_billing"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average COBRA premium per billing record"
    - name: "admin_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(admin_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(premium_amount AS DOUBLE)), 0), 2)
      comment: "Administrative fee as percentage of premium"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with COBRA billing"
    - name: "distinct_group_count"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups with COBRA billing"
    - name: "distinct_plan_count"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans with COBRA billing"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APTC subsidy KPIs tracking advance premium tax credit utilization, reconciliation, and marketplace compliance"
  source: "`vibe_health_insurance_v1`.`billing`.`aptc_subsidy`"
  dimensions:
    - name: "subsidy_year_month"
      expr: DATE_TRUNC('MONTH', subsidy_effective_date)
      comment: "Month when APTC subsidy became effective"
    - name: "aptc_status"
      expr: aptc_subsidy_status
      comment: "Current status of APTC subsidy (active, terminated, suspended)"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (APTC, CSR, state subsidy)"
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-sharing reduction variant (73, 87, 94)"
    - name: "exchange_code"
      expr: exchange_code
      comment: "Exchange code identifying the marketplace"
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status (pending, reconciled, disputed)"
  measures:
    - name: "subsidy_count"
      expr: COUNT(1)
      comment: "Total number of APTC subsidy records"
    - name: "total_monthly_aptc"
      expr: SUM(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Total monthly APTC subsidy amount"
    - name: "total_annual_aptc_cap"
      expr: SUM(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Total annual APTC cap across all subsidies"
    - name: "total_ytd_aptc_applied"
      expr: SUM(CAST(ytd_aptc_applied AS DOUBLE))
      comment: "Total year-to-date APTC subsidy applied"
    - name: "avg_monthly_aptc"
      expr: AVG(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Average monthly APTC subsidy per member"
    - name: "avg_annual_aptc_cap"
      expr: AVG(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Average annual APTC cap per member"
    - name: "aptc_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(ytd_aptc_applied AS DOUBLE)) / NULLIF(SUM(CAST(annual_aptc_cap AS DOUBLE)), 0), 2)
      comment: "Percentage of annual APTC cap utilized year-to-date"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members receiving APTC subsidy"
    - name: "distinct_plan_count"
      expr: COUNT(DISTINCT plan_health_plan_id)
      comment: "Distinct count of health plans with APTC subsidy"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute KPIs tracking dispute volume, resolution efficiency, and financial impact"
  source: "`vibe_health_insurance_v1`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_open_year_month"
      expr: DATE_TRUNC('MONTH', open_timestamp)
      comment: "Month when billing dispute was opened"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of dispute (open, under review, resolved, escalated)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute (billing error, coverage issue, payment mismatch)"
    - name: "initiator_type"
      expr: initiator_type
      comment: "Type of party initiating dispute (member, provider, employer, payer)"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution (adjustment, refund, denial, withdrawal)"
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount in dispute across all cases"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute case"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of members with billing disputes"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Distinct count of vendors involved in billing disputes"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT related_invoice_premium_invoice_id)
      comment: "Distinct count of invoices under dispute"
$$;