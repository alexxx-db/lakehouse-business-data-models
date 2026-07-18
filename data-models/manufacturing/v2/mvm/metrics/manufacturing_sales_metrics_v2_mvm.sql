-- Metric views for domain: sales | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sales opportunity performance metrics tracking pipeline health, conversion rates, win rates, and revenue forecasting accuracy across stages, regions, and product lines."
  source: "`vibe_manufacturing_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: stage
      comment: "Current sales stage of the opportunity (e.g., Prospecting, Qualification, Proposal, Negotiation, Closed Won/Lost)"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type classification of the opportunity (e.g., New Business, Upsell, Renewal, Cross-sell)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Revenue forecast category (e.g., Pipeline, Best Case, Commit, Closed)"
    - name: "region"
      expr: region
      comment: "Geographic sales region for the opportunity"
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the opportunity"
    - name: "industry_segment"
      expr: industry_segment
      comment: "Target customer industry segment"
    - name: "lead_source"
      expr: lead_source
      comment: "Original source of the sales lead (e.g., Web, Referral, Trade Show, Partner)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for opportunity close date"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for opportunity close date"
    - name: "is_won"
      expr: is_won
      comment: "Boolean flag indicating whether the opportunity was won"
    - name: "is_closed"
      expr: is_closed
      comment: "Boolean flag indicating whether the opportunity is closed (won or lost)"
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for opportunity loss (null if won or still open)"
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month of expected close date for time-series analysis"
  measures:
    - name: "total_opportunity_count"
      expr: COUNT(1)
      comment: "Total number of sales opportunities in the pipeline"
    - name: "total_pipeline_value"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of all opportunities in the pipeline"
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue AS DOUBLE))
      comment: "Total probability-weighted expected revenue across all opportunities"
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Number of opportunities that were won"
    - name: "won_opportunity_value"
      expr: SUM(CASE WHEN is_won = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of won opportunities"
    - name: "closed_opportunity_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Number of opportunities that are closed (won or lost)"
    - name: "win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_closed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of closed opportunities that were won (key conversion metric)"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average dollar value per opportunity"
    - name: "avg_sales_cycle_days"
      expr: AVG(CAST(sales_cycle_days AS DOUBLE))
      comment: "Average number of days from opportunity creation to close"
    - name: "avg_win_probability"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability percentage across all opportunities"
    - name: "unique_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts with opportunities"
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order intake and booking metrics tracking revenue recognition, order velocity, credit approval efficiency, and handoff performance for manufacturing order management."
  source: "`vibe_manufacturing_v1`.`sales`.`order_intake`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., Standard, Custom, Service, Spare Parts)"
    - name: "product_line"
      expr: product_line
      comment: "Product line for the order"
    - name: "industry_segment"
      expr: industry_segment
      comment: "Customer industry segment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of order intake"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of order intake"
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of credit approval process (e.g., Approved, Pending, Rejected)"
    - name: "handoff_status"
      expr: handoff_status
      comment: "Status of handoff to operations/fulfillment"
    - name: "booking_recognized_flag"
      expr: booking_recognized_flag
      comment: "Boolean flag indicating whether booking has been recognized for revenue purposes"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order (e.g., Standard, Expedited, Rush)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated for the order"
    - name: "intake_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month of order intake for time-series analysis"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of orders received"
    - name: "total_order_value"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total dollar value of all orders in local currency"
    - name: "total_order_value_base"
      expr: SUM(CAST(order_value_base_currency AS DOUBLE))
      comment: "Total dollar value of all orders in base currency for consolidated reporting"
    - name: "recognized_booking_value"
      expr: SUM(CASE WHEN booking_recognized_flag = TRUE THEN CAST(order_value_base_currency AS DOUBLE) ELSE 0 END)
      comment: "Total value of orders where booking has been recognized for revenue"
    - name: "avg_order_value"
      expr: AVG(CAST(order_value AS DOUBLE))
      comment: "Average order value across all orders"
    - name: "booking_recognition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_recognized_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with recognized bookings (revenue recognition efficiency)"
    - name: "credit_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_check_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that passed credit approval (credit risk metric)"
    - name: "avg_credit_approval_days"
      expr: AVG(DATEDIFF(credit_approval_date, intake_date))
      comment: "Average number of days from order intake to credit approval"
    - name: "avg_handoff_days"
      expr: AVG(DATEDIFF(handoff_date, intake_date))
      comment: "Average number of days from order intake to operations handoff (order processing efficiency)"
    - name: "avg_delivery_lead_time_days"
      expr: AVG(DATEDIFF(committed_delivery_date, intake_date))
      comment: "Average committed delivery lead time in days from order intake"
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers placing orders"
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote performance metrics tracking quote-to-order conversion, pricing effectiveness, discount management, and sales cycle velocity for manufacturing sales."
  source: "`vibe_manufacturing_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g., Draft, Submitted, Accepted, Rejected, Expired)"
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (e.g., Standard, Custom, Renewal, Amendment)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for the quote (e.g., Approved, Pending, Rejected)"
    - name: "non_standard_discount_flag"
      expr: non_standard_discount_flag
      comment: "Boolean flag indicating whether non-standard discounts were applied"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for quote rejection (null if not rejected)"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month of quote creation for time-series analysis"
  measures:
    - name: "total_quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes generated"
    - name: "total_quote_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total dollar value of all quotes including tax and shipping"
    - name: "total_subtotal_value"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal value of all quotes before tax and shipping"
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END)
      comment: "Number of quotes that were accepted by customers"
    - name: "accepted_quote_value"
      expr: SUM(CASE WHEN quote_status = 'Accepted' THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of accepted quotes"
    - name: "rejected_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Rejected' THEN 1 END)
      comment: "Number of quotes that were rejected by customers"
    - name: "quote_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(CASE WHEN quote_status IN ('Accepted', 'Rejected', 'Expired') THEN 1 END), 0), 2)
      comment: "Percentage of finalized quotes that were accepted (key conversion metric)"
    - name: "avg_quote_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average dollar value per quote"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across all quotes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total dollar amount of discounts given across all quotes"
    - name: "non_standard_discount_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN non_standard_discount_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes requiring non-standard discount approval (pricing discipline metric)"
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability percentage across all quotes"
    - name: "avg_quote_to_acceptance_days"
      expr: AVG(DATEDIFF(accepted_date, quote_date))
      comment: "Average number of days from quote creation to customer acceptance"
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers receiving quotes"
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote line-level metrics tracking product mix, margin performance, pricing effectiveness, and configuration complexity for detailed sales analysis."
  source: "`vibe_manufacturing_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the quote line item (e.g., Active, Cancelled, Substituted)"
    - name: "line_type"
      expr: line_type
      comment: "Type of line item (e.g., Product, Service, Discount, Shipping)"
    - name: "product_family"
      expr: product_family
      comment: "Product family for the line item"
    - name: "is_bundle_parent"
      expr: is_bundle_parent
      comment: "Boolean flag indicating whether this line is a parent of a product bundle"
    - name: "is_optional"
      expr: is_optional
      comment: "Boolean flag indicating whether this line item is optional"
    - name: "approval_level"
      expr: approval_level
      comment: "Required approval level for this line item (e.g., Standard, Manager, Director)"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of quote line items"
    - name: "total_line_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total dollar value of all quote line items"
    - name: "total_subtotal_value"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal value before tax"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of goods for all quote line items"
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin dollars across all quote line items"
    - name: "avg_margin_percent"
      expr: AVG(CAST(margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across all quote line items"
    - name: "blended_margin_percent"
      expr: ROUND(100.0 * SUM(CAST(margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Blended gross margin percentage across all line items (key profitability metric)"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total dollar amount of discounts applied at line level"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied at line level"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all line items"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units quoted across all line items"
    - name: "avg_quantity_per_line"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per quote line item"
    - name: "avg_commission_percent"
      expr: AVG(CAST(commission_percent AS DOUBLE))
      comment: "Average commission percentage for sales reps across line items"
    - name: "unique_products"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of unique products quoted"
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance metrics tracking quota attainment, pipeline health, account coverage, and rep productivity for sales force management."
  source: "`vibe_manufacturing_v1`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Current employment status of the sales rep (e.g., Active, On Leave, Terminated)"
    - name: "sales_role"
      expr: sales_role
      comment: "Role of the sales representative (e.g., Account Executive, Inside Sales, Sales Engineer)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Primary sales channel for the rep (e.g., Direct, Partner, Online)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment focus for the rep (e.g., Enterprise, Mid-Market, SMB)"
    - name: "product_line_specialization"
      expr: product_line_specialization
      comment: "Product line specialization of the rep"
    - name: "sales_office_location"
      expr: sales_office_location
      comment: "Office location of the sales rep"
    - name: "is_key_account_manager"
      expr: is_key_account_manager
      comment: "Boolean flag indicating whether the rep manages key accounts"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Most recent performance rating for the rep"
    - name: "industry_vertical_focus"
      expr: industry_vertical_focus
      comment: "Industry vertical focus for the rep"
  measures:
    - name: "total_rep_count"
      expr: COUNT(1)
      comment: "Total number of sales representatives"
    - name: "active_rep_count"
      expr: COUNT(CASE WHEN rep_status = 'Active' THEN 1 END)
      comment: "Number of active sales representatives"
    - name: "total_annual_quota"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota amount across all sales reps"
    - name: "avg_annual_quota"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average annual quota per sales rep"
    - name: "total_book_of_business"
      expr: SUM(CAST(book_of_business_value AS DOUBLE))
      comment: "Total book of business value managed by all reps"
    - name: "avg_book_of_business"
      expr: AVG(CAST(book_of_business_value AS DOUBLE))
      comment: "Average book of business value per rep"
    - name: "avg_active_accounts"
      expr: AVG(CAST(active_account_count AS DOUBLE))
      comment: "Average number of active accounts per rep"
    - name: "avg_active_opportunities"
      expr: AVG(CAST(active_opportunity_count AS DOUBLE))
      comment: "Average number of active opportunities per rep"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of sales experience across all reps"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average tenure in days for all reps (current and former)"
    - name: "key_account_manager_count"
      expr: COUNT(CASE WHEN is_key_account_manager = TRUE THEN 1 END)
      comment: "Number of reps designated as key account managers"
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales contract performance metrics tracking contract value, SLA compliance, renewal rates, and contract lifecycle management for manufacturing sales agreements."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the sales contract (e.g., Draft, Active, Expired, Terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sales contract (e.g., Master Agreement, Purchase Order, Service Agreement)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms specified in the contract"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the contract (e.g., Wire Transfer, Credit Card, Letter of Credit)"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for the contract (e.g., FOB, CIF, DDP)"
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the contract expires"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of sales contracts"
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total dollar value of all sales contracts"
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after adjustments"
    - name: "active_contract_value"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN CAST(value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of active contracts (key revenue pipeline metric)"
    - name: "avg_contract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average dollar value per contract"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all contracts"
    - name: "avg_contract_duration_days"
      expr: AVG(DATEDIFF(expiration_date, effective_date))
      comment: "Average contract duration in days from effective to expiration date"
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage commitment across all contracts"
    - name: "avg_liability_cap"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap amount across contracts"
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with sales contracts"
$$;
