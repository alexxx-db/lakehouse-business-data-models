-- Metric views for domain: sales | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue and booking performance metrics tracking booked orders, revenue recognition, and backlog across products, customers, and territories"
  source: "`vibe_semiconductors_v1`.`sales`.`booking`"
  dimensions:
    - name: "booking_date"
      expr: booking_date
      comment: "Date when the booking was recorded"
    - name: "booking_year"
      expr: YEAR(booking_date)
      comment: "Fiscal year of booking"
    - name: "booking_quarter"
      expr: CONCAT('Q', QUARTER(booking_date), '-', YEAR(booking_date))
      comment: "Fiscal quarter of booking"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month of booking for trend analysis"
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, pending, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, prototype)"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional performance analysis"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for shipment"
    - name: "product_family"
      expr: product_family
      comment: "Product family for portfolio analysis"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied (e.g., volume-based, fixed)"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery mode (e.g., standard, expedited)"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates if booking is in backlog"
    - name: "forecast_flag"
      expr: forecast_flag
      comment: "Indicates if booking is forecasted vs actual"
    - name: "is_critical"
      expr: is_critical
      comment: "Flags critical priority bookings"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory tracking"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of bookings recorded"
    - name: "total_booked_revenue_gross"
      expr: SUM(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Total gross revenue booked before discounts and adjustments"
    - name: "total_booked_revenue_net"
      expr: SUM(CAST(booked_revenue_net AS DOUBLE))
      comment: "Total net revenue booked after discounts and adjustments"
    - name: "total_booking_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total booking amount in USD for standardized currency reporting"
    - name: "total_booked_quantity"
      expr: SUM(CAST(booked_quantity AS BIGINT))
      comment: "Total quantity of units booked"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across bookings"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on bookings"
    - name: "avg_booking_amount_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average booking amount in USD per booking"
    - name: "avg_discount_rate"
      expr: ROUND(100.0 * AVG(CAST(discount_amount AS DOUBLE) / NULLIF(CAST(amount AS DOUBLE), 0)), 2)
      comment: "Average discount rate as percentage of booking amount"
    - name: "backlog_bookings_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bookings currently in backlog"
    - name: "critical_bookings_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical priority bookings requiring expedited handling"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with bookings"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products booked"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance and ROI metrics tracking campaign spend, lead generation, conversion, and return on investment"
  source: "`vibe_semiconductors_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when campaign started"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g., planned, active, completed, cancelled)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., email, webinar, trade show, digital)"
    - name: "channel"
      expr: channel
      comment: "Marketing channel used for the campaign"
    - name: "region"
      expr: region
      comment: "Geographic region targeted by the campaign"
    - name: "target_segment"
      expr: target_segment
      comment: "Target customer segment for the campaign"
    - name: "target_market"
      expr: target_market
      comment: "Target market for the campaign"
    - name: "audience_segment"
      expr: audience_segment
      comment: "Audience segment targeted"
    - name: "priority"
      expr: priority
      comment: "Priority level of the campaign"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates if campaign has compliance requirements"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across campaigns"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across campaigns"
    - name: "total_budget_usd"
      expr: SUM(CAST(budget_usd AS DOUBLE))
      comment: "Total budget in USD for standardized currency reporting"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "avg_roi_estimate"
      expr: AVG(CAST(roi_estimate AS DOUBLE))
      comment: "Average estimated return on investment across campaigns"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories with campaigns"
    - name: "active_campaigns_count"
      expr: SUM(CASE WHEN campaign_status = 'active' OR campaign_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active campaigns"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contract value and compliance metrics for semiconductor long-term supply agreements. Tracks contract value, volume commitments, credit exposure, and renewal status to support revenue assurance and customer relationship management."
  source: "`vibe_semiconductors_v1`.`sales`.`customer_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the customer contract (e.g., active, expired, terminated) for contract portfolio health."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., LTA, spot, NRE) for contract mix and revenue assurance analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the contract for regional contract value analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family covered by the contract for product-line revenue assurance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency financial reporting."
    - name: "invoicing_frequency"
      expr: invoicing_frequency
      comment: "Invoicing frequency (monthly, quarterly, milestone) for cash flow planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for working capital and cash flow analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Flag indicating auto-renewal contracts for revenue continuity and churn risk analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the contract became effective for contract vintage and cohort analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node covered by the contract for node-level revenue assurance analysis."
  measures:
    - name: "total_contract_value_usd"
      expr: SUM(CAST(contract_value_usd AS DOUBLE))
      comment: "Total contract value in USD. Primary KPI for contracted revenue backlog and revenue assurance."
    - name: "total_annual_contract_value_usd"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annual contract value (ACV) in USD. Key metric for recurring revenue and ARR analysis."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across customer contracts. Monitors credit exposure and financial risk."
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total committed volume across contracts. Drives wafer start planning and capacity reservation."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of customer contracts. Baseline metric for contract portfolio size and coverage."
    - name: "auto_renew_contract_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Number of auto-renewing contracts. Indicates recurring revenue stability and churn risk."
    - name: "avg_annual_contract_value_usd"
      expr: AVG(CAST(annual_value AS DOUBLE))
      comment: "Average annual contract value. Indicates customer deal size and strategic account value."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across contracts. Monitors pricing discipline and margin erosion in long-term agreements."
    - name: "total_max_order_quantity"
      expr: SUM(CAST(max_order_quantity AS DOUBLE))
      comment: "Total maximum order quantity across contracts. Supports capacity planning and supply commitment analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion performance metrics tracking lead volume, quality scores, conversion rates, and pipeline contribution"
  source: "`vibe_semiconductors_v1`.`sales`.`lead`"
  dimensions:
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_timestamp)
      comment: "Month when lead was created for trend analysis"
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (e.g., new, qualified, converted, disqualified)"
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (e.g., inbound, outbound, referral)"
    - name: "source"
      expr: source
      comment: "Source of the lead (e.g., web, trade show, partner)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the lead"
    - name: "rating"
      expr: rating
      comment: "Lead rating (e.g., hot, warm, cold)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the lead"
    - name: "region"
      expr: region
      comment: "Geographic region of the lead"
    - name: "country"
      expr: country
      comment: "Country of the lead"
    - name: "is_nre"
      expr: is_nre
      comment: "Indicates if lead involves NRE opportunity"
    - name: "itar_required"
      expr: itar_required
      comment: "Indicates if lead requires ITAR compliance"
    - name: "conversion_outcome"
      expr: conversion_outcome
      comment: "Outcome of lead conversion (e.g., won, lost, in progress)"
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads generated"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue potential from leads"
    - name: "total_estimated_quantity"
      expr: SUM(CAST(estimated_quantity AS BIGINT))
      comment: "Total estimated unit quantity from leads"
    - name: "avg_estimated_revenue"
      expr: AVG(CAST(estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per lead"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns generating leads"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts associated with leads"
    - name: "converted_leads_count"
      expr: SUM(CASE WHEN conversion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of leads that have been converted to opportunities"
    - name: "nre_leads_count"
      expr: SUM(CASE WHEN is_nre = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads involving NRE opportunities"
    - name: "itar_leads_count"
      expr: SUM(CASE WHEN itar_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads requiring ITAR compliance"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity performance metrics tracking deal progression, win rates, and revenue potential across stages and territories"
  source: "`vibe_semiconductors_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: stage
      comment: "Current stage of the opportunity in the sales pipeline"
    - name: "expected_close_year"
      expr: YEAR(expected_close_date)
      comment: "Expected fiscal year of close"
    - name: "expected_close_quarter"
      expr: CONCAT('Q', QUARTER(expected_close_date), '-', YEAR(expected_close_date))
      comment: "Expected fiscal quarter of close"
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Expected month of close for pipeline forecasting"
    - name: "region"
      expr: region
      comment: "Geographic region for regional pipeline analysis"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (e.g., direct, partner, distributor)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the opportunity"
    - name: "target_application"
      expr: target_application
      comment: "Target application or use case for the product"
    - name: "end_market"
      expr: end_market
      comment: "End market segment (e.g., automotive, consumer, industrial)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., one-time, recurring)"
    - name: "win_loss_outcome"
      expr: CASE WHEN win_loss_date IS NOT NULL THEN CASE WHEN win_loss_reason LIKE '%won%' OR win_loss_reason LIKE '%Win%' THEN 'Won' ELSE 'Lost' END ELSE 'Open' END
      comment: "Outcome classification: Won, Lost, or Open"
    - name: "has_nre"
      expr: CASE WHEN nre_amount > 0 THEN TRUE ELSE FALSE END
      comment: "Indicates if opportunity includes NRE charges"
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline"
    - name: "total_expected_gross_amount"
      expr: SUM(CAST(expected_gross_amount AS DOUBLE))
      comment: "Total expected gross revenue across all opportunities"
    - name: "total_expected_net_amount"
      expr: SUM(CAST(expected_net_amount AS DOUBLE))
      comment: "Total expected net revenue after discounts"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering charges across opportunities"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(expected_net_amount AS DOUBLE))
      comment: "Average expected net revenue per opportunity"
    - name: "avg_discount_amount"
      expr: AVG(CAST(expected_discount_amount AS DOUBLE))
      comment: "Average discount amount per opportunity"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts in pipeline"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories with active opportunities"
    - name: "opportunities_with_nre"
      expr: SUM(CASE WHEN nre_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of opportunities that include NRE charges"
    - name: "won_opportunities"
      expr: SUM(CASE WHEN win_loss_date IS NOT NULL AND (win_loss_reason LIKE '%won%' OR win_loss_reason LIKE '%Win%') THEN 1 ELSE 0 END)
      comment: "Count of opportunities marked as won"
    - name: "lost_opportunities"
      expr: SUM(CASE WHEN win_loss_date IS NOT NULL AND win_loss_reason NOT LIKE '%won%' AND win_loss_reason NOT LIKE '%Win%' THEN 1 ELSE 0 END)
      comment: "Count of opportunities marked as lost"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_partner_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel partner inventory health metrics tracking stock levels, aging, sell-through rates, and inventory turns across partners and products"
  source: "`vibe_semiconductors_v1`.`sales`.`partner_inventory`"
  dimensions:
    - name: "inventory_date_month"
      expr: DATE_TRUNC('MONTH', inventory_date)
      comment: "Month of inventory snapshot for trend analysis"
    - name: "partner_inventory_status"
      expr: partner_inventory_status
      comment: "Status of partner inventory (e.g., active, excess, obsolete)"
    - name: "location"
      expr: location
      comment: "Partner warehouse or distribution location"
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Indicates if inventory is on consignment"
    - name: "excess_flag"
      expr: excess_flag
      comment: "Flags excess inventory requiring attention"
    - name: "obsolete_flag"
      expr: obsolete_flag
      comment: "Flags obsolete inventory"
    - name: "aging_bucket"
      expr: CASE WHEN aging_days < '30' THEN '0-30 days' WHEN aging_days < '60' THEN '31-60 days' WHEN aging_days < '90' THEN '61-90 days' ELSE '90+ days' END
      comment: "Inventory aging bucket for aging analysis"
  measures:
    - name: "total_inventory_records"
      expr: COUNT(1)
      comment: "Total number of partner inventory records"
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS BIGINT))
      comment: "Total quantity of inventory on hand at partners"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS BIGINT))
      comment: "Total quantity of inventory in transit to partners"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS BIGINT))
      comment: "Total quantity of inventory reserved for orders"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS BIGINT))
      comment: "Total quantity of inventory available for sale"
    - name: "total_inventory_value_usd"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total value of partner inventory in USD"
    - name: "total_sell_through_quantity"
      expr: SUM(CAST(sell_through_quantity AS BIGINT))
      comment: "Total quantity sold through by partners in period"
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across partners"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply on hand at partners"
    - name: "avg_inventory_turn_rate"
      expr: AVG(CAST(inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate across partners"
    - name: "excess_inventory_count"
      expr: SUM(CASE WHEN excess_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inventory records flagged as excess"
    - name: "obsolete_inventory_count"
      expr: SUM(CASE WHEN obsolete_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inventory records flagged as obsolete"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT channel_partner_id)
      comment: "Number of unique channel partners with inventory"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products in partner inventory"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote performance and conversion metrics tracking quote volume, value, conversion rates, and win/loss outcomes"
  source: "`vibe_semiconductors_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_date_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month when quote was issued for trend analysis"
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g., draft, issued, accepted, rejected)"
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Win/loss outcome of the quote"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional quote analysis"
    - name: "is_converted"
      expr: is_converted
      comment: "Indicates if quote was converted to an order"
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier for pricing (e.g., low, medium, high volume)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms offered in the quote"
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms (Incoterms) specified in quote"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of quotes issued"
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total quoted amount across all quotes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount offered in quotes"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on quotes"
    - name: "avg_quote_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average quote value per quote"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quotes"
    - name: "converted_quotes_count"
      expr: SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quotes successfully converted to orders"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving quotes"
    - name: "distinct_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Number of unique opportunities with quotes"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote line-level pricing and volume metrics for semiconductor products. Enables SKU-level analysis of quoted prices, discounts, quantities, and tax to support product pricing governance and margin management."
  source: "`vibe_semiconductors_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "quote_line_status"
      expr: quote_line_status
      comment: "Status of the quote line for pipeline and approval workflow analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the quote line for regional pricing analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (direct, distributor) for channel pricing and margin analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type of the quoted product for packaging mix and cost analysis."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier applied to the quote line for volume pricing effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote line for multi-currency pricing analysis."
    - name: "is_custom"
      expr: is_custom
      comment: "Flag indicating custom product configuration for custom vs. standard product mix analysis."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Flag indicating price-locked lines for pricing stability and contract compliance analysis."
    - name: "internal_approval_status"
      expr: internal_approval_status
      comment: "Internal approval status for pricing governance and deal desk workflow analysis."
  measures:
    - name: "total_extended_amount_usd"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount (unit price × quantity) across quote lines. Primary revenue potential KPI at line level."
    - name: "total_net_price_usd"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price after discounts across quote lines. Reflects actual revenue potential after pricing adjustments."
    - name: "total_quoted_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units quoted across all lines. Drives demand planning and capacity allocation decisions."
    - name: "total_tax_amount_usd"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on quote lines for tax liability and compliance reporting."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quote lines. Monitors ASP trends and pricing strategy effectiveness."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across quote lines. Key pricing governance metric for deal desk and finance."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied across quote lines for tax planning and compliance analysis."
    - name: "quote_line_count"
      expr: COUNT(1)
      comment: "Total number of quote lines. Baseline metric for quoting complexity and product mix breadth."
    - name: "custom_line_count"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Number of custom product quote lines. Tracks custom product demand and engineering resource requirements."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_rebate_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rebate program performance metrics tracking rebate accruals, payouts, thresholds, and program effectiveness across partners"
  source: "`vibe_semiconductors_v1`.`sales`.`rebate_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the rebate program (e.g., active, expired, suspended)"
    - name: "program_type"
      expr: program_type
      comment: "Type of rebate program (e.g., volume-based, growth-based)"
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g., percentage, fixed amount)"
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner eligible for the program"
    - name: "region"
      expr: region
      comment: "Geographic region for the rebate program"
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used for rebate accrual calculation"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of rebate payouts"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates if program is exclusive to certain partners"
    - name: "effective_period"
      expr: CONCAT(CAST(effective_start_date AS STRING), ' to ', CAST(effective_end_date AS STRING))
      comment: "Effective period of the rebate program"
  measures:
    - name: "total_rebate_programs"
      expr: COUNT(1)
      comment: "Total number of rebate programs"
    - name: "total_max_payout_amount"
      expr: SUM(CAST(max_payout_amount AS DOUBLE))
      comment: "Total maximum payout amount across all programs"
    - name: "total_threshold_amount"
      expr: SUM(CAST(threshold_amount AS DOUBLE))
      comment: "Total threshold amount required to qualify for rebates"
    - name: "avg_rebate_percent"
      expr: AVG(CAST(rebate_percent AS DOUBLE))
      comment: "Average rebate percentage across programs"
    - name: "avg_tier1_rate_percent"
      expr: AVG(CAST(tier1_rate_percent AS DOUBLE))
      comment: "Average tier 1 rebate rate percentage"
    - name: "avg_tier2_rate_percent"
      expr: AVG(CAST(tier2_rate_percent AS DOUBLE))
      comment: "Average tier 2 rebate rate percentage"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT channel_partner_id)
      comment: "Number of unique channel partners enrolled in rebate programs"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts in rebate programs"
    - name: "active_programs_count"
      expr: SUM(CASE WHEN program_status = 'active' OR program_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active rebate programs"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration metrics for semiconductor channel sales. Tracks registration volume, protected pricing, estimated volume, and approval status to support channel conflict management, price protection governance, and design win pipeline development."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_design_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the design registration (e.g., pending, approved, expired) for pipeline health monitoring."
    - name: "sales_design_registration_status"
      expr: sales_design_registration_status
      comment: "Sales-specific registration status for CRM and channel management alignment."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of design registration (e.g., new design, re-registration) for registration mix analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the registration for regional channel management analysis."
    - name: "device_family"
      expr: device_family
      comment: "Device family of the registered design for product-line registration coverage analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the registered design for node-level design activity tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the registration for multi-currency pricing analysis."
    - name: "is_price_protected"
      expr: is_price_protected
      comment: "Flag indicating price-protected registrations for price protection program management."
    - name: "is_channel_conflict"
      expr: is_channel_conflict
      comment: "Flag indicating channel conflict registrations for conflict resolution and channel governance."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration for design registration velocity and trend analysis."
  measures:
    - name: "total_estimated_volume"
      expr: SUM(CAST(estimated_volume AS DOUBLE))
      comment: "Total estimated annual volume from design registrations. Drives demand planning and capacity allocation."
    - name: "total_protected_price_value_usd"
      expr: SUM(CAST(protected_price_usd AS DOUBLE))
      comment: "Total protected price value across registrations. Measures price protection program financial exposure."
    - name: "registration_count"
      expr: COUNT(1)
      comment: "Total number of design registrations. Baseline metric for channel design activity and pipeline development."
    - name: "approved_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Approved' THEN 1 END)
      comment: "Number of approved design registrations. Measures active price protection and channel commitment."
    - name: "channel_conflict_count"
      expr: COUNT(CASE WHEN is_channel_conflict = TRUE THEN 1 END)
      comment: "Number of registrations with channel conflicts. Monitors channel governance and conflict resolution workload."
    - name: "price_protected_count"
      expr: COUNT(CASE WHEN is_price_protected = TRUE THEN 1 END)
      comment: "Number of price-protected registrations. Tracks price protection program scope and financial exposure."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage on design registrations. Monitors pricing discipline in channel programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win performance metrics tracking competitive wins, revenue potential, and market penetration across products and customers"
  source: "`vibe_semiconductors_v1`.`sales`.`sales_design_win`"
  dimensions:
    - name: "win_date_month"
      expr: DATE_TRUNC('MONTH', win_date)
      comment: "Month when design win was secured"
    - name: "win_year"
      expr: YEAR(win_date)
      comment: "Fiscal year of design win"
    - name: "design_win_status"
      expr: design_win_status
      comment: "Current status of the design win (e.g., active, ramping, production)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for the design win (e.g., automotive, IoT, mobile)"
    - name: "region"
      expr: region
      comment: "Geographic region of the design win"
    - name: "end_application"
      expr: end_application
      comment: "End application or use case for the design win"
    - name: "competitor_displaced"
      expr: competitor_displaced
      comment: "Competitor that was displaced by this design win"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the design win"
    - name: "export_controlled"
      expr: export_controlled
      comment: "Indicates if design win involves export-controlled products"
    - name: "production_ramp_status"
      expr: CASE WHEN production_start_date IS NULL THEN 'Not Started' WHEN production_start_date > CURRENT_DATE THEN 'Scheduled' ELSE 'In Production' END
      comment: "Production ramp status based on start date"
  measures:
    - name: "total_design_wins"
      expr: COUNT(1)
      comment: "Total number of design wins secured"
    - name: "total_estimated_annual_revenue_gross"
      expr: SUM(CAST(estimated_annual_revenue_gross AS DOUBLE))
      comment: "Total estimated annual gross revenue from design wins"
    - name: "total_estimated_annual_revenue_net"
      expr: SUM(CAST(estimated_annual_revenue_net AS DOUBLE))
      comment: "Total estimated annual net revenue from design wins"
    - name: "total_lifetime_revenue_usd"
      expr: SUM(CAST(lifetime_revenue_usd AS DOUBLE))
      comment: "Total lifetime revenue potential across all design wins"
    - name: "total_estimated_annual_volume"
      expr: SUM(CAST(estimated_annual_volume AS BIGINT))
      comment: "Total estimated annual unit volume from design wins"
    - name: "avg_annual_revenue_per_win"
      expr: AVG(CAST(estimated_annual_revenue_net AS DOUBLE))
      comment: "Average annual net revenue per design win"
    - name: "avg_lifetime_revenue_per_win"
      expr: AVG(CAST(lifetime_revenue_usd AS DOUBLE))
      comment: "Average lifetime revenue per design win"
    - name: "avg_competitor_displacement_score"
      expr: AVG(CAST(competitor_displacement_score AS DOUBLE))
      comment: "Average competitive displacement score across design wins"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT sales_account_id)
      comment: "Number of unique customers with design wins"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products with design wins"
    - name: "design_wins_in_production"
      expr: SUM(CASE WHEN production_start_date IS NOT NULL AND production_start_date <= CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of design wins that have reached production"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast accuracy and performance metrics tracking forecast vs actual variance, bias, and forecast quality across periods and products"
  source: "`vibe_semiconductors_v1`.`sales`.`sales_forecast`"
  dimensions:
    - name: "forecast_period"
      expr: forecast_period
      comment: "Forecast period (e.g., monthly, quarterly)"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., demand, revenue, capacity)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (e.g., committed, upside, pipeline)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., draft, submitted, approved)"
    - name: "end_market"
      expr: end_market
      comment: "End market segment for the forecast"
    - name: "geography"
      expr: geography
      comment: "Geographic region for the forecast"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the forecast (e.g., high, medium, low)"
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario name for scenario-based forecasting"
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates if forecast is locked for changes"
  measures:
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of forecast records"
    - name: "total_forecast_revenue_usd"
      expr: SUM(CAST(forecast_revenue_usd AS DOUBLE))
      comment: "Total forecasted revenue in USD"
    - name: "total_forecast_units"
      expr: SUM(CAST(forecast_units AS BIGINT))
      comment: "Total forecasted unit volume"
    - name: "avg_forecast_revenue"
      expr: AVG(CAST(forecast_revenue_usd AS DOUBLE))
      comment: "Average forecasted revenue per forecast record"
    - name: "avg_variance_to_actual"
      expr: AVG(CAST(variance_to_actual AS DOUBLE))
      comment: "Average variance between forecast and actual performance"
    - name: "avg_forecast_bias"
      expr: AVG(CAST(bias AS DOUBLE))
      comment: "Average forecast bias indicating systematic over/under forecasting"
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error for forecast accuracy"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique products forecasted"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers in forecast"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories forecasted"
    - name: "locked_forecasts_count"
      expr: SUM(CASE WHEN is_locked = TRUE THEN 1 ELSE 0 END)
      comment: "Count of forecasts that are locked for changes"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) agreement metrics for semiconductor design services. Tracks NRE contract value, milestone completion, revenue recognition, and forecasted vs. actual revenue to support R&D cost recovery and design win economics."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the NRE agreement (e.g., active, completed, terminated) for portfolio health monitoring."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement (e.g., tapeout, mask, design) for NRE revenue mix analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the NRE agreement for regional NRE revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE agreement for multi-currency financial reporting."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g., PDK, mask set, prototype) for NRE scope and resource planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the NRE agreement for governance and deal desk workflow analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the NRE agreement became effective for revenue recognition timing analysis."
    - name: "sales_nre_agreement_status"
      expr: sales_nre_agreement_status
      comment: "Sales-specific status of the NRE agreement for CRM pipeline alignment."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating exclusive NRE agreements for IP strategy and competitive positioning analysis."
  measures:
    - name: "total_nre_contract_value_usd"
      expr: SUM(CAST(nre_total_amount AS DOUBLE))
      comment: "Total NRE contract value in USD. Primary KPI for NRE revenue pipeline and R&D cost recovery tracking."
    - name: "total_actual_revenue_recognized_usd"
      expr: SUM(CAST(actual_revenue_recognized AS DOUBLE))
      comment: "Total NRE revenue actually recognized. Measures NRE revenue realization vs. contract value."
    - name: "total_forecasted_revenue_usd"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted NRE revenue. Used for financial planning and revenue recognition scheduling."
    - name: "total_milestone_amount_usd"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total milestone payment amounts across NRE agreements. Tracks milestone billing and cash flow."
    - name: "nre_agreement_count"
      expr: COUNT(1)
      comment: "Total number of NRE agreements. Baseline metric for NRE business volume and design services activity."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive NRE agreements. Tracks IP exclusivity commitments and competitive lock-in."
    - name: "avg_nre_contract_value_usd"
      expr: AVG(CAST(nre_total_amount AS DOUBLE))
      comment: "Average NRE contract value. Indicates deal size trends in design services business."
    - name: "total_total_nre_amount_usd"
      expr: SUM(CAST(total_nre_amount AS DOUBLE))
      comment: "Total NRE amount (alternate field) for cross-validation and reconciliation with finance NRE records."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory coverage and revenue target metrics for semiconductor sales management. Tracks territory revenue targets, coverage structure, and active territory count to support sales force deployment and quota management."
  source: "`vibe_semiconductors_v1`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., active, inactive) for sales coverage analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g., geographic, named account, overlay) for sales model analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the territory for regional sales coverage analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the territory hierarchy (e.g., global, regional, district) for organizational analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the territory for country-level sales coverage analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the territory assignment for annual quota and target analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating active territories for sales coverage completeness analysis."
    - name: "is_overlay"
      expr: is_overlay
      comment: "Flag indicating overlay territories (e.g., FAE, specialist) for sales model complexity analysis."
    - name: "channel_tier"
      expr: channel_tier
      comment: "Channel tier associated with the territory for channel coverage and partner alignment analysis."
  measures:
    - name: "total_revenue_target_usd"
      expr: SUM(CAST(revenue_target_amount AS DOUBLE))
      comment: "Total revenue target across territories. Primary quota management KPI for sales leadership."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of territories. Baseline metric for sales coverage breadth and organizational structure."
    - name: "active_territory_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active territories. Measures effective sales coverage and identifies coverage gaps."
    - name: "overlay_territory_count"
      expr: COUNT(CASE WHEN is_overlay = TRUE THEN 1 END)
      comment: "Number of overlay territories. Tracks specialist and FAE coverage investment."
    - name: "avg_revenue_target_usd"
      expr: AVG(CAST(revenue_target_amount AS DOUBLE))
      comment: "Average revenue target per territory. Benchmarks quota levels and identifies imbalanced territory assignments."
$$;
