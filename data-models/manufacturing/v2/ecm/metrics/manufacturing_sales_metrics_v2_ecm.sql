-- Metric views for domain: sales | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline health, conversion, and revenue metrics derived from sales opportunities. Used by sales leadership to steer pipeline management, forecast accuracy, and win/loss analysis."
  source: "`vibe_manufacturing_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current opportunity stage (e.g. Prospecting, Qualification, Proposal, Closed Won) for funnel analysis."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (Commit, Best Case, Pipeline) used in revenue forecasting."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (New Business, Renewal, Upsell) for mix analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin of the opportunity (Inbound, Campaign, Partner, etc.) for marketing attribution."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the opportunity for segment-level pipeline analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity for regional performance tracking."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the opportunity for product mix analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity close date for annual planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the opportunity close date for quarterly business reviews."
    - name: "is_won"
      expr: is_won
      comment: "Flag indicating whether the opportunity was won, enabling win/loss segmentation."
    - name: "is_closed"
      expr: is_closed
      comment: "Flag indicating whether the opportunity is closed (won or lost)."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for losing the opportunity, used in competitive and process improvement analysis."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month of the expected close date for monthly pipeline trend analysis."
    - name: "close_date_quarter"
      expr: DATE_TRUNC('QUARTER', close_date)
      comment: "Quarter of the expected close date for quarterly pipeline reviews."
  measures:
    - name: "total_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total pipeline value across all open opportunities. Core metric for pipeline coverage and capacity planning."
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue AS DOUBLE))
      comment: "Sum of expected revenue across opportunities, reflecting probability-weighted pipeline value."
    - name: "avg_deal_size"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average opportunity value, used to track deal size trends and segment mix shifts."
    - name: "total_discount_percent_avg"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across opportunities, used to monitor pricing discipline and margin risk."
    - name: "total_probability_avg"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across open opportunities, indicating pipeline quality and confidence."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities, used as a baseline volume metric for pipeline density analysis."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Count of won opportunities, used to measure sales effectiveness and conversion volume."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_closed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of closed opportunities that were won. Key sales effectiveness KPI for QBRs and coaching."
    - name: "weighted_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE) * CAST(probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value, the primary input to revenue forecasting models."
    - name: "total_won_revenue"
      expr: SUM(CASE WHEN is_won = TRUE THEN amount ELSE 0 END)
      comment: "Total revenue from won opportunities in the period. Core revenue attainment metric."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order intake (bookings) metrics tracking the volume and value of orders received. Used by sales and operations leadership to monitor demand, backlog build, and booking trends."
  source: "`vibe_manufacturing_v1`.`sales`.`order_intake`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of order (Standard, Project, Service, etc.) for mix and margin analysis."
    - name: "intake_status"
      expr: intake_status
      comment: "Current status of the intake record (Pending, Confirmed, Cancelled) for pipeline health monitoring."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the order for vertical performance analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the order for product mix and revenue attribution."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the intake for annual bookings reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the intake for quarterly bookings reviews."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order for operational scheduling and fulfillment planning."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected for the order, used in logistics cost analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms (Incoterms) for the order, relevant for revenue recognition and risk transfer analysis."
    - name: "handoff_status"
      expr: handoff_status
      comment: "Status of the sales-to-operations handoff, used to track order readiness and transition efficiency."
    - name: "booking_recognized_flag"
      expr: booking_recognized_flag
      comment: "Whether the booking has been formally recognized, used for revenue recognition compliance."
    - name: "intake_date_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month of the intake date for monthly bookings trend analysis."
    - name: "intake_date_quarter"
      expr: DATE_TRUNC('QUARTER', intake_date)
      comment: "Quarter of the intake date for quarterly bookings reporting."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total value of orders received (bookings). Primary demand and revenue pipeline metric."
    - name: "total_intake_amount"
      expr: SUM(CAST(intake_amount AS DOUBLE))
      comment: "Total intake amount booked, used for bookings-to-revenue bridge analysis."
    - name: "total_order_value_base_currency"
      expr: SUM(CAST(order_value_base_currency AS DOUBLE))
      comment: "Total order value in base currency, enabling consistent cross-currency bookings reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(order_value AS DOUBLE))
      comment: "Average order value per intake record, used to track deal size trends and mix shifts."
    - name: "order_intake_count"
      expr: COUNT(1)
      comment: "Total number of order intake records, used as a volume baseline for bookings density analysis."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to orders, used to monitor FX exposure in the order book."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across orders, used to assess working capital and cash flow risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quota attainment and coverage metrics for sales reps and territories. Used by sales management to assess performance, identify underperformers, and calibrate future quota setting."
  source: "`vibe_manufacturing_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (Revenue, Units, Activity) for multi-dimensional performance analysis."
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota (Active, Draft, Approved) for governance and reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota for annual performance benchmarking."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota for quarterly attainment reviews."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the quota for monthly performance tracking."
    - name: "region"
      expr: region
      comment: "Geographic region of the quota for regional performance comparison."
    - name: "product_line"
      expr: product_line
      comment: "Product line scope of the quota for product-level attainment analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the quota for vertical performance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota for governance and audit tracking."
    - name: "is_team_quota"
      expr: is_team_quota
      comment: "Whether the quota is a team-level quota, used to distinguish individual vs. team performance."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the quota period start for time-series attainment trending."
  measures:
    - name: "total_quota_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total quota assigned across all reps/territories. Baseline for coverage and attainment analysis."
    - name: "total_attainment_amount"
      expr: SUM(CAST(attainment_amount AS DOUBLE))
      comment: "Total actual attainment against quota. Core sales performance metric."
    - name: "quota_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(attainment_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total quota achieved. Primary KPI for sales performance reviews and compensation."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining quota gap, used to assess how much more revenue is needed to hit targets."
    - name: "total_stretch_quota_amount"
      expr: SUM(CAST(stretch_quota_amount AS DOUBLE))
      comment: "Total stretch quota assigned, used to evaluate upside potential and incentive plan design."
    - name: "avg_attainment_percent"
      expr: AVG(CAST(attainment_percent AS DOUBLE))
      comment: "Average attainment percentage across quota records, used to identify distribution of performance."
    - name: "quota_record_count"
      expr: COUNT(1)
      comment: "Number of quota records, used as a baseline for quota coverage and headcount analysis."
    - name: "total_base_quota_amount"
      expr: SUM(CAST(base_quota_amount AS DOUBLE))
      comment: "Total base quota before adjustments, used to measure the impact of quota adjustments on targets."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total quota adjustments applied, used to track mid-period quota changes and their business rationale."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast accuracy and pipeline coverage metrics. Used by sales leadership and finance to align revenue expectations, assess forecast quality, and drive planning decisions."
  source: "`vibe_manufacturing_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (Draft, Submitted, Approved) for governance tracking."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (Commit, Best Case, Pipeline) for confidence-level segmentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast for annual planning alignment."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast for quarterly business reviews."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the forecast for monthly revenue planning."
    - name: "period_type"
      expr: period_type
      comment: "Type of forecast period (Monthly, Quarterly, Annual) for aggregation level analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the forecast for regional revenue planning."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the forecast for product mix revenue planning."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the forecast for vertical revenue planning."
    - name: "is_latest_version"
      expr: is_latest_version
      comment: "Flag indicating whether this is the latest forecast version, used to filter to current-state forecasts."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of forecast submission for tracking forecast cadence and timeliness."
  measures:
    - name: "total_forecast_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total forecasted revenue amount. Primary input to revenue planning and financial guidance."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed forecast amount, representing high-confidence revenue expectations."
    - name: "total_best_case_amount"
      expr: SUM(CAST(best_case_amount AS DOUBLE))
      comment: "Total best-case forecast amount, representing upside revenue potential."
    - name: "total_pipeline_amount"
      expr: SUM(CAST(pipeline_amount AS DOUBLE))
      comment: "Total pipeline amount in forecast, used to assess pipeline coverage relative to quota."
    - name: "total_weighted_pipeline_amount"
      expr: SUM(CAST(weighted_pipeline_amount AS DOUBLE))
      comment: "Total probability-weighted pipeline in forecast, the primary input to statistical revenue projections."
    - name: "total_submitted_amount"
      expr: SUM(CAST(submitted_amount AS DOUBLE))
      comment: "Total submitted forecast amount, used to track forecast submission completeness."
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota amount in forecast records, used for coverage ratio calculations."
    - name: "total_variance_to_quota"
      expr: SUM(CAST(variance_to_quota AS DOUBLE))
      comment: "Total variance between forecast and quota, used to identify gaps requiring management intervention."
    - name: "pipeline_coverage_ratio"
      expr: ROUND(SUM(CAST(pipeline_amount AS DOUBLE)) / NULLIF(SUM(CAST(quota_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of pipeline to quota, indicating whether sufficient pipeline exists to achieve targets. Target typically 3-4x."
    - name: "commit_coverage_ratio"
      expr: ROUND(SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(quota_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of committed forecast to quota, indicating high-confidence revenue coverage against targets."
    - name: "manager_adjustment_amount"
      expr: SUM(CAST(manager_adjusted_amount AS DOUBLE))
      comment: "Total manager-adjusted forecast amount, used to track management override patterns and forecast discipline."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records submitted, used to assess forecast participation and coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote conversion, value, and cycle-time metrics. Used by sales management to optimize quoting efficiency, pricing discipline, and win rates from quoted opportunities."
  source: "`vibe_manufacturing_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (Draft, Presented, Accepted, Rejected) for funnel analysis."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (Standard, Custom, Framework) for mix and complexity analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quote for governance and discount authorization tracking."
    - name: "non_standard_discount_flag"
      expr: non_standard_discount_flag
      comment: "Flag indicating non-standard discount was applied, used to monitor pricing exception rates."
    - name: "quote_date_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was created for monthly quoting activity trend analysis."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month the quote validity starts for pipeline timing analysis."
  measures:
    - name: "total_quote_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes issued. Measures the gross quoting activity and potential revenue pipeline."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-shipping subtotal across quotes, used for net revenue analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across quotes, used to monitor pricing leakage and margin risk."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across quotes, used for tax liability estimation and compliance reporting."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across quotes, used to track pricing discipline and discount trends."
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability across active quotes, used to assess pipeline quality and forecast confidence."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued, used as a volume baseline for quoting activity analysis."
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END)
      comment: "Number of accepted quotes, used to measure quoting effectiveness and conversion."
    - name: "quote_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes that were accepted. Key quoting effectiveness KPI for sales process optimization."
    - name: "non_standard_discount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN non_standard_discount_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes with non-standard discounts, used to monitor pricing exception frequency and approval burden."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote line-level revenue, margin, and discount metrics. Used by product management and sales operations to analyze product mix, pricing effectiveness, and margin by line item."
  source: "`vibe_manufacturing_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the quote line (Active, Cancelled, Substituted) for line-level pipeline analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of quote line (Product, Service, Spare Part) for revenue mix analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family of the quoted item for product mix and margin analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the quoted quantity, used in volume and pricing analysis."
    - name: "is_optional"
      expr: is_optional
      comment: "Whether the line is optional, used to distinguish core vs. optional revenue in quotes."
    - name: "is_bundle_parent"
      expr: is_bundle_parent
      comment: "Whether the line is a bundle parent, used to analyze bundling strategy and attach rates."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for the line, used to track discount authorization and governance."
    - name: "created_date_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month the quote line was created for monthly quoting volume trend analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total value of all quote lines. Measures gross quoted revenue at the line level."
    - name: "total_list_price_value"
      expr: SUM(CAST(list_price AS DOUBLE) * CAST(quantity AS DOUBLE))
      comment: "Total list price value (list price × quantity) across quote lines, used to measure discount impact vs. list."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at the line level, used to identify high-discount products and pricing leakage."
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin across quote lines. Core profitability metric for product and deal-level analysis."
    - name: "avg_margin_percent"
      expr: AVG(CAST(margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across quote lines, used to monitor pricing and cost discipline."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at the line level, used to identify discount concentration by product or rep."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units quoted across all lines, used for demand planning and capacity analysis."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of goods across quote lines, used for margin and profitability analysis."
    - name: "quote_line_count"
      expr: COUNT(1)
      comment: "Total number of quote lines, used as a baseline for quoting complexity and product mix analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation, qualification, and conversion metrics. Used by marketing and sales leadership to evaluate lead quality, source effectiveness, and pipeline contribution."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (New, Working, Qualified, Converted, Disqualified) for funnel analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the lead (Campaign, Web, Referral, Trade Show) for marketing attribution."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the lead for vertical pipeline contribution analysis."
    - name: "rating"
      expr: rating
      comment: "Lead quality rating (Hot, Warm, Cold) for prioritization and conversion analysis."
    - name: "is_converted"
      expr: is_converted
      comment: "Whether the lead was converted to an opportunity, used for conversion rate analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the lead for geographic pipeline contribution analysis."
    - name: "company_size"
      expr: company_size
      comment: "Size of the lead company for segment and deal size analysis."
    - name: "created_date_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month the lead was created for monthly lead generation trend analysis."
    - name: "conversion_date_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month the lead was converted for conversion timing analysis."
  measures:
    - name: "total_lead_count"
      expr: COUNT(1)
      comment: "Total number of leads generated. Baseline metric for top-of-funnel demand generation performance."
    - name: "converted_lead_count"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN 1 END)
      comment: "Number of leads converted to opportunities, used to measure lead quality and sales follow-up effectiveness."
    - name: "lead_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_converted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads converted to opportunities. Key marketing-to-sales handoff effectiveness KPI."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all leads, used to assess top-of-funnel revenue potential."
    - name: "total_estimated_project_value"
      expr: SUM(CAST(estimated_project_value AS DOUBLE))
      comment: "Total estimated project value across leads, used for project pipeline sizing and resource planning."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per lead, used to track lead quality trends and segment value differences."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue of lead companies, used to assess the quality and size of the lead pool."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract value, renewal, and compliance metrics. Used by sales and legal leadership to manage contract portfolio health, renewal risk, and revenue under contract."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (Active, Expired, Pending, Terminated) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (Framework, Project, Service, Supply) for mix and risk analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, used to assess renewal risk and revenue continuity."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms for the contract, relevant for revenue recognition and risk transfer analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the contract was approved for contract volume trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract expires for renewal pipeline and risk management."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all contracts in the portfolio. Primary metric for revenue under contract and backlog analysis."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after adjustments, used for accurate revenue recognition and backlog reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value, used to track deal size trends and segment mix shifts."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across contracts, used for tax liability estimation and compliance reporting."
    - name: "total_liability_cap_amount"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total liability cap across contracts, used by legal and risk management to assess maximum exposure."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts, used as a baseline for contract portfolio size and coverage analysis."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts with auto-renewal, used to assess revenue continuity and renewal risk exposure."
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with auto-renewal enabled. Used to assess recurring revenue stability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance and ROI metrics. Used by marketing and sales leadership to evaluate campaign effectiveness, channel efficiency, and pipeline contribution."
  source: "`vibe_manufacturing_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (Email, Event, Digital, Direct Mail) for channel mix analysis."
    - name: "channel"
      expr: channel
      comment: "Marketing channel of the campaign for channel-level ROI analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (Planned, Active, Completed, Cancelled) for portfolio management."
    - name: "objective"
      expr: objective
      comment: "Campaign objective (Lead Generation, Brand Awareness, Retention) for effectiveness analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the campaign for regional marketing investment analysis."
    - name: "is_test_campaign"
      expr: is_test_campaign
      comment: "Whether the campaign is a test, used to exclude test data from production reporting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started for monthly marketing activity trend analysis."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the campaign ended for campaign duration and timing analysis."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total revenue attributed to campaigns. Primary marketing ROI metric."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget allocated across campaigns, used for spend planning and variance analysis."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend across campaigns, used for budget utilization and ROI analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of campaigns, used for detailed cost accounting and efficiency analysis."
    - name: "total_actual_leads"
      expr: SUM(CAST(actual_leads AS DOUBLE))
      comment: "Total leads generated by campaigns, used to measure top-of-funnel contribution."
    - name: "total_actual_clicks"
      expr: SUM(CAST(actual_clicks AS DOUBLE))
      comment: "Total clicks generated by campaigns, used for digital engagement and conversion analysis."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered by campaigns, used for reach and brand awareness measurement."
    - name: "campaign_roi_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend AS DOUBLE)), 0), 2)
      comment: "Return on marketing investment (revenue / spend × 100). Primary campaign efficiency KPI for budget allocation decisions."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of campaign budget actually spent, used to assess marketing execution efficiency."
    - name: "cost_per_lead"
      expr: ROUND(SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_leads AS DOUBLE)), 0), 2)
      comment: "Average cost to generate one lead, used to compare channel efficiency and optimize marketing spend allocation."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns, used as a baseline for marketing activity volume analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales rep productivity and quota metrics. Used by sales management to assess rep performance, identify coaching needs, and optimize territory and headcount planning."
  source: "`vibe_manufacturing_v1`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Current status of the rep (Active, Inactive, On Leave) for headcount and coverage analysis."
    - name: "rep_type"
      expr: rep_type
      comment: "Type of rep (Field, Inside, Channel, Overlay) for productivity benchmarking by role."
    - name: "sales_role"
      expr: sales_role
      comment: "Sales role of the rep (Account Executive, SDR, SE) for role-based performance analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel the rep operates in (Direct, Partner, Online) for channel mix analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rep covers (Enterprise, Mid-Market, SMB) for segment performance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the rep is currently active, used to filter to active headcount for productivity analysis."
    - name: "is_key_account_manager"
      expr: is_key_account_manager
      comment: "Whether the rep is a key account manager, used to segment strategic account coverage."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the rep for talent management and coaching prioritization."
    - name: "hire_date_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year the rep was hired for tenure cohort analysis and ramp productivity benchmarking."
  measures:
    - name: "total_annual_quota"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota assigned across all reps, used for capacity planning and revenue target setting."
    - name: "total_book_of_business_value"
      expr: SUM(CAST(book_of_business_value AS DOUBLE))
      comment: "Total book of business value across reps, used to assess revenue at risk and account coverage."
    - name: "avg_annual_quota"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average annual quota per rep, used to benchmark quota levels and identify outliers."
    - name: "avg_travel_percentage"
      expr: AVG(CAST(travel_percentage AS DOUBLE))
      comment: "Average travel percentage across reps, used for cost management and rep workload analysis."
    - name: "active_rep_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active sales reps, used for headcount planning and productivity benchmarking."
    - name: "total_rep_count"
      expr: COUNT(1)
      comment: "Total number of rep records, used as a baseline for headcount and coverage analysis."
    - name: "key_account_manager_count"
      expr: COUNT(CASE WHEN is_key_account_manager = TRUE THEN 1 END)
      comment: "Number of key account managers, used to assess strategic account coverage and investment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Territory design, quota, and coverage metrics. Used by sales operations and leadership to optimize territory design, balance workloads, and ensure adequate market coverage."
  source: "`vibe_manufacturing_v1`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (Active, Inactive, Pending) for coverage management."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (Geographic, Named Account, Vertical, Overlay) for design analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the territory for regional coverage and quota analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment covered by the territory for segment coverage analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical focus of the territory for vertical coverage analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the territory is currently active, used to filter to live territories."
    - name: "is_overlay_territory"
      expr: is_overlay_territory
      comment: "Whether the territory is an overlay (specialist) territory, used to analyze overlay coverage model."
    - name: "coverage_model"
      expr: coverage_model
      comment: "Coverage model of the territory (Direct, Partner, Hybrid) for go-to-market analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the territory became effective for territory design change tracking."
  measures:
    - name: "total_annual_revenue_quota"
      expr: SUM(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Total annual revenue quota across all territories, used for capacity planning and market coverage assessment."
    - name: "avg_annual_revenue_quota"
      expr: AVG(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Average annual revenue quota per territory, used to assess quota balance and territory equity."
    - name: "active_territory_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active territories, used for coverage completeness and go-to-market design analysis."
    - name: "overlay_territory_count"
      expr: COUNT(CASE WHEN is_overlay_territory = TRUE THEN 1 END)
      comment: "Number of overlay territories, used to assess specialist coverage investment and cost."
    - name: "total_territory_count"
      expr: COUNT(1)
      comment: "Total number of territory records, used as a baseline for territory design and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_channel_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel partner performance, revenue, and certification metrics. Used by channel management to assess partner health, tier distribution, and indirect revenue contribution."
  source: "`vibe_manufacturing_v1`.`sales`.`channel_partner`"
  dimensions:
    - name: "partner_status"
      expr: partner_status
      comment: "Current status of the partner (Active, Inactive, Suspended) for portfolio health monitoring."
    - name: "partner_tier"
      expr: partner_tier
      comment: "Partner tier (Platinum, Gold, Silver, Bronze) for tier-based performance and investment analysis."
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner (Reseller, Distributor, VAR, SI) for channel mix analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the partner for compliance and capability analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the partner is currently active, used to filter to active channel coverage."
    - name: "mdf_eligible"
      expr: mdf_eligible
      comment: "Whether the partner is eligible for market development funds, used for MDF program management."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the partner for channel coverage gap analysis."
    - name: "industry_focus"
      expr: industry_focus
      comment: "Industry focus of the partner for vertical channel coverage analysis."
    - name: "onboarding_date_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month the partner was onboarded for partner recruitment trend analysis."
  measures:
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all channel partners, used for indirect channel revenue planning."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per partner, used to benchmark partner productivity and tier expectations."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to channel partners, used for financial risk and exposure management."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across partners, used to assess working capital and cash flow risk."
    - name: "active_partner_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active channel partners, used for channel coverage and capacity planning."
    - name: "mdf_eligible_partner_count"
      expr: COUNT(CASE WHEN mdf_eligible = TRUE THEN 1 END)
      comment: "Number of MDF-eligible partners, used for MDF budget planning and program investment decisions."
    - name: "total_partner_count"
      expr: COUNT(1)
      comment: "Total number of channel partner records, used as a baseline for channel ecosystem size analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_discount_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount schedule coverage and depth metrics. Used by pricing and sales operations to monitor discount policy compliance, approval rates, and pricing strategy effectiveness."
  source: "`vibe_manufacturing_v1`.`sales`.`discount_schedule`"
  dimensions:
    - name: "discount_schedule_status"
      expr: discount_schedule_status
      comment: "Current status of the discount schedule (Active, Expired, Draft) for policy governance."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (Volume, Promotional, Loyalty, Trade) for pricing strategy analysis."
    - name: "discount_method"
      expr: discount_method
      comment: "Method of discount application (Percentage, Fixed Amount) for pricing model analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (Tiered, Flat, Conditional) for pricing structure analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the discount schedule is currently active, used to filter to live pricing policies."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Whether the discount can be stacked with others, used to assess discount accumulation risk."
    - name: "approval_required"
      expr: approval_required
      comment: "Whether approval is required to apply the discount, used for governance and compliance analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the discount schedule for regional pricing analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the discount schedule became effective for pricing policy change tracking."
  measures:
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across active schedules, used to monitor overall pricing generosity and margin risk."
    - name: "avg_max_discount_amount"
      expr: AVG(CAST(max_discount_amount AS DOUBLE))
      comment: "Average maximum discount amount allowed, used to assess the ceiling of pricing concessions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across schedules, used to quantify the financial impact of discount policies."
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value required to qualify for discounts, used to assess discount threshold strategy."
    - name: "active_schedule_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active discount schedules, used to assess pricing policy complexity and governance burden."
    - name: "approval_required_schedule_count"
      expr: COUNT(CASE WHEN approval_required = TRUE THEN 1 END)
      comment: "Number of schedules requiring approval, used to assess governance overhead and approval bottlenecks."
    - name: "total_schedule_count"
      expr: COUNT(1)
      comment: "Total number of discount schedules, used as a baseline for pricing policy portfolio analysis."
$$;