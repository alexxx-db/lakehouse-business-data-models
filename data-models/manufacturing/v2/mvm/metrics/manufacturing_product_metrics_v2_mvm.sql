-- Metric views for domain: product | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:43:00

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Header business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`bom_header`"
  dimensions:
    - name: "Alternative Bom Indicator"
      expr: alternative_bom_indicator
    - name: "Approval Date"
      expr: approval_date
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bom Category"
      expr: bom_category
    - name: "Bom Description"
      expr: bom_description
    - name: "Bom Number"
      expr: bom_number
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Bom Usage"
      expr: bom_usage
    - name: "Configuration Profile"
      expr: configuration_profile
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Engineering Change Notice Number"
      expr: engineering_change_notice_number
    - name: "Engineering Change Order Number"
      expr: engineering_change_order_number
    - name: "Environmental Compliance Flag"
      expr: environmental_compliance_flag
    - name: "Erp System Code"
      expr: erp_system_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Header"
      expr: COUNT(DISTINCT bom_header_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
    - name: "Total Lot Size"
      expr: SUM(lot_size)
    - name: "Average Lot Size"
      expr: AVG(lot_size)
$$;

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
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`certification`"
  dimensions:
    - name: "Applicable Markets"
      expr: applicable_markets
    - name: "Applicable Standards"
      expr: applicable_standards
    - name: "Audit Date"
      expr: audit_date
    - name: "Certificate Document Url"
      expr: certificate_document_url
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Certifying Body"
      expr: certifying_body
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cybersecurity Certification"
      expr: cybersecurity_certification
    - name: "Declaration Of Conformity Number"
      expr: declaration_of_conformity_number
    - name: "Eccn Code"
      expr: eccn_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Energy Efficiency Rating"
      expr: energy_efficiency_rating
    - name: "Environmental Certification"
      expr: environmental_certification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification"
      expr: COUNT(DISTINCT certification_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
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
    - name: "Total Mean Time Between Failures"
      expr: SUM(mean_time_between_failures)
    - name: "Average Mean Time Between Failures"
      expr: AVG(mean_time_between_failures)
    - name: "Total Mean Time To Repair"
      expr: SUM(mean_time_to_repair)
    - name: "Average Mean Time To Repair"
      expr: AVG(mean_time_to_repair)
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
    - name: "Lifecycle Decision Rationale"
      expr: lifecycle_decision_rationale
    - name: "Lifecycle Review Date"
      expr: lifecycle_review_date
    - name: "Manufacturing Discontinuation Date"
      expr: manufacturing_discontinuation_date
    - name: "Market Demand Trend"
      expr: market_demand_trend
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lifecycle Stage"
      expr: COUNT(DISTINCT lifecycle_stage_id)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Bom Line business metrics"
  source: "`vibe_manufacturing_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "Alternative Item Group"
      expr: alternative_item_group
    - name: "Alternative Item Priority"
      expr: alternative_item_priority
    - name: "Assembly Level"
      expr: assembly_level
    - name: "Backflush Indicator"
      expr: backflush_indicator
    - name: "Bulk Material Indicator"
      expr: bulk_material_indicator
    - name: "Change Number"
      expr: change_number
    - name: "Component Origin"
      expr: component_origin
    - name: "Cost Relevance Indicator"
      expr: cost_relevance_indicator
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Component Flag"
      expr: critical_component_flag
    - name: "Ecn Number"
      expr: ecn_number
    - name: "Eco Number"
      expr: eco_number
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fixed Quantity Indicator"
      expr: fixed_quantity_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Bom Line"
      expr: COUNT(DISTINCT product_bom_line_id)
    - name: "Total Component Height Mm"
      expr: SUM(component_height_mm)
    - name: "Average Component Height Mm"
      expr: AVG(component_height_mm)
    - name: "Total Component Length Mm"
      expr: SUM(component_length_mm)
    - name: "Average Component Length Mm"
      expr: AVG(component_length_mm)
    - name: "Total Component Weight Kg"
      expr: SUM(component_weight_kg)
    - name: "Average Component Weight Kg"
      expr: AVG(component_weight_kg)
    - name: "Total Component Width Mm"
      expr: SUM(component_width_mm)
    - name: "Average Component Width Mm"
      expr: AVG(component_width_mm)
    - name: "Total Quantity Per Assembly"
      expr: SUM(quantity_per_assembly)
    - name: "Average Quantity Per Assembly"
      expr: AVG(quantity_per_assembly)
    - name: "Total Scrap Factor Percent"
      expr: SUM(scrap_factor_percent)
    - name: "Average Scrap Factor Percent"
      expr: AVG(scrap_factor_percent)
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
    - name: "Humidity Rating Percent"
      expr: humidity_rating_percent
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
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
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
    - name: "Cost Currency"
      expr: cost_currency
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
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku Master"
      expr: COUNT(DISTINCT sku_master_id)
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