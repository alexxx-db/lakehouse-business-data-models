-- Schema for Domain: product | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`product` COMMENT 'Authoritative semiconductor product catalog encompassing ICs, SoCs, ASICs, FPGAs, IP cores, and discrete devices. SSOT for product specifications, SKUs, BOM, process node assignments, PPA metrics, product lifecycle status (NPI through EOL), PCN management, and LTB notifications. Integrates with PLM systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` (
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the IC catalog entry. Primary key for the master record of semiconductor products including ICs, SoCs, ASICs, FPGAs, discretes, and licensable IP cores.',
    `family_id` BIGINT COMMENT 'FK to product.product_family.product_family_id — Every IC product belongs to a product family in the taxonomy hierarchy. This is the primary classification FK.',
    `ic_family_id` BIGINT COMMENT 'FK to product.product_family',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Every IC catalog entry has a corresponding material master in semiconductor ERP for procurement and inventory management. This link enables direct MRP consumption from catalog, cost accounting, and su',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Procurement process requires linking each IC catalog entry to its primary supplier for sourcing, cost analysis, and compliance tracking.',
    `aec_qualification_level` STRING COMMENT 'Specific AEC qualification standard met. Q100: ICs, Q101: Discretes, Q102: Optoelectronics, Q200: Passives. Set to NA if not automotive qualified.. Valid values are `AEC-Q100|AEC-Q101|AEC-Q102|AEC-Q200|NA`',
    `automotive_qualified` BOOLEAN COMMENT 'Indicates whether the product has passed automotive-grade qualification testing per AEC-Q standards. Required for automotive market. Includes extended temperature, reliability, and quality requirements.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the IC was manufactured or substantially transformed. Used for trade compliance, tariffs, and country-of-origin marking requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IC catalog record was first created in the PLM system. Audit trail for data governance and lineage tracking.',
    `design_type` STRING COMMENT 'Design methodology used for IC development. Determines NRE cost, time to market, and flexibility. Full custom offers maximum optimization; standard cell balances speed and cost.. Valid values are `Full_Custom|Semi_Custom|Standard_Cell|Gate_Array|Structured_ASIC|Platform_Based`',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'Physical die area in square millimeters after final layout. Critical cost driver as it determines dies per wafer and manufacturing yield economics. Part of PPA metrics.',
    `ear_eccn_code` STRING COMMENT 'ECCN code assigned under US Export Administration Regulations. Determines export licensing requirements for dual-use items. Format: 3A001.a. EAR99 indicates no specific ECCN.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `eol_announcement_date` DATE COMMENT 'Date when EOL was formally announced to customers via Product Change Notification (PCN). Triggers last-time-buy (LTB) planning and customer transition activities.',
    `first_silicon_date` DATE COMMENT 'Date when first fabricated silicon wafers were received from the fab for initial testing and validation. Marks start of silicon bring-up phase.',
    `hts_code` STRING COMMENT 'US Harmonized Tariff Schedule classification code for customs and import duty determination. Format: 8542.31.0000 for electronic integrated circuits.. Valid values are `^[0-9]{4}.[0-9]{2}.[0-9]{4}$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this catalog entry is currently active and available for business operations. False indicates archived or soft-deleted record retained for historical reference.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the product is subject to ITAR export controls for defense-related articles. True if product requires US State Department export license for international shipment.',
    `last_ship_date` DATE COMMENT 'Final date when product shipments will be made. Marks complete discontinuation of the product. Typically 6-12 months after last-time-buy date to allow for manufacturing lead time.',
    `last_time_buy_date` DATE COMMENT 'Final date for customers to place orders before product is discontinued. Typically 6-12 months after EOL announcement. After this date, no new orders are accepted.',
    `lead_free_compliant` BOOLEAN COMMENT 'Indicates whether the product meets RoHS (Restriction of Hazardous Substances) lead-free requirements. True if compliant with EU RoHS Directive for lead-free solder and materials.',
    `lifecycle_status` STRING COMMENT 'Current stage in the product lifecycle from New Product Introduction (NPI) through End of Life (EOL). Governs manufacturing, sales, and support activities. Transitions tracked in status history. [ENUM-REF-CANDIDATE: NPI|Qualification|Production|Mature|EOL_Announced|EOL_Active|Obsolete — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IC catalog record was last updated. Tracks data currency and change history for audit and synchronization purposes.',
    `npi_phase` STRING COMMENT 'Detailed phase within NPI lifecycle for products in pre-production stages. Tracks progress from concept through design, tapeout, silicon bring-up, and qualification. Set to NA for production products. [ENUM-REF-CANDIDATE: Concept|Design|Tapeout|Silicon_Validation|Qualification|Ramp|Production|NA — 8 candidates stripped; promote to reference product]',
    `operating_frequency_max_mhz` DECIMAL(18,2) COMMENT 'Maximum clock frequency in MHz at which the IC can reliably operate. Key performance metric for processors, SoCs, and high-speed digital circuits. Part of PPA metrics.',
    `operating_voltage_max_v` DECIMAL(18,2) COMMENT 'Maximum supply voltage in volts for safe operation. Defines upper bound of operating voltage range. Exceeding this may cause device damage or reliability issues.',
    `operating_voltage_min_v` DECIMAL(18,2) COMMENT 'Minimum supply voltage in volts for guaranteed operation. Defines lower bound of operating voltage range for power optimization and battery operation.',
    `pin_count` STRING COMMENT 'Total number of external pins or balls on the package. Determines PCB routing complexity, package cost, and I/O capability.',
    `power_max_mw` DECIMAL(18,2) COMMENT 'Maximum power consumption in milliwatts under worst-case operating conditions. Used for thermal design, power supply sizing, and system integration planning.',
    `power_typical_mw` DECIMAL(18,2) COMMENT 'Typical operating power consumption in milliwatts under nominal conditions. Critical PPA metric for mobile, IoT, and battery-powered applications. Measured at specified voltage and frequency.',
    `process_technology` STRING COMMENT 'Underlying semiconductor process technology architecture. Examples: CMOS (Complementary Metal-Oxide-Semiconductor), FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), BiCMOS (Bipolar CMOS). [ENUM-REF-CANDIDATE: CMOS|FinFET|GAA|BiCMOS|SOI|GaN|SiGe — 7 candidates stripped; promote to reference product]',
    `product_name` STRING COMMENT 'Human-readable marketing name of the IC product used in customer communications, datasheets, and sales collateral.',
    `product_type` STRING COMMENT 'High-level classification of the semiconductor product type. Determines design flow, manufacturing process, and business model (silicon vs. licensable IP). [ENUM-REF-CANDIDATE: IC|SoC|ASIC|FPGA|IP_Core|Discrete|Memory|Analog|Mixed_Signal|RF — 10 candidates stripped; promote to reference product]',
    `production_release_date` DATE COMMENT 'Date when product was officially released to production status and made available for volume manufacturing and customer orders. Marks end of qualification phase.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates compliance with EU REACH (Registration, Evaluation, Authorization and Restriction of Chemicals) regulation. Confirms no Substances of Very High Concern (SVHC) above threshold.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates full compliance with EU RoHS Directive restricting hazardous substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE). Required for European market access.',
    `rtl_language` STRING COMMENT 'Hardware description language used for RTL design specification. Verilog and SystemVerilog are industry standard for digital design. Set to NA for analog-only or IP-only products.. Valid values are `Verilog|VHDL|SystemVerilog|Chisel|NA`',
    `tapeout_date` DATE COMMENT 'Date when final GDSII design database was released to the fab for mask generation and wafer fabrication. Marks completion of design phase and start of manufacturing.',
    `target_market` STRING COMMENT 'Primary market segment or application domain for which the IC is designed. Determines qualification requirements, reliability standards, and regulatory compliance needs. [ENUM-REF-CANDIDATE: Automotive|Consumer|Industrial|Medical|Aerospace|Defense|Telecom|Computing|IoT|AI_ML — 10 candidates stripped; promote to reference product]',
    `temperature_grade` STRING COMMENT 'Temperature range classification determining qualified operating environment. Commercial: 0-70C, Industrial: -40-85C, Automotive: -40-125C, Military: -55-125C. Critical for market qualification.. Valid values are `Commercial|Industrial|Automotive|Military|Extended`',
    `transistor_count` BIGINT COMMENT 'Total number of transistors on the die. Key complexity metric for digital ICs and SoCs. Used for design effort estimation and manufacturing complexity assessment.',
    CONSTRAINT pk_ic_catalog PRIMARY KEY(`ic_catalog_id`)
) COMMENT 'Master record for all semiconductor products (ICs, SoCs, ASICs, FPGAs, discretes, licensable IP cores). SSOT for product identity, internal/external part numbers, product family assignment, process node, target market, and lifecycle state with full NPI→qualification→production→EOL transition history. Golden record integrated with PLM. Each entry represents a unique silicon design with one or more orderable SKU variants.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the stock keeping unit record. Primary key for the SKU entity representing a distinct orderable variant of a catalog product.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: SKUs are the orderable units that correspond directly to material master records in semiconductor ERP systems. Each SKU maps to a material master for procurement, inventory valuation, and MRP demand p',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the parent product definition in the IC catalog. Links this SKU to the base product design and specification.',
    `replacement_sku_id` BIGINT COMMENT 'Reference to the recommended replacement SKU for customers when this SKU reaches end of life. Facilitates design migration and continuity planning.',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Every SKU is an orderable variant of a catalog product. This is the most fundamental FK in the domain — without it, SKUs are orphaned from their parent product definition.',
    `sku_code` STRING COMMENT 'Externally-facing unique alphanumeric code identifying this orderable SKU variant. Used in customer orders, invoices, and supply chain documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where final manufacturing or substantial transformation occurred. Required for customs documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was first created in the system. Audit trail for data lineage and compliance.',
    `customer_part_number` STRING COMMENT 'Optional customer-specific part number assigned to this SKU for custom or design-win scenarios. Facilitates customer BOM alignment.',
    `eccn_code` STRING COMMENT 'US Bureau of Industry and Security (BIS) Export Administration Regulations (EAR) classification code. Determines export licensing requirements.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `eol_announcement_date` DATE COMMENT 'Date when Product Change Notification (PCN) was issued announcing the end of life for this SKU. Triggers Last Time Buy (LTB) planning for customers.',
    `halogen_free` BOOLEAN COMMENT 'Indicates whether this SKU is manufactured without halogen-containing materials (chlorine, bromine compounds). Required for certain environmental certifications.',
    `hts_code` STRING COMMENT 'International customs classification code for tariff and duty calculation. Used for cross-border shipments and trade compliance.. Valid values are `^[0-9]{4}.[0-9]{2}.[0-9]{2}.[0-9]{2}$`',
    `introduction_date` DATE COMMENT 'Date when this SKU was first made available for customer orders. Marks the transition from NPI to Active lifecycle status.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this SKU is subject to US ITAR export controls for defense articles. Requires special licensing and handling procedures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was most recently updated. Tracks data currency and change history.',
    `last_ship_date` DATE COMMENT 'Final date when shipments of this SKU will be fulfilled. Marks the end of product availability and transition to discontinued status.',
    `last_time_buy_date` DATE COMMENT 'Final date for customers to place orders for this SKU before discontinuation. Typically 6-12 months after EOL announcement.',
    `lead_time_weeks` STRING COMMENT 'Typical manufacturing and delivery lead time in weeks from order placement to shipment. Subject to capacity allocation and supply chain conditions.',
    `lifecycle_status` STRING COMMENT 'Current stage in the product lifecycle. NPI (New Product Introduction), Active (full production), Mature (stable demand), Declining (phase-out), EOL Announced (End of Life notice issued), Discontinued (no longer available).. Valid values are `npi|active|mature|declining|eol_announced|discontinued`',
    `list_price_usd` DECIMAL(18,2) COMMENT 'Published list price in US dollars for this SKU at 1000-unit quantity. Actual transaction prices subject to volume discounts and customer agreements.',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity that can be ordered for this SKU in a single purchase order line. Driven by packaging constraints and economic order quantities.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC moisture sensitivity classification indicating required storage and handling conditions before reflow soldering. MSL1 (unlimited floor life) to MSL6 (mandatory bake before use). [ENUM-REF-CANDIDATE: MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5|MSL5a|MSL6 — 8 candidates stripped; promote to reference product]',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this SKU is currently available for new customer orders. May be false during allocation, quality holds, or phase-out periods.',
    `pcn_required_flag` BOOLEAN COMMENT 'Indicates whether any changes to this SKU specification, manufacturing process, or supply chain require formal Product Change Notification (PCN) to customers per contractual or regulatory requirements.',
    `pin_count` STRING COMMENT 'Total number of electrical pins or balls on the package. Critical for PCB design and routing complexity assessment.',
    `qualification_level` STRING COMMENT 'Reliability and qualification standard met by this SKU. AEC-Q100 for automotive ICs, AEC-Q101 for discrete automotive, MIL-STD-883 for military/aerospace.. Valid values are `commercial|industrial|automotive_aec_q100|automotive_aec_q101|military_mil_std_883|space`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether this SKU meets EU REACH regulation requirements for chemical substance registration and disclosure.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether this SKU meets EU RoHS directive requirements for restricted substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE).',
    `shippable_flag` BOOLEAN COMMENT 'Indicates whether this SKU is currently authorized for shipment. May be false during quality holds, regulatory blocks, or export restrictions.',
    `speed_grade` STRING COMMENT 'Performance binning classification indicating maximum operating frequency or timing specification. Higher grades command premium pricing.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Fully-loaded standard manufacturing cost in US dollars including wafer fabrication, assembly, test, and allocated overhead. Used for margin analysis and inventory valuation.',
    `standard_pack_quantity` STRING COMMENT 'Number of units in a standard shipping container (tape and reel, tray, tube). Orders are typically placed in multiples of this quantity.',
    `temperature_range` STRING COMMENT 'Qualified operating temperature range classification. Commercial (0-70C), Industrial (-40-85C), Automotive (-40-125C), Military (-55-125C), Extended (-40-105C).. Valid values are `commercial|industrial|automotive|military|extended`',
    `unit_weight_grams` DECIMAL(18,2) COMMENT 'Weight of a single packaged unit in grams. Used for shipping cost calculation and logistics planning.',
    `voltage_variant` STRING COMMENT 'Core or I/O voltage specification variant for this SKU. Defines power supply requirements and compatibility with system voltage rails.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock-keeping unit records representing orderable, shippable variants of catalog products. Each SKU captures the specific combination of package type, speed grade, temperature range, voltage variant, and qualification level (commercial, industrial, automotive AEC-Q100/Q101) that constitutes a distinct orderable item. Links to ic_catalog for the parent product definition and to inventory for stock tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Unique identifier for the product family. Primary key for the product family entity.',
    `parent_family_id` BIGINT COMMENT 'Reference to the parent product family in the hierarchy. Supports multi-level taxonomy: portfolio → family → sub-family → product → variant. Null for top-level portfolio entries.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Product families are manufactured at specific foundry/fab suppliers. Family-level supplier assignment drives NPI planning, capacity allocation, and technology roadmap decisions. fab_site_code and osat',
    `active_pcn_count` STRING COMMENT 'Number of active PCNs currently in effect for this product family. Indicates ongoing changes to process, materials, or design that require customer notification and approval.',
    `application_domain` STRING COMMENT 'Specific application domain or use case this product family addresses (e.g., Advanced Driver Assistance Systems, Edge AI Inference, 5G Baseband Processing). Used for technical marketing and customer solution mapping.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for this product family (e.g., Automotive Solutions, Mobile Computing, IoT and Embedded). Aligns with organizational structure and P&L responsibility.',
    `family_code` STRING COMMENT 'Unique alphanumeric code identifying the product family in external systems and customer communications. Used in PLM, ERP, and CRM systems for product taxonomy navigation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was first created in the system. Used for data lineage and audit trail.',
    `family_description` STRING COMMENT 'Detailed description of the product family including target applications, key features, and market positioning. Used for technical documentation and sales enablement.',
    `design_center_location` STRING COMMENT 'Primary design center location responsible for this product family (e.g., San Jose CA, Austin TX, Bangalore India). Used for resource planning and IP ownership tracking.',
    `dfm_score` DECIMAL(18,2) COMMENT 'Design for Manufacturability score (0-100) indicating how well the product family design aligns with manufacturing best practices. Higher scores correlate with better yield and lower manufacturing risk.',
    `dft_coverage_percent` DECIMAL(18,2) COMMENT 'Design for Testability coverage percentage indicating the proportion of circuit nodes accessible for ATPG (Automatic Test Pattern Generation). Higher coverage enables better defect detection during wafer test.',
    `discontinuation_date` DATE COMMENT 'Date when this product family was fully discontinued and removed from active catalog. No further production or shipments after this date.',
    `ear_eccn_code` STRING COMMENT 'Export Control Classification Number under US EAR regulations. Defines export licensing requirements for dual-use technology. Format: category (0-9), product group (A-E), reason for control (001-999).. Valid values are `^[0-9][A-Z][0-9]{3}$`',
    `eda_tool_suite` STRING COMMENT 'Primary EDA tool suite used for design and verification of this product family (e.g., Cadence Virtuoso/Innovus, Synopsys Design Compiler/IC Compiler). Defines design methodology and tool licensing requirements.',
    `eol_announcement_date` DATE COMMENT 'Date when EOL was announced to customers via PCN (Product Change Notification). Triggers LTB (Last Time Buy) planning and customer migration activities.',
    `family_type` STRING COMMENT 'Classification of the product family by semiconductor device type. Aligns with industry standard device categories for design, fabrication, and test planning. [ENUM-REF-CANDIDATE: IC|SoC|ASIC|FPGA|IP_Core|Discrete|Mixed_Signal — 7 candidates stripped; promote to reference product]',
    `hierarchy_level` STRING COMMENT 'Numeric level in the product family hierarchy (1=portfolio, 2=family, 3=sub-family, 4=product, 5=variant). Supports up to five levels of product taxonomy as defined in the product domain.',
    `ip_core_count` STRING COMMENT 'Number of reusable IP cores integrated into products in this family. Indicates design complexity and IP licensing requirements. Used for NRE (Non-Recurring Engineering) cost estimation.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this product family is subject to ITAR export controls for defense-related technology. Restricts international sales and requires export licensing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was last updated. Used for change tracking and data synchronization across systems.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the product family: Concept (early planning), NPI (New Product Introduction), Active (volume production), Mature (stable production), Phase_Out (declining), EOL (End of Life announced), Discontinued (no longer available). Drives supply chain and customer communication strategies. [ENUM-REF-CANDIDATE: Concept|NPI|Active|Mature|Phase_Out|EOL|Discontinued — 7 candidates stripped; promote to reference product]',
    `lithography_type` STRING COMMENT 'Photolithography technology used for patterning (EUV Extreme Ultraviolet, DUV Deep Ultraviolet). Impacts design complexity, mask costs, and fab capability requirements.. Valid values are `EUV|DUV|Immersion|Dry`',
    `ltb_date` DATE COMMENT 'Final date for customers to place orders before product family is discontinued. Part of EOL process and customer lifecycle management.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this product family record. Used for audit trail and data governance.',
    `family_name` STRING COMMENT 'Business name of the product family (e.g., Cortex-M Series, Automotive MCU Family, RF Transceiver Family). Used in roadmap planning, marketing materials, and customer design-in targeting.',
    `npi_start_date` DATE COMMENT 'Date when this product family entered NPI phase. Marks the beginning of qualification, ramp, and early customer shipments. Used for TTM (Time to Market) tracking.',
    `package_type` STRING COMMENT 'Primary packaging technology for this product family (e.g., WLCSP Wafer-Level Chip Scale Package, BGA Ball Grid Array, QFN Quad Flat No-Lead, CoWoS Chip on Wafer on Substrate, InFO Integrated Fan-Out). Defines assembly process and thermal/electrical characteristics.',
    `pdk_version` STRING COMMENT 'Version of the Process Design Kit used for this product family. PDK contains design rules, device models, and technology files required for IC design. Critical for design-to-manufacturing alignment.',
    `process_node_nm` STRING COMMENT 'Semiconductor fabrication process node in nanometers (e.g., 5, 7, 14, 28). Defines the manufacturing technology generation and impacts PPA (Power Performance Area) characteristics. Critical for fab capacity planning and yield modeling.',
    `process_technology` STRING COMMENT 'Transistor architecture technology used in the process node (FinFET, GAA Gate All Around, Planar, FD-SOI Fully Depleted Silicon On Insulator). Determines electrical characteristics and design rules.. Valid values are `FinFET|GAA|Planar|FD_SOI`',
    `product_line_manager` STRING COMMENT 'Name of the product line manager responsible for roadmap, positioning, and lifecycle management of this product family. Business owner for strategic decisions.',
    `qualification_standard` STRING COMMENT 'Industry qualification standard this product family must meet (e.g., AEC-Q100 for automotive, MIL-STD-883 for military, JEDEC JESD47 for stress testing). Defines reliability testing requirements.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether this product family complies with EU REACH Regulation for chemical substance safety. Required for European market sales and supply chain transparency.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether this product family is designed to comply with EU RoHS Directive restricting hazardous substances in electronic equipment. Critical for European market access.',
    `target_market_segment` STRING COMMENT 'Primary market segment this product family targets. Used for roadmap planning, pricing strategy, and customer design-in targeting. Aligns with business unit structure and go-to-market strategy. [ENUM-REF-CANDIDATE: Computing|Mobile|Automotive|AI_ML|IoT|Industrial|Consumer|Networking|Data_Center — 9 candidates stripped; promote to reference product]',
    `target_performance_metric` STRING COMMENT 'Key performance metric and target value for this product family (e.g., 3.5 GHz clock frequency, 100 TOPS AI performance, 10 Gbps throughput). Used for competitive analysis and roadmap planning.',
    `target_power_mw` DECIMAL(18,2) COMMENT 'Target typical power consumption in milliwatts for this product family. Part of PPA (Power Performance Area) metrics used for competitive positioning and customer design-in evaluation.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target manufacturing yield percentage (good dies per wafer) for this product family at volume production. Used for cost modeling, capacity planning, and fab performance tracking.',
    `typical_die_size_mm2` DECIMAL(18,2) COMMENT 'Representative die size in square millimeters for products in this family. Used for wafer yield modeling, cost estimation, and capacity planning. Actual die sizes may vary by specific product variant.',
    `volume_production_date` DATE COMMENT 'Date when this product family achieved volume production status (Active lifecycle). Indicates full manufacturing qualification and capacity availability.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Hierarchical grouping of related IC products into product families and sub-families (e.g., Cortex-class SoCs, automotive MCU family, RF transceiver family). Manages the multi-level product taxonomy used for roadmap planning, pricing strategy, and customer design-in targeting. Supports up to five levels of hierarchy: portfolio → family → sub-family → product → variant.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_spec` (
    `product_spec_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the parent product (IC, SoC, ASIC, FPGA, IP core, or discrete device) for which this specification applies.',
    `approval_date` DATE COMMENT 'Date when this specification was formally approved for release to manufacturing or customers.',
    `approved_by` STRING COMMENT 'Name or identifier of the engineering authority who approved this specification for release.',
    `automotive_grade` STRING COMMENT 'AEC-Q100 automotive qualification grade indicating temperature range and reliability requirements (Grade 0: -40°C to 150°C, Grade 1: -40°C to 125°C, Grade 2: -40°C to 105°C, Grade 3: -40°C to 85°C).. Valid values are `none|aec_q100_grade_0|aec_q100_grade_1|aec_q100_grade_2|aec_q100_grade_3`',
    `characterization_date` DATE COMMENT 'Date when this specification was characterized and validated through silicon testing or simulation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product specification record was first created in the system.',
    `data_retention_years` STRING COMMENT 'Guaranteed data retention period in years for non-volatile memory components at specified temperature.',
    `die_area_achieved_mm2` DECIMAL(18,2) COMMENT 'Actual measured silicon die area in square millimeters (mm²) from physical layout. Part of PPA (Power-Performance-Area) metrics.',
    `die_area_target_mm2` DECIMAL(18,2) COMMENT 'Target silicon die area in square millimeters (mm²). Part of PPA (Power-Performance-Area) metrics.',
    `dynamic_power_achieved_mw` DECIMAL(18,2) COMMENT 'Actual measured or characterized dynamic power consumption in milliwatts (mW) during active switching operation at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `dynamic_power_target_mw` DECIMAL(18,2) COMMENT 'Target dynamic power consumption in milliwatts (mW) during active switching operation at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `endurance_cycles` BIGINT COMMENT 'Number of program/erase cycles guaranteed for non-volatile memory components (applicable to flash, EEPROM).',
    `esd_protection_level_kv` DECIMAL(18,2) COMMENT 'Electrostatic discharge protection rating in kilovolts (kV) per JEDEC standards (e.g., HBM, CDM models).',
    `functional_safety_rating` STRING COMMENT 'Functional safety certification level achieved by the product. ISO 26262 ASIL (Automotive Safety Integrity Level) A through D for automotive applications; IEC 61508 SIL (Safety Integrity Level) 1 through 4 for industrial applications. [ENUM-REF-CANDIDATE: none|iso_26262_asil_a|iso_26262_asil_b|iso_26262_asil_c|iso_26262_asil_d|iec_61508_sil_1|iec_61508_sil_2|iec_61508_sil_3|iec_61508_sil_4 — 9 candidates stripped; promote to reference product]',
    `gate_count` BIGINT COMMENT 'Total number of logic gates (or gate equivalents) in the design, representing design complexity.',
    `interface_protocols` STRING COMMENT 'Comma-separated list of supported communication interface protocols (e.g., PCIe, USB, DDR4, MIPI, SPI, I2C, CAN, Ethernet).',
    `io_count` STRING COMMENT 'Total number of input/output pins or pads available on the integrated circuit for signal connectivity.',
    `leakage_power_achieved_mw` DECIMAL(18,2) COMMENT 'Actual measured or characterized static leakage power consumption in milliwatts (mW) when the circuit is idle at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `leakage_power_target_mw` DECIMAL(18,2) COMMENT 'Target static leakage power consumption in milliwatts (mW) when the circuit is idle at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `max_frequency_achieved_mhz` DECIMAL(18,2) COMMENT 'Actual measured or characterized maximum operating frequency in megahertz (MHz) at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `max_frequency_target_mhz` DECIMAL(18,2) COMMENT 'Target maximum operating frequency in megahertz (MHz) at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `memory_configuration` STRING COMMENT 'Description of on-chip memory architecture including SRAM, cache, ROM, and embedded flash sizes and organization (e.g., 256KB L2 Cache, 2MB SRAM, 512KB ROM).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product specification record was last modified.',
    `notes` STRING COMMENT 'Additional notes, caveats, or clarifications regarding this product specification, including test conditions, measurement methodology, or known limitations.',
    `operating_condition_corner` STRING COMMENT 'Process-voltage-temperature (PVT) corner at which this specification is characterized. Typical represents nominal conditions; best/worst case represent performance extremes; slow/fast combinations represent process variation corners. [ENUM-REF-CANDIDATE: typical|best_case|worst_case|slow_slow|fast_fast|slow_fast|fast_slow — 7 candidates stripped; promote to reference product]',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum junction temperature in degrees Celsius at which the product is guaranteed to function within specification.',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum junction temperature in degrees Celsius at which the product is guaranteed to function within specification.',
    `operating_voltage_max_v` DECIMAL(18,2) COMMENT 'Maximum operating voltage in volts (V) at which the product is guaranteed to function within specification.',
    `operating_voltage_min_v` DECIMAL(18,2) COMMENT 'Minimum operating voltage in volts (V) at which the product is guaranteed to function within specification.',
    `operating_voltage_nominal_v` DECIMAL(18,2) COMMENT 'Nominal (typical) operating voltage in volts (V) for standard operation.',
    `package_type` STRING COMMENT 'Semiconductor package type and form factor (e.g., BGA, QFN, WLCSP, LGA, SOIC, DIP, CoWoS, InFO).',
    `process_node_nm` STRING COMMENT 'Semiconductor fabrication process technology node in nanometers (nm), representing the minimum feature size (e.g., 7, 5, 3).',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the product meets EU REACH regulation requirements for chemical substance registration and restriction.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the product meets EU RoHS directive requirements for restriction of hazardous substances (lead, mercury, cadmium, etc.).',
    `security_features` STRING COMMENT 'Comma-separated list of implemented hardware security features (e.g., Secure Boot, TrustZone, AES-256, SHA-256, Hardware Root of Trust, Anti-Tamper).',
    `spec_status` STRING COMMENT 'Current lifecycle status of this product specification (Draft: under development, Preliminary: pre-silicon or early silicon, Final: production-qualified, Obsolete: superseded by newer version).. Valid values are `draft|preliminary|final|obsolete`',
    `transistor_architecture` STRING COMMENT 'Type of transistor structure used in the process technology (Planar, FinFET, GAA - Gate All Around, Nanosheet, Nanowire).. Valid values are `planar|finfet|gaa|nanosheet|nanowire`',
    `transistor_count` BIGINT COMMENT 'Total number of transistors in the integrated circuit design.',
    `version` STRING COMMENT 'Version number of this product specification, following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Incremented with each specification revision.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_product_spec PRIMARY KEY(`product_spec_id`)
) COMMENT 'Detailed electrical, functional, and PPA (Power-Performance-Area) specifications for each IC product at given operating condition corners. Covers operating voltage range, temperature range, I/O count, interface protocols, memory configuration, security features, functional safety ratings (ISO 26262 ASIL, IEC 61508 SIL), plus target and achieved values for dynamic power, leakage power, maximum frequency, and die area. Supports multi-corner characterization and competitive PPA benchmarking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`bom` (
    `bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials header record. Primary key for the BOM entity.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the parent IC product or assembly that this BOM defines. Links to the product master catalog.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: BOMs often designate a contract manufacturer or primary supplier for the overall assembly, needed for production planning.',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Each BOM defines the component structure of a specific IC product. The BOM header must reference the product it describes.',
    `alternative_bom_indicator` STRING COMMENT 'Identifier for alternative BOM configurations for the same product. Used when multiple valid component combinations exist (e.g., different suppliers, different process nodes, or design variants).',
    `approval_date` DATE COMMENT 'Date when this BOM was formally approved for use. Marks the transition from draft/review to approved status.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The quantity of the parent product that this BOM defines. Typically 1 for single-unit BOMs, but may be higher for batch or lot-based manufacturing. All component quantities in BOM lines are relative to this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity, such as EA (each), LOT, WAFER, or other semiconductor-specific units. Must align with product master UOM.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, typically a human-readable code used across PLM and ERP systems for tracking and reference.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Draft indicates work in progress, in_review indicates pending approval, approved indicates ready for use, active indicates currently in production, frozen indicates locked for manufacturing, obsolete indicates no longer valid, superseded indicates replaced by newer revision. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|frozen|obsolete|superseded — 7 candidates stripped; promote to reference product]',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended use: engineering BOM (EBOM) for design, manufacturing BOM (MBOM) for production, service BOM for maintenance, planning BOM for forecasting, as-designed for original specification, or as-built for actual production configuration.. Valid values are `engineering|manufacturing|service|planning|as_designed|as_built`',
    `conflict_minerals_compliant_flag` BOOLEAN COMMENT 'Indicates whether the BOM and all its components are free from conflict minerals (tin, tantalum, tungsten, gold) sourced from conflict regions, per Dodd-Frank Act Section 1502 requirements.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total material cost. Typically USD for semiconductor industry but may vary by region.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `critical_material_flag` BOOLEAN COMMENT 'Indicates whether this BOM contains components classified as critical materials (long lead time, single source, strategic importance). Used for supply chain risk management.',
    `ear_classification` STRING COMMENT 'Export Control Classification Number (ECCN) or other EAR classification for this BOM. Determines export licensing requirements and restrictions.',
    `effective_end_date` DATE COMMENT 'Date after which this BOM revision is no longer valid for new production orders. Null indicates the BOM is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this BOM revision becomes valid and can be used for manufacturing, procurement, and costing. Critical for managing engineering changes and product transitions.',
    `engineering_change_order_number` STRING COMMENT 'Reference to the engineering change order that created or last modified this BOM revision. Critical for change traceability and audit compliance.',
    `eol_date` DATE COMMENT 'Planned or actual end-of-life date for this BOM. After this date, the product is no longer manufactured or supported.',
    `explosion_type` STRING COMMENT 'Defines how the BOM should be exploded for planning and costing: single-level shows only immediate children, multi-level shows full hierarchy, summarized shows consolidated component totals.. Valid values are `single_level|multi_level|summarized`',
    `external_bom_reference` STRING COMMENT 'Original BOM identifier from the source PLM or ERP system. Maintains traceability to upstream systems and enables cross-system reconciliation.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this BOM contains components or technology subject to ITAR export control regulations. Critical for defense and aerospace semiconductor applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was last updated. Tracks the most recent change for change management and audit purposes.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production lot size for which this BOM is optimized. Used in material requirements planning (MRP) and capacity planning calculations.',
    `ltb_notification_date` DATE COMMENT 'Date when Last Time Buy notification was issued for this BOM, indicating the product is approaching end-of-life and customers should place final orders.',
    `pcn_number` STRING COMMENT 'Product Change Notification number issued to customers when this BOM revision represents a material change to the product. Required for customer communication and approval.',
    `plant_code` STRING COMMENT 'Manufacturing plant or fabrication facility (FAB) where this BOM is applicable. Different plants may have different BOMs for the same product due to process variations or equipment differences.',
    `production_version` STRING COMMENT 'Production version identifier linking this BOM to a specific routing or process flow. Enables coordination between BOM and manufacturing process definitions.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the BOM and all its components meet REACH regulation requirements for chemical substance registration and safety. Rolled up from component-level compliance data.',
    `revision` STRING COMMENT 'Revision level or version of the BOM, incremented with each engineering change. Critical for change management and traceability.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the BOM and all its components meet RoHS directive requirements for restriction of hazardous substances. Rolled up from component-level compliance data.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'Expected scrap or yield loss percentage at the BOM level. Used to adjust material requirements and costing. Typical semiconductor yield losses are factored here.',
    `total_component_count` STRING COMMENT 'Total number of distinct component line items in this BOM. Provides quick visibility into BOM complexity without querying detail records.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'Rolled-up total material cost for all components in this BOM, calculated from component costs and quantities. Used for product costing and margin analysis.',
    `usage` STRING COMMENT 'Intended usage context for this BOM: production for manufacturing execution, costing for financial analysis, engineering for design reference, maintenance for service operations, or sales for customer quotations.. Valid values are `production|costing|engineering|maintenance|sales`',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of Materials header records defining the hierarchical component structure of each IC product assembly. Captures BOM revision, effectivity dates, BOM type (engineering, manufacturing, service), approval status, and overall RoHS/REACH compliance rollup. Parent entity for bom_line detail records. Integrates with PLM and ERP systems for manufacturing execution and change management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the BOM line entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: In semiconductor BOMs, individual line-item components are frequently other ICs or semiconductor devices that exist in the ic_catalog (e.g., a SoC BOM includes memory ICs, power management ICs, interf',
    `product_ip_core_id` BIGINT COMMENT 'Foreign key linking to product.product_ip_core. Business justification: When a SoC or ASIC BOM is defined, licensed IP cores (CPU cores, PHY blocks, memory controllers, etc.) appear as BOM line items. Adding component_product_ip_core_id on bom_line creates a direct FK to ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each BOM line component maps to a material master record for MRP, procurement planning, and inventory management. In semiconductor ERP (SAP MM), BOM line items must reference material master for cost ',
    `parent_line_bom_line_id` BIGINT COMMENT 'Reference to the parent BOM line in a multi-level BOM structure. Null for top-level components. Enables recursive BOM explosion and indented BOM reports.',
    `bom_id` BIGINT COMMENT 'Reference to the parent BOM header that this line belongs to. Links the line item to the overall product BOM structure.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Each BOM line component in semiconductor manufacturing has an associated incoming quality spec governing its acceptance inspection (AQL, electrical test criteria). Component qualification and approved',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: BOM lines for semiconductor products include raw material components (silicon wafers, chemicals, substrates). Linking bom_line to inventory.raw_material enables material cost rollup, procurement plann',
    `supplier_id` BIGINT COMMENT 'Reference to the primary supplier or vendor for this component. Links to supplier master data for procurement and supply chain management.',
    `to_bom_id` BIGINT COMMENT 'FK to product.bom.bom_id — Classic header-line relationship. BOM lines are meaningless without their parent BOM header.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this BOM line is currently active and should be used in production planning and costing. Inactive lines are retained for historical reference but excluded from current operations.',
    `approved_substitute_part_numbers` STRING COMMENT 'Comma-separated list of approved alternate or substitute part numbers that can be used in place of the primary component. Supports supply chain flexibility and risk mitigation.',
    `assembly_process_code` STRING COMMENT 'Code identifying the assembly or packaging process used to integrate this component (e.g., wirebond, flip-chip, CoWoS, InFO). Links to process routing and manufacturing execution.',
    `bom_level` STRING COMMENT 'The hierarchical level of this component in the multi-level BOM structure. Level 0 is the finished product, level 1 is direct sub-assembly, level 2 is sub-component of level 1, and so on. Supports BOM explosion for cost rollup and supply chain analysis.',
    `component_description` STRING COMMENT 'Detailed textual description of the component, including technical specifications, material properties, and functional purpose within the assembly.',
    `component_part_number` STRING COMMENT 'The unique part number or SKU of the component material used in this BOM line. May reference die, package substrate, passive components, interposer, or other materials.',
    `component_type` STRING COMMENT 'Classification of the component by its functional role in the semiconductor assembly. Includes die (silicon chip), package substrate, passive components (resistors, capacitors), interposer, leadframe, wirebond, solder ball, underfill material, and mold compound. [ENUM-REF-CANDIDATE: die|package_substrate|passive|interposer|leadframe|wirebond|solder_ball|underfill|mold_compound — 9 candidates stripped; promote to reference product]',
    `conflict_minerals_status` STRING COMMENT 'Compliance status for conflict minerals (tin, tantalum, tungsten, gold) sourcing per Dodd-Frank Act Section 1502. Tracks whether component supply chain is free from conflict region sourcing.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost. Supports multi-currency costing and global supply chain operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical to product functionality, quality, or supply chain continuity. Used for risk assessment and inventory planning.',
    `ear_eccn_code` STRING COMMENT 'The ECCN code assigned under US Export Administration Regulations, classifying the component for export control purposes. Required for international trade compliance.',
    `effectivity_end_date` DATE COMMENT 'The date on which this BOM line becomes obsolete or is replaced. Null for currently active components. Supports phase-in/phase-out scenarios and Product Change Notification (PCN) tracking.',
    `effectivity_start_date` DATE COMMENT 'The date from which this BOM line becomes effective. Supports date-based BOM versioning and engineering change management.',
    `engineering_change_order_number` STRING COMMENT 'The ECO number that introduced or last modified this BOM line. Provides traceability to engineering change management processes.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether the component is subject to ITAR export controls for defense-related articles and services. Critical for aerospace and defense semiconductor applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was last updated. Supports change tracking and audit trail.',
    `line_number` STRING COMMENT 'Sequential line number within the parent BOM, used for ordering and referencing specific components in the assembly hierarchy.',
    `make_or_buy_indicator` STRING COMMENT 'Indicates whether the component is manufactured in-house (make), procured externally (buy), or transferred from another plant (transfer). Drives procurement and production planning logic.. Valid values are `make|buy|transfer`',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, assembly instructions, quality requirements, or special handling instructions for this BOM line.',
    `phantom_bom_flag` BOOLEAN COMMENT 'Indicates whether this is a phantom or transient sub-assembly that is not stocked or tracked as inventory. Phantom BOMs are exploded through during MRP but not manufactured as discrete items.',
    `procurement_lead_time_days` STRING COMMENT 'The typical lead time in days required to procure this component from suppliers. Used for material requirements planning (MRP) and supply chain risk analysis.',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'The quantity of this component required to produce one unit of the parent assembly. Supports fractional quantities for materials measured by weight or volume.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the component complies with EU REACH Regulation for chemical substance registration and safety. Required for European market access.',
    `reference_designator` STRING COMMENT 'The reference designator or location identifier for the component on the physical layout or assembly drawing (e.g., U1, C23, R45). Links BOM to physical design.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the component complies with EU RoHS Directive restricting hazardous substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE). Critical for regulatory compliance and market access.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'Expected scrap or yield loss percentage for this component during manufacturing. Used to calculate net material requirements accounting for process losses.',
    `single_source_flag` BOOLEAN COMMENT 'Indicates whether this component is available from only one supplier, representing a supply chain risk. Triggers dual-sourcing initiatives and risk mitigation strategies.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard unit cost of the component in the base currency. Used for BOM cost rollup, product costing, and margin analysis.',
    `unit_of_measure` STRING COMMENT 'The unit in which the component quantity is expressed. Common values include EA (each), KG (kilogram), G (gram), L (liter), ML (milliliter), M (meter), MM (millimeter), WAFER, DIE. [ENUM-REF-CANDIDATE: EA|KG|G|L|ML|M|MM|WAFER|DIE — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Line items within a product BOM, each representing a component or sub-assembly. Captures component part number, quantity per assembly, UoM, component type (die, package substrate, passive, interposer), approved substitutes, lead time, and compliance attributes (RoHS, REACH, conflict minerals). Supports multi-level BOM explosion for cost rollup and supply chain risk analysis.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` (
    `product_ip_core_id` BIGINT COMMENT 'Unique identifier for the IP core product record. Primary key for the IP core catalog.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: product_ip_core represents reusable IP blocks that belong to a catalog product; adding ic_catalog_id creates the required parent link.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: IP core licensing management records the vendor (supplier) that provides each IP core for royalty and support purposes.',
    `area_mm2` DECIMAL(18,2) COMMENT 'Physical silicon area occupied by the IP core in square millimeters. Part of PPA (Power, Performance, Area) metrics.',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of industry compliance certifications the IP core meets (e.g., ISO 26262 for automotive, DO-254 for aerospace, FIPS 140-2 for cryptography).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP core record was first created in the system.',
    `design_for_testability` BOOLEAN COMMENT 'Indicates whether the IP core includes DFT features such as scan chains, BIST (Built-In Self-Test), or ATPG support.',
    `documentation_package` STRING COMMENT 'Reference to the documentation package location or identifier (e.g., datasheet, integration guide, verification plan, user manual).',
    `eda_tool_compatibility` STRING COMMENT 'Comma-separated list of EDA tools that support this IP core (e.g., Cadence Virtuoso, Synopsys Design Compiler, Mentor Graphics).',
    `eol_date` DATE COMMENT 'Planned or actual end-of-life date for the IP core. After this date, the IP is no longer supported for new designs.',
    `errata_notes` STRING COMMENT 'Known issues, limitations, or workarounds for the IP core. Reference to errata document or summary of key issues.',
    `foundry_compatibility` STRING COMMENT 'Comma-separated list of foundries whose PDKs this IP core is compatible with (e.g., TSMC, Samsung, GlobalFoundries, Intel).',
    `gate_count` BIGINT COMMENT 'Approximate number of logic gates in the IP core. Used for complexity estimation and area prediction.',
    `integration_complexity` STRING COMMENT 'Estimated complexity level for integrating the IP core into an SoC or ASIC design: low (plug-and-play), medium (moderate customization), high (significant integration effort), very high (extensive customization required).. Valid values are `low|medium|high|very_high`',
    `interface_protocol` STRING COMMENT 'Standard interface protocol(s) supported by the IP core (e.g., AXI4, AHB, APB, PCIe Gen4, USB 3.2, DDR5). Comma-separated if multiple.',
    `ip_category` STRING COMMENT 'Functional classification of the IP core: processor cores, memory controllers, interface controllers (USB, PCIe, Ethernet), analog blocks, PHYs, security engines, DSP blocks, or hardware accelerators. [ENUM-REF-CANDIDATE: processor|memory_controller|interface|analog|phy|security|dsp|accelerator — 8 candidates stripped; promote to reference product]',
    `ip_core_code` STRING COMMENT 'Unique business identifier or SKU for the IP core used in PLM and EDA systems.',
    `ip_core_name` STRING COMMENT 'Human-readable name of the IP core block (e.g., ARM Cortex-A78, USB 3.2 PHY, DDR5 Memory Controller).',
    `ip_type` STRING COMMENT 'Classification of IP core implementation: hard IP (physical layout fixed), soft IP (RTL synthesizable), or firm IP (netlist with some physical constraints).. Valid values are `hard_ip|soft_ip|firm_ip`',
    `licensing_model` STRING COMMENT 'Business model for IP core licensing: royalty-free (one-time fee), per-unit royalty (fee per chip manufactured), NRE upfront (non-recurring engineering fee), subscription (annual license), or hybrid (combination).. Valid values are `royalty_free|per_unit_royalty|nre_upfront|subscription|hybrid`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the IP core: development (under design), verification (testing phase), production (available for integration), mature (stable and widely used), deprecated (not recommended for new designs), or EOL (end of life).. Valid values are `development|verification|production|mature|deprecated|eol`',
    `low_power_modes` STRING COMMENT 'Comma-separated list of low-power operating modes supported by the IP core (e.g., sleep, retention, power gating, clock gating).',
    `ltb_notification_date` DATE COMMENT 'Date when the last time buy notification was issued for the IP core, alerting customers to place final orders before discontinuation.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the IP core record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP core record was last modified.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'One-time non-recurring engineering cost in USD for licensing and integrating the IP core into a design.',
    `operating_frequency_mhz` DECIMAL(18,2) COMMENT 'Maximum operating frequency of the IP core in megahertz.',
    `operating_voltage_v` DECIMAL(18,2) COMMENT 'Nominal operating voltage for the IP core in volts (e.g., 0.8V, 1.2V).',
    `per_unit_royalty_usd` DECIMAL(18,2) COMMENT 'Royalty fee in USD charged per manufactured chip that incorporates this IP core. Null if licensing model is royalty-free.',
    `performance_metric` STRING COMMENT 'Key performance indicator for the IP core (e.g., clock frequency in MHz, throughput in Gbps, DMIPS for processors). Part of PPA metrics.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Typical power consumption of the IP core in milliwatts under nominal operating conditions. Part of PPA (Power, Performance, Area) metrics.',
    `process_node_compatibility` STRING COMMENT 'Comma-separated list of process nodes (technology nodes) that this IP core supports (e.g., 7nm, 5nm, 3nm). Indicates which fabrication processes the IP can be manufactured on.',
    `reference_designs` STRING COMMENT 'Comma-separated list of reference design identifiers or links that demonstrate the IP core integration and usage.',
    `release_date` DATE COMMENT 'Date when this version of the IP core was officially released for production use.',
    `rtl_language` STRING COMMENT 'Hardware description language used for the IP core RTL: Verilog, VHDL, SystemVerilog, Chisel, or not applicable (for hard IPs without RTL).. Valid values are `verilog|vhdl|systemverilog|chisel|not_applicable`',
    `security_features` STRING COMMENT 'Comma-separated list of security features provided by the IP core (e.g., AES encryption, secure boot, TrustZone, cryptographic accelerators).',
    `support_contact` STRING COMMENT 'Contact information for technical support and integration assistance for the IP core.',
    `temperature_range_c` STRING COMMENT 'Operating temperature range for the IP core in Celsius (e.g., -40 to 125). Format: min to max.',
    `to_node` BIGINT COMMENT 'FK to product.product_process_node.product_process_node_id — IP cores have process node compatibility. Must reference which nodes the IP is qualified for.',
    `vendor_name` STRING COMMENT 'Name of the IP core vendor or provider (e.g., ARM, Synopsys, Cadence, internal design team).',
    `verification_status` STRING COMMENT 'Current verification state of the IP core: not started, in progress (under verification), verified (passed all tests), or silicon proven (validated in actual silicon).. Valid values are `not_started|in_progress|verified|silicon_proven`',
    `version` STRING COMMENT 'Version identifier of the IP core (e.g., v2.1, r1p3). Tracks revisions and updates to the IP block.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the IP core record.',
    CONSTRAINT pk_product_ip_core PRIMARY KEY(`product_ip_core_id`)
) COMMENT 'Intellectual Property core catalog for reusable silicon IP blocks available for integration into SoC and ASIC designs, including hard IPs (PHYs, memory compilers, analog blocks) and soft IPs (processor cores, interface controllers, security engines). Captures IP name, version, process node compatibility, licensing model (royalty-free, per-unit royalty, NRE), PPA characteristics, verification status, and EDA tool compatibility.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` (
    `compliance_cert_id` BIGINT COMMENT 'Unique identifier for the product compliance certification record.',
    `ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Compliance certifications are obtained for specific products or SKUs. Required for export control screening and customer documentation.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Automotive and safety compliance certifications (AEC-Q100, ISO 26262, IEC 61508) reference the specific test program used during qualification. This link enables certification auditors to trace which ',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Compliance certifications (AEC-Q100, RoHS, REACH, IATF 16949) in semiconductor manufacturing are issued against specific quality specs that define the acceptance criteria and test methods. Regulatory ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: RoHS, REACH, and AEC-Q compliance certifications are issued at the SKU level in semiconductor supply chains — package type and variant determine substance content and qualification scope. Customers re',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Compliance certifications (RoHS, REACH, AEC-Q, ITAR) are tracked per supplier for export control and environmental compliance audits. Semiconductor supply chain compliance reporting requires linking c',
    `applicable_markets` STRING COMMENT 'Comma-separated list of geographic markets, regions, or countries where this compliance certification is recognized and valid (e.g., USA, EU, CHN, JPN, KOR). Uses ISO 3166-1 alpha-3 country codes.',
    `applicable_regions` STRING COMMENT 'Comma-separated list of regulatory regions or jurisdictions where this certification applies (e.g., North America, European Union, Asia-Pacific, EMEA).',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or assessor from the certification body who conducted the compliance assessment.',
    `automotive_grade_certified` BOOLEAN COMMENT 'Boolean flag indicating whether the product has achieved automotive-grade qualification certification (e.g., AEC-Q100 for ICs, AEC-Q101 for discrete semiconductors) for use in automotive applications.',
    `certification_body` STRING COMMENT 'Name of the accredited third-party organization or regulatory authority that issued the compliance certification (e.g., TÜV, UL, Intertek, SGS, Bureau Veritas).',
    `certification_number` STRING COMMENT 'Unique certificate number or identifier issued by the certification body for this compliance certification.',
    `certification_scope` STRING COMMENT 'Detailed description of the scope of the certification, including specific product variants, process nodes, package types, or application domains covered by this certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the compliance certification indicating whether it is active and valid, expired, pending approval, suspended, revoked, or under review.. Valid values are `active|expired|pending|suspended|revoked|under_review`',
    `certification_type` STRING COMMENT 'Type of regulatory or standards certification obtained. RoHS (Restriction of Hazardous Substances), REACH (Registration Evaluation Authorization and Restriction of Chemicals), TSCA (Toxic Substances Control Act), AEC-Q100/Q101 (Automotive Electronics Council qualification standards), ISO 26262 (Automotive Functional Safety), IEC 61508 (Functional Safety), UL (Underwriters Laboratories), CE (Conformité Européenne), FCC (Federal Communications Commission), ITAR (International Traffic in Arms Regulations), EAR (Export Administration Regulations). [ENUM-REF-CANDIDATE: RoHS|REACH|TSCA|AEC-Q100|AEC-Q101|ISO 26262|IEC 61508|UL|CE|FCC|ITAR|EAR — 12 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, exceptions, conditions, or special handling instructions related to this compliance certification.',
    `conflict_minerals_declaration` STRING COMMENT 'Declaration of conflict minerals (tin, tantalum, tungsten, gold - 3TG) sourcing and compliance status with Dodd-Frank Act Section 1502 and OECD Due Diligence Guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance certification record was first created in the system.',
    `customer_specific_requirement` STRING COMMENT 'Description of any customer-specific compliance requirements or certifications that this record addresses beyond standard regulatory requirements.',
    `ear_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether the product is subject to EAR (Export Administration Regulations) export controls administered by the Bureau of Industry and Security.',
    `effective_date` DATE COMMENT 'Date from which the compliance certification becomes valid and enforceable for the product.',
    `environmental_standard` STRING COMMENT 'Environmental management system standard under which this certification was issued (e.g., ISO 14001, ISO 50001 for energy management).',
    `expiry_date` DATE COMMENT 'Date on which the compliance certification expires and requires renewal or re-certification. Nullable for certifications without expiration.',
    `export_control_classification` STRING COMMENT 'Export control classification code or category assigned to the product under this certification (e.g., ECCN - Export Control Classification Number under EAR, or USML category under ITAR).',
    `functional_safety_level` STRING COMMENT 'Functional safety integrity level achieved by the product under ISO 26262 (ASIL A/B/C/D for automotive) or IEC 61508 (SIL 1/2/3/4 for industrial) standards. ASIL (Automotive Safety Integrity Level), SIL (Safety Integrity Level). [ENUM-REF-CANDIDATE: ASIL_A|ASIL_B|ASIL_C|ASIL_D|SIL_1|SIL_2|SIL_3|SIL_4|not_applicable — 9 candidates stripped; promote to reference product]',
    `hazardous_substance_declaration` STRING COMMENT 'Detailed declaration of hazardous substances present in the product, including substance names, CAS (Chemical Abstracts Service) numbers, concentration levels, and compliance status with RoHS, REACH, and TSCA regulations.',
    `internal_owner` STRING COMMENT 'Name or employee identifier of the internal compliance manager or product quality engineer responsible for maintaining this certification.',
    `issue_date` DATE COMMENT 'Date on which the compliance certification was officially issued by the certification body.',
    `itar_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether the product is subject to ITAR (International Traffic in Arms Regulations) export controls and requires special handling for international shipments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance certification record was last modified or updated in the system.',
    `pcn_reference_number` STRING COMMENT 'Reference number of the Product Change Notification (PCN) that triggered this certification or recertification, if applicable.',
    `quality_management_standard` STRING COMMENT 'Quality management system standard under which this certification was issued (e.g., ISO 9001, IATF 16949, AS9100, ISO 13485).',
    `reach_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the product is compliant with REACH Regulation EC 1907/2006 governing the registration, evaluation, authorization, and restriction of chemicals in the European Union.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification cycles. Null if recertification is not required or is event-driven rather than time-based.',
    `recertification_required` BOOLEAN COMMENT 'Boolean flag indicating whether this certification requires periodic recertification or renewal (True) or is a one-time certification (False).',
    `recertification_trigger_events` STRING COMMENT 'Comma-separated list of business events that trigger mandatory recertification (e.g., design change, process node migration, package change, supplier change, PCN issuance, material substitution).',
    `restricted_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes to which export or sale of this product is restricted or prohibited under applicable export control regulations.',
    `rohs_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the product is compliant with RoHS (Restriction of Hazardous Substances) Directive 2011/65/EU restricting the use of specific hazardous materials in electrical and electronic equipment.',
    `supporting_documentation_url` STRING COMMENT 'URL or file path to the repository location containing supporting documentation, test reports, certificates, and compliance declarations for this certification.',
    `test_laboratory` STRING COMMENT 'Name of the accredited testing laboratory that performed the compliance testing and analysis supporting this certification.',
    `test_report_number` STRING COMMENT 'Reference number of the official test report or assessment document that supports this compliance certification.',
    CONSTRAINT pk_compliance_cert PRIMARY KEY(`compliance_cert_id`)
) COMMENT 'Product compliance certification records tracking regulatory and standards certifications obtained for each product or SKU, including RoHS, REACH, TSCA, AEC-Q100/Q101, ISO 26262, IEC 61508, UL, CE, FCC, and ITAR classification. Captures certification body, certificate number, issue date, expiry date, applicable markets/regions, and re-certification trigger events. Supports export control screening and customer compliance documentation requests.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_ic_family_id` FOREIGN KEY (`ic_family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_replacement_sku_id` FOREIGN KEY (`replacement_sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_product_ip_core_id` FOREIGN KEY (`product_ip_core_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`product_ip_core`(`product_ip_core_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_parent_line_bom_line_id` FOREIGN KEY (`parent_line_bom_line_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_to_bom_id` FOREIGN KEY (`to_bom_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`bom`(`bom_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_semiconductors_v1`.`product`.`sku`(`sku_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit (IC) Catalog Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog To Family');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ic_family_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `aec_qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Automotive Electronics Council (AEC) Qualification Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `aec_qualification_level` SET TAGS ('dbx_value_regex' = 'AEC-Q100|AEC-Q101|AEC-Q102|AEC-Q200|NA');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `automotive_qualified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'IC Design Methodology Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `design_type` SET TAGS ('dbx_value_regex' = 'Full_Custom|Semi_Custom|Standard_Cell|Gate_Array|Structured_ASIC|Platform_Based');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size in Square Millimeters');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `first_silicon_date` SET TAGS ('dbx_business_glossary_term' = 'First Silicon Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}.[0-9]{2}.[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `lead_free_compliant` SET TAGS ('dbx_business_glossary_term' = 'Lead-Free RoHS Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `npi_phase` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Phase');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `operating_frequency_max_mhz` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Frequency in Megahertz');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `operating_voltage_max_v` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Voltage in Volts');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `operating_voltage_min_v` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Voltage in Volts');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Package Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `power_max_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Power Consumption in Milliwatts');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `power_typical_mw` SET TAGS ('dbx_business_glossary_term' = 'Typical Power Consumption in Milliwatts');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Marketing Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `production_release_date` SET TAGS ('dbx_business_glossary_term' = 'Production Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Regulation Compliance');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Register Transfer Level (RTL) Language');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `rtl_language` SET TAGS ('dbx_value_regex' = 'Verilog|VHDL|SystemVerilog|Chisel|NA');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'Commercial|Industrial|Automotive|Military|Extended');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`ic_catalog` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit (IC) Catalog Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `replacement_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `eccn_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `halogen_free` SET TAGS ('dbx_business_glossary_term' = 'Halogen Free');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}.[0-9]{2}.[0-9]{2}.[0-9]{2}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Market Introduction Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Weeks)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'npi|active|mature|declining|eol_announced|discontinued');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price (United States Dollar)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `pcn_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `qualification_level` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive_aec_q100|automotive_aec_q101|military_mil_std_883|space');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `shippable_flag` SET TAGS ('dbx_business_glossary_term' = 'Shippable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (United States Dollar)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `standard_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Standard Pack Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `temperature_range` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `unit_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight (Grams)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`sku` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_business_glossary_term' = 'Voltage Variant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Family Identifier (ID)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `active_pcn_count` SET TAGS ('dbx_business_glossary_term' = 'Active Product Change Notification (PCN) Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `application_domain` SET TAGS ('dbx_business_glossary_term' = 'Application Domain');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_description` SET TAGS ('dbx_business_glossary_term' = 'Product Family Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `design_center_location` SET TAGS ('dbx_business_glossary_term' = 'Design Center Location');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `dfm_score` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Score');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `dft_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Coverage Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `eda_tool_suite` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Suite');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Product Family Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|Immersion|Dry');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `ltb_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Product Family Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `npi_start_date` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (Nanometers)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `process_technology` SET TAGS ('dbx_value_regex' = 'FinFET|GAA|Planar|FD_SOI');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `product_line_manager` SET TAGS ('dbx_business_glossary_term' = 'Product Line Manager');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Target Power Consumption (Milliwatts)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `typical_die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Typical Die Size (Square Millimeters)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`family` ALTER COLUMN `volume_production_date` SET TAGS ('dbx_business_glossary_term' = 'Volume Production Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` SET TAGS ('dbx_subdomain' = 'technical_specifications');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `automotive_grade` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `automotive_grade` SET TAGS ('dbx_value_regex' = 'none|aec_q100_grade_0|aec_q100_grade_1|aec_q100_grade_2|aec_q100_grade_3');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `characterization_date` SET TAGS ('dbx_business_glossary_term' = 'Characterization Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `die_area_achieved_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area Achieved (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `die_area_target_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area Target (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `dynamic_power_achieved_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Achieved (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `dynamic_power_target_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Target (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `endurance_cycles` SET TAGS ('dbx_business_glossary_term' = 'Endurance Cycles');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `esd_protection_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Electrostatic Discharge (ESD) Protection Level (kV)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `functional_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Rating');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `interface_protocols` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocols');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `io_count` SET TAGS ('dbx_business_glossary_term' = 'Input/Output (I/O) Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `leakage_power_achieved_mw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Achieved (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `leakage_power_target_mw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Target (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `max_frequency_achieved_mhz` SET TAGS ('dbx_business_glossary_term' = 'Maximum Frequency Achieved (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `max_frequency_target_mhz` SET TAGS ('dbx_business_glossary_term' = 'Maximum Frequency Target (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `memory_configuration` SET TAGS ('dbx_business_glossary_term' = 'Memory Configuration');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_condition_corner` SET TAGS ('dbx_business_glossary_term' = 'Operating Condition Corner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Maximum (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Minimum (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_voltage_max_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Maximum (V)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_voltage_min_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Minimum (V)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `operating_voltage_nominal_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Nominal (V)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|obsolete');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet|nanowire');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_spec` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` SET TAGS ('dbx_subdomain' = 'assembly_structure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `to_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'To Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bill of Materials (BOM) Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'engineering|manufacturing|service|planning|as_designed|as_built');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `conflict_minerals_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `critical_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Explosion Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `external_bom_reference` SET TAGS ('dbx_business_glossary_term' = 'External Bill of Materials (BOM) ID');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `ltb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Revision');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_component_count` SET TAGS ('dbx_business_glossary_term' = 'Total Component Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'production|costing|engineering|maintenance|sales');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'assembly_structure');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Component Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Component Product Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `parent_line_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent BOM Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `to_bom_id` SET TAGS ('dbx_business_glossary_term' = 'To Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `approved_substitute_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Approved Substitute Part Numbers');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `assembly_process_code` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'BOM Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `conflict_minerals_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `conflict_minerals_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `effectivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity End Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `effectivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Make or Buy Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_value_regex' = 'make|buy|transfer');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `phantom_bom_flag` SET TAGS ('dbx_business_glossary_term' = 'Phantom BOM Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `reference_designator` SET TAGS ('dbx_business_glossary_term' = 'Reference Designator');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` SET TAGS ('dbx_subdomain' = 'technical_specifications');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Product Intellectual Property (IP) Core Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Silicon Area in Square Millimeters (mm²)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `design_for_testability` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Support');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `documentation_package` SET TAGS ('dbx_business_glossary_term' = 'Documentation Package');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `eda_tool_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `errata_notes` SET TAGS ('dbx_business_glossary_term' = 'Errata Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `foundry_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Foundry Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `integration_complexity` SET TAGS ('dbx_business_glossary_term' = 'Integration Complexity');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `integration_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `interface_protocol` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocol');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_category` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Functional Category');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_core_code` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Code');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_core_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_value_regex' = 'hard_ip|soft_ip|firm_ip');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `licensing_model` SET TAGS ('dbx_business_glossary_term' = 'Licensing Model');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `licensing_model` SET TAGS ('dbx_value_regex' = 'royalty_free|per_unit_royalty|nre_upfront|subscription|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'development|verification|production|mature|deprecated|eol');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `low_power_modes` SET TAGS ('dbx_business_glossary_term' = 'Low Power Modes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `ltb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Notification Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost in United States Dollars (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `operating_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency in Megahertz (MHz)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `operating_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage in Volts (V)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `per_unit_royalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Per-Unit Royalty in United States Dollars (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `per_unit_royalty_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption in Milliwatts (mW)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Process Node Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `reference_designs` SET TAGS ('dbx_business_glossary_term' = 'Reference Designs');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Register Transfer Level (RTL) Language');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_value_regex' = 'verilog|vhdl|systemverilog|chisel|not_applicable');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_business_glossary_term' = 'Support Contact');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range in Celsius (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `to_node` SET TAGS ('dbx_business_glossary_term' = 'Ip Core To Node');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|silicon_proven');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Version');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`product_ip_core` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification ID');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regions');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `automotive_grade_certified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade Certified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|suspended|revoked|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `conflict_minerals_declaration` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Declaration');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `customer_specific_requirement` SET TAGS ('dbx_business_glossary_term' = 'Customer-Specific Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `customer_specific_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR (Export Administration Regulations) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `environmental_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Management Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `functional_safety_level` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Level');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `hazardous_substance_declaration` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Declaration');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `internal_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR (International Traffic in Arms Regulations) Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `pcn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'PCN (Product Change Notification) Reference Number');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `quality_management_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Management Standard');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH (Registration Evaluation Authorization and Restriction of Chemicals) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `recertification_trigger_events` SET TAGS ('dbx_business_glossary_term' = 'Recertification Trigger Events');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `restricted_countries` SET TAGS ('dbx_business_glossary_term' = 'Restricted Countries');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `restricted_countries` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS (Restriction of Hazardous Substances) Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation URL');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `test_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Test Laboratory');
ALTER TABLE `vibe_semiconductors_v1`.`product`.`compliance_cert` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
