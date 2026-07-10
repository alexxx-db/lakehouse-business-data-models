-- Metric views for domain: sales | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales pipeline and opportunity performance metrics. Tracks pipeline value, win rates, discount behavior, and deal velocity to steer revenue forecasting and sales strategy."
  source: "`vibe_manufacturing_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g., Prospecting, Qualification, Proposal, Closed Won)."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast bucket assigned to the opportunity (e.g., Commit, Best Case, Pipeline, Omitted)."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Classification of the opportunity (e.g., New Business, Renewal, Upsell, Cross-sell)."
    - name: "lead_source"
      expr: lead_source
      comment: "Channel or source that originated the opportunity (e.g., Web, Partner, Campaign, Referral)."
    - name: "region"
      expr: region
      comment: "Geographic region associated with the opportunity for territory-level analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the target customer, enabling segment-level pipeline analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the opportunity for product-mix pipeline analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity for annual pipeline and bookings reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the opportunity for quarterly business review analysis."
    - name: "is_won"
      expr: is_won
      comment: "Boolean flag indicating whether the opportunity was won, enabling win/loss segmentation."
    - name: "is_closed"
      expr: is_closed
      comment: "Boolean flag indicating whether the opportunity is closed (won or lost)."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month-level bucket of the expected close date for pipeline aging and monthly cadence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the opportunity for multi-currency pipeline reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the opportunity for geographic revenue analysis."
  measures:
    - name: "total_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total pipeline value (sum of opportunity amounts) across all open and closed opportunities. Primary top-line pipeline KPI used in QBRs and board decks."
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue AS DOUBLE))
      comment: "Sum of expected revenue across opportunities, reflecting probability-weighted or rep-estimated revenue. Used for revenue forecasting."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities. Used to assess pipeline volume and sales activity levels."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Count of won opportunities. Numerator for win rate calculation and bookings tracking."
    - name: "closed_opportunity_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Count of closed opportunities (won + lost). Denominator for win rate calculation."
    - name: "avg_opportunity_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average deal size across opportunities. Tracks deal size trends and informs capacity planning and quota setting."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across open opportunities. Indicates overall pipeline health and confidence level."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to opportunities. Monitors pricing discipline and margin erosion risk."
    - name: "total_won_amount"
      expr: SUM(CASE WHEN is_won = TRUE THEN amount ELSE 0 END)
      comment: "Total value of won opportunities (bookings). Core revenue attainment KPI for sales leadership."
    - name: "avg_sales_cycle_days"
      expr: AVG(CAST(sales_cycle_days AS DOUBLE))
      comment: "Average number of days from opportunity creation to close. Measures sales velocity and process efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order intake (bookings) metrics tracking the volume and value of orders received. Critical for revenue recognition, backlog management, and demand planning alignment."
  source: "`vibe_manufacturing_v1`.`sales`.`order_intake`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., Standard, Rush, Blanket, Service) for order-mix analysis."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order for fulfillment sequencing and escalation tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the order intake for annual bookings reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the order intake for quarterly bookings cadence."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the customer placing the order for segment-level bookings analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the order for product-mix bookings analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order for multi-currency bookings reporting."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (Incoterms) on the order for logistics cost and risk allocation analysis."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Credit approval status of the order, used to monitor credit risk exposure in the order book."
    - name: "booking_recognized_flag"
      expr: booking_recognized_flag
      comment: "Flag indicating whether the booking has been formally recognized for revenue reporting purposes."
    - name: "intake_date_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month-level bucket of the intake date for monthly bookings trend analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected on the order for logistics cost and lead-time analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the order for cash flow forecasting and DSO analysis."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total bookings value in transaction currency. Primary order intake KPI for revenue forecasting and backlog management."
    - name: "total_order_value_base_currency"
      expr: SUM(CAST(order_value_base_currency AS DOUBLE))
      comment: "Total bookings value normalized to base currency. Enables consistent cross-currency bookings reporting for finance."
    - name: "order_intake_count"
      expr: COUNT(1)
      comment: "Total number of orders received. Tracks order volume trends and sales activity."
    - name: "avg_order_value"
      expr: AVG(CAST(order_value AS DOUBLE))
      comment: "Average order value. Monitors deal size trends and informs pricing and bundling strategy."
    - name: "recognized_bookings_value"
      expr: SUM(CASE WHEN booking_recognized_flag = TRUE THEN order_value_base_currency ELSE 0 END)
      comment: "Total value of formally recognized bookings. Used for revenue recognition reporting and financial close."
    - name: "unrecognized_bookings_value"
      expr: SUM(CASE WHEN booking_recognized_flag = FALSE OR booking_recognized_flag IS NULL THEN order_value_base_currency ELSE 0 END)
      comment: "Total value of orders not yet recognized as bookings. Represents pending backlog requiring follow-up."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to orders. Used to monitor FX exposure and currency risk in the order book."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast accuracy and pipeline coverage metrics. Enables comparison of committed, pipeline, and quota amounts to drive forecast discipline and revenue predictability."
  source: "`vibe_manufacturing_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast record (e.g., Draft, Submitted, Approved, Locked)."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast bucket (e.g., Commit, Best Case, Pipeline) for pipeline coverage analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast for annual revenue planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast for quarterly business review cadence."
    - name: "period_type"
      expr: period_type
      comment: "Granularity of the forecast period (e.g., Monthly, Quarterly, Annual)."
    - name: "product_line"
      expr: product_line
      comment: "Product line covered by the forecast for product-mix revenue planning."
    - name: "region"
      expr: region
      comment: "Geographic region of the forecast for territory-level revenue planning."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the forecast for segment-level revenue planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast amounts for multi-currency reporting."
    - name: "is_latest_version"
      expr: is_latest_version
      comment: "Flag indicating whether this is the most current forecast version, enabling point-in-time vs. current analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of forecast submission for tracking forecast cadence and timeliness."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed forecast amount. Represents the highest-confidence revenue signal used by finance for revenue recognition planning."
    - name: "total_pipeline_amount"
      expr: SUM(CAST(pipeline_amount AS DOUBLE))
      comment: "Total pipeline amount in the forecast. Measures the breadth of the sales funnel available to cover quota."
    - name: "total_best_case_amount"
      expr: SUM(CAST(best_case_amount AS DOUBLE))
      comment: "Total best-case forecast amount. Represents the upside scenario used for capacity and supply planning."
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota amount against which forecast attainment is measured. Core denominator for quota coverage analysis."
    - name: "total_submitted_amount"
      expr: SUM(CAST(submitted_amount AS DOUBLE))
      comment: "Total amount submitted by sales reps in their forecasts. Used to compare rep-submitted vs. manager-adjusted forecasts."
    - name: "total_manager_adjusted_amount"
      expr: SUM(CAST(manager_adjusted_amount AS DOUBLE))
      comment: "Total manager-adjusted forecast amount. Measures the degree of management override applied to rep forecasts."
    - name: "total_weighted_pipeline_amount"
      expr: SUM(CAST(weighted_pipeline_amount AS DOUBLE))
      comment: "Total probability-weighted pipeline amount. Provides a risk-adjusted revenue estimate for financial planning."
    - name: "total_closed_amount"
      expr: SUM(CAST(closed_amount AS DOUBLE))
      comment: "Total closed/won amount within the forecast period. Tracks actual bookings against forecast."
    - name: "avg_quota_attainment_percent"
      expr: AVG(CAST(quota_attainment_percent AS DOUBLE))
      comment: "Average quota attainment percentage across forecast records. Key sales performance indicator for rep and team evaluation."
    - name: "avg_variance_to_quota"
      expr: AVG(CAST(variance_to_quota AS DOUBLE))
      comment: "Average variance between forecast and quota. Identifies systematic over- or under-forecasting patterns."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of forecast records. Used to assess forecast submission completeness and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota attainment and allocation metrics. Tracks rep and team performance against targets to drive compensation, coaching, and territory planning decisions."
  source: "`vibe_manufacturing_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (e.g., Revenue, Units, Activity) for multi-dimensional performance tracking."
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota record (e.g., Draft, Approved, Active, Closed)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota for annual performance planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota for quarterly attainment tracking."
    - name: "product_line"
      expr: product_line
      comment: "Product line scope of the quota for product-mix performance analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the quota for territory-level attainment analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the quota for segment-level performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quota amounts for multi-currency reporting."
    - name: "is_team_quota"
      expr: is_team_quota
      comment: "Flag indicating whether this is a team-level quota vs. individual rep quota."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate quota (e.g., Top-Down, Bottom-Up, Historical) for quota-setting process analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota record for governance and audit tracking."
  measures:
    - name: "total_base_quota_amount"
      expr: SUM(CAST(base_quota_amount AS DOUBLE))
      comment: "Total base quota amount across all quota records. Primary target metric for sales performance management."
    - name: "total_attainment_amount"
      expr: SUM(CAST(attainment_amount AS DOUBLE))
      comment: "Total actual attainment amount. Measures revenue booked against quota targets."
    - name: "total_stretch_quota_amount"
      expr: SUM(CAST(stretch_quota_amount AS DOUBLE))
      comment: "Total stretch quota amount. Represents the aspirational target used for incentive compensation upside."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining quota gap (quota minus attainment). Identifies how much revenue is still needed to hit targets."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total quota adjustments applied. Tracks mid-period quota changes for fairness and governance review."
    - name: "avg_attainment_percent"
      expr: AVG(CAST(attainment_percent AS DOUBLE))
      comment: "Average quota attainment percentage. Core KPI for rep performance evaluation, compensation, and coaching prioritization."
    - name: "quota_record_count"
      expr: COUNT(1)
      comment: "Total number of quota records. Used to verify quota coverage completeness across reps and territories."
    - name: "reps_above_100pct_attainment"
      expr: COUNT(CASE WHEN attainment_percent >= 100 THEN 1 END)
      comment: "Count of quota records where attainment is at or above 100%. Measures the proportion of reps hitting target — a key sales health indicator."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign effectiveness and ROI metrics. Tracks spend efficiency, lead generation, and revenue attribution to optimize marketing investment allocation."
  source: "`vibe_manufacturing_v1`.`sales`.`campaign`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel of the campaign (e.g., Email, Digital, Event, Partner) for channel-mix ROI analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g., Planned, Active, Completed, Cancelled)."
    - name: "objective"
      expr: objective
      comment: "Business objective of the campaign (e.g., Brand Awareness, Lead Generation, Retention) for goal-based performance analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the campaign for regional marketing spend analysis."
    - name: "frequency"
      expr: frequency
      comment: "Campaign frequency or cadence (e.g., One-time, Weekly, Monthly) for reach and fatigue analysis."
    - name: "is_test_campaign"
      expr: is_test_campaign
      comment: "Flag indicating whether this is an A/B test campaign, enabling test vs. control performance comparison."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucket of campaign start date for monthly marketing spend and performance trending."
    - name: "language_code"
      expr: language_code
      comment: "Language of the campaign for localization effectiveness analysis."
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend across campaigns. Primary cost metric for marketing budget management."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted marketing spend. Used to track budget utilization and variance."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total revenue attributed to campaigns. Core marketing ROI numerator for investment justification."
    - name: "total_actual_leads"
      expr: SUM(CAST(actual_leads AS DOUBLE))
      comment: "Total leads generated by campaigns. Measures top-of-funnel marketing effectiveness."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered by campaigns. Measures reach and brand exposure."
    - name: "total_actual_clicks"
      expr: SUM(CAST(actual_clicks AS DOUBLE))
      comment: "Total clicks generated by campaigns. Measures audience engagement and content relevance."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average campaign budget. Used to benchmark campaign investment levels and identify outliers."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Tracks marketing activity volume and program breadth."
    - name: "budget_variance"
      expr: SUM(CAST(actual_spend AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total variance between actual spend and budgeted spend. Negative values indicate underspend; positive values indicate overspend. Critical for marketing budget governance."
    - name: "revenue_vs_expected_variance"
      expr: SUM(CAST(actual_revenue AS DOUBLE) - CAST(expected_revenue AS DOUBLE))
      comment: "Total variance between actual and expected campaign revenue. Measures forecast accuracy and campaign performance vs. plan."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote conversion, pricing, and discount metrics. Tracks quote-to-order conversion efficiency, discount discipline, and deal economics to optimize the sales quoting process."
  source: "`vibe_manufacturing_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g., Draft, Presented, Accepted, Rejected, Expired) for funnel stage analysis."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (e.g., Standard, Custom, Renewal) for quote-mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quote for governance and discount approval tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote for multi-currency deal analysis."
    - name: "non_standard_discount_flag"
      expr: non_standard_discount_flag
      comment: "Flag indicating whether a non-standard discount was applied, used to monitor pricing exception rates."
    - name: "quote_date_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month-level bucket of the quote date for monthly quoting activity and conversion trending."
    - name: "incoterm"
      expr: incoterm
      comment: "Delivery terms on the quote for logistics cost and risk allocation analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the quote for cash flow and DSO impact analysis."
  measures:
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes. Measures the gross quoting pipeline and pricing volume."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-discount subtotal across quotes. Used for net revenue analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars granted across quotes. Monitors pricing leakage and margin erosion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across quotes. Used for tax liability estimation and compliance reporting."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued. Measures quoting activity volume and sales team productivity."
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END)
      comment: "Count of accepted quotes. Numerator for quote-to-order conversion rate calculation."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across quotes. Key pricing discipline metric monitored by sales leadership and finance."
    - name: "avg_win_probability_percentage"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability assigned to quotes. Provides a weighted view of the quoted pipeline's likelihood to convert."
    - name: "avg_quote_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average quote value. Tracks deal size trends and informs pricing strategy and sales capacity planning."
    - name: "non_standard_discount_count"
      expr: COUNT(CASE WHEN non_standard_discount_flag = TRUE THEN 1 END)
      comment: "Count of quotes with non-standard discounts applied. Monitors pricing exception frequency for governance and margin protection."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote line-level margin, pricing, and product mix metrics. Enables granular analysis of deal economics, discount patterns, and product contribution to quoted revenue."
  source: "`vibe_manufacturing_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the quote line (e.g., Active, Cancelled, Substituted) for line-level funnel analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of quote line (e.g., Product, Service, Spare Part) for product-mix margin analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family of the quoted item for family-level margin and revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote line for multi-currency deal analysis."
    - name: "is_optional"
      expr: is_optional
      comment: "Flag indicating whether the line is optional, enabling analysis of optional vs. mandatory item conversion rates."
    - name: "is_bundle_parent"
      expr: is_bundle_parent
      comment: "Flag indicating whether the line is a bundle parent, enabling bundle vs. standalone pricing analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the quoted item for volume and pricing normalization."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for the quote line discount, used to monitor discount governance compliance."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quote lines. Measures gross quoted revenue at line level."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of goods for quoted lines. Used to calculate gross margin on the quoted portfolio."
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin dollars across quote lines. Primary profitability metric for deal review and pricing decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at line level. Monitors pricing leakage and discount concentration by product."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity quoted across all lines. Used for demand planning and capacity alignment."
    - name: "avg_margin_percent"
      expr: AVG(CAST(margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across quote lines. Core deal profitability KPI used in deal desk reviews."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at line level. Monitors pricing discipline and identifies high-discount product lines."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quote lines. Tracks pricing trends and identifies price erosion by product family."
    - name: "avg_commission_percent"
      expr: AVG(CAST(commission_percent AS DOUBLE))
      comment: "Average commission percentage on quote lines. Used for sales compensation cost modeling and deal profitability analysis."
    - name: "quote_line_count"
      expr: COUNT(1)
      comment: "Total number of quote lines. Measures quoting complexity and product breadth in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales contract value, compliance, and lifecycle metrics. Tracks contracted revenue, SLA commitments, and contract health to support revenue assurance and customer retention."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the sales contract (e.g., Draft, Active, Expired, Terminated) for contract lifecycle analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sales contract (e.g., Fixed Price, Time & Material, Framework) for contract-mix analysis."
    - name: "value_currency"
      expr: value_currency
      comment: "Currency of the contract value for multi-currency contracted revenue reporting."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract for legal risk and compliance analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms on the contract for logistics and risk allocation analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the contract for cash flow and DSO impact analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month-level bucket of the contract effective date for contracted revenue timing analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month-level bucket of the contract expiration date for renewal pipeline and churn risk analysis."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Dispute resolution mechanism on the contract for legal risk profiling."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total contracted revenue value. Primary metric for contracted backlog and revenue assurance reporting."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after adjustments. Used for accurate revenue recognition and backlog reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across contracts. Used for tax liability estimation and compliance reporting."
    - name: "total_liability_cap_amount"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total liability cap exposure across contracts. Measures aggregate legal and financial risk in the contract portfolio."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of sales contracts. Tracks contract portfolio size and sales activity."
    - name: "avg_contract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average contract value. Monitors deal size trends and informs pricing and sales strategy."
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime commitment across contracts. Monitors service obligation levels and operational risk exposure."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Count of currently active contracts. Measures the live contracted revenue base for retention and renewal planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation, qualification, and conversion metrics. Tracks top-of-funnel health, lead quality, and conversion rates to optimize demand generation investment."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (e.g., New, Working, Qualified, Converted, Disqualified) for funnel stage analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Channel or source that generated the lead (e.g., Web, Event, Partner, Referral) for source-mix ROI analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the lead for segment-level demand generation analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the lead for geographic demand analysis."
    - name: "rating"
      expr: rating
      comment: "Lead quality rating (e.g., Hot, Warm, Cold) for prioritization and conversion rate analysis."
    - name: "is_converted"
      expr: is_converted
      comment: "Flag indicating whether the lead was converted to an opportunity, enabling conversion rate analysis."
    - name: "product_interest_area"
      expr: product_interest_area
      comment: "Product area of interest expressed by the lead for product-level demand signal analysis."
    - name: "created_date_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month-level bucket of lead creation date for monthly lead volume trending."
    - name: "company_size"
      expr: company_size
      comment: "Size category of the lead's company for market segment and ICP (Ideal Customer Profile) analysis."
  measures:
    - name: "total_lead_count"
      expr: COUNT(1)
      comment: "Total number of leads generated. Primary top-of-funnel volume metric for demand generation performance."
    - name: "converted_lead_count"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN 1 END)
      comment: "Count of leads converted to opportunities. Numerator for lead conversion rate — a key marketing effectiveness KPI."
    - name: "total_estimated_project_value"
      expr: SUM(CAST(estimated_project_value AS DOUBLE))
      comment: "Total estimated project value across leads. Measures the gross revenue potential in the lead pipeline."
    - name: "avg_estimated_project_value"
      expr: AVG(CAST(estimated_project_value AS DOUBLE))
      comment: "Average estimated project value per lead. Used to assess lead quality and prioritize high-value prospects."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue of lead companies. Measures the aggregate market opportunity represented by the lead pool."
    - name: "do_not_contact_count"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN 1 END)
      comment: "Count of leads marked do-not-contact. Monitors compliance with contact preferences and data privacy obligations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory design and quota allocation metrics. Enables analysis of territory coverage, quota distribution, and geographic balance to optimize territory planning."
  source: "`vibe_manufacturing_v1`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., Active, Inactive, Under Review) for territory portfolio management."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g., Geographic, Named Account, Overlay) for territory design analysis."
    - name: "region_level"
      expr: region_level
      comment: "Hierarchical region level of the territory (e.g., Global, Regional, Local) for roll-up analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the territory for coverage model analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical focus of the territory for vertical-specific quota and coverage analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel associated with the territory (e.g., Direct, Partner, Inside Sales)."
    - name: "is_overlay_territory"
      expr: is_overlay_territory
      comment: "Flag indicating whether this is an overlay territory (e.g., specialist overlay) vs. primary territory."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the territory quota for annual territory planning analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the territory definition for governance tracking."
  measures:
    - name: "total_annual_revenue_quota"
      expr: SUM(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Total annual revenue quota across all territories. Measures aggregate sales target and quota distribution balance."
    - name: "avg_annual_revenue_quota"
      expr: AVG(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Average annual revenue quota per territory. Used to assess quota equity and identify over- or under-loaded territories."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of territories. Tracks territory portfolio size and coverage model breadth."
    - name: "active_territory_count"
      expr: COUNT(CASE WHEN territory_status = 'Active' THEN 1 END)
      comment: "Count of active territories. Measures the live coverage footprint for sales capacity planning."
    - name: "overlay_territory_count"
      expr: COUNT(CASE WHEN is_overlay_territory = TRUE THEN 1 END)
      comment: "Count of overlay territories. Monitors specialist overlay coverage and associated cost-to-sell implications."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_discount_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount policy and pricing governance metrics. Tracks discount levels, approval requirements, and schedule effectiveness to protect margin and enforce pricing discipline."
  source: "`vibe_manufacturing_v1`.`sales`.`discount_schedule`"
  dimensions:
    - name: "discount_schedule_status"
      expr: discount_schedule_status
      comment: "Current status of the discount schedule (e.g., Active, Expired, Pending Approval)."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of discount schedule (e.g., Volume, Promotional, Contractual) for discount-mix analysis."
    - name: "discount_method"
      expr: discount_method
      comment: "Method of discount application (e.g., Percentage, Fixed Amount) for pricing model analysis."
    - name: "applies_to_customer_segment"
      expr: applies_to_customer_segment
      comment: "Customer segment targeted by the discount schedule for segment-level pricing analysis."
    - name: "applies_to_product_category"
      expr: applies_to_product_category
      comment: "Product category targeted by the discount schedule for product-level pricing analysis."
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating whether approval is required to apply this discount schedule."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether this discount can be stacked with other discounts, affecting margin risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the discount schedule for multi-currency pricing analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the discount schedule for regional pricing governance."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the discount schedule became effective for pricing timeline analysis."
  measures:
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across all active schedules. Monitors the overall discount level in the pricing portfolio."
    - name: "avg_max_discount_amount"
      expr: AVG(CAST(max_discount_amount AS DOUBLE))
      comment: "Average maximum discount amount allowed per schedule. Used to assess the ceiling of pricing concessions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total fixed discount amount across all schedules. Measures the aggregate pricing concession exposure."
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value required to qualify for discounts. Monitors discount qualification thresholds."
    - name: "discount_schedule_count"
      expr: COUNT(1)
      comment: "Total number of discount schedules. Tracks pricing policy complexity and proliferation."
    - name: "approval_required_count"
      expr: COUNT(CASE WHEN approval_required = TRUE THEN 1 END)
      comment: "Count of discount schedules requiring approval. Measures the proportion of controlled vs. open discounting policies."
    - name: "stackable_schedule_count"
      expr: COUNT(CASE WHEN is_stackable = TRUE THEN 1 END)
      comment: "Count of stackable discount schedules. Monitors the risk of compounded discounting eroding margin."
$$;