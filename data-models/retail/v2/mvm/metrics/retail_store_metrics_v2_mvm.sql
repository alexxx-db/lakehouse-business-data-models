-- Metric views for domain: store | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:25:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment business metrics"
  source: "`vibe_retail_v1`.`store`.`assignment`"
  dimensions:
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Override Reason"
      expr: override_reason
    - name: "Primary Cluster Flag"
      expr: primary_cluster_flag
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assignment"
      expr: COUNT(DISTINCT assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cluster business metrics"
  source: "`vibe_retail_v1`.`store`.`cluster`"
  dimensions:
    - name: "Allows Overlap"
      expr: allows_overlap
    - name: "Assortment Depth Strategy"
      expr: assortment_depth_strategy
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Cluster Status"
      expr: cluster_status
    - name: "Cluster Type"
      expr: cluster_type
    - name: "Clustering Criteria"
      expr: clustering_criteria
    - name: "Clustering Methodology"
      expr: clustering_methodology
    - name: "Code"
      expr: cluster_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Cluster Code"
      expr: external_cluster_code
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cluster"
      expr: COUNT(DISTINCT cluster_id)
    - name: "Total Average Annual Sales Usd"
      expr: SUM(average_annual_sales_usd)
    - name: "Average Average Annual Sales Usd"
      expr: AVG(average_annual_sales_usd)
    - name: "Total Average Store Size Sqft"
      expr: SUM(average_store_size_sqft)
    - name: "Average Average Store Size Sqft"
      expr: AVG(average_store_size_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department business metrics"
  source: "`vibe_retail_v1`.`store`.`department`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department Status"
      expr: department_status
    - name: "Department Type"
      expr: department_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Endcap Count"
      expr: endcap_count
    - name: "Fixture Count"
      expr: fixture_count
    - name: "Floor Number"
      expr: floor_number
    - name: "Gondola Count"
      expr: gondola_count
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "License Expiry Date"
      expr: license_expiry_date
    - name: "License Number"
      expr: license_number
    - name: "Licensed Department Flag"
      expr: licensed_department_flag
    - name: "Notes"
      expr: notes
    - name: "Omnichannel Fulfillment Enabled Flag"
      expr: omnichannel_fulfillment_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Department"
      expr: COUNT(DISTINCT department_id)
    - name: "Total Gross Margin Target Percent"
      expr: SUM(gross_margin_target_percent)
    - name: "Average Gross Margin Target Percent"
      expr: AVG(gross_margin_target_percent)
    - name: "Total Labor Budget Monthly"
      expr: SUM(labor_budget_monthly)
    - name: "Average Labor Budget Monthly"
      expr: AVG(labor_budget_monthly)
    - name: "Total Sales Target Monthly"
      expr: SUM(sales_target_monthly)
    - name: "Average Sales Target Monthly"
      expr: AVG(sales_target_monthly)
    - name: "Total Selling Area Sq Ft"
      expr: SUM(selling_area_sq_ft)
    - name: "Average Selling Area Sq Ft"
      expr: AVG(selling_area_sq_ft)
    - name: "Total Shrinkage Rate Percent"
      expr: SUM(shrinkage_rate_percent)
    - name: "Average Shrinkage Rate Percent"
      expr: AVG(shrinkage_rate_percent)
    - name: "Total Temperature Range Max F"
      expr: SUM(temperature_range_max_f)
    - name: "Average Temperature Range Max F"
      expr: AVG(temperature_range_max_f)
    - name: "Total Temperature Range Min F"
      expr: SUM(temperature_range_min_f)
    - name: "Average Temperature Range Min F"
      expr: AVG(temperature_range_min_f)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_format`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Format business metrics"
  source: "`vibe_retail_v1`.`store`.`format`"
  dimensions:
    - name: "Assortment Breadth Level"
      expr: assortment_breadth_level
    - name: "Assortment Depth Level"
      expr: assortment_depth_level
    - name: "Bopis Capable Flag"
      expr: bopis_capable_flag
    - name: "Clienteling Service Flag"
      expr: clienteling_service_flag
    - name: "Code"
      expr: format_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Dsd Receiving Flag"
      expr: dsd_receiving_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Endcap Count Typical"
      expr: endcap_count_typical
    - name: "Format Status"
      expr: format_status
    - name: "Format Type"
      expr: format_type
    - name: "Gondola Configuration Type"
      expr: gondola_configuration_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Program Participation Flag"
      expr: loyalty_program_participation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Format"
      expr: COUNT(DISTINCT format_id)
    - name: "Total Size Band Max Sqft"
      expr: SUM(size_band_max_sqft)
    - name: "Average Size Band Max Sqft"
      expr: AVG(size_band_max_sqft)
    - name: "Total Size Band Min Sqft"
      expr: SUM(size_band_min_sqft)
    - name: "Average Size Band Min Sqft"
      expr: AVG(size_band_min_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location business metrics"
  source: "`vibe_retail_v1`.`store`.`location`"
  dimensions:
    - name: "Accessibility Certified"
      expr: accessibility_certified
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Assortment Breadth Norm"
      expr: assortment_breadth_norm
    - name: "Assortment Depth Norm"
      expr: assortment_depth_norm
    - name: "Banner Brand"
      expr: banner_brand
    - name: "Bopis Capable"
      expr: bopis_capable
    - name: "City"
      expr: city
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Closure Date"
      expr: closure_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "District Code"
      expr: district_code
    - name: "Dsd Receiving"
      expr: dsd_receiving
    - name: "Email Address"
      expr: email_address
    - name: "Format Size Band"
      expr: format_size_band
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Location"
      expr: COUNT(DISTINCT location_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Selling Square Footage"
      expr: SUM(selling_square_footage)
    - name: "Average Selling Square Footage"
      expr: AVG(selling_square_footage)
    - name: "Total Total Square Footage"
      expr: SUM(total_square_footage)
    - name: "Average Total Square Footage"
      expr: AVG(total_square_footage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Terminal business metrics"
  source: "`vibe_retail_v1`.`store`.`pos_terminal`"
  dimensions:
    - name: "Barcode Scanner Type"
      expr: barcode_scanner_type
    - name: "Cash Drawer Enabled"
      expr: cash_drawer_enabled
    - name: "Contactless Enabled"
      expr: contactless_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Display Type"
      expr: customer_display_type
    - name: "Ebt Snap Enabled"
      expr: ebt_snap_enabled
    - name: "Emv Chip Enabled"
      expr: emv_chip_enabled
    - name: "Encryption Enabled"
      expr: encryption_enabled
    - name: "Hardware Model"
      expr: hardware_model
    - name: "Hardware Serial Number"
      expr: hardware_serial_number
    - name: "Installation Date"
      expr: installation_date
    - name: "Ip Address"
      expr: ip_address
    - name: "Lane Number"
      expr: lane_number
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Transaction Timestamp"
      expr: last_transaction_timestamp
    - name: "Mac Address"
      expr: mac_address
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Terminal"
      expr: COUNT(DISTINCT pos_terminal_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Region business metrics"
  source: "`vibe_retail_v1`.`store`.`region`"
  dimensions:
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Code"
      expr: region_code
    - name: "Comp Sales Base Year"
      expr: comp_sales_base_year
    - name: "Country Code"
      expr: country_code
    - name: "Country Subdivision Code"
      expr: country_subdivision_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Privacy Framework"
      expr: data_privacy_framework
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Region Code"
      expr: external_region_code
    - name: "Fiscal Calendar Code"
      expr: fiscal_calendar_code
    - name: "Food Safety Authority"
      expr: food_safety_authority
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Labor Law Jurisdiction"
      expr: labor_law_jurisdiction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Region"
      expr: COUNT(DISTINCT region_id)
    - name: "Total Geographic Area Km2"
      expr: SUM(geographic_area_km2)
    - name: "Average Geographic Area Km2"
      expr: AVG(geographic_area_km2)
    - name: "Total Population Estimate"
      expr: SUM(population_estimate)
    - name: "Average Population Estimate"
      expr: AVG(population_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_ship_from_store_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ship From Store Node business metrics"
  source: "`vibe_retail_v1`.`store`.`ship_from_store_node`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Carrier Account Number"
      expr: carrier_account_number
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daily Capacity Orders"
      expr: daily_capacity_orders
    - name: "Daily Capacity Units"
      expr: daily_capacity_units
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Inventory Sync Frequency Minutes"
      expr: inventory_sync_frequency_minutes
    - name: "Next Day Cutoff Time"
      expr: next_day_cutoff_time
    - name: "Node Code"
      expr: node_code
    - name: "Node Name"
      expr: node_name
    - name: "Node Type"
      expr: node_type
    - name: "Notes"
      expr: notes
    - name: "Oms Integration Enabled"
      expr: oms_integration_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ship From Store Node"
      expr: COUNT(DISTINCT ship_from_store_node_id)
    - name: "Total Average Pack Time Minutes"
      expr: SUM(average_pack_time_minutes)
    - name: "Average Average Pack Time Minutes"
      expr: AVG(average_pack_time_minutes)
    - name: "Total Average Pick Time Minutes"
      expr: SUM(average_pick_time_minutes)
    - name: "Average Average Pick Time Minutes"
      expr: AVG(average_pick_time_minutes)
    - name: "Total Cost Per Order"
      expr: SUM(cost_per_order)
    - name: "Average Cost Per Order"
      expr: AVG(cost_per_order)
    - name: "Total Service Radius Km"
      expr: SUM(service_radius_km)
    - name: "Average Service Radius Km"
      expr: AVG(service_radius_km)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_shrinkage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shrinkage Event business metrics"
  source: "`vibe_retail_v1`.`store`.`shrinkage_event`"
  dimensions:
    - name: "Case Reference Number"
      expr: case_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detection Method"
      expr: detection_method
    - name: "Event Date"
      expr: event_date
    - name: "Event Number"
      expr: event_number
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Incident Report Filed"
      expr: incident_report_filed
    - name: "Inventory Adjustment Posted"
      expr: inventory_adjustment_posted
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Police Report Number"
      expr: police_report_number
    - name: "Product Description"
      expr: product_description
    - name: "Recovery Method"
      expr: recovery_method
    - name: "Resolution Date"
      expr: resolution_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shrinkage Event"
      expr: COUNT(DISTINCT shrinkage_event_id)
    - name: "Total Cost Value Lost"
      expr: SUM(cost_value_lost)
    - name: "Average Cost Value Lost"
      expr: AVG(cost_value_lost)
    - name: "Total Quantity Lost"
      expr: SUM(quantity_lost)
    - name: "Average Quantity Lost"
      expr: AVG(quantity_lost)
    - name: "Total Recovery Amount"
      expr: SUM(recovery_amount)
    - name: "Average Recovery Amount"
      expr: AVG(recovery_amount)
    - name: "Total Total Retail Value Lost"
      expr: SUM(total_retail_value_lost)
    - name: "Average Total Retail Value Lost"
      expr: AVG(total_retail_value_lost)
    - name: "Total Unit Retail Value"
      expr: SUM(unit_retail_value)
    - name: "Average Unit Retail Value"
      expr: AVG(unit_retail_value)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_traffic_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Traffic Count business metrics"
  source: "`vibe_retail_v1`.`store`.`traffic_count`"
  dimensions:
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Counting Zone Code"
      expr: counting_zone_code
    - name: "Counting Zone Name"
      expr: counting_zone_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Data Source System"
      expr: data_source_system
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Hour Of Day"
      expr: hour_of_day
    - name: "Inbound Count"
      expr: inbound_count
    - name: "Is Holiday"
      expr: is_holiday
    - name: "Is Promotional Event"
      expr: is_promotional_event
    - name: "Is Store Open"
      expr: is_store_open
    - name: "Measurement Interval Minutes"
      expr: measurement_interval_minutes
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Net Occupancy Estimate"
      expr: net_occupancy_estimate
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Traffic Count"
      expr: COUNT(DISTINCT traffic_count_id)
    - name: "Total Accuracy Confidence Percent"
      expr: SUM(accuracy_confidence_percent)
    - name: "Average Accuracy Confidence Percent"
      expr: AVG(accuracy_confidence_percent)
    - name: "Total Average Dwell Time Minutes"
      expr: SUM(average_dwell_time_minutes)
    - name: "Average Average Dwell Time Minutes"
      expr: AVG(average_dwell_time_minutes)
    - name: "Total Conversion Rate Percent"
      expr: SUM(conversion_rate_percent)
    - name: "Average Conversion Rate Percent"
      expr: AVG(conversion_rate_percent)
    - name: "Total Temperature Fahrenheit"
      expr: SUM(temperature_fahrenheit)
    - name: "Average Temperature Fahrenheit"
      expr: AVG(temperature_fahrenheit)
$$;
