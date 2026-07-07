-- Metric views for domain: sales | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking business metrics"
  source: "`vibe_semiconductors_v1`.`sales`.`booking`"
  dimensions:
    - name: "Backlog Flag"
      expr: backlog_flag
    - name: "Booking Date"
      expr: booking_date
    - name: "Booking Status"
      expr: booking_status
    - name: "Comments"
      expr: comments
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "External Order Ref"
      expr: external_order_ref
    - name: "Forecast Flag"
      expr: forecast_flag
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Number"
      expr: number
    - name: "Order Type"
      expr: order_type
    - name: "Pricing Model"
      expr: pricing_model
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking"
      expr: COUNT(DISTINCT booking_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Amount Usd"
      expr: SUM(amount_usd)
    - name: "Average Amount Usd"
      expr: AVG(amount_usd)
    - name: "Total Booked Quantity"
      expr: SUM(booked_quantity)
    - name: "Average Booked Quantity"
      expr: AVG(booked_quantity)
    - name: "Total Booked Revenue Gross"
      expr: SUM(booked_revenue_gross)
    - name: "Average Booked Revenue Gross"
      expr: AVG(booked_revenue_gross)
    - name: "Total Booked Revenue Net"
      expr: SUM(booked_revenue_net)
    - name: "Average Booked Revenue Net"
      expr: AVG(booked_revenue_net)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Contract business metrics"
  source: "`vibe_semiconductors_v1`.`sales`.`customer_contract`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Arbitration Clause"
      expr: arbitration_clause
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Confidentiality Clause"
      expr: confidentiality_clause
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Contract Status"
      expr: customer_contract_status
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Contract"
      expr: COUNT(DISTINCT customer_contract_id)
    - name: "Total Annual Value"
      expr: SUM(annual_value)
    - name: "Average Annual Value"
      expr: AVG(annual_value)
    - name: "Total Contract Value Total"
      expr: SUM(contract_value_total)
    - name: "Average Contract Value Total"
      expr: AVG(contract_value_total)
    - name: "Total Contract Value Usd"
      expr: SUM(contract_value_usd)
    - name: "Average Contract Value Usd"
      expr: AVG(contract_value_usd)
    - name: "Total Discount Rate"
      expr: SUM(discount_rate)
    - name: "Average Discount Rate"
      expr: AVG(discount_rate)
    - name: "Total Max Order Quantity"
      expr: SUM(max_order_quantity)
    - name: "Average Max Order Quantity"
      expr: AVG(max_order_quantity)
    - name: "Total Min Order Quantity"
      expr: SUM(min_order_quantity)
    - name: "Average Min Order Quantity"
      expr: AVG(min_order_quantity)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Volume Commitment"
      expr: SUM(volume_commitment)
    - name: "Average Volume Commitment"
      expr: AVG(volume_commitment)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast business metrics"
  source: "`vibe_semiconductors_v1`.`sales`.`forecast`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End"
      expr: effective_end
    - name: "Effective Start"
      expr: effective_start
    - name: "End Market"
      expr: end_market
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Forecast Number"
      expr: forecast_number
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Forecast Type"
      expr: forecast_type
    - name: "Geography"
      expr: geography
    - name: "Horizon Months"
      expr: horizon_months
    - name: "Is Locked"
      expr: is_locked
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Forecast"
      expr: COUNT(DISTINCT forecast_id)
    - name: "Total Bias"
      expr: SUM(bias)
    - name: "Average Bias"
      expr: AVG(bias)
    - name: "Total Mape"
      expr: SUM(mape)
    - name: "Average Mape"
      expr: AVG(mape)
    - name: "Total Revenue"
      expr: SUM(revenue)
    - name: "Average Revenue"
      expr: AVG(revenue)
    - name: "Total Revenue Usd"
      expr: SUM(revenue_usd)
    - name: "Average Revenue Usd"
      expr: AVG(revenue_usd)
    - name: "Total Units"
      expr: SUM(units)
    - name: "Average Units"
      expr: AVG(units)
    - name: "Total Variance To Actual"
      expr: SUM(variance_to_actual)
    - name: "Average Variance To Actual"
      expr: AVG(variance_to_actual)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price List business metrics"
  source: "`vibe_semiconductors_v1`.`sales`.`price_list`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective Until"
      expr: effective_until
    - name: "End Market"
      expr: end_market
    - name: "Is Default"
      expr: is_default
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price List"
      expr: COUNT(DISTINCT price_list_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote business metrics"
  source: "`vibe_semiconductors_v1`.`sales`.`quote`"
  dimensions:
    - name: "Conversion Date"
      expr: conversion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Incoterms"
      expr: incoterms
    - name: "Is Converted"
      expr: is_converted
    - name: "Issue Date"
      expr: issue_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Number"
      expr: number
    - name: "Product Code"
      expr: product_code
    - name: "Quote Date"
      expr: quote_date
    - name: "Quote Status"
      expr: quote_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote"
      expr: COUNT(DISTINCT quote_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote Line business metrics"
  source: "`vibe_semiconductors_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Requested Delivery Date"
      expr: customer_requested_delivery_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Internal Approval Status"
      expr: internal_approval_status
    - name: "Is Custom"
      expr: is_custom
    - name: "Is Price Locked"
      expr: is_price_locked
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lead Time Weeks"
      expr: lead_time_weeks
    - name: "Line Comment"
      expr: line_comment
    - name: "Line Number"
      expr: line_number
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Package Type"
      expr: package_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote Line"
      expr: COUNT(DISTINCT quote_line_id)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Extended Amount"
      expr: SUM(extended_amount)
    - name: "Average Extended Amount"
      expr: AVG(extended_amount)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total Price"
      expr: SUM(total_price)
    - name: "Average Total Price"
      expr: AVG(total_price)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;