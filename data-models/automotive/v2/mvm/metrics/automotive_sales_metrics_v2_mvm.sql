-- Metric views for domain: sales | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_vehicle_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order metrics tracking revenue, order volume, pricing dynamics, and conversion performance across channels, regions, and order types"
  source: "`vibe_automotive_v1`.`sales`.`vehicle_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the vehicle order was placed"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the vehicle order"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (retail, fleet, etc.)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the order was placed"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the order"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the order"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type ordered (ICE, hybrid, electric)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle ordered"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing selected by customer"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level assigned to the order"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of vehicle orders"
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all vehicle orders including tax"
    - name: "total_selling_price"
      expr: SUM(CAST(selling_price AS DOUBLE))
      comment: "Total selling price before tax and fees"
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total manufacturer suggested retail price across all orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount applied to orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on orders"
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value credited across orders"
    - name: "avg_selling_price"
      expr: AVG(CAST(selling_price AS DOUBLE))
      comment: "Average selling price per vehicle order"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per order"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(msrp AS DOUBLE)), 0), 2)
      comment: "Percentage discount rate off MSRP"
    - name: "incentive_rate"
      expr: ROUND(100.0 * SUM(CAST(incentive_amount AS DOUBLE)) / NULLIF(SUM(CAST(msrp AS DOUBLE)), 0), 2)
      comment: "Percentage incentive rate relative to MSRP"
    - name: "price_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(selling_price AS DOUBLE)) / NULLIF(SUM(CAST(msrp AS DOUBLE)), 0), 2)
      comment: "Percentage of MSRP realized in selling price"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers placing orders"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships processing orders"
    - name: "orders_with_trade_in"
      expr: COUNT(DISTINCT CASE WHEN trade_in_value > 0 THEN vehicle_order_id END)
      comment: "Number of orders that included a trade-in"
    - name: "trade_in_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trade_in_value > 0 THEN vehicle_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that included a trade-in"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity conversion metrics tracking win rates, pipeline value, sales cycle efficiency, and competitive dynamics"
  source: "`vibe_automotive_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "created_date"
      expr: DATE(created_timestamp)
      comment: "Date the opportunity was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the opportunity was created"
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Expected close date for the opportunity"
    - name: "actual_close_date"
      expr: actual_close_date
      comment: "Actual close date when opportunity was won or lost"
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current stage in the sales pipeline"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of sales opportunity"
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel that generated the lead"
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity"
    - name: "is_won"
      expr: is_won
      comment: "Whether the opportunity was won"
    - name: "is_active"
      expr: is_active
      comment: "Whether the opportunity is currently active"
    - name: "priority"
      expr: priority
      comment: "Priority level of the opportunity"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing requested"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of interest"
    - name: "competitor_brand"
      expr: competitor_brand
      comment: "Competitor brand being considered"
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for losing the opportunity"
    - name: "win_reason"
      expr: win_reason
      comment: "Reason for winning the opportunity"
  measures:
    - name: "total_opportunity_count"
      expr: COUNT(1)
      comment: "Total number of sales opportunities"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities in pipeline"
    - name: "total_won_value"
      expr: SUM(CASE WHEN is_won = TRUE THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of won opportunities"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per opportunity"
    - name: "opportunities_won"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Number of opportunities won"
    - name: "opportunities_lost"
      expr: COUNT(CASE WHEN is_won = FALSE AND is_active = FALSE THEN 1 END)
      comment: "Number of opportunities lost"
    - name: "win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = FALSE THEN 1 END), 0), 2)
      comment: "Percentage of closed opportunities that were won"
    - name: "opportunities_with_test_drive"
      expr: COUNT(CASE WHEN test_drive_completed = TRUE THEN 1 END)
      comment: "Number of opportunities where test drive was completed"
    - name: "test_drive_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_drive_completed = TRUE AND is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN test_drive_completed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of test drives that converted to won opportunities"
    - name: "opportunities_with_quote"
      expr: COUNT(CASE WHEN quote_generated = TRUE THEN 1 END)
      comment: "Number of opportunities where a quote was generated"
    - name: "quote_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quote_generated = TRUE AND is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN quote_generated = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of quoted opportunities that were won"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers with opportunities"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships managing opportunities"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount offered per opportunity"
    - name: "avg_trade_in_value"
      expr: AVG(CAST(trade_in_value AS DOUBLE))
      comment: "Average trade-in value per opportunity"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_delivery_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle delivery execution metrics tracking on-time delivery, customer satisfaction, PDI completion, and delivery process efficiency"
  source: "`vibe_automotive_v1`.`sales`.`delivery_appointment`"
  dimensions:
    - name: "scheduled_delivery_date"
      expr: scheduled_delivery_date
      comment: "Scheduled date for vehicle delivery"
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month of scheduled delivery"
    - name: "actual_delivery_date"
      expr: DATE(actual_delivery_timestamp)
      comment: "Actual date vehicle was delivered"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the delivery appointment"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (dealership pickup, home delivery, etc.)"
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery location"
    - name: "pdi_status"
      expr: pdi_status
      comment: "Pre-delivery inspection status"
    - name: "vehicle_preparation_status"
      expr: vehicle_preparation_status
      comment: "Status of vehicle preparation for delivery"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of delivery documentation"
    - name: "financing_status"
      expr: financing_status
      comment: "Status of financing for the delivery"
    - name: "customer_confirmation_status"
      expr: customer_confirmation_status
      comment: "Customer confirmation status for appointment"
    - name: "delivery_satisfaction_score"
      expr: delivery_satisfaction_score
      comment: "Customer satisfaction score for delivery experience"
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country code for delivery location"
    - name: "delivery_state_province"
      expr: delivery_state_province
      comment: "State or province for delivery location"
  measures:
    - name: "total_delivery_appointments"
      expr: COUNT(1)
      comment: "Total number of delivery appointments scheduled"
    - name: "completed_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of deliveries actually completed"
    - name: "delivery_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled appointments that resulted in completed delivery"
    - name: "on_time_deliveries"
      expr: COUNT(CASE WHEN DATE(actual_delivery_timestamp) = scheduled_delivery_date THEN 1 END)
      comment: "Number of deliveries completed on the scheduled date"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN DATE(actual_delivery_timestamp) = scheduled_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed deliveries that were on time"
    - name: "rescheduled_appointments"
      expr: COUNT(CASE WHEN rescheduled_from_delivery_appointment_id IS NOT NULL THEN 1 END)
      comment: "Number of appointments that were rescheduled"
    - name: "reschedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rescheduled_from_delivery_appointment_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments that required rescheduling"
    - name: "pdi_completed_count"
      expr: COUNT(CASE WHEN pdi_completed_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of pre-delivery inspections completed"
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdi_completed_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with completed PDI"
    - name: "vehicle_orientation_completed_count"
      expr: COUNT(CASE WHEN vehicle_orientation_completed = TRUE THEN 1 END)
      comment: "Number of deliveries where vehicle orientation was completed"
    - name: "orientation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vehicle_orientation_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed deliveries that included vehicle orientation"
    - name: "connected_services_activated_count"
      expr: COUNT(CASE WHEN connected_services_activated = TRUE THEN 1 END)
      comment: "Number of deliveries where connected services were activated"
    - name: "connected_services_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN connected_services_activated = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed deliveries with connected services activated"
    - name: "digital_manual_sent_count"
      expr: COUNT(CASE WHEN digital_owner_manual_sent = TRUE THEN 1 END)
      comment: "Number of deliveries where digital owner manual was sent"
    - name: "deliveries_with_trade_in"
      expr: COUNT(CASE WHEN trade_in_id IS NOT NULL THEN 1 END)
      comment: "Number of deliveries that included a trade-in"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships performing deliveries"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers receiving deliveries"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_fleet_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet sales contract performance metrics tracking contract value, volume commitment fulfillment, discount effectiveness, and fleet customer retention"
  source: "`vibe_automotive_v1`.`sales`.`fleet_contract`"
  dimensions:
    - name: "contract_signed_date"
      expr: contract_signed_date
      comment: "Date the fleet contract was signed"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of contract effectiveness"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of contract effectiveness"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the fleet contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of fleet contract"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing for the fleet contract"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the fleet contract"
    - name: "national_fleet_account_flag"
      expr: national_fleet_account_flag
      comment: "Whether this is a national fleet account"
    - name: "government_contract_flag"
      expr: government_contract_flag
      comment: "Whether this is a government contract"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract has auto-renewal enabled"
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Whether maintenance is included in the contract"
    - name: "multi_location_delivery_flag"
      expr: multi_location_delivery_flag
      comment: "Whether contract allows multi-location delivery"
  measures:
    - name: "total_fleet_contracts"
      expr: COUNT(1)
      comment: "Total number of fleet contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total value of all fleet contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average value per fleet contract"
    - name: "total_base_discount"
      expr: SUM(CAST(base_discount_percentage AS DOUBLE))
      comment: "Sum of base discount percentages across contracts"
    - name: "avg_base_discount_percentage"
      expr: AVG(CAST(base_discount_percentage AS DOUBLE))
      comment: "Average base discount percentage offered"
    - name: "total_volume_tier_discount"
      expr: SUM(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Sum of volume tier discount percentages"
    - name: "avg_volume_tier_discount_percentage"
      expr: AVG(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Average volume tier discount percentage"
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active fleet contracts"
    - name: "national_account_contracts"
      expr: COUNT(CASE WHEN national_fleet_account_flag = TRUE THEN 1 END)
      comment: "Number of national fleet account contracts"
    - name: "government_contracts"
      expr: COUNT(CASE WHEN government_contract_flag = TRUE THEN 1 END)
      comment: "Number of government fleet contracts"
    - name: "contracts_with_auto_renewal"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts with auto-renewal enabled"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with auto-renewal enabled"
    - name: "contracts_with_maintenance"
      expr: COUNT(CASE WHEN maintenance_included_flag = TRUE THEN 1 END)
      comment: "Number of contracts that include maintenance"
    - name: "maintenance_attachment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_included_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that include maintenance"
    - name: "distinct_fleet_customers"
      expr: COUNT(DISTINCT organization_account_id)
      comment: "Number of unique fleet customer organizations"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships managing fleet contracts"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_trade_in`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade-in valuation and disposition metrics tracking appraisal accuracy, reconditioning efficiency, and trade-in profitability"
  source: "`vibe_automotive_v1`.`sales`.`trade_in`"
  dimensions:
    - name: "appraisal_date"
      expr: appraisal_date
      comment: "Date the trade-in was appraised"
    - name: "appraisal_month"
      expr: DATE_TRUNC('MONTH', appraisal_date)
      comment: "Month the trade-in was appraised"
    - name: "accepted_date"
      expr: accepted_date
      comment: "Date the trade-in offer was accepted"
    - name: "disposition_date"
      expr: disposition_date
      comment: "Date the trade-in was disposed of"
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition (retail, wholesale, auction, etc.)"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Overall condition grade of the trade-in vehicle"
    - name: "make"
      expr: make
      comment: "Make of the trade-in vehicle"
    - name: "model"
      expr: model
      comment: "Model of the trade-in vehicle"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the trade-in vehicle"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the trade-in vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the trade-in vehicle"
    - name: "title_status"
      expr: title_status
      comment: "Title status of the trade-in vehicle"
    - name: "exterior_condition"
      expr: exterior_condition
      comment: "Condition of the vehicle exterior"
    - name: "interior_condition"
      expr: interior_condition
      comment: "Condition of the vehicle interior"
    - name: "mechanical_condition"
      expr: mechanical_condition
      comment: "Mechanical condition of the vehicle"
    - name: "accident_history_flag"
      expr: accident_history_flag
      comment: "Whether the vehicle has accident history"
    - name: "inspection_completed"
      expr: inspection_completed
      comment: "Whether inspection was completed"
  measures:
    - name: "total_trade_ins"
      expr: COUNT(1)
      comment: "Total number of trade-in transactions"
    - name: "total_appraised_value"
      expr: SUM(CAST(appraised_value AS DOUBLE))
      comment: "Total appraised value of all trade-ins"
    - name: "total_allowance"
      expr: SUM(CAST(allowance AS DOUBLE))
      comment: "Total allowance given for trade-ins"
    - name: "total_disposition_amount"
      expr: SUM(CAST(disposition_amount AS DOUBLE))
      comment: "Total amount received from trade-in dispositions"
    - name: "total_reconditioning_cost"
      expr: SUM(CAST(reconditioning_cost AS DOUBLE))
      comment: "Total cost of reconditioning trade-in vehicles"
    - name: "total_outstanding_loan_balance"
      expr: SUM(CAST(outstanding_loan_balance AS DOUBLE))
      comment: "Total outstanding loan balance on trade-ins"
    - name: "avg_appraised_value"
      expr: AVG(CAST(appraised_value AS DOUBLE))
      comment: "Average appraised value per trade-in"
    - name: "avg_allowance"
      expr: AVG(CAST(allowance AS DOUBLE))
      comment: "Average allowance given per trade-in"
    - name: "avg_disposition_amount"
      expr: AVG(CAST(disposition_amount AS DOUBLE))
      comment: "Average disposition amount per trade-in"
    - name: "avg_reconditioning_cost"
      expr: AVG(CAST(reconditioning_cost AS DOUBLE))
      comment: "Average reconditioning cost per trade-in"
    - name: "allowance_premium_rate"
      expr: ROUND(100.0 * (SUM(CAST(allowance AS DOUBLE)) - SUM(CAST(appraised_value AS DOUBLE))) / NULLIF(SUM(CAST(appraised_value AS DOUBLE)), 0), 2)
      comment: "Percentage premium of allowance over appraised value"
    - name: "trade_ins_with_accident_history"
      expr: COUNT(CASE WHEN accident_history_flag = TRUE THEN 1 END)
      comment: "Number of trade-ins with accident history"
    - name: "trade_ins_with_inspection"
      expr: COUNT(CASE WHEN inspection_completed = TRUE THEN 1 END)
      comment: "Number of trade-ins with completed inspection"
    - name: "inspection_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trade-ins with completed inspection"
    - name: "trade_ins_with_service_records"
      expr: COUNT(CASE WHEN service_records_available = TRUE THEN 1 END)
      comment: "Number of trade-ins with available service records"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships processing trade-ins"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers trading in vehicles"
$$;


CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote generation and conversion metrics tracking quote-to-order conversion, pricing effectiveness, financing attachment, and quote velocity"
  source: "`vibe_automotive_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_date"
      expr: quote_date
      comment: "Date the quote was generated"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was generated"
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiration date of the quote"
    - name: "conversion_date"
      expr: conversion_date
      comment: "Date the quote was converted to an order"
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote"
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which quote was generated"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the quote"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the quoted vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the quoted vehicle"
    - name: "trim_level"
      expr: trim_level
      comment: "Trim level of the quoted vehicle"
    - name: "converted_to_order"
      expr: converted_to_order
      comment: "Whether the quote was converted to an order"
    - name: "financing_offered"
      expr: financing_offered
      comment: "Whether financing was offered in the quote"
    - name: "lease_offered"
      expr: lease_offered
      comment: "Whether lease was offered in the quote"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method specified in the quote"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of quotes generated"
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due across all quotes"
    - name: "total_net_selling_price"
      expr: SUM(CAST(net_selling_price AS DOUBLE))
      comment: "Total net selling price across all quotes"
    - name: "total_msrp_base"
      expr: SUM(CAST(msrp_base AS DOUBLE))
      comment: "Total base MSRP across all quotes"
    - name: "total_accessories"
      expr: SUM(CAST(accessories_total AS DOUBLE))
      comment: "Total accessories value across all quotes"
    - name: "total_options"
      expr: SUM(CAST(options_total AS DOUBLE))
      comment: "Total options value across all quotes"
    - name: "total_incentives"
      expr: SUM(CAST(incentive_total AS DOUBLE))
      comment: "Total incentives applied across all quotes"
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance across all quotes"
    - name: "avg_quote_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average total amount due per quote"
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price per quote"
    - name: "quotes_converted"
      expr: COUNT(CASE WHEN converted_to_order = TRUE THEN 1 END)
      comment: "Number of quotes converted to orders"
    - name: "quote_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes that converted to orders"
    - name: "quotes_with_financing"
      expr: COUNT(CASE WHEN financing_offered = TRUE THEN 1 END)
      comment: "Number of quotes that offered financing"
    - name: "financing_attachment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financing_offered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes that included financing offer"
    - name: "quotes_with_lease"
      expr: COUNT(CASE WHEN lease_offered = TRUE THEN 1 END)
      comment: "Number of quotes that offered lease"
    - name: "lease_attachment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lease_offered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes that included lease offer"
    - name: "quotes_with_trade_in"
      expr: COUNT(CASE WHEN trade_in_allowance > 0 THEN 1 END)
      comment: "Number of quotes that included trade-in"
    - name: "avg_apr_rate"
      expr: AVG(CAST(apr_rate AS DOUBLE))
      comment: "Average APR rate offered in quotes"
    - name: "avg_down_payment"
      expr: AVG(CAST(down_payment AS DOUBLE))
      comment: "Average down payment in quotes"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique customers receiving quotes"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT quote_dealership_id)
      comment: "Number of unique dealerships generating quotes"
$$;
