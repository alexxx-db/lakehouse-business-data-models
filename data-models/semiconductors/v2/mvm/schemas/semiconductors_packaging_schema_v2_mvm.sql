-- Schema for Domain: packaging | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:14:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`packaging` COMMENT 'Die packaging and assembly operations covering all package types including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip, wire bonding, and traditional leadframe/BGA formats. Manages OSAT partnerships, assembly process flows, substrate BOMs, package qualification, and assembly yield data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` (
    `assembly_order_id` BIGINT COMMENT 'Primary key for assembly_order',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who requested the assembly order.',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Contract fulfillment tracking: assembly orders are executed against customer supply contracts for pricing, volume commitment tracking, and PCN/EOL obligation compliance. Procurement and supply chain t',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Required for linking each assembly order to the specific customer design win that authorizes production, used in the Order Fulfillment process.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the primary equipment used for the assembly.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Production Planning to associate each assembly order with the exact IC design.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Custom packaging projects are driven by sales opportunities; linking ties assembly orders to the originating opportunity for forecasting.',
    `osat_vendor_id` BIGINT COMMENT 'Identifier of the outsourced assembly partner responsible for execution.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Every assembly order specifies a package type. This FK is essential for filtering orders by package format, capacity planning, and routing to qualified OSAT sites.',
    `actual_completion_date` DATE COMMENT 'The actual completion date associated with the assembly order packaging record.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Yield percentage achieved after assembly completion.',
    `assembly_order_status` STRING COMMENT 'Current lifecycle state of the assembly order.. Valid values are `released|in_process|completed|on_hold|cancelled`',
    `assembly_site` STRING COMMENT 'Code of the facility where the assembly is performed.',
    `completed_quantity` STRING COMMENT 'The completed quantity of the assembly order record in the packaging domain.',
    `completion_date` DATE COMMENT 'Date when the assembly work was completed.',
    `cost_adjustment_amount` DECIMAL(18,2) COMMENT 'Any cost adjustments (e.g., discounts, fees) applied to the gross amount.',
    `cost_gross_amount` DECIMAL(18,2) COMMENT 'Estimated total cost before any adjustments.',
    `cost_net_amount` DECIMAL(18,2) COMMENT 'Final cost after adjustments, representing the amount to be billed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assembly order record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amounts.. Valid values are `USD|EUR|JPY|CNY|GBP|CAD`',
    `defect_count` STRING COMMENT 'Number of defects recorded during assembly.',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'Target yield percentage expected for the assembly run.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the order is currently on hold.',
    `inspection_status` STRING COMMENT 'Result of the final inspection for the assembled package.. Valid values are `pending|passed|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly order record in the packaging domain.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly order record in the packaging domain.',
    `notes` STRING COMMENT 'Free‑form comments or remarks related to the order.',
    `number` STRING COMMENT 'The number of the assembly order record in the packaging domain.',
    `order_number` STRING COMMENT 'Business-visible alphanumeric identifier assigned to the assembly order.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the assembly order was initially placed.',
    `order_quantity` STRING COMMENT 'The order quantity of the assembly order record in the packaging domain.',
    `order_source` STRING COMMENT 'Origin of the order request.. Valid values are `internal|osat|external`',
    `ordered_quantity` STRING COMMENT 'The ordered quantity of the assembly order record in the packaging domain.',
    `planned_completion_date` DATE COMMENT 'The planned completion date associated with the assembly order packaging record.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the assembly order packaging record.',
    `priority` STRING COMMENT 'Business priority assigned to the assembly order.. Valid values are `low|medium|high|critical`',
    `priority_class` STRING COMMENT 'The priority class of the assembly order record in the packaging domain.',
    `quantity_ordered` STRING COMMENT 'Number of die units requested for assembly.',
    `release_date` DATE COMMENT 'Date when the order was released for execution.',
    `special_handling_instructions` STRING COMMENT 'Any additional instructions required for the assembly (e.g., cleanroom level, moisture sensitivity).',
    `target_ship_date` DATE COMMENT 'Planned date for shipment of the completed assembly.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assembly order record.',
    CONSTRAINT pk_assembly_order PRIMARY KEY(`assembly_order_id`)
) COMMENT 'Primary transactional record for die packaging and assembly work orders issued to OSAT partners or internal assembly lines. Captures assembly order number, package type (WLCSP, InFO, CoWoS, flip-chip, wire bond, BGA, leadframe), die lot reference, substrate lot, quantity ordered, target ship date, assembly site, process flow revision, and order status lifecycle (released, in-process, completed, on-hold). SSOT for all assembly execution events in the packaging domain. Shipment logistics and delivery tracking are owned by the order domain; cost accounting is owned by the finance domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` (
    `package_type_id` BIGINT COMMENT 'Primary key for package_type',
    `ball_count` STRING COMMENT 'The ball count of the package type record in the packaging domain.',
    `ball_count_max` STRING COMMENT 'Maximum number of solder balls for BGA‑type packages.',
    `ball_count_min` STRING COMMENT 'Minimum number of solder balls for BGA‑type packages.',
    `body_size_mm` STRING COMMENT 'The body size mm of the package type record in the packaging domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the package type record was first created in the system.',
    `package_type_description` STRING COMMENT 'Free‑form description of the package’s mechanical and electrical characteristics.',
    `effective_from` DATE COMMENT 'Date on which the package type becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the package type is no longer valid (null if indefinite).',
    `halogen_free` BOOLEAN COMMENT 'The halogen free of the package type record in the packaging domain.',
    `is_3d_ic` BOOLEAN COMMENT 'True if the package incorporates through‑silicon vias or other 3‑D stacking.',
    `is_advanced_package` BOOLEAN COMMENT 'True for cutting‑edge or specialty package formats.',
    `is_ball_grid_array` BOOLEAN COMMENT 'True if the package is a ball‑grid array type.',
    `is_flip_chip` BOOLEAN COMMENT 'True if the package utilizes flip‑chip interconnect technology.',
    `is_heterogeneous_integration` BOOLEAN COMMENT 'Indicates whether the package supports heterogeneous integration (e.g., chip‑on‑wafer).',
    `is_itar_controlled` BOOLEAN COMMENT 'True if the package is subject to International Traffic in Arms Regulations.',
    `is_leadframe` BOOLEAN COMMENT 'True if the package uses a traditional leadframe.',
    `is_osat_supported` BOOLEAN COMMENT 'True if the package type is commonly offered by outsourced assembly providers.',
    `is_reach_compliant` BOOLEAN COMMENT 'True if the package complies with REACH chemical safety regulations.',
    `is_rohs_compliant` BOOLEAN COMMENT 'True if the package meets RoHS restriction requirements.',
    `is_wire_bond` BOOLEAN COMMENT 'True if the package uses wire‑bond interconnects.',
    `jedec_outline_code` STRING COMMENT 'Official JEDEC outline identifier for the package (e.g., 5x5‑1mm).',
    `jedec_standard` STRING COMMENT 'The jedec standard of the package type record in the packaging domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the package type record in the packaging domain.',
    `lead_count` STRING COMMENT 'The lead count of the package type record in the packaging domain.',
    `lead_free` BOOLEAN COMMENT 'The lead free of the package type record in the packaging domain.',
    `lead_free_flag` BOOLEAN COMMENT 'The lead free flag of the package type record in the packaging domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the package type record in the packaging domain.',
    `max_current_a` DECIMAL(18,2) COMMENT 'Maximum continuous current rating for the package.',
    `max_die_pitch_um` DECIMAL(18,2) COMMENT 'Maximum center‑to‑center spacing between dies for multi‑die packages.',
    `max_junction_temp_c` DECIMAL(18,2) COMMENT 'The max junction temp c of the package type record in the packaging domain.',
    `max_operating_temperature_c` DECIMAL(18,2) COMMENT 'Highest temperature at which the package can reliably operate.',
    `max_power_dissipation_w` DECIMAL(18,2) COMMENT 'Maximum power the package can dissipate safely.',
    `max_voltage_v` DECIMAL(18,2) COMMENT 'Maximum voltage rating the package can withstand.',
    `min_die_pitch_um` DECIMAL(18,2) COMMENT 'Minimum center‑to‑center spacing between dies for multi‑die packages.',
    `min_operating_temperature_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which the package can reliably operate.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the package type record in the packaging domain.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC‑defined moisture sensitivity classification.. Valid values are `MSL1|MSL2|MSL3|MSL4|MSL5|MSL6`',
    `notes` STRING COMMENT 'The notes of the package type record in the packaging domain.',
    `package_category` STRING COMMENT 'Primary category of the package format; limited to six most common values.. Valid values are `wlcsp|info|cowos|tsv_3d|flip_chip|wire_bond`',
    `package_code` STRING COMMENT 'Coded value representing the package code of the package type packaging record.',
    `package_dimensions_height_um` DECIMAL(18,2) COMMENT 'External height (thickness) dimension of the package.',
    `package_dimensions_length_um` DECIMAL(18,2) COMMENT 'External length dimension of the package.',
    `package_dimensions_width_um` DECIMAL(18,2) COMMENT 'External width dimension of the package.',
    `package_family` STRING COMMENT 'Higher‑level family grouping (e.g., Wafer‑Level, Flip‑Chip, 3D‑IC).',
    `package_height_mm` DECIMAL(18,2) COMMENT 'The package height mm of the package type record in the packaging domain.',
    `package_material` STRING COMMENT 'Primary material used for the package substrate.. Valid values are `organic|ceramic|metal|plastic`',
    `package_name` STRING COMMENT 'Human‑readable name of the package format (e.g., WLCSP, CoWoS).',
    `package_type_status` STRING COMMENT 'Current lifecycle status of the package type.. Valid values are `active|inactive|deprecated`',
    `pin_count` STRING COMMENT 'The pin count of the package type record in the packaging domain.',
    `pin_count_max` STRING COMMENT 'Maximum number of electrical pins/balls the package can support.',
    `pin_count_min` STRING COMMENT 'Minimum number of electrical pins/balls the package can support.',
    `pitch_mm` DECIMAL(18,2) COMMENT 'The pitch mm of the package type record in the packaging domain.',
    `qualification_status` STRING COMMENT 'Current qualification state of the package format.. Valid values are `qualified|pending|rejected`',
    `reach_compliant` BOOLEAN COMMENT 'The reach compliant of the package type record in the packaging domain.',
    `reference_document` STRING COMMENT 'Identifier or URL of the primary specification document for the package type.',
    `rohs_compliant` BOOLEAN COMMENT 'The rohs compliant of the package type record in the packaging domain.',
    `substrate_type` STRING COMMENT 'The substrate type of the package type record in the packaging domain.',
    `thermal_resistance_c_per_w` DECIMAL(18,2) COMMENT 'Thermal resistance from die to ambient, expressed in degrees Celsius per Watt.',
    `thermal_resistance_ja` DECIMAL(18,2) COMMENT 'The thermal resistance ja of the package type record in the packaging domain.',
    `typical_thickness_um` DECIMAL(18,2) COMMENT 'Nominal vertical thickness of the finished package.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the package type record.',
    CONSTRAINT pk_package_type PRIMARY KEY(`package_type_id`)
) COMMENT 'Reference master for all semiconductor package formats supported by Semiconductors, including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip BGA, wire-bond QFN, leadframe DIP/QFP, and advanced heterogeneous integration formats. Stores package family, body dimensions, pin/ball count range, thermal resistance specs, moisture sensitivity level (MSL), JEDEC outline code, and qualification status. SSOT for package format classification used across assembly, product catalog, and qualification domains.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` (
    `osat_vendor_id` BIGINT COMMENT 'Unique surrogate key for OSAT vendor record.',
    `aec_q100_certified` BOOLEAN COMMENT 'Indicates if the vendor holds AEC-Q100 qualification.',
    `audit_score` DECIMAL(18,2) COMMENT 'Score from the latest audit (0-100).',
    `capacity_tier` STRING COMMENT 'Capacity tier classification for the vendors assembly lines.. Valid values are `Low|Medium|High|VeryHigh`',
    `capacity_units_per_month` STRING COMMENT 'The capacity units per month of the osat vendor record in the packaging domain.',
    `certifications` STRING COMMENT 'The certifications of the osat vendor record in the packaging domain.',
    `contact_email` STRING COMMENT 'The contact email of the osat vendor record in the packaging domain.',
    `country` STRING COMMENT 'The country of the osat vendor record in the packaging domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created.',
    `dppm_rate` DECIMAL(18,2) COMMENT 'Historical DPPM rate of the vendors assembly processes.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the vendor.',
    `export_control_classification` STRING COMMENT 'Export control regime applicable to the vendor.. Valid values are `EAR|ITAR|None`',
    `iatf_16949_certified` BOOLEAN COMMENT 'Indicates if the vendor holds IATF 16949 certification.',
    `is_active` BOOLEAN COMMENT 'The is active of the osat vendor record in the packaging domain.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates if the vendor holds ISO 9001 certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit performed on the vendor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the osat vendor record in the packaging domain.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the vendor record.. Valid values are `Active|Inactive|Onboarding|Offboarded`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the osat vendor record in the packaging domain.',
    `nda_ip_protection` BOOLEAN COMMENT 'Indicates whether a non-disclosure agreement and IP protection are in place.',
    `notes` STRING COMMENT 'Free-form notes regarding the vendor.',
    `osat_vendor_status` STRING COMMENT 'The status of the osat vendor record in the packaging domain.',
    `partnership_status` STRING COMMENT 'Current qualification status of the vendor within the OSAT program.. Valid values are `Approved|Preferred|Probation|Suspended|Terminated`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the vendor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the osat vendor packaging record.',
    `qualification_status` STRING COMMENT 'The qualification status of the osat vendor record in the packaging domain.',
    `quality_certifications` STRING COMMENT 'Semicolon-separated list of quality certifications held by the vendor (e.g., IATF 16949, ISO 9001, AEC-Q100).',
    `quality_rating` DECIMAL(18,2) COMMENT 'The quality rating of the osat vendor record in the packaging domain.',
    `scorecard_rating` DECIMAL(18,2) COMMENT 'The scorecard rating of the osat vendor record in the packaging domain.',
    `site_location` STRING COMMENT 'The site location of the osat vendor record in the packaging domain.',
    `standard_lead_time_days` STRING COMMENT 'Typical lead time in days for standard package orders.',
    `tax_identifier` STRING COMMENT 'Government tax identifier for the vendor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor record.',
    `vendor_address` STRING COMMENT 'Physical address of the vendors primary site.',
    `vendor_code` STRING COMMENT 'Unique vendor code used in ERP and PLM systems.',
    `vendor_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the vendors headquarters. [ENUM-REF-CANDIDATE: USA|CHN|KOR|JPN|TWN|DEU|... — promote to reference product]',
    `vendor_name` STRING COMMENT 'Legal name of the OSAT vendor as registered.',
    `vendor_short_name` STRING COMMENT 'Commonly used short name or abbreviation for the vendor.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on ownership and relationship.. Valid values are `OSAT|Internal|ThirdParty|JointVenture`',
    CONSTRAINT pk_osat_vendor PRIMARY KEY(`osat_vendor_id`)
) COMMENT 'Master record for Outsourced Semiconductor Assembly and Test (OSAT) partners and internal assembly sites used by Semiconductors. Captures vendor legal name, site locations, approved package type capabilities, quality certifications (IATF 16949, ISO 9001, AEC-Q100), historical DPPM performance, capacity tiers, standard lead times, NDA/IP protection status, export control classification (EAR/ITAR), and approved/preferred/probation status. SSOT for OSAT partner identity and qualification status within the packaging domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` (
    `assembly_process_flow_id` BIGINT COMMENT 'Unique system-generated identifier for each assembly process flow definition.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Process flows are defined per package type. A package type may have multiple flow revisions but each flow targets a specific package format.',
    `osat_vendor_id` BIGINT COMMENT 'Unique identifier for the osat vendor record within the assembly process flow packaging entity.',
    `primary_assembly_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Process flows are defined per package type. Required for routing and DFM constraint validation.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process Flow Definition uses a specific process node; required for Process Flow Specification report.',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Technology node directly determines qualified assembly process flows: advanced nodes (7nm, 5nm) mandate flip-chip with specific bump pitches, while mature nodes use wire bond. Process engineers select',
    `assembly_process_flow_status` STRING COMMENT 'Current lifecycle status of the flow definition.. Valid values are `active|inactive|draft|deprecated|retired`',
    `bond_type` STRING COMMENT 'Primary interconnect technology employed in the flow.. Valid values are `wire_bond|flip_chip|bump|csp|none|other`',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that this flow must satisfy.. Valid values are `SEMI|JEDEC|ISO9001|ISO14001|ITAR|EAR`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the assembly process flow record in the packaging domain.',
    `assembly_process_flow_description` STRING COMMENT 'Detailed free‑text description of the flow, its purpose, and scope.',
    `dfm_constraints` STRING COMMENT 'Free‑text list of DFM rules or constraints that must be obeyed for this flow.',
    `die_attach_method` STRING COMMENT 'Method used to attach the die to the substrate.. Valid values are `epoxy|solder|flip_chip|thermo_compression|csp|none`',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the assembly process flow packaging record.',
    `effective_from` DATE COMMENT 'Date on which the flow becomes valid for use.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the assembly process flow packaging record.',
    `effective_until` DATE COMMENT 'Date after which the flow is no longer valid (null if open‑ended).',
    `equipment_class` STRING COMMENT 'High‑level classification of equipment required for the flow (e.g., "Flip‑Chip Bonder", "Mold Press").',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'The estimated cycle time days of the assembly process flow record in the packaging domain.',
    `estimated_cycle_time_hours` DECIMAL(18,2) COMMENT 'The estimated cycle time hours of the assembly process flow record in the packaging domain.',
    `final_inspection_type` STRING COMMENT 'Primary inspection technique performed after assembly completion.. Valid values are `visual|automated|xray|acoustic|none|custom`',
    `flow_code` STRING COMMENT 'Coded value representing the flow code of the assembly process flow packaging record.',
    `flow_description` STRING COMMENT 'The flow description of the assembly process flow record in the packaging domain.',
    `flow_name` STRING COMMENT 'Human‑readable name describing the assembly process flow (e.g., "Advanced 3D‑IC Flip‑Chip Flow").',
    `flow_status` STRING COMMENT 'The flow status of the assembly process flow record in the packaging domain.',
    `flow_version` STRING COMMENT 'The flow version of the assembly process flow record in the packaging domain.',
    `is_default_flow` BOOLEAN COMMENT 'Flag indicating whether this flow is the default for its package type.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly process flow record in the packaging domain.',
    `marking_method` STRING COMMENT 'Method used to apply identification marks to the finished package.. Valid values are `laser|ink|dot_peen|none|silk_screen|etch`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly process flow record in the packaging domain.',
    `molding_material` STRING COMMENT 'Encapsulation material applied during the molding step.. Valid values are `epoxy|plastic|ceramic|none|custom|silicone`',
    `notes` STRING COMMENT 'The notes of the assembly process flow record in the packaging domain.',
    `process_time_target` DECIMAL(18,2) COMMENT 'Target total processing time for the flow, expressed in minutes.',
    `process_yield_target` DECIMAL(18,2) COMMENT 'Target yield percentage for the flow (e.g., 98.75).',
    `qualification_status` STRING COMMENT 'The qualification status of the assembly process flow record in the packaging domain.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the flow record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the flow record.',
    `revision_number` STRING COMMENT 'Sequential revision number of the flow definition.',
    `safety_classification` STRING COMMENT 'Safety level assigned to the flow (e.g., "Class A – Low Hazard").',
    `singulation_method` STRING COMMENT 'Technique used to separate individual packages from the wafer or panel.. Valid values are `laser|saw|plasma|mechanical|waterjet|none`',
    `step_count` STRING COMMENT 'Total count of discrete steps defined in the flow.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'The target yield percent of the assembly process flow record in the packaging domain.',
    `underfill_material` STRING COMMENT 'Material used to fill the gap between die and substrate after bonding.. Valid values are `epoxy|silicone|none|custom|organic|inorganic`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the flow record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the assembly process flow record in the packaging domain.',
    CONSTRAINT pk_assembly_process_flow PRIMARY KEY(`assembly_process_flow_id`)
) COMMENT 'Master definition of the step-by-step assembly process flow for each package type and product combination. Captures flow revision, process steps (die attach, wire bond/flip-chip bump, underfill, molding, singulation, marking, final inspection), equipment class per step, material specifications, and DFM constraints. Linked to package type and product SKU. Enables traceability from assembly order to process specification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` (
    `substrate_bom_id` BIGINT COMMENT 'Unique surrogate key for each substrate BOM record.',
    `assembly_process_flow_id` BIGINT COMMENT 'Unique identifier for the assembly process flow record within the substrate bom packaging entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Substrate BOM is generated per IC design; linking enables BOM cost roll‑up per product.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Substrate BOMs are defined for specific package types (CoWoS interposer, flip-chip BGA substrate, etc.).',
    `primary_substrate_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Substrate BOMs are specific to a package type. Required for procurement and assembly material planning.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Substrate BOM components (substrate, underfill, mold compound) correspond to raw material inventory items. This FK enables BOM-to-inventory availability checks, material procurement planning, and RoHS',
    `to_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Substrate BOMs are defined per package type. Required for material planning and assembly order material allocation.',
    `avl_status` STRING COMMENT 'AVL qualification status of the substrate supplier.. Valid values are `approved|pending|rejected`',
    `bom_code` STRING COMMENT 'Coded value representing the bom code of the substrate bom packaging record.',
    `bom_number` STRING COMMENT 'The bom number of the substrate bom record in the packaging domain.',
    `bump_pitch_um` DECIMAL(18,2) COMMENT 'Center‑to‑center distance between bumps on the substrate, expressed in micrometers.',
    `classification` STRING COMMENT 'Classification indicating performance tier or special characteristics.. Valid values are `standard|high_performance|low_k`',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the substrate.. Valid values are `compliant|non_compliant|pending`',
    `component_part_number` STRING COMMENT 'The component part number of the substrate bom record in the packaging domain.',
    `core_material` STRING COMMENT 'Primary material of the substrate core (e.g., ABF, BT resin, silicon, glass).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM record was first created.',
    `currency` STRING COMMENT 'Currency code for the unit cost.. Valid values are `USD|EUR|JPY|CNY`',
    `density_g_per_cm3` DECIMAL(18,2) COMMENT 'Material density of the substrate.',
    `dielectric_constant` DECIMAL(18,2) COMMENT 'Relative permittivity of the substrate material.',
    `effective_from` DATE COMMENT 'Date from which this BOM revision is valid for procurement.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the substrate bom packaging record.',
    `effective_until` DATE COMMENT 'Date until which this BOM revision remains valid (null if open‑ended).',
    `is_obsolete` BOOLEAN COMMENT 'Indicates whether the substrate is marked as obsolete.',
    `last_eco_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent engineering change order affecting this BOM.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the substrate bom record in the packaging domain.',
    `layer_count` STRING COMMENT 'Number of material layers in the substrate stack.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle phase of the substrate product.. Valid values are `in_design|in_production|end_of_life`',
    `material_description` STRING COMMENT 'The material description of the substrate bom record in the packaging domain.',
    `material_grade` STRING COMMENT 'Grade or quality level of the substrate material.',
    `max_operating_temp_c` DECIMAL(18,2) COMMENT 'Maximum temperature at which the substrate can reliably operate.',
    `min_operating_temp_c` DECIMAL(18,2) COMMENT 'Minimum temperature for reliable substrate operation.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the substrate bom record in the packaging domain.',
    `substrate_bom_name` STRING COMMENT 'Human‑readable name or description of the substrate.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the substrate BOM.',
    `pad_finish` STRING COMMENT 'Surface finish applied to substrate pads (e.g., ENIG, OSP, immersion tin, gold).. Valid values are `ENIG|OSP|immersion_tin|gold`',
    `part_number` STRING COMMENT 'Manufacturer-assigned part number identifying the substrate.',
    `quantity_per_unit` DECIMAL(18,2) COMMENT 'The quantity per unit of the substrate bom record in the packaging domain.',
    `rdl_spec` STRING COMMENT 'Specification details of the redistribution layer (RDL) used on the substrate.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the substrate complies with REACH chemical safety requirements.',
    `revision` STRING COMMENT 'Version or revision identifier of the substrate bom packaging record.',
    `revision_date` DATE COMMENT 'Date when the current revision was released.',
    `revision_number` STRING COMMENT 'Revision identifier for the BOM version.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the substrate complies with RoHS restrictions.',
    `substrate_bom_status` STRING COMMENT 'Current lifecycle status of the BOM record.. Valid values are `active|inactive|obsolete|draft`',
    `substrate_material` STRING COMMENT 'The substrate material of the substrate bom record in the packaging domain.',
    `substrate_supplier_name` STRING COMMENT 'The substrate supplier name of the substrate bom record in the packaging domain.',
    `substrate_supplier_part` STRING COMMENT 'The substrate supplier part of the substrate bom record in the packaging domain.',
    `substrate_type` STRING COMMENT 'Category of substrate used in packaging (e.g., interposer, die, panel, wafer).. Valid values are `interposer|die|panel|wafer`',
    `supplier_part_number` STRING COMMENT 'Part number used by the supplier for this substrate.',
    `thermal_conductivity_w_per_mk` DECIMAL(18,2) COMMENT 'Thermal conductivity of the substrate material.',
    `thickness_um` DECIMAL(18,2) COMMENT 'Physical thickness of the substrate in micrometers.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Reference cost per unit of substrate (excluding taxes and freight).',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the substrate bom record in the packaging domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOM record.',
    CONSTRAINT pk_substrate_bom PRIMARY KEY(`substrate_bom_id`)
) COMMENT 'Bill of Materials for packaging substrates and interposers used in advanced semiconductor packages. Captures substrate part number, layer count, core material (ABF, BT resin, silicon interposer, glass core), redistribution layer (RDL) specs, bump pitch, pad finish (ENIG, OSP, immersion tin), supplier, AVL status, unit cost reference, RoHS/REACH compliance flag, and revision history with ECO traceability. SSOT for substrate material specifications enabling procurement and assembly execution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` (
    `assembly_lot_id` BIGINT COMMENT 'Unique system-generated identifier for the assembly lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer account traceability on assembly lots is required for customer-facing quality documentation, SCAR reports, and delivery tracking. Semiconductor OSAT operations must trace every lot to the ord',
    `package_type_id` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Each assembly lot is for a specific package type. Required for WIP reporting and routing.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Lot-level shipment traceability: assembly lots are shipped against specific customer bookings. Automotive and industrial customers require lot-to-booking traceability for AEC-Q100 compliance, quality ',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Assembly lots are produced to fulfill a customer design win. Production ramp tracking, yield reporting by design win, and customer delivery commitment management all require direct traceability from a',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Yield and defect analysis per IC design needs the lot to reference its IC catalog entry.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Supports Lot Traceability workflow linking each assembly lot to the preceding inspection lot for defect tracking across packaging.',
    `assembly_order_id` BIGINT COMMENT 'FK to packaging.assembly_order.assembly_order_id — Assembly lots are created under an assembly order. This is the primary parent-child relationship for WIP tracking.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Each lot is processed at a specific OSAT site. Required for site-level yield analysis and capacity tracking.',
    `primary_assembly_package_type_id` BIGINT COMMENT 'Unique identifier for the assembly package type record within the assembly lot packaging entity.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: Change management requires assembly lots to be traceable to the specific design revision of the assembled die. If a design revision changes pad locations or die size, in-flight assembly lots must be f',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Logistics and Inventory Valuation require storing the location of each assembled package for warehouse management.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Assembly lots are built from die that passed wafer probe. Linking assembly_lot to the wafer_probe_run that qualified the die supply is fundamental KGD traceability — required for probe-to-package yiel',
    `actual_completion_date` DATE COMMENT 'Date when the lot was actually completed; may be null if not yet finished.',
    `assembly_lot_status` STRING COMMENT 'The status of the assembly lot record in the packaging domain.',
    `assembly_site` STRING COMMENT 'Name of the OSAT vendor or internal fab where the lot is assembled.',
    `completion_date` DATE COMMENT 'The completion date associated with the assembly lot packaging record.',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp of the assembly lot record in the packaging domain.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated monetary cost of assembling the lot, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assembly lot record was first created in the system.',
    `cumulative_yield_percent` DECIMAL(18,2) COMMENT 'Overall percentage of good dies produced from the lot after each process step.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values associated with the lot.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `current_process_step` STRING COMMENT 'The most recent manufacturing step the lot has completed or is currently executing.',
    `defect_density` DECIMAL(18,2) COMMENT 'Number of defects per unit area (e.g., defects per cm²) observed on the lot.',
    `die_count` STRING COMMENT 'Total number of individual dies contained in the assembly lot.',
    `good_unit_count` STRING COMMENT 'The good unit count of the assembly lot record in the packaging domain.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is currently on hold for any reason.',
    `hold_reason` STRING COMMENT 'Free‑text description of why the lot was placed on hold.',
    `inspection_fail_count` STRING COMMENT 'Number of inspection points that failed during the latest quality check.',
    `inspection_pass_count` STRING COMMENT 'Number of inspection points that passed during the latest quality check.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly lot record in the packaging domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assembly lot record.',
    `lot_name` STRING COMMENT 'Human‑readable name or label for the assembly lot, often used in reports and dashboards.',
    `lot_number` STRING COMMENT 'External business identifier assigned to the assembly lot, used for tracking across systems.',
    `lot_status` STRING COMMENT 'Overall lifecycle state of the lot, indicating whether it is active, completed, or terminated.. Valid values are `open|closed|scrapped`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly lot record in the packaging domain.',
    `notes` STRING COMMENT 'The notes of the assembly lot record in the packaging domain.',
    `package_version` STRING COMMENT 'Version or revision identifier of the package design used for this lot.',
    `quality_status` STRING COMMENT 'Result of the most recent quality inspection for the lot.. Valid values are `passed|failed|pending`',
    `reject_count` STRING COMMENT 'The reject count of the assembly lot record in the packaging domain.',
    `scrap_unit_count` STRING COMMENT 'The scrap unit count of the assembly lot record in the packaging domain.',
    `start_date` DATE COMMENT 'Planned or actual date when assembly of the lot began.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the assembly lot record in the packaging domain.',
    `target_completion_date` DATE COMMENT 'Planned date by which the lot should be fully assembled.',
    `unit_count` STRING COMMENT 'The unit count of the assembly lot record in the packaging domain.',
    `unit_count_in` STRING COMMENT 'The unit count in of the assembly lot record in the packaging domain.',
    `unit_count_out` STRING COMMENT 'The unit count out of the assembly lot record in the packaging domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the assembly lot record in the packaging domain.',
    `wip_status` STRING COMMENT 'Operational status of the lot within the assembly workflow.. Valid values are `queued|in_process|hold|complete`',
    `yield_percent` DECIMAL(18,2) COMMENT 'The yield percent of the assembly lot record in the packaging domain.',
    CONSTRAINT pk_assembly_lot PRIMARY KEY(`assembly_lot_id`)
) COMMENT 'Master tracking entity for an assembly lot progressing through OSAT or internal packaging operations. Captures lot number, parent wafer lot reference, die count, package type, assembly site (OSAT vendor), current process step, WIP status (queued, in-process, hold, complete), start/target/actual completion dates, cumulative yield, and hold flags. Central WIP identity that all step records, yield results, inspections, and defects reference. SSOT for assembly lot identity and real-time WIP status within the packaging domain. Equipment asset records are owned by the equipment domain; SPC charting is owned by the quality domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` (
    `assembly_yield_id` BIGINT COMMENT 'Primary key for assembly_yield',
    `assembly_order_id` BIGINT COMMENT 'Unique identifier for the assembly order record within the assembly yield packaging entity.',
    `assembly_process_flow_id` BIGINT COMMENT 'Unique identifier for the assembly process flow record within the assembly yield packaging entity.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Assembly yield records track die consumption and loss per process step. Linking to die_bank enables die consumption reconciliation against die bank inventory, supporting inventory depletion accuracy a',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment (e.g., die attach machine, wire bonder) used for this step.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Final test is a yield-impacting step in the assembly process flow; assembly_yield records for the final test step must link to the specific final_test_run that generated the yield data. Essential for ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: OSAT traceability requirement: assembly yield at each packaging step must be traceable to the incoming inspection lot (incoming die quality gate). Enables correlation of incoming die quality to packag',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: When packaging yield drops below threshold, an NCR is raised. Linking assembly_yield to the triggering NCR supports yield excursion management and IATF 16949 corrective action traceability — a named o',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the package type record within the assembly yield packaging entity.',
    `assembly_lot_id` BIGINT COMMENT 'Identifier of the parent assembly run or batch to which this yield step belongs.',
    `assembly_yield_status` STRING COMMENT 'Current lifecycle status of the step record.. Valid values are `in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `cumulative_yield_percent` DECIMAL(18,2) COMMENT 'Running cumulative yield from the start of the assembly run to this step.',
    `dppm` DECIMAL(18,2) COMMENT 'Defective parts per million metric for the step.',
    `first_pass_yield_percent` DECIMAL(18,2) COMMENT 'The first pass yield percent of the assembly yield record in the packaging domain.',
    `input_quantity` STRING COMMENT 'The input quantity of the assembly yield record in the packaging domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly yield record in the packaging domain.',
    `loss_quantity` STRING COMMENT 'The loss quantity of the assembly yield record in the packaging domain.',
    `measurement_date` DATE COMMENT 'The measurement date associated with the assembly yield packaging record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly yield record in the packaging domain.',
    `notes` STRING COMMENT 'The notes of the assembly yield record in the packaging domain.',
    `output_quantity` STRING COMMENT 'The output quantity of the assembly yield record in the packaging domain.',
    `process_step` STRING COMMENT 'Name of the specific packaging process step for which the yield data is recorded.. Valid values are `die_attach|wire_bond|bga_assembly|testing|final_inspection`',
    `reject_count` STRING COMMENT 'The reject count of the assembly yield record in the packaging domain.',
    `reject_quantity` STRING COMMENT 'The reject quantity of the assembly yield record in the packaging domain.',
    `rework_yield_percent` DECIMAL(18,2) COMMENT 'The rework yield percent of the assembly yield record in the packaging domain.',
    `scrap_reason_code` STRING COMMENT 'Standardized code describing why units were scrapped.. Valid values are `contamination|misalignment|defect|damage|other`',
    `step_end_timestamp` TIMESTAMP COMMENT 'Date and time when the process step completed.',
    `step_sequence` STRING COMMENT 'Ordinal position of the step within the overall assembly run.',
    `step_start_timestamp` TIMESTAMP COMMENT 'Date and time when the process step began.',
    `top_defect_category` STRING COMMENT 'The top defect category of the assembly yield record in the packaging domain.',
    `units_in` STRING COMMENT 'Number of dies or packages entering the process step.',
    `units_out` STRING COMMENT 'Number of good dies or packages exiting the process step.',
    `units_scrapped` STRING COMMENT 'Number of dies or packages discarded during the step.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the yield record.',
    `yield_category` STRING COMMENT 'The yield category of the assembly yield record in the packaging domain.',
    `yield_loss_category` STRING COMMENT 'The yield loss category of the assembly yield record in the packaging domain.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Yield for the step expressed as a percentage of units_out to units_in.',
    `yield_type` STRING COMMENT 'The yield type of the assembly yield record in the packaging domain.',
    CONSTRAINT pk_assembly_yield PRIMARY KEY(`assembly_yield_id`)
) COMMENT 'Transactional record capturing assembly yield data at each major process step and at final assembly completion for each lot. Stores lot ID, process step, units in, units out, units scrapped, scrap reason codes, yield percentage, cumulative assembly yield, and DPPM. Also serves as the authoritative record for scrap quantities and loss reasons within the packaging domain. Feeds assembly yield trending, OSAT scorecard, cost of poor quality (COPQ) analysis, and product cost calculations. Distinct from wafer probe yield (owned by test domain).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` (
    `assembly_defect_id` BIGINT COMMENT 'Primary key for assembly_defect',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Assembly defects must be traced to the originating die bank lot to distinguish die-related defects from process defects. This link drives supplier quality reporting, die bank quarantine decisions, and',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Assembly defects traced to incoming die quality require direct reference to the originating fab lot_process_run for root-cause analysis and CAPA. Semiconductor failure analysis reports and 8D investig',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Assembly defects surfaced during final test inspection must be traceable to the specific final test run that identified them. This supports CAPA initiation, yield loss attribution to OSAT, and defect-',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the package type record within the assembly defect packaging entity.',
    `assembly_lot_id` BIGINT COMMENT 'Identifier of the wafer lot where the defect was observed.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Enables Defect Traceability across wafer and package stages, required for Root Cause Analysis report that correlates wafer defects to package defects.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: REQUIRED: Defect root‑cause analysis links packaging defects back to the fab process step that introduced them.',
    `wafer_id` BIGINT COMMENT 'Identifier of the specific wafer containing the defective unit.',
    `assembly_defect_status` STRING COMMENT 'Current processing status of the defect record.. Valid values are `open|closed|escalated|resolved`',
    `comment` STRING COMMENT 'Free‑form notes entered by the inspector.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect record was initially created.',
    `defect_category` STRING COMMENT 'Higher‑level category describing the nature of the defect.. Valid values are `mechanical|electrical|material|process|design|other`',
    `defect_code` STRING COMMENT 'Coded value representing the defect code of the assembly defect packaging record.',
    `defect_count` STRING COMMENT 'The defect count of the assembly defect record in the packaging domain.',
    `defect_description` STRING COMMENT 'The defect description of the assembly defect record in the packaging domain.',
    `defect_image_uri` STRING COMMENT 'Link to the image captured for the defect.',
    `defect_type` STRING COMMENT 'Classification of the defect observed during inspection.. Valid values are `delamination|void|wire_sweep|solder_bridge|package_crack|marking_error`',
    `detected_date` DATE COMMENT 'The detected date associated with the assembly defect packaging record.',
    `detected_timestamp` TIMESTAMP COMMENT 'The detected timestamp of the assembly defect record in the packaging domain.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the defect was recorded.',
    `disposition` STRING COMMENT 'Decision taken for the defective unit.. Valid values are `rework|scrap|use_as_is`',
    `dppm` DECIMAL(18,2) COMMENT 'Calculated defect density for the lot (defects per million units).',
    `fmea_reference` STRING COMMENT 'Identifier of the related Failure Mode and Effects Analysis record.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the lot/unit is placed on hold for MRB escalation.',
    `inspection_batch_code` BIGINT COMMENT 'Identifier of the inspection batch (transaction header) to which this defect belongs.',
    `inspection_tool` STRING COMMENT 'Name or model of the inspection tool used.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating if the defect is considered critical for product functionality.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly defect record in the packaging domain.',
    `measurement_unit` STRING COMMENT 'Unit of the measurement value.. Valid values are `um|mm|percent|ohm|v`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Quantitative measurement associated with the defect (e.g., void size).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly defect record in the packaging domain.',
    `notes` STRING COMMENT 'The notes of the assembly defect record in the packaging domain.',
    `root_cause` STRING COMMENT 'Root cause analysis result for the defect.',
    `sequence_number` STRING COMMENT 'Line sequence number of the defect within the inspection batch.',
    `severity` STRING COMMENT 'The severity of the assembly defect record in the packaging domain.',
    `severity_level` STRING COMMENT 'Severity rating of the defect.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Work shift during which the defect was recorded.. Valid values are `day|swing|night`',
    `unit_serial_number` STRING COMMENT 'Serial number of the individual packaged unit (die) where the defect was detected.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the defect record.',
    CONSTRAINT pk_assembly_defect PRIMARY KEY(`assembly_defect_id`)
) COMMENT 'Transactional record for assembly defects and non-conformances identified during in-process inspection, final visual inspection, or reliability testing. Captures defect type (delamination, voiding, wire sweep, solder bridge, package crack, marking error), detection step, lot ID, unit serial number, defect image reference, disposition (rework, scrap, use-as-is), corrective action reference, and hold flag for quality domain MRB escalation. Supports DPPM tracking, FMEA, and feeds quality domain for enterprise-wide non-conformance management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` (
    `package_qualification_id` BIGINT COMMENT 'Primary key for package_qualification',
    `assembly_process_flow_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_process_flow. Business justification: A package qualification program certifies a specific combination of package type, OSAT vendor, AND assembly process flow. package_qualification already links to osat_vendor and package_type, but has n',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Package qualifications are initiated as a gate within the customer design win qualification process. Semiconductor operations require linking qualification results to the specific design win to confir',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the package qualification packaging entity.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Qualifications are site-specific — a package type must be qualified at each OSAT site independently.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Package qualification engineers validate mechanical and electrical compatibility using the specific physical layout revision (die dimensions, pad ring, bump map from die_area_mm2, die_height_um, die_w',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type',
    `assembly_lot_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_lot. Business justification: Package qualification programs use specific assembly lots as qualification vehicles — the actual production lots built and tested to certify the package type and process flow. Linking package_qualific',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Package qualification (JEDEC/AEC-Q100 compliance) must record the specific fab tool used during qualification testing for regulatory traceability and requalification triggers. test_equipment_code is a',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Package qualification is node-specific: stress test matrices, reliability requirements, and qualification standards differ by technology node. Qualification reports must reference the technology node ',
    `tertiary_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Qualifications certify specific package types for production. Essential for determining which package types are production-released.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Package qualification depends on the equipment being formally tool-qualified. Semiconductor process engineers must verify that the tool_qualification record for the equipment used in package qualifica',
    `actual_completion_date` DATE COMMENT 'The actual completion date associated with the package qualification packaging record.',
    `approval_date` DATE COMMENT 'Date the qualification was formally approved for production release.',
    `compliance_flag` STRING COMMENT 'Indicator of any special compliance considerations (e.g., automotive, aerospace).',
    `cost_currency` STRING COMMENT 'Currency code for the qualification cost.. Valid values are `USD|EUR|JPY|CNY|GBP|CAD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `defect_rate_ppm` STRING COMMENT 'Defective parts per million observed in the qualification samples.',
    `effective_from` DATE COMMENT 'Date the qualification becomes effective for manufacturing.',
    `effective_until` DATE COMMENT 'Expiration date of the qualification, if applicable.',
    `external_audit_date` DATE COMMENT 'Scheduled date for the external audit, if required.',
    `external_audit_required` BOOLEAN COMMENT 'Indicates whether an external audit is mandated for this qualification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the package qualification record in the packaging domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the package qualification record in the packaging domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the qualification team.',
    `package_qualification_status` STRING COMMENT 'The status of the package qualification record in the packaging domain.',
    `pass_fail_criteria` STRING COMMENT 'Defined criteria that determine pass or fail outcomes for each test.',
    `pass_fail_result` STRING COMMENT 'The pass fail result of the package qualification record in the packaging domain.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the package qualification packaging record.',
    `qualification_code` STRING COMMENT 'Coded value representing the qualification code of the package qualification packaging record.',
    `qualification_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for the qualification program, expressed in US dollars.',
    `qualification_document_number` STRING COMMENT 'Reference to the document that contains the full qualification report.',
    `qualification_method` STRING COMMENT 'Approach used for qualification testing.. Valid values are `accelerated|full_life|simulation`',
    `qualification_owner` STRING COMMENT 'Name of the person responsible for managing the qualification program.',
    `qualification_result` STRING COMMENT 'Overall outcome of the qualification after evaluating all test criteria.. Valid values are `pass|fail|conditional`',
    `qualification_standard` STRING COMMENT 'Standard or specification against which the package is qualified.. Valid values are `JEDEC_JESD47|AEC_Q100|AEC_Q101|MIL_STD_883|CUSTOM`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification program.. Valid values are `pending|in_progress|approved|rejected|withdrawn`',
    `qualification_type` STRING COMMENT 'Category of qualification: new package, package‑product combo, or OSAT site certification.. Valid values are `new_package|package_product_combination|osat_site`',
    `regulatory_compliance` STRING COMMENT 'Regulatory framework(s) the qualification adheres to.. Valid values are `JEDEC|AEC|MIL|CUSTOM`',
    `revision_number` STRING COMMENT 'Sequential revision number of the qualification record.',
    `risk_level` STRING COMMENT 'Assessed risk category of the qualification based on test outcomes.. Valid values are `low|medium|high|critical`',
    `sample_quantity` STRING COMMENT 'Number of sample units tested during qualification.',
    `sample_size` STRING COMMENT 'The sample size of the package qualification record in the packaging domain.',
    `stress_test_matrix` STRING COMMENT 'Set of stress tests applied during qualification (e.g., High Temperature Operating Life, Temperature Cycling).. Valid values are `HTOL|TC|HAST|ESD|Latch_Up|Thermal_Cycling`',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the qualification test cycle in hours.',
    `test_location` STRING COMMENT 'Physical location or facility where the qualification testing was conducted.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature (in Celsius) applied during stress testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification record.',
    `version` STRING COMMENT 'Version label for the qualification plan (e.g., v1.0, v2.1).',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of good dies per wafer after qualification testing.',
    CONSTRAINT pk_package_qualification PRIMARY KEY(`package_qualification_id`)
) COMMENT 'Master record for package qualification programs executed to certify a new package type, package-product combination, or OSAT site for production release. Captures qualification plan ID, package type, product SKU, qualification standard (JEDEC JESD47, AEC-Q100/Q101, MIL-STD-883), stress test matrix (HTOL, TC, HAST, ESD, latch-up), pass/fail criteria, qualification status, and approval date. SSOT for package qualification certification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` (
    `osat_package_capability_id` BIGINT COMMENT 'Unique surrogate key for the OSAT package capability association record',
    `osat_vendor_id` BIGINT COMMENT 'Foreign key linking to the OSAT vendor master record',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to the package type reference master',
    `audit_score` DECIMAL(18,2) COMMENT 'Quality audit score (0-100) for this vendor-package combination. Audit performance varies by package complexity and vendor capability.',
    `capacity_units_per_month` STRING COMMENT 'Allocated monthly capacity for this vendor-package combination, measured in units per month. Explicitly identified in detection reasoning as relationship-specific data. This is vendor-package specific, not vendor-wide.',
    `capacity_units_per_week` STRING COMMENT 'The capacity units per week of the osat vendor record in the packaging domain. [Moved from osat_vendor: Similar to monthly capacity, weekly capacity is allocated per package type based on line configuration and package complexity.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capability record was first created in the system',
    `dppm_rate` DECIMAL(18,2) COMMENT 'Defective parts per million rate for this vendor-package combination. Quality metrics are tracked per package type, as complexity varies.',
    `effective_from` DATE COMMENT 'Date from which this vendor-package capability became effective. Explicitly identified in detection reasoning as relationship-specific data. Tracks qualification history.',
    `effective_until` DATE COMMENT 'Date until which this vendor-package capability is valid (null if indefinite). Explicitly identified in detection reasoning as relationship-specific data. Supports time-bound qualifications and disqualifications.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit for this vendor-package capability. Audits are conducted per package type, not vendor-wide.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this capability record',
    `notes` STRING COMMENT 'Free-form notes regarding this specific vendor-package capability (e.g., qualification conditions, special handling requirements)',
    `package_capabilities` STRING COMMENT 'Comma-separated list of package types the vendor is qualified to assemble (e.g., WLCSP, InFO, CoWoS, TSV, flip-chip, BGA). [Moved from osat_vendor: This is a denormalized comma-separated list of package types the vendor is qualified for. This is M:N relationship data that should be represented as individual capability records, not as a string attribute on the vendor.]',
    `preferred_flag` BOOLEAN COMMENT 'Indicates whether this vendor is a preferred source for this package type. Explicitly identified in detection reasoning as relationship-specific data. Supports dual-sourcing and preferred vendor strategies.',
    `preferred_package_types` STRING COMMENT 'Comma-separated list of package types the vendor is preferred for. [Moved from osat_vendor: This is a denormalized STRING list that represents M:N relationship data. The detection reasoning explicitly identifies this as direct evidence that the current 1:N model is insufficient. Each preferred status belongs to a specific vendor-package combination, not to the vendor alone.]',
    `qualification_date` DATE COMMENT 'Date when the vendor completed qualification for this package type. Tracks formal qualification milestones per vendor-package combination.',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor for this specific package type (qualified, in_qualification, preferred, probation, disqualified). Explicitly identified in detection reasoning as relationship-specific data.',
    `standard_lead_time_days` STRING COMMENT 'Standard lead time in days for this vendor to assemble this specific package type. Explicitly identified in detection reasoning as relationship-specific data. Lead times vary by package complexity.',
    CONSTRAINT pk_osat_package_capability PRIMARY KEY(`osat_package_capability_id`)
) COMMENT 'This association product represents the qualification and capability relationship between OSAT vendors and package types in the semiconductor packaging domain. It captures vendor-specific qualifications, capacity allocations, lead times, and preferred status for each package type that a vendor is certified to assemble. Each record links one OSAT vendor to one package type with attributes that exist only in the context of this vendor-package qualification relationship. This is the operational SSOT for OSAT sourcing decisions, capacity planning, and dual-source strategies.. Existence Justification: In semiconductor manufacturing, OSAT (Outsourced Semiconductor Assembly and Test) vendor management is a formal, operationally-managed M:N business process. Each OSAT vendor is qualified for multiple package types (e.g., Vendor A qualified for WLCSP, BGA, and QFN), and each package type can be assembled by multiple qualified vendors to support dual-sourcing strategies and capacity risk mitigation. The business actively manages vendor-package qualifications through rigorous qualification programs, tracks capacity allocations per vendor-package combination, maintains quality metrics (DPPM, audit scores) per package type, and designates preferred vendors for specific packages.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_primary_assembly_package_type_id` FOREIGN KEY (`primary_assembly_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_primary_substrate_package_type_id` FOREIGN KEY (`primary_substrate_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_to_package_type_id` FOREIGN KEY (`to_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_primary_assembly_package_type_id` FOREIGN KEY (`primary_assembly_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tertiary_package_type_id` FOREIGN KEY (`tertiary_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ADD CONSTRAINT `fk_packaging_osat_package_capability_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ADD CONSTRAINT `fk_packaging_osat_package_capability_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`packaging` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`packaging` SET TAGS ('dbx_domain' = 'packaging');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Partner Identifier (OPID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage (AYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Status (AOS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_status` SET TAGS ('dbx_value_regex' = 'released|in_process|completed|on_hold|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_site` SET TAGS ('dbx_business_glossary_term' = 'Assembly Site Code (ASC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `completed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Completed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date (CD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Adjustment Amount (CAA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Cost Amount (GCA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cost Amount (NCA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CCY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CAD');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count (DC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage (EYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag (HF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (INS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (LSCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Number (AON)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placement Timestamp (OPT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source (OSRC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'internal|osat|external');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority (OPR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered (QO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (RD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions (SHI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `target_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Target Ship Date (TSD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` SET TAGS ('dbx_subdomain' = 'technical_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `ball_count` SET TAGS ('dbx_business_glossary_term' = 'Ball Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `ball_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ball Count (BALL_MAX)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `ball_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Ball Count (BALL_MIN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `body_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Body Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description (PKG_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `halogen_free` SET TAGS ('dbx_business_glossary_term' = 'Halogen Free');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_3d_ic` SET TAGS ('dbx_business_glossary_term' = '3D‑IC Package Flag (IS_3D_IC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_advanced_package` SET TAGS ('dbx_business_glossary_term' = 'Advanced Package Flag (IS_ADV)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_ball_grid_array` SET TAGS ('dbx_business_glossary_term' = 'Ball‑Grid Array Flag (IS_BGA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_flip_chip` SET TAGS ('dbx_business_glossary_term' = 'Flip‑Chip Package Flag (IS_FLIP_CHIP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_heterogeneous_integration` SET TAGS ('dbx_business_glossary_term' = 'Heterogeneous Integration Flag (IS_HET_INTEGR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag (ITAR_CTRL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_leadframe` SET TAGS ('dbx_business_glossary_term' = 'Leadframe Package Flag (IS_LEADFRAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_osat_supported` SET TAGS ('dbx_business_glossary_term' = 'OSAT Support Flag (IS_OSAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag (REACH_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag (ROHS_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_wire_bond` SET TAGS ('dbx_business_glossary_term' = 'Wire‑Bond Package Flag (IS_WIRE_BOND)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `jedec_outline_code` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Outline Code (JEDEC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `jedec_standard` SET TAGS ('dbx_business_glossary_term' = 'Jedec Standard');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `lead_count` SET TAGS ('dbx_business_glossary_term' = 'Lead Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `lead_free` SET TAGS ('dbx_business_glossary_term' = 'Lead Free');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `lead_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead Free Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_current_a` SET TAGS ('dbx_business_glossary_term' = 'Maximum Current (A) (MAX_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_die_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Maximum Die Pitch (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_junction_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Max Junction Temp C');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_power_dissipation_w` SET TAGS ('dbx_business_glossary_term' = 'Maximum Power Dissipation (W) (MAX_PWR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Maximum Voltage (V) (MAX_VOLT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `min_die_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Minimum Die Pitch (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `min_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL1|MSL2|MSL3|MSL4|MSL5|MSL6');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category (PKG_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_category` SET TAGS ('dbx_value_regex' = 'wlcsp|info|cowos|tsv_3d|flip_chip|wire_bond');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_dimensions_height_um` SET TAGS ('dbx_business_glossary_term' = 'Package Height (µm) (PKG_HT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_dimensions_length_um` SET TAGS ('dbx_business_glossary_term' = 'Package Length (µm) (PKG_LEN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_dimensions_width_um` SET TAGS ('dbx_business_glossary_term' = 'Package Width (µm) (PKG_WID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_family` SET TAGS ('dbx_business_glossary_term' = 'Package Family (PKG_FAMILY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Height Mm');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_material` SET TAGS ('dbx_business_glossary_term' = 'Package Material (PKG_MAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_material` SET TAGS ('dbx_value_regex' = 'organic|ceramic|metal|plastic');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name (PKG_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status (PKG_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `pin_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pin Count (PIN_MAX)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `pin_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pin Count (PIN_MIN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `pitch_mm` SET TAGS ('dbx_business_glossary_term' = 'Pitch Mm');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Reach Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Identifier (REF_DOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `thermal_resistance_c_per_w` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance (°C/W)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `thermal_resistance_ja` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance Ja');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `typical_thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Typical Package Thickness (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` SET TAGS ('dbx_subdomain' = 'vendor_capability');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `aec_q100_certified` SET TAGS ('dbx_business_glossary_term' = 'AEC-Q100 Certification (AEC_Q100_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score (AUDIT_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_business_glossary_term' = 'Capacity Tier (CAPACITY_TIER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|VeryHigh');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `dppm_rate` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number (DUNS_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EXPORT_CONTROL_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `iatf_16949_certified` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certification (IATF_16949_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certification (ISO_9001_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAST_AUDIT_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Onboarding|Offboarded');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `nda_ip_protection` SET TAGS ('dbx_business_glossary_term' = 'NDA/IP Protection Status (NDA_IP_PROTECTION)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `osat_vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status (PARTNERSHIP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'Approved|Preferred|Probation|Suspended|Terminated');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (PRIMARY_CONTACT_EMAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (PRIMARY_CONTACT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (PRIMARY_CONTACT_PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `quality_certifications` SET TAGS ('dbx_business_glossary_term' = 'Quality Certifications (QUALITY_CERTIFICATIONS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Rating');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (LEAD_TIME_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TAX_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address (VENDOR_ADDRESS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code (VENDOR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_country` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country (VENDOR_COUNTRY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name (VENDOR_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_short_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Short Name (VENDOR_SHORT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type (VENDOR_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'OSAT|Internal|ThirdParty|JointVenture');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` SET TAGS ('dbx_subdomain' = 'technical_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Flow To Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `primary_assembly_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_status` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|retired');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bond Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'wire_bond|flip_chip|bump|csp|none|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|ISO9001|ISO14001|ITAR|EAR');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `dfm_constraints` SET TAGS ('dbx_business_glossary_term' = 'DFM Constraints');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `die_attach_method` SET TAGS ('dbx_business_glossary_term' = 'Die Attach Method');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `die_attach_method` SET TAGS ('dbx_value_regex' = 'epoxy|solder|flip_chip|thermo_compression|csp|none');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `estimated_cycle_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time Hours');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `final_inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Final Inspection Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `final_inspection_type` SET TAGS ('dbx_value_regex' = 'visual|automated|xray|acoustic|none|custom');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Flow Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_description` SET TAGS ('dbx_business_glossary_term' = 'Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_business_glossary_term' = 'Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_version` SET TAGS ('dbx_business_glossary_term' = 'Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `is_default_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Default Flow');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `marking_method` SET TAGS ('dbx_business_glossary_term' = 'Marking Method');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `marking_method` SET TAGS ('dbx_value_regex' = 'laser|ink|dot_peen|none|silk_screen|etch');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `molding_material` SET TAGS ('dbx_business_glossary_term' = 'Molding Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `molding_material` SET TAGS ('dbx_value_regex' = 'epoxy|plastic|ceramic|none|custom|silicone');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_time_target` SET TAGS ('dbx_business_glossary_term' = 'Process Time Target (minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_yield_target` SET TAGS ('dbx_business_glossary_term' = 'Process Yield Target (%)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `singulation_method` SET TAGS ('dbx_business_glossary_term' = 'Singulation Method');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `singulation_method` SET TAGS ('dbx_value_regex' = 'laser|saw|plasma|mechanical|waterjet|none');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `step_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Process Steps');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `underfill_material` SET TAGS ('dbx_business_glossary_term' = 'Underfill Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `underfill_material` SET TAGS ('dbx_value_regex' = 'epoxy|silicone|none|custom|organic|inorganic');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` SET TAGS ('dbx_subdomain' = 'technical_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Bill of Materials ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate To Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `primary_substrate_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `to_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `bom_code` SET TAGS ('dbx_business_glossary_term' = 'Bom Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bom Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `bump_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Bump Pitch (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Substrate Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'standard|high_performance|low_k');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `core_material` SET TAGS ('dbx_business_glossary_term' = 'Core Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `density_g_per_cm3` SET TAGS ('dbx_business_glossary_term' = 'Density (g/cm³)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `dielectric_constant` SET TAGS ('dbx_business_glossary_term' = 'Dielectric Constant');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `is_obsolete` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `last_eco_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last ECO Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `layer_count` SET TAGS ('dbx_business_glossary_term' = 'Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_design|in_production|end_of_life');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `max_operating_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `min_operating_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_name` SET TAGS ('dbx_business_glossary_term' = 'Substrate Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `pad_finish` SET TAGS ('dbx_business_glossary_term' = 'Pad Finish');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `pad_finish` SET TAGS ('dbx_value_regex' = 'ENIG|OSP|immersion_tin|gold');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Substrate Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `quantity_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Unit');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `rdl_spec` SET TAGS ('dbx_business_glossary_term' = 'Redistribution Layer Specification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Revision');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|draft');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_material` SET TAGS ('dbx_business_glossary_term' = 'Substrate Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Substrate Supplier Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_supplier_part` SET TAGS ('dbx_business_glossary_term' = 'Substrate Supplier Part');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'interposer|die|panel|wafer');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `thermal_conductivity_w_per_mk` SET TAGS ('dbx_business_glossary_term' = 'Thermal Conductivity (W/m·K)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Substrate Thickness (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `primary_assembly_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACTUAL_COMP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_site` SET TAGS ('dbx_business_glossary_term' = 'Assembly Site (SITE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD) (COST_EST)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `cumulative_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `current_process_step` SET TAGS ('dbx_business_glossary_term' = 'Current Process Step (PROC_STEP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (DEFECT_DENSITY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `die_count` SET TAGS ('dbx_business_glossary_term' = 'Die Count (DIE_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `good_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Good Unit Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag (HOLD_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason (HOLD_RSN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `inspection_fail_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fail Count (FAIL_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `inspection_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Pass Count (PASS_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_name` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Name (LOT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Number (LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Lifecycle Status (LOT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|closed|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `package_version` SET TAGS ('dbx_business_glossary_term' = 'Package Version (PKG_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `reject_count` SET TAGS ('dbx_business_glossary_term' = 'Reject Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `scrap_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Scrap Unit Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Start Date (START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date (TARGET_COMP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `unit_count_in` SET TAGS ('dbx_business_glossary_term' = 'Unit Count In');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `unit_count_out` SET TAGS ('dbx_business_glossary_term' = 'Unit Count Out');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work‑In‑Process Status (WIP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'queued|in_process|hold|complete');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_yield_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Yield Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Run Identifier (ARI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_yield_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_yield_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `cumulative_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Yield Percentage (CYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `first_pass_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'First Pass Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Input Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `loss_quantity` SET TAGS ('dbx_business_glossary_term' = 'Loss Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Step (APS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `process_step` SET TAGS ('dbx_value_regex' = 'die_attach|wire_bond|bga_assembly|testing|final_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `reject_count` SET TAGS ('dbx_business_glossary_term' = 'Reject Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `reject_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reject Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `rework_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Rework Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code (SRC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_value_regex' = 'contamination|misalignment|defect|damage|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `step_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step End Timestamp (SET)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number (SSN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `step_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Start Timestamp (SST)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `top_defect_category` SET TAGS ('dbx_business_glossary_term' = 'Top Defect Category');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `units_in` SET TAGS ('dbx_business_glossary_term' = 'Units Input Count (UIC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `units_out` SET TAGS ('dbx_business_glossary_term' = 'Units Output Count (UOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `units_scrapped` SET TAGS ('dbx_business_glossary_term' = 'Units Scrapped Count (USC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `yield_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Category');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Category');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Step Yield Percentage (SYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `yield_type` SET TAGS ('dbx_business_glossary_term' = 'Yield Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `assembly_defect_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Defect Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Lot Process Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `assembly_defect_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `assembly_defect_status` SET TAGS ('dbx_value_regex' = 'open|closed|escalated|resolved');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Comment');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|material|process|design|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_image_uri` SET TAGS ('dbx_business_glossary_term' = 'Defect Image URI');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'delamination|void|wire_sweep|solder_bridge|package_crack|marking_error');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Defect Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'rework|scrap|use_as_is');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Defects Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `fmea_reference` SET TAGS ('dbx_business_glossary_term' = 'FMEA Reference');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `inspection_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Batch ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `inspection_tool` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'um|mm|percent|ohm|v');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Defect Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `unit_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` SET TAGS ('dbx_subdomain' = 'technical_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Assembly Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tertiary_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (CURRENCY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CAD');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `defect_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate (PPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'External Audit Date (EXT_AUDIT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `external_audit_required` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required (EXT_AUDIT_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Criteria (PASS_FAIL_CRIT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Result');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Qualification Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Document Identifier (DOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_business_glossary_term' = 'Qualification Method (QUAL_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_value_regex' = 'accelerated|full_life|simulation');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_owner` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner (OWNER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result (RESULT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard (QUAL_STD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_value_regex' = 'JEDEC_JESD47|AEC_Q100|AEC_Q101|MIL_STD_883|CUSTOM');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_package|package_product_combination|osat_site');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance (REG_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_value_regex' = 'JEDEC|AEC|MIL|CUSTOM');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity (SAMPLE_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `stress_test_matrix` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Matrix (STRESS_MATRIX)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `stress_test_matrix` SET TAGS ('dbx_value_regex' = 'HTOL|TC|HAST|ESD|Latch_Up|Thermal_Cycling');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location (TEST_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Version (VERSION)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` SET TAGS ('dbx_subdomain' = 'vendor_capability');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` SET TAGS ('dbx_association_edges' = 'packaging.osat_vendor,packaging.package_type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `osat_package_capability_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Package Capability ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Package Capability - Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Package Capability - Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `capacity_units_per_week` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `dppm_rate` SET TAGS ('dbx_business_glossary_term' = 'DPPM Rate');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `package_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Package Capabilities (PACKAGE_CAPABILITIES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `preferred_package_types` SET TAGS ('dbx_business_glossary_term' = 'Preferred Package Types (PREFERRED_PACKAGE_TYPES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_package_capability` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
