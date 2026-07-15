-- Metric views for domain: billing | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_bill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over premium bills. Tracks billed premium volume, outstanding balances, APL triggers, NSF activity, and billing cycle health — core inputs for revenue assurance, collections prioritization, and lapse-risk management."
  source: "`life_insurance_ecm`.`billing`.`premium_bill`"
  dimensions:
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency mode (e.g., Monthly, Quarterly, Annual) used to segment premium volume and collection patterns."
    - name: "bill_status"
      expr: bill_status
      comment: "Current status of the premium bill (e.g., Issued, Paid, Overdue, Cancelled) — primary filter for collections and aging analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the bill (EFT, Check, Credit Card) — used to analyze payment channel mix and NSF exposure."
    - name: "bill_month"
      expr: DATE_TRUNC('MONTH', bill_date)
      comment: "Calendar month the bill was issued — enables monthly trend analysis of billed premium and collection rates."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the premium payment is due — used for aging and cash-flow forecasting."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Start month of the billing period covered by the bill — supports earned-premium period alignment."
    - name: "group_bill_indicator"
      expr: group_bill_indicator
      comment: "Flags whether the bill is part of a group/list-bill arrangement — separates individual and group billing KPIs."
    - name: "notice_type"
      expr: notice_type
      comment: "Type of billing notice issued (Initial, Reminder, Final) — used to track escalation patterns and regulatory notice compliance."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Channel through which the bill was delivered (Mail, Email, Portal) — supports paperless adoption and delivery cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billed amount — required for multi-currency premium volume reporting."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year associated with the bill — enables cohort analysis of premium persistency by policy vintage."
    - name: "apl_triggered"
      expr: apl_triggered
      comment: "Indicates whether an Automatic Premium Loan was triggered on this bill — key indicator of policyholder financial stress."
    - name: "reinstatement_required"
      expr: reinstatement_required
      comment: "Flags bills where reinstatement of a lapsed policy is required — used to track reinstatement pipeline volume."
  measures:
    - name: "total_billed_premium"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total gross premium billed across all policies in the period. Core revenue-assurance KPI used in QBRs and financial close."
    - name: "total_base_premium_billed"
      expr: SUM(CAST(base_premium_amount AS DOUBLE))
      comment: "Sum of base (non-rider) premium billed — isolates core coverage premium from rider add-ons for product profitability analysis."
    - name: "total_rider_premium_billed"
      expr: SUM(CAST(rider_premium_amount AS DOUBLE))
      comment: "Sum of rider premium billed — measures ancillary coverage revenue and rider attachment value."
    - name: "total_coi_billed"
      expr: SUM(CAST(coi_amount AS DOUBLE))
      comment: "Total Cost of Insurance charges billed — critical for UL/IUL product profitability and mortality cost tracking."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Aggregate unpaid balance across all open bills — primary collections exposure metric used by billing operations."
    - name: "total_apl_amount_triggered"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total Automatic Premium Loan amounts triggered on bills — measures the scale of APL utilization as a lapse-prevention mechanism."
    - name: "total_nsf_fees_billed"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF (Non-Sufficient Funds) fees assessed on bills — tracks fee revenue and signals payment failure concentration."
    - name: "total_reinstatement_arrears"
      expr: SUM(CAST(reinstatement_arrears_amount AS DOUBLE))
      comment: "Total back-premium arrears billed for reinstatement cases — measures the financial burden on reinstating policyholders."
    - name: "total_ape_billed"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total Annualized Premium Equivalent billed — standard insurance sales and in-force premium metric used in executive reporting."
    - name: "count_bills_issued"
      expr: COUNT(1)
      comment: "Total number of premium bills issued — baseline volume metric for billing operations capacity and trend monitoring."
    - name: "count_apl_triggered_bills"
      expr: COUNT(CASE WHEN apl_triggered = TRUE THEN 1 END)
      comment: "Number of bills where an APL was triggered — measures the breadth of policyholder financial stress requiring loan intervention."
    - name: "count_reinstatement_required_bills"
      expr: COUNT(CASE WHEN reinstatement_required = TRUE THEN 1 END)
      comment: "Number of bills flagged as requiring reinstatement — tracks the active reinstatement pipeline volume."
    - name: "count_delivery_confirmed_bills"
      expr: COUNT(CASE WHEN delivery_confirmed = TRUE THEN 1 END)
      comment: "Number of bills with confirmed delivery — measures billing notice delivery effectiveness and regulatory compliance."
    - name: "avg_billed_amount_per_bill"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average premium billed per bill — tracks premium adequacy trends and detects anomalous billing patterns."
    - name: "avg_outstanding_balance_per_bill"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per open bill — used to benchmark collection difficulty and prioritize outreach."
    - name: "count_distinct_policies_billed"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct in-force policies billed in the period — measures active billing universe size for capacity planning."
    - name: "count_distinct_accounts_billed"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct billing accounts with bills issued — tracks active account engagement and billing reach."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment performance and cash collection KPI layer. Tracks premium payment volumes, NSF rates, suspense handling, refund activity, and EFT payment health — essential for cash management, collections efficiency, and policyholder payment behavior analysis."
  source: "`life_insurance_ecm`.`billing`.`billing_premium_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Payment channel used (EFT, Check, Credit Card, Wire) — enables payment mix analysis and channel-specific failure rate tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (Cleared, NSF, Pending, Reversed) — primary dimension for payment health dashboards."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (Regular, Reinstatement, Grace Period) — segments payment flows by business purpose."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Bank clearance status of the payment — used to track settlement timing and identify stuck payments."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt — enables monthly cash collection trend analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period the payment covers — supports earned-premium period matching and aging analysis."
    - name: "modal_premium_mode"
      expr: modal_premium_mode
      comment: "Premium payment frequency mode (Monthly, Quarterly, Semi-Annual, Annual) — used to analyze persistency by payment frequency."
    - name: "payment_source"
      expr: payment_source
      comment: "Origin of the payment (Policyholder, Employer, Third Party) — supports group vs. individual billing segmentation."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Flags payments that returned NSF — primary dimension for NSF rate and fee revenue analysis."
    - name: "grace_period_payment_flag"
      expr: grace_period_payment_flag
      comment: "Indicates payment was received during a grace period — measures late-payment behavior and lapse-prevention effectiveness."
    - name: "reinstatement_payment_flag"
      expr: reinstatement_payment_flag
      comment: "Flags payments associated with policy reinstatement — tracks reinstatement cash inflows separately."
    - name: "is_suspense"
      expr: is_suspense
      comment: "Indicates payment is held in suspense pending identification — used to monitor unallocated cash exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — required for multi-currency cash collection reporting."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue refunds (Check, EFT, Credit) — supports refund operations analysis."
    - name: "premium_allocation_type"
      expr: premium_allocation_type
      comment: "How the payment was allocated across premium components — used to analyze payment application patterns."
  measures:
    - name: "total_payment_amount_collected"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross premium payments received — primary cash collection KPI for treasury and revenue assurance."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amounts successfully applied to policy premiums — measures effective cash application vs. gross receipts."
    - name: "total_suspense_amount"
      expr: SUM(CAST(suspense_amount AS DOUBLE))
      comment: "Total payments held in suspense — measures unallocated cash exposure requiring operations resolution."
    - name: "total_nsf_fees_collected"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees charged on returned payments — tracks fee revenue and the financial cost of payment failures."
    - name: "total_ape_collected"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total Annualized Premium Equivalent collected — standard in-force premium metric for executive and regulatory reporting."
    - name: "count_payments_received"
      expr: COUNT(1)
      comment: "Total number of payment transactions received — baseline volume metric for payment operations capacity planning."
    - name: "count_nsf_payments"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of payments that returned NSF — measures payment failure frequency and policyholder financial stress."
    - name: "count_grace_period_payments"
      expr: COUNT(CASE WHEN grace_period_payment_flag = TRUE THEN 1 END)
      comment: "Number of payments received during grace periods — measures late-payment prevalence and lapse-prevention effectiveness."
    - name: "count_reinstatement_payments"
      expr: COUNT(CASE WHEN reinstatement_payment_flag = TRUE THEN 1 END)
      comment: "Number of reinstatement payments received — tracks reinstatement activity volume and associated cash inflows."
    - name: "count_suspense_payments"
      expr: COUNT(CASE WHEN is_suspense = TRUE THEN 1 END)
      comment: "Number of payments held in suspense — measures unresolved payment volume requiring operations intervention."
    - name: "count_apl_triggered_payments"
      expr: COUNT(CASE WHEN apl_trigger_flag = TRUE THEN 1 END)
      comment: "Number of payments that triggered an Automatic Premium Loan — measures APL activation frequency as a lapse-prevention signal."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average premium payment amount per transaction — tracks premium adequacy and detects anomalous payment patterns."
    - name: "count_distinct_policies_paid"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with payments received — measures active paying policy universe for persistency analysis."
    - name: "count_distinct_accounts_paid"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct billing accounts with payments — tracks account-level payment engagement."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_lapse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy lapse risk and persistency KPI layer. Tracks lapse volumes, outstanding premium at lapse, NAR exposure, non-forfeiture elections, and reinstatement eligibility — critical for persistency management, product profitability, and regulatory compliance."
  source: "`life_insurance_ecm`.`billing`.`lapse_event`"
  dimensions:
    - name: "lapse_reason_code"
      expr: lapse_reason_code
      comment: "Coded reason for the lapse (Non-Payment, Surrender, etc.) — primary dimension for root-cause analysis of persistency deterioration."
    - name: "lapse_status"
      expr: lapse_status
      comment: "Current status of the lapse event (Active, Reinstated, Expired) — used to track lapse resolution outcomes."
    - name: "non_forfeiture_option"
      expr: non_forfeiture_option
      comment: "Non-forfeiture option elected by the policyholder (Extended Term, Reduced Paid-Up, Cash Surrender) — measures policyholder behavior at lapse."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency at time of lapse — identifies whether payment frequency correlates with lapse risk."
    - name: "product_type"
      expr: product_type
      comment: "Product type of the lapsed policy (Term, Whole Life, UL, etc.) — enables product-level persistency benchmarking."
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where the policy was issued — supports geographic lapse rate analysis and state-level regulatory reporting."
    - name: "lapse_effective_month"
      expr: DATE_TRUNC('MONTH', lapse_effective_date)
      comment: "Month the lapse became effective — enables monthly lapse trend analysis and seasonality detection."
    - name: "policy_issue_year"
      expr: DATE_TRUNC('YEAR', policy_issue_date)
      comment: "Year the policy was originally issued — supports vintage cohort lapse rate analysis."
    - name: "reinstatement_eligible"
      expr: reinstatement_eligible
      comment: "Flags lapsed policies eligible for reinstatement — used to size the reinstatement opportunity pipeline."
    - name: "apl_applied"
      expr: apl_applied
      comment: "Indicates whether an APL was applied before lapse — measures APL effectiveness as a lapse-prevention tool."
    - name: "apl_eligible"
      expr: apl_eligible
      comment: "Indicates whether the policy was eligible for APL at lapse — used to identify missed APL intervention opportunities."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flags lapses requiring regulatory notification — supports compliance monitoring and notice SLA tracking."
    - name: "third_party_notice_sent"
      expr: third_party_notice_sent
      comment: "Indicates whether a third-party lapse notice was sent — tracks compliance with third-party notice regulations."
  measures:
    - name: "count_lapse_events"
      expr: COUNT(1)
      comment: "Total number of policy lapse events — primary persistency KPI used in executive reporting and product profitability analysis."
    - name: "total_face_amount_lapsed"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount of lapsed policies — measures the in-force book reduction and mortality risk exposure lost."
    - name: "total_nar_at_lapse"
      expr: SUM(CAST(nar_at_lapse AS DOUBLE))
      comment: "Total Net Amount at Risk at time of lapse — measures the mortality exposure that terminated, impacting reinsurance and reserve calculations."
    - name: "total_outstanding_premium_at_lapse"
      expr: SUM(CAST(outstanding_premium_amount AS DOUBLE))
      comment: "Total overdue premium outstanding at time of lapse — measures the collections shortfall that drove lapse events."
    - name: "total_modal_premium_lapsed"
      expr: SUM(CAST(modal_premium_amount AS DOUBLE))
      comment: "Total modal premium of lapsed policies — measures the recurring premium revenue lost due to lapses."
    - name: "total_apl_amount_at_lapse"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total APL balance outstanding at time of lapse — measures the loan exposure that could not prevent the lapse."
    - name: "total_policy_loan_balance_at_lapse"
      expr: SUM(CAST(policy_loan_balance AS DOUBLE))
      comment: "Total policy loan balance at time of lapse — measures credit exposure from loans on lapsed policies."
    - name: "total_reduced_paid_up_face"
      expr: SUM(CAST(reduced_paid_up_face_amount AS DOUBLE))
      comment: "Total face amount of Reduced Paid-Up non-forfeiture elections — measures the retained in-force value after lapse."
    - name: "count_reinstatement_eligible_lapses"
      expr: COUNT(CASE WHEN reinstatement_eligible = TRUE THEN 1 END)
      comment: "Number of lapsed policies eligible for reinstatement — sizes the reinstatement recovery opportunity for retention campaigns."
    - name: "count_apl_applied_lapses"
      expr: COUNT(CASE WHEN apl_applied = TRUE THEN 1 END)
      comment: "Number of lapses where APL was applied — measures APL utilization as a lapse-prevention intervention."
    - name: "count_apl_eligible_not_applied"
      expr: COUNT(CASE WHEN apl_eligible = TRUE AND apl_applied = FALSE THEN 1 END)
      comment: "Number of lapses where APL was eligible but not applied — identifies missed lapse-prevention opportunities for process improvement."
    - name: "count_regulatory_notification_required"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of lapses requiring regulatory notification — tracks compliance obligation volume and SLA exposure."
    - name: "avg_face_amount_lapsed"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount of lapsed policies — benchmarks the typical policy size affected by lapses for risk segmentation."
    - name: "count_distinct_policies_lapsed"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies that lapsed — the definitive persistency metric used in lapse rate calculations."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace period management and lapse-prevention KPI layer. Tracks grace period volumes, outstanding premium during grace, APL eligibility, resolution outcomes, and regulatory notice compliance — essential for collections intervention, lapse prevention, and regulatory adherence."
  source: "`life_insurance_ecm`.`billing`.`grace_period`"
  dimensions:
    - name: "period_status"
      expr: period_status
      comment: "Current status of the grace period (Active, Resolved, Lapsed, Expired) — primary dimension for grace period pipeline management."
    - name: "period_type"
      expr: period_type
      comment: "Type of grace period (Standard, Extended, Regulatory) — used to segment grace periods by policy and regulatory type."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "How the grace period was resolved (Payment Received, Lapsed, APL Applied, Waived) — measures lapse-prevention intervention effectiveness."
    - name: "product_type"
      expr: product_type
      comment: "Product type of the policy in grace (Term, Whole Life, UL) — enables product-level grace period and lapse risk analysis."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency of the policy in grace — identifies payment frequency correlation with grace period entry."
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State of policy issue — supports geographic grace period analysis and state-specific regulatory notice compliance."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method on the policy in grace — used to analyze payment channel correlation with grace period entry."
    - name: "apl_eligible"
      expr: apl_eligible
      comment: "Flags grace periods where APL is available as a lapse-prevention tool — used to size the APL intervention opportunity."
    - name: "regulatory_notice_required"
      expr: regulatory_notice_required
      comment: "Indicates whether a regulatory grace period notice is required — tracks compliance obligation volume."
    - name: "third_party_notice_required"
      expr: third_party_notice_required
      comment: "Flags grace periods requiring third-party notification — monitors compliance with third-party notice regulations."
    - name: "waiver_of_premium_active"
      expr: waiver_of_premium_active
      comment: "Indicates whether a waiver of premium rider is active — identifies grace periods that should self-resolve via waiver."
    - name: "grace_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the grace period began — enables monthly grace period entry trend analysis."
    - name: "notice_channel"
      expr: notice_channel
      comment: "Channel used to deliver grace period notice (Mail, Email, SMS) — supports notice delivery effectiveness analysis."
  measures:
    - name: "count_grace_periods_active"
      expr: COUNT(1)
      comment: "Total number of grace period records — measures the volume of policies at lapse risk at any point in time."
    - name: "total_outstanding_premium_in_grace"
      expr: SUM(CAST(outstanding_premium_amount AS DOUBLE))
      comment: "Total overdue premium across all grace period policies — measures the collections exposure requiring immediate intervention."
    - name: "total_modal_premium_in_grace"
      expr: SUM(CAST(modal_premium_amount AS DOUBLE))
      comment: "Total modal premium of policies in grace — measures the recurring revenue at risk of lapse."
    - name: "total_apl_amount_available"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total APL amounts available on grace period policies — measures the lapse-prevention capacity available via automatic loans."
    - name: "total_partial_payment_received"
      expr: SUM(CAST(partial_payment_amount AS DOUBLE))
      comment: "Total partial payments received during grace periods — measures partial collection success and remaining balance exposure."
    - name: "count_apl_eligible_grace_periods"
      expr: COUNT(CASE WHEN apl_eligible = TRUE THEN 1 END)
      comment: "Number of grace periods where APL is available — sizes the automatic lapse-prevention intervention opportunity."
    - name: "count_regulatory_notice_required"
      expr: COUNT(CASE WHEN regulatory_notice_required = TRUE THEN 1 END)
      comment: "Number of grace periods requiring regulatory notice — tracks compliance obligation volume and notice SLA exposure."
    - name: "count_waiver_active_grace_periods"
      expr: COUNT(CASE WHEN waiver_of_premium_active = TRUE THEN 1 END)
      comment: "Number of grace periods with active waiver of premium — identifies cases that should self-resolve without collections action."
    - name: "count_third_party_notice_required"
      expr: COUNT(CASE WHEN third_party_notice_required = TRUE THEN 1 END)
      comment: "Number of grace periods requiring third-party notice — monitors regulatory compliance for third-party notification obligations."
    - name: "avg_outstanding_premium_in_grace"
      expr: AVG(CAST(outstanding_premium_amount AS DOUBLE))
      comment: "Average outstanding premium per grace period policy — benchmarks typical collection shortfall for intervention prioritization."
    - name: "count_distinct_policies_in_grace"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies currently in grace period — the definitive lapse-risk pipeline size metric."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_nsf_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NSF (Non-Sufficient Funds) payment failure KPI layer. Tracks NSF frequency, fee revenue, representment outcomes, lapse initiation risk, and AML flags — essential for payment quality management, fee revenue tracking, and fraud/compliance monitoring."
  source: "`life_insurance_ecm`.`billing`.`nsf_event`"
  dimensions:
    - name: "bank_return_reason_code"
      expr: bank_return_reason_code
      comment: "Bank return reason code for the NSF (R01, R02, etc.) — identifies root causes of payment failures for remediation targeting."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the NSF event (Open, Resolved, Lapsed, Waived) — primary dimension for NSF resolution pipeline management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method that failed (EFT, Check) — identifies high-risk payment channels for NSF concentration analysis."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency of the policy with NSF — identifies payment frequency correlation with NSF risk."
    - name: "remediation_action"
      expr: remediation_action
      comment: "Action taken to remediate the NSF (Representment, Grace Period, Lapse Initiated) — measures remediation strategy effectiveness."
    - name: "representment_status"
      expr: representment_status
      comment: "Status of payment representment attempt (Pending, Cleared, Failed) — tracks representment success rates."
    - name: "nsf_fee_waived"
      expr: nsf_fee_waived
      comment: "Indicates whether the NSF fee was waived — used to track fee waiver rates and their impact on fee revenue."
    - name: "apl_triggered"
      expr: apl_triggered
      comment: "Flags NSF events where an APL was triggered as a lapse-prevention response — measures APL activation from payment failures."
    - name: "nsf_event_month"
      expr: DATE_TRUNC('MONTH', nsf_date)
      comment: "Month the NSF event occurred — enables monthly NSF trend analysis and seasonality detection."
    - name: "policy_status_at_nsf"
      expr: policy_status_at_nsf
      comment: "Policy status at the time of the NSF event — used to assess lapse risk severity by policy status."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify the policyholder of the NSF (Email, Mail, SMS) — supports notification effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the failed payment — required for multi-currency NSF exposure reporting."
  measures:
    - name: "count_nsf_events"
      expr: COUNT(1)
      comment: "Total number of NSF events — primary payment quality KPI measuring the frequency of payment failures."
    - name: "total_nsf_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total dollar value of payments that returned NSF — measures the cash collection shortfall from payment failures."
    - name: "total_nsf_fees_assessed"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees charged to policyholders — tracks fee revenue from payment failures and the financial burden on policyholders."
    - name: "total_apl_amount_triggered_by_nsf"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total APL amounts triggered in response to NSF events — measures the scale of automatic loan intervention from payment failures."
    - name: "count_nsf_with_apl_triggered"
      expr: COUNT(CASE WHEN apl_triggered = TRUE THEN 1 END)
      comment: "Number of NSF events where APL was triggered — measures APL as a lapse-prevention response to payment failures."
    - name: "count_nsf_fees_waived"
      expr: COUNT(CASE WHEN nsf_fee_waived = TRUE THEN 1 END)
      comment: "Number of NSF events where the fee was waived — tracks fee waiver frequency and its impact on fee revenue."
    - name: "count_nsf_with_lapse_initiated"
      expr: COUNT(CASE WHEN lapse_initiation_date IS NOT NULL THEN 1 END)
      comment: "Number of NSF events that escalated to lapse initiation — measures the conversion rate from payment failure to policy lapse."
    - name: "avg_nsf_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount that returned NSF — benchmarks the typical premium exposure per NSF event."
    - name: "count_distinct_policies_with_nsf"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with NSF events — measures the breadth of payment failure across the in-force book."
    - name: "count_distinct_accounts_with_nsf"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct billing accounts with NSF events — identifies accounts with payment quality issues for targeted outreach."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium schedule health and in-force premium KPI layer. Tracks scheduled premium volumes, MEC status, APL activation, waiver of premium, and schedule persistency — essential for in-force management, actuarial reserve inputs, and product compliance monitoring."
  source: "`life_insurance_ecm`.`billing`.`premium_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the premium schedule (Active, Lapsed, Suspended, Terminated) — primary dimension for in-force schedule health monitoring."
    - name: "modal_frequency"
      expr: modal_frequency
      comment: "Premium payment frequency (Monthly, Quarterly, Semi-Annual, Annual) — used to analyze premium persistency by payment mode."
    - name: "billing_method"
      expr: billing_method
      comment: "Method of billing (Direct Bill, List Bill, EFT) — segments schedules by billing channel for operational analysis."
    - name: "mec_status"
      expr: mec_status
      comment: "Modified Endowment Contract status of the policy — critical compliance dimension for tax-qualified product monitoring."
    - name: "apl_eligible"
      expr: apl_eligible
      comment: "Flags schedules eligible for Automatic Premium Loan — used to size the APL-eligible in-force book."
    - name: "apl_activated"
      expr: apl_activated
      comment: "Indicates APL is currently active on the schedule — measures the active APL utilization across the in-force book."
    - name: "waiver_of_premium"
      expr: waiver_of_premium
      comment: "Indicates whether a waiver of premium rider is active — identifies schedules exempt from premium collection."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the premium schedule — required for multi-currency in-force premium reporting."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the premium schedule became effective — supports new business and in-force cohort analysis."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the next premium payment is due — used for cash flow forecasting and collections planning."
    - name: "billing_notice_preference"
      expr: billing_notice_preference
      comment: "Policyholder preference for billing notices (Paper, Electronic, None) — supports paperless adoption tracking."
    - name: "premium_paying_period"
      expr: premium_paying_period
      comment: "Duration of the premium paying period (e.g., 10-Pay, 20-Pay, Life Pay) — used to segment schedules by payment structure."
  measures:
    - name: "total_modal_premium_scheduled"
      expr: SUM(CAST(modal_premium_amount AS DOUBLE))
      comment: "Total modal premium across all active schedules — measures the recurring premium revenue base for cash flow forecasting."
    - name: "total_base_premium_scheduled"
      expr: SUM(CAST(base_premium_amount AS DOUBLE))
      comment: "Total base premium scheduled — isolates core coverage premium from riders for product profitability analysis."
    - name: "total_rider_premium_scheduled"
      expr: SUM(CAST(rider_premium_amount AS DOUBLE))
      comment: "Total rider premium scheduled — measures ancillary coverage premium revenue across the in-force book."
    - name: "total_ape_scheduled"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total Annualized Premium Equivalent across all schedules — standard in-force premium metric for executive and regulatory reporting."
    - name: "total_guideline_annual_premium"
      expr: SUM(CAST(guideline_annual_premium AS DOUBLE))
      comment: "Total Guideline Annual Premium (GAP) across schedules — critical IRC 7702 compliance metric for life insurance tax qualification."
    - name: "total_seven_pay_premium_limit"
      expr: SUM(CAST(seven_pay_premium_limit AS DOUBLE))
      comment: "Total seven-pay premium limits across schedules — measures MEC test threshold exposure across the in-force book."
    - name: "total_nsf_fees_on_schedules"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees accumulated on premium schedules — tracks the cumulative payment failure cost burden on the in-force book."
    - name: "count_active_schedules"
      expr: COUNT(1)
      comment: "Total number of premium schedules — measures the size of the in-force billing universe for capacity and revenue planning."
    - name: "count_apl_activated_schedules"
      expr: COUNT(CASE WHEN apl_activated = TRUE THEN 1 END)
      comment: "Number of schedules with APL currently active — measures the scale of automatic loan utilization across the in-force book."
    - name: "count_waiver_active_schedules"
      expr: COUNT(CASE WHEN waiver_of_premium = TRUE THEN 1 END)
      comment: "Number of schedules with active waiver of premium — measures the disability-related premium exemption volume."
    - name: "count_mec_schedules"
      expr: COUNT(CASE WHEN mec_status = 'MEC' THEN 1 END)
      comment: "Number of schedules classified as Modified Endowment Contracts — tracks MEC exposure for tax compliance and product design monitoring."
    - name: "avg_modal_premium_per_schedule"
      expr: AVG(CAST(modal_premium_amount AS DOUBLE))
      comment: "Average modal premium per schedule — benchmarks premium adequacy and tracks premium level trends across the in-force book."
    - name: "count_distinct_policies_scheduled"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct in-force policies with premium schedules — measures the active billing universe size."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_reinstatement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy reinstatement performance and risk KPI layer. Tracks reinstatement volumes, approval rates, back-premium collections, underwriting evidence requirements, and fraud indicators — essential for retention management, underwriting risk control, and regulatory compliance."
  source: "`life_insurance_ecm`.`billing`.`billing_reinstatement`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Reinstatement approval status (Approved, Denied, Pending) — primary dimension for reinstatement pipeline and approval rate analysis."
    - name: "reinstatement_type"
      expr: reinstatement_type
      comment: "Type of reinstatement (Standard, Simplified, Full Underwriting) — used to segment reinstatement by underwriting rigor."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Underwriting decision on the reinstatement (Approved, Declined, Modified) — measures underwriting outcome distribution."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for reinstatement denial — identifies root causes of reinstatement failures for process improvement."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for reinstatement back-premium — tracks payment channel mix for reinstatement collections."
    - name: "product_code"
      expr: product_code
      comment: "Product code of the reinstated policy — enables product-level reinstatement rate and risk analysis."
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State of policy issue — supports geographic reinstatement analysis and state-specific regulatory compliance."
    - name: "evidence_type"
      expr: evidence_type
      comment: "Type of insurability evidence required (None, Statement, APS, Exam) — measures underwriting evidence burden by reinstatement type."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month the reinstatement application was submitted — enables monthly reinstatement volume trend analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the reinstatement was approved — tracks approval throughput and processing cycle time trends."
    - name: "aml_review_required"
      expr: aml_review_required
      comment: "Flags reinstatements requiring AML review — monitors compliance obligation volume for anti-money laundering screening."
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Flags reinstatements with suspected fraud — used to track fraud exposure in the reinstatement channel."
    - name: "underwriting_evidence_required"
      expr: underwriting_evidence_required
      comment: "Indicates whether underwriting evidence was required — used to segment reinstatements by complexity and processing cost."
    - name: "apl_used"
      expr: apl_used
      comment: "Indicates whether an APL was used to fund the reinstatement — measures APL utilization as a reinstatement funding mechanism."
  measures:
    - name: "count_reinstatement_applications"
      expr: COUNT(1)
      comment: "Total number of reinstatement applications — primary retention KPI measuring the volume of lapsed policyholders seeking to reinstate."
    - name: "count_approved_reinstatements"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved reinstatements — measures reinstatement success volume and retention recovery."
    - name: "count_denied_reinstatements"
      expr: COUNT(CASE WHEN approval_status = 'Denied' THEN 1 END)
      comment: "Number of denied reinstatements — tracks underwriting rejection volume and identifies denial reason patterns."
    - name: "total_back_premium_collected"
      expr: SUM(CAST(back_premium_amount AS DOUBLE))
      comment: "Total back-premium collected on reinstatements — measures the arrears revenue recovered through reinstatement activity."
    - name: "total_back_premium_interest_collected"
      expr: SUM(CAST(back_premium_interest_amount AS DOUBLE))
      comment: "Total interest on back-premium collected — measures the interest revenue component of reinstatement collections."
    - name: "total_amount_collected_on_reinstatement"
      expr: SUM(CAST(amount_collected AS DOUBLE))
      comment: "Total amount collected across all reinstatement transactions — measures gross cash inflow from reinstatement activity."
    - name: "total_face_amount_reinstated"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount of reinstated policies — measures the in-force book recovery from reinstatement activity."
    - name: "total_total_amount_due_for_reinstatement"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due across all reinstatement applications — measures the full financial obligation required to reinstate lapsed policies."
    - name: "total_csv_at_lapse"
      expr: SUM(CAST(csv_at_lapse AS DOUBLE))
      comment: "Total Cash Surrender Value at time of lapse for reinstated policies — measures the asset base available to fund reinstatement."
    - name: "count_fraud_flagged_reinstatements"
      expr: COUNT(CASE WHEN fraud_indicator = TRUE THEN 1 END)
      comment: "Number of reinstatements flagged for fraud — tracks fraud exposure in the reinstatement channel for risk management."
    - name: "count_aml_review_required"
      expr: COUNT(CASE WHEN aml_review_required = TRUE THEN 1 END)
      comment: "Number of reinstatements requiring AML review — monitors compliance screening volume and associated processing delays."
    - name: "avg_back_premium_per_reinstatement"
      expr: AVG(CAST(back_premium_amount AS DOUBLE))
      comment: "Average back-premium per reinstatement application — benchmarks the financial burden on reinstating policyholders."
    - name: "count_distinct_policies_reinstated"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with reinstatement applications — measures the breadth of reinstatement activity across the lapsed book."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_apl_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automatic Premium Loan (APL) transaction KPI layer. Tracks APL loan volumes, interest accrual, MEC impact, lapse prevention effectiveness, and outstanding balances — critical for policyholder financial health monitoring, product risk management, and actuarial reserve inputs."
  source: "`life_insurance_ecm`.`billing`.`apl_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the APL transaction (Active, Reversed, Settled) — primary dimension for APL portfolio health monitoring."
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the APL (Whole Life, UL, etc.) — enables product-level APL utilization and risk analysis."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Type of interest rate applied to the APL (Fixed, Variable) — used to analyze interest rate risk on the APL portfolio."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency of the policy with APL — identifies payment frequency correlation with APL utilization."
    - name: "lapse_prevention_flag"
      expr: lapse_prevention_flag
      comment: "Flags APL transactions specifically triggered to prevent lapse — measures APL effectiveness as a retention tool."
    - name: "mec_impact_flag"
      expr: mec_impact_flag
      comment: "Indicates whether the APL transaction has MEC tax implications — tracks compliance risk from APL activity on MEC policies."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed APL transactions — used to measure APL reversal rates and identify processing errors."
    - name: "apl_authorization_flag"
      expr: apl_authorization_flag
      comment: "Indicates whether the APL was properly authorized — monitors authorization compliance across APL transactions."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Flags whether the policyholder was notified of the APL — tracks notification compliance for regulatory adherence."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the APL transaction was posted — enables monthly APL volume and balance trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the APL transaction — required for multi-currency APL portfolio reporting."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year at time of APL — supports cohort analysis of APL utilization by policy duration."
  measures:
    - name: "total_apl_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total APL loan amounts originated — measures the scale of automatic premium loan activity as a lapse-prevention mechanism."
    - name: "total_outstanding_apl_balance"
      expr: SUM(CAST(outstanding_apl_balance AS DOUBLE))
      comment: "Total outstanding APL balance across all active loans — measures the credit exposure from automatic premium loans on the in-force book."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest_amount AS DOUBLE))
      comment: "Total interest accrued on APL balances — measures the interest income generated by the APL portfolio."
    - name: "total_overdue_premium_covered_by_apl"
      expr: SUM(CAST(overdue_premium_amount AS DOUBLE))
      comment: "Total overdue premium amounts covered by APL transactions — measures the premium revenue preserved through APL intervention."
    - name: "total_csv_at_apl_trigger"
      expr: SUM(CAST(csv_at_trigger AS DOUBLE))
      comment: "Total Cash Surrender Value at time of APL trigger — measures the asset base supporting APL originations."
    - name: "total_net_csv_after_apl"
      expr: SUM(CAST(net_csv_after_apl AS DOUBLE))
      comment: "Total net CSV remaining after APL deduction — measures the residual policyholder equity after APL utilization."
    - name: "total_premium_allocation_base"
      expr: SUM(CAST(premium_allocation_base AS DOUBLE))
      comment: "Total base premium allocated via APL transactions — measures the base coverage premium preserved through automatic loans."
    - name: "count_apl_transactions"
      expr: COUNT(1)
      comment: "Total number of APL transactions — measures APL activity volume as an indicator of policyholder financial stress."
    - name: "count_lapse_prevention_apl"
      expr: COUNT(CASE WHEN lapse_prevention_flag = TRUE THEN 1 END)
      comment: "Number of APL transactions specifically triggered for lapse prevention — measures the effectiveness of APL as a retention tool."
    - name: "count_mec_impacted_apl"
      expr: COUNT(CASE WHEN mec_impact_flag = TRUE THEN 1 END)
      comment: "Number of APL transactions with MEC tax implications — tracks compliance risk exposure from APL activity on MEC policies."
    - name: "count_reversed_apl_transactions"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed APL transactions — measures APL reversal frequency and identifies processing quality issues."
    - name: "avg_apl_loan_amount"
      expr: AVG(CAST(loan_amount AS DOUBLE))
      comment: "Average APL loan amount per transaction — benchmarks typical APL utilization size for risk segmentation."
    - name: "avg_interest_rate_on_apl"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate applied to APL transactions — monitors APL pricing trends and competitiveness."
    - name: "count_distinct_policies_with_apl"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with APL transactions — measures the breadth of APL utilization across the in-force book."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium adjustment and rate change KPI layer. Tracks adjustment volumes, premium change impacts, COI rate adjustments, MEC test implications, and regulatory revision activity — essential for product repricing governance, actuarial accuracy, and regulatory compliance."
  source: "`life_insurance_ecm`.`billing`.`premium_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of premium adjustment (COI Rate Change, Rider Addition, Face Amount Change, etc.) — primary dimension for adjustment root-cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (Pending, Applied, Reversed, Rejected) — used to track adjustment pipeline and processing health."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Coded reason for the premium adjustment — enables root-cause analysis of premium changes across the in-force book."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (Approved, Pending, Rejected) — monitors governance and approval workflow compliance."
    - name: "component_type"
      expr: component_type
      comment: "Premium component being adjusted (Base, COI, Rider, Expense Load) — enables component-level premium change analysis."
    - name: "product_code"
      expr: product_code
      comment: "Product code of the adjusted policy — supports product-level premium adjustment impact analysis."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency of the adjusted policy — used to analyze adjustment impact by payment mode."
    - name: "mec_test_flag"
      expr: mec_test_flag
      comment: "Flags adjustments that triggered a MEC test — monitors compliance risk from premium changes on tax-qualified policies."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed adjustments — used to measure adjustment reversal rates and identify processing quality issues."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment became effective — enables monthly premium change trend analysis."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year at time of adjustment — supports cohort analysis of premium changes by policy duration."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment — required for multi-currency premium adjustment reporting."
    - name: "rider_code"
      expr: rider_code
      comment: "Rider code associated with the adjustment — enables rider-level premium change analysis."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total net premium adjustment amount — measures the aggregate premium change impact across the in-force book."
    - name: "total_new_annual_premium"
      expr: SUM(CAST(new_annual_premium AS DOUBLE))
      comment: "Total new annual premium after adjustments — measures the post-adjustment in-force premium base."
    - name: "total_prior_annual_premium"
      expr: SUM(CAST(prior_annual_premium AS DOUBLE))
      comment: "Total prior annual premium before adjustments — provides the baseline for measuring premium change magnitude."
    - name: "total_new_modal_premium"
      expr: SUM(CAST(new_modal_premium AS DOUBLE))
      comment: "Total new modal premium after adjustments — measures the recurring premium cash flow impact of adjustments."
    - name: "total_prior_modal_premium"
      expr: SUM(CAST(prior_modal_premium AS DOUBLE))
      comment: "Total prior modal premium before adjustments — baseline for measuring modal premium change impact."
    - name: "total_new_face_amount"
      expr: SUM(CAST(new_face_amount AS DOUBLE))
      comment: "Total new face amount after adjustments — measures the post-adjustment mortality exposure across adjusted policies."
    - name: "total_seven_pay_premium_adjusted"
      expr: SUM(CAST(seven_pay_premium AS DOUBLE))
      comment: "Total seven-pay premium limits on adjusted policies — monitors MEC test threshold changes from premium adjustments."
    - name: "count_premium_adjustments"
      expr: COUNT(1)
      comment: "Total number of premium adjustments processed — measures adjustment activity volume for operations capacity planning."
    - name: "count_mec_test_triggered_adjustments"
      expr: COUNT(CASE WHEN mec_test_flag = TRUE THEN 1 END)
      comment: "Number of adjustments that triggered a MEC test — tracks compliance risk exposure from premium changes on tax-qualified policies."
    - name: "count_reversed_adjustments"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed premium adjustments — measures adjustment reversal frequency and processing quality."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average premium adjustment amount per transaction — benchmarks typical adjustment magnitude for anomaly detection."
    - name: "count_distinct_policies_adjusted"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies with premium adjustments — measures the breadth of repricing activity across the in-force book."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_suspense_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspense account and unallocated cash KPI layer. Tracks unresolved payment volumes, aging, AML flags, escheatment risk, and resolution effectiveness — essential for cash management, regulatory compliance, and operational efficiency in payment processing."
  source: "`life_insurance_ecm`.`billing`.`suspense_account`"
  dimensions:
    - name: "suspense_status"
      expr: suspense_status
      comment: "Current status of the suspense item (Open, Resolved, Escheated, Returned) — primary dimension for suspense pipeline management."
    - name: "suspense_reason_code"
      expr: suspense_reason_code
      comment: "Reason the payment was placed in suspense (NIGO, Unidentified, Duplicate, etc.) — enables root-cause analysis of suspense entry."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the suspense item was resolved (Applied, Returned, Escheated, Written Off) — measures resolution outcome distribution."
    - name: "payment_source_type"
      expr: payment_source_type
      comment: "Source type of the payment in suspense (EFT, Check, Wire) — identifies payment channel concentration in suspense."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket of the suspense item (0-30, 31-60, 61-90, 90+ days) — primary dimension for suspense aging analysis and escalation."
    - name: "aml_review_flag"
      expr: aml_review_flag
      comment: "Flags suspense items requiring AML review — monitors compliance screening volume for anti-money laundering obligations."
    - name: "nsf_flag"
      expr: nsf_flag
      comment: "Flags suspense items related to NSF events — used to separate NSF-related suspense from other unallocated cash."
    - name: "grace_period_flag"
      expr: grace_period_flag
      comment: "Flags suspense items associated with grace period payments — identifies time-sensitive suspense requiring priority resolution."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month the payment was received into suspense — enables monthly suspense inflow trend analysis."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the suspense item was resolved — tracks resolution throughput and cycle time trends."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the suspense amount — required for multi-currency unallocated cash reporting."
  measures:
    - name: "total_received_amount_in_suspense"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total cash received and placed in suspense — measures the gross unallocated cash inflow requiring operations resolution."
    - name: "total_unresolved_suspense_amount"
      expr: SUM(CAST(unresolved_amount AS DOUBLE))
      comment: "Total unresolved suspense balance — primary cash management KPI measuring outstanding unallocated cash exposure."
    - name: "total_resolved_suspense_amount"
      expr: SUM(CAST(resolved_amount AS DOUBLE))
      comment: "Total suspense amounts successfully resolved and applied — measures cash application effectiveness."
    - name: "count_suspense_items"
      expr: COUNT(1)
      comment: "Total number of suspense items — measures the volume of unallocated payment transactions requiring operations action."
    - name: "count_aml_flagged_suspense"
      expr: COUNT(CASE WHEN aml_review_flag = TRUE THEN 1 END)
      comment: "Number of suspense items flagged for AML review — tracks compliance screening volume and associated processing delays."
    - name: "count_grace_period_suspense"
      expr: COUNT(CASE WHEN grace_period_flag = TRUE THEN 1 END)
      comment: "Number of suspense items linked to grace period payments — identifies time-sensitive items requiring priority resolution to prevent lapse."
    - name: "count_nsf_related_suspense"
      expr: COUNT(CASE WHEN nsf_flag = TRUE THEN 1 END)
      comment: "Number of suspense items related to NSF events — measures NSF-driven suspense volume for payment quality analysis."
    - name: "avg_received_amount_per_suspense"
      expr: AVG(CAST(received_amount AS DOUBLE))
      comment: "Average payment amount per suspense item — benchmarks typical suspense item size for prioritization and staffing."
    - name: "avg_unresolved_amount_per_suspense"
      expr: AVG(CAST(unresolved_amount AS DOUBLE))
      comment: "Average unresolved balance per open suspense item — measures the typical resolution burden per item for operations planning."
    - name: "count_distinct_accounts_in_suspense"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct billing accounts with suspense items — measures the breadth of unallocated cash across the account base."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_eft_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EFT authorization and direct debit mandate KPI layer. Tracks EFT authorization volumes, failure rates, mandate health, variable amount usage, and KYC compliance — essential for payment channel management, collections efficiency, and regulatory mandate compliance."
  source: "`life_insurance_ecm`.`billing`.`eft_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the EFT authorization (Active, Cancelled, Suspended, Expired) — primary dimension for EFT mandate portfolio health."
    - name: "authorization_method"
      expr: authorization_method
      comment: "Method used to obtain EFT authorization (Online, Paper, Phone) — tracks authorization channel mix and digital adoption."
    - name: "authorization_channel"
      expr: authorization_channel
      comment: "Channel through which the EFT authorization was obtained — supports channel-level authorization quality analysis."
    - name: "account_type"
      expr: account_type
      comment: "Bank account type (Checking, Savings) — used to analyze EFT failure rates by account type."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of EFT collections (Monthly, Quarterly, Annual) — segments EFT mandates by collection frequency."
    - name: "debit_type"
      expr: debit_type
      comment: "Type of debit instruction (Fixed, Variable) — used to analyze variable vs. fixed amount EFT mandate distribution."
    - name: "direct_debit_scheme"
      expr: direct_debit_scheme
      comment: "Direct debit scheme used (ACH, SEPA, BACS) — supports scheme-level mandate and failure analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (Policyholder, Employer, Third Party) — segments EFT mandates by payer relationship."
    - name: "kyc_verified"
      expr: kyc_verified
      comment: "Indicates whether KYC verification was completed for the EFT mandate — monitors compliance with KYC requirements."
    - name: "variable_amount_flag"
      expr: variable_amount_flag
      comment: "Flags EFT authorizations with variable collection amounts — used to analyze variable premium EFT risk and complexity."
    - name: "apl_authorized"
      expr: apl_authorized
      comment: "Indicates whether APL is authorized under the EFT mandate — measures APL authorization coverage across EFT accounts."
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorization_date)
      comment: "Month the EFT authorization was obtained — enables monthly new mandate volume trend analysis."
    - name: "prenote_status"
      expr: prenote_status
      comment: "Status of the prenote verification (Sent, Cleared, Failed) — tracks prenote completion rates for EFT mandate validation."
    - name: "failure_handling_rule"
      expr: failure_handling_rule
      comment: "Rule applied when EFT collection fails (Retry, Grace Period, Lapse) — used to analyze failure handling strategy distribution."
  measures:
    - name: "total_collection_amount_authorized"
      expr: SUM(CAST(collection_amount AS DOUBLE))
      comment: "Total EFT collection amounts authorized — measures the recurring premium cash flow secured through EFT mandates."
    - name: "total_max_debit_amount_authorized"
      expr: SUM(CAST(max_debit_amount AS DOUBLE))
      comment: "Total maximum debit amounts authorized across EFT mandates — measures the upper bound of EFT collection capacity."
    - name: "count_eft_authorizations"
      expr: COUNT(1)
      comment: "Total number of EFT authorizations — measures the size of the EFT mandate portfolio and direct debit channel reach."
    - name: "count_active_eft_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'Active' THEN 1 END)
      comment: "Number of active EFT authorizations — measures the current active direct debit mandate base for collections planning."
    - name: "count_eft_with_failures"
      expr: COUNT(CASE WHEN last_failure_date IS NOT NULL THEN 1 END)
      comment: "Number of EFT authorizations with at least one collection failure — measures the breadth of EFT payment quality issues."
    - name: "count_kyc_verified_eft"
      expr: COUNT(CASE WHEN kyc_verified = TRUE THEN 1 END)
      comment: "Number of EFT authorizations with completed KYC verification — tracks KYC compliance coverage across the EFT mandate portfolio."
    - name: "count_variable_amount_eft"
      expr: COUNT(CASE WHEN variable_amount_flag = TRUE THEN 1 END)
      comment: "Number of EFT authorizations with variable collection amounts — measures variable premium EFT complexity and operational risk."
    - name: "count_apl_authorized_eft"
      expr: COUNT(CASE WHEN apl_authorized = TRUE THEN 1 END)
      comment: "Number of EFT mandates with APL authorization — measures APL authorization coverage for lapse-prevention readiness."
    - name: "avg_collection_amount_per_eft"
      expr: AVG(CAST(collection_amount AS DOUBLE))
      comment: "Average EFT collection amount per mandate — benchmarks typical premium collection size for EFT channel analysis."
    - name: "count_distinct_accounts_with_eft"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct billing accounts with EFT authorizations — measures EFT channel penetration across the account base."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio health KPI layer. Tracks account balances, delinquency exposure, APL status, KYC compliance, NSF history, and billing channel preferences — essential for portfolio risk management, collections prioritization, and customer financial health monitoring."
  source: "`life_insurance_ecm`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (Active, Delinquent, Suspended, Terminated) — primary dimension for account health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (Individual, Group, Corporate) — used to segment the account portfolio by customer type."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Premium billing frequency (Monthly, Quarterly, Annual) — enables analysis of payment mode distribution and associated risk."
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method on the account (EFT, Check, Credit Card) — used to analyze payment channel mix and failure risk."
    - name: "delinquency_indicator"
      expr: delinquency_indicator
      comment: "Flags accounts currently delinquent — primary dimension for collections prioritization and delinquency rate analysis."
    - name: "apl_indicator"
      expr: apl_indicator
      comment: "Indicates whether APL is active on the account — used to segment accounts by lapse-prevention status."
    - name: "paperless_billing_indicator"
      expr: paperless_billing_indicator
      comment: "Flags accounts enrolled in paperless billing — tracks digital adoption and associated cost savings."
    - name: "kyc_verified_indicator"
      expr: kyc_verified_indicator
      comment: "Indicates KYC verification status of the account — monitors compliance coverage across the account portfolio."
    - name: "aml_review_indicator"
      expr: aml_review_indicator
      comment: "Flags accounts under AML review — tracks compliance screening exposure across the billing account base."
    - name: "billing_state_code"
      expr: billing_state_code
      comment: "State associated with the billing address — supports geographic portfolio analysis and state-level regulatory reporting."
    - name: "bank_account_type"
      expr: bank_account_type
      comment: "Type of bank account on file (Checking, Savings) — used to analyze bank account type distribution and NSF risk."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the billing account became effective — supports new account cohort analysis and vintage tracking."
    - name: "billing_notice_preference"
      expr: billing_notice_preference
      comment: "Policyholder preference for billing notices (Paper, Electronic) — tracks notice preference distribution for cost and compliance analysis."
  measures:
    - name: "total_account_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all billing accounts — measures aggregate outstanding premium liability across the account portfolio."
    - name: "total_billed_amount_on_accounts"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total cumulative billed amount across all accounts — measures the aggregate premium billing volume for revenue assurance."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payment amounts across accounts — measures the most recent cash collection wave across the portfolio."
    - name: "total_ape_on_accounts"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total Annualized Premium Equivalent across billing accounts — standard in-force premium metric for executive portfolio reporting."
    - name: "count_billing_accounts"
      expr: COUNT(1)
      comment: "Total number of billing accounts — measures the size of the billing account portfolio for capacity and revenue planning."
    - name: "count_delinquent_accounts"
      expr: COUNT(CASE WHEN delinquency_indicator = TRUE THEN 1 END)
      comment: "Number of delinquent billing accounts — primary collections KPI measuring the breadth of payment delinquency across the portfolio."
    - name: "count_apl_active_accounts"
      expr: COUNT(CASE WHEN apl_indicator = TRUE THEN 1 END)
      comment: "Number of accounts with active APL — measures the scale of automatic loan utilization as a lapse-prevention mechanism."
    - name: "count_paperless_accounts"
      expr: COUNT(CASE WHEN paperless_billing_indicator = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in paperless billing — tracks digital adoption progress and associated operational cost savings."
    - name: "count_kyc_verified_accounts"
      expr: COUNT(CASE WHEN kyc_verified_indicator = TRUE THEN 1 END)
      comment: "Number of accounts with completed KYC verification — monitors KYC compliance coverage across the billing account base."
    - name: "count_aml_review_accounts"
      expr: COUNT(CASE WHEN aml_review_indicator = TRUE THEN 1 END)
      comment: "Number of accounts under AML review — tracks compliance screening volume and associated processing exposure."
    - name: "avg_account_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per billing account — benchmarks typical outstanding premium liability for collections prioritization."
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium allocation and fund distribution KPI layer. Tracks allocated premium volumes, COI charges, expense loads, NAR amounts, MEC test status, and reinsurance cession indicators — essential for product profitability analysis, actuarial reserve inputs, and investment fund management."
  source: "`life_insurance_ecm`.`billing`.`premium_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the premium allocation (Applied, Reversed, Pending) — primary dimension for allocation pipeline health monitoring."
    - name: "component_type"
      expr: component_type
      comment: "Premium component being allocated (Base, COI, Rider, Expense Load) — enables component-level premium flow analysis."
    - name: "product_type"
      expr: product_type
      comment: "Product type of the allocated policy (Term, UL, IUL, VUL) — supports product-level premium allocation and profitability analysis."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency of the allocated policy — used to analyze premium allocation patterns by payment mode."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the allocation — tracks payment channel distribution in premium allocations."
    - name: "mec_test_status"
      expr: mec_test_status
      comment: "MEC test status at time of allocation (Pass, Fail, Not Applicable) — monitors tax compliance across premium allocations."
    - name: "dac_eligible_indicator"
      expr: dac_eligible_indicator
      comment: "Flags allocations eligible for Deferred Acquisition Cost treatment — supports DAC asset calculation and GAAP reporting."
    - name: "reinsurance_ceded_indicator"
      expr: reinsurance_ceded_indicator
      comment: "Indicates whether the allocation is subject to reinsurance cession — used to separate direct and ceded premium flows."
    - name: "tax_qualified_indicator"
      expr: tax_qualified_indicator
      comment: "Flags tax-qualified premium allocations — supports segregation of qualified vs. non-qualified premium for tax reporting."
    - name: "reinstatement_indicator"
      expr: reinstatement_indicator
      comment: "Flags allocations associated with reinstatement payments — separates reinstatement premium flows from regular collections."
    - name: "grace_period_indicator"
      expr: grace_period_indicator
      comment: "Flags allocations made during grace periods — identifies late-payment premium flows for persistency analysis."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the premium was allocated — enables monthly premium allocation trend analysis."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year at time of allocation — supports cohort analysis of premium allocation patterns by policy duration."
    - name: "rider_code"
      expr: rider_code
      comment: "Rider code associated with the allocation — enables rider-level premium allocation analysis."
  measures:
    - name: "total_allocated_premium"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total premium successfully allocated to policies — measures the effective premium application volume for revenue recognition."
    - name: "total_annualized_premium_allocated"
      expr: SUM(CAST(annualized_premium_amount AS DOUBLE))
      comment: "Total annualized premium equivalent allocated — standard in-force premium metric for actuarial and executive reporting."
    - name: "total_modal_premium_allocated"
      expr: SUM(CAST(modal_premium_amount AS DOUBLE))
      comment: "Total modal premium allocated — measures the recurring premium cash flow applied to in-force policies."
    - name: "total_coi_charges_allocated"
      expr: SUM(CAST(coi_rate AS DOUBLE))
      comment: "Total COI rate charges allocated — measures the mortality cost component of premium allocations for product profitability analysis."
    - name: "total_expense_load_allocated"
      expr: SUM(CAST(expense_load_amount AS DOUBLE))
      comment: "Total expense load amounts allocated — measures the expense charge component of premium for cost recovery analysis."
    - name: "total_nar_amount_allocated"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk across allocated policies — measures the mortality exposure base for reinsurance and reserve calculations."
    - name: "total_account_value_credited"
      expr: SUM(CAST(account_value_credit_amount AS DOUBLE))
      comment: "Total account value credited from premium allocations — measures the investment component of premium applied to policyholder accounts."
    - name: "count_premium_allocations"
      expr: COUNT(1)
      comment: "Total number of premium allocation transactions — measures allocation processing volume for operations capacity planning."
    - name: "count_reinsurance_ceded_allocations"
      expr: COUNT(CASE WHEN reinsurance_ceded_indicator = TRUE THEN 1 END)
      comment: "Number of allocations subject to reinsurance cession — measures the volume of ceded premium transactions for reinsurance accounting."
    - name: "count_dac_eligible_allocations"
      expr: COUNT(CASE WHEN dac_eligible_indicator = TRUE THEN 1 END)
      comment: "Number of DAC-eligible premium allocations — supports Deferred Acquisition Cost asset calculation for GAAP financial reporting."
    - name: "count_grace_period_allocations"
      expr: COUNT(CASE WHEN grace_period_indicator = TRUE THEN 1 END)
      comment: "Number of allocations made during grace periods — measures late-payment premium application volume."
    - name: "avg_allocated_amount_per_transaction"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average premium allocated per transaction — benchmarks typical allocation size for anomaly detection and process monitoring."
    - name: "count_distinct_policies_allocated"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of distinct policies receiving premium allocations — measures the active premium-paying policy universe."
$$;
