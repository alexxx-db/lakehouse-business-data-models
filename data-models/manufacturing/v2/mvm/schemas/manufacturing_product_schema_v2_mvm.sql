-- Schema for Domain: product | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-03 07:50:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`product` COMMENT 'Product catalog and offering management domain serving as the SSOT for all manufactured products, automation systems, electrification solutions, and smart infrastructure components. Manages SKU master data, product families, configurations, pricing structures, product lifecycle stages from NPI to end-of-life, and product portfolio management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`sku_master` (
    `sku_master_id` BIGINT COMMENT 'Unique identifier for the SKU master record. Primary key for the SKU master data product.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Manufacturing SKUs (sellable/stockable items) are derived from engineering component masters. Critical for: ECO impact analysis on saleable products, cost rollup from engineering BOM to product cost, ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: sku_master.product_family_code is a denormalized string reference to the product family. Normalizing this to a FK (family_id → product.family.family_id) establishes the authoritative parent-child rela',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and consumption: A (high value, tight control), B (moderate value), C (low value, relaxed control). Used for inventory policy and cycle counting frequency.. Valid values are `A|B|C`',
    `base_uom` STRING COMMENT 'The fundamental unit of measure for inventory tracking and stock keeping. All other UoM conversions are calculated relative to this base unit. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|M2|FT2|M3|FT3|SET|KIT — 14 candidates stripped; promote to reference product]',
    `commercial_description` STRING COMMENT 'Marketing-optimized product description for sales and customer communication. Multi-language support maintained in PLM system.',
    `cost_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the standard cost. Typically the companys base or functional currency for financial reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the product is manufactured or substantially transformed. Required for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was first created in the system. Audit trail for data governance and compliance.',
    `dimension_uom` STRING COMMENT 'Unit of measure for length, width, and height dimensions. Standardized for consistent warehouse and logistics operations.. Valid values are `MM|CM|M|IN|FT`',
    `discontinuation_date` DATE COMMENT 'Date when the SKU is discontinued and no longer available for new orders. Supports end-of-life planning and inventory liquidation strategies.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned under the U.S. Export Administration Regulations (EAR). Determines export licensing requirements and trade compliance obligations.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `effective_date` DATE COMMENT 'Date when the SKU becomes active and available for transactions. Used for new product introductions and lifecycle transitions.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the product including packaging, measured in the weight UoM. Used for logistics planning, freight calculation, and warehouse capacity management.',
    `hazard_class` STRING COMMENT 'UN hazard classification code indicating the primary hazard type (e.g., 3 for flammable liquids, 8 for corrosive substances). Used for transportation and storage compliance.. Valid values are `^[1-9](.[1-6])?$`',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the SKU is classified as a hazardous material requiring special handling, storage, and transportation procedures per regulatory requirements.',
    `height` DECIMAL(18,2) COMMENT 'Height dimension of the product or its packaging, measured in the dimension UoM. Used for warehouse slotting and transportation planning.',
    `hts_code` STRING COMMENT 'Harmonized Tariff Schedule classification code for customs and international trade. Used to determine import duties, tariffs, and trade statistics reporting.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SKU master record. Used for change tracking and data synchronization across systems.',
    `length` DECIMAL(18,2) COMMENT 'Length dimension of the product or its packaging, measured in the dimension UoM. Used for warehouse slotting and transportation planning.',
    `lifecycle_status` STRING COMMENT 'Current stage in the product lifecycle from New Product Introduction (NPI) through end-of-life. Governs availability for new orders, production scheduling, and inventory management decisions.. Valid values are `npi|active|mature|phase_out|discontinued|obsolete`',
    `long_description` STRING COMMENT 'Detailed product description for technical documentation, sales catalogs, and customer-facing materials. Includes full technical specifications and feature details.',
    `lot_control_required` BOOLEAN COMMENT 'Flag indicating whether the SKU requires lot or batch number tracking for traceability, quality control, and recall management purposes.',
    `make_or_buy_code` STRING COMMENT 'Procurement strategy indicator: make (manufactured in-house), buy (purchased from suppliers), or both (dual-sourced). Drives MRP planning logic and sourcing decisions.. Valid values are `make|buy|both`',
    `material_number` STRING COMMENT 'SAP material number from S/4HANA MM module. Legacy identifier maintained for ERP integration and cross-system traceability.. Valid values are `^[0-9]{10,18}$`',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the product excluding packaging, measured in the weight UoM. Used for material content reporting and customs declarations.',
    `packing_group` STRING COMMENT 'UN packing group classification indicating the degree of danger: I (high danger), II (medium danger), III (low danger). Determines packaging and handling requirements.. Valid values are `I|II|III`',
    `plm_item_code` STRING COMMENT 'Unique identifier from Siemens Teamcenter PLM system. Links the SKU master record to engineering design data, CAD models, BOMs, and technical documentation.',
    `product_type` STRING COMMENT 'Classification of the SKU by manufacturing and inventory treatment. Determines BOM structure, production planning, and inventory valuation methods. [ENUM-REF-CANDIDATE: finished_good|semi_finished|raw_material|component|assembly|service_part|consumable|tool — 8 candidates stripped; promote to reference product]',
    `production_to_base_conversion` DECIMAL(18,2) COMMENT 'Conversion factor to translate production UoM quantities to base UoM. Used for MRP calculations and production planning.',
    `production_uom` STRING COMMENT 'Unit of measure used in manufacturing execution and shop floor control. Aligns with MES work order quantities and production reporting. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|M2|FT2|M3|FT3|SET|KIT|BATCH|LOT — 16 candidates stripped; promote to reference product]',
    `revision_level` STRING COMMENT 'Current engineering revision or version of the product design. Managed through ECO/ECN processes in PLM. Critical for configuration management and change control.. Valid values are `^[A-Z0-9]{1,10}$`',
    `sales_to_base_conversion` DECIMAL(18,2) COMMENT 'Conversion factor to translate sales UoM quantities to base UoM. Example: if sales UoM is BOX and base UoM is EA, and one box contains 12 pieces, the factor is 12.000000.',
    `sales_uom` STRING COMMENT 'Unit of measure used for customer orders and sales transactions. May differ from base UoM to accommodate customer ordering preferences. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|M2|FT2|M3|FT3|SET|KIT|BOX|PALLET — 16 candidates stripped; promote to reference product]',
    `sds_reference` STRING COMMENT 'Reference identifier or document number for the Safety Data Sheet (formerly MSDS) containing detailed hazard information, handling instructions, and emergency procedures.',
    `serial_control_required` BOOLEAN COMMENT 'Flag indicating whether the SKU requires individual serial number tracking for warranty management, asset tracking, and field service support.',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains usable or saleable from the date of manufacture or receipt. Used for inventory rotation, expiration management, and quality control.',
    `short_description` STRING COMMENT 'Concise product description for internal operational use, typically 40 characters or less. Used in MES shop floor displays and warehouse picking lists.',
    `sku_code` STRING COMMENT 'The authoritative, externally-known unique identifier for the SKU. Used across all systems including SAP S/4HANA MM, Siemens Teamcenter PLM, and Siemens Opcenter MES. This is the business key for the product.. Valid values are `^[A-Z0-9]{8,20}$`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost for inventory valuation and cost accounting. Maintained in the base currency and updated periodically through cost roll-up processes. Note: pricing structures are owned by the sales domain.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials as defined by the UN Recommendations on the Transport of Dangerous Goods. Required for shipping documentation and regulatory compliance.. Valid values are `^UN[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Volumetric measurement of the product or its packaging, measured in the volume UoM. Used for warehouse capacity planning and freight optimization.',
    `volume_uom` STRING COMMENT 'Unit of measure for volume. Used in logistics and warehouse management calculations.. Valid values are `L|ML|M3|GAL|FT3|IN3`',
    `weight_uom` STRING COMMENT 'Unit of measure for gross and net weight values. Standardized across the enterprise for consistent logistics and shipping calculations.. Valid values are `KG|LB|G|OZ|MT|TON`',
    `width` DECIMAL(18,2) COMMENT 'Width dimension of the product or its packaging, measured in the dimension UoM. Used for warehouse slotting and transportation planning.',
    CONSTRAINT pk_sku_master PRIMARY KEY(`sku_master_id`)
) COMMENT 'Single source of truth for all Stock Keeping Units (SKUs) across the manufactured product portfolio. Captures the authoritative SKU identifier, description, unit of measure, weight, dimensions, hazardous material classification (UN number, hazard class, packing group, SDS reference), export control classification (ECCN), and lifecycle status. Serves as the foundational master record referenced by BOM, MES, ERP (SAP S/4HANA MM), and PLM (Siemens Teamcenter) systems. Every manufactured item, automation system component, electrification solution, and smart infrastructure element is registered here before it can be produced, sold, or shipped. Includes base/sales/production UoM with conversion factors and multi-language commercial descriptions. Note: product pricing structures are owned by the sales domain; this domain owns product identity, structure, and commercial catalog definition only.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Primary key for family',
    `parent_family_id` BIGINT COMMENT 'Reference to the parent product family in the multi-level hierarchy. Enables nested family structures (e.g., Industrial Automation > Drives > Low Voltage Drives). Null for top-level families.',
    `business_unit` STRING COMMENT 'Name or code of the business unit or division responsible for this product family. Defines ownership for P&L accountability, product management, and strategic roadmap decisions.',
    `certification_requirements` STRING COMMENT 'Comma-separated list of required certifications and compliance standards for products in this family (e.g., UL, CE, IEC 61131, ISO 9001, ATEX, IECEx). Defines regulatory and safety compliance scope.',
    `family_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the product family. Used in SAP S/4HANA SD for catalog navigation and PLM (Siemens Teamcenter) for product classification. Serves as the business identifier for cross-system integration.. Valid values are `^[A-Z0-9]{3,20}$`',
    `competitive_positioning` STRING COMMENT 'Strategic positioning statement describing how this product family competes in the market (e.g., technology leader, cost leader, niche specialist). Used for marketing strategy and sales enablement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for standard cost and list price (e.g., USD, EUR, CNY). Defines the monetary unit for financial attributes.. Valid values are `^[A-Z]{3}$`',
    `cybersecurity_classification` STRING COMMENT 'Cybersecurity risk classification for products in this family based on connectivity, data handling, and criticality to customer operations. Drives security testing, vulnerability management, and compliance with IEC 62443 and NIST Cybersecurity Framework.. Valid values are `critical|high|medium|low|not_applicable`',
    `data_source_system` STRING COMMENT 'Name or code of the source system from which this product family record originated (e.g., SAP S/4HANA, Siemens Teamcenter PLM, Informatica MDM). Used for data lineage and integration troubleshooting.',
    `family_description` STRING COMMENT 'Detailed business description of the product family, including its purpose, key characteristics, typical applications, and differentiating features. Used for marketing collateral, sales enablement, and product documentation.',
    `distribution_channel` STRING COMMENT 'Primary distribution channel for products in this family (e.g., direct sales, distributor, OEM, e-commerce). Influences pricing, logistics, and customer engagement strategy.',
    `effective_end_date` DATE COMMENT 'Date when this product family was or will be discontinued or retired from the catalog. Null for active families. Used for phase-out planning and end-of-life management.',
    `effective_start_date` DATE COMMENT 'Date when this product family became active and available for sale or production. Marks the beginning of the familys lifecycle in the product catalog.',
    `environmental_compliance` STRING COMMENT 'Environmental and sustainability compliance standards applicable to this family (e.g., RoHS, REACH, WEEE, ISO 14001, Energy Star). Ensures adherence to environmental regulations and corporate sustainability commitments.',
    `erp_material_group` STRING COMMENT 'Material group code assigned in SAP S/4HANA (MATKL). Used for procurement, inventory management, and financial reporting. Links to purchasing conditions and valuation classes.',
    `family_type` STRING COMMENT 'Classification of the product family by offering type. Distinguishes between finished goods (end products), components (parts), assemblies (sub-systems), services (maintenance/support), software (embedded/standalone), systems (integrated solutions), and spare parts. [ENUM-REF-CANDIDATE: finished_goods|components|assemblies|services|software|systems|spare_parts — 7 candidates stripped; promote to reference product]',
    `geographic_availability` STRING COMMENT 'Comma-separated list of geographic regions or countries where products in this family are available for sale (e.g., EMEA, APAC, Americas, USA, DEU, CHN). Reflects regulatory approvals, distribution network, and go-to-market scope.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Indicates whether products in this family contain or are classified as hazardous materials requiring special handling, storage, or transportation (e.g., batteries, chemicals, flammable substances). Drives compliance with OSHA, EPA, and transportation regulations.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the product family hierarchy tree. Level 1 represents top-level families (e.g., Automation Systems). Level 2 represents sub-families (e.g., Drives). Level 3+ represents further nested classifications. Used for catalog navigation depth and reporting rollups.',
    `innovation_priority` STRING COMMENT 'Priority level for innovation and new product development within this family. High priority families receive accelerated R&D investment and technology roadmap focus.. Valid values are `high|medium|low`',
    `iot_enabled` BOOLEAN COMMENT 'Indicates whether products in this family have embedded IoT (Internet of Things) or IIoT (Industrial Internet of Things) connectivity for remote monitoring, predictive maintenance, or data analytics. Supports digital services and smart infrastructure offerings.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person or system that last modified this product family record. Supports audit trail and accountability for master data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was last updated. Used for change tracking, data synchronization, and audit compliance.',
    `lead_time_days` STRING COMMENT 'Standard manufacturing or procurement lead time in days for products in this family. Used for order promising, production planning (MRP), and inventory policy setting.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the product family. Active families are available for sale and production. Discontinued families are no longer offered. Phase-out families are being retired. NPI (New Product Introduction) families are in launch phase. End-of-life families support existing installations only. Under-development families are pre-launch.. Valid values are `active|discontinued|phase_out|new_product_introduction|end_of_life|under_development`',
    `list_price` DECIMAL(18,2) COMMENT 'Representative list price or price range midpoint for products in this family. Used for catalog display, quotation guidance, and revenue forecasting. Actual SKU prices may vary based on configuration and customer agreements.',
    `manufacturing_strategy` DECIMAL(18,2) COMMENT 'Primary manufacturing strategy for products in this family. Make-to-stock (MTS) builds to forecast. Make-to-order (MTO) builds to customer orders. Engineer-to-order (ETO) customizes designs. Configure-to-order (CTO) assembles from standard modules. Assemble-to-order (ATO) final assembly from components.',
    `market_segment` STRING COMMENT 'Primary market segment or vertical industry that this product family serves. Aligns with go-to-market strategy and sales organization structure. Used for revenue reporting, market analysis, and strategic planning. [ENUM-REF-CANDIDATE: industrial_automation|building_automation|energy_management|transportation|process_industries|discrete_manufacturing|infrastructure|oem_solutions — 8 candidates stripped; promote to reference product]',
    `mean_time_between_failures` DECIMAL(18,2) COMMENT 'Average Mean Time Between Failures (MTBF) in hours for products in this family. Key reliability metric used for maintenance planning, service level agreements, and product quality benchmarking.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Average Mean Time To Repair (MTTR) in hours for products in this family. Indicates serviceability and downtime impact. Used for maintenance planning and SLA (Service Level Agreement) definition.',
    `family_name` STRING COMMENT 'Human-readable name of the product family (e.g., Industrial Drives, Low-Voltage Switchgear, Smart Building Controllers, Programmable Logic Controllers). Primary display label for catalog navigation and reporting.',
    `plm_category` STRING COMMENT 'Classification code or category assigned in the PLM system (Siemens Teamcenter). Used for document management, BOM (Bill of Materials) structure, and engineering change control (ECO/ECN).',
    `procurement_type` STRING COMMENT 'Indicates whether products in this family are manufactured in-house, purchased from suppliers, or a combination of both. Drives sourcing strategy and supply chain planning.. Valid values are `manufactured|purchased|both`',
    `product_line_owner` STRING COMMENT 'Name or identifier of the product manager or product line owner responsible for this family. Accountable for portfolio strategy, pricing, and lifecycle management.',
    `product_portfolio_strategy` DECIMAL(18,2) COMMENT 'Strategic classification of the product family in the corporate portfolio. Invest families receive R&D funding and growth initiatives. Maintain families sustain current market position. Harvest families maximize cash flow with minimal investment. Divest families are candidates for discontinuation or sale.',
    `record_status` STRING COMMENT 'Administrative status of this master data record. Active records are current and in use. Inactive records are deprecated but retained for historical reference. Pending approval records await governance review. Archived records are retained for compliance but not operational use.. Valid values are `active|inactive|pending_approval|archived`',
    `sales_organization` STRING COMMENT 'Primary sales organization code responsible for selling products in this family. Defines sales territory, pricing authority, and revenue attribution in SAP S/4HANA SD.',
    `service_level_tier` STRING COMMENT 'Default service level tier for products in this family. Defines response time commitments, spare parts availability, and support escalation paths. Influences service pricing and customer expectations.. Valid values are `standard|premium|critical|basic`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Average standard cost per unit for products in this family, used for financial planning and margin analysis. Expressed in the companys base currency. Aggregated from individual SKU costs.',
    `target_customer_segment` STRING COMMENT 'Primary customer segment or persona targeted by this product family (e.g., large industrial OEMs, mid-size system integrators, building owners, utilities). Guides marketing campaigns and sales territory planning.',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for products in this family, expressed as a percentage (e.g., 35.50 for 35.5%). Used for pricing strategy, product mix optimization, and profitability analysis.',
    `technology_platform` STRING COMMENT 'Underlying technology platform or architecture shared by products in this family (e.g., SIMATIC Platform, SINAMICS Drive Platform, Desigo Building Automation Platform). Enables commonality analysis and platform lifecycle planning.',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months offered for products in this family. Defines the baseline service commitment and influences pricing and service revenue forecasting.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Defines the hierarchical grouping of related manufactured products into product families and sub-families (e.g., Industrial Drives, Low-Voltage Switchgear, Smart Building Controllers). Manages the product portfolio taxonomy used for planning, pricing, and go-to-market segmentation. Supports multi-level hierarchy with parent-child relationships, market segment alignment, and product line ownership. Referenced by PLM (Siemens Teamcenter) and SAP S/4HANA SD for catalog navigation and revenue reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` (
    `catalog_entry_id` BIGINT COMMENT 'Primary key for catalog_entry',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: catalog_entry has a configurable_flag: BOOLEAN indicating that some catalog entries represent configurable products. For these entries, the FK to configuration captures the base configuration definiti',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: catalog_entry.product_family_code is a denormalized string reference to the product family. Adding family_id FK normalizes this relationship so catalog entries are directly linked to their product fam',
    `replacement_catalog_catalog_entry_id` BIGINT COMMENT 'Reference to the catalog entry that replaces this product when it is discontinued or superseded. Supports product transition management and customer migration.',
    `sku_master_id` BIGINT COMMENT 'Reference to the engineering SKU master data. Links the commercial catalog entry to the underlying product master record managed in SAP S/4HANA MM and Siemens Teamcenter PLM.',
    `catalog_description` STRING COMMENT 'Detailed commercial description of the product offering including key features, benefits, and applications. Used in sales literature and customer communications.',
    `catalog_image_url` STRING COMMENT 'URL reference to the primary product image for this catalog entry. Used in online catalogs, e-commerce platforms, and sales presentations.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `catalog_name` STRING COMMENT 'The commercial product name as it appears in sales catalogs, quotations, and customer-facing documentation. May differ from the engineering product name.',
    `catalog_number` STRING COMMENT 'The externally-facing commercial catalog identifier used in sales orders, quotations, and customer communications. This is the orderable product code visible to customers and distributors.. Valid values are `^[A-Z0-9]{6,20}$`',
    `catalog_status` STRING COMMENT 'Current lifecycle status of the catalog entry indicating whether the product is available for sale, pending launch, or being phased out.. Valid values are `active|inactive|pending|discontinued|phase_out`',
    `catalog_version` STRING COMMENT 'Version identifier for the product catalog publication (e.g., 2024.1, 2024.2). Supports catalog change management and historical tracking.. Valid values are `^[0-9]{4}.[0-9]{1,2}$`',
    `certification_marks` STRING COMMENT 'Comma-separated list of certification marks and compliance logos applicable to this catalog entry (e.g., UL, CE, CSA, IEC). Used for regulatory compliance and customer requirements.',
    `configurable_flag` BOOLEAN COMMENT 'Indicates whether this catalog entry supports customer-specific configuration or customization (e.g., programmable controllers, modular systems with selectable options).',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where this product is manufactured or substantially transformed. Required for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this catalog entry record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the list price (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `distribution_chain` STRING COMMENT 'The distribution chain identifier combining sales organization, distribution channel, and division. Used for SAP SD integration and order processing.',
    `effective_end_date` DATE COMMENT 'The date after which this catalog entry is no longer available for new orders. Null for products with indefinite availability. Used for planned product discontinuations.',
    `effective_start_date` DATE COMMENT 'The date from which this catalog entry becomes available for sale and order entry. Supports time-based product launches and regional rollouts.',
    `environmental_compliance` STRING COMMENT 'Environmental compliance certifications and declarations for this catalog entry (e.g., RoHS, REACH, WEEE). Required for sales in regulated markets.',
    `export_control_classification` STRING COMMENT 'Export control classification for this catalog entry under applicable trade regulations (e.g., US ECCN, EU dual-use codes). Required for international sales compliance.',
    `harmonized_tariff_code` STRING COMMENT 'International harmonized commodity code for customs and tariff classification. Used for import/export documentation and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this catalog entry contains or is classified as hazardous material requiring special handling, shipping, and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this catalog entry record was last modified. Used for change tracking and data synchronization.',
    `last_price_update_date` TIMESTAMP COMMENT 'The date when the list price for this catalog entry was last updated. Used for price change tracking and audit trails.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the product lifecycle from New Product Introduction (NPI) through end-of-life. Used for portfolio management and strategic planning.. Valid values are `npi|growth|maturity|decline|end_of_life`',
    `list_price` DECIMAL(18,2) COMMENT 'The standard list price for this catalog entry in the base currency. Actual transaction prices may vary based on customer agreements, volume discounts, and promotions.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered for this catalog entry. Used to enforce business rules for small-volume orders and manufacturing lot sizes.',
    `modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this catalog entry record. Used for audit trails and accountability.',
    `oem_offering_flag` BOOLEAN COMMENT 'Indicates whether this catalog entry is an OEM product sold to other manufacturers for integration into their systems, as opposed to a standard commercial offering.',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this catalog entry can be directly ordered by customers. Not all SKUs are orderable; some are components or service parts only.',
    `price_unit_of_measure` DECIMAL(18,2) COMMENT 'The unit of measure for pricing (each, piece, set, kilogram, meter, square meter, cubic meter, liter, hour). Defines the quantity basis for the list price. [ENUM-REF-CANDIDATE: EA|PC|SET|KG|M|M2|M3|L|HR — 9 candidates stripped; promote to reference product]',
    `product_category` STRING COMMENT 'High-level product category classification aligning with the business strategic product portfolio segments. [ENUM-REF-CANDIDATE: automation_systems|electrification_solutions|smart_infrastructure|industrial_controls|power_distribution|building_automation|process_automation — 7 candidates stripped; promote to reference product]',
    `regional_availability` STRING COMMENT 'Geographic regions or countries where this catalog entry is available for sale. Supports regional product portfolio management and compliance with local regulations.',
    `sales_channel` STRING COMMENT 'Primary sales channel through which this catalog entry is sold (direct sales force, distributor network, OEM partnerships, online store, or channel partners).. Valid values are `direct|distributor|oem|online|partner`',
    `sales_organization` STRING COMMENT 'The SAP sales organization responsible for this catalog entry. Supports multi-org catalog management and sales territory alignment.',
    `service_level_tier` STRING COMMENT 'The default service level tier associated with this catalog entry, determining response times and support coverage for after-sales service.. Valid values are `standard|premium|critical|basic`',
    `standard_lead_time_days` STRING COMMENT 'The standard number of days from order receipt to shipment for this catalog entry under normal conditions. Used for customer delivery commitments and order promising.',
    `technical_datasheet_url` STRING COMMENT 'URL reference to the technical datasheet or specification document for this catalog entry. Provides detailed technical information for customers and sales teams.. Valid values are `^https?://.*.pdf$`',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months offered for this catalog entry. Used for customer communications and service planning.',
    CONSTRAINT pk_catalog_entry PRIMARY KEY(`catalog_entry_id`)
) COMMENT 'The commercial product catalog representing all individually orderable products, automation systems, electrification solutions, and smart infrastructure components available for sale. Captures catalog entry status, effective date ranges, sales channels (direct, distributor, OEM), regional availability, list price reference, OEM vs. standard offering flags, and catalog version. Acts as the bridge between the engineering SKU master and the commercial sales offering — not all SKUs are orderable, and catalog_entry defines which ones are. Managed in SAP S/4HANA SD and synchronized with Salesforce CRM product catalog.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`configuration` (
    `configuration_id` BIGINT COMMENT 'Primary key for configuration',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) that defines the components and assemblies required to manufacture this configuration.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: configuration.product_family_code is a denormalized string reference to the product family. Configurations (make-to-order, engineer-to-order variants) belong to a product family. Adding family_id FK n',
    `sku_master_id` BIGINT COMMENT 'Reference to the base product or product family that this configuration is derived from. Links to the product master catalog.',
    `superseded_by_configuration_id` BIGINT COMMENT 'Reference to the configuration that replaces this one when it becomes obsolete. Supports product migration and upgrade paths.',
    `application_type` STRING COMMENT 'Intended application or use case for this configuration. Describes the operational context where the product will be deployed.',
    `approval_date` DATE COMMENT 'Date when this configuration was formally approved for use in quoting and order fulfillment. Part of the configuration governance process.',
    `base_price` DECIMAL(18,2) COMMENT 'Starting price for the base product before configuration options are applied. Expressed in the default currency.',
    `certification_requirements` STRING COMMENT 'List of required certifications and compliance standards for this configuration, such as CE, UL, ISO certifications. Varies by market and application.',
    `configuration_code` DECIMAL(18,2) COMMENT 'Unique business identifier for the configured product variant. Used in CPQ (Configure-Price-Quote) workflows and order processing systems.',
    `configuration_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the product configuration. Indicates whether the configuration is available for quoting and ordering. [ENUM-REF-CANDIDATE: draft|active|inactive|obsolete|pending_approval|approved|rejected — 7 candidates stripped; promote to reference product]',
    `configuration_type` DECIMAL(18,2) COMMENT 'Classification of the configuration approach. Standard configurations are pre-defined, custom configurations are unique to customer requirements, engineer-to-order requires design work, make-to-order uses existing designs with custom parameters, configure-to-order selects from predefined options, and assemble-to-order combines standard modules.',
    `constraint_rules` STRING COMMENT 'Business rules and constraints that govern valid option combinations for this configuration. Defines incompatibilities, dependencies, and mandatory selections.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing fields. Indicates the currency in which prices are expressed.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or industry vertical for this configuration. Examples include automotive, energy, infrastructure, building automation.',
    `configuration_description` DECIMAL(18,2) COMMENT 'Detailed description of the configured product variant, including key features, options selected, and intended use case.',
    `dimensions_height_mm` DECIMAL(18,2) COMMENT 'Height dimension of the configured product in millimeters. Critical for packaging, shipping, and installation planning.',
    `dimensions_length_mm` DECIMAL(18,2) COMMENT 'Length dimension of the configured product in millimeters. Critical for packaging, shipping, and installation planning.',
    `dimensions_width_mm` DECIMAL(18,2) COMMENT 'Width dimension of the configured product in millimeters. Critical for packaging, shipping, and installation planning.',
    `effective_end_date` DATE COMMENT 'Date after which this configuration is no longer available for new orders. Supports product phase-out and end-of-life management.',
    `effective_start_date` DATE COMMENT 'Date from which this configuration becomes available for quoting and ordering. Supports phased product launches and market introductions.',
    `is_orderable` BOOLEAN COMMENT 'Flag indicating whether this configuration can currently be ordered. Used to control availability in CPQ (Configure-Price-Quote) and order management systems.',
    `is_quotable` BOOLEAN COMMENT 'Flag indicating whether this configuration can be included in customer quotes. May be quotable but not yet orderable during pre-launch phases.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was last updated. Tracks the most recent change to any field in the record.',
    `lead_time_days` STRING COMMENT 'Standard manufacturing and delivery lead time for this configuration in days. Used for order promising and scheduling.',
    `manufacturing_complexity` STRING COMMENT 'Assessment of the manufacturing complexity for this configuration. Impacts production planning, resource allocation, and lead time.. Valid values are `low|medium|high|very_high`',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be ordered for this configuration. Used to enforce economic order quantities and production efficiency.',
    `configuration_name` DECIMAL(18,2) COMMENT 'Human-readable name or title for the configured product variant. Describes the specific configuration in business terms.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this configuration. Used for internal communication and documentation.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Electrical power rating of the configured product in kilowatts. Relevant for electrification solutions and automation systems.',
    `price_adjustment` DECIMAL(18,2) COMMENT 'Total price adjustment resulting from selected configuration options. Can be positive (upcharge) or negative (discount).',
    `pricing_model` STRING COMMENT 'Pricing approach used for this configuration. Determines how the final price is calculated based on base product and selected options.. Valid values are `base_plus_options|bundled|tiered|custom_quote|cost_plus|value_based`',
    `regional_availability` STRING COMMENT 'Geographic regions or markets where this configuration is available for sale. Comma-separated list of region codes or market identifiers.',
    `requires_engineering_review` BOOLEAN COMMENT 'Flag indicating whether orders for this configuration require engineering review and approval before production. Common for engineer-to-order configurations.',
    `selected_options` STRING COMMENT 'Comma-separated or structured list of specific option codes selected for this configuration variant. Represents the actual choices made from the available option set.',
    `technical_specification_document` STRING COMMENT 'Reference to the technical specification document or datasheet that provides detailed engineering specifications for this configuration.',
    `total_configuration_price` DECIMAL(18,2) COMMENT 'Final calculated price for the configured product variant, including base price and all option adjustments.',
    `version_number` STRING COMMENT 'Version identifier for this configuration. Supports configuration change management and revision control.',
    `voltage_rating` STRING COMMENT 'Operating voltage specification for the configured product. Critical for electrical compatibility and safety compliance.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the configured product in kilograms. Used for shipping, logistics planning, and installation requirements.',
    CONSTRAINT pk_configuration PRIMARY KEY(`configuration_id`)
) COMMENT 'Manages configurable product variants and option sets for make-to-order and engineer-to-order automation systems and electrification solutions. Captures configuration rules, valid option combinations, constraint logic, base model references, and configured variant codes. Supports CPQ (Configure-Price-Quote) workflows in Salesforce CRM and variant configuration in SAP S/4HANA. Tracks which configuration options are available per product family, regional market, and customer segment.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` (
    `lifecycle_stage_id` BIGINT COMMENT 'Primary key for lifecycle_stage',
    `sku_master_id` BIGINT COMMENT 'Reference to the product in the product master catalog. Links this lifecycle stage record to the specific manufactured product, automation system, electrification solution, or smart infrastructure component.',
    `actual_eol_date` DATE COMMENT 'Actual date when the product reached end-of-life status. May differ from planned EOL date due to market conditions, inventory levels, or strategic decisions.',
    `lifecycle_stage_code` STRING COMMENT 'Current lifecycle stage of the product. NPI = New Product Introduction (pre-production or early launch), ACTIVE = Full production and sales, MATURE = Established product with stable demand, PHASE_DOWN = Planned reduction in production, EOL = End of Life (discontinued), OBSOLETE = No longer supported or available.. Valid values are `NPI|ACTIVE|MATURE|PHASE_DOWN|EOL|OBSOLETE`',
    `customer_communication_status` STRING COMMENT 'Status of customer notification and communication activities regarding the lifecycle stage change. Ensures timely and coordinated customer outreach for product discontinuations and transitions.. Valid values are `NOT_STARTED|PLANNED|IN_PROGRESS|COMPLETED|NOT_REQUIRED`',
    `customer_notification_date` DATE COMMENT 'Date when customers were officially notified of the lifecycle stage change, particularly for phase-down and end-of-life transitions. Critical for customer relationship management and contractual obligations.',
    `eco_reference_number` STRING COMMENT 'Reference number of the Engineering Change Order that authorized or documented the lifecycle stage transition, if applicable. Links lifecycle decisions to formal engineering change management processes.',
    `financial_impact_assessment` STRING COMMENT 'Summary of the financial implications of the lifecycle stage transition, including revenue impact, inventory write-offs, cost savings, and investment requirements. Business-confidential information for portfolio management.',
    `internal_notification_date` DATE COMMENT 'Date when internal stakeholders (sales, service, manufacturing, engineering) were notified of the lifecycle stage change to align cross-functional activities.',
    `inventory_wind_down_plan` STRING COMMENT 'Summary of the inventory management strategy for phasing out the product, including target inventory levels, sell-through timelines, and disposition plans for excess stock.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this is the current active lifecycle stage record for the product. Supports lifecycle history tracking with multiple stage records per product over time.',
    `last_time_buy_date` DATE COMMENT 'Final date by which customers can place orders for the product before it is discontinued. Critical milestone for customer communication and order management during product phase-out.',
    `last_time_ship_date` DATE COMMENT 'Final date by which the product will be shipped to customers. Represents the absolute end of product availability and delivery.',
    `lifecycle_decision_authority` STRING COMMENT 'Name or role of the person or committee that authorized the lifecycle stage transition. Supports governance and accountability for product portfolio decisions.',
    `lifecycle_decision_rationale` DECIMAL(18,2) COMMENT 'Business justification and reasoning for the lifecycle stage transition. Documents strategic, market, technical, or regulatory factors driving the lifecycle decision for portfolio rationalization and governance.',
    `lifecycle_review_date` DATE COMMENT 'Date of the most recent lifecycle stage review or assessment. Ensures regular evaluation of product portfolio health and lifecycle progression.',
    `manufacturing_discontinuation_date` DATE COMMENT 'Date when manufacturing and production of the product will cease. Drives supply chain wind-down, capacity reallocation, and inventory planning.',
    `market_demand_trend` STRING COMMENT 'Current market demand trend for the product. GROWING = increasing sales and market share, STABLE = consistent demand, DECLINING = decreasing sales, VOLATILE = unpredictable fluctuations, UNKNOWN = insufficient data. Informs lifecycle stage decisions and portfolio strategy.. Valid values are `GROWING|STABLE|DECLINING|VOLATILE|UNKNOWN`',
    `lifecycle_stage_name` STRING COMMENT 'Human-readable name of the lifecycle stage for reporting and communication purposes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next lifecycle stage review. Supports proactive lifecycle management and timely decision-making for product portfolio optimization.',
    `planned_eol_date` DATE COMMENT 'Planned date when the product will reach end-of-life status and be discontinued from active production and sales. Critical for supply chain wind-down planning and customer communication.',
    `previous_lifecycle_stage_code` STRING COMMENT 'The lifecycle stage code that preceded the current stage. Enables lifecycle transition analysis and stage progression tracking.. Valid values are `NPI|ACTIVE|MATURE|PHASE_DOWN|EOL|OBSOLETE`',
    `record_created_by` STRING COMMENT 'User ID or name of the person who created this lifecycle stage record. Supports accountability and audit trail for lifecycle decisions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle stage record was created in the system. Supports audit trail and data lineage for lifecycle management.',
    `record_updated_by` STRING COMMENT 'User ID or name of the person who last updated this lifecycle stage record. Supports accountability and audit trail for lifecycle changes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this lifecycle stage record. Enables change tracking and audit trail for lifecycle management.',
    `regulatory_compliance_impact` STRING COMMENT 'Description of any regulatory or compliance factors influencing the lifecycle stage decision, such as safety standards updates, environmental regulations, or certification requirements for industrial automation and electrification products.',
    `sales_discontinuation_date` DATE COMMENT 'Date when active sales and marketing efforts for the product will cease. May differ from last-time-buy date to allow for inventory sell-through.',
    `service_support_end_date` DATE COMMENT 'Date when after-sales service, technical support, and spare parts availability will cease for the product. Critical for customer service planning and SLA management.',
    `source_system_code` STRING COMMENT 'Unique identifier of this lifecycle stage record in the source system. Enables traceability and reconciliation between the lakehouse and operational systems.',
    `spare_parts_availability_end_date` DATE COMMENT 'Date when spare parts for the product will no longer be available for purchase. Important for maintenance planning and customer communication for automation and electrification systems.',
    `stage_effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the lifecycle stage transition became effective in the system. Supports audit trail and change tracking for lifecycle decisions.',
    `stage_entry_date` DATE COMMENT 'Date when the product entered the current lifecycle stage. Used to track time-in-stage and lifecycle progression analytics.',
    `supplier_notification_date` DATE COMMENT 'Date when suppliers and supply chain partners were notified of the lifecycle stage change to coordinate material procurement wind-down and component availability.',
    `warranty_support_end_date` DATE COMMENT 'Date when warranty coverage for newly sold units of this product will cease. Affects sales terms and customer commitments during product phase-out.',
    CONSTRAINT pk_lifecycle_stage PRIMARY KEY(`lifecycle_stage_id`)
) COMMENT 'Tracks the lifecycle stage of each product from New Product Introduction (NPI) through active production, phase-down, and end-of-life (EOL). Captures lifecycle stage code, stage entry date, planned EOL date, last-time-buy date, last-time-ship date, replacement product reference, and lifecycle decision rationale. Supports portfolio rationalization, supply chain wind-down planning, and customer communication for discontinued automation and electrification products. Managed in Siemens Teamcenter PLM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`product_specification` (
    `product_specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Product specifications (customer-facing, sales/marketing) often derive from or reference engineering specifications (design authority). Real business need: synchronizing spec changes when engineering ',
    `sku_master_id` BIGINT COMMENT 'Reference to the parent product in the product catalog. Links this specification to the master product record.',
    `altitude_rating_meters` DECIMAL(18,2) COMMENT 'Maximum operating altitude in meters above sea level. Defines altitude limitations for product operation due to air pressure and cooling considerations.',
    `application_suitability` STRING COMMENT 'Intended application areas and use cases. Describes the industrial applications, environments, or processes for which the product is designed and suitable.',
    `approved_date` DATE COMMENT 'Date when this specification version was formally approved. Tracks the approval milestone in the specification lifecycle.',
    `color_finish` STRING COMMENT 'Product color and surface finish. Describes the external appearance and coating (e.g., RAL 7035 light grey, powder coated, anodized aluminum).',
    `communication_protocol` STRING COMMENT 'Supported communication protocols for data exchange. Lists the industrial communication standards the product supports (e.g., PROFINET, EtherNet/IP, Modbus TCP, OPC UA).',
    `connection_type` STRING COMMENT 'Electrical connection or terminal type. Describes the method for connecting wires or cables to the product (e.g., screw terminals, spring clamp, plug connector).',
    `current_rating_amperes` DECIMAL(18,2) COMMENT 'Maximum continuous current rating in amperes. Defines the electrical current capacity of the product.',
    `datasheet_reference` STRING COMMENT 'Reference identifier or document number for the associated product datasheet. Links to the detailed technical datasheet managed in the engineering document management system.',
    `dimensions_height_mm` DECIMAL(18,2) COMMENT 'Product height dimension in millimeters. Defines the physical height for installation planning and space requirements.',
    `dimensions_length_mm` DECIMAL(18,2) COMMENT 'Product length dimension in millimeters. Defines the physical length for installation planning and space requirements.',
    `dimensions_width_mm` DECIMAL(18,2) COMMENT 'Product width dimension in millimeters. Defines the physical width for installation planning and space requirements.',
    `effective_date` DATE COMMENT 'Date when this specification version becomes effective and applicable for use in engineering, manufacturing, and sales processes.',
    `expiration_date` DATE COMMENT 'Date when this specification version is no longer valid or has been superseded by a newer revision. Null for active specifications without planned obsolescence.',
    `frequency_rating_hz` STRING COMMENT 'Operating frequency rating in Hertz. Specifies the electrical frequency the product is designed for (e.g., 50Hz, 60Hz, 50/60Hz).',
    `humidity_rating_percent` DECIMAL(18,2) COMMENT 'Relative humidity rating or range for product operation. Specifies the acceptable humidity conditions (e.g., 5-95% RH non-condensing).',
    `installation_manual_reference` STRING COMMENT 'Reference identifier or document number for the installation manual. Links to the installation instructions managed in the engineering document management system.',
    `ip_rating` STRING COMMENT 'Ingress Protection rating per IEC 60529 standard. Defines the level of protection against solid objects and liquids (e.g., IP65, IP67, IP20).. Valid values are `^IP[0-9]{2}[A-Z]?$`',
    `material_composition` STRING COMMENT 'Primary materials used in product construction. Lists the key materials and their properties (e.g., stainless steel housing, polycarbonate cover, copper conductors).',
    `mounting_type` STRING COMMENT 'Physical mounting method for the product. Specifies how the product is installed (e.g., DIN rail, panel mount, wall mount).. Valid values are `din_rail|panel_mount|wall_mount|floor_mount|rack_mount|embedded`',
    `nema_rating` STRING COMMENT 'NEMA enclosure rating for North American markets. Defines environmental protection level (e.g., NEMA1, NEMA4, NEMA4X, NEMA12).. Valid values are `^NEMA[0-9]{1,2}[A-Z]?$`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the specification. Captures supplementary information for engineering, quality, or sales teams.',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum operating ambient temperature in degrees Celsius. Defines the upper temperature limit for safe and reliable product operation.',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum operating ambient temperature in degrees Celsius. Defines the lower temperature limit for safe and reliable product operation.',
    `performance_parameter` STRING COMMENT 'Key performance parameters and metrics. Describes critical performance characteristics such as response time, accuracy, throughput, or efficiency ratings specific to the product type.',
    `power_rating_watts` DECIMAL(18,2) COMMENT 'Electrical power rating in watts. Specifies the maximum power consumption or output capacity of the product.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system. Tracks the initial capture of the specification data.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was last modified. Tracks the most recent update to any field in the specification record.',
    `revision_number` STRING COMMENT 'Version or revision identifier for the specification document. Tracks changes and updates over time.. Valid values are `^[A-Z0-9]{1,10}$`',
    `safety_data_sheet_reference` STRING COMMENT 'Reference identifier for the Safety Data Sheet. Links to the SDS document for products containing hazardous materials, managed in the engineering document management system.',
    `shock_resistance` STRING COMMENT 'Mechanical shock resistance specification. Describes the products ability to withstand mechanical shock per applicable test standards (e.g., IEC 60068-2-27).',
    `source_system_code` STRING COMMENT 'Unique identifier of this specification record in the source system. Enables traceability back to the originating system for data lineage and reconciliation.',
    `specification_description` STRING COMMENT 'Detailed textual description of the product specification. Provides comprehensive technical and commercial details not captured in structured fields.',
    `specification_name` STRING COMMENT 'Human-readable name or title of the product specification. Describes the specification purpose or scope.',
    `specification_number` STRING COMMENT 'Unique business identifier for the product specification document. Used for external reference and traceability across engineering, quality, and sales teams.. Valid values are `^SPEC-[A-Z0-9]{8,12}$`',
    `specification_status` STRING COMMENT 'Current lifecycle status of the product specification. Tracks the approval and active state of the specification document.. Valid values are `draft|under_review|approved|active|obsolete|superseded`',
    `specification_type` STRING COMMENT 'Classification of the specification document type. Indicates whether the specification covers technical parameters, commercial terms, or a combination.. Valid values are `technical|commercial|combined|performance|safety|environmental`',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius. Defines the upper temperature limit for product storage when not in operation.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius. Defines the lower temperature limit for product storage when not in operation.',
    `technical_drawing_reference` STRING COMMENT 'Reference identifier for associated technical drawings. Links to CAD drawings, dimensional drawings, or assembly drawings managed in the PLM system.',
    `vibration_resistance` DECIMAL(18,2) COMMENT 'Vibration resistance specification. Describes the products ability to withstand mechanical vibration per applicable test standards (e.g., IEC 60068-2-6).',
    `voltage_rating` STRING COMMENT 'Electrical voltage rating or range for the product. Specifies the nominal operating voltage and acceptable voltage range (e.g., 24VDC, 110-240VAC, 400V 3-phase).',
    `weight_kg` DECIMAL(18,2) COMMENT 'Product weight in kilograms. Defines the mass for shipping, handling, and installation planning.',
    CONSTRAINT pk_product_specification PRIMARY KEY(`product_specification_id`)
) COMMENT 'Technical and commercial specifications for manufactured products, automation systems, and electrification solutions. Captures electrical ratings, mechanical dimensions, environmental ratings (IP class, NEMA class), operating temperature range, performance parameters, and application suitability. Includes references to associated technical documentation (datasheets, installation manuals, safety data sheets) managed in the engineering domains document management system. Serves as the authoritative technical specification record referenced by engineering, quality, and sales teams. Managed in Siemens Teamcenter PLM and SAP S/4HANA. Note: certification records (UL, CE, IEC, ATEX, RoHS/REACH) are tracked separately in the certification product.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`plant_data` (
    `plant_data_id` BIGINT COMMENT 'Primary key for plant_data',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Associate plant‑specific data with the SKU it describes; enables plant‑level planning per SKU',
    `abc_indicator` BOOLEAN COMMENT 'ABC classification for inventory management prioritization. A=High-value items requiring tight control, B=Medium-value items, C=Low-value items with relaxed control.',
    `availability_check_group` STRING COMMENT 'Two-character key that controls which stock types are included in ATP (Available-to-Promise) checks for sales orders and production orders.. Valid values are `^[A-Z0-9]{2}$`',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether components are backflushed (automatically issued) when production order confirmations are posted. True=Backflush enabled, False=Manual goods issue required.',
    `batch_management_required` BOOLEAN COMMENT 'Indicates whether batch/lot tracking is required for this material at this plant. True=Batch management active, False=No batch tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this plant data record was first created in the system.',
    `cycle_counting_indicator` BOOLEAN COMMENT 'Single-character code that determines the frequency of cycle counting for this material. Used to schedule physical inventory counts.',
    `discontinuation_date` DATE COMMENT 'Date on which this material will be discontinued at this plant. Used for phase-out planning and last-time-buy notifications.',
    `effective_out_date` DATE COMMENT 'Date from which this plant data record becomes inactive. Used to manage time-dependent plant data changes.',
    `fixed_lot_size` DECIMAL(18,2) COMMENT 'Fixed order quantity used when lot size procedure is set to fixed lot size. MRP will always propose this quantity.',
    `gr_processing_time_days` STRING COMMENT 'Number of days required for goods receipt processing, quality inspection, and stock placement after physical delivery.',
    `in_house_production_time_days` STRING COMMENT 'Number of working days required to manufacture this material from raw materials to finished goods at this plant. Used in production scheduling and MRP.',
    `inspection_setup_required` BOOLEAN COMMENT 'Indicates whether a quality inspection setup (inspection lot creation) is required for goods receipts of this material at this plant. True=Inspection required, False=No inspection.',
    `issue_storage_location` STRING COMMENT 'Four-character code identifying the default storage location from which materials are issued to production orders or sales orders.. Valid values are `^[A-Z0-9]{4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this plant data record was last updated.',
    `lot_size_procedure` STRING COMMENT 'Lot-sizing procedure used in MRP to determine order quantities. EX=Lot-for-lot, HB=Replenish to maximum stock level, FX=Fixed lot size, WB=Weekly lot size, PK=Period lot size, LS=Lot size key.. Valid values are `EX|HB|FX|WB|PK|LS`',
    `material_number` STRING COMMENT 'Unique material identifier (SKU) from the material master. Links this plant data record to the global material master.. Valid values are `^[A-Z0-9]{8,18}$`',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or produced in a single lot for this material at this plant. Used in MRP calculations.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Target maximum inventory level for this material at this plant. Used in replenishment planning to determine order quantities.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or produced in a single lot for this material at this plant. Used in MRP calculations.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum number of days of remaining shelf life required for goods receipt acceptance. Batches with less remaining shelf life are rejected.',
    `modified_by_user` STRING COMMENT 'User ID of the person who last modified this plant data record. Used for audit trail and change tracking.. Valid values are `^[A-Z0-9]{12}$`',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the person or group responsible for MRP and procurement activities for this material at this plant.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_type` STRING COMMENT 'MRP procedure that controls how material requirements are planned. PD=MRP, VB=Manual reorder point, VM=Forecast-based planning, VV=Time-phased planning, ND=No planning, R1=Reorder point planning, R2=Replenishment planning. [ENUM-REF-CANDIDATE: PD|VB|VM|VV|ND|R1|R2 — 7 candidates stripped; promote to reference product]',
    `negative_stock_allowed` BOOLEAN COMMENT 'Indicates whether negative stock balances are permitted for this material at this plant. True=Negative stock allowed, False=System blocks transactions that would create negative stock.',
    `planned_delivery_time_days` STRING COMMENT 'Number of calendar days from order placement to goods receipt. Used by MRP to schedule procurement proposals and calculate reorder points.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or facility where this material is produced or stocked. Each plant has its own plant data record for a given material.. Valid values are `^[A-Z0-9]{4}$`',
    `plant_status` STRING COMMENT 'Current lifecycle status of this material at this plant. Active=Normal production/sales, Blocked=Temporarily unavailable, Discontinued=End-of-life, Phase_out=Being phased out, New_product_introduction=NPI stage.. Valid values are `active|blocked|discontinued|phase_out|new_product_introduction`',
    `procurement_type` STRING COMMENT 'Indicates how the material is procured at this plant. E=In-house production, F=External procurement (purchasing), X=Both production and external procurement.. Valid values are `E|F|X`',
    `production_storage_location` STRING COMMENT 'Four-character code identifying the default storage location within the plant where finished goods from production are received.. Valid values are `^[A-Z0-9]{4}$`',
    `profit_center` STRING COMMENT 'Ten-character code identifying the profit center responsible for this material at this plant. Used for internal profitability analysis.. Valid values are `^[A-Z0-9]{10}$`',
    `quality_inspection_type` STRING COMMENT 'QM inspection type that determines when quality inspections are triggered. 01=Goods receipt from vendor, 02=Goods receipt from production, 03=Goods issue to customer, 04=Stock transfer, 05=Physical inventory, 08=Recurring inspection, 09=Audit inspection. [ENUM-REF-CANDIDATE: 01|02|03|04|05|08|09 — 7 candidates stripped; promote to reference product]',
    `reorder_point` DECIMAL(18,2) COMMENT 'Stock level at which MRP triggers a procurement proposal. Calculated based on lead time demand plus safety stock.',
    `rounding_value` DECIMAL(18,2) COMMENT 'Rounding value for lot sizes. MRP rounds proposed order quantities up to the nearest multiple of this value.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum stock level maintained as buffer against demand fluctuations and supply disruptions. MRP triggers procurement when stock falls below this level plus reorder point.',
    `scheduling_margin_key` DECIMAL(18,2) COMMENT 'Key that defines float times (opening period, float before production, float after production) used in production scheduling to add buffer time.',
    `serialization_level` STRING COMMENT 'Controls serial number management for this material at this plant. 0=No serial numbers, 1=Serial number at goods receipt, 2=Serial number at goods issue, 3=Serial number at goods receipt and issue, 4=Serial number at production.. Valid values are `0|1|2|3|4`',
    `shelf_life_expiration_days` DECIMAL(18,2) COMMENT 'Total shelf life period in days from production date to expiration date. Used for batch management and FEFO (First Expired First Out) logic.',
    `special_procurement_type` STRING COMMENT 'Special procurement key for subcontracting, consignment, stock transfer, or other special procurement scenarios. 10=Withdrawal from warehouse, 20=Production in another plant, 30=External procurement, 40=Subcontracting, 50=Phantom assembly, 51=Phantom assembly with lead time, 52=Collective order, 70=Stock transfer, 80=Consignment, 90=Pipeline. [ENUM-REF-CANDIDATE: 10|20|30|40|50|51|52|70|80|90 — 10 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'Four-digit code that determines the general ledger accounts to which inventory movements are posted. Links material movements to financial accounting.. Valid values are `^[0-9]{4}$`',
    CONSTRAINT pk_plant_data PRIMARY KEY(`plant_data_id`)
) COMMENT 'Plant-specific master data extensions for each SKU, capturing manufacturing plant assignment, MRP type, lot size procedure, safety stock level, reorder point, planned delivery time, production storage location, and quality inspection type. Represents the SAP S/4HANA MM/PP plant view of the material master, enabling plant-level production planning, MRP runs, and inventory management. Each SKU may have different plant data records per manufacturing facility.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`classification` (
    `classification_id` BIGINT COMMENT 'Primary key for classification',
    `sku_master_id` BIGINT COMMENT 'Reference to the product being classified. Links to the product master data.',
    `application_area` STRING COMMENT 'The functional application area or use case for the product (e.g., Process Automation, Building Management, Motion Control, Power Distribution).',
    `assigned_by` STRING COMMENT 'User ID or system identifier of the person or process that assigned this classification. Supports audit trail and data quality accountability.',
    `assigned_date` DATE COMMENT 'The date when this classification was originally assigned to the product. Distinct from effective start date; tracks data lineage.',
    `auto_classified_flag` BOOLEAN COMMENT 'Indicates whether this classification was assigned automatically by a system or AI/ML model (true) or manually by a human user (false). Supports data quality monitoring and exception handling.',
    `business_unit` STRING COMMENT 'The business unit or division responsible for the product. Supports P&L reporting and organizational accountability.',
    `class_code` STRING COMMENT 'The specific classification code or identifier within the chosen scheme. For example, UNSPSC segment-family-class-commodity code, eCl@ss class ID, or HS tariff code.',
    `class_description` STRING COMMENT 'Human-readable description of the classification class. Provides business context for the class code.',
    `class_level` STRING COMMENT 'The hierarchical level of the classification within the scheme. For example, in UNSPSC: 1=Segment, 2=Family, 3=Class, 4=Commodity. Enables drill-down and roll-up reporting.',
    `classification_status` STRING COMMENT 'Current lifecycle status of the classification assignment. Active classifications are used for procurement, catalog, and export documentation. Deprecated classifications are retained for historical reporting.. Valid values are `active|inactive|pending|deprecated|superseded`',
    `commodity_code` STRING COMMENT 'Internal or industry-specific commodity code used for procurement categorization, spend analysis, and supplier management. Often aligned with SAP Ariba commodity taxonomy.',
    `confidence_score` DECIMAL(18,2) COMMENT 'A confidence score (0-100) indicating the certainty or quality of the classification assignment. Used when classifications are assigned by automated systems or AI/ML models.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the product is manufactured or substantially transformed. Required for customs documentation and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this classification record was first created in the system. Supports audit trail and data lineage tracking.',
    `customs_tariff_code` STRING COMMENT 'The Harmonized System tariff classification code used for customs declarations, import/export documentation, and duty calculation. Critical for international trade compliance.',
    `data_quality_status` STRING COMMENT 'The data quality status of this classification record. Indicates whether the classification has been verified, requires review, or has quality issues. Supports data stewardship workflows.. Valid values are `verified|unverified|pending_review|flagged|approved`',
    `effective_end_date` DATE COMMENT 'The date until which this classification assignment is valid. Null indicates an open-ended assignment. Used for managing classification transitions and product reclassifications.',
    `effective_start_date` DATE COMMENT 'The date from which this classification assignment is valid and should be used for business processes. Supports time-based classification changes for product lifecycle management.',
    `export_control_classification` STRING COMMENT 'Export control classification number assigned under export control regulations (e.g., US EAR, EU Dual-Use Regulation). Determines licensing requirements for international shipments of controlled goods.',
    `industry_segment` STRING COMMENT 'The primary industry segment or vertical market for which the product is designed (e.g., Automotive, Food & Beverage, Pharmaceuticals, Energy, Infrastructure).',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this classification record. Supports audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this classification record was last updated. Supports change tracking and data quality monitoring.',
    `last_review_date` DATE COMMENT 'The date when this classification was last reviewed for accuracy and relevance. Supports data quality management and periodic classification audits.',
    `material_group` STRING COMMENT 'SAP material group code used for grouping materials with similar characteristics for procurement, inventory management, and reporting purposes.',
    `material_type` STRING COMMENT 'SAP material type classification (e.g., FERT=Finished Product, HALB=Semi-Finished Product, ROH=Raw Material, HAWA=Trading Goods). Determines procurement and inventory handling rules.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next classification review. Enables proactive data quality management and compliance with classification governance policies.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the classification assignment. May include rationale for classification decisions, special handling instructions, or data quality observations.',
    `parent_class_code` STRING COMMENT 'The classification code of the parent node in the hierarchy. Enables navigation of multi-level taxonomies.',
    `primary_classification_flag` BOOLEAN COMMENT 'Indicates whether this is the primary classification for the product. A product may have multiple classifications across different schemes, but only one primary classification per scheme.',
    `product_category_l1` STRING COMMENT 'Top-level product category in the internal product hierarchy. Represents the broadest product grouping (e.g., Automation Systems, Electrification Solutions, Smart Infrastructure).',
    `product_category_l2` STRING COMMENT 'Second-level product category in the internal product hierarchy. Provides more granular segmentation within L1 categories.',
    `product_category_l3` STRING COMMENT 'Third-level product category in the internal product hierarchy. Provides detailed product family classification.',
    `product_category_l4` STRING COMMENT 'Fourth-level product category in the internal product hierarchy. Represents the most granular product classification level.',
    `product_line` STRING COMMENT 'The product line or brand family to which the product belongs. Used for portfolio management, marketing segmentation, and sales reporting.',
    `record_source` STRING COMMENT 'The source system or data feed from which this classification record originated. Supports data lineage and integration troubleshooting.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this classification is required for regulatory compliance purposes (e.g., customs, export control, environmental reporting). True if the classification is mandatory for legal/regulatory reasons.',
    `scheme` STRING COMMENT 'The standardized classification system or taxonomy used to categorize the product. Common schemes include UNSPSC (United Nations Standard Products and Services Code), eCl@ss (international product classification standard), ETIM (electro-technical information model), HS Code (Harmonized System for customs), and internal category hierarchies. [ENUM-REF-CANDIDATE: UNSPSC|eCl@ss|ETIM|HS_CODE|INTERNAL_CATEGORY|NAICS|SIC|GTIN — 8 candidates stripped; promote to reference product]',
    `search_keywords` STRING COMMENT 'Comma-separated list of search keywords or tags associated with this classification. Enhances product discoverability in e-commerce catalogs, procurement systems, and internal search applications.',
    `version` STRING COMMENT 'The version of the classification scheme standard being used. Classification schemes are periodically updated; tracking version ensures correct interpretation of codes.',
    CONSTRAINT pk_classification PRIMARY KEY(`classification_id`)
) COMMENT 'Assigns products to standardized classification schemes including industry taxonomy codes (UNSPSC, eCl@ss, ETIM), internal product category hierarchy, and customs tariff/HS codes for export compliance. Captures classification scheme, class code, class description, and assignment validity. Supports procurement catalog integration via SAP Ariba, customs documentation in logistics, and product search/filtering in the commercial catalog. Managed in SAP S/4HANA MM classification system.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Primary key for the order_line association',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: When a customer places an order, they order a specific catalog entry (the commercial offering with defined price, lead time, warranty, and orderable terms). order_line currently references sku_master_',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: For make-to-order and engineer-to-order products, an order line is placed against a specific product configuration (selected options, constraints, pricing model). Adding configuration_id to order_line',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to the SKU master record',
    `backorder_flag` BOOLEAN COMMENT 'Whether the line is currently backordered.',
    `billing_status` STRING COMMENT 'Billing status of the order line',
    `cancellation_reason` STRING COMMENT 'Cancellation reason',
    `confirmed_delivery_date` DATE COMMENT '',
    `confirmed_quantity` DECIMAL(18,2) COMMENT '',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost amount for the line',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `delivery_date` DATE COMMENT '',
    `delivery_status` STRING COMMENT 'Current delivery status of the SKU for this order line',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to the SKU on the order line',
    `discount_percent` DECIMAL(18,2) COMMENT 'discount percent',
    `discount_percentage` DECIMAL(18,2) COMMENT '',
    `extended_amount` DECIMAL(18,2) COMMENT 'extended amount',
    `extended_price_amount` DECIMAL(18,2) COMMENT '',
    `fulfillment_priority` STRING COMMENT 'Fulfillment priority code',
    `gross_price` DECIMAL(18,2) COMMENT '',
    `item_category` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_amount` DECIMAL(18,2) COMMENT '',
    `line_notes` STRING COMMENT '',
    `line_number` STRING COMMENT '',
    `line_sequence_number` STRING COMMENT 'Line sequence number',
    `line_status` STRING COMMENT '',
    `line_total_amount` DECIMAL(18,2) COMMENT '',
    `list_price` DECIMAL(18,2) COMMENT '',
    `margin_amount` DECIMAL(18,2) COMMENT 'Margin amount for the line',
    `net_price` DECIMAL(18,2) COMMENT 'Net unit price of the SKU on the order line after discounts',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity ordered on this line.',
    `profit_center_code` STRING COMMENT 'Profit center attribution for the order line.',
    `promised_delivery_date` DATE COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `rejection_reason` STRING COMMENT 'Reason code if the order line was rejected.',
    `requested_date` DATE COMMENT '',
    `requested_delivery_date` DATE COMMENT '',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested on the order line',
    `returnable_flag` BOOLEAN COMMENT 'Returnable flag',
    `shipped_quantity` DECIMAL(18,2) COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `unit_price_amount` DECIMAL(18,2) COMMENT '',
    `warranty_months` STRING COMMENT 'Warranty months',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Represents the line item linking a SKU to a sales order, capturing quantity, price, discount, and delivery status for each product in an order.. Existence Justification: A SKU (product) can be sold on many sales orders, and each sales order can contain many SKUs. The line item that links a SKU to an order is created and maintained by order entry staff and carries quantity, price, discount, and delivery status, which are attributes of the relationship itself.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_replacement_catalog_catalog_entry_id` FOREIGN KEY (`replacement_catalog_catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_superseded_by_configuration_id` FOREIGN KEY (`superseded_by_configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ADD CONSTRAINT `fk_product_lifecycle_stage_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ADD CONSTRAINT `fk_product_classification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_catalog_entry_id` FOREIGN KEY (`catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_mvm_ssot_duplicates_resolved' = '8');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_mvm_quality_score_maintained' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `commercial_description` SET TAGS ('dbx_business_glossary_term' = 'Commercial Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `dimension_uom` SET TAGS ('dbx_business_glossary_term' = 'Dimension Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `dimension_uom` SET TAGS ('dbx_value_regex' = 'MM|CM|M|IN|FT');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `height` SET TAGS ('dbx_business_glossary_term' = 'Height Dimension');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Length Dimension');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'npi|active|mature|phase_out|discontinued|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `lot_control_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Control Required Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `make_or_buy_code` SET TAGS ('dbx_business_glossary_term' = 'Make or Buy Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `make_or_buy_code` SET TAGS ('dbx_value_regex' = 'make|buy|both');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `plm_item_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `production_to_base_conversion` SET TAGS ('dbx_business_glossary_term' = 'Production to Base Unit of Measure (UoM) Conversion Factor');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `production_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `revision_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sales_to_base_conversion` SET TAGS ('dbx_business_glossary_term' = 'Sales to Base Unit of Measure (UoM) Conversion Factor');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sales_uom` SET TAGS ('dbx_business_glossary_term' = 'Sales Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sds_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `serial_control_required` SET TAGS ('dbx_business_glossary_term' = 'Serial Control Required Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'L|ML|M3|GAL|FT3|IN3');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|G|OZ|MT|TON');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `width` SET TAGS ('dbx_business_glossary_term' = 'Width Dimension');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Family ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `cybersecurity_classification` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Classification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `cybersecurity_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_description` SET TAGS ('dbx_business_glossary_term' = 'Product Family Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `environmental_compliance` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Standards');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `erp_material_group` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Material Group');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Product Family Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Product Family Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `innovation_priority` SET TAGS ('dbx_business_glossary_term' = 'Innovation Priority');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `innovation_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `iot_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet of Things (IoT) Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Family Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|phase_out|new_product_introduction|end_of_life|under_development');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `manufacturing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Product Family Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `plm_category` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Category');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'manufactured|purchased|both');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `product_line_owner` SET TAGS ('dbx_business_glossary_term' = 'Product Line Owner');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `product_portfolio_strategy` SET TAGS ('dbx_business_glossary_term' = 'Product Portfolio Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Master Data Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|archived');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Tier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|critical|basic');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Standard Warranty Period (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `replacement_catalog_catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Catalog ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_description` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_image_url` SET TAGS ('dbx_business_glossary_term' = 'Catalog Image Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_name` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_status` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|phase_out');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}.[0-9]{1,2}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `certification_marks` SET TAGS ('dbx_business_glossary_term' = 'Certification Marks');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `configurable_flag` SET TAGS ('dbx_business_glossary_term' = 'Configurable Product Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `configurable_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `distribution_chain` SET TAGS ('dbx_business_glossary_term' = 'Distribution Chain');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `environmental_compliance` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Indicators');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `last_price_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'npi|growth|maturity|decline|end_of_life');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `oem_offering_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Offering Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `oem_offering_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|oem|online|partner');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Tier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|critical|basic');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `technical_datasheet_url` SET TAGS ('dbx_business_glossary_term' = 'Technical Datasheet Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `technical_datasheet_url` SET TAGS ('dbx_value_regex' = '^https?://.*.pdf$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Base Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `superseded_by_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Configuration ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `constraint_rules` SET TAGS ('dbx_business_glossary_term' = 'Constraint Rules');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `dimensions_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Height Millimeters');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `dimensions_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Length Millimeters');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `dimensions_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Width Millimeters');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Is Orderable');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `is_orderable` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `is_quotable` SET TAGS ('dbx_business_glossary_term' = 'Is Quotable');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `is_quotable` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `manufacturing_complexity` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Complexity');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `manufacturing_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating Kilowatts');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `price_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Configuration Price Adjustment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `price_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'base_plus_options|bundled|tiered|custom_quote|cost_plus|value_based');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `requires_engineering_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Engineering Review');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `selected_options` SET TAGS ('dbx_business_glossary_term' = 'Selected Options');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `technical_specification_document` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `total_configuration_price` SET TAGS ('dbx_business_glossary_term' = 'Total Configuration Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `total_configuration_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `voltage_rating` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kilograms');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` SET TAGS ('dbx_subdomain' = 'lifecycle_operations');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `actual_eol_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End-of-Life (EOL) Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_code` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_code` SET TAGS ('dbx_value_regex' = 'NPI|ACTIVE|MATURE|PHASE_DOWN|EOL|OBSOLETE');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `customer_communication_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Communication Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `customer_communication_status` SET TAGS ('dbx_value_regex' = 'NOT_STARTED|PLANNED|IN_PROGRESS|COMPLETED|NOT_REQUIRED');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `eco_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `financial_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `financial_impact_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `internal_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Notification Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `inventory_wind_down_plan` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wind-Down Plan');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Lifecycle Record');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `is_active` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `last_time_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Ship (LTS) Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_decision_authority` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Decision Authority');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Decision Rationale');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_review_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `manufacturing_discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Discontinuation Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `market_demand_trend` SET TAGS ('dbx_business_glossary_term' = 'Market Demand Trend');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `market_demand_trend` SET TAGS ('dbx_value_regex' = 'GROWING|STABLE|DECLINING|VOLATILE|UNKNOWN');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_name` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Lifecycle Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `planned_eol_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End-of-Life (EOL) Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `previous_lifecycle_stage_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Lifecycle Stage Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `previous_lifecycle_stage_code` SET TAGS ('dbx_value_regex' = 'NPI|ACTIVE|MATURE|PHASE_DOWN|EOL|OBSOLETE');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `regulatory_compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Impact');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `sales_discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Discontinuation Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `service_support_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Support End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `spare_parts_availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Availability End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `stage_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Effective Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `stage_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `supplier_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notification Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `warranty_support_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Support End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `altitude_rating_meters` SET TAGS ('dbx_business_glossary_term' = 'Altitude Rating (Meters)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `application_suitability` SET TAGS ('dbx_business_glossary_term' = 'Application Suitability');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `color_finish` SET TAGS ('dbx_business_glossary_term' = 'Color and Finish');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `current_rating_amperes` SET TAGS ('dbx_business_glossary_term' = 'Current Rating (Amperes)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `datasheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Datasheet Reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `dimensions_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Height (Millimeters)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `dimensions_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Length (Millimeters)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `dimensions_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Width (Millimeters)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `frequency_rating_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency Rating (Hz)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `humidity_rating_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Rating (Percent)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `installation_manual_reference` SET TAGS ('dbx_business_glossary_term' = 'Installation Manual Reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `ip_rating` SET TAGS ('dbx_business_glossary_term' = 'Ingress Protection (IP) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `ip_rating` SET TAGS ('dbx_value_regex' = '^IP[0-9]{2}[A-Z]?$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `mounting_type` SET TAGS ('dbx_business_glossary_term' = 'Mounting Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `mounting_type` SET TAGS ('dbx_value_regex' = 'din_rail|panel_mount|wall_mount|floor_mount|rack_mount|embedded');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `nema_rating` SET TAGS ('dbx_business_glossary_term' = 'National Electrical Manufacturers Association (NEMA) Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `nema_rating` SET TAGS ('dbx_value_regex' = '^NEMA[0-9]{1,2}[A-Z]?$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Maximum (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Minimum (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `performance_parameter` SET TAGS ('dbx_business_glossary_term' = 'Performance Parameter');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `power_rating_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (Watts)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `safety_data_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `shock_resistance` SET TAGS ('dbx_business_glossary_term' = 'Shock Resistance');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^SPEC-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'technical|commercial|combined|performance|safety|environmental');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum (Celsius)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `technical_drawing_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Drawing Reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `vibration_resistance` SET TAGS ('dbx_business_glossary_term' = 'Vibration Resistance');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `voltage_rating` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` SET TAGS ('dbx_subdomain' = 'lifecycle_operations');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Data Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `availability_check_group` SET TAGS ('dbx_business_glossary_term' = 'Availability Check Group');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `availability_check_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `batch_management_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Required');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `cycle_counting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cycle Counting Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `effective_out_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Out Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `fixed_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `gr_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `in_house_production_time_days` SET TAGS ('dbx_business_glossary_term' = 'In-House Production Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `inspection_setup_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Setup Required');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `issue_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Issue Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `issue_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `lot_size_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `lot_size_procedure` SET TAGS ('dbx_value_regex' = 'EX|HB|FX|WB|PK|LS');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `negative_stock_allowed` SET TAGS ('dbx_business_glossary_term' = 'Negative Stock Allowed');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `plant_status` SET TAGS ('dbx_business_glossary_term' = 'Plant Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `plant_status` SET TAGS ('dbx_value_regex' = 'active|blocked|discontinued|phase_out|new_product_introduction');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `production_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Production Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `production_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `quality_inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `scheduling_margin_key` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Margin Key');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `serialization_level` SET TAGS ('dbx_business_glossary_term' = 'Serialization Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `serialization_level` SET TAGS ('dbx_value_regex' = '0|1|2|3|4');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `shelf_life_expiration_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Classification Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Application Area');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Classification Assigned By');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Assignment Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `auto_classified_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Classified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `auto_classified_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Class Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Classification Class Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `class_level` SET TAGS ('dbx_business_glossary_term' = 'Classification Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Assignment Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Classification Confidence Score');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Customs Tariff Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_review|flagged|approved');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `parent_class_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Classification Class Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `primary_classification_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Classification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `primary_classification_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `product_category_l1` SET TAGS ('dbx_business_glossary_term' = 'Product Category Level 1');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `product_category_l2` SET TAGS ('dbx_business_glossary_term' = 'Product Category Level 2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `product_category_l3` SET TAGS ('dbx_business_glossary_term' = 'Product Category Level 3');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `product_category_l4` SET TAGS ('dbx_business_glossary_term' = 'Product Category Level 4');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Classification Scheme');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Classification Search Keywords');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Classification Scheme Version');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_subdomain' = 'lifecycle_operations');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Order Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Sku Master Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `returnable_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
