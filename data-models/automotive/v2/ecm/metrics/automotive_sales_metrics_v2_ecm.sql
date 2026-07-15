-- Metric views for domain: sales | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_vehicle_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vehicle order KPIs tracking order volume, revenue, conversion, and fulfillment performance across sales channels, regions, and time periods."
  source: "`vibe_automotive_v1`.`sales`.`vehicle_order`"
  dimensions:
    - name: "order_fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the vehicle order for annual performance tracking"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for trend analysis"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter of order placement for quarterly business reviews"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (dealer, direct, fleet, online) for channel performance analysis"
    - name: "order_status"
      expr: order_status
      comment: "Current order status (confirmed, in production, delivered, cancelled) for pipeline tracking"
    - name: "order_type"
      expr: order_type
      comment: "Order type (retail, fleet, stock) for segmentation"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional performance comparison"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year for product mix analysis"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, HEV, PHEV, BEV) for electrification tracking"
    - name: "financing_type"
      expr: financing_type
      comment: "Financing method (cash, loan, lease) for F&I penetration analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency reporting"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle orders placed - primary volume KPI"
    - name: "total_order_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross merchandise value of all vehicle orders - primary revenue KPI"
    - name: "total_selling_price"
      expr: SUM(CAST(selling_price AS DOUBLE))
      comment: "Total selling price before taxes and fees"
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total manufacturer suggested retail price for pricing power analysis"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts given across all orders - margin impact KPI"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total manufacturer incentives applied - program effectiveness KPI"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected for compliance and revenue reconciliation"
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value accepted - used vehicle acquisition KPI"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value per transaction - pricing and mix indicator"
    - name: "avg_selling_price"
      expr: AVG(CAST(selling_price AS DOUBLE))
      comment: "Average selling price per vehicle - transaction price realization"
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per order - pricing discipline indicator"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(msrp AS DOUBLE)), 0), 2)
      comment: "Discount as percentage of MSRP - pricing power and margin pressure KPI"
    - name: "incentive_rate"
      expr: ROUND(100.0 * SUM(CAST(incentive_amount AS DOUBLE)) / NULLIF(SUM(CAST(selling_price AS DOUBLE)), 0), 2)
      comment: "Incentive as percentage of selling price - program cost efficiency"
    - name: "orders_with_trade_in"
      expr: COUNT(CASE WHEN trade_in_value > 0 THEN 1 END)
      comment: "Count of orders with trade-in - used vehicle sourcing volume"
    - name: "trade_in_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trade_in_value > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with trade-in - used vehicle acquisition effectiveness"
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled orders - order quality and customer commitment indicator"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders cancelled - sales process quality KPI"
    - name: "delivered_orders"
      expr: COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END)
      comment: "Count of orders successfully delivered - fulfillment volume KPI"
    - name: "delivery_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders delivered - order-to-delivery conversion KPI"
    - name: "unique_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Distinct customers placing orders - customer acquisition and retention indicator"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity conversion KPIs tracking deal progression, win rates, and sales effectiveness across territories and product lines."
  source: "`vibe_automotive_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "opportunity_fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual pipeline and conversion tracking"
    - name: "opportunity_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month opportunity was created for pipeline velocity analysis"
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current sales stage (lead, qualified, proposal, negotiation, closed) for funnel analysis"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Opportunity type (new, upsell, renewal) for deal classification"
    - name: "region"
      expr: region
      comment: "Geographic region for territory performance comparison"
    - name: "territory"
      expr: territory
      comment: "Sales territory for rep and team performance tracking"
    - name: "lead_source"
      expr: lead_source
      comment: "Lead source (web, referral, event, campaign) for marketing attribution"
    - name: "model_year"
      expr: model_year
      comment: "Target vehicle model year for product demand analysis"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Target powertrain type for electrification demand tracking"
    - name: "financing_type"
      expr: financing_type
      comment: "Preferred financing method for F&I planning"
    - name: "priority"
      expr: priority
      comment: "Opportunity priority (high, medium, low) for resource allocation"
    - name: "is_won"
      expr: is_won
      comment: "Whether opportunity was won for win/loss analysis"
    - name: "is_active"
      expr: is_active
      comment: "Whether opportunity is still active for pipeline health"
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of sales opportunities - pipeline volume KPI"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities - pipeline revenue potential"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per opportunity - deal size indicator"
    - name: "won_opportunities"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Count of won opportunities - sales effectiveness KPI"
    - name: "won_opportunity_value"
      expr: SUM(CASE WHEN is_won = TRUE THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of won opportunities - realized revenue from pipeline"
    - name: "win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = FALSE THEN 1 END), 0), 2)
      comment: "Percentage of closed opportunities that were won - sales effectiveness KPI"
    - name: "active_opportunities"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active opportunities - live pipeline volume"
    - name: "active_pipeline_value"
      expr: SUM(CASE WHEN is_active = TRUE THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of active opportunities - current pipeline potential"
    - name: "closed_opportunities"
      expr: COUNT(CASE WHEN is_active = FALSE THEN 1 END)
      comment: "Count of closed opportunities (won or lost) - pipeline throughput"
    - name: "opportunities_with_test_drive"
      expr: COUNT(CASE WHEN test_drive_completed = TRUE THEN 1 END)
      comment: "Count of opportunities with completed test drive - engagement indicator"
    - name: "test_drive_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_drive_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of opportunities with test drive - sales process adherence"
    - name: "opportunities_with_quote"
      expr: COUNT(CASE WHEN quote_generated = TRUE THEN 1 END)
      comment: "Count of opportunities with generated quote - proposal stage progression"
    - name: "quote_generation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quote_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of opportunities with quote - sales funnel conversion"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts offered across opportunities - pricing concession tracking"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentives applied to opportunities - program utilization"
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value across opportunities - used vehicle sourcing potential"
    - name: "avg_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across opportunities - pipeline quality indicator"
    - name: "unique_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Distinct customers with opportunities - prospect base size"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote generation and conversion KPIs tracking pricing effectiveness, quote-to-order conversion, and sales cycle efficiency."
  source: "`vibe_automotive_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month quote was generated for trend analysis"
    - name: "quote_quarter"
      expr: DATE_TRUNC('QUARTER', quote_date)
      comment: "Quarter quote was generated for quarterly performance tracking"
    - name: "quote_status"
      expr: quote_status
      comment: "Quote status (draft, sent, accepted, rejected, expired) for conversion funnel"
    - name: "quote_type"
      expr: quote_type
      comment: "Quote type (retail, fleet, lease) for segmentation"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for channel effectiveness comparison"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic region for regional pricing and conversion analysis"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year for product mix analysis"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type for electrification demand tracking"
    - name: "financing_offered"
      expr: financing_offered
      comment: "Whether financing was offered for F&I penetration analysis"
    - name: "lease_offered"
      expr: lease_offered
      comment: "Whether lease was offered for lease penetration tracking"
    - name: "converted_to_order"
      expr: converted_to_order
      comment: "Whether quote converted to order for conversion analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Quote currency for multi-currency reporting"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of quotes generated - sales activity volume KPI"
    - name: "total_quote_value"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total value of all quotes - potential revenue pipeline"
    - name: "avg_quote_value"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average quote value - deal size and pricing indicator"
    - name: "total_msrp_base"
      expr: SUM(CAST(msrp_base AS DOUBLE))
      comment: "Total base MSRP across quotes for pricing power analysis"
    - name: "total_options_value"
      expr: SUM(CAST(options_total AS DOUBLE))
      comment: "Total options and packages value - upsell effectiveness"
    - name: "total_accessories_value"
      expr: SUM(CAST(accessories_total AS DOUBLE))
      comment: "Total accessories value - aftermarket revenue potential"
    - name: "total_incentive_value"
      expr: SUM(CAST(incentive_total AS DOUBLE))
      comment: "Total incentives quoted - program utilization and cost"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on quotes for revenue reconciliation"
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance offered - used vehicle acquisition cost"
    - name: "converted_quotes"
      expr: COUNT(CASE WHEN converted_to_order = TRUE THEN 1 END)
      comment: "Count of quotes converted to orders - conversion effectiveness KPI"
    - name: "quote_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes converted to orders - critical sales effectiveness KPI"
    - name: "converted_quote_value"
      expr: SUM(CASE WHEN converted_to_order = TRUE THEN CAST(total_amount_due AS DOUBLE) ELSE 0 END)
      comment: "Total value of converted quotes - realized revenue from quoting activity"
    - name: "quotes_with_financing"
      expr: COUNT(CASE WHEN financing_offered = TRUE THEN 1 END)
      comment: "Count of quotes with financing offered - F&I engagement"
    - name: "financing_offer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financing_offered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes with financing offered - F&I penetration"
    - name: "quotes_with_lease"
      expr: COUNT(CASE WHEN lease_offered = TRUE THEN 1 END)
      comment: "Count of quotes with lease offered - lease program engagement"
    - name: "lease_offer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lease_offered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes with lease offered - lease penetration"
    - name: "quotes_with_trade_in"
      expr: COUNT(CASE WHEN trade_in_allowance > 0 THEN 1 END)
      comment: "Count of quotes with trade-in - used vehicle sourcing activity"
    - name: "avg_options_per_quote"
      expr: AVG(CAST(options_total AS DOUBLE))
      comment: "Average options value per quote - upsell effectiveness indicator"
    - name: "avg_accessories_per_quote"
      expr: AVG(CAST(accessories_total AS DOUBLE))
      comment: "Average accessories value per quote - aftermarket attachment rate"
    - name: "incentive_rate"
      expr: ROUND(100.0 * SUM(CAST(incentive_total AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Incentive as percentage of subtotal - program cost efficiency"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_fleet_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet sales contract KPIs tracking large-volume B2B sales, contract fulfillment, and fleet customer performance."
  source: "`vibe_automotive_v1`.`sales`.`fleet_contract`"
  dimensions:
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', contract_signed_date)
      comment: "Month contract was signed for trend analysis"
    - name: "contract_status"
      expr: contract_status
      comment: "Contract status (active, fulfilled, terminated) for pipeline health"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (national, regional, government) for segmentation"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic region for regional fleet performance"
    - name: "financing_type"
      expr: financing_type
      comment: "Financing method for fleet F&I analysis"
    - name: "government_contract_flag"
      expr: government_contract_flag
      comment: "Whether contract is government for public sector tracking"
    - name: "national_fleet_account_flag"
      expr: national_fleet_account_flag
      comment: "Whether account is national fleet for strategic account management"
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Whether maintenance is included for service revenue tracking"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract auto-renews for retention planning"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency reporting"
  measures:
    - name: "total_fleet_contracts"
      expr: COUNT(1)
      comment: "Total number of fleet contracts - B2B sales volume KPI"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total value of all fleet contracts - primary B2B revenue KPI"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value - deal size indicator for fleet sales"
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS BIGINT))
      comment: "Total vehicle units committed across contracts - volume pipeline"
    - name: "total_delivered_volume"
      expr: SUM(CAST(delivered_volume AS BIGINT))
      comment: "Total vehicle units delivered - fulfillment volume KPI"
    - name: "total_remaining_volume"
      expr: SUM(CAST(remaining_volume AS BIGINT))
      comment: "Total vehicle units remaining to deliver - backlog KPI"
    - name: "avg_committed_volume"
      expr: AVG(CAST(committed_volume AS BIGINT))
      comment: "Average committed volume per contract - fleet size indicator"
    - name: "contract_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_volume AS BIGINT)) / NULLIF(SUM(CAST(committed_volume AS BIGINT)), 0), 2)
      comment: "Percentage of committed volume delivered - fulfillment effectiveness KPI"
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Count of active contracts - live B2B pipeline"
    - name: "active_contract_value"
      expr: SUM(CASE WHEN contract_status = 'active' THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of active contracts - current B2B revenue potential"
    - name: "government_contracts"
      expr: COUNT(CASE WHEN government_contract_flag = TRUE THEN 1 END)
      comment: "Count of government contracts - public sector penetration"
    - name: "government_contract_value"
      expr: SUM(CASE WHEN government_contract_flag = TRUE THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of government contracts - public sector revenue"
    - name: "national_fleet_contracts"
      expr: COUNT(CASE WHEN national_fleet_account_flag = TRUE THEN 1 END)
      comment: "Count of national fleet contracts - strategic account volume"
    - name: "national_fleet_contract_value"
      expr: SUM(CASE WHEN national_fleet_account_flag = TRUE THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of national fleet contracts - strategic account revenue"
    - name: "contracts_with_maintenance"
      expr: COUNT(CASE WHEN maintenance_included_flag = TRUE THEN 1 END)
      comment: "Count of contracts with maintenance - service revenue opportunity"
    - name: "maintenance_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_included_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with maintenance - service attachment rate"
    - name: "avg_base_discount_percentage"
      expr: AVG(CAST(base_discount_percentage AS DOUBLE))
      comment: "Average base discount percentage - fleet pricing concession indicator"
    - name: "avg_volume_tier_discount"
      expr: AVG(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Average volume tier discount - volume incentive effectiveness"
    - name: "unique_fleet_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Distinct fleet customers - B2B customer base size"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance KPIs tracking campaign ROI, lead generation effectiveness, and marketing spend efficiency."
  source: "`vibe_automotive_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month campaign started for trend analysis"
    - name: "campaign_quarter"
      expr: DATE_TRUNC('QUARTER', start_date)
      comment: "Quarter campaign started for quarterly marketing review"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Campaign status (planned, active, completed, cancelled) for pipeline tracking"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Campaign type (launch, seasonal, clearance, conquest) for segmentation"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional marketing effectiveness"
    - name: "territory_code"
      expr: territory_code
      comment: "Sales territory for territory-level campaign performance"
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Target customer segment for audience effectiveness analysis"
    - name: "target_model_year"
      expr: target_model_year
      comment: "Target model year for product-specific campaign tracking"
    - name: "target_nameplate"
      expr: target_nameplate
      comment: "Target nameplate for nameplate-specific campaign performance"
    - name: "marketing_channels"
      expr: marketing_channels
      comment: "Marketing channels used (digital, TV, print, event) for channel mix analysis"
    - name: "dealer_participation_flag"
      expr: dealer_participation_flag
      comment: "Whether dealers participated for co-op marketing tracking"
    - name: "priority"
      expr: priority
      comment: "Campaign priority for resource allocation analysis"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns - marketing activity volume"
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total campaign budget allocated - marketing investment KPI"
    - name: "total_actual_spent"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total actual spend across campaigns - realized marketing cost"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign - campaign investment level"
    - name: "avg_actual_spent_per_campaign"
      expr: AVG(CAST(actual_spent_amount AS DOUBLE))
      comment: "Average actual spend per campaign - realized cost per campaign"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget spent - budget execution efficiency KPI"
    - name: "active_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'active' THEN 1 END)
      comment: "Count of currently active campaigns - live marketing activity"
    - name: "completed_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'completed' THEN 1 END)
      comment: "Count of completed campaigns - campaign throughput"
    - name: "campaigns_with_dealer_participation"
      expr: COUNT(CASE WHEN dealer_participation_flag = TRUE THEN 1 END)
      comment: "Count of campaigns with dealer participation - co-op marketing engagement"
    - name: "dealer_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dealer_participation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of campaigns with dealer participation - co-op effectiveness"
    - name: "total_target_market_share"
      expr: SUM(CAST(kpi_market_share_target AS DOUBLE))
      comment: "Total target market share across campaigns - strategic goal aggregation"
    - name: "total_actual_market_share"
      expr: SUM(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Total actual market share achieved - strategic performance"
    - name: "market_share_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(kpi_market_share_actual AS DOUBLE)) / NULLIF(SUM(CAST(kpi_market_share_target AS DOUBLE)), 0), 2)
      comment: "Percentage of market share target achieved - strategic effectiveness KPI"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and qualification KPIs tracking lead volume, quality, conversion, and source effectiveness for demand generation."
  source: "`vibe_automotive_v1`.`sales`.`sales_lead`"
  dimensions:
    - name: "lead_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month lead was created for trend analysis"
    - name: "lead_quarter"
      expr: DATE_TRUNC('QUARTER', created_timestamp)
      comment: "Quarter lead was created for quarterly demand generation review"
    - name: "lead_status"
      expr: lead_status
      comment: "Lead status (new, contacted, qualified, converted, lost) for funnel analysis"
    - name: "lead_type"
      expr: lead_type
      comment: "Lead type (inbound, outbound, referral) for source classification"
    - name: "lead_source"
      expr: lead_source
      comment: "Lead source (web, event, referral, campaign) for marketing attribution"
    - name: "region"
      expr: region
      comment: "Geographic region for regional demand generation performance"
    - name: "vehicle_interest_category"
      expr: vehicle_interest_category
      comment: "Vehicle category of interest for product demand analysis"
    - name: "vehicle_model_interest"
      expr: vehicle_model_interest
      comment: "Specific model of interest for model-level demand tracking"
    - name: "model_year_interest"
      expr: model_year_interest
      comment: "Model year of interest for product planning"
    - name: "purchase_timeframe"
      expr: purchase_timeframe
      comment: "Expected purchase timeframe for lead prioritization"
    - name: "rating"
      expr: rating
      comment: "Lead rating (hot, warm, cold) for quality segmentation"
    - name: "financing_interest"
      expr: financing_interest
      comment: "Whether lead expressed financing interest for F&I targeting"
    - name: "trade_in_interest"
      expr: trade_in_interest
      comment: "Whether lead has trade-in interest for used vehicle sourcing"
    - name: "test_drive_requested"
      expr: test_drive_requested
      comment: "Whether lead requested test drive for engagement indicator"
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads generated - primary demand generation KPI"
    - name: "converted_leads"
      expr: COUNT(CASE WHEN lead_status = 'converted' THEN 1 END)
      comment: "Count of leads converted to opportunities - conversion effectiveness"
    - name: "lead_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_status = 'converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads converted - critical demand generation effectiveness KPI"
    - name: "qualified_leads"
      expr: COUNT(CASE WHEN lead_status = 'qualified' THEN 1 END)
      comment: "Count of qualified leads - sales-ready pipeline volume"
    - name: "qualification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_status = 'qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads qualified - lead quality indicator"
    - name: "lost_leads"
      expr: COUNT(CASE WHEN lead_status = 'lost' THEN 1 END)
      comment: "Count of lost leads - lead attrition tracking"
    - name: "lead_loss_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_status = 'lost' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads lost - lead nurturing effectiveness"
    - name: "leads_with_financing_interest"
      expr: COUNT(CASE WHEN financing_interest = TRUE THEN 1 END)
      comment: "Count of leads interested in financing - F&I opportunity volume"
    - name: "financing_interest_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financing_interest = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads with financing interest - F&I penetration potential"
    - name: "leads_with_trade_in_interest"
      expr: COUNT(CASE WHEN trade_in_interest = TRUE THEN 1 END)
      comment: "Count of leads with trade-in interest - used vehicle sourcing opportunity"
    - name: "trade_in_interest_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trade_in_interest = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads with trade-in interest - used vehicle acquisition potential"
    - name: "leads_requesting_test_drive"
      expr: COUNT(CASE WHEN test_drive_requested = TRUE THEN 1 END)
      comment: "Count of leads requesting test drive - high-engagement leads"
    - name: "test_drive_request_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_drive_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads requesting test drive - engagement quality indicator"
    - name: "leads_with_email_opt_in"
      expr: COUNT(CASE WHEN opt_in_email = TRUE THEN 1 END)
      comment: "Count of leads with email opt-in - nurture-able audience size"
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_in_email = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads with email opt-in - marketing permission rate"
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across leads - revenue potential indicator"
    - name: "avg_estimated_budget"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per lead - deal size potential"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and target achievement KPIs tracking quota attainment, territory performance, and sales force effectiveness."
  source: "`vibe_automotive_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual quota tracking"
    - name: "quota_fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly quota performance"
    - name: "quota_fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly quota tracking"
    - name: "quota_status"
      expr: quota_status
      comment: "Quota status (active, achieved, missed, revised) for performance tracking"
    - name: "quota_type"
      expr: quota_type
      comment: "Quota type (revenue, units, margin) for KPI classification"
    - name: "assignee_type"
      expr: assignee_type
      comment: "Assignee type (rep, team, territory, dealer) for hierarchy analysis"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional quota performance"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for channel quota tracking"
    - name: "product_line"
      expr: product_line
      comment: "Product line for product-specific quota analysis"
    - name: "vehicle_segment"
      expr: vehicle_segment
      comment: "Vehicle segment for segment quota performance"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type for electrification quota tracking"
    - name: "model_year"
      expr: model_year
      comment: "Model year for product year quota analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for quota governance tracking"
    - name: "incentive_eligible"
      expr: incentive_eligible
      comment: "Whether quota is incentive-eligible for compensation planning"
  measures:
    - name: "total_quotas"
      expr: COUNT(1)
      comment: "Total number of quotas assigned - sales force coverage"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total quota target value - aggregate sales goal"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average quota target per assignment - typical quota level"
    - name: "total_threshold_minimum"
      expr: SUM(CAST(threshold_minimum AS DOUBLE))
      comment: "Total minimum threshold across quotas - baseline performance expectation"
    - name: "total_threshold_stretch"
      expr: SUM(CAST(threshold_stretch AS DOUBLE))
      comment: "Total stretch threshold across quotas - aspirational performance goal"
    - name: "avg_threshold_minimum"
      expr: AVG(CAST(threshold_minimum AS DOUBLE))
      comment: "Average minimum threshold - typical baseline expectation"
    - name: "avg_threshold_stretch"
      expr: AVG(CAST(threshold_stretch AS DOUBLE))
      comment: "Average stretch threshold - typical aspirational goal"
    - name: "approved_quotas"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved quotas - finalized quota assignments"
    - name: "quota_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotas approved - quota governance efficiency"
    - name: "incentive_eligible_quotas"
      expr: COUNT(CASE WHEN incentive_eligible = TRUE THEN 1 END)
      comment: "Count of incentive-eligible quotas - compensation-linked goals"
    - name: "incentive_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incentive_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotas with incentive eligibility - compensation coverage"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_delivery_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle delivery and customer handover KPIs tracking delivery efficiency, customer satisfaction, and pre-delivery inspection quality."
  source: "`vibe_automotive_v1`.`sales`.`delivery_appointment`"
  dimensions:
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month of scheduled delivery for trend analysis"
    - name: "delivery_quarter"
      expr: DATE_TRUNC('QUARTER', scheduled_delivery_date)
      comment: "Quarter of scheduled delivery for quarterly fulfillment tracking"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment status (scheduled, confirmed, completed, cancelled) for pipeline tracking"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Delivery type (dealer pickup, home delivery, remote) for service model analysis"
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Location type (dealership, customer home, other) for logistics analysis"
    - name: "pdi_status"
      expr: pdi_status
      comment: "Pre-delivery inspection status for quality gate tracking"
    - name: "customer_confirmation_status"
      expr: customer_confirmation_status
      comment: "Customer confirmation status for appointment reliability"
    - name: "financing_status"
      expr: financing_status
      comment: "Financing status at delivery for F&I completion tracking"
    - name: "trade_in_status"
      expr: trade_in_status
      comment: "Trade-in status at delivery for used vehicle acquisition tracking"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Documentation status for compliance and process quality"
    - name: "vehicle_preparation_status"
      expr: vehicle_preparation_status
      comment: "Vehicle preparation status for readiness tracking"
  measures:
    - name: "total_delivery_appointments"
      expr: COUNT(1)
      comment: "Total number of delivery appointments - delivery volume KPI"
    - name: "completed_deliveries"
      expr: COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END)
      comment: "Count of completed deliveries - successful handover volume"
    - name: "delivery_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in delivery - delivery effectiveness KPI"
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled appointments - delivery disruption tracking"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled - delivery reliability indicator"
    - name: "pdi_completed_count"
      expr: COUNT(CASE WHEN pdi_status = 'completed' THEN 1 END)
      comment: "Count of completed pre-delivery inspections - quality gate adherence"
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdi_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with completed PDI - quality process compliance"
    - name: "vehicle_orientation_completed_count"
      expr: COUNT(CASE WHEN vehicle_orientation_completed = TRUE THEN 1 END)
      comment: "Count of deliveries with vehicle orientation - customer education adherence"
    - name: "vehicle_orientation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vehicle_orientation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with orientation - customer experience quality"
    - name: "connected_services_activated_count"
      expr: COUNT(CASE WHEN connected_services_activated = TRUE THEN 1 END)
      comment: "Count of deliveries with connected services activated - digital service activation"
    - name: "connected_services_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN connected_services_activated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with connected services - digital engagement KPI"
    - name: "digital_owner_manual_sent_count"
      expr: COUNT(CASE WHEN digital_owner_manual_sent = TRUE THEN 1 END)
      comment: "Count of deliveries with digital manual sent - digital customer experience"
    - name: "avg_appointment_duration_minutes"
      expr: AVG(CAST(appointment_duration_minutes AS BIGINT))
      comment: "Average appointment duration - delivery efficiency indicator"
    - name: "avg_handover_duration_minutes"
      expr: AVG(CAST(handover_duration_minutes AS BIGINT))
      comment: "Average handover duration - customer experience time investment"
    - name: "avg_reminder_sent_count"
      expr: AVG(CAST(reminder_sent_count AS BIGINT))
      comment: "Average reminders sent per appointment - customer engagement effort"
    - name: "rescheduled_appointments"
      expr: COUNT(CASE WHEN rescheduled_from_appointment_id IS NOT NULL THEN 1 END)
      comment: "Count of rescheduled appointments - scheduling flexibility tracking"
    - name: "reschedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rescheduled_from_appointment_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments rescheduled - scheduling stability indicator"
$$;
