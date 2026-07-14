-- Metric views for domain: product | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:49:54

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_aftersales_model_year_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aftersales Model Year Program business metrics"
  source: "`vibe_automotive_v1`.`product`.`aftersales_model_year_program`"
  dimensions:
    - name: "Actual Production Volume"
      expr: actual_production_volume
    - name: "Adas Level"
      expr: adas_level
    - name: "Connected Services Enabled"
      expr: connected_services_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eop Date"
      expr: eop_date
    - name: "Fmea Completed"
      expr: fmea_completed
    - name: "Homologation Region"
      expr: homologation_region
    - name: "Launch Date"
      expr: launch_date
    - name: "Model Year"
      expr: model_year
    - name: "Msrp Currency"
      expr: msrp_currency
    - name: "Ncap Target Rating"
      expr: ncap_target_rating
    - name: "Ota Capable"
      expr: ota_capable
    - name: "Platform Code"
      expr: platform_code
    - name: "Powertrain Type"
      expr: powertrain_type
    - name: "Ppap Status"
      expr: ppap_status
    - name: "Program Budget Currency"
      expr: program_budget_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aftersales Model Year Program"
      expr: COUNT(DISTINCT aftersales_model_year_program_id)
    - name: "Total Bom Complexity Score"
      expr: SUM(bom_complexity_score)
    - name: "Average Bom Complexity Score"
      expr: AVG(bom_complexity_score)
    - name: "Total Cafe Target"
      expr: SUM(cafe_target)
    - name: "Average Cafe Target"
      expr: AVG(cafe_target)
    - name: "Total Capex Amount"
      expr: SUM(capex_amount)
    - name: "Average Capex Amount"
      expr: AVG(capex_amount)
    - name: "Total Epa Rating Target"
      expr: SUM(epa_rating_target)
    - name: "Average Epa Rating Target"
      expr: AVG(epa_rating_target)
    - name: "Total Program Budget Amount"
      expr: SUM(program_budget_amount)
    - name: "Average Program Budget Amount"
      expr: AVG(program_budget_amount)
    - name: "Total Target Msrp Max"
      expr: SUM(target_msrp_max)
    - name: "Average Target Msrp Max"
      expr: AVG(target_msrp_max)
    - name: "Total Target Msrp Min"
      expr: SUM(target_msrp_min)
    - name: "Average Target Msrp Min"
      expr: AVG(target_msrp_min)
    - name: "Total Tooling Investment"
      expr: SUM(tooling_investment)
    - name: "Average Tooling Investment"
      expr: AVG(tooling_investment)
    - name: "Total Wltp Target"
      expr: SUM(wltp_target)
    - name: "Average Wltp Target"
      expr: AVG(wltp_target)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_aftersales_option_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aftersales Option Package business metrics"
  source: "`vibe_automotive_v1`.`product`.`aftersales_option_package`"
  dimensions:
    - name: "Available Markets"
      expr: available_markets
    - name: "Available Model Years"
      expr: available_model_years
    - name: "Available Trim Levels"
      expr: available_trim_levels
    - name: "Bom Reference Number"
      expr: bom_reference_number
    - name: "Content Description"
      expr: content_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Excludes Package Codes"
      expr: excludes_package_codes
    - name: "Included In Package Codes"
      expr: included_in_package_codes
    - name: "Installation Location"
      expr: installation_location
    - name: "Introduction Date"
      expr: introduction_date
    - name: "Is Orderable"
      expr: is_orderable
    - name: "Is Visible To Customer"
      expr: is_visible_to_customer
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Marketing Description"
      expr: marketing_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aftersales Option Package"
      expr: COUNT(DISTINCT aftersales_option_package_id)
    - name: "Total Attachment Rate Percent"
      expr: SUM(attachment_rate_percent)
    - name: "Average Attachment Rate Percent"
      expr: AVG(attachment_rate_percent)
    - name: "Total Dealer Cost Amount"
      expr: SUM(dealer_cost_amount)
    - name: "Average Dealer Cost Amount"
      expr: AVG(dealer_cost_amount)
    - name: "Total Emissions Impact Grams Co2 Km"
      expr: SUM(emissions_impact_grams_co2_km)
    - name: "Average Emissions Impact Grams Co2 Km"
      expr: AVG(emissions_impact_grams_co2_km)
    - name: "Total Fuel Economy Impact Percent"
      expr: SUM(fuel_economy_impact_percent)
    - name: "Average Fuel Economy Impact Percent"
      expr: AVG(fuel_economy_impact_percent)
    - name: "Total Labor Hours"
      expr: SUM(labor_hours)
    - name: "Average Labor Hours"
      expr: AVG(labor_hours)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_aftersales_trim_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aftersales Trim Level business metrics"
  source: "`vibe_automotive_v1`.`product`.`aftersales_trim_level`"
  dimensions:
    - name: "Adas Level"
      expr: adas_level
    - name: "Availability Regions"
      expr: availability_regions
    - name: "Body Style"
      expr: body_style
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drivetrain"
      expr: drivetrain
    - name: "Electric Range Miles"
      expr: electric_range_miles
    - name: "Eop Date"
      expr: eop_date
    - name: "Epa City Mpg"
      expr: epa_city_mpg
    - name: "Epa Combined Mpg"
      expr: epa_combined_mpg
    - name: "Epa Highway Mpg"
      expr: epa_highway_mpg
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Horsepower"
      expr: horsepower
    - name: "Is Fleet Eligible"
      expr: is_fleet_eligible
    - name: "Is Special Edition"
      expr: is_special_edition
    - name: "Market Segment"
      expr: market_segment
    - name: "Model Year"
      expr: model_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aftersales Trim Level"
      expr: COUNT(DISTINCT aftersales_trim_level_id)
    - name: "Total Battery Capacity Kwh"
      expr: SUM(battery_capacity_kwh)
    - name: "Average Battery Capacity Kwh"
      expr: AVG(battery_capacity_kwh)
    - name: "Total Cargo Volume Cu Ft"
      expr: SUM(cargo_volume_cu_ft)
    - name: "Average Cargo Volume Cu Ft"
      expr: AVG(cargo_volume_cu_ft)
    - name: "Total Engine Displacement Liters"
      expr: SUM(engine_displacement_liters)
    - name: "Average Engine Displacement Liters"
      expr: AVG(engine_displacement_liters)
    - name: "Total Invoice Price"
      expr: SUM(invoice_price)
    - name: "Average Invoice Price"
      expr: AVG(invoice_price)
    - name: "Total Msrp Base Price"
      expr: SUM(msrp_base_price)
    - name: "Average Msrp Base Price"
      expr: AVG(msrp_base_price)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Header business metrics"
  source: "`vibe_automotive_v1`.`product`.`bom_header`"
  dimensions:
    - name: "Adas Level"
      expr: adas_level
    - name: "Alternative Bom Group"
      expr: alternative_bom_group
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Bom Usage"
      expr: bom_usage
    - name: "Change Number"
      expr: change_number
    - name: "Configuration Profile"
      expr: configuration_profile
    - name: "Connectivity Package"
      expr: connectivity_package
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Emissions Standard"
      expr: emissions_standard
    - name: "Engineering Release Date"
      expr: engineering_release_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Header"
      expr: COUNT(DISTINCT bom_header_id)
    - name: "Total Msrp Base Amount"
      expr: SUM(msrp_base_amount)
    - name: "Average Msrp Base Amount"
      expr: AVG(msrp_base_amount)
    - name: "Total Standard Cost Amount"
      expr: SUM(standard_cost_amount)
    - name: "Average Standard Cost Amount"
      expr: AVG(standard_cost_amount)
    - name: "Total Total Assembly Weight Kg"
      expr: SUM(total_assembly_weight_kg)
    - name: "Average Total Assembly Weight Kg"
      expr: AVG(total_assembly_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_catalog_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog Publication business metrics"
  source: "`vibe_automotive_v1`.`product`.`catalog_publication`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By User Name"
      expr: approved_by_user_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Confirmation Flag"
      expr: distribution_confirmation_flag
    - name: "Distribution Confirmation Timestamp"
      expr: distribution_confirmation_timestamp
    - name: "Distribution Method"
      expr: distribution_method
    - name: "Distribution Retry Count"
      expr: distribution_retry_count
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "File Checksum"
      expr: file_checksum
    - name: "File Name"
      expr: file_name
    - name: "Language Code"
      expr: language_code
    - name: "Last Distribution Error"
      expr: last_distribution_error
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Year"
      expr: model_year
    - name: "Nameplate Count"
      expr: nameplate_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog Publication"
      expr: COUNT(DISTINCT catalog_publication_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_catalog_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog Version business metrics"
  source: "`vibe_automotive_v1`.`product`.`catalog_version`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Catalog Type"
      expr: catalog_type
    - name: "Change Summary"
      expr: change_summary
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Current"
      expr: is_current
    - name: "Market Segment"
      expr: market_segment
    - name: "Region Coverage"
      expr: region_coverage
    - name: "Release Notes"
      expr: release_notes
    - name: "Catalog Version Status"
      expr: catalog_version_status
    - name: "Total Models"
      expr: total_models
    - name: "Total Options"
      expr: total_options
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog Version"
      expr: COUNT(DISTINCT catalog_version_id)
    - name: "Total Sku Structure Code"
      expr: SUM(sku_structure_code)
    - name: "Average Sku Structure Code"
      expr: AVG(sku_structure_code)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_market_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market Availability business metrics"
  source: "`vibe_automotive_v1`.`product`.`market_availability`"
  dimensions:
    - name: "Allocation Constraint Flag"
      expr: allocation_constraint_flag
    - name: "Assembly Mode"
      expr: assembly_mode
    - name: "Availability Status"
      expr: availability_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Ordering Code"
      expr: dealer_ordering_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Emissions Standard"
      expr: emissions_standard
    - name: "Ev Battery Warranty Months"
      expr: ev_battery_warranty_months
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fuel Economy Unit"
      expr: fuel_economy_unit
    - name: "Homologation Approval Date"
      expr: homologation_approval_date
    - name: "Homologation Approval Status"
      expr: homologation_approval_status
    - name: "Homologation Certificate Number"
      expr: homologation_certificate_number
    - name: "Homologation Expiry Date"
      expr: homologation_expiry_date
    - name: "Import Duty Classification"
      expr: import_duty_classification
    - name: "Incentive Eligible Flag"
      expr: incentive_eligible_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Market Availability"
      expr: COUNT(DISTINCT market_availability_id)
    - name: "Total Destination Charge Amount"
      expr: SUM(destination_charge_amount)
    - name: "Average Destination Charge Amount"
      expr: AVG(destination_charge_amount)
    - name: "Total Fuel Economy Rating"
      expr: SUM(fuel_economy_rating)
    - name: "Average Fuel Economy Rating"
      expr: AVG(fuel_economy_rating)
    - name: "Total Government Incentive Amount"
      expr: SUM(government_incentive_amount)
    - name: "Average Government Incentive Amount"
      expr: AVG(government_incentive_amount)
    - name: "Total Import Duty Rate Percent"
      expr: SUM(import_duty_rate_percent)
    - name: "Average Import Duty Rate Percent"
      expr: AVG(import_duty_rate_percent)
    - name: "Total Local Content Percent"
      expr: SUM(local_content_percent)
    - name: "Average Local Content Percent"
      expr: AVG(local_content_percent)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_msrp_price_book`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Msrp Price Book business metrics"
  source: "`vibe_automotive_v1`.`product`.`msrp_price_book`"
  dimensions:
    - name: "Approved Date"
      expr: approved_date
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dealer Access Level"
      expr: dealer_access_level
    - name: "Destination Charge Included Flag"
      expr: destination_charge_included_flag
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Code"
      expr: market_code
    - name: "Model Year"
      expr: model_year
    - name: "Price Book Code"
      expr: price_book_code
    - name: "Price Book Name"
      expr: price_book_name
    - name: "Price Book Type"
      expr: price_book_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Msrp Price Book"
      expr: COUNT(DISTINCT msrp_price_book_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_msrp_price_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Msrp Price Entry business metrics"
  source: "`vibe_automotive_v1`.`product`.`msrp_price_entry`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fleet Eligible Flag"
      expr: fleet_eligible_flag
    - name: "Government Eligible Flag"
      expr: government_eligible_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Year"
      expr: model_year
    - name: "Notes"
      expr: notes
    - name: "Price Change Reason"
      expr: price_change_reason
    - name: "Price Protection Flag"
      expr: price_protection_flag
    - name: "Price Status"
      expr: price_status
    - name: "Price Type"
      expr: price_type
    - name: "Promotional Flag"
      expr: promotional_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Msrp Price Entry"
      expr: COUNT(DISTINCT msrp_price_entry_id)
    - name: "Total Advertising Fee Amount"
      expr: SUM(advertising_fee_amount)
    - name: "Average Advertising Fee Amount"
      expr: AVG(advertising_fee_amount)
    - name: "Total Base Msrp Amount"
      expr: SUM(base_msrp_amount)
    - name: "Average Base Msrp Amount"
      expr: AVG(base_msrp_amount)
    - name: "Total Dealer Invoice Amount"
      expr: SUM(dealer_invoice_amount)
    - name: "Average Dealer Invoice Amount"
      expr: AVG(dealer_invoice_amount)
    - name: "Total Destination Charge Amount"
      expr: SUM(destination_charge_amount)
    - name: "Average Destination Charge Amount"
      expr: AVG(destination_charge_amount)
    - name: "Total Employee Pricing Amount"
      expr: SUM(employee_pricing_amount)
    - name: "Average Employee Pricing Amount"
      expr: AVG(employee_pricing_amount)
    - name: "Total Gas Guzzler Tax Amount"
      expr: SUM(gas_guzzler_tax_amount)
    - name: "Average Gas Guzzler Tax Amount"
      expr: AVG(gas_guzzler_tax_amount)
    - name: "Total Holdback Percentage"
      expr: SUM(holdback_percentage)
    - name: "Average Holdback Percentage"
      expr: AVG(holdback_percentage)
    - name: "Total Luxury Tax Amount"
      expr: SUM(luxury_tax_amount)
    - name: "Average Luxury Tax Amount"
      expr: AVG(luxury_tax_amount)
    - name: "Total Prior Msrp Amount"
      expr: SUM(prior_msrp_amount)
    - name: "Average Prior Msrp Amount"
      expr: AVG(prior_msrp_amount)
    - name: "Total Supplier Pricing Amount"
      expr: SUM(supplier_pricing_amount)
    - name: "Average Supplier Pricing Amount"
      expr: AVG(supplier_pricing_amount)
    - name: "Total Total Msrp Amount"
      expr: SUM(total_msrp_amount)
    - name: "Average Total Msrp Amount"
      expr: AVG(total_msrp_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_order_guide`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Guide business metrics"
  source: "`vibe_automotive_v1`.`product`.`order_guide`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Build To Stock Flag"
      expr: build_to_stock_flag
    - name: "Cafe Compliance Flag"
      expr: cafe_compliance_flag
    - name: "Order Guide Code"
      expr: order_guide_code
    - name: "Color Option Count"
      expr: color_option_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Order Guide Description"
      expr: order_guide_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Emissions Standard"
      expr: emissions_standard
    - name: "Fleet Eligible Flag"
      expr: fleet_eligible_flag
    - name: "Homologation Region"
      expr: homologation_region
    - name: "Incentive Program Eligible Flag"
      expr: incentive_program_eligible_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Guide"
      expr: COUNT(DISTINCT order_guide_id)
    - name: "Total Base Msrp Max"
      expr: SUM(base_msrp_max)
    - name: "Average Base Msrp Max"
      expr: AVG(base_msrp_max)
    - name: "Total Base Msrp Min"
      expr: SUM(base_msrp_min)
    - name: "Average Base Msrp Min"
      expr: AVG(base_msrp_min)
    - name: "Total Dealer Invoice Discount Percentage"
      expr: SUM(dealer_invoice_discount_percentage)
    - name: "Average Dealer Invoice Discount Percentage"
      expr: AVG(dealer_invoice_discount_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_package_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Availability business metrics"
  source: "`vibe_automotive_v1`.`product`.`package_availability`"
  dimensions:
    - name: "Availability Status"
      expr: availability_status
    - name: "Launch Date"
      expr: launch_date
    - name: "Launch Date Month"
      expr: DATE_TRUNC('MONTH', launch_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Availability"
      expr: COUNT(DISTINCT package_availability_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_pricing_condition_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing Condition Assignment business metrics"
  source: "`vibe_automotive_v1`.`product`.`pricing_condition_assignment`"
  dimensions:
    - name: "Condition Status"
      expr: condition_status
    - name: "Condition Type"
      expr: condition_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pricing Condition Assignment"
      expr: COUNT(DISTINCT pricing_condition_assignment_id)
    - name: "Total Condition Value"
      expr: SUM(condition_value)
    - name: "Average Condition Value"
      expr: AVG(condition_value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Bom Line business metrics"
  source: "`vibe_automotive_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Bom Line"
      expr: COUNT(DISTINCT product_bom_line_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_product_nameplate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Nameplate business metrics"
  source: "`vibe_automotive_v1`.`product`.`product_nameplate`"
  dimensions:
    - name: "Brand Name"
      expr: brand_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Nameplate Code"
      expr: nameplate_code
    - name: "Nameplate Name"
      expr: nameplate_name
    - name: "Segment"
      expr: segment
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Nameplate"
      expr: COUNT(DISTINCT product_nameplate_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_product_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Segment business metrics"
  source: "`vibe_automotive_v1`.`product`.`product_segment`"
  dimensions:
    - name: "Adas Level Range"
      expr: adas_level_range
    - name: "Annual Sales Volume Target"
      expr: annual_sales_volume_target
    - name: "Body Style Category"
      expr: body_style_category
    - name: "Cafe Fleet Category"
      expr: cafe_fleet_category
    - name: "Cargo Volume Range Cu Ft"
      expr: cargo_volume_range_cu_ft
    - name: "Competitive Set Definition"
      expr: competitive_set_definition
    - name: "Connectivity Capability"
      expr: connectivity_capability
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Emissions Standard Target"
      expr: emissions_standard_target
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Homologation Regions"
      expr: homologation_regions
    - name: "Industry Classification Code"
      expr: industry_classification_code
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Segment"
      expr: COUNT(DISTINCT product_segment_id)
    - name: "Total Market Share Target Pct"
      expr: SUM(market_share_target_pct)
    - name: "Average Market Share Target Pct"
      expr: AVG(market_share_target_pct)
    - name: "Total Price Range Max Usd"
      expr: SUM(price_range_max_usd)
    - name: "Average Price Range Max Usd"
      expr: AVG(price_range_max_usd)
    - name: "Total Price Range Min Usd"
      expr: SUM(price_range_min_usd)
    - name: "Average Price Range Min Usd"
      expr: AVG(price_range_min_usd)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku business metrics"
  source: "`vibe_automotive_v1`.`product`.`sku`"
  dimensions:
    - name: "Adas Level"
      expr: adas_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Curb Weight Lbs"
      expr: curb_weight_lbs
    - name: "Door Count"
      expr: door_count
    - name: "Drivetrain Type"
      expr: drivetrain_type
    - name: "Emission Standard"
      expr: emission_standard
    - name: "Eop Date"
      expr: eop_date
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Gvwr Lbs"
      expr: gvwr_lbs
    - name: "Horsepower"
      expr: horsepower
    - name: "Interior Color Code"
      expr: interior_color_code
    - name: "Interior Material Type"
      expr: interior_material_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Market Destination Code"
      expr: market_destination_code
    - name: "Model Year"
      expr: model_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku"
      expr: COUNT(DISTINCT sku_id)
    - name: "Total Battery Capacity Kwh"
      expr: SUM(battery_capacity_kwh)
    - name: "Average Battery Capacity Kwh"
      expr: AVG(battery_capacity_kwh)
    - name: "Total Cargo Volume Cu Ft"
      expr: SUM(cargo_volume_cu_ft)
    - name: "Average Cargo Volume Cu Ft"
      expr: AVG(cargo_volume_cu_ft)
    - name: "Total Electric Range Miles"
      expr: SUM(electric_range_miles)
    - name: "Average Electric Range Miles"
      expr: AVG(electric_range_miles)
    - name: "Total Engine Displacement Liters"
      expr: SUM(engine_displacement_liters)
    - name: "Average Engine Displacement Liters"
      expr: AVG(engine_displacement_liters)
    - name: "Total Epa City Mpg"
      expr: SUM(epa_city_mpg)
    - name: "Average Epa City Mpg"
      expr: AVG(epa_city_mpg)
    - name: "Total Epa Combined Mpg"
      expr: SUM(epa_combined_mpg)
    - name: "Average Epa Combined Mpg"
      expr: AVG(epa_combined_mpg)
    - name: "Total Epa Highway Mpg"
      expr: SUM(epa_highway_mpg)
    - name: "Average Epa Highway Mpg"
      expr: AVG(epa_highway_mpg)
    - name: "Total Invoice Price Amount"
      expr: SUM(invoice_price_amount)
    - name: "Average Invoice Price Amount"
      expr: AVG(invoice_price_amount)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
    - name: "Total Wheelbase Inches"
      expr: SUM(wheelbase_inches)
    - name: "Average Wheelbase Inches"
      expr: AVG(wheelbase_inches)
$$;