-- Metric views for domain: sales | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core booking metrics tracking revenue, volume, and operational performance of semiconductor orders"
  source: "`vibe_semiconductors_v1`.`sales`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, pending, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, prototype)"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for the booking"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for shipment"
    - name: "product_family"
      expr: product_family
      comment: "Product family of the booked semiconductor"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of delivery (e.g., air, sea, ground)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the booking"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the booking"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the booking"
    - name: "booking_year"
      expr: YEAR(booking_timestamp)
      comment: "Year when the booking was created"
    - name: "booking_quarter"
      expr: CONCAT('Q', QUARTER(booking_timestamp), '-', YEAR(booking_timestamp))
      comment: "Quarter when the booking was created"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month when the booking was created"
    - name: "revenue_recognition_year"
      expr: YEAR(revenue_recognition_date)
      comment: "Year when revenue is recognized"
    - name: "revenue_recognition_quarter"
      expr: CONCAT('Q', QUARTER(revenue_recognition_date), '-', YEAR(revenue_recognition_date))
      comment: "Quarter when revenue is recognized"
    - name: "is_backlog"
      expr: backlog_flag
      comment: "Whether the booking is in backlog"
    - name: "is_forecast"
      expr: forecast_flag
      comment: "Whether the booking is forecasted"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the booking is marked as critical"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of bookings"
    - name: "total_booked_revenue_gross"
      expr: SUM(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Total gross revenue booked across all orders"
    - name: "total_booked_revenue_net"
      expr: SUM(CAST(booked_revenue_net AS DOUBLE))
      comment: "Total net revenue booked after discounts and adjustments"
    - name: "total_booked_quantity"
      expr: SUM(CAST(booked_quantity AS DOUBLE))
      comment: "Total quantity of units booked"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to bookings"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on bookings"
    - name: "avg_booked_revenue_gross"
      expr: AVG(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Average gross revenue per booking"
    - name: "avg_booked_revenue_net"
      expr: AVG(CAST(booked_revenue_net AS DOUBLE))
      comment: "Average net revenue per booking"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per booking"
    - name: "avg_booked_quantity"
      expr: AVG(CAST(booked_quantity AS DOUBLE))
      comment: "Average quantity per booking"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(booked_revenue_gross AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as discounts"
    - name: "revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(booked_revenue_net AS DOUBLE)) / NULLIF(SUM(CAST(booked_revenue_gross AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue realized as net revenue after discounts"
    - name: "tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(booked_revenue_net AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as percentage of net revenue"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with bookings"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique IC catalog products booked"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales opportunity pipeline metrics tracking deal value, conversion, and win/loss performance"
  source: "`vibe_semiconductors_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current stage of the opportunity in the sales pipeline"
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity"
    - name: "end_market"
      expr: end_market
      comment: "Target end market or industry vertical"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the opportunity is pursued"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model proposed for the opportunity"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract associated with the opportunity"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the contract negotiation"
    - name: "competitive_landscape"
      expr: competitive_landscape
      comment: "Competitive situation for this opportunity"
    - name: "target_application"
      expr: target_application
      comment: "Target application for the semiconductor product"
    - name: "win_loss_reason"
      expr: win_loss_reason
      comment: "Reason for winning or losing the opportunity"
    - name: "expected_close_year"
      expr: YEAR(expected_close_date)
      comment: "Year when the opportunity is expected to close"
    - name: "expected_close_quarter"
      expr: CONCAT('Q', QUARTER(expected_close_date), '-', YEAR(expected_close_date))
      comment: "Quarter when the opportunity is expected to close"
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month when the opportunity is expected to close"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the opportunity was created"
    - name: "created_quarter"
      expr: CONCAT('Q', QUARTER(created_timestamp), '-', YEAR(created_timestamp))
      comment: "Quarter when the opportunity was created"
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of sales opportunities"
    - name: "total_expected_gross_amount"
      expr: SUM(CAST(expected_gross_amount AS DOUBLE))
      comment: "Total expected gross revenue from all opportunities"
    - name: "total_expected_net_amount"
      expr: SUM(CAST(expected_net_amount AS DOUBLE))
      comment: "Total expected net revenue from all opportunities"
    - name: "total_expected_discount_amount"
      expr: SUM(CAST(expected_discount_amount AS DOUBLE))
      comment: "Total expected discount amount across opportunities"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering revenue expected"
    - name: "avg_expected_gross_amount"
      expr: AVG(CAST(expected_gross_amount AS DOUBLE))
      comment: "Average expected gross revenue per opportunity"
    - name: "avg_expected_net_amount"
      expr: AVG(CAST(expected_net_amount AS DOUBLE))
      comment: "Average expected net revenue per opportunity"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across opportunities"
    - name: "expected_discount_rate"
      expr: ROUND(100.0 * SUM(CAST(expected_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(expected_gross_amount AS DOUBLE)), 0), 2)
      comment: "Expected discount rate as percentage of gross amount"
    - name: "expected_revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(expected_net_amount AS DOUBLE)) / NULLIF(SUM(CAST(expected_gross_amount AS DOUBLE)), 0), 2)
      comment: "Expected net revenue as percentage of gross revenue"
    - name: "nre_mix"
      expr: ROUND(100.0 * SUM(CAST(nre_amount AS DOUBLE)) / NULLIF(SUM(CAST(expected_net_amount AS DOUBLE)), 0), 2)
      comment: "NRE revenue as percentage of total expected net revenue"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts in the pipeline"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique IC catalog products in opportunities"
    - name: "distinct_design_wins"
      expr: COUNT(DISTINCT design_win_id)
      comment: "Number of unique design wins associated with opportunities"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast metrics tracking projected revenue, quantity, and forecast accuracy"
  source: "`vibe_semiconductors_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., demand, supply, revenue)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the forecast"
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario name for the forecast (e.g., best case, worst case)"
    - name: "geography"
      expr: geography
      comment: "Geographic region for the forecast"
    - name: "end_market"
      expr: end_market
      comment: "Target end market for the forecast"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the forecast"
    - name: "horizon_months"
      expr: horizon_months
      comment: "Forecast horizon in months"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the forecast is locked for changes"
    - name: "effective_start_year"
      expr: YEAR(effective_start)
      comment: "Year when the forecast becomes effective"
    - name: "effective_start_quarter"
      expr: CONCAT('Q', QUARTER(effective_start), '-', YEAR(effective_start))
      comment: "Quarter when the forecast becomes effective"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start)
      comment: "Month when the forecast becomes effective"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when the forecast was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter when the forecast was submitted"
  measures:
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of forecast records"
    - name: "total_forecast_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total forecasted revenue across all records"
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total forecasted quantity across all records"
    - name: "avg_forecast_revenue"
      expr: AVG(CAST(revenue AS DOUBLE))
      comment: "Average forecasted revenue per record"
    - name: "avg_forecast_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average forecasted quantity per record"
    - name: "avg_bias"
      expr: AVG(CAST(bias AS DOUBLE))
      comment: "Average forecast bias (systematic over/under forecasting)"
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error of forecasts"
    - name: "total_variance_to_actual"
      expr: SUM(CAST(variance_to_actual AS DOUBLE))
      comment: "Total variance between forecast and actual results"
    - name: "avg_variance_to_actual"
      expr: AVG(CAST(variance_to_actual AS DOUBLE))
      comment: "Average variance between forecast and actual results"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts in forecasts"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique IC catalog products forecasted"
    - name: "distinct_design_wins"
      expr: COUNT(DISTINCT design_win_id)
      comment: "Number of unique design wins in forecasts"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contract metrics tracking contract value, terms, and performance"
  source: "`vibe_semiconductors_v1`.`sales`.`customer_contract`"
  dimensions:
    - name: "customer_contract_status"
      expr: customer_contract_status
      comment: "Current status of the customer contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., master agreement, spot purchase)"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the contract"
    - name: "product_family"
      expr: product_family
      comment: "Product family covered by the contract"
    - name: "pricing_terms"
      expr: pricing_terms
      comment: "Pricing terms of the contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the contract"
    - name: "invoicing_frequency"
      expr: invoicing_frequency
      comment: "Frequency of invoicing under the contract"
    - name: "renewal_option"
      expr: renewal_option
      comment: "Renewal option terms"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the contract auto-renews"
    - name: "has_arbitration_clause"
      expr: arbitration_clause
      comment: "Whether the contract includes an arbitration clause"
    - name: "has_confidentiality_clause"
      expr: confidentiality_clause
      comment: "Whether the contract includes a confidentiality clause"
    - name: "has_eol_clause"
      expr: eol_clause
      comment: "Whether the contract includes an end-of-life clause"
    - name: "has_ltb_provision"
      expr: ltb_provision
      comment: "Whether the contract includes a last-time-buy provision"
    - name: "has_pcn_obligation"
      expr: pcn_obligation
      comment: "Whether the contract includes a product change notification obligation"
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year when the contract becomes effective"
    - name: "effective_from_quarter"
      expr: CONCAT('Q', QUARTER(effective_from), '-', YEAR(effective_from))
      comment: "Quarter when the contract becomes effective"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of customer contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total value of all customer contracts"
    - name: "total_annual_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annual contract value across all contracts"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total volume commitment across all contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average total value per contract"
    - name: "avg_annual_value"
      expr: AVG(CAST(annual_value AS DOUBLE))
      comment: "Average annual value per contract"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across contracts"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across contracts"
    - name: "avg_volume_commitment"
      expr: AVG(CAST(volume_commitment AS DOUBLE))
      comment: "Average volume commitment per contract"
    - name: "avg_min_order_quantity"
      expr: AVG(CAST(min_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts"
    - name: "avg_max_order_quantity"
      expr: AVG(CAST(max_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity across contracts"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with contracts"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of unique IC catalog products under contract"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote metrics tracking quote value, conversion, and win/loss performance"
  source: "`vibe_semiconductors_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote"
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Win or loss status of the quote"
    - name: "reason_lost"
      expr: reason_lost
      comment: "Reason the quote was lost"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the quote"
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms specified in the quote"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms specified in the quote"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for the quote"
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier for pricing"
    - name: "is_converted"
      expr: is_converted
      comment: "Whether the quote was converted to a booking"
    - name: "quote_year"
      expr: YEAR(quote_date)
      comment: "Year when the quote was created"
    - name: "quote_quarter"
      expr: CONCAT('Q', QUARTER(quote_date), '-', YEAR(quote_date))
      comment: "Quarter when the quote was created"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month when the quote was created"
    - name: "conversion_year"
      expr: YEAR(conversion_date)
      comment: "Year when the quote was converted"
    - name: "conversion_quarter"
      expr: CONCAT('Q', QUARTER(conversion_date), '-', YEAR(conversion_date))
      comment: "Quarter when the quote was converted"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of quotes issued"
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of all quotes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across all quotes"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes"
    - name: "avg_quote_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total value per quote"
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per quote"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per quote"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quotes"
    - name: "quote_discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of total quote value"
    - name: "quote_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_converted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes converted to bookings"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts quoted"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-recurring engineering agreement metrics tracking NRE revenue, milestones, and project performance"
  source: "`vibe_semiconductors_v1`.`sales`.`nre_agreement`"
  dimensions:
    - name: "sales_nre_agreement_status"
      expr: sales_nre_agreement_status
      comment: "Current status of the NRE agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the NRE agreement"
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable under the NRE agreement"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the NRE agreement"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the NRE agreement"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the NRE agreement"
    - name: "ip_ownership_clause"
      expr: ip_ownership_clause
      comment: "Intellectual property ownership clause"
    - name: "has_change_order"
      expr: change_order_flag
      comment: "Whether the agreement has a change order"
    - name: "has_exclusivity"
      expr: exclusivity_flag
      comment: "Whether the agreement includes exclusivity"
    - name: "has_invoice_trigger"
      expr: invoice_trigger_flag
      comment: "Whether the agreement has invoice triggers"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year when the NRE agreement becomes effective"
    - name: "effective_start_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter when the NRE agreement becomes effective"
    - name: "milestone_planned_year"
      expr: YEAR(milestone_planned_date)
      comment: "Year when the milestone is planned"
    - name: "milestone_planned_quarter"
      expr: CONCAT('Q', QUARTER(milestone_planned_date), '-', YEAR(milestone_planned_date))
      comment: "Quarter when the milestone is planned"
  measures:
    - name: "total_nre_agreements"
      expr: COUNT(1)
      comment: "Total number of NRE agreements"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_total_amount AS DOUBLE))
      comment: "Total NRE revenue across all agreements"
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted NRE revenue"
    - name: "total_actual_revenue_recognized"
      expr: SUM(CAST(actual_revenue_recognized AS DOUBLE))
      comment: "Total actual NRE revenue recognized"
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total milestone payment amounts"
    - name: "avg_nre_amount"
      expr: AVG(CAST(nre_total_amount AS DOUBLE))
      comment: "Average NRE amount per agreement"
    - name: "avg_forecasted_revenue"
      expr: AVG(CAST(forecasted_revenue AS DOUBLE))
      comment: "Average forecasted revenue per NRE agreement"
    - name: "avg_actual_revenue_recognized"
      expr: AVG(CAST(actual_revenue_recognized AS DOUBLE))
      comment: "Average actual revenue recognized per NRE agreement"
    - name: "avg_milestone_amount"
      expr: AVG(CAST(milestone_amount AS DOUBLE))
      comment: "Average milestone payment amount"
    - name: "nre_revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue_recognized AS DOUBLE)) / NULLIF(SUM(CAST(forecasted_revenue AS DOUBLE)), 0), 2)
      comment: "Percentage of forecasted NRE revenue actually recognized"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with NRE agreements"
    - name: "distinct_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Number of unique opportunities with NRE agreements"
    - name: "distinct_design_wins"
      expr: COUNT(DISTINCT design_win_id)
      comment: "Number of unique design wins with NRE agreements"
$$;