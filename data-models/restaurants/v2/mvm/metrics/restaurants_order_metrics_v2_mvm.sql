-- Metric views for domain: order | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 20:01:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_catering_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering Order business metrics"
  source: "`vibe_restaurants_v1`.`order`.`catering_order`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled At"
      expr: cancelled_at
    - name: "Catering Order Number"
      expr: catering_order_number
    - name: "Confirmed At"
      expr: confirmed_at
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Currency Code"
      expr: currency_code
    - name: "Dietary Accommodations"
      expr: dietary_accommodations
    - name: "Event Date"
      expr: event_date
    - name: "Event Start Time"
      expr: event_start_time
    - name: "Fulfilled At"
      expr: fulfilled_at
    - name: "Fulfillment Mode"
      expr: fulfillment_mode
    - name: "Headcount"
      expr: headcount
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Order Status"
      expr: order_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catering Order"
      expr: COUNT(DISTINCT catering_order_id)
    - name: "Total Balance Due"
      expr: SUM(balance_due)
    - name: "Average Balance Due"
      expr: AVG(balance_due)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
    - name: "Total Gratuity Amount"
      expr: SUM(gratuity_amount)
    - name: "Average Gratuity Amount"
      expr: AVG(gratuity_amount)
    - name: "Total Quoted Price"
      expr: SUM(quoted_price)
    - name: "Average Quoted Price"
      expr: AVG(quoted_price)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`vibe_restaurants_v1`.`order`.`channel`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Average Ticket Time Seconds"
      expr: average_ticket_time_seconds
    - name: "Category"
      expr: channel_category
    - name: "Channel Type"
      expr: channel_type
    - name: "Code"
      expr: code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Default Daypart"
      expr: default_daypart
    - name: "Description"
      expr: description
    - name: "Display Order"
      expr: display_order
    - name: "Fulfillment Mode"
      expr: fulfillment_mode
    - name: "Integration Platform"
      expr: integration_platform
    - name: "Is Active"
      expr: is_active
    - name: "Is Digital"
      expr: is_digital
    - name: "Kds Routing Enabled"
      expr: kds_routing_enabled
    - name: "Name"
      expr: name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery Order business metrics"
  source: "`vibe_restaurants_v1`.`order`.`delivery_order`"
  dimensions:
    - name: "Actual Delivery Time Minutes"
      expr: actual_delivery_time_minutes
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Actual Prep Time Minutes"
      expr: actual_prep_time_minutes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Feedback"
      expr: customer_feedback
    - name: "Customer Rating"
      expr: customer_rating
    - name: "Delivery Exception Type"
      expr: delivery_exception_type
    - name: "Delivery Instructions"
      expr: delivery_instructions
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Estimated Delivery Time Minutes"
      expr: estimated_delivery_time_minutes
    - name: "Estimated Delivery Timestamp"
      expr: estimated_delivery_timestamp
    - name: "Estimated Prep Time Minutes"
      expr: estimated_prep_time_minutes
    - name: "Exception Notes"
      expr: exception_notes
    - name: "Is Contactless Delivery"
      expr: is_contactless_delivery
    - name: "Order Confirmed Timestamp"
      expr: order_confirmed_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Order"
      expr: COUNT(DISTINCT delivery_order_id)
    - name: "Total Delivery Distance Km"
      expr: SUM(delivery_distance_km)
    - name: "Average Delivery Distance Km"
      expr: AVG(delivery_distance_km)
    - name: "Total Delivery Fee Amount"
      expr: SUM(delivery_fee_amount)
    - name: "Average Delivery Fee Amount"
      expr: AVG(delivery_fee_amount)
    - name: "Total Delivery Latitude"
      expr: SUM(delivery_latitude)
    - name: "Average Delivery Latitude"
      expr: AVG(delivery_latitude)
    - name: "Total Delivery Longitude"
      expr: SUM(delivery_longitude)
    - name: "Average Delivery Longitude"
      expr: AVG(delivery_longitude)
    - name: "Total Platform Commission Amount"
      expr: SUM(platform_commission_amount)
    - name: "Average Platform Commission Amount"
      expr: AVG(platform_commission_amount)
    - name: "Total Platform Commission Rate"
      expr: SUM(platform_commission_rate)
    - name: "Average Platform Commission Rate"
      expr: AVG(platform_commission_rate)
    - name: "Total Tip Amount"
      expr: SUM(tip_amount)
    - name: "Average Tip Amount"
      expr: AVG(tip_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount business metrics"
  source: "`vibe_restaurants_v1`.`order`.`discount`"
  dimensions:
    - name: "Applied At"
      expr: applied_at
    - name: "Authorization Required"
      expr: authorization_required
    - name: "Channel Restriction"
      expr: channel_restriction
    - name: "Code"
      expr: discount_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart Restriction"
      expr: daypart_restriction
    - name: "Discount Type"
      expr: discount_type
    - name: "Is Pre Approved"
      expr: is_pre_approved
    - name: "Is Stackable"
      expr: is_stackable
    - name: "Is Voided"
      expr: is_voided
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Name"
      expr: name
    - name: "Reason"
      expr: reason
    - name: "Scope"
      expr: scope
    - name: "Tax Treatment"
      expr: tax_treatment
    - name: "Valid From Date"
      expr: valid_from_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Discount"
      expr: COUNT(DISTINCT discount_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Cogs Impact Amount"
      expr: SUM(cogs_impact_amount)
    - name: "Average Cogs Impact Amount"
      expr: AVG(cogs_impact_amount)
    - name: "Total Final Price"
      expr: SUM(final_price)
    - name: "Average Final Price"
      expr: AVG(final_price)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Min Purchase Amount"
      expr: SUM(min_purchase_amount)
    - name: "Average Min Purchase Amount"
      expr: AVG(min_purchase_amount)
    - name: "Total Original Price"
      expr: SUM(original_price)
    - name: "Average Original Price"
      expr: AVG(original_price)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
    - name: "Total Revenue Impact Amount"
      expr: SUM(revenue_impact_amount)
    - name: "Average Revenue Impact Amount"
      expr: AVG(revenue_impact_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Order business metrics"
  source: "`vibe_restaurants_v1`.`order`.`guest_order`"
  dimensions:
    - name: "Cancelled At"
      expr: cancelled_at
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Delivery Provider"
      expr: delivery_provider
    - name: "Fulfilled At"
      expr: fulfilled_at
    - name: "Is Lto"
      expr: is_lto
    - name: "Is Voided"
      expr: is_voided
    - name: "Item Count"
      expr: item_count
    - name: "Kds Routed At"
      expr: kds_routed_at
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Olo Order Ref"
      expr: olo_order_ref
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Party Size"
      expr: party_size
    - name: "Payment Status"
      expr: payment_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guest Order"
      expr: COUNT(DISTINCT guest_order_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tip Amount"
      expr: SUM(tip_amount)
    - name: "Average Tip Amount"
      expr: AVG(tip_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_kds_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kds Ticket business metrics"
  source: "`vibe_restaurants_v1`.`order`.`kds_ticket`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daypart"
      expr: daypart
    - name: "Item Count"
      expr: item_count
    - name: "Modifier Count"
      expr: modifier_count
    - name: "Priority Level"
      expr: priority_level
    - name: "Re Fire Count"
      expr: re_fire_count
    - name: "Re Fire Flag"
      expr: re_fire_flag
    - name: "Re Fire Reason"
      expr: re_fire_reason
    - name: "Sos Met Flag"
      expr: sos_met_flag
    - name: "Sos Target Seconds"
      expr: sos_target_seconds
    - name: "Special Instructions"
      expr: special_instructions
    - name: "Ticket Bumped Timestamp"
      expr: ticket_bumped_timestamp
    - name: "Ticket Completed Timestamp"
      expr: ticket_completed_timestamp
    - name: "Ticket Created Timestamp"
      expr: ticket_created_timestamp
    - name: "Ticket Number"
      expr: ticket_number
    - name: "Ticket Sequence Number"
      expr: ticket_sequence_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Kds Ticket"
      expr: COUNT(DISTINCT kds_ticket_id)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Item business metrics"
  source: "`vibe_restaurants_v1`.`order`.`order_item`"
  dimensions:
    - name: "Calorie Count"
      expr: calorie_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart Code"
      expr: daypart_code
    - name: "Is Combo Component"
      expr: is_combo_component
    - name: "Is Lto"
      expr: is_lto
    - name: "Item Status"
      expr: item_status
    - name: "Kds Bump Timestamp"
      expr: kds_bump_timestamp
    - name: "Kds Sent Timestamp"
      expr: kds_sent_timestamp
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Pmix Category"
      expr: pmix_category
    - name: "Preparation Instructions"
      expr: preparation_instructions
    - name: "Promo Code"
      expr: promo_code
    - name: "Refund Flag"
      expr: refund_flag
    - name: "Source System Item Ref"
      expr: source_system_item_ref
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Item"
      expr: COUNT(DISTINCT order_item_id)
    - name: "Total Cost"
      expr: SUM(cost)
    - name: "Average Cost"
      expr: AVG(cost)
    - name: "Total Line Discount Amount"
      expr: SUM(line_discount_amount)
    - name: "Average Line Discount Amount"
      expr: AVG(line_discount_amount)
    - name: "Total Line Gross Amount"
      expr: SUM(line_gross_amount)
    - name: "Average Line Gross Amount"
      expr: AVG(line_gross_amount)
    - name: "Total Line Net Amount"
      expr: SUM(line_net_amount)
    - name: "Average Line Net Amount"
      expr: AVG(line_net_amount)
    - name: "Total Modifier Price"
      expr: SUM(modifier_price)
    - name: "Average Modifier Price"
      expr: AVG(modifier_price)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_order_modifier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Modifier business metrics"
  source: "`vibe_restaurants_v1`.`order`.`order_modifier`"
  dimensions:
    - name: "Allergen Flag"
      expr: allergen_flag
    - name: "Allergen Notes"
      expr: allergen_notes
    - name: "Applied Timestamp"
      expr: applied_timestamp
    - name: "Calorie Delta"
      expr: calorie_delta
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Group Name"
      expr: group_name
    - name: "Initiation Source"
      expr: initiation_source
    - name: "Is Comped"
      expr: is_comped
    - name: "Is Default"
      expr: is_default
    - name: "Is Voided"
      expr: is_voided
    - name: "Kds Acknowledged Timestamp"
      expr: kds_acknowledged_timestamp
    - name: "Kds Routed"
      expr: kds_routed
    - name: "Loyalty Redemption Flag"
      expr: loyalty_redemption_flag
    - name: "Lto Flag"
      expr: lto_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Modifier"
      expr: COUNT(DISTINCT order_modifier_id)
    - name: "Total Cogs Delta"
      expr: SUM(cogs_delta)
    - name: "Average Cogs Delta"
      expr: AVG(cogs_delta)
    - name: "Total Price Delta"
      expr: SUM(price_delta)
    - name: "Average Price Delta"
      expr: AVG(price_delta)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`vibe_restaurants_v1`.`order`.`payment`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Captured Timestamp"
      expr: captured_timestamp
    - name: "Card Entry Method"
      expr: card_entry_method
    - name: "Card Type"
      expr: card_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Gift Card Number Masked"
      expr: gift_card_number_masked
    - name: "Is Split Tender"
      expr: is_split_tender
    - name: "Is Voided"
      expr: is_voided
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Masked Card Number"
      expr: masked_card_number
    - name: "Offline Authorization Flag"
      expr: offline_authorization_flag
    - name: "Payment Status"
      expr: payment_status
    - name: "Pos Transaction Number"
      expr: pos_transaction_number
    - name: "Processor Name"
      expr: processor_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
    - name: "Total Applied Amount"
      expr: SUM(applied_amount)
    - name: "Average Applied Amount"
      expr: AVG(applied_amount)
    - name: "Total Change Due Amount"
      expr: SUM(change_due_amount)
    - name: "Average Change Due Amount"
      expr: AVG(change_due_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Interchange Fee Amount"
      expr: SUM(interchange_fee_amount)
    - name: "Average Interchange Fee Amount"
      expr: AVG(interchange_fee_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tendered Amount"
      expr: SUM(tendered_amount)
    - name: "Average Tendered Amount"
      expr: AVG(tendered_amount)
    - name: "Total Tip Amount"
      expr: SUM(tip_amount)
    - name: "Average Tip Amount"
      expr: AVG(tip_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund business metrics"
  source: "`vibe_restaurants_v1`.`order`.`refund`"
  dimensions:
    - name: "Approved At"
      expr: approved_at
    - name: "Batch Code"
      expr: batch_code
    - name: "Channel"
      expr: channel
    - name: "Csat Impact Flag"
      expr: csat_impact_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Fraud Review Notes"
      expr: fraud_review_notes
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Guest Contact Method"
      expr: guest_contact_method
    - name: "Is Fraudulent"
      expr: is_fraudulent
    - name: "Is Voided"
      expr: is_voided
    - name: "Loyalty Points Refunded"
      expr: loyalty_points_refunded
    - name: "Method"
      expr: method
    - name: "Nps Survey Sent"
      expr: nps_survey_sent
    - name: "Original Payment Method"
      expr: original_payment_method
    - name: "Payment Processor Ref"
      expr: payment_processor_ref
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Refund"
      expr: COUNT(DISTINCT refund_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Subtotal"
      expr: SUM(subtotal)
    - name: "Average Subtotal"
      expr: AVG(subtotal)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Status Event business metrics"
  source: "`vibe_restaurants_v1`.`order`.`status_event`"
  dimensions:
    - name: "Business Date"
      expr: business_date
    - name: "Cumulative Elapsed Seconds"
      expr: cumulative_elapsed_seconds
    - name: "Current State"
      expr: current_state
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Daypart"
      expr: daypart
    - name: "Delivery Zone"
      expr: delivery_zone
    - name: "Drive Thru Lane"
      expr: drive_thru_lane
    - name: "Elapsed Seconds In Prior State"
      expr: elapsed_seconds_in_prior_state
    - name: "Event Date"
      expr: event_date
    - name: "Event Sequence"
      expr: event_sequence
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Exception Reason Code"
      expr: exception_reason_code
    - name: "Exception Reason Description"
      expr: exception_reason_description
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fulfillment Mode"
      expr: fulfillment_mode
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Status Event"
      expr: COUNT(DISTINCT status_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_tax`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax business metrics"
  source: "`vibe_restaurants_v1`.`order`.`tax`"
  dimensions:
    - name: "Adjusted Timestamp"
      expr: adjusted_timestamp
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Applied Timestamp"
      expr: applied_timestamp
    - name: "Authority Code"
      expr: authority_code
    - name: "Authority Level"
      expr: authority_level
    - name: "Authority Name"
      expr: authority_name
    - name: "Code"
      expr: tax_code
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Engine Source"
      expr: engine_source
    - name: "Exemption Certificate Ref"
      expr: exemption_certificate_ref
    - name: "Exemption Reason"
      expr: exemption_reason
    - name: "Is Exempt"
      expr: is_exempt
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tax"
      expr: COUNT(DISTINCT tax_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Original Tax Amount"
      expr: SUM(original_tax_amount)
    - name: "Average Original Tax Amount"
      expr: AVG(original_tax_amount)
    - name: "Total Rate"
      expr: SUM(rate)
    - name: "Average Rate"
      expr: AVG(rate)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Taxable Amount"
      expr: SUM(taxable_amount)
    - name: "Average Taxable Amount"
      expr: AVG(taxable_amount)
$$;
