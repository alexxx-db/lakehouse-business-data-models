-- Schema for Domain: product | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`product` COMMENT 'Product catalog and offering management domain serving as the SSOT for all manufactured products, automation systems, electrification solutions, and smart infrastructure components. Manages SKU master data, product families, configurations, pricing structures, product lifecycle stages from NPI to end-of-life, and product portfolio management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`sku_master` (
    `sku_master_id` BIGINT COMMENT 'Unique identifier for the SKU master record. Primary key for the SKU master data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost Allocation Report requires each SKU to be charged to a cost center for manufacturing cost tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial reporting of sales per SKU needs a dedicated revenue GL account for posting invoices.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Primary Supplier Assignment report requires each SKU to reference its main vendor for cost, lead‑time, and compliance decisions.',
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
    `product_family_code` STRING COMMENT 'Classification code identifying the product family or product line to which this SKU belongs. Used for portfolio management and product hierarchy reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
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
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit Center Performance Report groups families to evaluate profitability by product line.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Family-level audits apply a common regulatory requirement to all SKUs within the family.',
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
    `employee_id` BIGINT COMMENT 'Reference to the product manager responsible for this catalog entry. Supports product ownership and accountability.',
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
    `product_family_code` STRING COMMENT 'Classification code identifying the product family or product line to which this catalog entry belongs (e.g., automation controllers, motor drives, circuit breakers).',
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
    `option_set_id` BIGINT COMMENT 'Identifier for the collection of configuration options and rules that define valid combinations for this configuration.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Configuration Ownership Accountability Report needs to link configuration_owner to employee for audit trail.',
    `routing_id` BIGINT COMMENT 'Identifier for the manufacturing routing or process plan used to produce this configuration. Defines the sequence of operations.',
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
    `product_family_code` STRING COMMENT 'Code identifying the product family or product line to which this configuration belongs. Used for portfolio management and reporting.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`bom_header` (
    `bom_header_id` BIGINT COMMENT 'Unique identifier for the BOM header record. Primary key for the BOM header entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Engineering cost allocation tracks BOM creation expenses against the responsible cost center.',
    `cost_estimate_id` BIGINT COMMENT 'Reference to the most recent cost estimate calculated for this BOM. Links to costing records that roll up material, labor, and overhead costs from BOM components.',
    `plant_data_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this BOM is valid and used. BOMs can be plant-specific to accommodate local manufacturing processes and material availability.',
    `employee_id` BIGINT COMMENT 'Reference to the design engineer or engineering team responsible for maintaining this BOM. Primary contact for BOM-related questions and change requests.',
    `family_id` BIGINT COMMENT 'FK to product.family',
    `sku_master_id` BIGINT COMMENT 'Reference to the manufactured product, automation system, or electrification solution that this BOM defines. Links to the product master data.',
    `tertiary_bom_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this BOM header record. Supports accountability and audit trail requirements.',
    `alternative_bom_indicator` BOOLEAN COMMENT 'Identifier for alternative BOM versions for the same product. Allows multiple valid BOMs for a product to support different manufacturing methods, material substitutions, or regional variations.',
    `approval_date` DATE COMMENT 'Date when this BOM version was formally approved for production use. Marks the completion of engineering review and quality validation processes.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity for which the BOM is defined. All component quantities in the BOM lines are specified relative to this base quantity. Typically 1 unit of the finished product.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity. Defines the measurement unit (EA, KG, M, L, etc.) for the finished product quantity.',
    `bom_category` STRING COMMENT 'Structural classification of the BOM. Standard for fixed structures, Configurable for variant BOMs, Phantom for transient assemblies, Reference for documentation, Kit for bundled items.. Valid values are `standard|configurable|phantom|reference|kit`',
    `bom_description` STRING COMMENT 'Textual description of the BOM purpose, scope, or special characteristics. Provides context for the BOM structure and its intended application.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM. Externally-known unique code used across PLM and ERP systems for referencing the BOM structure.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM header. Tracks progression from draft through approval to active production use and eventual obsolescence. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|frozen|obsolete|archived — 7 candidates stripped; promote to reference product]',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended use. Engineering BOM for design, Manufacturing BOM for production, Sales BOM for customer-facing configurations, Service BOM for maintenance, Planning BOM for MRP, Costing BOM for financial analysis.. Valid values are `engineering|manufacturing|sales|service|planning|costing`',
    `bom_usage` STRING COMMENT 'Intended application context for this BOM. Defines whether the BOM is used for production runs, prototyping, spare parts management, rework operations, simulation, or testing purposes.. Valid values are `production|prototype|spare_parts|rework|simulation|testing`',
    `configuration_profile` DECIMAL(18,2) COMMENT 'Reference to the variant configuration profile for configurable products. Links the BOM to the product configurator rules and constraints.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this BOM header record was first created in the system. Immutable audit field for record lifecycle tracking.',
    `effective_date` DATE COMMENT 'Date from which this BOM version becomes valid and can be used for production planning and manufacturing execution. Supports phased rollout of engineering changes.',
    `engineering_change_notice_number` STRING COMMENT 'Reference to the ECN that communicated the engineering change. ECNs notify stakeholders of approved changes before implementation.',
    `engineering_change_order_number` STRING COMMENT 'Reference to the ECO that authorized the creation or modification of this BOM version. Provides traceability to the engineering change management process.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this BOM must comply with environmental regulations (RoHS, REACH, WEEE, ISO 14001). Used to enforce material restrictions and sustainability requirements.',
    `erp_system_code` STRING COMMENT 'Unique identifier for this BOM in the ERP system (SAP S/4HANA PP). Used for cross-system reconciliation and data lineage tracking.',
    `expiration_date` DATE COMMENT 'Date after which this BOM version is no longer valid for production use. Nullable for BOMs without a planned end date. Used to phase out obsolete BOM structures.',
    `explosion_type` STRING COMMENT 'Defines how the BOM structure is expanded in planning and costing. Single-level shows immediate components, Multi-level shows full hierarchy, Summarized aggregates across levels.. Valid values are `single_level|multi_level|summarized`',
    `is_configurable` BOOLEAN COMMENT 'Indicates whether this BOM supports variant configuration. True for BOMs with configurable components or optional features that can be selected during order entry.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether this BOM is for a critical product requiring special handling, quality controls, or regulatory compliance. Used to trigger enhanced review and approval workflows.',
    `is_phantom` BOOLEAN COMMENT 'Indicates whether this is a phantom BOM. Phantom BOMs represent transient assemblies that are not stocked but are consumed immediately in the parent assembly.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this BOM header record. Used for change tracking and audit trail purposes.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production batch size for which this BOM is optimized. Used in Material Requirements Planning (MRP) and production scheduling to determine component requirements.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the BOM. Used for manufacturing notes, quality alerts, or design rationale.',
    `plm_system_code` STRING COMMENT 'Unique identifier for this BOM in the source PLM system (Siemens Teamcenter). Used for synchronization and traceability between PLM and ERP systems.',
    `production_version` STRING COMMENT 'Identifier linking the BOM to a specific production process and routing. Enables multiple production methods for the same product with different BOM and routing combinations.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this BOM is subject to regulatory compliance requirements (CE marking, UL certification, IEC standards, etc.). Triggers additional documentation and validation workflows.',
    `revision_level` STRING COMMENT 'Version identifier for the BOM structure. Incremented with each Engineering Change Order (ECO) or Engineering Change Notice (ECN) that modifies the BOM.',
    CONSTRAINT pk_bom_header PRIMARY KEY(`bom_header_id`)
) COMMENT 'Bill of Materials (BOM) header record defining the top-level assembly structure for manufactured products, automation systems, and electrification solutions. Captures BOM type (engineering BOM, manufacturing BOM, sales BOM), BOM status, effective date range, plant assignment, base quantity, and revision level. Managed in Siemens Teamcenter PLM and synchronized to SAP S/4HANA PP for production planning. The BOM header is the authoritative structural definition of a manufactured product.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` (
    `product_bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the product_bom_line entity.',
    `bom_header_id` BIGINT COMMENT 'Foreign key reference to the parent BOM header that this line belongs to. Each BOM line must belong to exactly one BOM header.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Production planning reports require each BOM line to reference the engineering component master to ensure design consistency and cost roll‑up.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to engineering.drawing. Business justification: Manufacturing execution system uses the drawing ID per BOM line to fetch exact assembly drawings for work orders and quality inspections.',
    `sku_master_id` BIGINT COMMENT 'Foreign key reference to the component material or part from the SKU master data that is required for this assembly. Each BOM line references exactly one component SKU.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: BOM Supplier Allocation process tracks which vendor supplies each component, essential for production scheduling and quality audits.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production resource where this component is consumed. Used for shop floor material staging and kitting.',
    `alternative_item_group` STRING COMMENT 'Identifier for a group of interchangeable components that can substitute for each other in the assembly. Used for flexible BOM structures and supply chain resilience.',
    `alternative_item_priority` STRING COMMENT 'Priority ranking for this component within its alternative item group. Lower numbers indicate higher priority for material selection during MRP and production execution.',
    `assembly_level` STRING COMMENT 'The hierarchical level of this component in the multi-level BOM structure. Level 0 is the finished product, level 1 is direct sub-assembly, level 2 is sub-sub-assembly, etc. Used for BOM explosion and implosion.',
    `backflush_indicator` BOOLEAN COMMENT 'Flag indicating whether this component is consumed automatically via backflushing when the operation is confirmed (True) or requires manual goods issue (False). Used in lean manufacturing and MES integration.',
    `bulk_material_indicator` BOOLEAN COMMENT 'Flag indicating whether this component is a bulk material (liquids, powders, gases) that requires special handling, storage, and measurement during production.',
    `change_number` STRING COMMENT 'Internal change control number tracking modifications to this BOM line. Used for audit trail and version control in engineering change management.',
    `component_description` STRING COMMENT 'Textual description of the component part or material used in the assembly, providing additional context beyond the SKU reference.',
    `component_height_mm` DECIMAL(18,2) COMMENT 'Height dimension of the component in millimeters. Used for variable-size materials and spatial planning in assembly.',
    `component_length_mm` DECIMAL(18,2) COMMENT 'Length dimension of the component in millimeters. Used for variable-size materials and spatial planning in assembly.',
    `component_origin` STRING COMMENT 'Procurement strategy for this component: make (manufactured in-house), buy (purchased from supplier), make_or_buy (flexible sourcing), subcontract (outsourced manufacturing).. Valid values are `make|buy|make_or_buy|subcontract`',
    `component_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the component in kilograms. Used for calculating total assembly weight, shipping weight, and material handling requirements.',
    `component_width_mm` DECIMAL(18,2) COMMENT 'Width dimension of the component in millimeters. Used for variable-size materials and spatial planning in assembly.',
    `cost_relevance_indicator` DECIMAL(18,2) COMMENT 'Flag indicating whether this component should be included in product costing calculations. Text items and phantom assemblies are typically not cost-relevant.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this BOM line record. Used for accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM line record was first created in the system. Used for audit trail and data lineage.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical for production and requires special attention in material planning, procurement, and availability checking.',
    `ecn_number` STRING COMMENT 'Reference to the Engineering Change Notice that authorized this BOM line change. Provides traceability to engineering change documentation.',
    `eco_number` STRING COMMENT 'Reference to the Engineering Change Order that introduced or modified this BOM line. Links BOM changes to formal engineering change management processes.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM line is no longer active and should not be used in new production orders. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this BOM line becomes active and should be used in production planning and execution. Supports date-effectivity for phased component changes.',
    `fixed_quantity_indicator` BOOLEAN COMMENT 'Indicates whether the component quantity is fixed regardless of parent assembly batch size (True) or scales proportionally with batch size (False). Used for setup materials and consumables.',
    `installation_point` STRING COMMENT 'Physical location or position identifier where this component is installed in the parent assembly. Used for assembly instructions and service documentation.',
    `item_category` STRING COMMENT 'Classification of the BOM line item type: stock (regular inventory item), non_stock (direct procurement), phantom (pass-through assembly with no inventory), text (documentation only), variable_size (length/weight variable), co_product (joint output), by_product (secondary output). [ENUM-REF-CANDIDATE: stock|non_stock|phantom|text|variable_size|co_product|by_product — 7 candidates stripped; promote to reference product]',
    `lead_time_offset_days` STRING COMMENT 'Number of days before the parent assembly start date that this component must be available. Used for backward scheduling in production planning and MRP runs.',
    `line_number` STRING COMMENT 'Sequential line item number within the BOM header, used for ordering and referencing specific components in the assembly structure.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this BOM line record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM line record was last modified. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, comments, or special handling requirements for this component in the assembly process.',
    `operation_sequence` DECIMAL(18,2) COMMENT 'The routing operation number at which this component is consumed or installed in the manufacturing process. Links BOM to routing for integrated production planning.',
    `product_bom_line_status` STRING COMMENT 'Current lifecycle status of this BOM line: active (in use), inactive (temporarily disabled), pending (awaiting approval), obsolete (phased out), blocked (quality hold), released (approved for production).. Valid values are `active|inactive|pending|obsolete|blocked|released`',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'The required quantity of this component needed to produce one unit of the parent assembly. Supports up to 6 decimal places for precision in chemical, pharmaceutical, and electronics manufacturing.',
    `revision_level` STRING COMMENT 'Engineering revision level or version of this BOM line. Tracks design iterations and ensures correct component versions are used in production.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'Expected scrap or waste percentage for this component during the manufacturing process. Used by MRP to calculate additional material requirements. Value between 0.00 and 100.00.',
    `spare_part_indicator` BOOLEAN COMMENT 'Indicates whether this component is also available as a spare part for after-sales service and maintenance. Used for service parts planning and documentation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the component quantity (e.g., EA=Each, PC=Piece, KG=Kilogram, L=Liter, M=Meter). Must align with the component SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|PC|KG|G|L|ML|M|CM|FT|IN|LB|OZ|SET|BOX|ROLL|SHEET — 16 candidates stripped; promote to reference product]',
    CONSTRAINT pk_product_bom_line PRIMARY KEY(`product_bom_line_id`)
) COMMENT 'Individual component line items within a Bill of Materials (BOM), representing the parent-child assembly relationships for manufactured products. Captures component SKU reference, quantity per assembly, unit of measure, item category (stock, non-stock, phantom), scrap factor, lead time offset, alternative item group, and engineering change order (ECO) reference. Supports multi-level BOM explosion for MRP runs in SAP S/4HANA PP and production routing in Siemens Opcenter MES. Each bom_line belongs to exactly one bom_header and references exactly one component from sku_master.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` (
    `lifecycle_stage_id` BIGINT COMMENT 'Primary key for lifecycle_stage',
    `sku_master_id` BIGINT COMMENT 'Reference to the product in the product master catalog. Links this lifecycle stage record to the specific manufactured product, automation system, electrification solution, or smart infrastructure component.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: EOL and phase‑out decisions depend on regulatory deadlines; linking each lifecycle stage to its governing regulation.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`product_revision` (
    `product_revision_id` BIGINT COMMENT 'Unique identifier for the product revision record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Revision approval logs approved_by_employee_id to capture the engineer authorizing the product revision.',
    `sku_master_id` BIGINT COMMENT 'Reference to the parent product for which this revision applies. Links to the product master record.',
    `superseded_revision_product_revision_id` BIGINT COMMENT 'Reference to the previous product revision that this revision replaces. Maintains revision lineage and traceability.',
    `approval_date` DATE COMMENT 'Date when this revision was formally approved for release to manufacturing.',
    `approval_status` STRING COMMENT 'Current approval state of the revision within the engineering change control workflow.. Valid values are `not_submitted|pending|approved|rejected|conditional`',
    `bom_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision includes changes to the product Bill of Materials structure or component list.',
    `change_impact_level` STRING COMMENT 'Assessment of the magnitude and scope of impact this revision has on form, fit, function, manufacturing process, or supply chain.. Valid values are `minor|moderate|major|critical`',
    `change_reason_code` STRING COMMENT 'Categorization of the primary business reason or driver for this engineering revision.. Valid values are `design_improvement|cost_reduction|quality_issue|regulatory_compliance|supplier_change|customer_request`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revision record was first created in the source system.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether customers must be formally notified of this revision due to impact on form, fit, function, or regulatory compliance.',
    `drawing_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision includes changes to engineering drawings, CAD (Computer-Aided Design) models, or technical documentation.',
    `ecn_number` STRING COMMENT 'Reference number of the Engineering Change Notice that communicated this revision to stakeholders. Documents the notification of the approved change.. Valid values are `^ECN-[0-9]{6,10}$`',
    `eco_number` STRING COMMENT 'Reference number of the Engineering Change Order that authorized this revision. Provides traceability to the formal change request and approval process.. Valid values are `^ECO-[0-9]{6,10}$`',
    `effectivity_date` DATE COMMENT 'Date when this revision becomes effective for manufacturing and procurement. Determines when the new revision must be used in production.',
    `effectivity_serial_end` STRING COMMENT 'Ending serial number through which this revision is effective, when effectivity is controlled by serial number range.',
    `effectivity_serial_start` STRING COMMENT 'Starting serial number from which this revision is effective, when effectivity is controlled by serial number.',
    `effectivity_type` STRING COMMENT 'Method by which the revision effectivity is controlled (by date, serial number range, lot/batch, or immediate implementation).. Valid values are `date|serial_number|lot_batch|immediate`',
    `interchangeability_code` STRING COMMENT 'Defines whether this revision can be substituted for previous revisions in existing assemblies or field installations.. Valid values are `fully_interchangeable|forward_compatible|not_interchangeable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revision record was last updated in the source system.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or instructions related to this revision for engineering, manufacturing, or quality teams.',
    `obsolete_date` DATE COMMENT 'Date when this revision was marked as obsolete and no longer valid for new production orders.',
    `ppap_required_flag` BOOLEAN COMMENT 'Indicates whether this revision requires a new Production Part Approval Process submission to customers.',
    `process_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision requires changes to manufacturing processes, work instructions, or shop floor procedures.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this revision requires re-certification or approval from regulatory bodies (UL, CE, OSHA, EPA, etc.).',
    `release_date` DATE COMMENT 'Date when this revision was officially released to production and made available for use in manufacturing operations.',
    `revision_code` STRING COMMENT 'Engineering revision level identifier (e.g., A, B, C, 01, 02). Represents the sequential version of the product design.. Valid values are `^[A-Z0-9]{1,10}$`',
    `revision_description` STRING COMMENT 'Detailed description of the changes introduced in this revision, including design modifications, material changes, or process improvements.',
    `revision_status` STRING COMMENT 'Current lifecycle status of the product revision indicating its approval and release state.. Valid values are `draft|pending_approval|approved|released|obsolete|superseded`',
    `source_system_code` STRING COMMENT 'Unique identifier of this revision record in the source PLM (Product Lifecycle Management) system for traceability and reconciliation.',
    `specification_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision includes changes to product specifications, performance requirements, or acceptance criteria.',
    `testing_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision requires changes to quality testing procedures, inspection plans, or validation protocols.',
    `tooling_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision requires changes to manufacturing tooling, fixtures, jigs, or molds.',
    CONSTRAINT pk_product_revision PRIMARY KEY(`product_revision_id`)
) COMMENT 'Manages engineering revision history for manufactured products, tracking each revision level, Engineering Change Order (ECO) and Engineering Change Notice (ECN) references, revision description, effectivity date, and approval status. Captures the delta between revisions including affected BOM lines, drawing changes, and specification updates. Ensures traceability from product design through manufacturing execution per ISO 9001 document control requirements. Sourced from Siemens Teamcenter PLM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`product_specification` (
    `product_specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Specification approval workflow tracks which engineer approved each spec via approved_by_employee_id.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Specification approval workflow requires linking each specification to the governing regulatory standard.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`product_certification` (
    `product_certification_id` BIGINT COMMENT 'Unique identifier for the product certification record. Primary key.',
    `asset_certification_id` BIGINT COMMENT 'Reference to SSOT owner asset.asset_certification for certification conflict resolution.',
    `product_asset_asset_certification_ssot_ref_id` BIGINT COMMENT 'SSOT reference to the single source of truth record; this product is a non-authoritative duplicate view.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Certification management assigns responsible_engineer_employee_id to record accountability for each certification.',
    `sku_master_id` BIGINT COMMENT 'Reference to the manufactured product, automation system, electrification solution, or smart infrastructure component that holds this certification.',
    `applicable_markets` STRING COMMENT 'Geographic markets, regions, or countries where this certification enables product sale and distribution (e.g., European Union, North America, APAC). Pipe-separated list of ISO 3166-1 alpha-3 country codes or region identifiers.',
    `applicable_standards` STRING COMMENT 'Technical standards, regulations, or directives against which the product was certified (e.g., IEC 61131-2, EN 60204-1, UL 508). Pipe-separated list of standard identifiers.',
    `audit_date` DATE COMMENT 'Date of the most recent audit or inspection conducted by the certifying body to verify ongoing compliance.',
    `certificate_document_url` STRING COMMENT 'URL or file path to the digital copy of the certification certificate document stored in the document management system.',
    `certification_level` STRING COMMENT 'Classification or rating level assigned by the certification (e.g., ATEX Zone 1, IP67, Safety Integrity Level SIL 2, Performance Level PLd).',
    `certification_number` STRING COMMENT 'Unique certificate number or listing identifier issued by the certifying body (e.g., UL file number, CE declaration number, IEC certificate ID).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification indicating whether it is valid, expired, pending renewal, or revoked.. Valid values are `Active|Expired|Pending Renewal|Suspended|Revoked|Under Review`',
    `certification_type` STRING COMMENT 'Type of regulatory or safety certification obtained. Indicates the certification standard or framework under which the product was evaluated. [ENUM-REF-CANDIDATE: UL Listing|CE Marking|IEC Compliance|ATEX Rating|RoHS Declaration|REACH Declaration|ECCN Classification|FCC Certification|CSA Approval|TUV Certification — 10 candidates stripped; promote to reference product]',
    `certifying_body` STRING COMMENT 'Name of the organization or authority that issued the certification (e.g., Underwriters Laboratories, TUV Rheinland, Notified Body, National Standards Authority).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain and maintain this certification, including testing fees, audit fees, and certification body charges.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount (e.g., USD, EUR, CNY).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `cybersecurity_certification` STRING COMMENT 'Cybersecurity certification or compliance level achieved by the product (e.g., IEC 62443-4-1, IEC 62443-4-2, NIST Cybersecurity Framework).',
    `declaration_of_conformity_number` DECIMAL(18,2) COMMENT 'Unique identifier for the manufacturers Declaration of Conformity document associated with this certification, particularly for CE marking.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned under the U.S. Commerce Control List for dual-use items subject to export regulations.',
    `effective_date` DATE COMMENT 'Date from which the certification becomes valid and the product is authorized for market access under the certification scope.',
    `energy_efficiency_rating` STRING COMMENT 'Energy efficiency classification or rating assigned to the product (e.g., Energy Star, EU Energy Label class A+++, IEC 60034-30-1 efficiency class IE3).',
    `environmental_certification` STRING COMMENT 'Environmental management or sustainability certification obtained (e.g., ISO 14001, LEED, BREEAM, Cradle to Cradle).',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and requires renewal. Null for certifications with indefinite validity subject to ongoing compliance.',
    `functional_safety_certification` STRING COMMENT 'Functional safety certification level achieved by the product (e.g., IEC 61508 SIL 2, ISO 13849 PLd, IEC 61511).',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether this certification is typically disclosed to customers in product documentation, datasheets, or sales materials as a market differentiator.',
    `issue_date` DATE COMMENT 'Date on which the certification was officially issued or granted by the certifying body.',
    `mandatory_for_markets` STRING COMMENT 'List of markets or regions where this certification is legally mandatory for product sale (as opposed to voluntary). Pipe-separated ISO 3166-1 alpha-3 country codes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified or updated in the system.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next surveillance audit or re-certification assessment by the certifying body.',
    `product_scope` STRING COMMENT 'Description of the product models, configurations, or variants covered under this certification. Defines the boundary of what is certified.',
    `quality_certification` STRING COMMENT 'Quality management system certification under which the product was manufactured (e.g., ISO 9001, IATF 16949, AS9100).',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the product complies with REACH regulation for chemical substance registration and restriction in the European Union.',
    `remarks` STRING COMMENT 'Additional notes, conditions, limitations, or special requirements associated with the certification. May include restrictions on use, environmental conditions, or configuration dependencies.',
    `renewal_date` DATE COMMENT 'Target or scheduled date for certification renewal or re-assessment to maintain continuous compliance.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the product complies with RoHS Directive restricting the use of hazardous substances in electrical and electronic equipment.',
    `test_report_number` STRING COMMENT 'Reference number of the test report or assessment documentation that supports the certification issuance.',
    `weee_compliant` BOOLEAN COMMENT 'Indicates whether the product complies with WEEE Directive for proper disposal and recycling of electronic waste.',
    CONSTRAINT pk_product_certification PRIMARY KEY(`product_certification_id`)
) COMMENT 'Tracks regulatory and safety certifications obtained for manufactured products including UL listings, CE marking, IEC compliance, ATEX ratings, RoHS/REACH declarations, and export control classifications (ECCN). Captures certifying body, certificate number, issue date, expiry date, applicable markets/regions, product scope, and renewal status. Critical for market access compliance and customer-facing documentation. Supports ISO 9001 quality records and regulatory reporting to UL, CE, and OSHA.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`substitution` (
    `substitution_id` BIGINT COMMENT 'Primary key for substitution',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Substitution approval process logs approved_by_employee_id to capture who authorized a substitution.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Link primary SKU to master record for substitution; removes free‑form primary_sku column',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Substituted parts must satisfy the same regulatory requirement as the original part for compliance approval.',
    `application_restriction` STRING COMMENT 'Free-text description of any limitations or restrictions on where the substitute can be used. May reference specific customer segments, geographic regions, or application types.',
    `approval_date` DATE COMMENT 'Date when the substitution was formally approved by engineering, quality, or product management.',
    `automatic_substitution_flag` BOOLEAN COMMENT 'Indicates whether the substitution can be applied automatically by MRP or order management systems (true) or requires manual approval (false).',
    `compliance_certification_required_flag` BOOLEAN COMMENT 'Indicates whether the substitute product requires additional compliance certifications (UL, CE, IEC) before it can be used in regulated applications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the substitution record was first created in the system.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether customer approval or notification is required before applying the substitution in order fulfillment.',
    `customer_segment_restriction` STRING COMMENT 'Comma-separated list of customer segment codes where this substitution is restricted or not recommended.',
    `eco_reference_number` STRING COMMENT 'Reference to the Engineering Change Order that authorized or documented this substitution. Links to PLM system ECO records.. Valid values are `^ECO-[0-9]{6,10}$`',
    `effective_date` DATE COMMENT 'Date when the substitution becomes valid and can be used in order management, MRP, and customer service processes.',
    `expiration_date` DATE COMMENT 'Date when the substitution is no longer valid. Null indicates indefinite validity.',
    `form_fit_function_match` STRING COMMENT 'Indicates the degree of form-fit-function equivalence between primary and substitute. Exact means identical in all dimensions; partial means some differences exist; none means significant differences.. Valid values are `exact|form_only|fit_only|function_only|partial|none`',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this substitution is NOT permitted due to regulatory, certification, or business policy reasons.',
    `interchangeable_flag` BOOLEAN COMMENT 'Indicates whether the substitution is bidirectional (true) or unidirectional (false). When true, both SKUs can substitute for each other.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user or system that last modified the substitution record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the substitution record was last updated.',
    `last_used_date` DATE COMMENT 'Most recent date when this substitution was applied in a business transaction.',
    `lead_time_variance_days` STRING COMMENT 'Difference in standard lead time between substitute and primary SKU, measured in days. Positive values indicate longer lead time for substitute.',
    `price_variance_percent` DECIMAL(18,2) COMMENT 'Percentage difference in list price between the substitute and primary SKU. Positive values indicate the substitute is more expensive; negative values indicate cost savings.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating preference order when multiple substitutes exist for the same primary SKU. Lower numbers indicate higher priority. Used by MRP and order management fallback logic.',
    `quality_equivalence_verified_flag` BOOLEAN COMMENT 'Indicates whether quality assurance has verified that the substitute meets the same quality standards as the primary SKU through testing or certification.',
    `reason` STRING COMMENT 'Business reason for establishing the substitution relationship. Captures why the primary SKU requires a substitute. [ENUM-REF-CANDIDATE: discontinued|end_of_life|allocation|supply_shortage|obsolete|cost_reduction|quality_improvement|design_change — 8 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Unique identifier of this substitution record in the source system of record.',
    `substitute_sku` STRING COMMENT 'The replacement or substitute SKU that can be used in place of the primary SKU.. Valid values are `^[A-Z0-9]{8,20}$`',
    `substitution_status` STRING COMMENT 'Current lifecycle status of the substitution record. Active indicates the substitution is in effect; pending approval awaits engineering or quality review; approved is authorized but not yet effective; rejected was not approved; expired is no longer valid; suspended is temporarily inactive.. Valid values are `active|pending_approval|approved|rejected|expired|suspended`',
    `substitution_type` STRING COMMENT 'Classification of the substitution relationship. Direct replacement indicates identical form-fit-function; functional equivalent provides same capability with potential differences; upward compatible offers enhanced features; temporary substitute is short-term solution; cross-reference indicates OEM equivalence; alternate is approved alternative.. Valid values are `direct_replacement|functional_equivalent|upward_compatible|temporary_substitute|cross_reference|alternate`',
    `technical_notes` STRING COMMENT 'Engineering or technical notes describing differences between primary and substitute SKUs, installation considerations, or compatibility information.',
    `usage_count` STRING COMMENT 'Number of times this substitution has been applied in order management or MRP processes. Used for analytics and substitution effectiveness tracking.',
    CONSTRAINT pk_substitution PRIMARY KEY(`substitution_id`)
) COMMENT 'Defines approved substitute and alternate products for SKUs that are discontinued, on allocation, or unavailable. Captures the primary SKU, substitute SKU, substitution type (direct replacement, functional equivalent, upward compatible), effective date, approval status, and any application restrictions. Supports order management fallback logic in SAP S/4HANA SD, MRP alternative item processing, and customer service resolution for end-of-life product transitions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`bundle` (
    `bundle_id` BIGINT COMMENT 'Primary key for bundle',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Bundle approval tracking uses approved_by_user_employee_id to identify the employee approving the bundle.',
    `family_id` BIGINT COMMENT 'FK to product.family',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Bundle profitability analysis aggregates revenue and cost under a dedicated profit center.',
    `approval_status` STRING COMMENT 'Current approval status for new or modified bundles requiring management or product committee approval before activation.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle was approved for sale. Null if approval_status is not approved.',
    `assembly_required_flag` BOOLEAN COMMENT 'Indicates whether the bundle requires factory assembly or integration before shipment (True) or is shipped as separate components (False).',
    `availability_end_date` DATE COMMENT 'Date when this bundle is no longer available for new orders. Null for ongoing offerings. Used for promotional bundles and product phase-out planning.',
    `availability_start_date` DATE COMMENT 'Date when this bundle becomes available for sale. Used for new product introduction (NPI) and promotional campaign timing.',
    `bundle_status` STRING COMMENT 'Current lifecycle state of the bundle: draft (under development), active (available for sale), inactive (temporarily unavailable), discontinued (no longer sold but supported), obsolete (end-of-life).. Valid values are `draft|active|inactive|discontinued|obsolete`',
    `bundle_type` STRING COMMENT 'Classification of the bundle structure: fixed (pre-defined components, no substitution), configurable (customer can select options), promotional (time-limited marketing offer), solution (engineered system package), service (includes maintenance/support).. Valid values are `fixed|configurable|promotional|solution|service`',
    `certification_requirements` STRING COMMENT 'List of industry certifications or compliance standards the bundle meets (e.g., CE, UL, IEC 61508, ATEX). Critical for regulated industries and export compliance.',
    `bundle_code` STRING COMMENT 'Externally-known unique business identifier for the bundle, used in sales orders and quotations. Typically follows company SKU (Stock Keeping Unit) pattern for composite offerings.. Valid values are `^[A-Z0-9]{6,20}$`',
    `component_count` STRING COMMENT 'Total number of distinct SKU (Stock Keeping Unit) components included in this bundle. Used for complexity assessment and inventory planning.',
    `configuration_rules` DECIMAL(18,2) COMMENT 'Business rules governing component selection and substitution for configurable bundles. Describes constraints, dependencies, and valid option combinations.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the primary country of manufacture or assembly for the bundle. Used for customs, tariffs, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created this bundle record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the list price (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `bundle_description` STRING COMMENT 'Detailed commercial description of the bundle, including key features, benefits, and typical use cases. Used in catalogs, quotations, and sales documentation.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to the sum-of-parts price when pricing_method is discounted. Null for other pricing methods.',
    `distribution_channel_code` STRING COMMENT 'Code identifying the distribution channel through which this bundle is sold (e.g., direct sales, distributor, OEM (Original Equipment Manufacturer), e-commerce).',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned to the bundle for U.S. export control compliance. Determines licensing requirements for international shipments.',
    `energy_efficiency_rating` STRING COMMENT 'Energy efficiency classification or rating for the bundle if applicable (e.g., A+++, Energy Star, IE4). Used for sustainability reporting and customer decision-making.',
    `environmental_compliance` STRING COMMENT 'Environmental compliance certifications and declarations for the bundle (e.g., RoHS, REACH, WEEE, ISO 14001). Critical for EU and global environmental regulations.',
    `hazmat_classification` STRING COMMENT 'Hazardous material classification code if the bundle contains components subject to dangerous goods regulations. Used for shipping and handling compliance.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the bundle. Used for international trade, customs declarations, and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `image_url` STRING COMMENT 'URL to the primary product image or rendering of the bundle. Used in e-commerce, catalogs, and sales presentations.',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this bundle record. Used for change management and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle record was last updated. Used for change tracking and data synchronization.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from order placement to delivery for this bundle. Accounts for component availability, assembly, and logistics.',
    `list_price` DECIMAL(18,2) COMMENT 'Standard list price for the bundle in the base currency. Represents the published price before any customer-specific discounts or negotiations.',
    `marketing_description` STRING COMMENT 'Extended marketing copy and value proposition for the bundle, used in promotional materials, web catalogs, and sales presentations. Distinct from technical bundle_description.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of bundle units that must be ordered in a single transaction. Used to enforce volume thresholds for bundled offerings.',
    `bundle_name` STRING COMMENT 'Human-readable commercial name of the bundle as presented to customers and used in sales materials (e.g., Automation Cell Starter Kit, Smart Factory Solution Package).',
    `packaging_type` STRING COMMENT 'Description of the standard packaging method for the bundle (e.g., Wooden Crate, Cardboard Box, Pallet, Custom Container). Impacts shipping and handling requirements.',
    `pricing_method` STRING COMMENT 'Method used to calculate bundle price: sum_of_parts (total of component prices), fixed_price (single bundle price regardless of components), discounted (percentage off sum-of-parts), tiered (volume-based pricing), custom (negotiated per deal).. Valid values are `sum_of_parts|fixed_price|discounted|tiered|custom`',
    `replacement_bundle_code` STRING COMMENT 'Bundle code of the successor or replacement bundle when this bundle is discontinued. Used for product transition planning and customer migration.',
    `sales_organization_code` STRING COMMENT 'Code identifying the sales organization responsible for this bundle. Used in multi-division enterprises to segment product portfolios by business unit or geography.',
    `service_level_code` STRING COMMENT 'Code identifying the standard service level or SLA (Service Level Agreement) tier included with the bundle (e.g., BASIC, PREMIUM, 24x7).',
    `target_market_segment` STRING COMMENT 'Primary market segment or industry vertical this bundle is designed for (e.g., Automotive Manufacturing, Food & Beverage, Pharmaceutical, Discrete Manufacturing).',
    `technical_documentation_url` STRING COMMENT 'URL or document reference to the technical documentation, installation guides, and specifications for the bundle. Used by sales engineering and customer support.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total shipping volume of the complete bundle in cubic meters, including packaging. Used for warehouse space planning and transportation optimization.',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months provided with the bundle. Covers all included components under a unified warranty policy.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total shipping weight of the complete bundle in kilograms, including all components and packaging. Used for logistics planning and freight cost calculation.',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Defines commercial product bundles, solution packages, and system kits that combine multiple SKUs into a single orderable offering (e.g., a complete automation cell bundle including PLC, HMI, drives, and cabling). Captures bundle code, bundle type (fixed, configurable, promotional), component SKU list with quantities, bundle pricing method (sum-of-parts, fixed, discounted), availability period, and minimum order quantity. Supports solution selling for industrial automation and electrification systems in Salesforce CRM and SAP S/4HANA SD. Distinct from catalog_entry which represents individual orderable items; bundle represents composite offerings.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`plant_data` (
    `plant_data_id` BIGINT COMMENT 'Primary key for plant_data',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Plant‑level cost reporting requires linking plant data to the plants cost center.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Production scheduling assigns production_scheduler_employee_id to link the scheduler employee for labor planning.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`change_order` (
    `change_order_id` BIGINT COMMENT 'Primary key for change_order',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Change order initiation logs initiator_employee_id to identify the employee who raised the change.',
    `product_revision_id` BIGINT COMMENT 'Foreign key linking to product.product_revision. Business justification: Change orders often target a specific product revision; linking change_order to product_revision captures this ownership.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Tie each change order to the primary SKU it affects; removes unstructured affected_sku_list column',
    `affected_bom_level` STRING COMMENT 'Indicates which level(s) of the BOM hierarchy are impacted by the change: top-level finished goods, sub-assemblies, individual components, raw materials, or all levels.. Valid values are `top_level|sub_assembly|component|raw_material|all_levels`',
    `approval_date` DATE COMMENT 'Date when the change order received final approval from all required approvers and was authorized for implementation.',
    `approval_status` STRING COMMENT 'Overall approval decision status across all required approvers. Conditional indicates approval with stipulations; escalated indicates management review required.. Valid values are `pending|approved|rejected|conditional|escalated`',
    `approval_workflow_stage` STRING COMMENT 'Current stage in the multi-level approval workflow. Indicates which functional area is currently reviewing the change order. [ENUM-REF-CANDIDATE: engineering|quality|manufacturing|procurement|finance|executive|complete — 7 candidates stripped; promote to reference product]',
    `change_description` STRING COMMENT 'Comprehensive description of the proposed change, detailing what is being modified, the scope of the change, and the technical nature of the modification.',
    `change_owner_name` STRING COMMENT 'Name of the person assigned as the change owner responsible for driving the change through approval and implementation. Accountable for successful execution.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the primary business driver for the change: quality improvement, cost reduction, regulatory compliance, component obsolescence, customer request, or safety enhancement.. Valid values are `quality_improvement|cost_reduction|regulatory_compliance|obsolescence|customer_request|safety_enhancement`',
    `change_reason_description` STRING COMMENT 'Detailed narrative explanation of why the change is being requested, including background context, problem statement, and business justification.',
    `change_request_number` STRING COMMENT 'The externally-known unique identifier for the change order, typically formatted as ECO-NNNNNN or ECN-NNNNNN. This is the business identifier used across PLM, ERP, and MES systems.. Valid values are `^(ECO|ECN|PCN)-[0-9]{6,10}$`',
    `change_status` STRING COMMENT 'Current lifecycle status of the change order in the approval and implementation workflow. Tracks progression from initial draft through review, approval, implementation, and closure. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implemented|closed — 7 candidates stripped; promote to reference product]',
    `change_type` STRING COMMENT 'Classification of the change order by the nature of the modification: design (product design changes), process (manufacturing process changes), documentation (drawing/spec updates), material (material substitution), specification (technical spec changes), or BOM (bill of materials structure changes).. Valid values are `design|process|documentation|material|specification|bom`',
    `closure_date` DATE COMMENT 'Date when the change order was formally closed after successful implementation and validation. Marks the end of the change lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was first created in the PLM system. Marks the beginning of the change request lifecycle.',
    `customer_approval_status` STRING COMMENT 'Status of customer approval for the change, if customer notification is required. Tracks whether the customer has reviewed and approved the proposed modification.. Valid values are `not_required|pending|approved|rejected`',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customer notification is required for this change. True for changes that affect form, fit, function, or regulatory compliance requiring customer approval or notification.',
    `effectivity_date` DATE COMMENT 'The date on which the change becomes effective and must be implemented in production. This is the cutover date for transitioning from old to new specifications.',
    `effectivity_serial_number` STRING COMMENT 'Optional serial number or production lot number at which the change becomes effective. Used for mid-production changes where effectivity is tied to specific units rather than a date.',
    `impact_assessment_cost` DECIMAL(18,2) COMMENT 'Estimated financial impact of implementing the change, including tooling, material, labor, and rework costs. Used for cost-benefit analysis and approval decision-making.',
    `impact_assessment_inventory` STRING COMMENT 'Assessment of the impact on existing inventory, including obsolete stock quantities, rework requirements, scrap decisions, and transition inventory management strategy.',
    `impact_assessment_lead_time_days` STRING COMMENT 'Estimated impact on product lead time resulting from the change, measured in days. Positive values indicate lead time increase; negative values indicate reduction.',
    `impact_assessment_quality` STRING COMMENT 'Assessment of quality implications, including changes to inspection requirements, test procedures, quality control points, and expected quality improvements or risks.',
    `implementation_completion_date` DATE COMMENT 'Actual date when the change was fully implemented in production and the new specifications became active.',
    `implementation_status` STRING COMMENT 'Status of the physical implementation of the change in production. Tracks execution progress after approval has been granted.. Valid values are `not_started|in_progress|completed|on_hold|cancelled`',
    `implementing_plant_code` STRING COMMENT 'Code identifying the manufacturing plant or facility responsible for implementing the change. May be a single plant or multiple plants for multi-site rollout.. Valid values are `^[A-Z0-9]{4,6}$`',
    `initiator_department` STRING COMMENT 'Department or functional area of the change initiator (e.g., Engineering, Quality, Manufacturing, Procurement).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the change order record. Tracks the latest modification for audit and synchronization purposes.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, implementation notes, lessons learned, or other relevant information not captured in structured fields.',
    `plm_system_code` STRING COMMENT 'Unique identifier for this change order in the source PLM system (Siemens Teamcenter). Used for system integration and traceability back to the system of record.',
    `previous_revision_level` STRING COMMENT 'The product revision level that existed before this change order. Provides traceability to the prior design state.. Valid values are `^[A-Z0-9]{1,4}$`',
    `priority` STRING COMMENT 'Business priority level for processing and implementing the change. Critical priority indicates safety or regulatory urgency requiring immediate action.. Valid values are `critical|high|medium|low`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or certification body whose requirements are impacted by this change (e.g., UL, IEC, OSHA, EPA, CE). Applicable when regulatory_impact_flag is true.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the change has regulatory compliance implications requiring additional review, testing, or certification updates (e.g., UL, CE, safety certifications).',
    `related_capa_number` STRING COMMENT 'Reference to the CAPA record associated with this change order. Links the change to corrective or preventive action initiatives.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `related_ncr_number` STRING COMMENT 'Reference to the Non-Conformance Report that triggered this change order, if applicable. Links the change to quality issues or defects that necessitated the modification.. Valid values are `^NCR-[0-9]{6,10}$`',
    `revision_level` STRING COMMENT 'The new product revision level resulting from this change order. Tracks version progression of the product design (e.g., Rev A, Rev B, Rev 01, Rev 02).. Valid values are `^[A-Z0-9]{1,4}$`',
    `urgency_flag` BOOLEAN COMMENT 'Boolean indicator for expedited processing requirements. True indicates the change requires fast-track approval and implementation due to safety, regulatory, or critical business needs.',
    `validation_completion_date` DATE COMMENT 'Date when validation testing was completed and results were documented. Marks the final verification of the change implementation.',
    `validation_required` BOOLEAN COMMENT 'Indicates whether post-implementation validation testing is required to verify the change achieved its intended results without introducing new issues.',
    `validation_status` STRING COMMENT 'Status of post-implementation validation activities. Tracks whether the change has been verified to meet requirements and quality standards.. Valid values are `not_required|pending|in_progress|passed|failed`',
    CONSTRAINT pk_change_order PRIMARY KEY(`change_order_id`)
) COMMENT 'Engineering Change Order (ECO) and Engineering Change Notice (ECN) records governing approved changes to product designs, BOMs, specifications, and manufacturing processes as they affect the product master record. Captures change request number, change type (design, process, documentation), affected SKUs and BOM levels, change reason, impact assessment (cost, lead time, inventory), approval workflow status, effectivity date, and implementing plant. This product owns the product-facing change governance; the engineering domain owns the broader design change workflow and CAD/drawing changes. Managed in Siemens Teamcenter PLM change management module per ISO 9001 change control requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Primary key for the order_line association',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Orders can be for a bundle; adding bundle_id to order_line creates the needed parent relationship without a cycle.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to the sales order header',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the supply_agreement association',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to the SKU master record',
    `supplier_id` BIGINT COMMENT '',
    `agreed_price` DECIMAL(18,2) COMMENT '',
    `agreed_price_amount` DECIMAL(18,2) COMMENT '',
    `agreement_end_date` DATE COMMENT '',
    `agreement_number` STRING COMMENT '',
    `agreement_start_date` DATE COMMENT '',
    `agreement_status` STRING COMMENT '',
    `agreement_terms` STRING COMMENT '',
    `agreement_type` STRING COMMENT '',
    `auto_renew_flag` BOOLEAN COMMENT '',
    `auto_renewal_flag` BOOLEAN COMMENT '',
    `committed_annual_volume` DECIMAL(18,2) COMMENT '',
    `committed_volume` DECIMAL(18,2) COMMENT '',
    `contracted_price` DECIMAL(18,2) COMMENT 'contracted price',
    `contracted_volume` DECIMAL(18,2) COMMENT 'Business data attribute for supply_agreement.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Date when the contract becomes effective for the specific SKU',
    `end_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `governing_law` STRING COMMENT 'Governing law jurisdiction for the agreement',
    `incoterms` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lead_time_days` STRING COMMENT 'Lead time in days for delivery of the SKU under this contract',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `payment_terms` DECIMAL(18,2) COMMENT '',
    `penalty_clause` STRING COMMENT '',
    `price` DECIMAL(18,2) COMMENT 'Negotiated price for the SKU under this contract',
    `price_break_terms` DECIMAL(18,2) COMMENT '',
    `price_uom` DECIMAL(18,2) COMMENT '',
    `quality_requirements` STRING COMMENT 'Quality requirements covered by the supply agreement.',
    `renewal_notice_days` STRING COMMENT '',
    `review_frequency_months` STRING COMMENT 'How often the supply agreement is reviewed.',
    `start_date` DATE COMMENT '',
    `terms_summary` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT 'Business data attribute for supply_agreement.',
    `volume_commitment_quantity` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'This association product represents the contractual relationship between a SKU master record and a procurement contract. It captures contract‑specific details that apply to each SKU‑contract pairing, such as the effective date of the agreement, the negotiated price, and the lead time for delivery.. Existence Justification: A SKU can be covered by multiple procurement contracts (e.g., different suppliers, time‑bound agreements) and a single procurement contract typically includes many SKUs. The business actively creates and maintains these links, tracking contract‑specific terms such as price, effective date, and lead time for each SKU‑contract pair.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`product`.`option_set` (
    `option_set_id` BIGINT COMMENT 'Primary key for option_set',
    `parent_option_set_id` BIGINT COMMENT 'Self-referencing FK on option_set (parent_option_set_id)',
    `option_set_category` STRING COMMENT 'Higher‑level grouping for the option set (e.g., product line, region).',
    `option_set_code` STRING COMMENT 'Compact alphanumeric code used to reference the option set in downstream systems.',
    `confidentiality_level` STRING COMMENT 'Data classification level applied to the option set.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the option set record was first created.',
    `option_set_description` STRING COMMENT 'Detailed description of the purpose and usage of the option set.',
    `effective_from` DATE COMMENT 'Date when the option set becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the option set expires; null if indefinite.',
    `external_reference` STRING COMMENT 'Identifier used to map the option set to an external vendor or ERP system.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this option set is the default choice for its type.',
    `option_set_name` STRING COMMENT 'Human‑readable name of the option set.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the option set.',
    `option_type` STRING COMMENT 'Category that defines the nature of the option (e.g., color, size, material).',
    `sort_order` STRING COMMENT 'Numeric order used to present options in a consistent sequence.',
    `option_set_status` STRING COMMENT 'Current lifecycle status of the option set.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the option set record.',
    `version_number` STRING COMMENT 'Version of the option set definition for change management.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_option_set PRIMARY KEY(`option_set_id`)
) COMMENT 'Master reference table for option_set. Referenced by option_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_replacement_catalog_catalog_entry_id` FOREIGN KEY (`replacement_catalog_catalog_entry_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`catalog_entry`(`catalog_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ADD CONSTRAINT `fk_product_catalog_entry_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_option_set_id` FOREIGN KEY (`option_set_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`option_set`(`option_set_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_superseded_by_configuration_id` FOREIGN KEY (`superseded_by_configuration_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ADD CONSTRAINT `fk_product_lifecycle_stage_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_superseded_revision_product_revision_id` FOREIGN KEY (`superseded_revision_product_revision_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_family_id` FOREIGN KEY (`family_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`family`(`family_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` ADD CONSTRAINT `fk_product_classification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ADD CONSTRAINT `fk_product_change_order_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ADD CONSTRAINT `fk_product_change_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ADD CONSTRAINT `fk_product_order_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ADD CONSTRAINT `fk_product_option_set_parent_option_set_id` FOREIGN KEY (`parent_option_set_id`) REFERENCES `vibe_manufacturing_v1`.`product`.`option_set`(`option_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_mvm_ssot_duplicates_resolved' = '8');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_mvm_quality_score_maintained' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `product_family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`sku_master` ALTER COLUMN `product_family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Family ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`family` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`catalog_entry` ALTER COLUMN `product_family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` SET TAGS ('dbx_subdomain' = 'structure_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `option_set_id` SET TAGS ('dbx_business_glossary_term' = 'Option Set ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `product_family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `requires_engineering_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Engineering Review');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `selected_options` SET TAGS ('dbx_business_glossary_term' = 'Selected Options');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `technical_specification_document` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `total_configuration_price` SET TAGS ('dbx_business_glossary_term' = 'Total Configuration Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `total_configuration_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `voltage_rating` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`configuration` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kilograms');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` SET TAGS ('dbx_subdomain' = 'structure_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `family_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `tertiary_bom_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `tertiary_bom_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `tertiary_bom_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bill of Materials (BOM) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_category` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Category');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_category` SET TAGS ('dbx_value_regex' = 'standard|configurable|phantom|reference|kit');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_description` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'engineering|manufacturing|sales|service|planning|costing');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `bom_usage` SET TAGS ('dbx_value_regex' = 'production|prototype|spare_parts|rework|simulation|testing');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `engineering_change_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `erp_system_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) System ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'Explosion Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Is Configurable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `is_configurable` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `is_critical` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `is_phantom` SET TAGS ('dbx_business_glossary_term' = 'Is Phantom Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `is_phantom` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bom_header` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` SET TAGS ('dbx_subdomain' = 'structure_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bill of Materials (BOM) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `alternative_item_priority` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Priority');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `assembly_level` SET TAGS ('dbx_business_glossary_term' = 'Assembly Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `bulk_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Change Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Height Millimeters (MM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Length Millimeters (MM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_origin` SET TAGS ('dbx_business_glossary_term' = 'Component Origin');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_origin` SET TAGS ('dbx_value_regex' = 'make|buy|make_or_buy|subcontract');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Component Weight Kilograms (KG)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `component_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Width Millimeters (MM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `cost_relevance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Relevance Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `fixed_quantity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fixed Quantity Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `installation_point` SET TAGS ('dbx_business_glossary_term' = 'Installation Point');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Category');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete|blocked|released');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `spare_part_indicator` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `lifecycle_stage_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`lifecycle_stage` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` SET TAGS ('dbx_subdomain' = 'engineering_change');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Product Revision ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `superseded_revision_product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Revision ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|conditional');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `bom_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Affected Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `bom_affected_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'design_improvement|cost_reduction|quality_issue|regulatory_compliance|supplier_change|customer_request');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `drawing_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Drawing Affected Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `drawing_affected_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `ecn_number` SET TAGS ('dbx_value_regex' = '^ECN-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `eco_number` SET TAGS ('dbx_value_regex' = '^ECO-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `effectivity_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `effectivity_serial_end` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number End');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `effectivity_serial_start` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number Start');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `effectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `effectivity_type` SET TAGS ('dbx_value_regex' = 'date|serial_number|lot_batch|immediate');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_business_glossary_term' = 'Interchangeability Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_value_regex' = 'fully_interchangeable|forward_compatible|not_interchangeable');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `ppap_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `ppap_required_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `process_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Affected Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `process_affected_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_business_glossary_term' = 'Revision Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|released|obsolete|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `specification_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Affected Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `specification_affected_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `testing_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Testing Affected Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `testing_affected_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `tooling_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Tooling Affected Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_revision` ALTER COLUMN `tooling_affected_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` SET TAGS ('dbx_subdomain' = 'engineering_change');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_specification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot_group' = 'certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot_master' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot_of' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot_subject' = 'product_conformity_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_duplicate_resolution' = 'subject_partition');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `asset_certification_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `product_asset_asset_certification_ssot_ref_id` SET TAGS ('dbx_ssot_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Pending Renewal|Suspended|Revoked|Under Review');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `cybersecurity_certification` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `declaration_of_conformity_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Conformity (DoC) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `energy_efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `functional_safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `is_customer_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Facing Certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `is_customer_facing` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `mandatory_for_markets` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Markets');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Management Certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Certification Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`product_certification` ALTER COLUMN `weee_compliant` SET TAGS ('dbx_business_glossary_term' = 'Waste Electrical and Electronic Equipment (WEEE) Compliant');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` SET TAGS ('dbx_subdomain' = 'structure_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `application_restriction` SET TAGS ('dbx_business_glossary_term' = 'Application Restriction');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `automatic_substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Substitution Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `automatic_substitution_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `compliance_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `compliance_certification_required_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `customer_segment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Restriction');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `eco_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `eco_reference_number` SET TAGS ('dbx_value_regex' = '^ECO-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `form_fit_function_match` SET TAGS ('dbx_business_glossary_term' = 'Form Fit Function Match');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `form_fit_function_match` SET TAGS ('dbx_value_regex' = 'exact|form_only|fit_only|function_only|partial|none');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `interchangeable_flag` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `interchangeable_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `lead_time_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variance Days');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `price_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `quality_equivalence_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Equivalence Verified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `quality_equivalence_verified_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitute_sku` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitute_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_value_regex' = 'active|pending_approval|approved|rejected|expired|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'direct_replacement|functional_equivalent|upward_compatible|temporary_substitute|cross_reference|alternate');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `technical_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`substitution` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` SET TAGS ('dbx_subdomain' = 'structure_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` SET TAGS ('dbx_review_status' = 'enriched');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `family_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `assembly_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assembly Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `assembly_required_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|discontinued|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_business_glossary_term' = 'Bundle Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_value_regex' = 'fixed|configurable|promotional|solution|service');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Bundle Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `component_count` SET TAGS ('dbx_business_glossary_term' = 'Component Count');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `configuration_rules` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rules');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_description` SET TAGS ('dbx_business_glossary_term' = 'Bundle Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bundle Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `energy_efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Rating');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `environmental_compliance` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Product Image URL');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'Bundle List Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Bundle Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Bundle Pricing Method');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'sum_of_parts|fixed_price|discounted|tiered|custom');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `replacement_bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement Bundle Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `technical_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Technical Documentation URL');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (m³)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`bundle` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Data Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Scheduler Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`plant_data` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`classification` SET TAGS ('dbx_structure_required' = 'v2');
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
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` SET TAGS ('dbx_subdomain' = 'engineering_change');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `affected_bom_level` SET TAGS ('dbx_business_glossary_term' = 'Affected Bill of Materials (BOM) Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `affected_bom_level` SET TAGS ('dbx_value_regex' = 'top_level|sub_assembly|component|raw_material|all_levels');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `approval_workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Stage');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'quality_improvement|cost_reduction|regulatory_compliance|obsolescence|customer_request|safety_enhancement');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) / Engineering Change Notice (ECN) Request Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_request_number` SET TAGS ('dbx_value_regex' = '^(ECO|ECN|PCN)-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'design|process|documentation|material|specification|bom');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `effectivity_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `effectivity_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `impact_assessment_cost` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Cost');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `impact_assessment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `impact_assessment_inventory` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Inventory');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `impact_assessment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `impact_assessment_quality` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Quality');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `implementing_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Implementing Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `implementing_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `initiator_department` SET TAGS ('dbx_business_glossary_term' = 'Change Initiator Department');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Change Order Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System ID');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `previous_revision_level` SET TAGS ('dbx_business_glossary_term' = 'Previous Product Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `previous_revision_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Order Priority');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `related_capa_number` SET TAGS ('dbx_business_glossary_term' = 'Related Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `related_capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `related_ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Related Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `related_ncr_number` SET TAGS ('dbx_value_regex' = '^NCR-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `revision_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `validation_required` SET TAGS ('dbx_business_glossary_term' = 'Validation Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`change_order` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_association_edges' = 'product.sku_master,order.order_header');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_reviewed' = 'thin_expanded');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_review_status' = 'enriched');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Order Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Sales Order Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line - Sku Master Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`order_line` ALTER COLUMN `returnable_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'product.sku_master,procurement.procurement_contract');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_reviewed' = 'stub_enriched');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_review_status' = 'enriched');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Supply Agreement Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Procurement Contract Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Sku Master Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`supply_agreement` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` SET TAGS ('dbx_subdomain' = 'structure_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` SET TAGS ('dbx_structure_required' = 'v2');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_id` SET TAGS ('dbx_business_glossary_term' = 'Option Set Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `parent_option_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Option Set Id');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `parent_option_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `is_default` SET TAGS ('dbx_typing_rule' = 'boolean');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `option_set_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`product`.`option_set` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
