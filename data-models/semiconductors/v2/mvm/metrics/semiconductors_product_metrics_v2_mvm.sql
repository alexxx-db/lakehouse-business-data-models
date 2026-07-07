-- Metric views for domain: product | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`bom`"
  dimensions:
    - name: "Alternative Bom Indicator"
      expr: alternative_bom_indicator
    - name: "Approval Date"
      expr: approval_date
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Conflict Minerals Compliant Flag"
      expr: conflict_minerals_compliant_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Material Flag"
      expr: critical_material_flag
    - name: "Ear Classification"
      expr: ear_classification
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Engineering Change Order Number"
      expr: engineering_change_order_number
    - name: "Eol Date"
      expr: eol_date
    - name: "Explosion Type"
      expr: explosion_type
    - name: "External Bom Reference"
      expr: external_bom_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom"
      expr: COUNT(DISTINCT bom_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
    - name: "Total Lot Size"
      expr: SUM(lot_size)
    - name: "Average Lot Size"
      expr: AVG(lot_size)
    - name: "Total Scrap Percentage"
      expr: SUM(scrap_percentage)
    - name: "Average Scrap Percentage"
      expr: AVG(scrap_percentage)
    - name: "Total Total Material Cost"
      expr: SUM(total_material_cost)
    - name: "Average Total Material Cost"
      expr: AVG(total_material_cost)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Line business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`bom_line`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Approved Substitute Part Numbers"
      expr: approved_substitute_part_numbers
    - name: "Assembly Process Code"
      expr: assembly_process_code
    - name: "Bom Level"
      expr: bom_level
    - name: "Bom Line Status"
      expr: bom_line_status
    - name: "Component Description"
      expr: component_description
    - name: "Component Part Number"
      expr: component_part_number
    - name: "Component Type"
      expr: component_type
    - name: "Conflict Minerals Status"
      expr: conflict_minerals_status
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Component Flag"
      expr: critical_component_flag
    - name: "Ear Eccn Code"
      expr: ear_eccn_code
    - name: "Effectivity End Date"
      expr: effectivity_end_date
    - name: "Effectivity Start Date"
      expr: effectivity_start_date
    - name: "Engineering Change Order Number"
      expr: engineering_change_order_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Line"
      expr: COUNT(DISTINCT bom_line_id)
    - name: "Total Quantity Per Assembly"
      expr: SUM(quantity_per_assembly)
    - name: "Average Quantity Per Assembly"
      expr: AVG(quantity_per_assembly)
    - name: "Total Scrap Factor Percent"
      expr: SUM(scrap_factor_percent)
    - name: "Average Scrap Factor Percent"
      expr: AVG(scrap_factor_percent)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_compliance_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance Cert business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`compliance_cert`"
  dimensions:
    - name: "Applicable Markets"
      expr: applicable_markets
    - name: "Applicable Regions"
      expr: applicable_regions
    - name: "Auditor Name"
      expr: auditor_name
    - name: "Automotive Grade Certified"
      expr: automotive_grade_certified
    - name: "Certification Body"
      expr: certification_body
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Scope"
      expr: certification_scope
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Cert Status"
      expr: compliance_cert_status
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Conflict Minerals Declaration"
      expr: conflict_minerals_declaration
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Specific Requirement"
      expr: customer_specific_requirement
    - name: "Ear Controlled"
      expr: ear_controlled
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Compliance Cert"
      expr: COUNT(DISTINCT compliance_cert_id)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Family business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`family`"
  dimensions:
    - name: "Active Pcn Count"
      expr: active_pcn_count
    - name: "Application Domain"
      expr: application_domain
    - name: "Business Unit"
      expr: business_unit
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Center Location"
      expr: design_center_location
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Ear Eccn Code"
      expr: ear_eccn_code
    - name: "Eda Tool Suite"
      expr: eda_tool_suite
    - name: "Eol Announcement Date"
      expr: eol_announcement_date
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Family Status"
      expr: family_status
    - name: "Family Type"
      expr: family_type
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Ip Core Count"
      expr: ip_core_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Family"
      expr: COUNT(DISTINCT family_id)
    - name: "Total Dfm Score"
      expr: SUM(dfm_score)
    - name: "Average Dfm Score"
      expr: AVG(dfm_score)
    - name: "Total Dft Coverage Percent"
      expr: SUM(dft_coverage_percent)
    - name: "Average Dft Coverage Percent"
      expr: AVG(dft_coverage_percent)
    - name: "Total Target Power Mw"
      expr: SUM(target_power_mw)
    - name: "Average Target Power Mw"
      expr: AVG(target_power_mw)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
    - name: "Total Typical Die Size Mm2"
      expr: SUM(typical_die_size_mm2)
    - name: "Average Typical Die Size Mm2"
      expr: AVG(typical_die_size_mm2)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ic_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ic Catalog business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`ic_catalog`"
  dimensions:
    - name: "Aec Qualification Level"
      expr: aec_qualification_level
    - name: "Automotive Qualified"
      expr: automotive_qualified
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Type"
      expr: design_type
    - name: "Ear Eccn Code"
      expr: ear_eccn_code
    - name: "Eol Announcement Date"
      expr: eol_announcement_date
    - name: "External Part Number"
      expr: external_part_number
    - name: "First Silicon Date"
      expr: first_silicon_date
    - name: "Hts Code"
      expr: hts_code
    - name: "Ic Catalog Status"
      expr: ic_catalog_status
    - name: "Internal Part Number"
      expr: internal_part_number
    - name: "Is Active"
      expr: is_active
    - name: "Itar Controlled"
      expr: itar_controlled
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Ship Date"
      expr: last_ship_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ic Catalog"
      expr: COUNT(DISTINCT ic_catalog_id)
    - name: "Total Catalog To Family"
      expr: SUM(catalog_to_family)
    - name: "Average Catalog To Family"
      expr: AVG(catalog_to_family)
    - name: "Total Die Size Mm2"
      expr: SUM(die_size_mm2)
    - name: "Average Die Size Mm2"
      expr: AVG(die_size_mm2)
    - name: "Total Operating Frequency Max Mhz"
      expr: SUM(operating_frequency_max_mhz)
    - name: "Average Operating Frequency Max Mhz"
      expr: AVG(operating_frequency_max_mhz)
    - name: "Total Operating Voltage Max V"
      expr: SUM(operating_voltage_max_v)
    - name: "Average Operating Voltage Max V"
      expr: AVG(operating_voltage_max_v)
    - name: "Total Operating Voltage Min V"
      expr: SUM(operating_voltage_min_v)
    - name: "Average Operating Voltage Min V"
      expr: AVG(operating_voltage_min_v)
    - name: "Total Power Max Mw"
      expr: SUM(power_max_mw)
    - name: "Average Power Max Mw"
      expr: AVG(power_max_mw)
    - name: "Total Power Typical Mw"
      expr: SUM(power_typical_mw)
    - name: "Average Power Typical Mw"
      expr: AVG(power_typical_mw)
    - name: "Total Transistor Count"
      expr: SUM(transistor_count)
    - name: "Average Transistor Count"
      expr: AVG(transistor_count)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_process_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Node business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`process_node`"
  dimensions:
    - name: "Active Product Count"
      expr: active_product_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Rule Complexity"
      expr: design_rule_complexity
    - name: "Environmental Compliance Status"
      expr: environmental_compliance_status
    - name: "Eol Announcement Date"
      expr: eol_announcement_date
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Foundry Source"
      expr: foundry_source
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Stage"
      expr: lifecycle_stage
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Ltb Deadline Date"
      expr: ltb_deadline_date
    - name: "Metal Layer Count"
      expr: metal_layer_count
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Multi Patterning Layers"
      expr: multi_patterning_layers
    - name: "Node Code"
      expr: node_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Node"
      expr: COUNT(DISTINCT process_node_id)
    - name: "Total Baseline Yield Percent"
      expr: SUM(baseline_yield_percent)
    - name: "Average Baseline Yield Percent"
      expr: AVG(baseline_yield_percent)
    - name: "Total Cost Per Wafer Usd"
      expr: SUM(cost_per_wafer_usd)
    - name: "Average Cost Per Wafer Usd"
      expr: AVG(cost_per_wafer_usd)
    - name: "Total Cycle Time Days"
      expr: SUM(cycle_time_days)
    - name: "Average Cycle Time Days"
      expr: AVG(cycle_time_days)
    - name: "Total Minimum Feature Size Nm"
      expr: SUM(minimum_feature_size_nm)
    - name: "Average Minimum Feature Size Nm"
      expr: AVG(minimum_feature_size_nm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_product_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Spec business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`product_spec`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Automotive Grade"
      expr: automotive_grade
    - name: "Characterization Date"
      expr: characterization_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Years"
      expr: data_retention_years
    - name: "Functional Safety Rating"
      expr: functional_safety_rating
    - name: "Interface Protocols"
      expr: interface_protocols
    - name: "Io Count"
      expr: io_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Memory Configuration"
      expr: memory_configuration
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Operating Condition Corner"
      expr: operating_condition_corner
    - name: "Product Spec Status"
      expr: product_spec_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Spec"
      expr: COUNT(DISTINCT product_spec_id)
    - name: "Total Die Area Achieved Mm2"
      expr: SUM(die_area_achieved_mm2)
    - name: "Average Die Area Achieved Mm2"
      expr: AVG(die_area_achieved_mm2)
    - name: "Total Die Area Target Mm2"
      expr: SUM(die_area_target_mm2)
    - name: "Average Die Area Target Mm2"
      expr: AVG(die_area_target_mm2)
    - name: "Total Dynamic Power Achieved Mw"
      expr: SUM(dynamic_power_achieved_mw)
    - name: "Average Dynamic Power Achieved Mw"
      expr: AVG(dynamic_power_achieved_mw)
    - name: "Total Dynamic Power Target Mw"
      expr: SUM(dynamic_power_target_mw)
    - name: "Average Dynamic Power Target Mw"
      expr: AVG(dynamic_power_target_mw)
    - name: "Total Endurance Cycles"
      expr: SUM(endurance_cycles)
    - name: "Average Endurance Cycles"
      expr: AVG(endurance_cycles)
    - name: "Total Esd Protection Level Kv"
      expr: SUM(esd_protection_level_kv)
    - name: "Average Esd Protection Level Kv"
      expr: AVG(esd_protection_level_kv)
    - name: "Total Gate Count"
      expr: SUM(gate_count)
    - name: "Average Gate Count"
      expr: AVG(gate_count)
    - name: "Total Leakage Power Achieved Mw"
      expr: SUM(leakage_power_achieved_mw)
    - name: "Average Leakage Power Achieved Mw"
      expr: AVG(leakage_power_achieved_mw)
    - name: "Total Leakage Power Target Mw"
      expr: SUM(leakage_power_target_mw)
    - name: "Average Leakage Power Target Mw"
      expr: AVG(leakage_power_target_mw)
    - name: "Total Max Frequency Achieved Mhz"
      expr: SUM(max_frequency_achieved_mhz)
    - name: "Average Max Frequency Achieved Mhz"
      expr: AVG(max_frequency_achieved_mhz)
    - name: "Total Max Frequency Target Mhz"
      expr: SUM(max_frequency_target_mhz)
    - name: "Average Max Frequency Target Mhz"
      expr: AVG(max_frequency_target_mhz)
    - name: "Total Operating Temperature Max C"
      expr: SUM(operating_temperature_max_c)
    - name: "Average Operating Temperature Max C"
      expr: AVG(operating_temperature_max_c)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku business metrics"
  source: "`vibe_semiconductors_v1`.`product`.`sku`"
  dimensions:
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Part Number"
      expr: customer_part_number
    - name: "Eccn Code"
      expr: eccn_code
    - name: "Eol Announcement Date"
      expr: eol_announcement_date
    - name: "Halogen Free"
      expr: halogen_free
    - name: "Hts Code"
      expr: hts_code
    - name: "Introduction Date"
      expr: introduction_date
    - name: "Itar Controlled"
      expr: itar_controlled
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Ship Date"
      expr: last_ship_date
    - name: "Last Time Buy Date"
      expr: last_time_buy_date
    - name: "Lead Time Weeks"
      expr: lead_time_weeks
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku"
      expr: COUNT(DISTINCT sku_id)
    - name: "Total List Price Usd"
      expr: SUM(list_price_usd)
    - name: "Average List Price Usd"
      expr: AVG(list_price_usd)
    - name: "Total Standard Cost Usd"
      expr: SUM(standard_cost_usd)
    - name: "Average Standard Cost Usd"
      expr: AVG(standard_cost_usd)
    - name: "Total Unit Weight Grams"
      expr: SUM(unit_weight_grams)
    - name: "Average Unit Weight Grams"
      expr: AVG(unit_weight_grams)
$$;