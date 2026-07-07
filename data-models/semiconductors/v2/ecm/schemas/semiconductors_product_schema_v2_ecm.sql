-- Schema for Domain: product | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`product` COMMENT 'Authoritative semiconductor product catalog encompassing ICs, SoCs, ASICs, FPGAs, IP cores, and discrete devices. SSOT for product specifications, SKUs, BOM, process node assignments, PPA metrics, product lifecycle status (NPI through EOL), PCN management, and LTB notifications. Integrates with PLM systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` (
    `ic_catalog_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - products are manufactured on specific technology nodes',
    `family_id` BIGINT COMMENT 'FK to product family',
    `process_node_id` BIGINT COMMENT 'FK to process node',
    `employee_id` BIGINT COMMENT 'FK to product manager employee',
    `eccn_classification_id` BIGINT COMMENT 'FK to compliance ECCN classification',
    `package_type_id` BIGINT COMMENT 'FK to packaging package type',
    `aec_qualification_level` STRING COMMENT 'The aec qualification level of the ic catalog record in the product domain.',
    `automotive_qualified` BOOLEAN COMMENT 'Whether product is automotive qualified',
    `catalog_to_family` BIGINT COMMENT 'Catalog to family mapping',
    `country_of_origin` STRING COMMENT 'The country of origin of the ic catalog record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `design_type` STRING COMMENT 'Design type classification',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'Die size in square millimeters',
    `ear_eccn_code` STRING COMMENT 'EAR ECCN export control code',
    `eol_announcement_date` DATE COMMENT 'End of life announcement date',
    `external_part_number` STRING COMMENT 'The external part number of the ic catalog record in the product domain.',
    `first_silicon_date` DATE COMMENT 'The first silicon date associated with the ic catalog product record.',
    `hts_code` STRING COMMENT 'Harmonized tariff schedule code',
    `internal_part_number` STRING COMMENT 'The internal part number of the ic catalog record in the product domain.',
    `is_active` BOOLEAN COMMENT 'Whether product is active',
    `itar_controlled` BOOLEAN COMMENT 'ITAR controlled flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the ic catalog record in the product domain.',
    `last_ship_date` DATE COMMENT 'The last ship date associated with the ic catalog product record.',
    `last_time_buy_date` DATE COMMENT 'The last time buy date associated with the ic catalog product record.',
    `lead_free_compliant` BOOLEAN COMMENT 'Lead free compliance flag',
    `lifecycle_status` STRING COMMENT 'Product lifecycle status',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the ic catalog record in the product domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record modification timestamp',
    `notes` STRING COMMENT 'The notes of the ic catalog record in the product domain.',
    `npi_phase` STRING COMMENT 'New product introduction phase',
    `operating_frequency_max_mhz` DECIMAL(18,2) COMMENT 'Maximum operating frequency in MHz',
    `operating_voltage_max_v` DECIMAL(18,2) COMMENT 'Maximum operating voltage',
    `operating_voltage_min_v` DECIMAL(18,2) COMMENT 'Minimum operating voltage',
    `pin_count` STRING COMMENT 'The pin count of the ic catalog record in the product domain.',
    `power_max_mw` DECIMAL(18,2) COMMENT 'Maximum power in milliwatts',
    `power_typical_mw` DECIMAL(18,2) COMMENT 'Typical power in milliwatts',
    `process_technology` STRING COMMENT 'The process technology of the ic catalog record in the product domain.',
    `product_name` STRING COMMENT 'The product name of the ic catalog record in the product domain.',
    `product_type` STRING COMMENT 'Product type classification',
    `production_release_date` DATE COMMENT 'The production release date associated with the ic catalog product record.',
    `reach_compliant` BOOLEAN COMMENT 'REACH compliance flag',
    `rohs_compliant` BOOLEAN COMMENT 'RoHS compliance flag',
    `rtl_language` STRING COMMENT 'RTL language used',
    `ic_catalog_status` STRING COMMENT 'The status of the ic catalog record in the product domain.',
    `tapeout_date` DATE COMMENT 'The tapeout date associated with the ic catalog product record.',
    `target_market` STRING COMMENT 'Target market segment',
    `temperature_grade` STRING COMMENT 'The temperature grade of the ic catalog record in the product domain.',
    `transistor_count` BIGINT COMMENT 'The transistor count of the ic catalog record in the product domain.',
    CONSTRAINT pk_ic_catalog PRIMARY KEY(`ic_catalog_id`)
) COMMENT 'Master catalog of all IC products with lifecycle, compliance, and technical specifications. Authoritative source for product identity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key',
    `package_type_id` BIGINT COMMENT 'FK to package type',
    `replacement_sku_id` BIGINT COMMENT 'FK to replacement SKU',
    `employee_id` BIGINT COMMENT 'FK to sales owner',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `sku_code` STRING COMMENT 'Coded value representing the code of the sku product record.',
    `country_of_origin` STRING COMMENT 'The country of origin of the sku record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `customer_part_number` STRING COMMENT 'The customer part number of the sku record in the product domain.',
    `eccn_code` STRING COMMENT 'Coded value representing the eccn code of the sku product record.',
    `eol_announcement_date` DATE COMMENT 'The eol announcement date associated with the sku product record.',
    `halogen_free` BOOLEAN COMMENT 'Halogen free flag',
    `hts_code` STRING COMMENT 'Coded value representing the hts code of the sku product record.',
    `introduction_date` DATE COMMENT 'The introduction date associated with the sku product record.',
    `itar_controlled` BOOLEAN COMMENT 'ITAR controlled flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the sku record in the product domain.',
    `last_ship_date` DATE COMMENT 'The last ship date associated with the sku product record.',
    `last_time_buy_date` DATE COMMENT 'The last time buy date associated with the sku product record.',
    `lead_time_weeks` STRING COMMENT 'Lead time in weeks',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the sku record in the product domain.',
    `list_price_usd` DECIMAL(18,2) COMMENT 'List price in USD',
    `manufacturer_part_number` STRING COMMENT 'The manufacturer part number of the sku record in the product domain.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity of the sku record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the sku record in the product domain.',
    `moisture_sensitivity_level` STRING COMMENT 'The moisture sensitivity level of the sku record in the product domain.',
    `notes` STRING COMMENT 'The notes of the sku record in the product domain.',
    `orderable_flag` BOOLEAN COMMENT 'Whether SKU is orderable',
    `pcn_required_flag` BOOLEAN COMMENT 'The pcn required flag of the sku record in the product domain.',
    `pin_count` STRING COMMENT 'The pin count of the sku record in the product domain.',
    `qualification_level` STRING COMMENT 'The qualification level of the sku record in the product domain.',
    `reach_compliant` BOOLEAN COMMENT 'REACH compliant flag',
    `rohs_compliant` BOOLEAN COMMENT 'RoHS compliant flag',
    `shippable_flag` BOOLEAN COMMENT 'Whether SKU is shippable',
    `speed_grade` STRING COMMENT 'The speed grade of the sku record in the product domain.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Standard cost in USD',
    `standard_pack_quantity` STRING COMMENT 'The standard pack quantity of the sku record in the product domain.',
    `sku_status` STRING COMMENT 'The status of the sku record in the product domain.',
    `temperature_range` STRING COMMENT 'The temperature range of the sku record in the product domain.',
    `unit_weight_grams` DECIMAL(18,2) COMMENT 'Unit weight in grams',
    `voltage_variant` STRING COMMENT 'The voltage variant of the sku record in the product domain.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock-keeping unit representing an orderable, shippable product variant with pricing, compliance, and logistics attributes.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to manager',
    `parent_family_id` BIGINT COMMENT 'FK to parent family',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `active_pcn_count` STRING COMMENT 'The active pcn count of the family record in the product domain.',
    `application_domain` STRING COMMENT 'The application domain of the family record in the product domain.',
    `business_unit` STRING COMMENT 'The business unit of the family record in the product domain.',
    `family_code` STRING COMMENT 'Family code',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the family record in the product domain.',
    `family_description` STRING COMMENT 'Family description',
    `design_center_location` STRING COMMENT 'The design center location of the family record in the product domain.',
    `dfm_score` DECIMAL(18,2) COMMENT 'The dfm score of the family record in the product domain.',
    `dft_coverage_percent` DECIMAL(18,2) COMMENT 'The dft coverage percent of the family record in the product domain.',
    `discontinuation_date` DATE COMMENT 'The discontinuation date associated with the family product record.',
    `ear_eccn_code` STRING COMMENT 'Coded value representing the ear eccn code of the family product record.',
    `eda_tool_suite` STRING COMMENT 'The eda tool suite of the family record in the product domain.',
    `eol_announcement_date` DATE COMMENT 'The eol announcement date associated with the family product record.',
    `fab_site_code` STRING COMMENT 'Coded value representing the fab site code of the family product record.',
    `hierarchy_level` STRING COMMENT 'The hierarchy level of the family record in the product domain.',
    `ip_core_count` STRING COMMENT 'The ip core count of the family record in the product domain.',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the family record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the family record in the product domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the family record in the product domain.',
    `lithography_type` STRING COMMENT 'The lithography type of the family record in the product domain.',
    `ltb_date` DATE COMMENT 'The ltb date associated with the family product record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the family record in the product domain.',
    `modified_by_user` STRING COMMENT 'The modified by user of the family record in the product domain.',
    `family_name` STRING COMMENT 'Family name',
    `notes` STRING COMMENT 'The notes of the family record in the product domain.',
    `npi_start_date` DATE COMMENT 'The npi start date associated with the family product record.',
    `osat_partner` STRING COMMENT 'The osat partner of the family record in the product domain.',
    `package_type` STRING COMMENT 'The package type of the family record in the product domain.',
    `pdk_version` STRING COMMENT 'The pdk version of the family record in the product domain.',
    `process_node_nm` STRING COMMENT 'Process node in nm',
    `process_technology` STRING COMMENT 'The process technology of the family record in the product domain.',
    `product_line_manager` STRING COMMENT 'The product line manager of the family record in the product domain.',
    `qualification_standard` STRING COMMENT 'The qualification standard of the family record in the product domain.',
    `reach_compliant_flag` BOOLEAN COMMENT 'The reach compliant flag of the family record in the product domain.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'The rohs compliant flag of the family record in the product domain.',
    `family_status` STRING COMMENT 'The status of the family record in the product domain.',
    `target_market_segment` STRING COMMENT 'The target market segment of the family record in the product domain.',
    `target_performance_metric` STRING COMMENT 'The target performance metric of the family record in the product domain.',
    `target_power_mw` DECIMAL(18,2) COMMENT 'Target power in mW',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'The target yield percent of the family record in the product domain.',
    `family_type` STRING COMMENT 'Family type',
    `typical_die_size_mm2` DECIMAL(18,2) COMMENT 'Typical die size in mm2',
    `volume_production_date` DATE COMMENT 'The volume production date associated with the family product record.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Product family grouping related IC products by architecture, process node, and market segment for portfolio management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`process_node` (
    `process_node_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to process owner',
    `active_product_count` STRING COMMENT 'The active product count of the process node record in the product domain.',
    `baseline_yield_percent` DECIMAL(18,2) COMMENT 'The baseline yield percent of the process node record in the product domain.',
    `cost_per_wafer_usd` DECIMAL(18,2) COMMENT 'Cost per wafer in USD',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the process node record in the product domain.',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Cycle time in days',
    `design_rule_complexity` STRING COMMENT 'The design rule complexity of the process node record in the product domain.',
    `environmental_compliance_status` STRING COMMENT 'The environmental compliance status of the process node record in the product domain.',
    `eol_announcement_date` DATE COMMENT 'The eol announcement date associated with the process node product record.',
    `export_control_classification` STRING COMMENT 'The export control classification of the process node record in the product domain.',
    `foundry_source` STRING COMMENT 'The foundry source of the process node record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the process node record in the product domain.',
    `lifecycle_stage` STRING COMMENT 'The lifecycle stage of the process node record in the product domain.',
    `lithography_type` STRING COMMENT 'The lithography type of the process node record in the product domain.',
    `ltb_deadline_date` DATE COMMENT 'The ltb deadline date associated with the process node product record.',
    `metal_layer_count` STRING COMMENT 'The metal layer count of the process node record in the product domain.',
    `minimum_feature_size_nm` DECIMAL(18,2) COMMENT 'Minimum feature size in nm',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the process node record in the product domain.',
    `modified_by_user` STRING COMMENT 'The modified by user of the process node record in the product domain.',
    `multi_patterning_layers` STRING COMMENT 'The multi patterning layers of the process node record in the product domain.',
    `node_code` STRING COMMENT 'Coded value representing the node code of the process node product record.',
    `node_generation` STRING COMMENT 'The node generation of the process node record in the product domain.',
    `node_name` STRING COMMENT 'The node name of the process node record in the product domain.',
    `notes` STRING COMMENT 'The notes of the process node record in the product domain.',
    `opc_required_flag` BOOLEAN COMMENT 'The opc required flag of the process node record in the product domain.',
    `pdk_release_date` DATE COMMENT 'The pdk release date associated with the process node product record.',
    `pdk_version` STRING COMMENT 'The pdk version of the process node record in the product domain.',
    `power_performance_area_rating` STRING COMMENT 'PPA rating',
    `qualification_date` DATE COMMENT 'The qualification date associated with the process node product record.',
    `qualification_status` STRING COMMENT 'The qualification status of the process node record in the product domain.',
    `process_node_status` STRING COMMENT 'The status of the process node record in the product domain.',
    `supported_device_types` STRING COMMENT 'The supported device types of the process node record in the product domain.',
    `technology_readiness_level` STRING COMMENT 'The technology readiness level of the process node record in the product domain.',
    `transistor_architecture` STRING COMMENT 'The transistor architecture of the process node record in the product domain.',
    `wafer_size_mm` STRING COMMENT 'Wafer size in mm',
    CONSTRAINT pk_process_node PRIMARY KEY(`process_node_id`)
) COMMENT 'Semiconductor process technology node definition with lithography, architecture, and qualification parameters.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_spec` (
    `product_spec_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `employee_id` BIGINT COMMENT 'FK to owner employee',
    `primary_product_ic_catalog_id` BIGINT COMMENT 'FK to product IC catalog',
    `primary_ic_catalog_id` BIGINT COMMENT 'Unique identifier for the primary ic catalog record within the product spec product entity.',
    `approval_date` DATE COMMENT 'The approval date associated with the product spec product record.',
    `approved_by` STRING COMMENT 'The approved by of the product spec record in the product domain.',
    `automotive_grade` STRING COMMENT 'The automotive grade of the product spec record in the product domain.',
    `characterization_date` DATE COMMENT 'The characterization date associated with the product spec product record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product spec record in the product domain.',
    `data_retention_years` STRING COMMENT 'The data retention years of the product spec record in the product domain.',
    `die_area_achieved_mm2` DECIMAL(18,2) COMMENT 'Die area achieved',
    `die_area_target_mm2` DECIMAL(18,2) COMMENT 'Die area target',
    `dynamic_power_achieved_mw` DECIMAL(18,2) COMMENT 'Dynamic power achieved',
    `dynamic_power_target_mw` DECIMAL(18,2) COMMENT 'Dynamic power target',
    `endurance_cycles` BIGINT COMMENT 'The endurance cycles of the product spec record in the product domain.',
    `esd_protection_level_kv` DECIMAL(18,2) COMMENT 'ESD protection level',
    `functional_safety_rating` STRING COMMENT 'The functional safety rating of the product spec record in the product domain.',
    `gate_count` BIGINT COMMENT 'The gate count of the product spec record in the product domain.',
    `interface_protocols` STRING COMMENT 'The interface protocols of the product spec record in the product domain.',
    `io_count` STRING COMMENT 'The io count of the product spec record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product spec record in the product domain.',
    `leakage_power_achieved_mw` DECIMAL(18,2) COMMENT 'Leakage power achieved',
    `leakage_power_target_mw` DECIMAL(18,2) COMMENT 'Leakage power target',
    `max_frequency_achieved_mhz` DECIMAL(18,2) COMMENT 'Max frequency achieved',
    `max_frequency_target_mhz` DECIMAL(18,2) COMMENT 'Max frequency target',
    `memory_configuration` STRING COMMENT 'The memory configuration of the product spec record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the product spec record in the product domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the product spec record in the product domain.',
    `notes` STRING COMMENT 'The notes of the product spec record in the product domain.',
    `operating_condition_corner` STRING COMMENT 'The operating condition corner of the product spec record in the product domain.',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'Max operating temperature',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'Min operating temperature',
    `operating_voltage_max_v` DECIMAL(18,2) COMMENT 'Max operating voltage',
    `operating_voltage_min_v` DECIMAL(18,2) COMMENT 'Min operating voltage',
    `operating_voltage_nominal_v` DECIMAL(18,2) COMMENT 'Nominal operating voltage',
    `package_type` STRING COMMENT 'The package type of the product spec record in the product domain.',
    `process_node_nm` STRING COMMENT 'Process node in nm',
    `reach_compliant` BOOLEAN COMMENT 'The reach compliant of the product spec record in the product domain.',
    `rohs_compliant` BOOLEAN COMMENT 'The rohs compliant of the product spec record in the product domain.',
    `security_features` STRING COMMENT 'The security features of the product spec record in the product domain.',
    `spec_status` STRING COMMENT 'The spec status of the product spec record in the product domain.',
    `product_spec_status` STRING COMMENT 'The status of the product spec record in the product domain.',
    `transistor_architecture` STRING COMMENT 'The transistor architecture of the product spec record in the product domain.',
    `transistor_count` BIGINT COMMENT 'The transistor count of the product spec record in the product domain.',
    `version` STRING COMMENT 'Version or revision identifier of the product spec product record.',
    CONSTRAINT pk_product_spec PRIMARY KEY(`product_spec_id`)
) COMMENT 'Detailed product specification covering electrical, thermal, and mechanical parameters with target vs achieved metrics.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`bom` (
    `bom_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `internal_order_id` BIGINT COMMENT 'FK to internal order',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `alternative_bom_indicator` STRING COMMENT 'The alternative bom indicator of the bom record in the product domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the bom product record.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The base quantity of the bom record in the product domain.',
    `base_unit_of_measure` STRING COMMENT 'The base unit of measure of the bom record in the product domain.',
    `conflict_minerals_compliant_flag` BOOLEAN COMMENT 'Conflict minerals compliant',
    `cost_currency_code` STRING COMMENT 'Coded value representing the cost currency code of the bom product record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the bom record in the product domain.',
    `critical_material_flag` BOOLEAN COMMENT 'The critical material flag of the bom record in the product domain.',
    `ear_classification` STRING COMMENT 'The ear classification of the bom record in the product domain.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the bom product record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the bom product record.',
    `engineering_change_order_number` STRING COMMENT 'ECO number',
    `eol_date` DATE COMMENT 'The eol date associated with the bom product record.',
    `explosion_type` STRING COMMENT 'The explosion type of the bom record in the product domain.',
    `external_bom_reference` STRING COMMENT 'The external bom reference of the bom record in the product domain.',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the bom record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the bom record in the product domain.',
    `lot_size` DECIMAL(18,2) COMMENT 'The lot size of the bom record in the product domain.',
    `ltb_notification_date` DATE COMMENT 'The ltb notification date associated with the bom product record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the bom record in the product domain.',
    `notes` STRING COMMENT 'The notes of the bom record in the product domain.',
    `number` STRING COMMENT 'BOM number',
    `pcn_number` STRING COMMENT 'The pcn number of the bom record in the product domain.',
    `plant_code` STRING COMMENT 'Coded value representing the plant code of the bom product record.',
    `production_version` STRING COMMENT 'The production version of the bom record in the product domain.',
    `reach_compliant_flag` BOOLEAN COMMENT 'The reach compliant flag of the bom record in the product domain.',
    `revision` STRING COMMENT 'Version or revision identifier of the bom product record.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'The rohs compliant flag of the bom record in the product domain.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'The scrap percentage of the bom record in the product domain.',
    `bom_status` STRING COMMENT 'BOM status',
    `total_component_count` STRING COMMENT 'The total component count of the bom record in the product domain.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'The total material cost of the bom record in the product domain.',
    `bom_type` STRING COMMENT 'The type of the bom record in the product domain.',
    `usage` STRING COMMENT 'The usage of the bom record in the product domain.',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of materials header defining the component structure for an IC product with compliance and cost tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Primary key',
    `parent_line_bom_line_id` BIGINT COMMENT 'FK to parent line',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `bom_id` BIGINT COMMENT 'Unique identifier for the primary bom record within the bom line product entity.',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `to_bom_id` BIGINT COMMENT 'Unique identifier for the to bom record within the bom line product entity.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the bom line record in the product domain.',
    `approved_substitute_part_numbers` STRING COMMENT 'The approved substitute part numbers of the bom line record in the product domain.',
    `assembly_process_code` STRING COMMENT 'Coded value representing the assembly process code of the bom line product record.',
    `bom_level` STRING COMMENT 'The bom level of the bom line record in the product domain.',
    `component_description` STRING COMMENT 'The component description of the bom line record in the product domain.',
    `component_part_number` STRING COMMENT 'The component part number of the bom line record in the product domain.',
    `component_type` STRING COMMENT 'The component type of the bom line record in the product domain.',
    `conflict_minerals_status` STRING COMMENT 'The conflict minerals status of the bom line record in the product domain.',
    `cost_currency_code` STRING COMMENT 'Coded value representing the cost currency code of the bom line product record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the bom line record in the product domain.',
    `critical_component_flag` BOOLEAN COMMENT 'The critical component flag of the bom line record in the product domain.',
    `ear_eccn_code` STRING COMMENT 'Coded value representing the ear eccn code of the bom line product record.',
    `effectivity_end_date` DATE COMMENT 'The effectivity end date associated with the bom line product record.',
    `effectivity_start_date` DATE COMMENT 'The effectivity start date associated with the bom line product record.',
    `engineering_change_order_number` STRING COMMENT 'ECO number',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the bom line record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the bom line record in the product domain.',
    `line_number` STRING COMMENT 'The line number of the bom line record in the product domain.',
    `make_or_buy_indicator` STRING COMMENT 'The make or buy indicator of the bom line record in the product domain.',
    `manufacturer_name` STRING COMMENT 'The manufacturer name of the bom line record in the product domain.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturer part number of the bom line record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the bom line record in the product domain.',
    `notes` STRING COMMENT 'The notes of the bom line record in the product domain.',
    `phantom_bom_flag` BOOLEAN COMMENT 'The phantom bom flag of the bom line record in the product domain.',
    `procurement_lead_time_days` STRING COMMENT 'The procurement lead time days of the bom line record in the product domain.',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'The quantity per assembly of the bom line record in the product domain.',
    `reach_compliant_flag` BOOLEAN COMMENT 'The reach compliant flag of the bom line record in the product domain.',
    `reference_designator` STRING COMMENT 'The reference designator of the bom line record in the product domain.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'The rohs compliant flag of the bom line record in the product domain.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'The scrap factor percent of the bom line record in the product domain.',
    `single_source_flag` BOOLEAN COMMENT 'The single source flag of the bom line record in the product domain.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard cost of the bom line record in the product domain.',
    `bom_line_status` STRING COMMENT 'The status of the bom line record in the product domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the bom line record in the product domain.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual line item in a bill of materials specifying component, quantity, sourcing, and compliance details.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`pcn` (
    `pcn_id` BIGINT COMMENT 'Primary key',
    `change_notification_id` BIGINT COMMENT 'FK to change notification',
    `employee_id` BIGINT COMMENT 'FK to change owner',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `affected_customer_count` STRING COMMENT 'The affected customer count of the pcn record in the product domain.',
    `affected_product_list` STRING COMMENT 'The affected product list of the pcn record in the product domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the pcn product record.',
    `approved_by_name` STRING COMMENT 'The approved by name of the pcn record in the product domain.',
    `automotive_qualification_required_flag` BOOLEAN COMMENT 'Automotive qualification required',
    `change_category` STRING COMMENT 'The change category of the pcn record in the product domain.',
    `change_description` STRING COMMENT 'The change description of the pcn record in the product domain.',
    `change_owner_email` STRING COMMENT 'The change owner email of the pcn record in the product domain.',
    `change_owner_name` STRING COMMENT 'The change owner name of the pcn record in the product domain.',
    `change_rationale` STRING COMMENT 'The change rationale of the pcn record in the product domain.',
    `change_title` STRING COMMENT 'The change title of the pcn record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the pcn record in the product domain.',
    `customer_approval_count` STRING COMMENT 'The customer approval count of the pcn record in the product domain.',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Customer approval required',
    `customer_objection_count` STRING COMMENT 'The customer objection count of the pcn record in the product domain.',
    `customer_response_deadline` DATE COMMENT 'The customer response deadline of the pcn record in the product domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the pcn product record.',
    `electrical_impact_assessment` STRING COMMENT 'The electrical impact assessment of the pcn record in the product domain.',
    `environmental_compliance_impact` STRING COMMENT 'The environmental compliance impact of the pcn record in the product domain.',
    `form_fit_function_impact` STRING COMMENT 'The form fit function impact of the pcn record in the product domain.',
    `implementation_date` DATE COMMENT 'The implementation date associated with the pcn product record.',
    `jedec_compliance_status` STRING COMMENT 'The jedec compliance status of the pcn record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the pcn record in the product domain.',
    `last_ship_date` DATE COMMENT 'The last ship date associated with the pcn product record.',
    `last_time_buy_date` DATE COMMENT 'The last time buy date associated with the pcn product record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the pcn record in the product domain.',
    `new_specification` STRING COMMENT 'The new specification of the pcn record in the product domain.',
    `notes` STRING COMMENT 'The notes of the pcn record in the product domain.',
    `notification_date` DATE COMMENT 'The notification date associated with the pcn product record.',
    `number` STRING COMMENT 'PCN number',
    `old_specification` STRING COMMENT 'The old specification of the pcn record in the product domain.',
    `qualification_completion_date` DATE COMMENT 'The qualification completion date associated with the pcn product record.',
    `qualification_plan` STRING COMMENT 'The qualification plan of the pcn record in the product domain.',
    `qualification_status` STRING COMMENT 'The qualification status of the pcn record in the product domain.',
    `related_pcn_numbers` STRING COMMENT 'The related pcn numbers of the pcn record in the product domain.',
    `reliability_impact_assessment` STRING COMMENT 'The reliability impact assessment of the pcn record in the product domain.',
    `sample_request_deadline` DATE COMMENT 'The sample request deadline of the pcn record in the product domain.',
    `samples_available_flag` BOOLEAN COMMENT 'The samples available flag of the pcn record in the product domain.',
    `pcn_status` STRING COMMENT 'PCN status',
    `superseded_by_pcn_number` STRING COMMENT 'The superseded by pcn number of the pcn record in the product domain.',
    `pcn_type` STRING COMMENT 'The type of the pcn record in the product domain.',
    CONSTRAINT pk_pcn PRIMARY KEY(`pcn_id`)
) COMMENT 'Product change notification communicating manufacturing or design changes to affected customers with qualification tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` (
    `product_ltb_notification_id` BIGINT COMMENT 'Primary key',
    `customer_ltb_notification_id` BIGINT COMMENT 'FK to customer LTB notification',
    `employee_id` BIGINT COMMENT 'FK to LTB owner',
    `ic_catalog_id` BIGINT COMMENT 'FK to replacement product',
    `actual_ltb_revenue` DECIMAL(18,2) COMMENT 'The actual ltb revenue of the product ltb notification record in the product domain.',
    `actual_ltb_units` STRING COMMENT 'The actual ltb units of the product ltb notification record in the product domain.',
    `approved_by` STRING COMMENT 'The approved by of the product ltb notification record in the product domain.',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp of the product ltb notification record in the product domain.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the product ltb notification record in the product domain.',
    `cancelled_by` STRING COMMENT 'The cancelled by of the product ltb notification record in the product domain.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The cancelled timestamp of the product ltb notification record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product ltb notification record in the product domain.',
    `customer_acknowledgment_deadline` DATE COMMENT 'The customer acknowledgment deadline of the product ltb notification record in the product domain.',
    `customer_acknowledgment_required` BOOLEAN COMMENT 'The customer acknowledgment required of the product ltb notification record in the product domain.',
    `discontinuance_reason_code` STRING COMMENT 'Coded value representing the discontinuance reason code of the product ltb notification product record.',
    `discontinuance_reason_description` STRING COMMENT 'The discontinuance reason description of the product ltb notification record in the product domain.',
    `estimated_ltb_revenue` DECIMAL(18,2) COMMENT 'The estimated ltb revenue of the product ltb notification record in the product domain.',
    `estimated_ltb_units` STRING COMMENT 'The estimated ltb units of the product ltb notification record in the product domain.',
    `final_order_date` DATE COMMENT 'The final order date associated with the product ltb notification product record.',
    `final_shipment_date` DATE COMMENT 'The final shipment date associated with the product ltb notification product record.',
    `issued_by` STRING COMMENT 'The issued by of the product ltb notification record in the product domain.',
    `issued_timestamp` TIMESTAMP COMMENT 'The issued timestamp of the product ltb notification record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product ltb notification record in the product domain.',
    `maximum_order_quantity` STRING COMMENT 'The maximum order quantity of the product ltb notification record in the product domain.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity of the product ltb notification record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the product ltb notification record in the product domain.',
    `notes` STRING COMMENT 'The notes of the product ltb notification record in the product domain.',
    `notification_channel` STRING COMMENT 'The notification channel of the product ltb notification record in the product domain.',
    `notification_issue_date` DATE COMMENT 'The notification issue date associated with the product ltb notification product record.',
    `notification_language` STRING COMMENT 'The notification language of the product ltb notification record in the product domain.',
    `notification_number` STRING COMMENT 'The notification number of the product ltb notification record in the product domain.',
    `notification_status` STRING COMMENT 'The notification status of the product ltb notification record in the product domain.',
    `notification_type` STRING COMMENT 'The notification type of the product ltb notification record in the product domain.',
    `pcn_number` STRING COMMENT 'The pcn number of the product ltb notification record in the product domain.',
    `regulatory_approval_required` BOOLEAN COMMENT 'The regulatory approval required of the product ltb notification record in the product domain.',
    `regulatory_approval_status` STRING COMMENT 'The regulatory approval status of the product ltb notification record in the product domain.',
    `replacement_product_qualification_required` BOOLEAN COMMENT 'The replacement product qualification required of the product ltb notification record in the product domain.',
    `product_ltb_notification_status` STRING COMMENT 'The status of the product ltb notification record in the product domain.',
    `total_customers_acknowledged` STRING COMMENT 'The total customers acknowledged of the product ltb notification record in the product domain.',
    `total_customers_notified` STRING COMMENT 'The total customers notified of the product ltb notification record in the product domain.',
    CONSTRAINT pk_product_ltb_notification PRIMARY KEY(`product_ltb_notification_id`)
) COMMENT 'Product-side LTB notification record. Authoritative owner of LTB lifecycle data; references customer.customer_ltb_notification for customer-facing view.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` (
    `product_ip_core_id` BIGINT COMMENT 'Primary key',
    `eccn_classification_id` BIGINT COMMENT 'FK to ECCN classification',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `employee_id` BIGINT COMMENT 'FK to owner employee',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `design_ip_core_id` BIGINT COMMENT 'FK to design IP core',
    `area_mm2` DECIMAL(18,2) COMMENT 'Area in mm2',
    `authoritative_design_ip_core_id` BIGINT COMMENT 'Authoritative design IP core FK',
    `compliance_certifications` STRING COMMENT 'The compliance certifications of the product ip core record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product ip core record in the product domain.',
    `design_for_testability` BOOLEAN COMMENT 'The design for testability of the product ip core record in the product domain.',
    `documentation_package` STRING COMMENT 'The documentation package of the product ip core record in the product domain.',
    `eda_tool_compatibility` STRING COMMENT 'The eda tool compatibility of the product ip core record in the product domain.',
    `eol_date` DATE COMMENT 'The eol date associated with the product ip core product record.',
    `errata_notes` STRING COMMENT 'The errata notes of the product ip core record in the product domain.',
    `foundry_compatibility` STRING COMMENT 'The foundry compatibility of the product ip core record in the product domain.',
    `gate_count` BIGINT COMMENT 'The gate count of the product ip core record in the product domain.',
    `integration_complexity` STRING COMMENT 'The integration complexity of the product ip core record in the product domain.',
    `interface_protocol` STRING COMMENT 'The interface protocol of the product ip core record in the product domain.',
    `ip_category` STRING COMMENT 'The ip category of the product ip core record in the product domain.',
    `ip_core_code` STRING COMMENT 'Coded value representing the ip core code of the product ip core product record.',
    `ip_core_name` STRING COMMENT 'The ip core name of the product ip core record in the product domain.',
    `ip_core_to_node` BIGINT COMMENT 'IP core to node mapping',
    `ip_type` STRING COMMENT 'The ip type of the product ip core record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product ip core record in the product domain.',
    `licensing_model` STRING COMMENT 'The licensing model of the product ip core record in the product domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the product ip core record in the product domain.',
    `low_power_modes` STRING COMMENT 'The low power modes of the product ip core record in the product domain.',
    `ltb_notification_date` DATE COMMENT 'The ltb notification date associated with the product ip core product record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the product ip core record in the product domain.',
    `modified_by` STRING COMMENT 'The modified by of the product ip core record in the product domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the product ip core record in the product domain.',
    `notes` STRING COMMENT 'The notes of the product ip core record in the product domain.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'NRE cost in USD',
    `operating_frequency_mhz` DECIMAL(18,2) COMMENT 'Operating frequency in MHz',
    `operating_voltage_v` DECIMAL(18,2) COMMENT 'Operating voltage',
    `per_unit_royalty_usd` DECIMAL(18,2) COMMENT 'Per unit royalty in USD',
    `performance_metric` STRING COMMENT 'The performance metric of the product ip core record in the product domain.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Power consumption in mW',
    `process_node_compatibility` STRING COMMENT 'The process node compatibility of the product ip core record in the product domain.',
    `reference_designs` STRING COMMENT 'The reference designs of the product ip core record in the product domain.',
    `release_date` DATE COMMENT 'The release date associated with the product ip core product record.',
    `rtl_language` STRING COMMENT 'The rtl language of the product ip core record in the product domain.',
    `security_features` STRING COMMENT 'The security features of the product ip core record in the product domain.',
    `ssot_owner_reference` BIGINT COMMENT 'The ssot owner reference of the product ip core record in the product domain.',
    `product_ip_core_status` STRING COMMENT 'The status of the product ip core record in the product domain.',
    `support_contact` STRING COMMENT 'The support contact of the product ip core record in the product domain.',
    `temperature_range_c` STRING COMMENT 'Temperature range',
    `vendor_name` STRING COMMENT 'The vendor name of the product ip core record in the product domain.',
    `verification_status` STRING COMMENT 'The verification status of the product ip core record in the product domain.',
    `version` STRING COMMENT 'Version or revision identifier of the product ip core product record.',
    `created_by` STRING COMMENT 'The created by of the product ip core record in the product domain.',
    CONSTRAINT pk_product_ip_core PRIMARY KEY(`product_ip_core_id`)
) COMMENT 'Product-domain view of IP cores used in products. References design.design_ip_core as authoritative source for IP core technical details.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` (
    `product_qualification_program_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - qualification programs are technology node specific',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `employee_id` BIGINT COMMENT 'FK to program manager',
    `quality_qualification_program_id` BIGINT COMMENT 'SSOT reference to owner quality.quality_qualification_program.quality_qualification_program_id',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `acceptance_criteria` STRING COMMENT 'The acceptance criteria of the product qualification program record in the product domain.',
    `actual_completion_date` DATE COMMENT 'The actual completion date associated with the product qualification program product record.',
    `actual_start_date` DATE COMMENT 'The actual start date associated with the product qualification program product record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product qualification program record in the product domain.',
    `deviation_description` STRING COMMENT 'The deviation description of the product qualification program record in the product domain.',
    `deviation_granted` BOOLEAN COMMENT 'The deviation granted of the product qualification program record in the product domain.',
    `esd_cdm_enabled` BOOLEAN COMMENT 'The esd cdm enabled of the product qualification program record in the product domain.',
    `esd_cdm_voltage_v` STRING COMMENT 'ESD CDM voltage',
    `esd_hbm_enabled` BOOLEAN COMMENT 'The esd hbm enabled of the product qualification program record in the product domain.',
    `esd_hbm_voltage_v` STRING COMMENT 'ESD HBM voltage',
    `failure_threshold_ppm` STRING COMMENT 'The failure threshold ppm of the product qualification program record in the product domain.',
    `hast_duration_hours` STRING COMMENT 'The hast duration hours of the product qualification program record in the product domain.',
    `hast_enabled` BOOLEAN COMMENT 'The hast enabled of the product qualification program record in the product domain.',
    `hast_relative_humidity_pct` STRING COMMENT 'HAST relative humidity',
    `hast_temperature_c` STRING COMMENT 'HAST temperature',
    `htol_duration_hours` STRING COMMENT 'The htol duration hours of the product qualification program record in the product domain.',
    `htol_enabled` BOOLEAN COMMENT 'The htol enabled of the product qualification program record in the product domain.',
    `htol_temperature_c` STRING COMMENT 'HTOL temperature',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product qualification program record in the product domain.',
    `latchup_current_ma` STRING COMMENT 'The latchup current ma of the product qualification program record in the product domain.',
    `latchup_enabled` BOOLEAN COMMENT 'The latchup enabled of the product qualification program record in the product domain.',
    `lot_count` STRING COMMENT 'The lot count of the product qualification program record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the product qualification program record in the product domain.',
    `notes` STRING COMMENT 'The notes of the product qualification program record in the product domain.',
    `planned_completion_date` DATE COMMENT 'The planned completion date associated with the product qualification program product record.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the product qualification program product record.',
    `program_code` STRING COMMENT 'Coded value representing the program code of the product qualification program product record.',
    `program_name` STRING COMMENT 'The program name of the product qualification program record in the product domain.',
    `program_status` STRING COMMENT 'The program status of the product qualification program record in the product domain.',
    `qualification_standard` STRING COMMENT 'The qualification standard of the product qualification program record in the product domain.',
    `qualification_type` STRING COMMENT 'The qualification type of the product qualification program record in the product domain.',
    `responsible_engineer` STRING COMMENT 'The responsible engineer of the product qualification program record in the product domain.',
    `sample_size` STRING COMMENT 'The sample size of the product qualification program record in the product domain.',
    `product_qualification_program_status` STRING COMMENT 'The status of the product qualification program record in the product domain.',
    `tc_cycle_count` STRING COMMENT 'The tc cycle count of the product qualification program record in the product domain.',
    `tc_enabled` BOOLEAN COMMENT 'The tc enabled of the product qualification program record in the product domain.',
    `tc_max_temperature_c` STRING COMMENT 'TC max temperature',
    `tc_min_temperature_c` STRING COMMENT 'TC min temperature',
    `test_matrix_version` STRING COMMENT 'The test matrix version of the product qualification program record in the product domain.',
    `waiver_granted` BOOLEAN COMMENT 'The waiver granted of the product qualification program record in the product domain.',
    `waiver_justification` STRING COMMENT 'The waiver justification of the product qualification program record in the product domain.',
    CONSTRAINT pk_product_qualification_program PRIMARY KEY(`product_qualification_program_id`)
) COMMENT 'Qualification program tracking reliability testing (HTOL, HAST, TC, ESD) for product release approval.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` (
    `compliance_cert_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to account',
    `employee_id` BIGINT COMMENT 'FK to cert owner',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `primary_ic_catalog_id` BIGINT COMMENT 'FK to primary IC catalog',
    `applicable_markets` STRING COMMENT 'The applicable markets of the compliance cert record in the product domain.',
    `applicable_regions` STRING COMMENT 'The applicable regions of the compliance cert record in the product domain.',
    `auditor_name` STRING COMMENT 'The auditor name of the compliance cert record in the product domain.',
    `automotive_grade_certified` BOOLEAN COMMENT 'The automotive grade certified of the compliance cert record in the product domain.',
    `certification_body` STRING COMMENT 'The certification body of the compliance cert record in the product domain.',
    `certification_number` STRING COMMENT 'The certification number of the compliance cert record in the product domain.',
    `certification_scope` STRING COMMENT 'The certification scope of the compliance cert record in the product domain.',
    `certification_status` STRING COMMENT 'The certification status of the compliance cert record in the product domain.',
    `certification_type` STRING COMMENT 'The certification type of the compliance cert record in the product domain.',
    `compliance_notes` STRING COMMENT 'The compliance notes of the compliance cert record in the product domain.',
    `conflict_minerals_declaration` STRING COMMENT 'The conflict minerals declaration of the compliance cert record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the compliance cert record in the product domain.',
    `customer_specific_requirement` STRING COMMENT 'The customer specific requirement of the compliance cert record in the product domain.',
    `ear_controlled` BOOLEAN COMMENT 'The ear controlled of the compliance cert record in the product domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the compliance cert product record.',
    `environmental_standard` STRING COMMENT 'The environmental standard of the compliance cert record in the product domain.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the compliance cert product record.',
    `export_control_classification` STRING COMMENT 'The export control classification of the compliance cert record in the product domain.',
    `functional_safety_level` STRING COMMENT 'The functional safety level of the compliance cert record in the product domain.',
    `hazardous_substance_declaration` STRING COMMENT 'The hazardous substance declaration of the compliance cert record in the product domain.',
    `internal_owner` STRING COMMENT 'The internal owner of the compliance cert record in the product domain.',
    `issue_date` DATE COMMENT 'The issue date associated with the compliance cert product record.',
    `itar_controlled` BOOLEAN COMMENT 'The itar controlled of the compliance cert record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the compliance cert record in the product domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the compliance cert record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the compliance cert record in the product domain.',
    `notes` STRING COMMENT 'The notes of the compliance cert record in the product domain.',
    `pcn_reference_number` STRING COMMENT 'The pcn reference number of the compliance cert record in the product domain.',
    `quality_management_standard` STRING COMMENT 'The quality management standard of the compliance cert record in the product domain.',
    `reach_compliant` BOOLEAN COMMENT 'The reach compliant of the compliance cert record in the product domain.',
    `recertification_frequency_months` STRING COMMENT 'The recertification frequency months of the compliance cert record in the product domain.',
    `recertification_required` BOOLEAN COMMENT 'The recertification required of the compliance cert record in the product domain.',
    `recertification_trigger_events` STRING COMMENT 'The recertification trigger events of the compliance cert record in the product domain.',
    `restricted_countries` STRING COMMENT 'The restricted countries of the compliance cert record in the product domain.',
    `rohs_compliant` BOOLEAN COMMENT 'The rohs compliant of the compliance cert record in the product domain.',
    `compliance_cert_status` STRING COMMENT 'The status of the compliance cert record in the product domain.',
    `supporting_documentation_url` STRING COMMENT 'The supporting documentation url of the compliance cert record in the product domain.',
    `test_laboratory` STRING COMMENT 'The test laboratory of the compliance cert record in the product domain.',
    `test_report_number` STRING COMMENT 'The test report number of the compliance cert record in the product domain.',
    CONSTRAINT pk_compliance_cert PRIMARY KEY(`compliance_cert_id`)
) COMMENT 'Compliance certification record for environmental, safety, and export control standards applicable to IC products.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`errata` (
    `errata_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to account',
    `employee_id` BIGINT COMMENT 'FK to engineering owner',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `test_case_id` BIGINT COMMENT 'FK to test case',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `affected_revisions` STRING COMMENT 'The affected revisions of the errata record in the product domain.',
    `affected_use_cases` STRING COMMENT 'The affected use cases of the errata record in the product domain.',
    `business_impact` STRING COMMENT 'The business impact of the errata record in the product domain.',
    `closure_reason` STRING COMMENT 'The closure reason of the errata record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the errata record in the product domain.',
    `customer_disclosure_status` STRING COMMENT 'The customer disclosure status of the errata record in the product domain.',
    `disclosure_date` DATE COMMENT 'The disclosure date associated with the errata product record.',
    `discovered_by` STRING COMMENT 'The discovered by of the errata record in the product domain.',
    `discovered_date` DATE COMMENT 'The discovered date associated with the errata product record.',
    `engineering_owner` STRING COMMENT 'The engineering owner of the errata record in the product domain.',
    `fix_plan` STRING COMMENT 'The fix plan of the errata record in the product domain.',
    `fix_target_revision` STRING COMMENT 'The fix target revision of the errata record in the product domain.',
    `functional_block` STRING COMMENT 'The functional block of the errata record in the product domain.',
    `impacted_customer_count` STRING COMMENT 'The impacted customer count of the errata record in the product domain.',
    `internal_notes` STRING COMMENT 'The internal notes of the errata record in the product domain.',
    `last_modified_by` STRING COMMENT 'The last modified by of the errata record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the errata record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the errata record in the product domain.',
    `notes` STRING COMMENT 'The notes of the errata record in the product domain.',
    `number` STRING COMMENT 'Errata number',
    `pcn_number` STRING COMMENT 'The pcn number of the errata record in the product domain.',
    `regulatory_impact` STRING COMMENT 'The regulatory impact of the errata record in the product domain.',
    `related_errata_ids` STRING COMMENT 'The related errata ids of the errata record in the product domain.',
    `resolution_date` DATE COMMENT 'The resolution date associated with the errata product record.',
    `root_cause` STRING COMMENT 'The root cause of the errata record in the product domain.',
    `severity` STRING COMMENT 'The severity of the errata record in the product domain.',
    `silicon_revision` STRING COMMENT 'The silicon revision of the errata record in the product domain.',
    `errata_status` STRING COMMENT 'Errata status',
    `symptom_description` STRING COMMENT 'The symptom description of the errata record in the product domain.',
    `title` STRING COMMENT 'The title of the errata record in the product domain.',
    `to_revision` BIGINT COMMENT 'The to revision of the errata record in the product domain.',
    `verification_date` DATE COMMENT 'The verification date associated with the errata product record.',
    `verification_status` STRING COMMENT 'The verification status of the errata record in the product domain.',
    `workaround_available` BOOLEAN COMMENT 'The workaround available of the errata record in the product domain.',
    `workaround_description` STRING COMMENT 'The workaround description of the errata record in the product domain.',
    `workaround_performance_impact` STRING COMMENT 'The workaround performance impact of the errata record in the product domain.',
    CONSTRAINT pk_errata PRIMARY KEY(`errata_id`)
) COMMENT 'Known silicon errata documenting functional deviations, workarounds, and fix plans for IC products.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` (
    `configuration_rule_id` BIGINT COMMENT 'Primary key',
    `family_id` BIGINT COMMENT 'FK to family',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `overridden_configuration_rule_id` BIGINT COMMENT 'FK to overridden rule',
    `employee_id` BIGINT COMMENT 'FK to rule owner',
    `applicable_market` STRING COMMENT 'The applicable market of the configuration rule record in the product domain.',
    `applicable_process_node` STRING COMMENT 'The applicable process node of the configuration rule record in the product domain.',
    `automotive_qualified` BOOLEAN COMMENT 'The automotive qualified of the configuration rule record in the product domain.',
    `constraint_expression` STRING COMMENT 'The constraint expression of the configuration rule record in the product domain.',
    `country_of_origin` STRING COMMENT 'The country of origin of the configuration rule record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the configuration rule record in the product domain.',
    `configuration_rule_description` STRING COMMENT 'Configuration rule description',
    `ear_eccn_code` STRING COMMENT 'Coded value representing the ear eccn code of the configuration rule product record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the configuration rule product record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the configuration rule product record.',
    `hts_code` STRING COMMENT 'Coded value representing the hts code of the configuration rule product record.',
    `is_default_rule` BOOLEAN COMMENT 'The is default rule of the configuration rule record in the product domain.',
    `itar_controlled` BOOLEAN COMMENT 'The itar controlled of the configuration rule record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the configuration rule record in the product domain.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'The last reviewed timestamp of the configuration rule record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the configuration rule record in the product domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the configuration rule record in the product domain.',
    `notes` STRING COMMENT 'The notes of the configuration rule record in the product domain.',
    `option_dependencies` STRING COMMENT 'The option dependencies of the configuration rule record in the product domain.',
    `package_type` STRING COMMENT 'The package type of the configuration rule record in the product domain.',
    `priority` STRING COMMENT 'The priority of the configuration rule record in the product domain.',
    `qualification_level` STRING COMMENT 'The qualification level of the configuration rule record in the product domain.',
    `reach_compliant` BOOLEAN COMMENT 'The reach compliant of the configuration rule record in the product domain.',
    `reviewed_by` STRING COMMENT 'The reviewed by of the configuration rule record in the product domain.',
    `rohs_compliant` BOOLEAN COMMENT 'The rohs compliant of the configuration rule record in the product domain.',
    `rule_code` STRING COMMENT 'Coded value representing the rule code of the configuration rule product record.',
    `rule_name` STRING COMMENT 'The rule name of the configuration rule record in the product domain.',
    `rule_owner` STRING COMMENT 'The rule owner of the configuration rule record in the product domain.',
    `rule_type` STRING COMMENT 'The rule type of the configuration rule record in the product domain.',
    `rule_version` STRING COMMENT 'The rule version of the configuration rule record in the product domain.',
    `speed_grade` STRING COMMENT 'The speed grade of the configuration rule record in the product domain.',
    `configuration_rule_status` STRING COMMENT 'Configuration rule status',
    `temperature_range` STRING COMMENT 'The temperature range of the configuration rule record in the product domain.',
    `voltage_variant` STRING COMMENT 'The voltage variant of the configuration rule record in the product domain.',
    CONSTRAINT pk_configuration_rule PRIMARY KEY(`configuration_rule_id`)
) COMMENT 'Product configuration rules defining valid combinations of options, variants, and constraints for ordering.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` (
    `product_sample_request_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to account',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `followup_product_sample_request_id` BIGINT COMMENT 'FK to followup request',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `customer_sample_request_id` BIGINT COMMENT 'Authoritative customer sample request FK',
    `product_customer_sample_request_id` BIGINT COMMENT 'FK to customer sample request',
    `order_id` BIGINT COMMENT 'FK to sales order',
    `approval_status` STRING COMMENT 'The approval status of the product sample request record in the product domain.',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp of the product sample request record in the product domain.',
    `compliance_itar_flag` BOOLEAN COMMENT 'ITAR compliance flag',
    `compliance_reach_flag` BOOLEAN COMMENT 'REACH compliance flag',
    `compliance_rohs_flag` BOOLEAN COMMENT 'RoHS compliance flag',
    `contact_email` STRING COMMENT 'The contact email of the product sample request record in the product domain.',
    `contact_name` STRING COMMENT 'The contact name of the product sample request record in the product domain.',
    `contact_phone` STRING COMMENT 'The contact phone of the product sample request record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product sample request record in the product domain.',
    `design_win_conversion_flag` BOOLEAN COMMENT 'The design win conversion flag of the product sample request record in the product domain.',
    `design_win_status` STRING COMMENT 'The design win status of the product sample request record in the product domain.',
    `evaluation_outcome` STRING COMMENT 'The evaluation outcome of the product sample request record in the product domain.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'The evaluation score of the product sample request record in the product domain.',
    `expedited_flag` BOOLEAN COMMENT 'The expedited flag of the product sample request record in the product domain.',
    `export_control_info` STRING COMMENT 'The export control info of the product sample request record in the product domain.',
    `feedback_due_date` DATE COMMENT 'The feedback due date associated with the product sample request product record.',
    `feedback_received_date` DATE COMMENT 'The feedback received date associated with the product sample request product record.',
    `feedback_summary` STRING COMMENT 'The feedback summary of the product sample request record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product sample request record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the product sample request record in the product domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the product sample request record in the product domain.',
    `notes` STRING COMMENT 'The notes of the product sample request record in the product domain.',
    `priority` STRING COMMENT 'The priority of the product sample request record in the product domain.',
    `quantity` STRING COMMENT 'The quantity of the product sample request record in the product domain.',
    `request_number` STRING COMMENT 'The request number of the product sample request record in the product domain.',
    `request_source` STRING COMMENT 'The request source of the product sample request record in the product domain.',
    `request_timestamp` TIMESTAMP COMMENT 'The request timestamp of the product sample request record in the product domain.',
    `sample_condition` STRING COMMENT 'The sample condition of the product sample request record in the product domain.',
    `sample_cost_amount` DECIMAL(18,2) COMMENT 'The sample cost amount of the product sample request record in the product domain.',
    `sample_cost_currency` STRING COMMENT 'The sample cost currency of the product sample request record in the product domain.',
    `sample_returned_flag` BOOLEAN COMMENT 'The sample returned flag of the product sample request record in the product domain.',
    `sample_serial_number` STRING COMMENT 'The sample serial number of the product sample request record in the product domain.',
    `sample_type` STRING COMMENT 'The sample type of the product sample request record in the product domain.',
    `ship_date` DATE COMMENT 'The ship date associated with the product sample request product record.',
    `shipping_address` STRING COMMENT 'The shipping address of the product sample request record in the product domain.',
    `shipping_method` STRING COMMENT 'The shipping method of the product sample request record in the product domain.',
    `product_sample_request_status` STRING COMMENT 'Sample request status',
    `target_application` STRING COMMENT 'The target application of the product sample request record in the product domain.',
    `tracking_number` STRING COMMENT 'The tracking number of the product sample request record in the product domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the product sample request record in the product domain.',
    CONSTRAINT pk_product_sample_request PRIMARY KEY(`product_sample_request_id`)
) COMMENT 'Product-side sample request tracking. Authoritative owner of sample fulfillment data; references customer.customer_sample_request for customer-facing view.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to account',
    `product_ip_core_id` BIGINT COMMENT 'FK to product IP core',
    `agreement_date` DATE COMMENT 'The agreement date associated with the license agreement product record.',
    `agreement_number` STRING COMMENT 'The agreement number of the license agreement record in the product domain.',
    `agreement_status` STRING COMMENT 'The agreement status of the license agreement record in the product domain.',
    `agreement_type` STRING COMMENT 'The agreement type of the license agreement record in the product domain.',
    `amendment_count` STRING COMMENT 'The amendment count of the license agreement record in the product domain.',
    `annual_minimum_units` STRING COMMENT 'The annual minimum units of the license agreement record in the product domain.',
    `audit_rights_flag` BOOLEAN COMMENT 'The audit rights flag of the license agreement record in the product domain.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the license agreement record in the product domain.',
    `auto_renewal_flag` BOOLEAN COMMENT 'The auto renewal flag of the license agreement record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the license agreement record in the product domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the license agreement product record.',
    `dispute_resolution_method` STRING COMMENT 'The dispute resolution method of the license agreement record in the product domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the license agreement product record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the license agreement product record.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the license agreement product record.',
    `exclusivity_flag` BOOLEAN COMMENT 'The exclusivity flag of the license agreement record in the product domain.',
    `exclusivity_type` STRING COMMENT 'The exclusivity type of the license agreement record in the product domain.',
    `expiration_date` DATE COMMENT 'The expiration date associated with the license agreement product record.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the license agreement product record.',
    `export_control_classification` STRING COMMENT 'The export control classification of the license agreement record in the product domain.',
    `field_of_use` STRING COMMENT 'The field of use of the license agreement record in the product domain.',
    `geographic_restriction` STRING COMMENT 'The geographic restriction of the license agreement record in the product domain.',
    `governing_law` STRING COMMENT 'The governing law of the license agreement record in the product domain.',
    `governing_law_jurisdiction` STRING COMMENT 'The governing law jurisdiction of the license agreement record in the product domain.',
    `indemnification_cap_usd` DECIMAL(18,2) COMMENT 'The indemnification cap usd of the license agreement record in the product domain.',
    `ip_core_count` STRING COMMENT 'The ip core count of the license agreement record in the product domain.',
    `ip_version` STRING COMMENT 'The ip version of the license agreement record in the product domain.',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the license agreement record in the product domain.',
    `last_audit_date` DATE COMMENT 'The last audit date associated with the license agreement product record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the license agreement record in the product domain.',
    `license_scope` STRING COMMENT 'The license scope of the license agreement record in the product domain.',
    `license_type` STRING COMMENT 'The license type of the license agreement record in the product domain.',
    `licensee_contact_name` STRING COMMENT 'The licensee contact name of the license agreement record in the product domain.',
    `licensing_model` STRING COMMENT 'The licensing model of the license agreement record in the product domain.',
    `maximum_volume_units` BIGINT COMMENT 'The maximum volume units of the license agreement record in the product domain.',
    `minimum_royalty_usd` DECIMAL(18,2) COMMENT 'The minimum royalty usd of the license agreement record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the license agreement record in the product domain.',
    `notes` STRING COMMENT 'The notes of the license agreement record in the product domain.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'The nre cost usd of the license agreement record in the product domain.',
    `payment_terms` STRING COMMENT 'The payment terms of the license agreement record in the product domain.',
    `per_unit_royalty_usd` DECIMAL(18,2) COMMENT 'The per unit royalty usd of the license agreement record in the product domain.',
    `renewal_term_months` STRING COMMENT 'The renewal term months of the license agreement record in the product domain.',
    `renewal_terms` STRING COMMENT 'The renewal terms of the license agreement record in the product domain.',
    `royalty_cap_usd` DECIMAL(18,2) COMMENT 'The royalty cap usd of the license agreement record in the product domain.',
    `royalty_minimum_usd` DECIMAL(18,2) COMMENT 'The royalty minimum usd of the license agreement record in the product domain.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The royalty rate of the license agreement record in the product domain.',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percent',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The royalty rate percent of the license agreement record in the product domain.',
    `signed_by_licensee` STRING COMMENT 'The signed by licensee of the license agreement record in the product domain.',
    `signed_by_licensor` STRING COMMENT 'The signed by licensor of the license agreement record in the product domain.',
    `signed_date` DATE COMMENT 'The signed date associated with the license agreement product record.',
    `license_agreement_status` STRING COMMENT 'The status of the license agreement record in the product domain.',
    `sublicense_allowed_flag` BOOLEAN COMMENT 'The sublicense allowed flag of the license agreement record in the product domain.',
    `support_level` STRING COMMENT 'The support level of the license agreement record in the product domain.',
    `termination_clause` STRING COMMENT 'The termination clause of the license agreement record in the product domain.',
    `territory` STRING COMMENT 'The territory of the license agreement record in the product domain.',
    `territory_restriction` STRING COMMENT 'The territory restriction of the license agreement record in the product domain.',
    `territory_scope` STRING COMMENT 'The territory scope of the license agreement record in the product domain.',
    `total_contract_value_usd` DECIMAL(18,2) COMMENT 'The total contract value usd of the license agreement record in the product domain.',
    `upfront_fee_usd` DECIMAL(18,2) COMMENT 'The upfront fee usd of the license agreement record in the product domain.',
    `warranty_period_months` STRING COMMENT 'The warranty period months of the license agreement record in the product domain.',
    CONSTRAINT pk_license_agreement PRIMARY KEY(`license_agreement_id`)
) COMMENT 'IP licensing agreements between licensor and licensee covering royalty terms, territory, exclusivity, and compliance controls.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` (
    `license_allocation_id` BIGINT COMMENT 'Primary key',
    `export_license_id` BIGINT COMMENT 'FK to export license',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `license_agreement_id` BIGINT COMMENT 'FK to license agreement',
    `allocated_qty` BIGINT COMMENT 'The allocated qty of the license allocation record in the product domain.',
    `allocated_quantity` BIGINT COMMENT 'The allocated quantity of the license allocation record in the product domain.',
    `allocated_units` BIGINT COMMENT 'The allocated units of the license allocation record in the product domain.',
    `allocated_value_usd` DECIMAL(18,2) COMMENT 'The allocated value usd of the license allocation record in the product domain.',
    `allocation_date` DATE COMMENT 'The allocation date associated with the license allocation product record.',
    `allocation_notes` STRING COMMENT 'The allocation notes of the license allocation record in the product domain.',
    `allocation_number` STRING COMMENT 'The allocation number of the license allocation record in the product domain.',
    `allocation_period` STRING COMMENT 'The allocation period of the license allocation record in the product domain.',
    `allocation_period_end` STRING COMMENT 'The allocation period end of the license allocation record in the product domain.',
    `allocation_period_start` STRING COMMENT 'The allocation period start of the license allocation record in the product domain.',
    `allocation_qty` DECIMAL(18,2) COMMENT 'The allocation qty of the license allocation record in the product domain.',
    `allocation_status` STRING COMMENT 'The allocation status of the license allocation record in the product domain.',
    `allocation_type` STRING COMMENT 'The allocation type of the license allocation record in the product domain.',
    `allocation_unit` STRING COMMENT 'The allocation unit of the license allocation record in the product domain.',
    `allocation_value_usd` DECIMAL(18,2) COMMENT 'The allocation value usd of the license allocation record in the product domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the license allocation product record.',
    `approval_status` STRING COMMENT 'The approval status of the license allocation record in the product domain.',
    `approved_by` STRING COMMENT 'The approved by of the license allocation record in the product domain.',
    `authorized_commodities` STRING COMMENT 'The authorized commodities of the license allocation record in the product domain.',
    `authorized_countries` STRING COMMENT 'The authorized countries of the license allocation record in the product domain.',
    `authorized_end_users` STRING COMMENT 'The authorized end users of the license allocation record in the product domain.',
    `authorized_quantity` BIGINT COMMENT 'The authorized quantity of the license allocation record in the product domain.',
    `consignee_name` STRING COMMENT 'The consignee name of the license allocation record in the product domain.',
    `consumed_qty` BIGINT COMMENT 'The consumed qty of the license allocation record in the product domain.',
    `consumed_quantity` BIGINT COMMENT 'The consumed quantity of the license allocation record in the product domain.',
    `consumed_units` BIGINT COMMENT 'The consumed units of the license allocation record in the product domain.',
    `consumed_value_usd` DECIMAL(18,2) COMMENT 'The consumed value usd of the license allocation record in the product domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the license allocation record in the product domain.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the license allocation product record.',
    `destination_country_code` STRING COMMENT 'Coded value representing the destination country code of the license allocation product record.',
    `diversion_risk_score` DECIMAL(18,2) COMMENT 'The diversion risk score of the license allocation record in the product domain.',
    `eccn_classification` STRING COMMENT 'The eccn classification of the license allocation record in the product domain.',
    `effective_from` DATE COMMENT 'The effective from of the license allocation record in the product domain.',
    `effective_until` DATE COMMENT 'The effective until of the license allocation record in the product domain.',
    `end_use_description` STRING COMMENT 'The end use description of the license allocation record in the product domain.',
    `end_use_statement` STRING COMMENT 'The end use statement of the license allocation record in the product domain.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the license allocation product record.',
    `export_control_classification` STRING COMMENT 'The export control classification of the license allocation record in the product domain.',
    `field_of_use` STRING COMMENT 'The field of use of the license allocation record in the product domain.',
    `issue_date` DATE COMMENT 'The issue date associated with the license allocation product record.',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the license allocation record in the product domain.',
    `last_consumption_date` DATE COMMENT 'The last consumption date associated with the license allocation product record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the license allocation record in the product domain.',
    `last_shipment_date` DATE COMMENT 'The last shipment date associated with the license allocation product record.',
    `license_type` STRING COMMENT 'The license type of the license allocation record in the product domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the license allocation record in the product domain.',
    `notes` STRING COMMENT 'The notes of the license allocation record in the product domain.',
    `overage_allowed_flag` BOOLEAN COMMENT 'The overage allowed flag of the license allocation record in the product domain.',
    `overage_rate_pct` DECIMAL(18,2) COMMENT 'The overage rate pct of the license allocation record in the product domain.',
    `reconciliation_date` DATE COMMENT 'The reconciliation date associated with the license allocation product record.',
    `remaining_qty` BIGINT COMMENT 'The remaining qty of the license allocation record in the product domain.',
    `remaining_quantity` BIGINT COMMENT 'The remaining quantity of the license allocation record in the product domain.',
    `remaining_units` BIGINT COMMENT 'The remaining units of the license allocation record in the product domain.',
    `renewal_flag` BOOLEAN COMMENT 'The renewal flag of the license allocation record in the product domain.',
    `restriction_notes` STRING COMMENT 'The restriction notes of the license allocation record in the product domain.',
    `review_frequency_days` STRING COMMENT 'The review frequency days of the license allocation record in the product domain.',
    `shipment_count` STRING COMMENT 'The shipment count of the license allocation record in the product domain.',
    `license_allocation_status` STRING COMMENT 'The status of the license allocation record in the product domain.',
    `usage_tracking_method` STRING COMMENT 'The usage tracking method of the license allocation record in the product domain.',
    `utilization_percent` DECIMAL(18,2) COMMENT 'The utilization percent of the license allocation record in the product domain.',
    `value_limit_usd` DECIMAL(18,2) COMMENT 'The value limit usd of the license allocation record in the product domain.',
    CONSTRAINT pk_license_allocation PRIMARY KEY(`license_allocation_id`)
) COMMENT 'Allocation of export license or IP license quantities/values to specific products, countries, and end-users with consumption tracking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_replacement_sku_id` FOREIGN KEY (`replacement_sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_primary_product_ic_catalog_id` FOREIGN KEY (`primary_product_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_primary_ic_catalog_id` FOREIGN KEY (`primary_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_parent_line_bom_line_id` FOREIGN KEY (`parent_line_bom_line_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_to_bom_id` FOREIGN KEY (`to_bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ADD CONSTRAINT `fk_product_product_ltb_notification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_primary_ic_catalog_id` FOREIGN KEY (`primary_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_overridden_configuration_rule_id` FOREIGN KEY (`overridden_configuration_rule_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`configuration_rule`(`configuration_rule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_followup_product_sample_request_id` FOREIGN KEY (`followup_product_sample_request_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_sample_request`(`product_sample_request_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ADD CONSTRAINT `fk_product_product_sample_request_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ADD CONSTRAINT `fk_product_license_agreement_product_ip_core_id` FOREIGN KEY (`product_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_ip_core`(`product_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ADD CONSTRAINT `fk_product_license_allocation_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ADD CONSTRAINT `fk_product_license_allocation_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`license_agreement`(`license_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_ssot_owner' = 'product_identity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Process Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `aec_qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Aec Qualification Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `automotive_qualified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualified');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `catalog_to_family` SET TAGS ('dbx_business_glossary_term' = 'Catalog To Family');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Ear Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Eol Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `external_part_number` SET TAGS ('dbx_business_glossary_term' = 'External Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `first_silicon_date` SET TAGS ('dbx_business_glossary_term' = 'First Silicon Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Hts Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `internal_part_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `lead_free_compliant` SET TAGS ('dbx_business_glossary_term' = 'Lead Free Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `npi_phase` SET TAGS ('dbx_business_glossary_term' = 'Npi Phase');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `operating_frequency_max_mhz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency Max Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `operating_voltage_max_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Max V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `operating_voltage_min_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Min V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `power_max_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Max Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `power_typical_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Typical Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `production_release_date` SET TAGS ('dbx_business_glossary_term' = 'Production Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Rtl Language');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_catalog_status` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `replacement_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Sku Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Eol Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `halogen_free` SET TAGS ('dbx_business_glossary_term' = 'Halogen Free');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Hts Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Introduction Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Weeks');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `pcn_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pcn Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `shippable_flag` SET TAGS ('dbx_business_glossary_term' = 'Shippable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Standard Pack Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'Sku Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `unit_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight Grams');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_business_glossary_term' = 'Voltage Variant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `active_pcn_count` SET TAGS ('dbx_business_glossary_term' = 'Active Pcn Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `application_domain` SET TAGS ('dbx_business_glossary_term' = 'Application Domain');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Family Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_description` SET TAGS ('dbx_business_glossary_term' = 'Family Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `design_center_location` SET TAGS ('dbx_business_glossary_term' = 'Design Center Location');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `dfm_score` SET TAGS ('dbx_business_glossary_term' = 'Dfm Score');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `dft_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Dft Coverage Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Ear Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `eda_tool_suite` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Suite');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Eol Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fab Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ltb_date` SET TAGS ('dbx_business_glossary_term' = 'Ltb Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `npi_start_date` SET TAGS ('dbx_business_glossary_term' = 'Npi Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `osat_partner` SET TAGS ('dbx_business_glossary_term' = 'Osat Partner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Pdk Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `product_line_manager` SET TAGS ('dbx_business_glossary_term' = 'Product Line Manager');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_status` SET TAGS ('dbx_business_glossary_term' = 'Family Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Target Power Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Family Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `typical_die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Typical Die Size Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `volume_production_date` SET TAGS ('dbx_business_glossary_term' = 'Volume Production Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `active_product_count` SET TAGS ('dbx_business_glossary_term' = 'Active Product Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `baseline_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `cost_per_wafer_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Wafer Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Eol Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `foundry_source` SET TAGS ('dbx_business_glossary_term' = 'Foundry Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `ltb_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Ltb Deadline Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size Nm');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `multi_patterning_layers` SET TAGS ('dbx_business_glossary_term' = 'Multi Patterning Layers');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Node Generation');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `opc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Opc Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `pdk_release_date` SET TAGS ('dbx_business_glossary_term' = 'Pdk Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Pdk Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `power_performance_area_rating` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area Rating');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `process_node_status` SET TAGS ('dbx_business_glossary_term' = 'Process Node Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `supported_device_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Types');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `primary_product_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `automotive_grade` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `characterization_date` SET TAGS ('dbx_business_glossary_term' = 'Characterization Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Years');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `die_area_achieved_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area Achieved Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `die_area_target_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area Target Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `dynamic_power_achieved_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Achieved Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `dynamic_power_target_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Target Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `endurance_cycles` SET TAGS ('dbx_business_glossary_term' = 'Endurance Cycles');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `esd_protection_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Esd Protection Level Kv');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `functional_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Rating');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `interface_protocols` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocols');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `io_count` SET TAGS ('dbx_business_glossary_term' = 'Io Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `leakage_power_achieved_mw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Achieved Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `leakage_power_target_mw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Target Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `max_frequency_achieved_mhz` SET TAGS ('dbx_business_glossary_term' = 'Max Frequency Achieved Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `max_frequency_target_mhz` SET TAGS ('dbx_business_glossary_term' = 'Max Frequency Target Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `memory_configuration` SET TAGS ('dbx_business_glossary_term' = 'Memory Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_condition_corner` SET TAGS ('dbx_business_glossary_term' = 'Operating Condition Corner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Max C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Min C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_voltage_max_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Max V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_voltage_min_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Min V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_voltage_nominal_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Nominal V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Spec Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `product_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_subdomain' = 'configuration_structure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bom Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `conflict_minerals_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `critical_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Ear Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'Eol Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'Explosion Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `external_bom_reference` SET TAGS ('dbx_business_glossary_term' = 'External Bom Reference');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ltb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Ltb Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Bom Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Pcn Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Revision');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bom Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_component_count` SET TAGS ('dbx_business_glossary_term' = 'Total Component Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bom Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Usage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'configuration_structure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `parent_line_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line Bom Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bom Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `to_bom_id` SET TAGS ('dbx_business_glossary_term' = 'To Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `approved_substitute_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Approved Substitute Part Numbers');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `assembly_process_code` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'Bom Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `conflict_minerals_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Ear Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `effectivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity End Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `effectivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Make Or Buy Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `phantom_bom_flag` SET TAGS ('dbx_business_glossary_term' = 'Phantom Bom Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `reference_designator` SET TAGS ('dbx_business_glossary_term' = 'Reference Designator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` SET TAGS ('dbx_subdomain' = 'change_notification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `affected_product_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Product List');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `automotive_qualification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Email');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `customer_approval_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `customer_objection_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Objection Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `customer_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `electrical_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Electrical Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `environmental_compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Impact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `form_fit_function_impact` SET TAGS ('dbx_business_glossary_term' = 'Form Fit Function Impact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `jedec_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Jedec Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `new_specification` SET TAGS ('dbx_business_glossary_term' = 'New Specification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Pcn Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `old_specification` SET TAGS ('dbx_business_glossary_term' = 'Old Specification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `qualification_plan` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `related_pcn_numbers` SET TAGS ('dbx_business_glossary_term' = 'Related Pcn Numbers');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `reliability_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Reliability Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `sample_request_deadline` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `samples_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Samples Available Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `pcn_status` SET TAGS ('dbx_business_glossary_term' = 'Pcn Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `superseded_by_pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Pcn Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`pcn` ALTER COLUMN `pcn_type` SET TAGS ('dbx_business_glossary_term' = 'Pcn Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` SET TAGS ('dbx_subdomain' = 'change_notification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` SET TAGS ('dbx_ssot_owner' = 'ltb_notification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `product_ltb_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ltb Notification Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `customer_ltb_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Ltb Notification Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Ltb Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Replacement Product Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `actual_ltb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Actual Ltb Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `actual_ltb_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Ltb Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `customer_acknowledgment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledgment Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `customer_acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledgment Required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `discontinuance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discontinuance Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `discontinuance_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Discontinuance Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `estimated_ltb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ltb Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `estimated_ltb_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ltb Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `final_order_date` SET TAGS ('dbx_business_glossary_term' = 'Final Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `final_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Shipment Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `issued_by` SET TAGS ('dbx_business_glossary_term' = 'Issued By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notification_language` SET TAGS ('dbx_business_glossary_term' = 'Notification Language');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Pcn Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `replacement_product_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Qualification Required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `product_ltb_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Product Ltb Notification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `total_customers_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Total Customers Acknowledged');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ltb_notification` ALTER COLUMN `total_customers_notified` SET TAGS ('dbx_business_glossary_term' = 'Total Customers Notified');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_subdomain' = 'change_notification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_ssot_owner' = 'design.design_ip_core');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_ssot_consumer' = 'design.design_ip_core');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Area Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `authoritative_design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Design Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `design_for_testability` SET TAGS ('dbx_business_glossary_term' = 'Design For Testability');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `documentation_package` SET TAGS ('dbx_business_glossary_term' = 'Documentation Package');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `eda_tool_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Eda Tool Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'Eol Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `errata_notes` SET TAGS ('dbx_business_glossary_term' = 'Errata Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `foundry_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Foundry Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `integration_complexity` SET TAGS ('dbx_business_glossary_term' = 'Integration Complexity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `interface_protocol` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocol');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_category` SET TAGS ('dbx_business_glossary_term' = 'Ip Category');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_core_code` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_core_to_node` SET TAGS ('dbx_business_glossary_term' = 'Ip Core To Node');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Ip Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `licensing_model` SET TAGS ('dbx_business_glossary_term' = 'Licensing Model');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `low_power_modes` SET TAGS ('dbx_business_glossary_term' = 'Low Power Modes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ltb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Ltb Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Nre Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `operating_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency Mhz');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `operating_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `per_unit_royalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Per Unit Royalty Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Process Node Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `reference_designs` SET TAGS ('dbx_business_glossary_term' = 'Reference Designs');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Rtl Language');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `product_ip_core_status` SET TAGS ('dbx_business_glossary_term' = 'Product Ip Core Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_business_glossary_term' = 'Support Contact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `product_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Qualification Program Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `deviation_granted` SET TAGS ('dbx_business_glossary_term' = 'Deviation Granted');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `esd_cdm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Esd Cdm Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `esd_cdm_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Esd Cdm Voltage V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `esd_hbm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Esd Hbm Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `esd_hbm_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Esd Hbm Voltage V');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `failure_threshold_ppm` SET TAGS ('dbx_business_glossary_term' = 'Failure Threshold Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `hast_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Hast Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `hast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Hast Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `hast_relative_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Hast Relative Humidity Pct');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `hast_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Hast Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `htol_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Htol Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `htol_enabled` SET TAGS ('dbx_business_glossary_term' = 'Htol Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `htol_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Htol Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `latchup_current_ma` SET TAGS ('dbx_business_glossary_term' = 'Latchup Current Ma');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `latchup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Latchup Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `lot_count` SET TAGS ('dbx_business_glossary_term' = 'Lot Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `product_qualification_program_status` SET TAGS ('dbx_business_glossary_term' = 'Product Qualification Program Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `tc_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Tc Cycle Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `tc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tc Enabled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `tc_max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Tc Max Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `tc_min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Tc Min Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `test_matrix_version` SET TAGS ('dbx_business_glossary_term' = 'Test Matrix Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_qualification_program` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cert Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `primary_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regions');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `automotive_grade_certified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade Certified');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `conflict_minerals_declaration` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Declaration');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `customer_specific_requirement` SET TAGS ('dbx_business_glossary_term' = 'Customer Specific Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'Ear Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `environmental_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `functional_safety_level` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `hazardous_substance_declaration` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Declaration');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `internal_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `pcn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pcn Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `quality_management_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Management Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency Months');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `recertification_trigger_events` SET TAGS ('dbx_business_glossary_term' = 'Recertification Trigger Events');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `restricted_countries` SET TAGS ('dbx_business_glossary_term' = 'Restricted Countries');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_cert_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cert Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Url');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `test_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Test Laboratory');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `errata_id` SET TAGS ('dbx_business_glossary_term' = 'Errata Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Errata Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `affected_revisions` SET TAGS ('dbx_business_glossary_term' = 'Affected Revisions');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `affected_use_cases` SET TAGS ('dbx_business_glossary_term' = 'Affected Use Cases');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `customer_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Disclosure Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `discovered_by` SET TAGS ('dbx_business_glossary_term' = 'Discovered By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `discovered_date` SET TAGS ('dbx_business_glossary_term' = 'Discovered Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `engineering_owner` SET TAGS ('dbx_business_glossary_term' = 'Engineering Owner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `fix_plan` SET TAGS ('dbx_business_glossary_term' = 'Fix Plan');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `fix_target_revision` SET TAGS ('dbx_business_glossary_term' = 'Fix Target Revision');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `functional_block` SET TAGS ('dbx_business_glossary_term' = 'Functional Block');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `impacted_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Customer Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Errata Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Pcn Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `related_errata_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Errata Ids');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `silicon_revision` SET TAGS ('dbx_business_glossary_term' = 'Silicon Revision');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `errata_status` SET TAGS ('dbx_business_glossary_term' = 'Errata Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `symptom_description` SET TAGS ('dbx_business_glossary_term' = 'Symptom Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `to_revision` SET TAGS ('dbx_business_glossary_term' = 'To Revision');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `workaround_available` SET TAGS ('dbx_business_glossary_term' = 'Workaround Available');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`errata` ALTER COLUMN `workaround_performance_impact` SET TAGS ('dbx_business_glossary_term' = 'Workaround Performance Impact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` SET TAGS ('dbx_subdomain' = 'configuration_structure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `overridden_configuration_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Overridden Configuration Rule Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `applicable_process_node` SET TAGS ('dbx_business_glossary_term' = 'Applicable Process Node');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `automotive_qualified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualified');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `constraint_expression` SET TAGS ('dbx_business_glossary_term' = 'Constraint Expression');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Ear Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Hts Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `is_default_rule` SET TAGS ('dbx_business_glossary_term' = 'Is Default Rule');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `option_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Option Dependencies');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`configuration_rule` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_business_glossary_term' = 'Voltage Variant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_subdomain' = 'licensing_samples');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_ssot_owner' = 'sample_request');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_ssot_counterpart' = 'customer.customer_sample_request');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `product_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sample Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `followup_product_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Product Sample Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `customer_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Customer Sample Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `product_customer_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Sample Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `compliance_itar_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Itar Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `compliance_reach_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reach Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `compliance_rohs_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rohs Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `design_win_conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Design Win Conversion Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `design_win_status` SET TAGS ('dbx_business_glossary_term' = 'Design Win Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `evaluation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `expedited_flag` SET TAGS ('dbx_business_glossary_term' = 'Expedited Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `export_control_info` SET TAGS ('dbx_business_glossary_term' = 'Export Control Info');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `feedback_due_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `feedback_received_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Feedback Summary');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `sample_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `sample_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Amount');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `sample_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Currency');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `sample_returned_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Returned Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `sample_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `shipping_address` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `shipping_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `shipping_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `product_sample_request_status` SET TAGS ('dbx_business_glossary_term' = 'Product Sample Request Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_sample_request` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` SET TAGS ('dbx_subdomain' = 'licensing_samples');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` SET TAGS ('dbx_association_edges' = 'product.product_ip_core,customer.account');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ip Core Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `annual_minimum_units` SET TAGS ('dbx_business_glossary_term' = 'Annual Minimum Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `field_of_use` SET TAGS ('dbx_business_glossary_term' = 'Field Of Use');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `indemnification_cap_usd` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Cap Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `ip_version` SET TAGS ('dbx_business_glossary_term' = 'Ip Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `license_scope` SET TAGS ('dbx_business_glossary_term' = 'License Scope');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `licensee_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `licensee_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `licensee_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `licensing_model` SET TAGS ('dbx_business_glossary_term' = 'Licensing Model');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `maximum_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `minimum_royalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Royalty Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Nre Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `per_unit_royalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Per Unit Royalty Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `royalty_cap_usd` SET TAGS ('dbx_business_glossary_term' = 'Royalty Cap Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Pct');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `signed_by_licensee` SET TAGS ('dbx_business_glossary_term' = 'Signed By Licensee');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `signed_by_licensor` SET TAGS ('dbx_business_glossary_term' = 'Signed By Licensor');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `license_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `sublicense_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Allowed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `support_level` SET TAGS ('dbx_business_glossary_term' = 'Support Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `total_contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_agreement` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` SET TAGS ('dbx_subdomain' = 'licensing_samples');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` SET TAGS ('dbx_association_edges' = 'product.ic_catalog,compliance.export_license');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` SET TAGS ('dbx_v2_verified' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` SET TAGS ('dbx_structure' = 'required');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `license_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'License Allocation Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocated_qty` SET TAGS ('dbx_business_glossary_term' = 'Allocated Qty');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocated_units` SET TAGS ('dbx_business_glossary_term' = 'Allocated Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocated_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `allocation_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Allocation Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `authorized_commodities` SET TAGS ('dbx_business_glossary_term' = 'Authorized Commodities');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `authorized_countries` SET TAGS ('dbx_business_glossary_term' = 'Authorized Countries');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `authorized_end_users` SET TAGS ('dbx_business_glossary_term' = 'Authorized End Users');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `consumed_qty` SET TAGS ('dbx_business_glossary_term' = 'Consumed Qty');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `consumed_units` SET TAGS ('dbx_business_glossary_term' = 'Consumed Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `consumed_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Consumed Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `diversion_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Diversion Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `eccn_classification` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `end_use_description` SET TAGS ('dbx_business_glossary_term' = 'End Use Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `end_use_statement` SET TAGS ('dbx_business_glossary_term' = 'End Use Statement');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `field_of_use` SET TAGS ('dbx_business_glossary_term' = 'Field Of Use');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `last_consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Consumption Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `last_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Shipment Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `remaining_qty` SET TAGS ('dbx_business_glossary_term' = 'Remaining Qty');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `remaining_units` SET TAGS ('dbx_business_glossary_term' = 'Remaining Units');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Restriction Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Shipment Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `license_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'License Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`license_allocation` ALTER COLUMN `value_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Value Limit Usd');
