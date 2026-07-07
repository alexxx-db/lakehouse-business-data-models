-- Schema for Domain: packaging | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`packaging` COMMENT 'Die packaging and assembly operations covering all package types including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip, wire bonding, and traditional leadframe/BGA formats. Manages OSAT partnerships, assembly process flows, substrate BOMs, package qualification, and assembly yield data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` (
    `assembly_order_id` BIGINT COMMENT 'Primary key for assembly_order',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who requested the assembly order.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Assembly orders are issued to a specific OSAT vendor or internal site. Critical for vendor performance tracking and capacity allocation.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Every assembly order specifies a package type — this is the primary classification that determines process flow, substrate, and equipment. Critical for filtering orders by package family.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assembly Order Cost Tracking report requires associating each order with the responsible cost center for budgeting and expense allocation.',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Required for linking each assembly order to the specific customer design win that authorizes production, used in the Order Fulfillment process.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Needed for Assembly Order Cost Allocation and Regulatory Traceability linking the order to the die bank supplying the dies.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: ECCN classification determines export control category for each order; needed for compliance reporting and customs filings.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Required for Export License Verification Report; each assembly order must be linked to the export license governing its shipment.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the primary equipment used for the assembly.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Production Planning to associate each assembly order with the exact IC design.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Assembly Order is created for a specific IC design project; linking enables traceability, cost allocation, and schedule alignment in the packaging execution process.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Needed for Order Planning report that uses inspection lot results to set expected yield and schedule packaging of wafers.',
    `mpw_shuttle_id` BIGINT COMMENT 'Foreign key linking to design.mpw_shuttle. Business justification: MPW shuttle schedule drives packaging lead times; linking the order to the shuttle provides coordinated planning across design and packaging.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Custom packaging projects are driven by sales opportunities; linking ties assembly orders to the originating opportunity for forecasting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sales order assignment to a sales rep is used in order‑to‑cash reporting and commission calculations.',
    `packaging_line_id` BIGINT COMMENT 'Identifier of the specific packaging line used.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Ensures the assembly order uses the correct pricing terms defined in the customers price agreement, critical for billing and contract compliance.',
    `primary_assembly_osat_vendor_id` BIGINT COMMENT 'Identifier of the outsourced assembly partner responsible for execution.',
    `primary_assembly_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Every assembly order specifies a package type. This FK is essential for filtering orders by package format, capacity planning, and routing to qualified OSAT sites.',
    `assembly_process_flow_id` BIGINT COMMENT 'FK to packaging.assembly_process_flow.assembly_process_flow_id — Each assembly order executes against a specific process flow revision. Required for traceability and change control.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: REQUIRED: Order must reference the exact fab process flow used to produce dies for traceability and handoff reports.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Assembly order fulfillment depends on a purchase order; linking supports order‑PO status reconciliation and financial reporting.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Assembly orders are created from approved sales quotes; linking provides traceability from quote to manufacturing.',
    `actual_completion_date` DATE COMMENT 'The actual completion date associated with the assembly order packaging record.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Yield percentage achieved after assembly completion.',
    `assembly_order_number` STRING COMMENT 'The number of the assembly order record in the packaging domain.',
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
    `osat_vendor_id` BIGINT COMMENT 'Unique identifier for the osat vendor record within the package type packaging entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the package type packaging entity.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: REQUIRED: Package qualification and compliance depend on the technology node; the link drives qualification reports.',
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
    `employee_id` BIGINT COMMENT 'Unique identifier for the account manager employee record within the osat vendor packaging entity.',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to shared.site.site_id - OSAT vendors have physical facility locations',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: REQUIRED: OSAT vendor is a supplier; linking enables unified supplier performance, audit, and regulatory reporting.',
    `aec_q100_certified` BOOLEAN COMMENT 'Indicates if the vendor holds AEC-Q100 qualification.',
    `audit_score` DECIMAL(18,2) COMMENT 'Score from the latest audit (0-100).',
    `capacity_tier` STRING COMMENT 'Capacity tier classification for the vendors assembly lines.. Valid values are `Low|Medium|High|VeryHigh`',
    `capacity_units_per_month` STRING COMMENT 'The capacity units per month of the osat vendor record in the packaging domain.',
    `capacity_units_per_week` STRING COMMENT 'The capacity units per week of the osat vendor record in the packaging domain.',
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
    `package_capabilities` STRING COMMENT 'Comma-separated list of package types the vendor is qualified to assemble (e.g., WLCSP, InFO, CoWoS, TSV, flip-chip, BGA).',
    `partnership_status` STRING COMMENT 'Current qualification status of the vendor within the OSAT program.. Valid values are `Approved|Preferred|Probation|Suspended|Terminated`',
    `preferred_package_types` STRING COMMENT 'Comma-separated list of package types the vendor is preferred for.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit: Process flow creation must be signed by a process engineer; required for compliance reports and traceability.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Process flows are defined for specific package types. Critical for routing assembly orders to the correct flow.',
    `assembly_process_owner_employee_id` BIGINT COMMENT 'Unique identifier for the assembly process owner employee record within the assembly process flow packaging entity.',
    `osat_vendor_id` BIGINT COMMENT 'Unique identifier for the osat vendor record within the assembly process flow packaging entity.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the assembly process flow packaging entity.',
    `primary_assembly_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Process flows are defined per package type. Required for routing and DFM constraint validation.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: REQUIRED: Packaging flow is tied to a specific fab flow for end‑to‑end yield and DFM coordination.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process Flow Definition uses a specific process node; required for Process Flow Specification report.',
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
    `flow_to_package_type` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Process flows are defined per package type. A package type may have multiple flow revisions but each flow targets a specific package format.',
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
    `assembly_change_notice_id` BIGINT COMMENT 'Identifier of the ECO that introduced this BOM revision.',
    `assembly_process_flow_id` BIGINT COMMENT 'Unique identifier for the assembly process flow record within the substrate bom packaging entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Substrate BOM is generated per IC design; linking enables BOM cost roll‑up per product.',
    `material_lot_id` BIGINT COMMENT 'Unique identifier for the material lot record within the substrate bom packaging entity.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Substrate BOMs are defined per package type. Required for material planning and assembly order material allocation.',
    `primary_substrate_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Substrate BOMs are specific to a package type. Required for procurement and assembly material planning.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the substrate.',
    `substrate_package_type_id` BIGINT COMMENT 'Unique identifier for the substrate package type record within the substrate bom packaging entity.',
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
    `substrate_to_package_type` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Substrate BOMs are defined for specific package types (CoWoS interposer, flip-chip BGA substrate, etc.).',
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
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Each lot is physically at a specific OSAT site. Required for WIP-by-site reporting and site-level yield analysis.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the assembly package type record within the assembly lot packaging entity.',
    `assembly_packaging_package_type_id` BIGINT COMMENT 'FK to packaging.package_type',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lot-level cost accounting ties production expenses to the cost center that funds the lot, used in the Packaging Cost Summary.',
    `export_license_usage_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license_usage. Business justification: Export license usage per assembly lot must be tracked for license utilization reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Yield and defect analysis per IC design needs the lot to reference its IC catalog entry.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Lot tracking reports require the originating design project to correlate yield and defect data with design intent.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Supports Lot Traceability workflow linking each assembly lot to the preceding inspection lot for defect tracking across packaging.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lot manager is recorded for WIP ownership, yield accountability, and shift hand‑over documentation.',
    `packaging_line_id` BIGINT COMMENT 'Foreign key linking to packaging.packaging_line. Business justification: An assembly lot is processed on a specific packaging line; linking the lot to the line provides traceability of line usage for yield and defect analysis.',
    `assembly_order_id` BIGINT COMMENT 'FK to packaging.assembly_order.assembly_order_id — Assembly lots are created under an assembly order. This is the primary parent-child relationship for WIP tracking.',
    `primary_assembly_osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Each lot is processed at a specific OSAT site. Required for site-level yield analysis and capacity tracking.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: REQUIRED: Each assembly lot originates from a wafer lot produced by a specific fab flow; needed for traceability.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit Center Performance report allocates revenue and profit per packaging lot to the profit center responsible for the product line.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lot‑level tracking report requires linking each assembly lot to the SKU it contains.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Logistics and Inventory Valuation require storing the location of each assembled package for warehouse management.',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier',
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
    `lot_package_type` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Each assembly lot is for a specific package type. Required for WIP reporting and routing.',
    `lot_status` STRING COMMENT 'Overall lifecycle state of the lot, indicating whether it is active, completed, or terminated.. Valid values are `open|closed|scrapped`',
    `lot_to_order` BIGINT COMMENT 'FK to packaging.pkg_assembly_order.pkg_assembly_order_id — Assembly lots are created against assembly orders. This is the fundamental WIP-to-order traceability link.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield analysis ties scrap and rework costs to the cost center responsible for the assembly line.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or automation system that performed the step.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment (e.g., die attach machine, wire bonder) used for this step.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the package type record within the assembly yield packaging entity.',
    `assembly_lot_id` BIGINT COMMENT 'Identifier of the parent assembly run or batch to which this yield step belongs.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: REQUIRED: Yield per assembly step must reference the corresponding fab step to correlate SPC and defect data.',
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
    `assembly_step_record_id` BIGINT COMMENT 'Unique identifier for the assembly step record record within the assembly defect packaging entity.',
    `capa_record_id` BIGINT COMMENT 'Reference to the corrective action record linked to this defect.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Defect tracking cost allocation assigns investigation and corrective action expenses to the owning cost center.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who recorded the defect.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment used for the inspection.',
    `inspection_result_id` BIGINT COMMENT 'Unique identifier for the inspection result record within the assembly defect packaging entity.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the package type record within the assembly defect packaging entity.',
    `assembly_lot_id` BIGINT COMMENT 'Identifier of the wafer lot where the defect was observed.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: REQUIRED: Defect root‑cause analysis links packaging defects back to the fab process step that introduced them.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Enables Defect Traceability across wafer and package stages, required for Root Cause Analysis report that correlates wafer defects to package defects.',
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
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Package qualification results are tied to specific certifications; linking enables compliance verification.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Package Qualification Cost Tracking report assigns qualification expenses to the cost center overseeing the packaging program.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the package qualification packaging entity.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Package qualification must be tied to the design project to verify that the chosen package meets the designs electrical and mechanical requirements.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Qualifications are site-specific — a package type must be qualified at each OSAT site independently.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Qualification approval requires a qualified engineers sign‑off; the report lists the approving employee.',
    `package_program_manager_employee_id` BIGINT COMMENT 'Unique identifier for the package program manager employee record within the package qualification packaging entity.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type',
    `sku_id` BIGINT COMMENT 'FK to product.sku',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Qualification results are linked to the specific tapeout to ensure the mask set used matches the qualified package specifications.',
    `tertiary_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Qualifications certify specific package types for production. Essential for determining which package types are production-released.',
    `test_program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Package qualification requires a specific test program; linking provides traceability of which test program validated the package, required for qualification audit.',
    `qualification_plan_id` BIGINT COMMENT 'Business identifier for the qualification plan used to certify the package.',
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
    `test_equipment_code` STRING COMMENT 'Identifier of the equipment used to perform the qualification tests.',
    `test_location` STRING COMMENT 'Physical location or facility where the qualification testing was conducted.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature (in Celsius) applied during stress testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification record.',
    `version` STRING COMMENT 'Version label for the qualification plan (e.g., v1.0, v2.1).',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of good dies per wafer after qualification testing.',
    CONSTRAINT pk_package_qualification PRIMARY KEY(`package_qualification_id`)
) COMMENT 'Master record for package qualification programs executed to certify a new package type, package-product combination, or OSAT site for production release. Captures qualification plan ID, package type, product SKU, qualification standard (JEDEC JESD47, AEC-Q100/Q101, MIL-STD-883), stress test matrix (HTOL, TC, HAST, ESD, latch-up), pass/fail criteria, qualification status, and approval date. SSOT for package qualification certification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` (
    `reliability_stress_test_id` BIGINT COMMENT 'System-generated unique identifier for each reliability stress test run.',
    `assembly_lot_id` BIGINT COMMENT 'Unique identifier for the assembly lot record within the reliability stress test packaging entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reliability Stress Test budgeting requires charging test expenses to the cost center that sponsors the product qualification.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer or technician who supervised the test.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment used for the run.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability reports must be tied to the specific IC design under test.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Reliability tests are executed on a specific design; linking enables the reliability report to reference design parameters and version.',
    `package_qualification_id` BIGINT COMMENT 'FK to packaging.package_qualification.package_qualification_id — Stress tests are executed as part of qualification programs. This link enables qualification status rollup from individual test results.',
    `primary_reliability_package_qualification_id` BIGINT COMMENT 'FK to packaging.package_qualification.package_qualification_id — Stress tests are executed as part of a qualification program. Required for qualification evidence chain.',
    `reliability_test_id` BIGINT COMMENT 'Foreign key linking to quality.reliability_test. Business justification: Integrates packaging stress test results with wafer‑level reliability data for the Reliability Consolidated Report used in product qualification.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Reliability stress test results are required for regulatory filing submissions; linking provides evidence.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the reliability package type record within the reliability stress test packaging entity.',
    `reliability_packaging_package_type_id` BIGINT COMMENT 'Identifier of the semiconductor package associated with this test run.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the reliability stress test record in the packaging domain.',
    `cycle_count` STRING COMMENT 'The cycle count of the reliability stress test record in the packaging domain.',
    `cycles` STRING COMMENT 'Number of electrical or mechanical cycles applied (relevant for cycling tests).',
    `data_source_system` STRING COMMENT 'Originating system that captured the test data (e.g., Camstar MES).',
    `disposition` STRING COMMENT 'Overall outcome of the test run.. Valid values are `pass|fail|abort`',
    `duration_hours` STRING COMMENT 'The duration hours of the reliability stress test record in the packaging domain.',
    `duration_seconds` STRING COMMENT 'Total elapsed time of the test run in seconds.',
    `failure_count` STRING COMMENT 'Number of units that failed during the test.',
    `failure_mode` STRING COMMENT 'Descriptive classification of the observed failure mechanism.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity level during the test, expressed as a percentage.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the reliability stress test record in the packaging domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the reliability stress test record in the packaging domain.',
    `mttf_hours` DECIMAL(18,2) COMMENT 'Estimated mean time to failure derived from test results, expressed in hours.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the test operator.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test record.',
    `reliability_stress_test_status` STRING COMMENT 'Current lifecycle state of the reliability test.. Valid values are `planned|running|completed|passed|failed|aborted`',
    `result` STRING COMMENT 'The result of the reliability stress test record in the packaging domain.',
    `result_metric` STRING COMMENT 'Name of the primary quantitative result measured (e.g., failure_rate).',
    `result_status` STRING COMMENT 'The result status of the reliability stress test record in the packaging domain.',
    `result_unit` STRING COMMENT 'Unit of measure for the result value (e.g., failures_per_hour).',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary result metric.',
    `sample_size` STRING COMMENT 'Number of individual units subjected to the stress test.',
    `stress_test_to_qualification` BIGINT COMMENT 'FK to packaging.pkg_qualification.pkg_qualification_id — Reliability stress tests are executed as part of qualification programs. Each test run links to its parent qualification.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature condition applied during the test, expressed in degrees Celsius.',
    `test_conditions_description` STRING COMMENT 'Narrative description of the test environment and setup.',
    `test_end_date` DATE COMMENT 'The test end date associated with the reliability stress test packaging record.',
    `test_location` STRING COMMENT 'Facility or lab identifier where the test was executed.',
    `test_result` STRING COMMENT 'The test result of the reliability stress test record in the packaging domain.',
    `test_run_code` STRING COMMENT 'External code or number assigned to the test run for traceability across systems.',
    `test_spec_version` STRING COMMENT 'Version identifier of the test specification document.',
    `test_standard` STRING COMMENT 'Industry or internal standard governing the test methodology.. Valid values are `JEDEC|IEC|ISO|Custom`',
    `test_start_date` DATE COMMENT 'The test start date associated with the reliability stress test packaging record.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date and time when the stress test started.',
    `test_type` STRING COMMENT 'Type of reliability stress test performed (e.g., HTOL, TC, HAST, PRECON, ESD, Latch-up, Drop). [ENUM-REF-CANDIDATE: HTOL|TC|HAST|PRECON|ESD|Latch-up|Drop — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the reliability stress test record in the packaging domain.',
    `voltage_v` DECIMAL(18,2) COMMENT 'Voltage applied to the device under test, expressed in volts.',
    CONSTRAINT pk_reliability_stress_test PRIMARY KEY(`reliability_stress_test_id`)
) COMMENT 'Transactional record for individual reliability stress test runs performed as part of package qualification or ongoing reliability monitoring. Captures test type (HTOL, TC, HAST, PRECON, ESD, latch-up, drop test), sample size, stress conditions (temperature, humidity, voltage, cycles), test duration, failure count, failure mode, MTTF estimate, and pass/fail disposition. Linked to pkg_qualification and pkg_defect_record.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` (
    `material_lot_id` BIGINT COMMENT 'Primary key for material_lot',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material Lot Cost Accounting attributes material procurement costs to the cost center that ordered the material.',
    `bom_id` BIGINT COMMENT 'FK to product.substrate_bom.substrate_bom_id — Material lots of substrates reference the substrate BOM specification they fulfill. Enables material traceability from lot to spec.',
    `osat_vendor_id` BIGINT COMMENT 'Unique identifier for the osat vendor record within the material lot packaging entity.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the package type record within the material lot packaging entity.',
    `primary_material_substrate_bom_id` BIGINT COMMENT 'FK to product.substrate_bom.substrate_bom_id — Material lots received are matched to substrate BOM line items for consumption tracking.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Material Traceability and Compliance reports need to link each packaging material lot to its raw material inventory record.',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Substance inventory tracks hazardous chemicals in material lots for REACH/ROHS compliance reporting.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the external supplier providing the material lot.',
    `certificate_of_conformance_ref` STRING COMMENT 'Reference identifier to the Certificate of Conformance document associated with the lot.',
    `certification_number` STRING COMMENT 'The certification number of the material lot record in the packaging domain.',
    `compliance_document_ref` STRING COMMENT 'Reference to any additional compliance documentation attached to the lot.',
    `compliance_itar_status` STRING COMMENT 'ITAR export‑control status of the material lot.. Valid values are `approved|restricted|denied`',
    `compliance_reach_status` STRING COMMENT 'REACH compliance status of the material lot.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_rohs_status` STRING COMMENT 'RoHS compliance status of the material lot.. Valid values are `compliant|non_compliant|exempt`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost assigned to a single unit of the material.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the material lot record in the packaging domain.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_per_unit.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `expiration_date` DATE COMMENT 'The expiration date associated with the material lot packaging record.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the material lot packaging record.',
    `humidity_storage_percent` DECIMAL(18,2) COMMENT 'Recorded relative humidity percentage for the lots storage environment.',
    `incoming_inspection_status` STRING COMMENT 'Result of the initial quality inspection performed on receipt of the lot.. Valid values are `passed|failed|pending`',
    `inspection_failure_reason` STRING COMMENT 'Textual reason for inspection failure, if applicable.',
    `inspection_passed` BOOLEAN COMMENT 'True if the lot passed all required inspections.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the material lot record in the packaging domain.',
    `lot_number` STRING COMMENT 'Human‑readable identifier assigned to the material lot by the receiving facility.',
    `lot_status` STRING COMMENT 'The lot status of the material lot record in the packaging domain.',
    `manufacture_date` DATE COMMENT 'The manufacture date associated with the material lot packaging record.',
    `material_description` STRING COMMENT 'Free‑text description of the material, including any special characteristics.',
    `material_grade` STRING COMMENT 'The material grade of the material lot record in the packaging domain.',
    `material_lot_number` STRING COMMENT 'The number of the material lot record in the packaging domain.',
    `material_lot_status` STRING COMMENT 'Current lifecycle status of the material lot within the packaging operation.. Valid values are `received|inspected|released|quarantined|consumed|expired`',
    `material_type` STRING COMMENT 'Category of the packaging material (e.g., substrate, lead frame, mold compound). [ENUM-REF-CANDIDATE: substrate|lead_frame|mold_compound|bond_wire|solder_paste|underfill|marking_ink — 7 candidates stripped; promote to reference product]',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the material lot record in the packaging domain.',
    `notes` STRING COMMENT 'The notes of the material lot record in the packaging domain.',
    `part_number` STRING COMMENT 'Standard part number that uniquely identifies the packaging material type across the enterprise.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numerical quality rating assigned after inspection (0‑100).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the material lot record in the packaging domain.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Total amount of material received in the lot, expressed in the unit defined by unit_of_measure.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the lot is currently placed in quarantine pending further review.',
    `receipt_date` DATE COMMENT 'The receipt date associated with the material lot packaging record.',
    `received_date` DATE COMMENT 'The received date associated with the material lot packaging record.',
    `received_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the material lot was logged into the system.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the material lot record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the material lot record.',
    `release_date` DATE COMMENT 'Date the lot was released from quarantine and made available for production.',
    `rohs_compliant` BOOLEAN COMMENT 'The rohs compliant of the material lot record in the packaging domain.',
    `shelf_life_expiry_date` DATE COMMENT 'Date after which the material lot is considered out‑of‑spec for use.',
    `storage_condition` STRING COMMENT 'Required storage environment (e.g., temperature‑controlled, humidity‑controlled).',
    `supplier_lot_number` STRING COMMENT 'Lot number provided by the external supplier for traceability.',
    `temperature_storage_c` DECIMAL(18,2) COMMENT 'Recorded storage temperature in degrees Celsius for the lot.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity_received (e.g., pieces, kilograms).. Valid values are `pieces|kg|g|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the material lot record in the packaging domain.',
    CONSTRAINT pk_material_lot PRIMARY KEY(`material_lot_id`)
) COMMENT 'Master record for incoming packaging material lots received at the assembly site, including substrates, lead frames, mold compounds, bond wires, solder paste, underfill, and marking inks. Captures material part number, supplier lot number, quantity received, incoming inspection status, Certificate of Conformance (CoC) reference, shelf life expiry, storage conditions, and quarantine/release status. SSOT for packaging-specific material lot identity and incoming quality status. General inventory management is owned by the inventory domain; supplier master data is owned by the supply domain; RoHS/REACH compliance declarations are owned by the compliance domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` (
    `inspection_result_id` BIGINT COMMENT 'Primary key for inspection_result',
    `assembly_lot_id` BIGINT COMMENT 'Unique identifier for the secondary assembly lot record within the inspection result packaging entity.',
    `assembly_step_record_id` BIGINT COMMENT 'Unique identifier for the assembly step record record within the inspection result packaging entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection Result Cost Allocation links inspection labor and equipment expenses to the cost center responsible for quality control.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the inspection equipment used.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the operator who performed the inspection.',
    `inspector_employee_id` BIGINT COMMENT 'Unique identifier for the inspector employee record within the inspection result packaging entity.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the package type record within the inspection result packaging entity.',
    `primary_assembly_lot_id` BIGINT COMMENT 'FK to packaging.assembly_lot.assembly_lot_id — Inspection results are recorded per lot at each inspection gate. Required for lot release decisions.',
    `spc_chart_id` BIGINT COMMENT 'Reference to the SPC chart that consumes this inspection result.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the inspection result record in the packaging domain.',
    `defect_category` STRING COMMENT 'Primary classification of the defect type for this record.. Valid values are `open|short|bridge|particle|misalignment|other`',
    `defect_count_category` STRING COMMENT 'Number of defects observed for the specified defect category.',
    `defect_count_total` STRING COMMENT 'Aggregate number of defects detected across all categories.',
    `defect_density` DECIMAL(18,2) COMMENT 'Defects per unit inspected, calculated as total defects divided by units inspected.',
    `defect_density_unit` STRING COMMENT 'Unit of measure for defect density.. Valid values are `defects_per_unit|defects_per_cm2`',
    `defect_severity` STRING COMMENT 'Severity level assigned to the defect(s) detected.. Valid values are `critical|major|minor|warning`',
    `disposition` STRING COMMENT 'Final accept/reject decision for the inspected lot.. Valid values are `accept|reject`',
    `fail_count` STRING COMMENT 'The fail count of the inspection result record in the packaging domain.',
    `inspection_code` STRING COMMENT 'Business identifier assigned to the inspection event, often used on shop floor reports.',
    `inspection_date` DATE COMMENT 'The inspection date associated with the inspection result packaging record.',
    `inspection_method` STRING COMMENT 'Technique used to perform the inspection.. Valid values are `aoi|xray|sam|manual`',
    `inspection_notes` STRING COMMENT 'Free‑form comments entered by the inspector.',
    `inspection_result_status` STRING COMMENT 'The status of the inspection result record in the packaging domain.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record.. Valid values are `pending|in_progress|completed|rejected`',
    `inspection_step` STRING COMMENT 'Specific process step at which the inspection was taken.. Valid values are `post_die_attach|post_wire_bond|post_mold|final_visual`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Exact date and time when the inspection was performed on the lot.',
    `inspection_type` STRING COMMENT 'The inspection type of the inspection result record in the packaging domain.',
    `is_spc_control` BOOLEAN COMMENT 'Indicates whether this inspection result is used in SPC control charting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the inspection result record in the packaging domain.',
    `measured_value` DECIMAL(18,2) COMMENT 'The measured value of the inspection result record in the packaging domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the inspection result record in the packaging domain.',
    `notes` STRING COMMENT 'The notes of the inspection result record in the packaging domain.',
    `pass_count` STRING COMMENT 'The pass count of the inspection result record in the packaging domain.',
    `quality_outcome` STRING COMMENT 'Overall quality result derived from the inspection.. Valid values are `pass|fail|rework`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection result record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inspection result record.',
    `result` STRING COMMENT 'The result of the inspection result record in the packaging domain.',
    `result_status` STRING COMMENT 'The result status of the inspection result record in the packaging domain.',
    `sample_size` STRING COMMENT 'The sample size of the inspection result record in the packaging domain.',
    `units_inspected` STRING COMMENT 'Number of individual units (dies, packages) inspected in this step.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the inspection result record in the packaging domain.',
    CONSTRAINT pk_inspection_result PRIMARY KEY(`inspection_result_id`)
) COMMENT 'Transactional record for in-process and final visual/automated inspection results during assembly. Captures inspection step (post-die-attach, post-wire-bond, post-mold, final visual), inspection method (AOI, X-ray, SAM, manual), lot ID, unit count inspected, defect count by category, inspection equipment reference (FK to equipment domain), operator ID, and accept/reject disposition. SSOT for assembly-line inspection outcomes within the packaging domain. Enterprise-wide SPC analysis and control charting are owned by the quality domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` (
    `assembly_change_notice_id` BIGINT COMMENT 'Primary key for assembly_change_notice',
    `account_id` BIGINT COMMENT 'Identifier of the customer impacted by the change.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the assembly change owner employee record within the assembly change notice packaging entity.',
    `assembly_employee_id` BIGINT COMMENT 'Internal employee identifier of the person responsible for the change.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the assembly package type record within the assembly change notice packaging entity.',
    `assembly_packaging_package_type_id` BIGINT COMMENT 'Type of package involved in the change. [ENUM-REF-CANDIDATE: wlcsp|info|cowos|tsv_3d|flip_chip|wire_bond|leadframe_bga — promote to reference product]',
    `assembly_process_flow_id` BIGINT COMMENT 'Unique identifier for the assembly process flow record within the assembly change notice packaging entity.',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Change notices must reference the affected design win to track impact on the specific product, supporting the Change Management report.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Change notices reference the affected IC design for compliance and impact analysis.',
    `osat_vendor_id` BIGINT COMMENT 'Name or code of the substrate material supplier affected by the change.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Regulatory filing is triggered by assembly change notices; linking captures filing reference for audit.',
    `assembly_change_notice_status` STRING COMMENT 'The status of the assembly change notice record in the packaging domain.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documentation is attached to the change notice.',
    `attachment_reference` STRING COMMENT 'Path or identifier of the attached document(s) in the DMS.',
    `change_approval_date` DATE COMMENT 'Date the change was formally approved for implementation.',
    `change_category` STRING COMMENT 'The change category of the assembly change notice record in the packaging domain.',
    `change_description` STRING COMMENT 'Detailed narrative describing the nature and rationale of the change.',
    `change_originator` STRING COMMENT 'Department or function that originated the change request.. Valid values are `design|process|supply_chain|quality|packaging`',
    `change_owner_name` STRING COMMENT 'Full name of the change owner.',
    `change_status` STRING COMMENT 'Current lifecycle status of the change notice.. Valid values are `draft|review|approved|implemented|closed|rejected`',
    `change_submission_date` DATE COMMENT 'Date the change notice was submitted to the change control system.',
    `change_title` STRING COMMENT 'The change title of the assembly change notice record in the packaging domain.',
    `change_type` STRING COMMENT 'Category of the change (e.g., material, process, OSAT site transfer, substrate supplier, design, other).. Valid values are `material|process|osat_site|substrate_supplier|design|other`',
    `compliance_review_date` DATE COMMENT 'Date on which the compliance review was completed.',
    `compliance_review_status` STRING COMMENT 'Current status of the regulatory/compliance review for this change.. Valid values are `pending|completed|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change notice record was first created in the system.',
    `customer_approval_required` BOOLEAN COMMENT 'The customer approval required of the assembly change notice record in the packaging domain.',
    `customer_approval_status` STRING COMMENT 'Current approval status from the customer regarding the change.. Valid values are `pending|approved|rejected|not_required`',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating whether the customer must be notified of this change.',
    `effective_date` DATE COMMENT 'Date on which the change becomes binding for production.',
    `impact_on_dppm` DECIMAL(18,2) COMMENT 'Estimated change in DPPM metric due to the change.',
    `impact_on_yield_percent` DECIMAL(18,2) COMMENT 'Estimated percentage change in wafer or die yield caused by the change.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly change notice record in the packaging domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly change notice record in the packaging domain.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `notice_number` STRING COMMENT 'The notice number of the assembly change notice record in the packaging domain.',
    `notice_status` STRING COMMENT 'The notice status of the assembly change notice record in the packaging domain.',
    `notification_date` DATE COMMENT 'The notification date associated with the assembly change notice packaging record.',
    `osat_site_transfer` STRING COMMENT 'Target OSAT site code if the change involves moving production to a different assembly facility.',
    `package_material` STRING COMMENT 'Material composition of the package (e.g., epoxy, ceramic, organic).',
    `pcn_number` STRING COMMENT 'Unique PCN identifier assigned per JEDEC JESD46 guidelines.',
    `process_step_changed` STRING COMMENT 'Specific manufacturing process step that is being modified.',
    `qualification_required` BOOLEAN COMMENT 'Indicates if the change requires a qualification or qualification run before implementation.',
    `regulatory_impact_details` STRING COMMENT 'Free‑text description of the regulatory impact, including standards affected.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'True if the change has regulatory implications (e.g., RoHS, REACH, ITAR).',
    `related_pcn_number` STRING COMMENT 'Identifier of a related PCN, if this change is a follow‑on or amendment.',
    `sku_count` STRING COMMENT 'Number of distinct SKUs listed in the affected_sku field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the change notice record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the change notice.',
    CONSTRAINT pk_assembly_change_notice PRIMARY KEY(`assembly_change_notice_id`)
) COMMENT 'Master record for Product Change Notifications (PCN) and process change notifications originating from the packaging domain. Captures PCN number, change type (package material, process step, OSAT site transfer, substrate supplier change), affected product SKUs, change description, customer notification requirement, customer approval status, qualification requirement, effective date, and regulatory impact flag. Supports JEDEC JESD46 PCN standard and customer contractual PCN obligations. Regulatory impact assessment details are owned by compliance domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` (
    `customer_requirement_id` BIGINT COMMENT 'Primary key for customer_requirement',
    `account_id` BIGINT COMMENT 'Unique identifier of the OEM/fabless/ODM customer associated with the requirement.',
    `package_type_id` BIGINT COMMENT 'Unique identifier for the customer package type record within the customer requirement packaging entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Customer Requirement matrix is defined per IC; linking enables requirement traceability.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the customer requirement packaging entity.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Customers approve specific OSAT sites for their products. Required for order routing compliance.',
    `primary_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Customer requirements specify required package types. Needed to validate assembly orders against customer specs.',
    `tertiary_customer_packaging_package_type_id` BIGINT COMMENT 'Target package format requested by the customer.',
    `compliance_requirements` STRING COMMENT 'Regulatory or standards compliance constraints (e.g., RoHS, REACH) attached to the packaging.',
    `compliance_status` STRING COMMENT 'The compliance status of the customer requirement record in the packaging domain.',
    `contract_effective_date` DATE COMMENT 'Date when the packaging requirement contract becomes binding.',
    `contract_expiration_date` DATE COMMENT 'Date when the packaging requirement contract ends; null for open‑ended agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requirement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.. Valid values are `^[A-Z]{3}$`',
    `custom_marking` STRING COMMENT 'Customer‑specified marking, labeling, or silkscreen details for the package.',
    `customer_requirement_status` STRING COMMENT 'Current lifecycle status of the packaging requirement.. Valid values are `active|inactive|pending|suspended|draft`',
    `delivery_location` STRING COMMENT 'Customer‑specified destination for the packaged product.',
    `dry_pack_required` BOOLEAN COMMENT 'Indicates whether the package must be shipped in a dry‑pack condition.',
    `effective_date` DATE COMMENT 'The effective date associated with the customer requirement packaging record.',
    `electrical_performance_requirements` STRING COMMENT 'Electrical specifications such as impedance, capacitance, and signal integrity constraints.',
    `export_control_classification` STRING COMMENT 'Export control regime applicable to the package (EAR, ITAR, or None).. Valid values are `EAR|ITAR|None`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer requirement record in the packaging domain.',
    `leadframe_material` STRING COMMENT 'Material of the leadframe (if applicable) for the package.. Valid values are `copper|aluminum|copper_alloy`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the customer requirement record in the packaging domain.',
    `moisture_sensitivity_level` STRING COMMENT 'Moisture Sensitivity Level required for handling and storage.. Valid values are `level1|level2|level3|level4|level5|level6`',
    `notes` STRING COMMENT 'The notes of the customer requirement record in the packaging domain.',
    `package_height_mm` DECIMAL(18,2) COMMENT 'External height of the finished package in millimetres.',
    `package_length_mm` DECIMAL(18,2) COMMENT 'External length of the finished package in millimetres.',
    `package_width_mm` DECIMAL(18,2) COMMENT 'External width of the finished package in millimetres.',
    `packaging_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost of the packaging service in US dollars.',
    `packaging_material` STRING COMMENT 'Material used for the package encapsulation.. Valid values are `epoxy|organic|ceramic|silicon`',
    `packaging_sla_days` STRING COMMENT 'Maximum number of days from order receipt to package delivery as agreed with the customer.',
    `packaging_test_method` STRING COMMENT 'Primary test method used to qualify the package.. Valid values are `visual|xray|automated|functional`',
    `pcn_notification_lead_time_days` STRING COMMENT 'Number of days the customer requires advance notice for a Product Change Notification.',
    `priority` STRING COMMENT 'The priority of the customer requirement record in the packaging domain.',
    `qualification_requirements` STRING COMMENT 'Specific qualification tests or criteria the package must satisfy.',
    `reliability_target_ppm` STRING COMMENT 'Target reliability expressed as defective parts per million over the product life.',
    `required_dppm` STRING COMMENT 'Maximum allowed defective parts per million for the package.',
    `required_mtbf_hours` DECIMAL(18,2) COMMENT 'Target MTBF for the packaged component expressed in hours.',
    `required_yield_percent` DECIMAL(18,2) COMMENT 'Minimum acceptable good‑die yield percentage for the package.',
    `requirement_code` STRING COMMENT 'Coded value representing the requirement code of the customer requirement packaging record.',
    `requirement_description` STRING COMMENT 'The requirement description of the customer requirement record in the packaging domain.',
    `requirement_number` STRING COMMENT 'External business reference number for the packaging requirement contract.. Valid values are `^[A-Z0-9_-]+$`',
    `requirement_status` STRING COMMENT 'The requirement status of the customer requirement record in the packaging domain.',
    `requirement_type` STRING COMMENT 'Classification of the requirement lifecycle stage.. Valid values are `design_in|qualification|production|post_production`',
    `shipping_method` STRING COMMENT 'Preferred logistics method for delivering the packaged component.. Valid values are `air|sea|ground`',
    `specification_value` DECIMAL(18,2) COMMENT 'The specification value of the customer requirement record in the packaging domain.',
    `specified_value` DECIMAL(18,2) COMMENT 'The specified value of the customer requirement record in the packaging domain.',
    `target_value` DECIMAL(18,2) COMMENT 'The target value of the customer requirement record in the packaging domain.',
    `test_specification` STRING COMMENT 'Reference to the detailed test specification document.',
    `thermal_budget_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature rise for the package during operation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the requirement record.',
    `version_number` STRING COMMENT 'Incremental version of the requirement record for change tracking.',
    `warranty_period_months` STRING COMMENT 'Length of the warranty period offered for the packaged component.',
    `weight_gram` DECIMAL(18,2) COMMENT 'Weight of the packaged component in grams.',
    CONSTRAINT pk_customer_requirement PRIMARY KEY(`customer_requirement_id`)
) COMMENT 'Master record for customer-specific packaging requirements and design-in specifications agreed with OEM, fabless, or ODM customers. Captures customer ID, product SKU, required package type, custom marking requirements, special handling (MSL, dry pack), customer-approved OSAT sites, customer qualification requirements, PCN notification lead time, and contractual packaging SLAs. Bridges customer design-win commitments to packaging execution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` (
    `assembly_step_record_id` BIGINT COMMENT 'System‑generated unique identifier for each assembly step execution record.',
    `employee_id` BIGINT COMMENT 'Identifier of the human operator or automation agent responsible for the step execution.',
    `assembly_operator_employee_id` BIGINT COMMENT 'Unique identifier for the assembly operator employee record within the assembly step record packaging entity.',
    `assembly_process_flow_id` BIGINT COMMENT 'FK to packaging.assembly_process_flow.assembly_process_flow_id — Step records reference the process flow definition to validate correct sequence and parameters.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Step‑record cost capture links each process step’s labor and equipment spend to the cost center budgeting the lot.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the equipment (e.g., die bonder, wire bonder) that performed the step.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material lot (e.g., adhesive, underfill) consumed in this step.',
    `packaging_line_id` BIGINT COMMENT 'Unique identifier for the packaging line record within the assembly step record packaging entity.',
    `assembly_lot_id` BIGINT COMMENT 'Identifier of the assembly lot (batch of packaged units) to which this step belongs.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: REQUIRED: Mapping each assembly step to the fab step enables integrated process control and reporting.',
    `rework_assembly_step_record_id` BIGINT COMMENT 'Self-referencing FK on assembly_step_record (rework_assembly_step_record_id)',
    `assembly_step_record_status` STRING COMMENT 'The status of the assembly step record record in the packaging domain.',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp of the assembly step record record in the packaging domain.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the step (e.g., SEMI, JEDEC).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the step record was initially created in the system.',
    `defect_count` STRING COMMENT 'Number of defects detected during inspection of this step.',
    `defect_type` STRING COMMENT 'High‑level classification of detected defects (e.g., particle, misalignment, void).',
    `dppm` STRING COMMENT 'Defect density expressed as parts per million for this step.',
    `duration_seconds` STRING COMMENT 'Total elapsed time of the step in seconds (calculated from start and end timestamps).',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the assembly step record record in the packaging domain.',
    `force_n` DECIMAL(18,2) COMMENT 'Force applied (e.g., during die attach or bonding) expressed in newtons.',
    `input_quantity` STRING COMMENT 'The input quantity of the assembly step record record in the packaging domain.',
    `inspection_result` STRING COMMENT 'Outcome of the in‑process inspection for this step.. Valid values are `pass|fail|rework`',
    `is_pass` BOOLEAN COMMENT 'True if the step passed all quality criteria; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the assembly step record record in the packaging domain.',
    `material_quantity` DECIMAL(18,2) COMMENT 'Quantity of material used in the step, expressed in the unit of measure defined for the material (e.g., grams, milliliters).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the assembly step record record in the packaging domain.',
    `notes` STRING COMMENT 'Optional free‑text comments captured by the operator or system.',
    `output_quantity` STRING COMMENT 'The output quantity of the assembly step record record in the packaging domain.',
    `parameter_profile` STRING COMMENT 'JSON‑encoded set of detailed process parameters (ramp rates, dwell times, etc.) captured for the step.',
    `pressure_pa` DECIMAL(18,2) COMMENT 'Pressure applied during the step, expressed in pascals.',
    `process_yield_percent` DECIMAL(18,2) COMMENT 'Yield percentage measured after this step (good units / units processed).',
    `safety_classification` STRING COMMENT 'Safety level assigned to the step based on material and process hazards.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the assembly step record record in the packaging domain.',
    `step_code` STRING COMMENT 'Coded value representing the step code of the assembly step record packaging record.',
    `step_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the step completed or was terminated.',
    `step_name` STRING COMMENT 'The step name of the assembly step record record in the packaging domain.',
    `step_number` STRING COMMENT 'The step number of the assembly step record record in the packaging domain.',
    `step_sequence` STRING COMMENT 'Ordinal position of this step within the defined assembly process flow.',
    `step_sequence_number` STRING COMMENT 'The step sequence number of the assembly step record record in the packaging domain.',
    `step_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the step began execution on the equipment.',
    `step_status` STRING COMMENT 'Current lifecycle status of the step record.. Valid values are `completed|in_progress|failed|queued`',
    `step_type` STRING COMMENT 'Categorical code indicating the type of packaging operation performed in this step (e.g., die attach, wire bonding).. Valid values are `die_attach|wire_bond|flip_chip|molding|singulation|marking`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Target or measured temperature of the equipment during the step, expressed in degrees Celsius.',
    `units_processed` STRING COMMENT 'The units processed of the assembly step record record in the packaging domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the step record.',
    CONSTRAINT pk_assembly_step_record PRIMARY KEY(`assembly_step_record_id`)
) COMMENT 'Consolidated transactional record for all assembly process step executions including die attach, wire bonding, flip-chip bumping, molding/encapsulation, TSV formation, underfill, singulation, and marking. Captures step type, lot ID, process parameters (material, temperature, pressure, force profiles as structured data), equipment ID, operator ID, measurement results, inspection outcomes, and pass/fail disposition. Supports full traceability from packaged unit back through every process step. Replaces individual step-level tables with a single flexible entity differentiated by step type.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` (
    `packaging_line_id` BIGINT COMMENT 'Primary key for packaging_line',
    `osat_vendor_id` BIGINT COMMENT 'Unique identifier for the osat vendor record within the packaging line packaging entity.',
    `parent_packaging_line_id` BIGINT COMMENT 'Self-referencing FK on packaging_line (parent_packaging_line_id)',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the line is located.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the supervisor employee record within the packaging line packaging entity.',
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line record within the packaging line packaging entity.',
    `capacity_per_hour` DECIMAL(18,2) COMMENT 'Maximum number of packages the line can produce per hour under nominal conditions.',
    `capacity_units_per_day` STRING COMMENT 'The capacity units per day of the packaging line record in the packaging domain.',
    `capacity_units_per_hour` STRING COMMENT 'The capacity units per hour of the packaging line record in the packaging domain.',
    `classification` STRING COMMENT 'Business classification (e.g., "high_volume", "prototype", "R&D").',
    `packaging_line_code` STRING COMMENT 'Business identifier code used in production planning and scheduling.',
    `commissioning_date` DATE COMMENT 'The commissioning date associated with the packaging line packaging record.',
    `compliance_certification` STRING COMMENT 'Relevant compliance certifications held by the line (e.g., ISO 26262, IEC 61508).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the packaging line record was first created in the system.',
    `current_yield_percent` DECIMAL(18,2) COMMENT 'Observed good‑part yield as a percentage of total units processed in the latest reporting period.',
    `defect_rate_ppm` DECIMAL(18,2) COMMENT 'Defects per million units measured on the line.',
    `effective_from` DATE COMMENT 'Date when the packaging line became operational for the defined configuration.',
    `effective_until` DATE COMMENT 'Date when the packaging line configuration is scheduled to be retired or replaced (null if open‑ended).',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total electricity consumption of the line per month.',
    `equipment_count` STRING COMMENT 'Number of major equipment units (e.g., bonders, die attachers) assigned to the line.',
    `is_active` BOOLEAN COMMENT 'The is active of the packaging line record in the packaging domain.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the packaging line record in the packaging domain.',
    `line_code` STRING COMMENT 'Coded value representing the line code of the packaging line packaging record.',
    `line_name` STRING COMMENT 'The line name of the packaging line record in the packaging domain.',
    `line_status` STRING COMMENT 'The line status of the packaging line record in the packaging domain.',
    `line_type` STRING COMMENT 'Category of packaging technology employed on the line.',
    `location` STRING COMMENT 'Specific building/area within the plant (e.g., "Cleanroom 3A").',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the packaging line record in the packaging domain.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between unplanned line stoppages.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the line after a failure.',
    `packaging_line_name` STRING COMMENT 'Human‑readable name of the packaging line (e.g., "WLCSP Line A").',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance activity.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the line.',
    `operator_in_charge` STRING COMMENT 'Name or employee identifier of the primary operator responsible for the line.',
    `osat_partner` STRING COMMENT 'Name of the outsourced assembly service provider linked to this line, if any.',
    `packaging_line_status` STRING COMMENT 'Current lifecycle status of the line.',
    `process_flow_version` STRING COMMENT 'Version identifier of the process flow recipe used on the line.',
    `qualification_status` STRING COMMENT 'Current qualification state of the line for the assigned package types.',
    `safety_classification` STRING COMMENT 'Safety class assigned to the line based on hazard analysis.',
    `shift_pattern` STRING COMMENT 'Operational shift model used for the line.',
    `supported_package_families` STRING COMMENT 'The supported package families of the packaging line record in the packaging domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the packaging line record.',
    CONSTRAINT pk_packaging_line PRIMARY KEY(`packaging_line_id`)
) COMMENT 'Master reference table for packaging_line. Referenced by packaging_line_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` (
    `qualification_plan_id` BIGINT COMMENT 'Primary key for qualification_plan',
    `osat_vendor_id` BIGINT COMMENT 'Unique identifier for the osat vendor record within the qualification plan packaging entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the qualification plan packaging entity.',
    `package_qualification_id` BIGINT COMMENT 'Unique identifier for the package qualification record within the qualification plan packaging entity.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type',
    `qualification_plan_owner_employee_id` BIGINT COMMENT 'Unique identifier for the qualification plan owner employee record within the qualification plan packaging entity.',
    `superseded_qualification_plan_id` BIGINT COMMENT 'Self-referencing FK on qualification_plan (superseded_qualification_plan_id)',
    `approval_date` DATE COMMENT 'Date on which the qualification plan was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the qualification plan.',
    `confidentiality_level` STRING COMMENT 'Data classification indicating the sensitivity of the qualification plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification plan record was first created.',
    `document_url` STRING COMMENT 'Link to the detailed qualification plan document stored in the document repository.',
    `effective_end_date` DATE COMMENT 'Date on which the qualification plan expires or is superseded; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date on which the qualification plan becomes effective.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the qualification plan is mandatory for the product family.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the qualification plan record in the packaging domain.',
    `last_updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification plan.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the qualification plan record in the packaging domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the plan.',
    `osat_partner_name` STRING COMMENT 'Name of the outsourced assembly service partner linked to this qualification plan.',
    `pass_fail_threshold` STRING COMMENT 'Threshold definition (e.g., yield ≥ 99.5%) used to determine pass or fail.',
    `plan_code` STRING COMMENT 'Human‑readable code used to reference the qualification plan across systems.',
    `plan_name` STRING COMMENT 'Descriptive name of the qualification plan.',
    `plan_status` STRING COMMENT 'The plan status of the qualification plan record in the packaging domain.',
    `plan_type` STRING COMMENT 'Category of the qualification plan indicating its primary focus.',
    `plan_version` STRING COMMENT 'The plan version of the qualification plan record in the packaging domain.',
    `planned_completion_date` DATE COMMENT 'The planned completion date associated with the qualification plan packaging record.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the qualification plan packaging record.',
    `process_flow` STRING COMMENT 'Name or identifier of the assembly process flow used in the qualification.',
    `product_family` STRING COMMENT 'Family or series of semiconductor products subject to qualification.',
    `qualification_criteria` STRING COMMENT 'Key performance or reliability criteria that must be met for plan approval.',
    `qualification_plan_status` STRING COMMENT 'Current lifecycle state of the qualification plan.',
    `qualification_scope` STRING COMMENT 'Textual description of the products, packages, or processes covered by the plan.',
    `qualification_standard` STRING COMMENT 'The qualification standard of the qualification plan record in the packaging domain.',
    `responsible_engineer` STRING COMMENT 'Name or employee identifier of the engineer accountable for the plan.',
    `retention_period_days` STRING COMMENT 'Number of days the qualification plan record must be retained for compliance.',
    `revision_number` STRING COMMENT 'Revision identifier for minor updates within a version.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired minimum yield percentage for qualified units.',
    `test_end_date` DATE COMMENT 'Planned completion date for the qualification testing.',
    `test_matrix` STRING COMMENT 'The test matrix of the qualification plan record in the packaging domain.',
    `test_matrix_version` STRING COMMENT 'The test matrix version of the qualification plan record in the packaging domain.',
    `test_start_date` DATE COMMENT 'Planned start date for the qualification testing.',
    `test_suite_name` STRING COMMENT 'Name of the test suite executed as part of the qualification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the qualification plan record in the packaging domain.',
    `version_number` STRING COMMENT 'Sequential version number of the plan for change control.',
    `yield_history_reference` BIGINT COMMENT 'Reference to the historical yield data set used during plan creation.',
    `created_by` STRING COMMENT 'User or system that created the qualification plan record.',
    CONSTRAINT pk_qualification_plan PRIMARY KEY(`qualification_plan_id`)
) COMMENT 'Master reference table for qualification_plan. Referenced by qualification_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_packaging_line_id` FOREIGN KEY (`packaging_line_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`packaging_line`(`packaging_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_primary_assembly_osat_vendor_id` FOREIGN KEY (`primary_assembly_osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_primary_assembly_package_type_id` FOREIGN KEY (`primary_assembly_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ADD CONSTRAINT `fk_packaging_package_type_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_primary_assembly_package_type_id` FOREIGN KEY (`primary_assembly_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_assembly_change_notice_id` FOREIGN KEY (`assembly_change_notice_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice`(`assembly_change_notice_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_material_lot_id` FOREIGN KEY (`material_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`material_lot`(`material_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_primary_substrate_package_type_id` FOREIGN KEY (`primary_substrate_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_substrate_package_type_id` FOREIGN KEY (`substrate_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_assembly_packaging_package_type_id` FOREIGN KEY (`assembly_packaging_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_packaging_line_id` FOREIGN KEY (`packaging_line_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`packaging_line`(`packaging_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_primary_assembly_osat_vendor_id` FOREIGN KEY (`primary_assembly_osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_assembly_step_record_id` FOREIGN KEY (`assembly_step_record_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_step_record`(`assembly_step_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_inspection_result_id` FOREIGN KEY (`inspection_result_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`inspection_result`(`inspection_result_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ADD CONSTRAINT `fk_packaging_assembly_defect_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tertiary_package_type_id` FOREIGN KEY (`tertiary_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_qualification_plan_id` FOREIGN KEY (`qualification_plan_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`qualification_plan`(`qualification_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_package_qualification_id` FOREIGN KEY (`package_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_qualification`(`package_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_primary_reliability_package_qualification_id` FOREIGN KEY (`primary_reliability_package_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_qualification`(`package_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ADD CONSTRAINT `fk_packaging_reliability_stress_test_reliability_packaging_package_type_id` FOREIGN KEY (`reliability_packaging_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_assembly_step_record_id` FOREIGN KEY (`assembly_step_record_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_step_record`(`assembly_step_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ADD CONSTRAINT `fk_packaging_inspection_result_primary_assembly_lot_id` FOREIGN KEY (`primary_assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_assembly_packaging_package_type_id` FOREIGN KEY (`assembly_packaging_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ADD CONSTRAINT `fk_packaging_assembly_change_notice_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_primary_package_type_id` FOREIGN KEY (`primary_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ADD CONSTRAINT `fk_packaging_customer_requirement_tertiary_customer_packaging_package_type_id` FOREIGN KEY (`tertiary_customer_packaging_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_assembly_process_flow_id` FOREIGN KEY (`assembly_process_flow_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`(`assembly_process_flow_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_packaging_line_id` FOREIGN KEY (`packaging_line_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`packaging_line`(`packaging_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ADD CONSTRAINT `fk_packaging_assembly_step_record_rework_assembly_step_record_id` FOREIGN KEY (`rework_assembly_step_record_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_step_record`(`assembly_step_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ADD CONSTRAINT `fk_packaging_packaging_line_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ADD CONSTRAINT `fk_packaging_packaging_line_parent_packaging_line_id` FOREIGN KEY (`parent_packaging_line_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`packaging_line`(`packaging_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ADD CONSTRAINT `fk_packaging_qualification_plan_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ADD CONSTRAINT `fk_packaging_qualification_plan_package_qualification_id` FOREIGN KEY (`package_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_qualification`(`package_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ADD CONSTRAINT `fk_packaging_qualification_plan_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ADD CONSTRAINT `fk_packaging_qualification_plan_superseded_qualification_plan_id` FOREIGN KEY (`superseded_qualification_plan_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`qualification_plan`(`qualification_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`packaging` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`packaging` SET TAGS ('dbx_domain' = 'packaging');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Mpw Shuttle Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Order Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `packaging_line_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Line Identifier (PLI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `primary_assembly_osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Partner Identifier (OPID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `primary_assembly_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage (AYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_number` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` SET TAGS ('dbx_subdomain' = 'engineering_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `aec_q100_certified` SET TAGS ('dbx_business_glossary_term' = 'AEC-Q100 Certification (AEC_Q100_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score (AUDIT_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_business_glossary_term' = 'Capacity Tier (CAPACITY_TIER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|VeryHigh');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_units_per_week` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Week');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `package_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Package Capabilities (PACKAGE_CAPABILITIES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status (PARTNERSHIP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'Approved|Preferred|Probation|Suspended|Terminated');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `preferred_package_types` SET TAGS ('dbx_business_glossary_term' = 'Preferred Package Types (PREFERRED_PACKAGE_TYPES)');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` SET TAGS ('dbx_subdomain' = 'engineering_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `primary_assembly_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_to_package_type` SET TAGS ('dbx_business_glossary_term' = 'Flow To Package Type');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` SET TAGS ('dbx_subdomain' = 'engineering_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Bill of Materials ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `assembly_change_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `material_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `primary_substrate_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_to_package_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate To Package Type');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_packaging_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_packaging_package_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `export_license_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Usage Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `packaging_line_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `primary_assembly_osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_package_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Lifecycle Status (LOT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|closed|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_to_order` SET TAGS ('dbx_business_glossary_term' = 'Lot To Order');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (OPID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Run Identifier (ARI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `assembly_step_record_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Step Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_defect` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Record Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` SET TAGS ('dbx_subdomain' = 'quality_certification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_program_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_program_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_program_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sku_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tertiary_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Identifier (QUAL_PLAN_ID)');
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
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier (EQP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location (TEST_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Version (VERSION)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` SET TAGS ('dbx_subdomain' = 'quality_certification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `reliability_stress_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Stress Test ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `primary_reliability_package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Package Qualification Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Reliability Test Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `reliability_packaging_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `cycles` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Test Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|abort');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Failure Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Humidity (%)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `mttf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Failure (hours)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `reliability_stress_test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `reliability_stress_test_status` SET TAGS ('dbx_value_regex' = 'planned|running|completed|passed|failed|aborted');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Result');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `result_metric` SET TAGS ('dbx_business_glossary_term' = 'Result Metric');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `stress_test_to_qualification` SET TAGS ('dbx_business_glossary_term' = 'Stress Test To Qualification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_conditions_description` SET TAGS ('dbx_business_glossary_term' = 'Test Conditions Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_run_code` SET TAGS ('dbx_business_glossary_term' = 'Test Run Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_spec_version` SET TAGS ('dbx_business_glossary_term' = 'Test Specification Version');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_standard` SET TAGS ('dbx_value_regex' = 'JEDEC|IEC|ISO|Custom');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`reliability_stress_test` ALTER COLUMN `voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `primary_material_substrate_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Material Substrate Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUPP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `certificate_of_conformance_ref` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance Reference (COC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference (COMP_DOC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_business_glossary_term' = 'ITAR Compliance Status (ITAR_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_value_regex' = 'approved|restricted|denied');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_reach_status` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Status (REACH_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_reach_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_rohs_status` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Status (ROHS_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_rohs_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (CPU)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `humidity_storage_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (HUMID_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `incoming_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Incoming Inspection Status (INSP_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `incoming_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `inspection_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Inspection Failure Reason (INSP_FAIL_RSN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `inspection_passed` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag (INSP_PASS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MAT_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status (LOT_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_status` SET TAGS ('dbx_value_regex' = 'received|inspected|released|quarantined|consumed|expired');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type (MAT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Material Part Number (MPN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score (QUAL_SCR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received (QTY_RCV)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag (QUAR_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp (RCV_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (REL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date (EXP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition (STOR_COND)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number (SUPP_LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `temperature_storage_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (TEMP_C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pieces|kg|g|ml');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `assembly_step_record_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Step Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Identifier (EQP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (OPERATOR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `primary_assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Lot Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Identifier (SPC_CHART_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category (DEFECT_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_category` SET TAGS ('dbx_value_regex' = 'open|short|bridge|particle|misalignment|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_count_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Count per Category (DEFECT_CAT_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Defect Count (DEFECT_TOTAL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (DEFECT_DENSITY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_density_unit` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Unit (DEFECT_DENSITY_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_density_unit` SET TAGS ('dbx_value_regex' = 'defects_per_unit|defects_per_cm2');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity (SEVERITY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Inspection Disposition (DISPOSITION)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept|reject');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Code (INSPECT_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method (METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'aoi|xray|sam|manual');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_result_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lifecycle Status (INSPECT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_step` SET TAGS ('dbx_business_glossary_term' = 'Inspection Step (STEP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_step` SET TAGS ('dbx_value_regex' = 'post_die_attach|post_wire_bond|post_mold|final_visual');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Timestamp (INSPECT_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `is_spc_control` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Flag (SPC_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `pass_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `quality_outcome` SET TAGS ('dbx_business_glossary_term' = 'Quality Outcome (QUALITY_OUTCOME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `quality_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|rework');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATE_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Result');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `units_inspected` SET TAGS ('dbx_business_glossary_term' = 'Units Inspected (UNITS_INSP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`inspection_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` SET TAGS ('dbx_subdomain' = 'quality_certification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_change_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Change Notice Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Owner ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_packaging_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Supplier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `assembly_change_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Change Notice Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Attachment Reference');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_originator` SET TAGS ('dbx_business_glossary_term' = 'Change Originator');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_originator` SET TAGS ('dbx_value_regex' = 'design|process|supply_chain|quality|packaging');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'draft|review|approved|implemented|closed|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Change Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'material|process|osat_site|substrate_supplier|design|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `impact_on_dppm` SET TAGS ('dbx_business_glossary_term' = 'Impact on Defective Parts Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `impact_on_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Impact on Yield Percent (YIELD_% )');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `osat_site_transfer` SET TAGS ('dbx_business_glossary_term' = 'OSAT Site Transfer');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `package_material` SET TAGS ('dbx_business_glossary_term' = 'Package Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Number (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `process_step_changed` SET TAGS ('dbx_business_glossary_term' = 'Process Step Changed');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Qualification Required');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `regulatory_impact_details` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Details');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `related_pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Related PCN Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `sku_count` SET TAGS ('dbx_business_glossary_term' = 'SKU Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_change_notice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `customer_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Requirement Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `primary_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `tertiary_customer_packaging_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMP_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date (EFF_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `custom_marking` SET TAGS ('dbx_business_glossary_term' = 'Custom Marking Requirements (CUST_MARK)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `customer_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status (REQ_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `customer_requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|draft');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location (DEL_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `dry_pack_required` SET TAGS ('dbx_business_glossary_term' = 'Dry Pack Requirement (DRY_PACK)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `electrical_performance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Electrical Performance Requirements (ELEC_PERF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EXP_CTRL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `leadframe_material` SET TAGS ('dbx_business_glossary_term' = 'Leadframe Material (LF_MAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `leadframe_material` SET TAGS ('dbx_value_regex' = 'copper|aluminum|copper_alloy');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4|level5|level6');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `package_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Height (mm) (PKG_HT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `package_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Length (mm) (PKG_LEN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `package_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Package Width (mm) (PKG_WID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `packaging_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost (USD) (PKG_COST_USD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material (PKG_MAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `packaging_material` SET TAGS ('dbx_value_regex' = 'epoxy|organic|ceramic|silicon');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `packaging_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Packaging Service Level Agreement (PKG_SLA_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `packaging_test_method` SET TAGS ('dbx_business_glossary_term' = 'Packaging Test Method (TEST_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `packaging_test_method` SET TAGS ('dbx_value_regex' = 'visual|xray|automated|functional');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `pcn_notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'PCN Notification Lead Time (PCN_LEAD_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `qualification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Qualification Requirements (QUAL_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `reliability_target_ppm` SET TAGS ('dbx_business_glossary_term' = 'Reliability Target (PPM) (REL_TGT_PPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `required_dppm` SET TAGS ('dbx_business_glossary_term' = 'Required Defective Parts Per Million (DPPM_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `required_mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Mean Time Between Failures (MTBF_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `required_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Required Yield Percentage (YIELD_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_business_glossary_term' = 'Requirement Number (REQ_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type (REQ_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'design_in|qualification|production|post_production');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method (SHIP_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|sea|ground');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `specification_value` SET TAGS ('dbx_business_glossary_term' = 'Specification Value');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `specified_value` SET TAGS ('dbx_business_glossary_term' = 'Specified Value');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `test_specification` SET TAGS ('dbx_business_glossary_term' = 'Test Specification (TEST_SPEC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `thermal_budget_c` SET TAGS ('dbx_business_glossary_term' = 'Thermal Budget (°C) (THERM_BUDGET)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months) (WARR_MONTHS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`customer_requirement` ALTER COLUMN `weight_gram` SET TAGS ('dbx_business_glossary_term' = 'Package Weight (g) (PKG_WGT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_step_record_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Step Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `packaging_line_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `rework_assembly_step_record_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Assembly Step Record Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `rework_assembly_step_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `assembly_step_record_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Step Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Step Duration (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `force_n` SET TAGS ('dbx_business_glossary_term' = 'Process Force (N)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Input Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|rework');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `is_pass` SET TAGS ('dbx_business_glossary_term' = 'Step Pass Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `material_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Step Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `parameter_profile` SET TAGS ('dbx_business_glossary_term' = 'Parameter Profile (JSON)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `pressure_pa` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure (Pa)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `process_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Process Yield (%)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_code` SET TAGS ('dbx_business_glossary_term' = 'Step Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|queued');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_type` SET TAGS ('dbx_business_glossary_term' = 'Assembly Step Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `step_type` SET TAGS ('dbx_value_regex' = 'die_attach|wire_bond|flip_chip|molding|singulation|marking');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `units_processed` SET TAGS ('dbx_business_glossary_term' = 'Units Processed');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_step_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` SET TAGS ('dbx_subdomain' = 'engineering_standards');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `packaging_line_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `parent_packaging_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Packaging Line Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `parent_packaging_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_ssot_owner' = 'invoice.invoice_line');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_ref_role' = 'fk');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Hour');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `capacity_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `capacity_units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Hour');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `packaging_line_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `current_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `defect_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kwh');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `equipment_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Line Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Line Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mtbf Hours');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mttr Hours');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `packaging_line_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `operator_in_charge` SET TAGS ('dbx_business_glossary_term' = 'Operator In Charge');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `osat_partner` SET TAGS ('dbx_business_glossary_term' = 'Osat Partner');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `packaging_line_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `process_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Version');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `supported_package_families` SET TAGS ('dbx_business_glossary_term' = 'Supported Package Families');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`packaging_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` SET TAGS ('dbx_subdomain' = 'quality_certification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `package_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_plan_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_plan_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_plan_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `superseded_qualification_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Qualification Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `superseded_qualification_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Url');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `osat_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Osat Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `pass_fail_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `process_flow` SET TAGS ('dbx_business_glossary_term' = 'Process Flow');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `test_matrix` SET TAGS ('dbx_business_glossary_term' = 'Test Matrix');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `test_matrix_version` SET TAGS ('dbx_business_glossary_term' = 'Test Matrix Version');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `test_suite_name` SET TAGS ('dbx_business_glossary_term' = 'Test Suite Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `yield_history_reference` SET TAGS ('dbx_business_glossary_term' = 'Yield History Reference');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`qualification_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
