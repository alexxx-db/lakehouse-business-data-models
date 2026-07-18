-- Metric views for domain: fulfillment | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:25:35

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_bopis_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bopis Appointment business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`bopis_appointment`"
  dimensions:
    - name: "Actual Pickup Timestamp"
      expr: actual_pickup_timestamp
    - name: "Actual Ready Minutes"
      expr: actual_ready_minutes
    - name: "Alternate Pickup Person Name"
      expr: alternate_pickup_person_name
    - name: "Appointment Number"
      expr: appointment_number
    - name: "Appointment Status"
      expr: appointment_status
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Check In Method"
      expr: check_in_method
    - name: "Check In Timestamp"
      expr: check_in_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Email"
      expr: customer_email
    - name: "Customer Name"
      expr: customer_name
    - name: "Customer Phone"
      expr: customer_phone
    - name: "Expiration Timestamp"
      expr: expiration_timestamp
    - name: "Id Verification Method"
      expr: id_verification_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bopis Appointment"
      expr: COUNT(DISTINCT bopis_appointment_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`carrier`"
  dimensions:
    - name: "Api Integration Flag"
      expr: api_integration_flag
    - name: "Bopis Ready Flag"
      expr: bopis_ready_flag
    - name: "Carrier Status"
      expr: carrier_status
    - name: "Carrier Type"
      expr: carrier_type
    - name: "Code"
      expr: carrier_code
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cutoff Time Local"
      expr: cutoff_time_local
    - name: "Edi Capable Flag"
      expr: edi_capable_flag
    - name: "Geographic Coverage"
      expr: geographic_coverage
    - name: "Hazmat Certified Flag"
      expr: hazmat_certified_flag
    - name: "Insurance Coverage Flag"
      expr: insurance_coverage_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier"
      expr: COUNT(DISTINCT carrier_id)
    - name: "Total Base Rate Per Lb"
      expr: SUM(base_rate_per_lb)
    - name: "Average Base Rate Per Lb"
      expr: AVG(base_rate_per_lb)
    - name: "Total Dimensional Weight Factor"
      expr: SUM(dimensional_weight_factor)
    - name: "Average Dimensional Weight Factor"
      expr: AVG(dimensional_weight_factor)
    - name: "Total Extended Area Surcharge"
      expr: SUM(extended_area_surcharge)
    - name: "Average Extended Area Surcharge"
      expr: AVG(extended_area_surcharge)
    - name: "Total Fuel Surcharge Percentage"
      expr: SUM(fuel_surcharge_percentage)
    - name: "Average Fuel Surcharge Percentage"
      expr: AVG(fuel_surcharge_percentage)
    - name: "Total Max Height Inches"
      expr: SUM(max_height_inches)
    - name: "Average Max Height Inches"
      expr: AVG(max_height_inches)
    - name: "Total Max Length Inches"
      expr: SUM(max_length_inches)
    - name: "Average Max Length Inches"
      expr: AVG(max_length_inches)
    - name: "Total Max Weight Lbs"
      expr: SUM(max_weight_lbs)
    - name: "Average Max Weight Lbs"
      expr: AVG(max_weight_lbs)
    - name: "Total Max Width Inches"
      expr: SUM(max_width_inches)
    - name: "Average Max Width Inches"
      expr: AVG(max_width_inches)
    - name: "Total Negotiated Discount Percentage"
      expr: SUM(negotiated_discount_percentage)
    - name: "Average Negotiated Discount Percentage"
      expr: AVG(negotiated_discount_percentage)
    - name: "Total Residential Delivery Surcharge"
      expr: SUM(residential_delivery_surcharge)
    - name: "Average Residential Delivery Surcharge"
      expr: AVG(residential_delivery_surcharge)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_carrier_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Service business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`carrier_service`"
  dimensions:
    - name: "Bopis Eligible Flag"
      expr: bopis_eligible_flag
    - name: "Carbon Neutral Flag"
      expr: carbon_neutral_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cutoff Time"
      expr: cutoff_time
    - name: "Cutoff Timezone"
      expr: cutoff_timezone
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Restriction Type"
      expr: geographic_restriction_type
    - name: "Hazmat Eligible Flag"
      expr: hazmat_eligible_flag
    - name: "Holiday Delivery Flag"
      expr: holiday_delivery_flag
    - name: "Insurance Included Flag"
      expr: insurance_included_flag
    - name: "International Eligible Flag"
      expr: international_eligible_flag
    - name: "Perishable Eligible Flag"
      expr: perishable_eligible_flag
    - name: "Restricted Countries"
      expr: restricted_countries
    - name: "Restricted Postal Codes"
      expr: restricted_postal_codes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Service"
      expr: COUNT(DISTINCT carrier_service_id)
    - name: "Total Base Rate"
      expr: SUM(base_rate)
    - name: "Average Base Rate"
      expr: AVG(base_rate)
    - name: "Total Insurance Max Value"
      expr: SUM(insurance_max_value)
    - name: "Average Insurance Max Value"
      expr: AVG(insurance_max_value)
    - name: "Total Max Girth Cm"
      expr: SUM(max_girth_cm)
    - name: "Average Max Girth Cm"
      expr: AVG(max_girth_cm)
    - name: "Total Max Height Cm"
      expr: SUM(max_height_cm)
    - name: "Average Max Height Cm"
      expr: AVG(max_height_cm)
    - name: "Total Max Length Cm"
      expr: SUM(max_length_cm)
    - name: "Average Max Length Cm"
      expr: AVG(max_length_cm)
    - name: "Total Max Weight Kg"
      expr: SUM(max_weight_kg)
    - name: "Average Max Weight Kg"
      expr: AVG(max_weight_kg)
    - name: "Total Max Width Cm"
      expr: SUM(max_width_cm)
    - name: "Average Max Width Cm"
      expr: AVG(max_width_cm)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_fulfillment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment Line business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_line`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Exception Code"
      expr: exception_code
    - name: "Exception Description"
      expr: exception_description
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fulfillment Source Type"
      expr: fulfillment_source_type
    - name: "Gtin"
      expr: gtin
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Original Sku"
      expr: original_sku
    - name: "Pack Timestamp"
      expr: pack_timestamp
    - name: "Pick Location"
      expr: pick_location
    - name: "Pick Timestamp"
      expr: pick_timestamp
    - name: "Serial Number"
      expr: serial_number
    - name: "Ship Timestamp"
      expr: ship_timestamp
    - name: "Sku"
      expr: sku
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fulfillment Line"
      expr: COUNT(DISTINCT fulfillment_line_id)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Quantity Allocated"
      expr: SUM(quantity_allocated)
    - name: "Average Quantity Allocated"
      expr: AVG(quantity_allocated)
    - name: "Total Quantity Cancelled"
      expr: SUM(quantity_cancelled)
    - name: "Average Quantity Cancelled"
      expr: AVG(quantity_cancelled)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Quantity Packed"
      expr: SUM(quantity_packed)
    - name: "Average Quantity Packed"
      expr: AVG(quantity_packed)
    - name: "Total Quantity Picked"
      expr: SUM(quantity_picked)
    - name: "Average Quantity Picked"
      expr: AVG(quantity_picked)
    - name: "Total Quantity Shipped"
      expr: SUM(quantity_shipped)
    - name: "Average Quantity Shipped"
      expr: AVG(quantity_shipped)
    - name: "Total Weight"
      expr: SUM(weight)
    - name: "Average Weight"
      expr: AVG(weight)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment Node business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_node`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Automation Level"
      expr: automation_level
    - name: "Bopis Enabled"
      expr: bopis_enabled
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Curbside Pickup Enabled"
      expr: curbside_pickup_enabled
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Dock Door Count"
      expr: dock_door_count
    - name: "Email Address"
      expr: email_address
    - name: "Hazmat Certified"
      expr: hazmat_certified
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manager Name"
      expr: manager_name
    - name: "Next Day Delivery Enabled"
      expr: next_day_delivery_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fulfillment Node"
      expr: COUNT(DISTINCT fulfillment_node_id)
    - name: "Total Delivery Zone Coverage Radius Miles"
      expr: SUM(delivery_zone_coverage_radius_miles)
    - name: "Average Delivery Zone Coverage Radius Miles"
      expr: AVG(delivery_zone_coverage_radius_miles)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment Order business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fulfillment Assigned Timestamp"
      expr: fulfillment_assigned_timestamp
    - name: "Fulfillment Created Timestamp"
      expr: fulfillment_created_timestamp
    - name: "Fulfillment Method"
      expr: fulfillment_method
    - name: "Fulfillment Order Number"
      expr: fulfillment_order_number
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Gift Message"
      expr: gift_message
    - name: "Is Gift"
      expr: is_gift
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Order Date"
      expr: order_date
    - name: "Package Count"
      expr: package_count
    - name: "Packing Completed Timestamp"
      expr: packing_completed_timestamp
    - name: "Packing Slip Url"
      expr: packing_slip_url
    - name: "Picking Completed Timestamp"
      expr: picking_completed_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fulfillment Order"
      expr: COUNT(DISTINCT fulfillment_order_id)
    - name: "Total Actual Fulfillment Hours"
      expr: SUM(actual_fulfillment_hours)
    - name: "Average Actual Fulfillment Hours"
      expr: AVG(actual_fulfillment_hours)
    - name: "Total Shipping Cost Amount"
      expr: SUM(shipping_cost_amount)
    - name: "Average Shipping Cost Amount"
      expr: AVG(shipping_cost_amount)
    - name: "Total Total Volume Cubic Meters"
      expr: SUM(total_volume_cubic_meters)
    - name: "Average Total Volume Cubic Meters"
      expr: AVG(total_volume_cubic_meters)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_node_carrier_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Node Carrier Service business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`node_carrier_service`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cutoff Time Override"
      expr: cutoff_time_override
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active Flag"
      expr: is_active_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Daily Volume"
      expr: max_daily_volume
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Cutoff Time Override Month"
      expr: DATE_TRUNC('MONTH', cutoff_time_override)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Node Carrier Service"
      expr: COUNT(DISTINCT node_carrier_service_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack Task business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`pack_task`"
  dimensions:
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Exception Code"
      expr: exception_code
    - name: "Exception Notes"
      expr: exception_notes
    - name: "Fulfillment Type"
      expr: fulfillment_type
    - name: "Gift Message Included Flag"
      expr: gift_message_included_flag
    - name: "Gift Wrap Flag"
      expr: gift_wrap_flag
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Items Packed Count"
      expr: items_packed_count
    - name: "Pack Duration Seconds"
      expr: pack_duration_seconds
    - name: "Pack End Timestamp"
      expr: pack_end_timestamp
    - name: "Pack Start Timestamp"
      expr: pack_start_timestamp
    - name: "Package Size"
      expr: package_size
    - name: "Package Type"
      expr: package_type
    - name: "Packing Slip Printed Flag"
      expr: packing_slip_printed_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pack Task"
      expr: COUNT(DISTINCT pack_task_id)
    - name: "Total Insurance Value Amount"
      expr: SUM(insurance_value_amount)
    - name: "Average Insurance Value Amount"
      expr: AVG(insurance_value_amount)
    - name: "Total Package Height Cm"
      expr: SUM(package_height_cm)
    - name: "Average Package Height Cm"
      expr: AVG(package_height_cm)
    - name: "Total Package Length Cm"
      expr: SUM(package_length_cm)
    - name: "Average Package Length Cm"
      expr: AVG(package_length_cm)
    - name: "Total Package Weight Kg"
      expr: SUM(package_weight_kg)
    - name: "Average Package Weight Kg"
      expr: AVG(package_weight_kg)
    - name: "Total Package Width Cm"
      expr: SUM(package_width_cm)
    - name: "Average Package Width Cm"
      expr: AVG(package_width_cm)
    - name: "Total Quality Check Performed By"
      expr: SUM(quality_check_performed_by)
    - name: "Average Quality Check Performed By"
      expr: AVG(quality_check_performed_by)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick Task business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`pick_task`"
  dimensions:
    - name: "Aisle"
      expr: aisle
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Bay"
      expr: bay
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Approval Status"
      expr: customer_approval_status
    - name: "Exception Code"
      expr: exception_code
    - name: "Exception Reason"
      expr: exception_reason
    - name: "Fulfillment Channel"
      expr: fulfillment_channel
    - name: "Label Applied"
      expr: label_applied
    - name: "Package Type"
      expr: package_type
    - name: "Packing Slip Printed"
      expr: packing_slip_printed
    - name: "Packing Station Code"
      expr: packing_station_code
    - name: "Pick Task Status"
      expr: pick_task_status
    - name: "Priority Level"
      expr: priority_level
    - name: "Quality Check Outcome"
      expr: quality_check_outcome
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pick Task"
      expr: COUNT(DISTINCT pick_task_id)
    - name: "Total Quantity Picked"
      expr: SUM(quantity_picked)
    - name: "Average Quantity Picked"
      expr: AVG(quantity_picked)
    - name: "Total Quantity Requested"
      expr: SUM(quantity_requested)
    - name: "Average Quantity Requested"
      expr: AVG(quantity_requested)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`shipment`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Carrier Charge Currency Code"
      expr: carrier_charge_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Declared Value Currency Code"
      expr: declared_value_currency_code
    - name: "Delivery Instructions"
      expr: delivery_instructions
    - name: "Delivery Signature Required Flag"
      expr: delivery_signature_required_flag
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Fulfillment Type"
      expr: fulfillment_type
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Package Count"
      expr: package_count
    - name: "Ship Date"
      expr: ship_date
    - name: "Ship From Location Type"
      expr: ship_from_location_type
    - name: "Ship To Address Line1"
      expr: ship_to_address_line1
    - name: "Ship To Address Line2"
      expr: ship_to_address_line2
    - name: "Ship To City"
      expr: ship_to_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipment"
      expr: COUNT(DISTINCT shipment_id)
    - name: "Total Carrier Charge Amount"
      expr: SUM(carrier_charge_amount)
    - name: "Average Carrier Charge Amount"
      expr: AVG(carrier_charge_amount)
    - name: "Total Declared Value Amount"
      expr: SUM(declared_value_amount)
    - name: "Average Declared Value Amount"
      expr: AVG(declared_value_amount)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Length Cm"
      expr: SUM(length_cm)
    - name: "Average Length Cm"
      expr: AVG(length_cm)
    - name: "Total Shipping Cost Amount"
      expr: SUM(shipping_cost_amount)
    - name: "Average Shipping Cost Amount"
      expr: AVG(shipping_cost_amount)
    - name: "Total Total Volume Cubic Meters"
      expr: SUM(total_volume_cubic_meters)
    - name: "Average Total Volume Cubic Meters"
      expr: AVG(total_volume_cubic_meters)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment Package business metrics"
  source: "`vibe_retail_v1`.`fulfillment`.`shipment_package`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Contents Summary"
      expr: contents_summary
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Confirmation Method"
      expr: delivery_confirmation_method
    - name: "Delivery Notes"
      expr: delivery_notes
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Is Hazmat"
      expr: is_hazmat
    - name: "Is Insured"
      expr: is_insured
    - name: "Is Label Printed"
      expr: is_label_printed
    - name: "Is Manifested"
      expr: is_manifested
    - name: "Is Sealed"
      expr: is_sealed
    - name: "Is Signature Required"
      expr: is_signature_required
    - name: "Item Count"
      expr: item_count
    - name: "Labeled Timestamp"
      expr: labeled_timestamp
    - name: "Manifested Timestamp"
      expr: manifested_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipment Package"
      expr: COUNT(DISTINCT shipment_package_id)
    - name: "Total Billable Weight Kg"
      expr: SUM(billable_weight_kg)
    - name: "Average Billable Weight Kg"
      expr: AVG(billable_weight_kg)
    - name: "Total Dimensional Weight Kg"
      expr: SUM(dimensional_weight_kg)
    - name: "Average Dimensional Weight Kg"
      expr: AVG(dimensional_weight_kg)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Insurance Value Amount"
      expr: SUM(insurance_value_amount)
    - name: "Average Insurance Value Amount"
      expr: AVG(insurance_value_amount)
    - name: "Total Length Cm"
      expr: SUM(length_cm)
    - name: "Average Length Cm"
      expr: AVG(length_cm)
    - name: "Total Shipping Cost Amount"
      expr: SUM(shipping_cost_amount)
    - name: "Average Shipping Cost Amount"
      expr: AVG(shipping_cost_amount)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;
