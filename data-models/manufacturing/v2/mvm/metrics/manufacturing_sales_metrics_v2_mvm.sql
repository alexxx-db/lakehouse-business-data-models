-- Metric views for domain: sales | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:49:07

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "Close Date"
      expr: close_date
    - name: "Closed Date"
      expr: closed_date
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Country Code"
      expr: country_code
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Installation Status"
      expr: delivery_installation_status
    - name: "Description"
      expr: description
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Forecast Category"
      expr: forecast_category
    - name: "Has Open Activity"
      expr: has_open_activity
    - name: "Industry Segment"
      expr: industry_segment
    - name: "Is Closed"
      expr: is_closed
    - name: "Is Private"
      expr: is_private
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Opportunity"
      expr: COUNT(DISTINCT opportunity_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Expected Revenue"
      expr: SUM(expected_revenue)
    - name: "Average Expected Revenue"
      expr: AVG(expected_revenue)
    - name: "Total Probability Percent"
      expr: SUM(probability_percent)
    - name: "Average Probability Percent"
      expr: AVG(probability_percent)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Intake business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`order_intake`"
  dimensions:
    - name: "Booking Recognition Date"
      expr: booking_recognition_date
    - name: "Booking Recognized Flag"
      expr: booking_recognized_flag
    - name: "Committed Delivery Date"
      expr: committed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Approval Date"
      expr: credit_approval_date
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Po Date"
      expr: customer_po_date
    - name: "Customer Po Number"
      expr: customer_po_number
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Handoff Date"
      expr: handoff_date
    - name: "Handoff Status"
      expr: handoff_status
    - name: "Incoterms"
      expr: incoterms
    - name: "Industry Segment"
      expr: industry_segment
    - name: "Intake Date"
      expr: intake_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Intake"
      expr: COUNT(DISTINCT order_intake_id)
    - name: "Total Credit Check Status"
      expr: SUM(credit_check_status)
    - name: "Average Credit Check Status"
      expr: AVG(credit_check_status)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Intake Amount"
      expr: SUM(intake_amount)
    - name: "Average Intake Amount"
      expr: AVG(intake_amount)
    - name: "Total Order Value"
      expr: SUM(order_value)
    - name: "Average Order Value"
      expr: AVG(order_value)
    - name: "Total Order Value Base Currency"
      expr: SUM(order_value_base_currency)
    - name: "Average Order Value Base Currency"
      expr: AVG(order_value_base_currency)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Payment Terms Days"
      expr: SUM(payment_terms_days)
    - name: "Average Payment Terms Days"
      expr: AVG(payment_terms_days)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_price_book`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Book business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`price_book`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required"
      expr: approval_required
    - name: "Country Code"
      expr: country_code
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Discount Policy"
      expr: discount_policy
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Industry Segment"
      expr: industry_segment
    - name: "Is Active"
      expr: is_active
    - name: "Is Standard"
      expr: is_standard
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Notes"
      expr: notes
    - name: "Product Line"
      expr: product_line
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Book"
      expr: COUNT(DISTINCT price_book_id)
    - name: "Total Code"
      expr: SUM(code)
    - name: "Average Code"
      expr: AVG(code)
    - name: "Total Description"
      expr: SUM(description)
    - name: "Average Description"
      expr: AVG(description)
    - name: "Total Name"
      expr: SUM(name)
    - name: "Average Name"
      expr: AVG(name)
    - name: "Total Price Book Status"
      expr: SUM(price_book_status)
    - name: "Average Price Book Status"
      expr: AVG(price_book_status)
    - name: "Total Price Book Type"
      expr: SUM(price_book_type)
    - name: "Average Price Book Type"
      expr: AVG(price_book_type)
    - name: "Total Pricing Strategy"
      expr: SUM(pricing_strategy)
    - name: "Average Pricing Strategy"
      expr: AVG(pricing_strategy)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_price_book_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Book Entry business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`price_book_entry`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geography Code"
      expr: geography_code
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Market Segment"
      expr: market_segment
    - name: "Pricing Method"
      expr: pricing_method
    - name: "Product Family"
      expr: product_family
    - name: "Product Line"
      expr: product_line
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Book Entry"
      expr: COUNT(DISTINCT price_book_entry_id)
    - name: "Total Cost Price"
      expr: SUM(cost_price)
    - name: "Average Cost Price"
      expr: AVG(cost_price)
    - name: "Total Description"
      expr: SUM(description)
    - name: "Average Description"
      expr: AVG(description)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Maximum Discount Percent"
      expr: SUM(maximum_discount_percent)
    - name: "Average Maximum Discount Percent"
      expr: AVG(maximum_discount_percent)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Minimum Price"
      expr: SUM(minimum_price)
    - name: "Average Minimum Price"
      expr: AVG(minimum_price)
    - name: "Total Name"
      expr: SUM(name)
    - name: "Average Name"
      expr: AVG(name)
    - name: "Total Price Type"
      expr: SUM(price_type)
    - name: "Average Price Type"
      expr: AVG(price_type)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Use Standard Price"
      expr: SUM(use_standard_price)
    - name: "Average Use Standard Price"
      expr: AVG(use_standard_price)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`quote`"
  dimensions:
    - name: "Accepted Date"
      expr: accepted_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "Incoterm"
      expr: incoterm
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Name"
      expr: name
    - name: "Non Standard Discount Flag"
      expr: non_standard_discount_flag
    - name: "Notes"
      expr: notes
    - name: "Presented Date"
      expr: presented_date
    - name: "Quote Date"
      expr: quote_date
    - name: "Quote Number"
      expr: quote_number
    - name: "Quote Status"
      expr: quote_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote"
      expr: COUNT(DISTINCT quote_id)
    - name: "Total Configuration Summary"
      expr: SUM(configuration_summary)
    - name: "Average Configuration Summary"
      expr: AVG(configuration_summary)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Shipping Handling Amount"
      expr: SUM(shipping_handling_amount)
    - name: "Average Shipping Handling Amount"
      expr: AVG(shipping_handling_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
    - name: "Total Win Probability Percentage"
      expr: SUM(win_probability_percentage)
    - name: "Average Win Probability Percentage"
      expr: AVG(win_probability_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote Line business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "Approval Level"
      expr: approval_level
    - name: "Committed Delivery Date"
      expr: committed_delivery_date
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Bundle Parent"
      expr: is_bundle_parent
    - name: "Is Optional"
      expr: is_optional
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Line Type"
      expr: line_type
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
    - name: "Notes"
      expr: notes
    - name: "Product Family"
      expr: product_family
    - name: "Requested Delivery Date"
      expr: requested_delivery_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote Line"
      expr: COUNT(DISTINCT quote_line_id)
    - name: "Total Commission Percent"
      expr: SUM(commission_percent)
    - name: "Average Commission Percent"
      expr: AVG(commission_percent)
    - name: "Total Configuration Summary"
      expr: SUM(configuration_summary)
    - name: "Average Configuration Summary"
      expr: AVG(configuration_summary)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Line Amount"
      expr: SUM(line_amount)
    - name: "Average Line Amount"
      expr: AVG(line_amount)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Margin Amount"
      expr: SUM(margin_amount)
    - name: "Average Margin Amount"
      expr: AVG(margin_amount)
    - name: "Total Margin Percent"
      expr: SUM(margin_percent)
    - name: "Average Margin Percent"
      expr: AVG(margin_percent)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rep business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`rep`"
  dimensions:
    - name: "Active Account Count"
      expr: active_account_count
    - name: "Active Opportunity Count"
      expr: active_opportunity_count
    - name: "Certification List"
      expr: certification_list
    - name: "Code"
      expr: code
    - name: "Commission Plan Code"
      expr: commission_plan_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm User Code"
      expr: crm_user_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Email"
      expr: email
    - name: "Email Address"
      expr: email_address
    - name: "Full Name"
      expr: full_name
    - name: "Hire Date"
      expr: hire_date
    - name: "Industry Vertical Focus"
      expr: industry_vertical_focus
    - name: "Is Active"
      expr: is_active
    - name: "Is Key Account Manager"
      expr: is_key_account_manager
    - name: "Language Proficiency"
      expr: language_proficiency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rep"
      expr: COUNT(DISTINCT rep_id)
    - name: "Total Annual Quota Amount"
      expr: SUM(annual_quota_amount)
    - name: "Average Annual Quota Amount"
      expr: AVG(annual_quota_amount)
    - name: "Total Book Of Business Value"
      expr: SUM(book_of_business_value)
    - name: "Average Book Of Business Value"
      expr: AVG(book_of_business_value)
    - name: "Total Travel Percentage"
      expr: SUM(travel_percentage)
    - name: "Average Travel Percentage"
      expr: AVG(travel_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Contract business metrics"
  source: "`vibe_manufacturing_v1`.`sales`.`sales_contract`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Compliance Certifications Required"
      expr: compliance_certifications_required
    - name: "Confidentiality Clause"
      expr: confidentiality_clause
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Signatory Name"
      expr: customer_signatory_name
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Delivery Schedule"
      expr: delivery_schedule
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Document Url"
      expr: document_url
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Contract"
      expr: COUNT(DISTINCT sales_contract_id)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Net Contract Value"
      expr: SUM(net_contract_value)
    - name: "Average Net Contract Value"
      expr: AVG(net_contract_value)
    - name: "Total Payment Method"
      expr: SUM(payment_method)
    - name: "Average Payment Method"
      expr: AVG(payment_method)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
    - name: "Total Value Amount"
      expr: SUM(value_amount)
    - name: "Average Value Amount"
      expr: AVG(value_amount)
    - name: "Total Value Currency"
      expr: SUM(value_currency)
    - name: "Average Value Currency"
      expr: AVG(value_currency)
$$;