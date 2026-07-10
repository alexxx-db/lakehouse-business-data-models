-- Metric views for domain: product | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:48:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_catalog_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog Entry business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`catalog_entry`"
  dimensions:
    - name: "Catalog Description"
      expr: catalog_description
    - name: "Catalog Image Url"
      expr: catalog_image_url
    - name: "Catalog Name"
      expr: catalog_name
    - name: "Catalog Number"
      expr: catalog_number
    - name: "Catalog Status"
      expr: catalog_status
    - name: "Catalog Version"
      expr: catalog_version
    - name: "Certification Marks"
      expr: certification_marks
    - name: "Configurable Flag"
      expr: configurable_flag
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Chain"
      expr: distribution_chain
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Environmental Compliance"
      expr: environmental_compliance
    - name: "Export Control Classification"
      expr: export_control_classification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog Entry"
      expr: COUNT(DISTINCT catalog_entry_id)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Price Unit Of Measure"
      expr: SUM(price_unit_of_measure)
    - name: "Average Price Unit Of Measure"
      expr: AVG(price_unit_of_measure)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Classification business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`classification`"
  dimensions:
    - name: "Application Area"
      expr: application_area
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Auto Classified Flag"
      expr: auto_classified_flag
    - name: "Business Unit"
      expr: business_unit
    - name: "Class Code"
      expr: class_code
    - name: "Class Description"
      expr: class_description
    - name: "Class Level"
      expr: class_level
    - name: "Classification Status"
      expr: classification_status
    - name: "Commodity Code"
      expr: commodity_code
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Tariff Code"
      expr: customs_tariff_code
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Classification"
      expr: COUNT(DISTINCT classification_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Configuration business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`configuration`"
  dimensions:
    - name: "Application Type"
      expr: application_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Certification Requirements"
      expr: certification_requirements
    - name: "Constraint Rules"
      expr: constraint_rules
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
    - name: "Is Orderable"
      expr: is_orderable
    - name: "Is Quotable"
      expr: is_quotable
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Manufacturing Complexity"
      expr: manufacturing_complexity
    - name: "Minimum Order Quantity"
      expr: minimum_order_quantity
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Configuration"
      expr: COUNT(DISTINCT configuration_id)
    - name: "Total Base Price"
      expr: SUM(base_price)
    - name: "Average Base Price"
      expr: AVG(base_price)
    - name: "Total Code"
      expr: SUM(code)
    - name: "Average Code"
      expr: AVG(code)
    - name: "Total Configuration Status"
      expr: SUM(configuration_status)
    - name: "Average Configuration Status"
      expr: AVG(configuration_status)
    - name: "Total Configuration Type"
      expr: SUM(configuration_type)
    - name: "Average Configuration Type"
      expr: AVG(configuration_type)
    - name: "Total Description"
      expr: SUM(description)
    - name: "Average Description"
      expr: AVG(description)
    - name: "Total Dimensions Height Mm"
      expr: SUM(dimensions_height_mm)
    - name: "Average Dimensions Height Mm"
      expr: AVG(dimensions_height_mm)
    - name: "Total Dimensions Length Mm"
      expr: SUM(dimensions_length_mm)
    - name: "Average Dimensions Length Mm"
      expr: AVG(dimensions_length_mm)
    - name: "Total Dimensions Width Mm"
      expr: SUM(dimensions_width_mm)
    - name: "Average Dimensions Width Mm"
      expr: AVG(dimensions_width_mm)
    - name: "Total Name"
      expr: SUM(name)
    - name: "Average Name"
      expr: AVG(name)
    - name: "Total Power Rating Kw"
      expr: SUM(power_rating_kw)
    - name: "Average Power Rating Kw"
      expr: AVG(power_rating_kw)
    - name: "Total Price Adjustment"
      expr: SUM(price_adjustment)
    - name: "Average Price Adjustment"
      expr: AVG(price_adjustment)
    - name: "Total Total Configuration Price"
      expr: SUM(total_configuration_price)
    - name: "Average Total Configuration Price"
      expr: AVG(total_configuration_price)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Family business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`family`"
  dimensions:
    - name: "Business Unit"
      expr: business_unit
    - name: "Certification Requirements"
      expr: certification_requirements
    - name: "Code"
      expr: code
    - name: "Competitive Positioning"
      expr: competitive_positioning
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cybersecurity Classification"
      expr: cybersecurity_classification
    - name: "Data Source System"
      expr: data_source_system
    - name: "Description"
      expr: description
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Environmental Compliance"
      expr: environmental_compliance
    - name: "Erp Material Group"
      expr: erp_material_group
    - name: "Family Type"
      expr: family_type
    - name: "Geographic Availability"
      expr: geographic_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Family"
      expr: COUNT(DISTINCT family_id)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Manufacturing Strategy"
      expr: SUM(manufacturing_strategy)
    - name: "Average Manufacturing Strategy"
      expr: AVG(manufacturing_strategy)
    - name: "Total Mean Time Between Failures"
      expr: SUM(mean_time_between_failures)
    - name: "Average Mean Time Between Failures"
      expr: AVG(mean_time_between_failures)
    - name: "Total Mean Time To Repair"
      expr: SUM(mean_time_to_repair)
    - name: "Average Mean Time To Repair"
      expr: AVG(mean_time_to_repair)
    - name: "Total Product Portfolio Strategy"
      expr: SUM(product_portfolio_strategy)
    - name: "Average Product Portfolio Strategy"
      expr: AVG(product_portfolio_strategy)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Target Margin Percent"
      expr: SUM(target_margin_percent)
    - name: "Average Target Margin Percent"
      expr: AVG(target_margin_percent)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_lifecycle_stage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lifecycle Stage business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`lifecycle_stage`"
  dimensions:
    - name: "Actual Eol Date"
      expr: actual_eol_date
    - name: "Code"
      expr: code
    - name: "Customer Communication Status"
      expr: customer_communication_status
    - name: "Customer Notification Date"
      expr: customer_notification_date
    - name: "Eco Reference Number"
      expr: eco_reference_number
    - name: "Financial Impact Assessment"
      expr: financial_impact_assessment
    - name: "Internal Notification Date"
      expr: internal_notification_date
    - name: "Inventory Wind Down Plan"
      expr: inventory_wind_down_plan
    - name: "Is Active"
      expr: is_active
    - name: "Last Time Buy Date"
      expr: last_time_buy_date
    - name: "Last Time Ship Date"
      expr: last_time_ship_date
    - name: "Lifecycle Decision Authority"
      expr: lifecycle_decision_authority
    - name: "Lifecycle Review Date"
      expr: lifecycle_review_date
    - name: "Manufacturing Discontinuation Date"
      expr: manufacturing_discontinuation_date
    - name: "Market Demand Trend"
      expr: market_demand_trend
    - name: "Name"
      expr: name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lifecycle Stage"
      expr: COUNT(DISTINCT lifecycle_stage_id)
    - name: "Total Lifecycle Decision Rationale"
      expr: SUM(lifecycle_decision_rationale)
    - name: "Average Lifecycle Decision Rationale"
      expr: AVG(lifecycle_decision_rationale)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Line business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`order_line`"
  dimensions:
    - name: "Backorder Flag"
      expr: backorder_flag
    - name: "Billing Status"
      expr: billing_status
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Fulfillment Priority"
      expr: fulfillment_priority
    - name: "Item Category"
      expr: item_category
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Notes"
      expr: line_notes
    - name: "Line Number"
      expr: line_number
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Line Status"
      expr: line_status
    - name: "Profit Center Code"
      expr: profit_center_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Line"
      expr: COUNT(DISTINCT order_line_id)
    - name: "Total Confirmed Quantity"
      expr: SUM(confirmed_quantity)
    - name: "Average Confirmed Quantity"
      expr: AVG(confirmed_quantity)
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
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Extended Amount"
      expr: SUM(extended_amount)
    - name: "Average Extended Amount"
      expr: AVG(extended_amount)
    - name: "Total Extended Price Amount"
      expr: SUM(extended_price_amount)
    - name: "Average Extended Price Amount"
      expr: AVG(extended_price_amount)
    - name: "Total Gross Price"
      expr: SUM(gross_price)
    - name: "Average Gross Price"
      expr: AVG(gross_price)
    - name: "Total Line Amount"
      expr: SUM(line_amount)
    - name: "Average Line Amount"
      expr: AVG(line_amount)
    - name: "Total Line Total Amount"
      expr: SUM(line_total_amount)
    - name: "Average Line Total Amount"
      expr: AVG(line_total_amount)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Margin Amount"
      expr: SUM(margin_amount)
    - name: "Average Margin Amount"
      expr: AVG(margin_amount)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_plant_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant Data business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`plant_data`"
  dimensions:
    - name: "Abc Indicator"
      expr: abc_indicator
    - name: "Availability Check Group"
      expr: availability_check_group
    - name: "Backflush Indicator"
      expr: backflush_indicator
    - name: "Batch Management Required"
      expr: batch_management_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Counting Indicator"
      expr: cycle_counting_indicator
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Effective Out Date"
      expr: effective_out_date
    - name: "Gr Processing Time Days"
      expr: gr_processing_time_days
    - name: "In House Production Time Days"
      expr: in_house_production_time_days
    - name: "Inspection Setup Required"
      expr: inspection_setup_required
    - name: "Issue Storage Location"
      expr: issue_storage_location
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Size Procedure"
      expr: lot_size_procedure
    - name: "Material Number"
      expr: material_number
    - name: "Minimum Remaining Shelf Life Days"
      expr: minimum_remaining_shelf_life_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plant Data"
      expr: COUNT(DISTINCT plant_data_id)
    - name: "Total Fixed Lot Size"
      expr: SUM(fixed_lot_size)
    - name: "Average Fixed Lot Size"
      expr: AVG(fixed_lot_size)
    - name: "Total Maximum Lot Size"
      expr: SUM(maximum_lot_size)
    - name: "Average Maximum Lot Size"
      expr: AVG(maximum_lot_size)
    - name: "Total Maximum Stock Level"
      expr: SUM(maximum_stock_level)
    - name: "Average Maximum Stock Level"
      expr: AVG(maximum_stock_level)
    - name: "Total Minimum Lot Size"
      expr: SUM(minimum_lot_size)
    - name: "Average Minimum Lot Size"
      expr: AVG(minimum_lot_size)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Rounding Value"
      expr: SUM(rounding_value)
    - name: "Average Rounding Value"
      expr: AVG(rounding_value)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Scheduling Margin Key"
      expr: SUM(scheduling_margin_key)
    - name: "Average Scheduling Margin Key"
      expr: AVG(scheduling_margin_key)
    - name: "Total Shelf Life Expiration Days"
      expr: SUM(shelf_life_expiration_days)
    - name: "Average Shelf Life Expiration Days"
      expr: AVG(shelf_life_expiration_days)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Specification business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`product_specification`"
  dimensions:
    - name: "Application Suitability"
      expr: application_suitability
    - name: "Approved Date"
      expr: approved_date
    - name: "Color Finish"
      expr: color_finish
    - name: "Communication Protocol"
      expr: communication_protocol
    - name: "Connection Type"
      expr: connection_type
    - name: "Datasheet Reference"
      expr: datasheet_reference
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frequency Rating Hz"
      expr: frequency_rating_hz
    - name: "Installation Manual Reference"
      expr: installation_manual_reference
    - name: "Ip Rating"
      expr: ip_rating
    - name: "Material Composition"
      expr: material_composition
    - name: "Mounting Type"
      expr: mounting_type
    - name: "Nema Rating"
      expr: nema_rating
    - name: "Notes"
      expr: notes
    - name: "Performance Parameter"
      expr: performance_parameter
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Specification"
      expr: COUNT(DISTINCT product_specification_id)
    - name: "Total Altitude Rating Meters"
      expr: SUM(altitude_rating_meters)
    - name: "Average Altitude Rating Meters"
      expr: AVG(altitude_rating_meters)
    - name: "Total Current Rating Amperes"
      expr: SUM(current_rating_amperes)
    - name: "Average Current Rating Amperes"
      expr: AVG(current_rating_amperes)
    - name: "Total Dimensions Height Mm"
      expr: SUM(dimensions_height_mm)
    - name: "Average Dimensions Height Mm"
      expr: AVG(dimensions_height_mm)
    - name: "Total Dimensions Length Mm"
      expr: SUM(dimensions_length_mm)
    - name: "Average Dimensions Length Mm"
      expr: AVG(dimensions_length_mm)
    - name: "Total Dimensions Width Mm"
      expr: SUM(dimensions_width_mm)
    - name: "Average Dimensions Width Mm"
      expr: AVG(dimensions_width_mm)
    - name: "Total Humidity Rating Percent"
      expr: SUM(humidity_rating_percent)
    - name: "Average Humidity Rating Percent"
      expr: AVG(humidity_rating_percent)
    - name: "Total Operating Temperature Max C"
      expr: SUM(operating_temperature_max_c)
    - name: "Average Operating Temperature Max C"
      expr: AVG(operating_temperature_max_c)
    - name: "Total Operating Temperature Min C"
      expr: SUM(operating_temperature_min_c)
    - name: "Average Operating Temperature Min C"
      expr: AVG(operating_temperature_min_c)
    - name: "Total Power Rating Watts"
      expr: SUM(power_rating_watts)
    - name: "Average Power Rating Watts"
      expr: AVG(power_rating_watts)
    - name: "Total Storage Temperature Max C"
      expr: SUM(storage_temperature_max_c)
    - name: "Average Storage Temperature Max C"
      expr: AVG(storage_temperature_max_c)
    - name: "Total Storage Temperature Min C"
      expr: SUM(storage_temperature_min_c)
    - name: "Average Storage Temperature Min C"
      expr: AVG(storage_temperature_min_c)
    - name: "Total Vibration Resistance"
      expr: SUM(vibration_resistance)
    - name: "Average Vibration Resistance"
      expr: AVG(vibration_resistance)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku Master business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`sku_master`"
  dimensions:
    - name: "Abc Classification"
      expr: abc_classification
    - name: "Base Uom"
      expr: base_uom
    - name: "Commercial Description"
      expr: commercial_description
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dimension Uom"
      expr: dimension_uom
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Eccn Code"
      expr: eccn_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Hazard Class"
      expr: hazard_class
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Hts Code"
      expr: hts_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Long Description"
      expr: long_description
    - name: "Lot Control Required"
      expr: lot_control_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku Master"
      expr: COUNT(DISTINCT sku_master_id)
    - name: "Total Cost Currency"
      expr: SUM(cost_currency)
    - name: "Average Cost Currency"
      expr: AVG(cost_currency)
    - name: "Total Gross Weight"
      expr: SUM(gross_weight)
    - name: "Average Gross Weight"
      expr: AVG(gross_weight)
    - name: "Total Height"
      expr: SUM(height)
    - name: "Average Height"
      expr: AVG(height)
    - name: "Total Length"
      expr: SUM(length)
    - name: "Average Length"
      expr: AVG(length)
    - name: "Total Net Weight"
      expr: SUM(net_weight)
    - name: "Average Net Weight"
      expr: AVG(net_weight)
    - name: "Total Production To Base Conversion"
      expr: SUM(production_to_base_conversion)
    - name: "Average Production To Base Conversion"
      expr: AVG(production_to_base_conversion)
    - name: "Total Sales To Base Conversion"
      expr: SUM(sales_to_base_conversion)
    - name: "Average Sales To Base Conversion"
      expr: AVG(sales_to_base_conversion)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Volume"
      expr: SUM(volume)
    - name: "Average Volume"
      expr: AVG(volume)
    - name: "Total Width"
      expr: SUM(width)
    - name: "Average Width"
      expr: AVG(width)
$$;