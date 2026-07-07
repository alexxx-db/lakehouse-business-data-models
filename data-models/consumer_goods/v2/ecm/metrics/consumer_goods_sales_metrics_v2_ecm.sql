-- Metric views for domain: sales | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account assortment metrics measuring SKU distribution breadth, listing status, and VMI eligibility across the trade account portfolio."
  source: "`vibe_consumer_goods_v1`.`sales`.`account_assortment`"
  dimensions:
    - name: "account_assortment_status"
      expr: account_assortment_status
      comment: "Status of the assortment record (e.g. active, delisted, pending) for distribution management."
    - name: "listing_status"
      expr: listing_status
      comment: "Listing status of the SKU at the account (e.g. listed, delisted, pending) for distribution tracking."
    - name: "assortment_type"
      expr: assortment_type
      comment: "Type of assortment (e.g. core, seasonal, promotional) for range planning analysis."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates DSD-served assortment. Used to segment distribution by route-to-market."
    - name: "vmi_eligible_flag"
      expr: vmi_eligible_flag
      comment: "Indicates VMI eligibility for the assortment. Tracks VMI program expansion potential."
    - name: "exclusive_flag"
      expr: exclusive_flag
      comment: "Indicates exclusive assortment items. Tracks competitive differentiation at account level."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates promotional assortment items. Used to separate core vs. promotional distribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for assortment financial metrics."
    - name: "listing_date"
      expr: listing_date
      comment: "Date the SKU was listed at the account for distribution velocity analysis."
  measures:
    - name: "total_assortment_sku_count"
      expr: COUNT(DISTINCT account_assortment_id)
      comment: "Total number of SKU-account assortment records. Tracks distribution breadth across the account portfolio."
    - name: "active_listing_count"
      expr: COUNT(DISTINCT CASE WHEN listing_status = 'LISTED' THEN account_assortment_id END)
      comment: "Number of actively listed SKU-account combinations. Primary distribution point (TDP) count metric."
    - name: "total_moq"
      expr: SUM(CAST(moq AS DOUBLE))
      comment: "Total minimum order quantity across assortment records. Used for supply planning and order policy management."
    - name: "vmi_eligible_sku_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_eligible_flag = TRUE THEN account_assortment_id END)
      comment: "Number of VMI-eligible assortment records. Tracks VMI program coverage and expansion opportunity."
    - name: "avg_assortment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average financial amount per assortment record. Used as a proxy for assortment value contribution."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field sales execution metrics covering call frequency, compliance, and effectiveness. Used by sales management to evaluate rep productivity and in-store execution quality."
  source: "`vibe_consumer_goods_v1`.`sales`.`account_call`"
  dimensions:
    - name: "call_date"
      expr: call_date
      comment: "Date the sales call was conducted — primary time dimension for call activity trending."
    - name: "call_type"
      expr: call_type
      comment: "Type of sales call (e.g. Routine, Audit, New Listing) — used to analyze call mix and purpose."
    - name: "call_status"
      expr: call_status
      comment: "Status of the call (e.g. Completed, Planned, Cancelled) — used to measure call completion rates."
    - name: "call_outcome"
      expr: call_outcome
      comment: "Outcome of the sales call (e.g. Order Taken, Display Set, Issue Raised) — used to measure call effectiveness."
    - name: "display_compliance_flag"
      expr: display_compliance_flag
      comment: "Indicates whether display compliance was achieved during the call — used for in-store execution KPIs."
    - name: "shelf_position_compliant_flag"
      expr: shelf_position_compliant_flag
      comment: "Indicates whether shelf position was compliant during the call — used for planogram compliance tracking."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Description of corrective actions required — used to identify recurring execution issues."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Planned date for the call — used to measure call scheduling adherence."
  measures:
    - name: "total_calls"
      expr: COUNT(1)
      comment: "Total number of sales calls logged — baseline field activity volume metric."
    - name: "completed_calls"
      expr: COUNT(CASE WHEN call_status = 'Completed' THEN 1 END)
      comment: "Number of completed sales calls — used to measure rep call completion rate."
    - name: "call_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN call_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of planned calls completed — key field sales productivity KPI."
    - name: "display_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN display_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls where display compliance was achieved — measures in-store execution quality."
    - name: "shelf_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN shelf_position_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls where shelf position was compliant — planogram execution KPI."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_actions_completed_flag = FALSE AND corrective_actions_required IS NOT NULL THEN 1 END)
      comment: "Number of calls with outstanding corrective actions — used to track unresolved execution issues."
    - name: "avg_pog_compliance_score"
      expr: AVG(CAST(pog_compliance_score AS DOUBLE))
      comment: "Average planogram compliance score across calls — used to benchmark in-store execution quality."
    - name: "total_orders_taken_value"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total order value captured during sales calls — measures direct revenue generation from field activity."
    - name: "avg_call_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average order value per sales call — used to assess rep commercial effectiveness."
    - name: "calls_with_oos_count"
      expr: COUNT(CASE WHEN oos_items_count IS NOT NULL AND oos_items_count != '0' THEN 1 END)
      comment: "Number of calls where out-of-stock items were observed — used to quantify OSA issues in the field."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit risk and exposure metrics. Used by credit management and finance to monitor credit utilization, risk concentration, and collection health across the customer base."
  source: "`vibe_consumer_goods_v1`.`sales`.`account_credit_profile`"
  dimensions:
    - name: "credit_hold_status"
      expr: credit_hold_status
      comment: "Credit hold status of the account — used to identify accounts on hold and revenue at risk."
    - name: "risk_category"
      expr: risk_category
      comment: "Credit risk category (e.g. Low, Medium, High) — primary risk segmentation dimension."
    - name: "risk_class"
      expr: risk_class
      comment: "Credit risk class — used for portfolio-level risk concentration analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating of the account — used for credit policy and limit-setting decisions."
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the credit profile (e.g. Active, Suspended, Closed) — used to filter active credit relationships."
    - name: "payment_method_preference"
      expr: payment_method_preference
      comment: "Preferred payment method — used for cash flow forecasting and payment risk analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for the account — used to prioritize collections activity."
    - name: "credit_insurance_coverage_flag"
      expr: credit_insurance_coverage_flag
      comment: "Indicates whether credit insurance is in place — used to assess risk mitigation coverage."
    - name: "bankruptcy_flag"
      expr: bankruptcy_flag
      comment: "Indicates whether the account has filed for bankruptcy — used to flag high-risk exposure."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — measures total credit exposure capacity."
    - name: "total_credit_used"
      expr: SUM(CAST(credit_used AS DOUBLE))
      comment: "Total credit currently utilized — primary credit exposure KPI for risk management."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current credit exposure — used to monitor aggregate AR risk."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit_amount AS DOUBLE))
      comment: "Total available credit headroom — used to assess capacity for incremental business."
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(credit_used AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Credit utilization as a percentage of total credit limit — primary credit risk concentration KPI."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_status = 'On Hold' THEN 1 END)
      comment: "Number of accounts currently on credit hold — used to quantify revenue at risk from credit blocks."
    - name: "credit_hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_hold_status = 'On Hold' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts on credit hold — used to monitor credit portfolio health."
    - name: "total_credit_insurance_coverage"
      expr: SUM(CAST(credit_insurance_coverage_amount AS DOUBLE))
      comment: "Total credit insurance coverage amount — used to assess risk mitigation against total exposure."
    - name: "insurance_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(credit_insurance_coverage_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_exposure_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of credit exposure covered by insurance — measures risk mitigation effectiveness."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of credit profiles — used to track credit portfolio size."
    - name: "high_risk_account_count"
      expr: COUNT(CASE WHEN risk_category = 'High' THEN 1 END)
      comment: "Number of high-risk accounts — used to monitor concentration of credit risk."
    - name: "high_risk_exposure"
      expr: SUM(CASE WHEN risk_category = 'High' THEN CAST(current_exposure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total credit exposure from high-risk accounts — used to quantify tail risk in the AR portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service level agreement metrics. Used by commercial and supply chain teams to monitor SLA commitments, performance targets, and penalty/incentive exposure."
  source: "`vibe_consumer_goods_v1`.`sales`.`account_sla`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. OTIF, Fill Rate, OSA) — used to segment SLA performance by commitment type."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier level — used to segment accounts by service commitment level."
    - name: "account_sla_status"
      expr: account_sla_status
      comment: "Current status of the SLA (e.g. Active, Expired, Breached) — used to filter live SLA commitments."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period for the SLA — used for period-level SLA performance analysis."
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "SLA effective start date — used for SLA lifecycle analysis."
    - name: "effective_to_date"
      expr: effective_to_date
      comment: "SLA effective end date — used to identify expiring SLAs."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the SLA auto-renews — used for contract management planning."
  measures:
    - name: "sla_count"
      expr: COUNT(1)
      comment: "Total number of SLA records — used to track SLA portfolio size."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage across SLAs — used to benchmark service commitment levels."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target across SLAs — used to assess service level commitments."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty exposure across SLA agreements — used to quantify financial risk from SLA breaches."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive opportunity across SLA agreements — used to quantify upside from SLA over-performance."
    - name: "avg_minimum_performance_threshold"
      expr: AVG(CAST(minimum_performance_threshold AS DOUBLE))
      comment: "Average minimum performance threshold — used to assess floor-level service commitments."
    - name: "avg_target_metric_value"
      expr: AVG(CAST(target_metric_value AS DOUBLE))
      comment: "Average target metric value across SLAs — used to benchmark service targets."
    - name: "net_incentive_penalty_exposure"
      expr: SUM(CAST(incentive_amount AS DOUBLE) - CAST(penalty_amount AS DOUBLE))
      comment: "Net financial exposure (incentive minus penalty) across SLAs — used to assess overall SLA financial position."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_distribution_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution point and numeric distribution metrics. Used by category management and sales to track SKU distribution coverage, ACV-weighted distribution, and listing health."
  source: "`vibe_consumer_goods_v1`.`sales`.`distribution_point`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current distribution status of the SKU at the point (e.g. Active, Delisted, Pending) — primary distribution health dimension."
    - name: "distribution_point_status"
      expr: distribution_point_status
      comment: "Operational status of the distribution point record — used to filter active vs. inactive points."
    - name: "channel_type"
      expr: channel_type
      comment: "Retail channel type — used for channel-level distribution analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel — used for channel distribution coverage reporting."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for the distribution point — used to filter live distribution."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates DSD (Direct Store Delivery) distribution — used to segment DSD vs. warehouse distribution."
    - name: "tdp_count_flag"
      expr: tdp_count_flag
      comment: "Indicates whether this point counts toward TDP (Total Distribution Points) — used for TDP metric calculation."
    - name: "new_product_flag"
      expr: new_product_flag
      comment: "Indicates a new product distribution point — used to track new product launch distribution velocity."
    - name: "activation_date"
      expr: activation_date
      comment: "Date the distribution point was activated — used for distribution ramp analysis."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the distribution point — used for regional distribution coverage analysis."
  measures:
    - name: "total_distribution_points"
      expr: COUNT(1)
      comment: "Total number of distribution points — baseline numeric distribution metric (TDP count)."
    - name: "active_distribution_points"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active distribution points — used to measure live SKU distribution coverage."
    - name: "tdp_count"
      expr: COUNT(CASE WHEN tdp_count_flag = TRUE THEN 1 END)
      comment: "Total Distribution Points (TDP) count — primary numeric distribution KPI for category management."
    - name: "total_acv_percentage"
      expr: SUM(CAST(acv_percentage AS DOUBLE))
      comment: "Sum of ACV percentages across distribution points — used to compute ACV-weighted distribution."
    - name: "avg_acv_percentage"
      expr: AVG(CAST(acv_percentage AS DOUBLE))
      comment: "Average ACV percentage per distribution point — used to assess quality of distribution coverage."
    - name: "avg_actual_retail_price"
      expr: AVG(CAST(actual_retail_price AS DOUBLE))
      comment: "Average actual retail price across distribution points — used to monitor price realization at shelf."
    - name: "avg_msrp_price"
      expr: AVG(CAST(msrp_price AS DOUBLE))
      comment: "Average MSRP across distribution points — used to benchmark actual vs. recommended pricing."
    - name: "price_to_msrp_ratio"
      expr: ROUND(100.0 * AVG(CAST(actual_retail_price AS DOUBLE)) / NULLIF(AVG(CAST(msrp_price AS DOUBLE)), 0), 2)
      comment: "Actual retail price as a percentage of MSRP — used to monitor pricing compliance and promotional depth."
    - name: "new_distribution_points"
      expr: COUNT(CASE WHEN new_product_flag = TRUE THEN 1 END)
      comment: "Number of new product distribution points — used to track new product launch distribution velocity."
    - name: "dsd_distribution_points"
      expr: COUNT(CASE WHEN dsd_flag = TRUE THEN 1 END)
      comment: "Number of DSD distribution points — used to measure DSD channel coverage."
    - name: "pog_compliant_points"
      expr: COUNT(CASE WHEN pog_compliance_flag = TRUE THEN 1 END)
      comment: "Number of distribution points with planogram compliance — used to measure execution quality across distribution."
    - name: "pog_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pog_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Planogram compliance rate across active distribution points — measures in-store execution quality at scale."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable and billing performance metrics. Covers revenue recognition, payment status, dispute management, and DSO — critical for finance and commercial teams."
  source: "`vibe_consumer_goods_v1`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. Open, Paid, Disputed, Overdue) — primary AR aging dimension."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice — used to segment outstanding vs. collected receivables."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing document (e.g. Standard, Credit Memo, Debit Memo) — used for billing mix analysis."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued — primary time dimension for AR aging and revenue recognition."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date — used to compute overdue exposure and DSO."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AR reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, Wire, Check) — used for cash flow forecasting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice — used to segment AR by terms bucket."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel associated with the invoice — used for channel revenue reporting."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "Revenue recognition category — required for ASC 606 / IFRS 15 compliance reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — used to isolate disputed AR exposure."
  measures:
    - name: "total_invoiced_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoiced amount — top-line billed revenue KPI for finance and commercial reporting."
    - name: "total_invoiced_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoiced amount after discounts and allowances — used for net revenue reporting."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding (unpaid) AR balance — primary cash flow and credit risk KPI."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected — used to track cash collection efficiency."
    - name: "total_trade_discount_amount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discounts applied on invoices — used to monitor trade spend and net revenue impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed — required for tax compliance and liability reporting."
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges billed to customers — used to assess freight recovery rate."
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin on invoiced sales — profitability KPI for commercial finance."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued — baseline billing volume metric."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute — used to monitor AR quality and customer satisfaction issues."
    - name: "disputed_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total AR balance under dispute — risk exposure KPI for credit and collections teams."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute — signals billing accuracy and customer relationship health."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected — primary cash collection efficiency KPI."
    - name: "gross_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of net invoiced revenue — profitability ratio for executive reporting."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice value — used to track deal size trends and commercial mix shifts."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity management metrics. Used by sales leadership to forecast revenue, manage pipeline health, and evaluate win/loss performance."
  source: "`vibe_consumer_goods_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current stage/status of the opportunity (e.g. Prospecting, Proposal, Closed Won) — primary pipeline dimension."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (e.g. New Business, Expansion, Renewal) — used for pipeline mix analysis."
    - name: "stage"
      expr: stage
      comment: "Sales stage of the opportunity — used for funnel conversion analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for the opportunity — used for channel pipeline analysis."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (e.g. Commit, Best Case, Pipeline) — used for revenue forecasting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expected close — used for annual pipeline planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the expected close — used for quarterly pipeline reviews."
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Expected close date — used for pipeline timing and revenue forecasting."
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the opportunity lead — used to evaluate lead generation channel effectiveness."
    - name: "jbp_alignment_flag"
      expr: jbp_alignment_flag
      comment: "Indicates whether the opportunity is aligned to a Joint Business Plan — used for strategic account tracking."
  measures:
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all pipeline opportunities — primary revenue forecast input for sales leadership."
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue from pipeline opportunities — used for annual revenue planning."
    - name: "total_estimated_acv_gain"
      expr: SUM(CAST(estimated_acv_gain AS DOUBLE))
      comment: "Total estimated ACV (All Commodity Volume) gain from opportunities — used for distribution expansion planning."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline — baseline pipeline volume metric."
    - name: "avg_probability_pct"
      expr: AVG(CAST(probability_pct AS DOUBLE))
      comment: "Average win probability across pipeline opportunities — used to weight pipeline value for forecasting."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE) * CAST(probability_pct AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value — most accurate revenue forecast metric for executive planning."
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average opportunity value — used to track deal size trends and commercial mix."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN opportunity_status = 'Closed Won' THEN 1 END)
      comment: "Number of won opportunities — used to measure sales conversion success."
    - name: "lost_opportunity_count"
      expr: COUNT(CASE WHEN opportunity_status = 'Closed Lost' THEN 1 END)
      comment: "Number of lost opportunities — used to analyze competitive loss patterns."
    - name: "win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opportunity_status = 'Closed Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN opportunity_status IN ('Closed Won', 'Closed Lost') THEN 1 END), 0), 2)
      comment: "Win rate as a percentage of closed opportunities — primary sales effectiveness KPI."
    - name: "won_revenue"
      expr: SUM(CASE WHEN opportunity_status = 'Closed Won' THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total revenue value of won opportunities — used to measure actual pipeline conversion to revenue."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order performance metrics covering revenue, margin, volume, and fulfillment efficiency. Primary KPI surface for sales leadership and supply chain steering."
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g. Open, Confirmed, Shipped, Cancelled) — used to filter pipeline vs. fulfilled revenue."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, DSD, VMI, Return) — drives channel-mix analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel through which the order was placed — key dimension for channel P&L."
    - name: "order_date"
      expr: order_date
      comment: "Calendar date the order was placed — used for time-series trending and period comparisons."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Customer-requested delivery date — used to measure on-time performance."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual date the order was delivered — used to compute delivery lead time and OTIF."
    - name: "otif_status"
      expr: otif_status
      comment: "On-Time In-Full status flag for the order — primary SLA compliance dimension."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel code (e.g. Retail, Wholesale, DTC) — used for channel revenue segmentation."
    - name: "sales_organization"
      expr: sales_organization
      comment: "SAP sales organization responsible for the order — used for org-level P&L attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue reporting."
    - name: "priority"
      expr: priority
      comment: "Order priority level — used to analyze fulfillment performance by priority tier."
    - name: "order_source"
      expr: source
      comment: "System or channel that originated the order (e.g. EDI, Web, Manual) — used for order intake analysis."
  measures:
    - name: "total_order_gross_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue across all orders. Primary top-line revenue KPI for sales leadership."
    - name: "total_order_net_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Net revenue (pre-tax, pre-freight subtotal) — used for net sales reporting and margin analysis."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars across orders. Directly informs profitability steering decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across orders — used to monitor promotional spend and pricing discipline."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges on orders — used to track logistics cost burden on revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across orders — required for tax liability reporting."
    - name: "total_order_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units ordered — volume KPI used for demand and capacity planning."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of orders placed — baseline volume metric for order intake trending."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value — key commercial health indicator; declining AOV signals pricing or mix erosion."
    - name: "avg_gross_margin_per_order"
      expr: AVG(CAST(gross_margin_amount AS DOUBLE))
      comment: "Average gross margin per order — used to assess profitability mix across channels and accounts."
    - name: "gross_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of total revenue — primary profitability ratio for executive dashboards."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross revenue — monitors pricing discipline and promotional leakage."
    - name: "freight_as_pct_of_revenue"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of revenue — used to track logistics efficiency and cost-to-serve."
    - name: "otif_order_count"
      expr: COUNT(CASE WHEN otif_status = 'OTIF' THEN 1 END)
      comment: "Count of orders delivered On-Time In-Full — numerator for OTIF rate calculation."
    - name: "otif_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN otif_status = 'OTIF' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders delivered On-Time In-Full — critical SLA KPI for customer satisfaction and penalty avoidance."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled orders — used to monitor order fallout and revenue leakage risk."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders cancelled — signals demand volatility, supply issues, or customer dissatisfaction."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, order_date) AS DOUBLE))
      comment: "Average days from order placement to delivery — operational efficiency KPI for supply chain and customer service."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_return_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales return and reverse logistics metrics. Used by supply chain, quality, and commercial teams to monitor return volume, value, and root cause — directly impacts net revenue and customer satisfaction."
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the original sale — used for channel-level return analysis."
  measures:
    - name: "return_order_count"
      expr: COUNT(1)
      comment: "Total number of return orders — baseline return volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_planogram_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-store planogram and shelf execution compliance metrics. Used by category management and field sales to measure retail execution quality and drive corrective action."
  source: "`vibe_consumer_goods_v1`.`sales`.`planogram_compliance`"
  dimensions:
    - name: "audit_date"
      expr: audit_date
      comment: "Date of the planogram compliance audit — primary time dimension for execution trending."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g. Routine, Spot Check, Post-Reset) — used to segment compliance by audit type."
    - name: "planogram_compliance_status"
      expr: planogram_compliance_status
      comment: "Overall compliance status of the audit — used to filter compliant vs. non-compliant stores."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether corrective action is required — used to prioritize field follow-up."
    - name: "osa_compliance_flag"
      expr: osa_compliance_flag
      comment: "On-shelf availability compliance flag — used to measure OSA performance at store level."
    - name: "shelf_position_compliant_flag"
      expr: shelf_position_compliant_flag
      comment: "Indicates whether shelf position was compliant — used for planogram adherence tracking."
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category audited — used for category-level compliance analysis."
    - name: "pog_version_code"
      expr: pog_version_code
      comment: "Planogram version being audited — used to track compliance by POG version."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of corrective action resolution — used to track issue closure rates."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of planogram compliance audits conducted — baseline execution coverage metric."
    - name: "avg_compliance_pct"
      expr: AVG(CAST(compliance_pct AS DOUBLE))
      comment: "Average planogram compliance percentage across audits — primary in-store execution KPI."
    - name: "avg_display_compliance_score"
      expr: AVG(CAST(display_compliance_score AS DOUBLE))
      comment: "Average display compliance score — used to measure secondary display execution quality."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action — used to quantify execution gap volume."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action — measures overall execution failure rate."
    - name: "osa_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN osa_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-shelf availability compliance rate — critical KPI for lost sales prevention."
    - name: "shelf_position_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN shelf_position_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where shelf position was compliant — measures planogram adherence."
    - name: "unauthorized_substitution_count"
      expr: COUNT(CASE WHEN unauthorized_substitution_flag = TRUE THEN 1 END)
      comment: "Number of audits with unauthorized product substitutions — used to protect brand shelf space."
    - name: "avg_previous_audit_score"
      expr: AVG(CAST(previous_audit_score AS DOUBLE))
      comment: "Average prior audit score — used as baseline for measuring compliance improvement trends."
    - name: "compliance_improvement"
      expr: ROUND(AVG(CAST(compliance_pct AS DOUBLE)) - AVG(CAST(previous_audit_score AS DOUBLE)), 2)
      comment: "Average improvement in compliance score vs. prior audit — measures execution improvement trajectory."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale retail execution metrics covering sell-out velocity, promotional lift, and out-of-stock performance. Essential for category management and trade marketing decisions."
  source: "`vibe_consumer_goods_v1`.`sales`.`pos_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the POS transaction — primary time dimension for sell-out trending."
    - name: "channel_type"
      expr: channel_type
      comment: "Retail channel type (e.g. Grocery, Drug, Mass) — used for channel sell-out analysis."
    - name: "store_format"
      expr: store_format
      comment: "Physical store format (e.g. Hypermarket, Convenience) — used for format-level performance analysis."
    - name: "store_country_code"
      expr: store_country_code
      comment: "Country where the store is located — used for geographic sell-out reporting."
    - name: "store_state_province"
      expr: store_state_province
      comment: "State or province of the store — used for regional sell-out analysis."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the transaction was on promotion — used to measure promotional lift."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion applied (e.g. TPR, Display, Feature) — used for promotional effectiveness analysis."
    - name: "out_of_stock_flag"
      expr: out_of_stock_flag
      comment: "Indicates an out-of-stock event at time of transaction — used to quantify lost sales."
    - name: "baseline_sales_flag"
      expr: baseline_sales_flag
      comment: "Indicates whether the sale is baseline (non-promoted) — used to separate base vs. incremental volume."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency retail reporting."
    - name: "week_ending_date"
      expr: week_ending_date
      comment: "Week-ending date for the transaction — standard CPG weekly reporting period."
    - name: "data_source"
      expr: data_source
      comment: "Source of the POS data (e.g. Retailer Direct, Syndicated) — used to assess data coverage and quality."
  measures:
    - name: "total_sales_amount"
      expr: SUM(CAST(sales_amount AS DOUBLE))
      comment: "Total retail sales value (sell-out revenue) — primary consumer demand KPI for category management."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold at retail — volume KPI for market share and velocity analysis."
    - name: "total_extended_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total extended retail value (units × retail price) — used for market share and ACV-weighted distribution."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional discount value at retail — used to measure trade investment efficiency."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of POS transactions — baseline volume metric for retail coverage."
    - name: "promoted_transaction_count"
      expr: COUNT(CASE WHEN promotional_flag = TRUE THEN 1 END)
      comment: "Number of transactions occurring on promotion — used to measure promotional reach."
    - name: "oos_transaction_count"
      expr: COUNT(CASE WHEN out_of_stock_flag = TRUE THEN 1 END)
      comment: "Number of out-of-stock events recorded — used to quantify lost sales and OSA performance."
    - name: "oos_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_stock_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Out-of-stock rate as a percentage of total transactions — critical on-shelf availability KPI."
    - name: "promotional_sales_amount"
      expr: SUM(CASE WHEN promotional_flag = TRUE THEN CAST(sales_amount AS DOUBLE) ELSE 0 END)
      comment: "Total sales value generated on promotion — used to calculate promotional lift and ROI."
    - name: "baseline_sales_amount"
      expr: SUM(CASE WHEN baseline_sales_flag = TRUE THEN CAST(sales_amount AS DOUBLE) ELSE 0 END)
      comment: "Total baseline (non-promoted) sales value — used to isolate incremental promotional volume."
    - name: "avg_retail_selling_price"
      expr: AVG(CAST(retail_selling_price AS DOUBLE))
      comment: "Average retail selling price per transaction — used to monitor price realization and competitive positioning."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(units_sold AS DOUBLE))
      comment: "Average units sold per transaction — basket size indicator for category performance."
    - name: "promotional_sales_mix"
      expr: ROUND(100.0 * SUM(CASE WHEN promotional_flag = TRUE THEN CAST(sales_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(sales_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total sales generated on promotion — used to assess promotional dependency and pricing health."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average POS data quality score — used to assess reliability of sell-out data for decision-making."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and target management metrics. Used by sales leadership to set, track, and evaluate rep and team performance against targets."
  source: "`vibe_consumer_goods_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (e.g. Revenue, Volume, TDP) — used to segment quota performance by KPI type."
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota (e.g. Active, Draft, Approved) — used to filter live vs. draft targets."
    - name: "period_type"
      expr: period_type
      comment: "Period type for the quota (e.g. Monthly, Quarterly, Annual) — used for period-level performance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota — used for annual target vs. actual comparisons."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota — used for quarterly business review performance tracking."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel the quota applies to — used for channel-level target analysis."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the quota period — used for time-series quota trending."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the quota period — used to identify active quota windows."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota — used to filter approved vs. pending targets."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the quota targets — used for segment-level quota analysis."
  measures:
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota target value — primary target-setting KPI for sales planning and compensation."
    - name: "total_stretch_target"
      expr: SUM(CAST(stretch_target AS DOUBLE))
      comment: "Total stretch target value — used to assess upside potential and incentive plan design."
    - name: "total_minimum_threshold"
      expr: SUM(CAST(minimum_threshold AS DOUBLE))
      comment: "Total minimum performance threshold — used to define floor for commission eligibility."
    - name: "quota_record_count"
      expr: COUNT(1)
      comment: "Total number of quota records — used to track quota coverage across reps, teams, and periods."
    - name: "avg_quota_amount"
      expr: AVG(CAST(quota_amount AS DOUBLE))
      comment: "Average quota amount per record — used to benchmark quota levels across reps and territories."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across quota records — used to monitor compensation plan cost and design."
    - name: "avg_accelerator_rate"
      expr: AVG(CAST(accelerator_rate AS DOUBLE))
      comment: "Average accelerator rate for over-quota performance — used to assess incentive plan aggressiveness."
    - name: "total_quota_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total quota value (alternate value field) — used for volume-based quota tracking alongside revenue quotas."
    - name: "approved_quota_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved quota records — used to track quota finalization progress."
    - name: "quota_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quota records that have been approved — used to monitor quota-setting process completion."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade deduction and claims management metrics. Used by finance and commercial teams to monitor deduction volume, validity, and resolution efficiency — directly impacts net revenue realization."
  source: "`vibe_consumer_goods_v1`.`sales`.`sales_deduction`"
  dimensions:
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (e.g. Promotional, Shortage, Pricing) — used to categorize deduction root causes."
    - name: "deduction_status"
      expr: deduction_status
      comment: "Current status of the deduction (e.g. Open, Resolved, Disputed) — used for AR aging and resolution tracking."
    - name: "sales_deduction_status"
      expr: sales_deduction_status
      comment: "Operational status of the sales deduction record — used for workflow management."
    - name: "valid_claim_flag"
      expr: valid_claim_flag
      comment: "Indicates whether the deduction claim is valid — used to separate legitimate vs. invalid deductions."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the deduction has been escalated — used to prioritize high-risk deductions."
    - name: "deduction_date"
      expr: deduction_date
      comment: "Date the deduction was taken — primary time dimension for deduction trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deduction — required for multi-currency deduction reporting."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the deduction — used to identify systemic issues driving deduction volume."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel associated with the deduction — used for channel-level deduction analysis."
  measures:
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount taken — primary net revenue impact KPI for commercial finance."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed by customers — used to measure gross deduction exposure."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved deduction amount — used to measure validated trade spend."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed deduction amount — used to quantify contested AR exposure."
    - name: "deduction_count"
      expr: COUNT(1)
      comment: "Total number of deduction records — baseline volume metric for deduction management."
    - name: "valid_deduction_count"
      expr: COUNT(CASE WHEN valid_claim_flag = TRUE THEN 1 END)
      comment: "Number of valid deduction claims — used to measure legitimate trade spend."
    - name: "invalid_deduction_count"
      expr: COUNT(CASE WHEN valid_claim_flag = FALSE THEN 1 END)
      comment: "Number of invalid deduction claims — used to quantify revenue leakage from invalid claims."
    - name: "invalid_deduction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN valid_claim_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deductions that are invalid — key metric for deduction quality and revenue protection."
    - name: "invalid_deduction_amount"
      expr: SUM(CASE WHEN valid_claim_flag = FALSE THEN CAST(deduction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of invalid deductions — quantifies recoverable revenue leakage."
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount that was approved — used to assess deduction validation rigor."
    - name: "avg_deduction_amount"
      expr: AVG(CAST(deduction_amount AS DOUBLE))
      comment: "Average deduction amount per record — used to benchmark deduction size and identify outliers."
    - name: "escalated_deduction_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated deductions — used to monitor high-risk deduction pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales rebate agreement performance metrics. Used by commercial finance and trade marketing to monitor rebate accruals, settlement efficiency, and program ROI."
  source: "`vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. Volume, Growth, Promotional) — used to segment rebate spend by program type."
    - name: "sales_rebate_agreement_status"
      expr: sales_rebate_agreement_status
      comment: "Status of the rebate agreement (e.g. Active, Expired, Pending) — used to filter live agreements."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement — used to track agreement finalization."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "How often rebates are settled (e.g. Monthly, Quarterly, Annual) — used for cash flow planning."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for rebate calculation (e.g. Net Sales, Invoice Value) — used for rebate program design analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the rebate agreement — used for agreement lifecycle analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the rebate agreement — used to identify expiring agreements."
    - name: "tier_structure_flag"
      expr: tier_structure_flag
      comment: "Indicates whether the rebate has a tiered structure — used to segment tiered vs. flat rebate programs."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews — used for contract management planning."
  measures:
    - name: "total_accrued_rebate_amount"
      expr: SUM(CAST(accrued_rebate_amount AS DOUBLE))
      comment: "Total accrued rebate liability — primary trade spend liability KPI for commercial finance."
    - name: "total_settled_rebate_amount"
      expr: SUM(CAST(settled_rebate_amount AS DOUBLE))
      comment: "Total rebate amount already settled — used to track cash outflow from rebate programs."
    - name: "total_maximum_rebate_amount"
      expr: SUM(CAST(maximum_rebate_amount AS DOUBLE))
      comment: "Total maximum rebate exposure across all agreements — used for worst-case trade spend planning."
    - name: "total_minimum_qualification_amount"
      expr: SUM(CAST(minimum_qualification_amount AS DOUBLE))
      comment: "Total minimum qualification threshold across agreements — used to assess rebate program accessibility."
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of rebate agreements — used to track program portfolio size."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN sales_rebate_agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active rebate agreements — used to monitor live trade spend commitments."
    - name: "avg_rebate_pct"
      expr: AVG(CAST(rebate_pct AS DOUBLE))
      comment: "Average rebate percentage across agreements — used to benchmark trade investment rates."
    - name: "settlement_rate"
      expr: ROUND(100.0 * SUM(CAST(settled_rebate_amount AS DOUBLE)) / NULLIF(SUM(CAST(accrued_rebate_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued rebates that have been settled — measures rebate settlement efficiency."
    - name: "unsettled_rebate_amount"
      expr: SUM(CAST(accrued_rebate_amount AS DOUBLE) - CAST(settled_rebate_amount AS DOUBLE))
      comment: "Total outstanding unsettled rebate liability — used to monitor open trade spend obligations."
$$;
