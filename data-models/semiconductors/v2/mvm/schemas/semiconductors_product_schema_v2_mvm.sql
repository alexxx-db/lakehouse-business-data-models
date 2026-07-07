-- Schema for Domain: product | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`product` COMMENT 'Authoritative semiconductor product catalog encompassing ICs, SoCs, ASICs, FPGAs, IP cores, and discrete devices. SSOT for product specifications, SKUs, BOM, process node assignments, PPA metrics, product lifecycle status (NPI through EOL), PCN management, and LTB notifications. Integrates with PLM systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` (
    `ic_catalog_id` BIGINT COMMENT 'Primary key',
    `family_id` BIGINT COMMENT 'FK to product family',
    `package_type_id` BIGINT COMMENT 'FK to packaging package type',
    `process_node_id` BIGINT COMMENT 'FK to process node',
    `technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - products are manufactured on specific technology nodes',
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
    `ic_catalog_status` STRING COMMENT 'The status of the ic catalog record in the product domain.',
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
    `tapeout_date` DATE COMMENT 'The tapeout date associated with the ic catalog product record.',
    `target_market` STRING COMMENT 'Target market segment',
    `temperature_grade` STRING COMMENT 'The temperature grade of the ic catalog record in the product domain.',
    `transistor_count` BIGINT COMMENT 'The transistor count of the ic catalog record in the product domain.',
    CONSTRAINT pk_ic_catalog PRIMARY KEY(`ic_catalog_id`)
) COMMENT 'Master catalog of all IC products with lifecycle, compliance, and technical specifications. Authoritative source for product identity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key',
    `assembly_process_flow_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_process_flow. Business justification: Each orderable SKU is produced via a specific assembly process flow defining die attach, wire bond/flip-chip, and molding steps. Operations and supply chain teams need SKU-to-process-flow linkage for ',
    `package_type_id` BIGINT COMMENT 'FK to package type',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `osat_vendor_id` BIGINT COMMENT 'Foreign key linking to packaging.osat_vendor. Business justification: Each SKU is assembled at a primary qualified OSAT vendor — critical for supply chain sourcing, capacity planning, country-of-origin declarations on shipping documents, and customer-facing supply chain',
    `replacement_sku_id` BIGINT COMMENT 'FK to replacement SKU',
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
    `sku_status` STRING COMMENT 'The status of the sku record in the product domain.',
    `speed_grade` STRING COMMENT 'The speed grade of the sku record in the product domain.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Standard cost in USD',
    `standard_pack_quantity` STRING COMMENT 'The standard pack quantity of the sku record in the product domain.',
    `temperature_range` STRING COMMENT 'The temperature range of the sku record in the product domain.',
    `unit_weight_grams` DECIMAL(18,2) COMMENT 'Unit weight in grams',
    `voltage_variant` STRING COMMENT 'The voltage variant of the sku record in the product domain.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock-keeping unit representing an orderable, shippable product variant with pricing, compliance, and logistics attributes.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Primary key',
    `parent_family_id` BIGINT COMMENT 'FK to parent family',
    `osat_vendor_id` BIGINT COMMENT 'Foreign key linking to packaging.osat_vendor. Business justification: Product families have a primary qualified OSAT vendor for assembly. Sourcing, supply chain, and NPI teams use family-level OSAT qualification for vendor selection, capacity allocation, and risk manage',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Product families define supported package types for roadmap planning, NPI phase-gate reviews, and customer design-in guidance. Product line managers and marketing use family-level package type for por',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: family.process_node_nm is a denormalized integer (nanometers) representing the process technology node for the family. This duplicates data in process_node.minimum_feature_size_nm. Adding primary_proc',
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
    `family_status` STRING COMMENT 'The status of the family record in the product domain.',
    `family_type` STRING COMMENT 'Family type',
    `hierarchy_level` STRING COMMENT 'The hierarchy level of the family record in the product domain.',
    `ip_core_count` STRING COMMENT 'The ip core count of the family record in the product domain.',
    `itar_controlled_flag` BOOLEAN COMMENT 'The itar controlled flag of the family record in the product domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the family record in the product domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the family record in the product domain.',
    `lithography_type` STRING COMMENT 'The lithography type of the family record in the product domain.',
    `ltb_date` DATE COMMENT 'The ltb date associated with the family product record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the family record in the product domain.',
    `modified_by_user` STRING COMMENT 'The modified by user of the family record in the product domain.',
    `family_name` STRING COMMENT 'The family name of the family record in the product domain.',
    `notes` STRING COMMENT 'The notes of the family record in the product domain.',
    `npi_start_date` DATE COMMENT 'The npi start date associated with the family product record.',
    `pdk_version` STRING COMMENT 'The pdk version of the family record in the product domain.',
    `process_technology` STRING COMMENT 'The process technology of the family record in the product domain.',
    `product_line_manager` STRING COMMENT 'The product line manager of the family record in the product domain.',
    `qualification_standard` STRING COMMENT 'The qualification standard of the family record in the product domain.',
    `reach_compliant_flag` BOOLEAN COMMENT 'The reach compliant flag of the family record in the product domain.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'The rohs compliant flag of the family record in the product domain.',
    `target_performance_metric` STRING COMMENT 'The target performance metric of the family record in the product domain.',
    `target_power_mw` DECIMAL(18,2) COMMENT 'Target power in mW',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'The target yield percent of the family record in the product domain.',
    `typical_die_size_mm2` DECIMAL(18,2) COMMENT 'Typical die size in mm2',
    `volume_production_date` DATE COMMENT 'The volume production date associated with the family product record.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Product family grouping related IC products by architecture, process node, and market segment for portfolio management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`process_node` (
    `process_node_id` BIGINT COMMENT 'Primary key',
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
    `process_node_status` STRING COMMENT 'The status of the process node record in the product domain.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the process node product record.',
    `qualification_status` STRING COMMENT 'The qualification status of the process node record in the product domain.',
    `supported_device_types` STRING COMMENT 'The supported device types of the process node record in the product domain.',
    `technology_readiness_level` STRING COMMENT 'The technology readiness level of the process node record in the product domain.',
    `transistor_architecture` STRING COMMENT 'The transistor architecture of the process node record in the product domain.',
    `wafer_size_mm` STRING COMMENT 'Wafer size in mm',
    CONSTRAINT pk_process_node PRIMARY KEY(`process_node_id`)
) COMMENT 'Semiconductor process technology node definition with lithography, architecture, and qualification parameters.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_spec` (
    `product_spec_id` BIGINT COMMENT 'Primary key',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Product specs (thermal resistance, max power, operating temperature) are package-specific. Datasheet generation, customer qualification reports, and AEC-Q100 submissions require spec-to-package linkag',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the primary ic catalog record within the product spec product entity.',
    `primary_product_ic_catalog_id` BIGINT COMMENT 'FK to product IC catalog',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: product_spec.process_node_nm is a denormalized integer (nanometers) that duplicates data already captured in process_node.minimum_feature_size_nm. Adding spec_process_node_id as a FK to process_node.p',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
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
    `product_spec_status` STRING COMMENT 'The status of the product spec record in the product domain.',
    `reach_compliant` BOOLEAN COMMENT 'The reach compliant of the product spec record in the product domain.',
    `rohs_compliant` BOOLEAN COMMENT 'The rohs compliant of the product spec record in the product domain.',
    `security_features` STRING COMMENT 'The security features of the product spec record in the product domain.',
    `spec_status` STRING COMMENT 'The spec status of the product spec record in the product domain.',
    `transistor_architecture` STRING COMMENT 'The transistor architecture of the product spec record in the product domain.',
    `transistor_count` BIGINT COMMENT 'The transistor count of the product spec record in the product domain.',
    `version` STRING COMMENT 'Version or revision identifier of the product spec product record.',
    CONSTRAINT pk_product_spec PRIMARY KEY(`product_spec_id`)
) COMMENT 'Detailed product specification covering electrical, thermal, and mechanical parameters with target vs achieved metrics.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`bom` (
    `bom_id` BIGINT COMMENT 'Primary key',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: BOM material sets (substrate, mold compound, die attach) differ by package type. Procurement and manufacturing engineering reference BOM-to-package-type for correct material selection, ECO management,',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `alternative_bom_indicator` STRING COMMENT 'The alternative bom indicator of the bom record in the product domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the bom product record.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The base quantity of the bom record in the product domain.',
    `base_unit_of_measure` STRING COMMENT 'The base unit of measure of the bom record in the product domain.',
    `bom_status` STRING COMMENT 'BOM status',
    `bom_type` STRING COMMENT 'The type of the bom record in the product domain.',
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
    `total_component_count` STRING COMMENT 'The total component count of the bom record in the product domain.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'The total material cost of the bom record in the product domain.',
    `usage` STRING COMMENT 'The usage of the bom record in the product domain.',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of materials header defining the component structure for an IC product with compliance and cost tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Primary key',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: bom_line.component_part_number and manufacturer_part_number are free-text fields that may reference ICs in the catalog. When a BOM component is itself an IC product in the catalog (common in SoC and m',
    `parent_line_bom_line_id` BIGINT COMMENT 'FK to parent line',
    `bom_id` BIGINT COMMENT 'Unique identifier for the primary bom record within the bom line product entity.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Each BOM line component in semiconductor manufacturing has an associated incoming quality control spec (IQC). Component qualification and supplier quality programs require linking BOM line items to th',
    `to_bom_id` BIGINT COMMENT 'Unique identifier for the to bom record within the bom line product entity.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the bom line record in the product domain.',
    `approved_substitute_part_numbers` STRING COMMENT 'The approved substitute part numbers of the bom line record in the product domain.',
    `assembly_process_code` STRING COMMENT 'Coded value representing the assembly process code of the bom line product record.',
    `bom_level` STRING COMMENT 'The bom level of the bom line record in the product domain.',
    `bom_line_status` STRING COMMENT 'The status of the bom line record in the product domain.',
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
    `unit_of_measure` STRING COMMENT 'The unit of measure of the bom line record in the product domain.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual line item in a bill of materials specifying component, quantity, sourcing, and compliance details.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` (
    `compliance_cert_id` BIGINT COMMENT 'Primary key',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Compliance certifications (RoHS, AEC-Q100, REACH) are often package-specific — a cert covers a specific IC in a specific package form factor. Regulatory reporting, customer compliance declarations, an',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: compliance_cert currently links to ic_catalog (product level) but compliance certifications in semiconductor practice are often SKU-specific — a particular package variant (SKU) may have different RoH',
    `osat_vendor_id` BIGINT COMMENT 'Foreign key linking to packaging.osat_vendor. Business justification: AEC-Q100 and IATF 16949 compliance certifications are OSAT-site-specific — the cert is valid only for assembly performed at the qualifying OSAT. Quality and regulatory teams track which OSAT performed',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Customer contracts in semiconductors frequently mandate specific compliance certifications (AEC-Q100, IATF 16949, RoHS declarations) as contractual obligations. Linking compliance_cert to customer_con',
    `ic_catalog_id` BIGINT COMMENT 'FK to primary IC catalog',
    `applicable_markets` STRING COMMENT 'The applicable markets of the compliance cert record in the product domain.',
    `applicable_regions` STRING COMMENT 'The applicable regions of the compliance cert record in the product domain.',
    `auditor_name` STRING COMMENT 'The auditor name of the compliance cert record in the product domain.',
    `automotive_grade_certified` BOOLEAN COMMENT 'The automotive grade certified of the compliance cert record in the product domain.',
    `certification_body` STRING COMMENT 'The certification body of the compliance cert record in the product domain.',
    `certification_number` STRING COMMENT 'The certification number of the compliance cert record in the product domain.',
    `certification_scope` STRING COMMENT 'The certification scope of the compliance cert record in the product domain.',
    `certification_status` STRING COMMENT 'The certification status of the compliance cert record in the product domain.',
    `certification_type` STRING COMMENT 'The certification type of the compliance cert record in the product domain.',
    `compliance_cert_status` STRING COMMENT 'The status of the compliance cert record in the product domain.',
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
    `supporting_documentation_url` STRING COMMENT 'The supporting documentation url of the compliance cert record in the product domain.',
    `test_laboratory` STRING COMMENT 'The test laboratory of the compliance cert record in the product domain.',
    `test_report_number` STRING COMMENT 'The test report number of the compliance cert record in the product domain.',
    CONSTRAINT pk_compliance_cert PRIMARY KEY(`compliance_cert_id`)
) COMMENT 'Compliance certification record for environmental, safety, and export control standards applicable to IC products.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_replacement_sku_id` FOREIGN KEY (`replacement_sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_primary_product_ic_catalog_id` FOREIGN KEY (`primary_product_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_parent_line_bom_line_id` FOREIGN KEY (`parent_line_bom_line_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_to_bom_id` FOREIGN KEY (`to_bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Process Node Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_catalog_status` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Status');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Osat Vendor Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `replacement_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Sku Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'Sku Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Standard Pack Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `unit_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight Grams');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_business_glossary_term' = 'Voltage Variant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Osat Vendor Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Process Node Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_status` SET TAGS ('dbx_business_glossary_term' = 'Family Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Family Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Itar Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ltb_date` SET TAGS ('dbx_business_glossary_term' = 'Ltb Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `npi_start_date` SET TAGS ('dbx_business_glossary_term' = 'Npi Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Pdk Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `product_line_manager` SET TAGS ('dbx_business_glossary_term' = 'Product Line Manager');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Target Power Mw');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `typical_die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Typical Die Size Mm2');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `volume_production_date` SET TAGS ('dbx_business_glossary_term' = 'Volume Production Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `process_node_status` SET TAGS ('dbx_business_glossary_term' = 'Process Node Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `supported_device_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Types');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`process_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_subdomain' = 'technical_specification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `primary_product_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `product_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Spec Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_subdomain' = 'technical_specification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bom Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bom Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bom Type');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_component_count` SET TAGS ('dbx_business_glossary_term' = 'Total Component Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Usage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'technical_specification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Component Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `parent_line_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line Bom Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `to_bom_id` SET TAGS ('dbx_business_glossary_term' = 'To Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `approved_substitute_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Approved Substitute Part Numbers');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `assembly_process_code` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'Bom Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Status');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_subdomain' = 'technical_specification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cert Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Osat Vendor Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regions');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `automotive_grade_certified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade Certified');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_cert_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cert Status');
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
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Url');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `test_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Test Laboratory');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
