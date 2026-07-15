-- Metric views for domain: billing | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice-level KPIs for port billing operations. Tracks revenue billed, collection efficiency, tax exposure, discount leakage, and invoice lifecycle status across vessel calls, shipping lines, and billing cycles. Primary steering dashboard for the Port Finance and Billing Operations teams."
  source: "`vibe_shipping_ports_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. DRAFT, ISSUED, PAID, DISPUTED, CANCELLED). Used to segment revenue pipeline by collection stage."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO 4217 currency code of the invoice. Enables multi-currency revenue analysis and FX exposure reporting."
    - name: "service_type"
      expr: service_type
      comment: "Category of port service billed (e.g. VESSEL_DUES, THC, PILOTAGE, STORAGE, REEFER). Drives revenue-stream decomposition."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms on the invoice (e.g. NET30, NET60). Used to benchmark actual collection against agreed terms."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance. Enables monthly revenue trend analysis and period-over-period comparisons."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the invoice is due. Used to project cash collection timelines and identify upcoming receivables."
    - name: "tax_exemption_flag"
      expr: tax_exemption_flag
      comment: "Indicates whether the invoice is tax-exempt. Used to segregate taxable vs. exempt revenue for regulatory reporting."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge code on the invoice. Enables revenue analysis by destination port for trade-lane reporting."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of Loading code on the invoice. Enables revenue analysis by origin port for trade-lane reporting."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month in which revenue is recognised under IFRS 15. Separates billing date from recognition date for deferred revenue tracking."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross amount invoiced including tax. Primary top-line revenue KPI for port billing. Executives use this to track billed revenue against budget."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax invoice amount. Used to isolate net revenue from tax components for margin analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across all invoices. Required for VAT/GST regulatory reporting and tax liability management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoices. Tracks commercial discount leakage against tariff rates; triggers review if discount rate exceeds policy thresholds."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-issuance adjustments (credits/debits) applied to invoices. High adjustment volumes signal tariff or operational data quality issues."
    - name: "total_baf_amount"
      expr: SUM(CAST(baf_amount AS DOUBLE))
      comment: "Total Bunker Adjustment Factor (BAF) surcharge billed. Tracks fuel-surcharge revenue stream separately for tariff compliance and shipping-line negotiations."
    - name: "total_caf_amount"
      expr: SUM(CAST(caf_amount AS DOUBLE))
      comment: "Total Currency Adjustment Factor (CAF) surcharge billed. Monitors FX surcharge revenue and exposure to currency volatility."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume KPI for billing throughput and operational capacity planning."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct customer accounts billed. Measures billing reach and customer base activity within the period."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'DISPUTED' THEN 1 END)
      comment: "Number of invoices currently in dispute. High dispute counts indicate tariff accuracy or service delivery issues requiring management intervention."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'PAID' THEN 1 END)
      comment: "Number of invoices fully paid. Used to compute collection rate and monitor cash conversion efficiency."
    - name: "avg_invoice_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value. Tracks revenue yield per billing event; declining averages may signal volume mix shift or discount pressure."
    - name: "tax_exempt_invoice_count"
      expr: COUNT(CASE WHEN tax_exemption_flag = TRUE THEN 1 END)
      comment: "Number of tax-exempt invoices. Monitors the volume of exemptions granted for compliance audit and revenue leakage review."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_charge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular charge-event KPIs representing individual billable activities at the port (container handling, vessel dues, storage, reefer, hazmat surcharges). This is the atomic revenue fact table. Used by Revenue Management, Tariff, and Operations Finance to analyse charge composition, unit rates, and billing accuracy."
  source: "`vibe_shipping_ports_v1`.`billing`.`charge_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of billable event (e.g. DISCHARGE, LOAD, STORAGE, REEFER_PLUG, HAZMAT_SURCHARGE). Primary dimension for revenue-stream decomposition."
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the charge event (e.g. PENDING, INVOICED, DISPUTED, CANCELLED). Used to track unbilled revenue exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge. Enables multi-currency revenue analysis."
    - name: "tariff_code"
      expr: tariff_code
      comment: "Tariff code applied to the charge event. Used to validate tariff compliance and identify most-used tariff items."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the charge quantity (e.g. TEU, GRT, CBM, DAY). Required for rate benchmarking and tariff schedule validation."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Indicates whether the charge relates to a reefer (refrigerated) container. Reefer charges carry premium rates and require separate revenue tracking."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the charge relates to a hazardous/IMDG cargo unit. Hazmat surcharges are a distinct revenue stream with regulatory implications."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the charge event is under dispute. Used to quantify disputed revenue at the charge level."
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Indicates whether the charge has been exempted from billing. Monitors revenue exemptions for policy compliance."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class of the cargo being charged. Enables hazmat surcharge revenue analysis by DG class."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month of the charge event. Enables monthly charge volume and revenue trend analysis."
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charge amount before discounts and tax. Primary revenue KPI at the charge-event level; used to track revenue by service type and tariff code."
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts. Represents actual revenue earned per charge event; used for margin analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at charge-event level. Tracks commercial discount leakage against tariff rates."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on charge events. Required for tax liability reporting and VAT reconciliation."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across all charge events. Used to compute revenue yield per tonne and validate VGM-based billing."
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres. Used for volumetric revenue yield analysis and storage charge validation."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total billable quantity (TEUs, GRT, days, etc.) across charge events. Baseline throughput measure for tariff rate validation."
    - name: "charge_event_count"
      expr: COUNT(1)
      comment: "Total number of charge events. Measures billing throughput and operational activity volume."
    - name: "disputed_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of charge events under dispute. High counts signal tariff accuracy or operational data quality issues."
    - name: "exempted_charge_count"
      expr: COUNT(CASE WHEN exemption_flag = TRUE THEN 1 END)
      comment: "Number of charge events exempted from billing. Monitors revenue exemption volume for policy compliance and leakage control."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate applied across charge events. Used to benchmark effective tariff rates against published schedules and detect rate erosion."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate for time-based charges (storage, demurrage). Used to validate demurrage and detention rate application."
    - name: "reefer_charge_count"
      expr: COUNT(CASE WHEN reefer_flag = TRUE THEN 1 END)
      comment: "Number of reefer-related charge events. Tracks reefer revenue volume as a premium service stream."
    - name: "hazmat_charge_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of hazmat/IMDG charge events. Monitors DG surcharge revenue and compliance with IMDG billing requirements."
    - name: "avg_free_time_days"
      expr: AVG(CAST(free_time_days AS DOUBLE))
      comment: "Average free time days granted per charge event. Used to assess free-time policy generosity and its impact on storage revenue."
    - name: "avg_excess_days"
      expr: AVG(CAST(excess_days AS DOUBLE))
      comment: "Average excess days beyond free time per charge event. Directly drives demurrage/detention revenue; high averages indicate port congestion or customer dwell issues."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash application KPIs for port receivables. Tracks amounts received, reconciliation status, payment methods, and advance payment behaviour. Used by Treasury, Credit Control, and Finance to manage cash flow and collection performance."
  source: "`vibe_shipping_ports_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. RECEIVED, CLEARED, REVERSED, UNALLOCATED). Used to track cash application pipeline."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. FULL, PARTIAL, ADVANCE, OVERPAYMENT). Enables analysis of payment behaviour patterns."
    - name: "method"
      expr: method
      comment: "Payment method used (e.g. WIRE_TRANSFER, CHEQUE, DIRECT_DEBIT, ONLINE). Used to optimise payment channel strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payment was received. Enables FX exposure and multi-currency cash management analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation against invoices (e.g. RECONCILED, UNRECONCILED, PARTIAL). Tracks cash application backlog."
    - name: "is_advance_payment"
      expr: is_advance_payment
      comment: "Indicates whether the payment is an advance (pre-payment). Used to track advance payment liability and cash flow timing."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt. Enables monthly cash collection trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment. Used for annual cash collection reporting and budget vs. actual analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment. Enables sub-annual cash collection analysis aligned to financial reporting periods."
  measures:
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash received from customers. Primary cash collection KPI; compared against total invoiced amount to compute collection rate."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total payment amount allocated to specific invoices. Measures cash application efficiency; gap vs. amount_paid reveals unallocated cash."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices. High unapplied balances indicate cash application backlog and reconciliation risk."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early-payment discounts taken by customers. Tracks cost of early-payment incentive programmes."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment amount converted to base (reporting) currency. Used for consolidated cash reporting eliminating FX distortion."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received. Baseline volume KPI for payment processing throughput."
    - name: "advance_payment_count"
      expr: COUNT(CASE WHEN is_advance_payment = TRUE THEN 1 END)
      comment: "Number of advance payments received. Tracks pre-payment behaviour which improves cash flow predictability."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'UNRECONCILED' THEN 1 END)
      comment: "Number of payments not yet reconciled to invoices. Operational KPI for the cash application team; high counts indicate processing backlog."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount_paid AS DOUBLE))
      comment: "Average payment amount per transaction. Used to profile customer payment behaviour and detect anomalies."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to payments. Used to monitor FX rate application consistency and treasury hedging effectiveness."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute management KPIs tracking dispute volumes, financial exposure, resolution performance, and SLA compliance. Used by Customer Service, Revenue Assurance, and Finance to manage dispute risk, identify root causes, and improve billing accuracy."
  source: "`vibe_shipping_ports_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. OPEN, UNDER_REVIEW, RESOLVED, ESCALATED, CLOSED). Used to track dispute pipeline and backlog."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute (e.g. TARIFF_ERROR, DUPLICATE_CHARGE, SERVICE_NOT_RENDERED). Primary dimension for root-cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason code for the dispute. Enables granular root-cause analysis to drive billing process improvements."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g. CREDIT_ISSUED, CHARGE_UPHELD, PARTIAL_CREDIT). Used to assess dispute outcome patterns."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the dispute. High escalation levels indicate systemic billing issues requiring management attention."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the dispute resolution SLA was breached. Used to monitor customer service quality and contractual compliance."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification of the dispute. Drives corrective action prioritisation and billing process improvement initiatives."
    - name: "lodged_date_month"
      expr: DATE_TRUNC('MONTH', lodged_date)
      comment: "Calendar month the dispute was lodged. Enables trend analysis of dispute intake volumes."
    - name: "disputed_currency_code"
      expr: disputed_currency_code
      comment: "Currency of the disputed amount. Used for multi-currency dispute exposure reporting."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute. Primary risk KPI for Revenue Assurance; large disputed amounts represent revenue at risk."
    - name: "total_credit_amount_issued"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued to resolve disputes. Measures the financial cost of billing errors and dispute resolution."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes lodged. Baseline volume KPI; rising dispute counts signal deteriorating billing accuracy."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open disputes. Operational backlog KPI for the dispute resolution team."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END)
      comment: "Number of disputes that have been escalated. High escalation rates indicate unresolved systemic billing issues."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes where resolution SLA was breached. Directly impacts customer satisfaction scores and contractual penalty exposure."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Used to profile dispute severity and prioritise high-value dispute resolution."
    - name: "avg_customer_satisfaction_rating"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating following dispute resolution. Tracks service quality impact of billing disputes on customer relationships."
    - name: "distinct_customer_dispute_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct customers with active or historical disputes. Identifies customers with recurring billing issues for targeted account management."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing cycle performance KPIs tracking cycle throughput, financial totals, and operational efficiency. Used by Billing Operations and Finance to monitor cycle health, invoice generation performance, and period-close readiness."
  source: "`vibe_shipping_ports_v1`.`billing`.`billing_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the billing cycle (e.g. OPEN, CLOSED, IN_PROGRESS). Used to monitor period-close progress."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of billing cycle (e.g. MONTHLY, WEEKLY, AD_HOC, VESSEL_CALL). Enables analysis of billing frequency and cycle mix."
    - name: "service_category"
      expr: service_category
      comment: "Service category covered by the billing cycle (e.g. CONTAINER, VESSEL, BULK). Used to segment cycle performance by service line."
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency of the billing cycle. Enables multi-currency cycle analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the billing cycle. Used for annual billing performance reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the billing cycle. Enables quarterly revenue recognition and billing throughput analysis."
    - name: "is_adjustment_cycle"
      expr: is_adjustment_cycle
      comment: "Indicates whether the cycle is an adjustment cycle. Used to separate regular billing from correction cycles in performance reporting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Calendar month the billing cycle started. Enables monthly cycle volume and revenue trend analysis."
    - name: "late_fee_applicable_flag"
      expr: late_fee_applicable_flag
      comment: "Indicates whether late fees apply in this cycle. Used to track late-fee revenue exposure and collection policy enforcement."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total gross amount billed across all cycles. Top-line revenue KPI for billing operations; compared against budget and prior periods."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount after discounts across all cycles. Represents actual revenue earned net of commercial concessions."
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discount granted across billing cycles. Tracks aggregate commercial discount leakage for tariff policy review."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount across billing cycles. Required for tax liability reporting and period-close reconciliation."
    - name: "billing_cycle_count"
      expr: COUNT(1)
      comment: "Total number of billing cycles. Baseline operational volume KPI for billing throughput management."
    - name: "closed_cycle_count"
      expr: COUNT(CASE WHEN cycle_status = 'CLOSED' THEN 1 END)
      comment: "Number of billing cycles successfully closed. Tracks period-close completion rate; open cycles at period-end indicate revenue recognition risk."
    - name: "avg_late_fee_percentage"
      expr: AVG(CAST(late_fee_percentage AS DOUBLE))
      comment: "Average late fee percentage applied across cycles. Used to monitor late-fee policy consistency and revenue from overdue accounts."
    - name: "avg_total_billed_per_cycle"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per billing cycle. Tracks billing yield per cycle; declining averages may indicate volume or rate erosion."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_receivable_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable portfolio KPIs tracking outstanding balances, aging buckets, credit risk, and collection performance. Used by Credit Control, Treasury, and CFO to manage receivables health, credit exposure, and working capital."
  source: "`vibe_shipping_ports_v1`.`billing`.`receivable_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the receivable account (e.g. ACTIVE, SUSPENDED, CLOSED, CREDIT_HOLD). Used to segment the AR portfolio by health status."
    - name: "account_classification"
      expr: account_classification
      comment: "Classification of the receivable account (e.g. SHIPPING_LINE, FREIGHT_FORWARDER, HAULIER). Enables AR analysis by customer segment."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the account. Used to segment AR portfolio by credit risk tier for provisioning and collection prioritisation."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level of the account (e.g. LEVEL_1, LEVEL_2, LEGAL). Tracks escalation of overdue accounts through the collections process."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates whether the account is on credit hold. Accounts on credit hold represent service delivery risk and require immediate attention."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred billing currency of the account. Used for multi-currency AR portfolio analysis."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Method used to deliver invoices to the customer (e.g. EDI, EMAIL, PORTAL). Used to optimise invoice delivery and reduce payment delays."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Frequency of account statements issued (e.g. MONTHLY, WEEKLY). Used to align statement cadence with customer payment cycles."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance across all accounts. Primary AR portfolio KPI; directly impacts working capital and cash flow forecasting."
    - name: "total_aging_0_30_days"
      expr: SUM(CAST(aging_bucket_0_30_days AS DOUBLE))
      comment: "Total AR balance aged 0-30 days. Current receivables within standard payment terms; baseline for collection efficiency measurement."
    - name: "total_aging_31_60_days"
      expr: SUM(CAST(aging_bucket_31_60_days AS DOUBLE))
      comment: "Total AR balance aged 31-60 days overdue. Early-stage overdue receivables; triggers first-level dunning actions."
    - name: "total_aging_61_90_days"
      expr: SUM(CAST(aging_bucket_61_90_days AS DOUBLE))
      comment: "Total AR balance aged 61-90 days overdue. Mid-stage overdue receivables; triggers escalated collection actions."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_bucket_over_90_days AS DOUBLE))
      comment: "Total AR balance aged over 90 days overdue. High-risk receivables requiring legal action or write-off provisioning."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Used to assess aggregate credit exposure and compare against outstanding balances."
    - name: "total_write_off_amount_ytd"
      expr: SUM(CAST(write_off_amount_ytd AS DOUBLE))
      comment: "Total year-to-date write-off amount. Tracks bad debt expense; high write-offs indicate credit policy or collection process failures."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payments received across accounts. Used to assess recent collection momentum."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of receivable accounts. Baseline portfolio size KPI."
    - name: "credit_hold_account_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts on credit hold. Tracks credit risk exposure; high counts indicate deteriorating portfolio quality."
    - name: "avg_days_to_pay"
      expr: AVG(CAST(average_days_to_pay AS DOUBLE))
      comment: "Average days to pay across all accounts. Key DSO proxy metric; rising averages indicate worsening collection performance."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per account. Used to profile account-level receivables exposure and identify high-balance outliers."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_revenue_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS 15 revenue recognition KPIs tracking recognised vs. deferred revenue, recognition methods, and revenue event volumes by service category and accounting period. Used by Finance, Revenue Accounting, and External Audit to ensure compliant revenue recognition and period-close accuracy."
  source: "`vibe_shipping_ports_v1`.`billing`.`revenue_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition (e.g. RECOGNISED, DEFERRED, REVERSED, PENDING). Primary dimension for revenue recognition pipeline analysis."
    - name: "recognition_method"
      expr: recognition_method
      comment: "IFRS 15 recognition method applied (e.g. POINT_IN_TIME, OVER_TIME). Used to validate compliance with performance obligation satisfaction criteria."
    - name: "revenue_stream_category"
      expr: revenue_stream_category
      comment: "Revenue stream category (e.g. CONTAINER_HANDLING, VESSEL_DUES, STORAGE, ANCILLARY). Enables revenue decomposition by business line."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the revenue event. Unapproved events represent revenue recognition risk at period-close."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the revenue event is a reversal. Used to track revenue corrections and their financial impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue event. Enables multi-currency revenue recognition analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the revenue event. Used for annual revenue recognition reporting and audit."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Calendar month of revenue recognition. Enables monthly recognised revenue trend analysis aligned to financial reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the revenue event. Used for sub-annual revenue recognition analysis and period-close reconciliation."
  measures:
    - name: "total_recognised_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognised in the period under IFRS 15. Primary revenue KPI for financial reporting; compared against budget and prior periods."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods. Represents contract liabilities on the balance sheet; monitored for IFRS 15 compliance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments (variable consideration, contract modifications). Tracks the financial impact of revenue estimate revisions."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total service quantity underlying revenue events. Used to compute revenue yield per unit of service delivered."
    - name: "revenue_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events. Baseline volume KPI for revenue accounting throughput."
    - name: "reversal_event_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of revenue reversal events. High reversal counts indicate billing or recognition errors requiring process improvement."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate underlying revenue events. Used to benchmark effective revenue rates against tariff schedules."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct customers generating revenue events. Measures revenue breadth across the customer base."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit note and billing adjustment KPIs tracking the volume, value, and reasons for post-invoice corrections. Used by Revenue Assurance, Finance, and Billing Operations to monitor billing accuracy, credit note leakage, and adjustment approval governance."
  source: "`vibe_shipping_ports_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "credit_note_status"
      expr: credit_note_status
      comment: "Status of the credit note adjustment (e.g. DRAFT, APPROVED, POSTED, CANCELLED). Used to track adjustment pipeline and approval backlog."
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Reason code for the credit adjustment (e.g. TARIFF_ERROR, DUPLICATE_CHARGE, GOODWILL). Primary dimension for root-cause analysis of billing corrections."
    - name: "service_type"
      expr: service_type
      comment: "Service type to which the adjustment relates. Used to identify which service lines generate the most billing corrections."
    - name: "tariff_code"
      expr: tariff_code
      comment: "Tariff code associated with the adjustment. Used to identify tariff items with high correction rates."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the adjustment is a reversal of a prior adjustment. Used to track correction-of-correction events."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment. Enables multi-currency adjustment analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the adjustment. Used for annual credit note and adjustment reporting."
    - name: "applied_date_month"
      expr: DATE_TRUNC('MONTH', applied_date)
      comment: "Calendar month the adjustment was applied. Enables monthly adjustment volume and value trend analysis."
    - name: "customer_notification_sent"
      expr: customer_notification_sent
      comment: "Indicates whether the customer was notified of the adjustment. Tracks notification compliance for customer communication governance."
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued via adjustments. Measures revenue given back to customers; high values indicate systemic billing errors."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credit component of adjustments. Required for tax authority reporting and VAT reclaim management."
    - name: "total_net_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total net credit amount (credit + tax credit) issued. Represents total financial exposure from billing corrections."
    - name: "total_original_charge_amount"
      expr: SUM(CAST(original_charge_amount AS DOUBLE))
      comment: "Total original charge amount that was subsequently adjusted. Used to compute the adjustment rate as a percentage of billed revenue."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of billing adjustments issued. Baseline volume KPI; rising counts signal deteriorating billing accuracy."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal adjustments. Tracks correction-of-correction events which indicate compounding billing errors."
    - name: "distinct_customer_adjustment_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct customers receiving adjustments. Identifies customers with recurring billing issues for targeted account review."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per adjustment. Used to profile adjustment severity and prioritise high-value correction reviews."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collections KPIs tracking overdue invoice volumes, dunning escalation levels, settlement activity, and write-off risk. Used by Credit Control and Treasury to manage the collections process and minimise bad debt exposure."
  source: "`vibe_shipping_ports_v1`.`billing`.`dunning_notice`"
  dimensions:
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current status of the dunning notice (e.g. SENT, ACKNOWLEDGED, SETTLED, ESCALATED). Tracks collections pipeline progression."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level (e.g. LEVEL_1, LEVEL_2, LEGAL). Higher levels indicate greater collection risk and potential bad debt."
    - name: "dunning_method"
      expr: dunning_method
      comment: "Method used to issue the dunning notice (e.g. EMAIL, LETTER, PHONE, LEGAL_NOTICE). Used to optimise collections channel effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the overdue amount. Enables multi-currency collections analysis."
    - name: "credit_block_flag"
      expr: credit_block_flag
      comment: "Indicates whether a credit block has been applied to the account. Tracks credit risk enforcement actions."
    - name: "legal_action_threatened_flag"
      expr: legal_action_threatened_flag
      comment: "Indicates whether legal action has been threatened. Tracks escalation to legal collections stage."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the overdue amount has been written off. Tracks bad debt crystallisation events."
    - name: "payment_plan_offered_flag"
      expr: payment_plan_offered_flag
      comment: "Indicates whether a payment plan was offered to the customer. Tracks use of payment plan arrangements as a collections tool."
    - name: "dunning_date_month"
      expr: DATE_TRUNC('MONTH', dunning_date)
      comment: "Calendar month the dunning notice was issued. Enables monthly collections activity trend analysis."
  measures:
    - name: "total_overdue_amount"
      expr: SUM(CAST(total_overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all dunning notices. Primary collections risk KPI; directly impacts bad debt provisioning and cash flow forecasting."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled through the dunning process. Measures collections effectiveness; compared against total overdue to compute recovery rate."
    - name: "total_dunning_fee_amount"
      expr: SUM(CAST(dunning_fee_amount AS DOUBLE))
      comment: "Total dunning fees charged to overdue accounts. Tracks late-payment fee revenue and its deterrent effectiveness."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on overdue balances. Tracks interest income from late payments and monitors policy application consistency."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit of accounts under dunning. Used to assess credit exposure concentration in the overdue portfolio."
    - name: "dunning_notice_count"
      expr: COUNT(1)
      comment: "Total number of dunning notices issued. Baseline collections activity volume KPI."
    - name: "legal_action_count"
      expr: COUNT(CASE WHEN legal_action_threatened_flag = TRUE THEN 1 END)
      comment: "Number of accounts where legal action has been threatened. Tracks escalation to the most severe collections stage."
    - name: "write_off_count"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Number of accounts written off. Tracks bad debt crystallisation events; rising counts indicate credit policy failures."
    - name: "avg_overdue_amount"
      expr: AVG(CAST(total_overdue_amount AS DOUBLE))
      comment: "Average overdue amount per dunning notice. Used to profile overdue account severity and prioritise high-value collections efforts."
$$;


CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`billing_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS 15 performance obligation KPIs tracking the portfolio of contractual service obligations, standalone selling prices, and revenue recognition lifecycle. Used by Revenue Accounting and Finance to ensure compliant contract accounting and monitor obligation fulfilment."
  source: "`vibe_shipping_ports_v1`.`billing`.`performance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation (e.g. VESSEL_HANDLING, STORAGE, PILOTAGE, REEFER_MONITORING). Used to decompose the obligation portfolio by service type."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the obligation (e.g. ACTIVE, SATISFIED, CANCELLED, SUPERSEDED). Tracks obligation fulfilment progress."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "IFRS 15 recognition method (e.g. POINT_IN_TIME, OVER_TIME). Used to validate compliance with performance obligation satisfaction criteria."
    - name: "service_category"
      expr: service_category
      comment: "Service category of the obligation. Enables revenue obligation analysis by business line."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the obligation is billed (e.g. PER_CALL, MONTHLY, ANNUAL). Used to project billing cash flows."
    - name: "distinct_flag"
      expr: distinct_flag
      comment: "Indicates whether the obligation is distinct under IFRS 15. Distinct obligations must be accounted for separately; non-distinct obligations are bundled."
    - name: "variable_consideration_flag"
      expr: variable_consideration_flag
      comment: "Indicates whether the obligation includes variable consideration. Variable consideration requires estimation and constraint assessment under IFRS 15."
    - name: "ebitda_classification"
      expr: ebitda_classification
      comment: "EBITDA classification of the obligation revenue. Used to align revenue recognition with management reporting EBITDA structure."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Calendar month the obligation became effective. Enables cohort analysis of obligation portfolios by inception period."
  measures:
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Total standalone selling price (SSP) across all performance obligations. Used to allocate transaction prices under IFRS 15 and validate pricing consistency."
    - name: "total_standard_quantity"
      expr: SUM(CAST(standard_quantity AS DOUBLE))
      comment: "Total standard quantity committed across obligations. Used to project service delivery volumes and capacity requirements."
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Total number of performance obligations in the portfolio. Baseline KPI for contract accounting complexity and workload."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active performance obligations. Tracks the live obligation portfolio requiring ongoing revenue recognition."
    - name: "variable_consideration_obligation_count"
      expr: COUNT(CASE WHEN variable_consideration_flag = TRUE THEN 1 END)
      comment: "Number of obligations with variable consideration. Higher counts increase revenue estimation complexity and audit risk under IFRS 15."
    - name: "avg_standalone_selling_price"
      expr: AVG(CAST(standalone_selling_price AS DOUBLE))
      comment: "Average standalone selling price per obligation. Used to benchmark SSP consistency across similar service obligations."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct customers with active performance obligations. Measures the breadth of contractual service commitments across the customer base."
$$;
