-- Schema for Domain: product | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 13:03:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`product` COMMENT 'Single source of truth for all product master data across the CPG/FMCG portfolio. Owns SKU definitions, GTIN/UPC/EAN identifiers, product hierarchies, BOM structures, PLM lifecycle stages, formulation records, packaging specifications, INCI ingredient declarations, and regulatory labeling attributes. Serves as the authoritative product catalog referenced by all other domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique surrogate identifier for each SKU record in the product master. Primary key for the sku data product, referenced by all downstream domains as the authoritative product identifier.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each SKU to be assigned a cost_center for expense tracking and product profitability analysis.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Required for assigning each SKU to its primary distribution node used in supply planning, ATP calculations, and network optimization.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Primary Distribution Center Assignment needed for inventory allocation and OTIF planning reports; experts assign each SKU to its main DC.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR invoice posting uses a default sales GL account per SKU; linking enables automated revenue posting and audit trails.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: sku should be linked to its product hierarchy for classification; no existing column, so new FK added.',
    `innovation_brief_id` BIGINT COMMENT 'Foreign key linking to research.innovation_brief. Business justification: Tracks which Innovation Brief generated the SKU, supporting pipeline reporting and ROI analysis of innovation initiatives.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: CAPACITY PLANNING: Assign each SKU to its primary manufacturing facility for production capacity allocation, cost per facility, and regulatory reporting.',
    `marketing_brand_id` BIGINT COMMENT 'FK to marketing.brand.brand_id — Links SKU master to brand master. Fundamental for brand-level revenue reporting, portfolio analysis, and marketing attribution.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Needed for product development cost allocation and regulatory traceability linking each SKU to its originating R&D project.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Primary Supplier Assignment for each SKU is required for sourcing strategy, cost analysis, and regulatory compliance reports.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Designating a primary supplier site per SKU supports logistics planning, VMI inventory control, and OTIF performance tracking.',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: sku needs to reference its brand master; brand string is redundant once product_brand_id FK is added.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: SKU may belong to multiple product categories; linking SKU to product_category adds needed inbound relationship.',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: Needed for linking each SKU to its lifecycle assessment for regulatory compliance and carbon footprint reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for PLM Product Owner assignment; ownership reports need employee responsible for each SKU.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability statements map each SKU to a profit_center, enabling SKU‑level P&L reporting and margin analysis.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: SKU belongs to a product category; linking SKU to category eliminates silo and consolidates category data.',
    `sku_group_id` BIGINT COMMENT 'Foreign key linking to product.sku_group. Business justification: SKU can be grouped; linking SKU to sku_group provides hierarchy and eliminates silo for sku_group.',
    `sku_marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand performance reports require each SKU to be linked to its marketing brand for equity and spend analysis.',
    `sku_code` STRING COMMENT 'Internal alphanumeric code assigned to the SKU within the ERP system (SAP S/4HANA Material Number). Serves as the primary business identifier used in procurement, manufacturing, and sales transactions. Maps to SAP MM material number.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `color` STRING COMMENT 'Consumer-facing color descriptor for the SKU (e.g., Blue, Clear, White). Applicable to products where color is a differentiating attribute (e.g., hair color, cosmetics, cleaning products). Used in planogram execution and consumer-facing content.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the product is manufactured or substantially transformed. Required for customs declarations, trade compliance, and consumer labeling in many markets.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was first created in the system of record (SAP S/4HANA). Used for data lineage, audit trail, and compliance with SOX record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the MSRP and standard cost fields (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `discontinuation_date` DATE COMMENT 'Date on which the SKU was or is planned to be permanently discontinued from the portfolio. Triggers end-of-life processes in supply chain, manufacturing, and trade. Null if the SKU is still active.',
    `ean` STRING COMMENT '13-digit European Article Number (EAN-13) used in international retail markets outside North America for barcode scanning and product identification. Registered with GS1.. Valid values are `^[0-9]{13}$`',
    `fefo_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum remaining shelf life percentage (of total shelf life) required at the time of shipment to a customer or retailer. Below this threshold, the product is considered non-shippable. Used in Blue Yonder WMS and SAP IBP inventory optimization.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the consumer unit including packaging in kilograms. Used in logistics freight calculation, transportation planning, and customs documentation. Maps to SAP MM material master gross weight field.',
    `gtin` STRING COMMENT 'GS1-standard Global Trade Item Number uniquely identifying the product in global trade. Encompasses UPC-A (12-digit), EAN-13 (13-digit), and ITF-14 (14-digit) formats. Used for barcode scanning, EDI transactions, and retailer product listings.. Valid values are `^[0-9]{8,14}$`',
    `inci_declaration` STRING COMMENT 'Full INCI (International Nomenclature of Cosmetic Ingredients) ingredient list as declared on product packaging, listed in descending order of concentration. Mandatory for cosmetic and personal care products under FDA and EU regulations. Stored in Veeva Vault.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the SKU is classified as a hazardous material requiring special handling, storage, or transportation documentation (e.g., Safety Data Sheet / SDS). Triggers compliance workflows in logistics and warehouse management.',
    `is_recyclable_packaging` BOOLEAN COMMENT 'Indicates whether the primary packaging of the SKU is designed to be recyclable. Used in sustainability reporting, ESG disclosures, and consumer-facing labeling claims per FTC Green Guides.',
    `is_regulated_product` BOOLEAN COMMENT 'Indicates whether the SKU is subject to regulatory approval or registration requirements (e.g., FDA OTC drug, EPA-registered disinfectant, CPSC-regulated product). Triggers regulatory submission workflows in Veeva Vault.',
    `is_sustainable` BOOLEAN COMMENT 'Indicates whether the SKU meets the companys sustainability criteria, such as FSC-certified packaging, RSPO-certified palm oil, or ISO 14001-aligned manufacturing. Used in sustainability reporting and ESG disclosures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SKU master record. Used for change data capture (CDC) in the Databricks Silver Layer pipeline, audit trail, and data quality monitoring.',
    `launch_date` DATE COMMENT 'Date on which the SKU was first commercially available for sale in any market. Used in new product development (NPD) tracking, demand planning baseline establishment, and trade promotion planning.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the SKU in the Product Lifecycle Management (PLM) framework (e.g., concept, development, launch, growth, mature, decline, discontinued). Governs which business processes are active for the SKU. Managed in Veeva Vault PLM. [ENUM-REF-CANDIDATE: concept|development|launch|growth|mature|decline|discontinued — 7 candidates stripped; promote to reference product]',
    `msrp` DECIMAL(18,2) COMMENT 'Manufacturer Suggested Retail Price (MSRP) in the base currency. Represents the recommended consumer selling price (RSP) set by the manufacturer. Used in trade promotion planning (TPM), pricing strategy, and retailer negotiations. Confidential commercial data.',
    `net_content` DECIMAL(18,2) COMMENT 'Numeric net content quantity of the product as declared on packaging (e.g., 500, 1.5, 200). Must be paired with net_content_uom. Regulated by FDA and FTC for accurate labeling. Used in COGS calculation and logistics weight/volume planning.',
    `net_content_uom` STRING COMMENT 'Unit of measure for the net content quantity (e.g., ml, L, g, kg, oz, fl oz, ct). Aligned with GS1 UN/CEFACT unit codes. Required for regulatory labeling compliance and logistics planning. [ENUM-REF-CANDIDATE: ml|L|g|kg|oz|fl oz|ct|units — 8 candidates stripped; promote to reference product]',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content excluding packaging in kilograms. Used in COGS calculation, regulatory labeling, and customs declarations. Maps to SAP MM material master net weight field.',
    `pack_size` STRING COMMENT 'Number of individual consumer units contained within a single sellable pack (e.g., 1 for single unit, 2 for twin pack, 6 for multipack). Used in trade promotion planning (TPM), pricing, and distribution requirements planning (DRP).',
    `packaging_material_type` STRING COMMENT 'Material type of the primary consumer packaging (e.g., plastic, glass, aluminum, paper, cardboard). Used in sustainability reporting, EU REACH compliance, and packaging specification management in Veeva Vault. [ENUM-REF-CANDIDATE: plastic|glass|aluminum|paper|cardboard|composite|biodegradable — 7 candidates stripped; promote to reference product]',
    `portfolio_classification` STRING COMMENT 'Strategic classification of the SKU within the brand portfolio (e.g., core, strategic, tail, innovation, seasonal, limited_edition). Used in S&OP (Sales and Operations Planning) prioritization, resource allocation, and SKU rationalization decisions.. Valid values are `core|strategic|tail|innovation|seasonal|limited_edition`',
    `product_form` STRING COMMENT 'Physical or chemical form of the product (e.g., liquid, powder, gel, cream, spray). Critical for manufacturing process routing in Siemens Opcenter MES, packaging specification, and regulatory classification. [ENUM-REF-CANDIDATE: liquid|powder|gel|cream|foam|spray|bar|tablet|capsule|wipe|stick|sheet — promote to reference product]',
    `product_name` STRING COMMENT 'Full consumer-facing product name as it appears on packaging and in retail listings. Includes brand, variant, and size descriptors (e.g., Brand X Moisturizing Body Wash Fresh Scent 500ml). Used in marketing, trade, and regulatory submissions.',
    `regulatory_category` STRING COMMENT 'Regulatory classification of the SKU determining the applicable regulatory framework and labeling requirements (e.g., cosmetic, OTC drug, household chemical, food). Drives compliance workflows in Veeva Vault and regulatory reporting. [ENUM-REF-CANDIDATE: cosmetic|otc_drug|household_chemical|food|dietary_supplement|medical_device|general_merchandise — 7 candidates stripped; promote to reference product]',
    `scent` STRING COMMENT 'Consumer-facing scent or fragrance descriptor for the SKU (e.g., Fresh, Lavender, Unscented). Relevant for personal care and household products. Used in consumer engagement, marketing, and IFRA fragrance compliance tracking.',
    `short_description` STRING COMMENT 'Abbreviated product description (typically 40–80 characters) used in ERP transactions, warehouse management systems, and EDI communications where full product names are truncated. Maps to SAP MM short text field.',
    `sku_status` STRING COMMENT 'Current operational status of the SKU in the ERP system (SAP S/4HANA material status). Controls whether the SKU can be procured, manufactured, sold, or shipped. blocked prevents all transactions; pending_launch indicates pre-commercialization.. Valid values are `active|inactive|blocked|discontinued|pending_launch`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per consumer unit used for Cost of Goods Sold (COGS) calculation, financial reporting, and profitability analysis. Set annually during standard cost roll in SAP S/4HANA CO. Confidential financial data.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the SKU throughout the supply chain (e.g., ambient, refrigerated, frozen, controlled_temperature). Drives warehouse slotting in Blue Yonder WMS, transportation lane requirements, and regulatory compliance.. Valid values are `ambient|refrigerated|frozen|controlled_temperature|dry|flammable`',
    `sub_brand` STRING COMMENT 'Sub-brand or product line within the parent brand (e.g., Dove Men+Care, Tide PODS). Enables granular brand portfolio analysis and targeted trade promotion management (TPM).',
    `subcategory` STRING COMMENT 'Second-level product classification within the category (e.g., Shampoo, Conditioner, Detergent Pods). Supports granular category management, demand planning in SAP IBP, and retail execution reporting.',
    `target_demographic` STRING COMMENT 'Primary consumer demographic segment this SKU is designed and marketed for (e.g., adult, baby, male, female, professional). Drives consumer segmentation, marketing investment allocation, and shelf placement strategy. [ENUM-REF-CANDIDATE: adult|baby|child|teen|senior|unisex|male|female|professional|family — promote to reference product]',
    `total_shelf_life_days` STRING COMMENT 'Total shelf life of the SKU in days from the date of manufacture to the expiry date as declared on packaging. Used in FEFO (First Expired First Out) inventory management, Blue Yonder WMS configuration, and regulatory compliance.',
    `upc` STRING COMMENT '12-digit Universal Product Code (UPC-A) used primarily in North American retail for point-of-sale scanning and inventory management. Subset of GTIN. Registered with GS1 US.. Valid values are `^[0-9]{12}$`',
    `variant` STRING COMMENT 'Specific variant descriptor distinguishing this SKU from others within the same product line (e.g., Original, Sensitive Skin, Extra Strength, 2-in-1). Used in PLM lifecycle management and consumer segmentation.',
    `volume_ml` DECIMAL(18,2) COMMENT 'Volume of the consumer unit in millilitres, used for liquid and semi-liquid products. Supports logistics cube utilization calculations, warehouse slotting, and transportation planning.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Core master record for every Stock Keeping Unit (SKU) in the CPG/FMCG portfolio. Single source of truth for SKU identity including internal code, description, brand assignment, sub-brand, product form, variant, net content, unit of measure, pack size, launch date, discontinuation date, PLM lifecycle stage, portfolio classification, shelf life attributes (total shelf life, FEFO threshold, storage conditions), and key consumer-facing attributes (scent, color, target demographic). Referenced by all other domains as the authoritative product identifier.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` (
    `gtin_registry_id` BIGINT COMMENT 'Unique surrogate primary key for each GTIN registry record in the Databricks Silver layer. Assigned by the platform upon ingestion from SAP S/4HANA MM or GS1 registration source.',
    `jurisdiction_id` BIGINT COMMENT 'add column jurisdiction_id (BIGINT) with FK to regulatory.jurisdiction.jurisdiction_id - GTINs may be jurisdiction-specific for regulatory compliance',
    `sku_id` BIGINT COMMENT 'Reference to the internal SKU master record to which this GTIN is assigned. A single SKU may have multiple GTINs across packaging hierarchy levels (each, inner pack, case, pallet).',
    `activation_date` DATE COMMENT 'The date on which the GTIN was activated and made available for commercial use, EDI transactions, and retailer catalog publication. May differ from assignment_date when a GTIN is pre-assigned during NPD but activated at product launch.',
    `assignment_date` DATE COMMENT 'The calendar date on which this GTIN was formally assigned to the SKU by the brand owner. Used for GS1 GTIN Management Standard compliance, audit trails, and PLM lifecycle tracking in SAP S/4HANA MM.',
    `barcode_symbology` STRING COMMENT 'The barcode symbology used to encode this GTIN on the physical product or packaging (e.g., UPC-A for consumer units, ITF-14 for cases, GS1-128 for logistic labels). Determines scanner compatibility at POS, warehouse, and DSD delivery points. [ENUM-REF-CANDIDATE: UPC-A|EAN-13|EAN-8|ITF-14|GS1-128|GS1_DataBar|QR_Code — promote to reference product]',
    `brand_name` STRING COMMENT 'The registered brand or trademark name under which the product is marketed to consumers. Used for retailer catalog syndication, Nielsen IQ market measurement reporting, and trade promotion management in Salesforce Consumer Goods Cloud.',
    `brand_owner_gln` STRING COMMENT 'The 13-digit GS1 Global Location Number (GLN) identifying the legal entity that owns the brand and is responsible for the GTIN assignment. Required for GS1 Data Source (1WorldSync/Salsify) product data syndication and retailer onboarding.. Valid values are `^[0-9]{13}$`',
    `cases_per_pallet` STRING COMMENT 'The standard number of cases stacked on one pallet (logistic unit). Used for transportation planning, warehouse slotting in Blue Yonder WMS, and pallet-level GTIN-14 assignment. Drives DRP and S&OP capacity calculations in SAP IBP.',
    `check_digit` STRING COMMENT 'The single trailing check digit of the GTIN, calculated using the GS1 modulo-10 algorithm. Used to validate GTIN integrity during barcode scanning, EDI processing, and retailer catalog ingestion. Stored explicitly to support validation workflows.. Valid values are `^[0-9]{1}$`',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the product was manufactured or substantially transformed. Required for customs declarations, FDA import labeling, FTC country-of-origin rules, and retailer catalog submissions.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GTIN registry record was first created in the system of record. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, SOX compliance, and data lineage tracking.',
    `data_pool_publication_date` DATE COMMENT 'The date on which the product data for this GTIN was first published to the GS1 data pool (GDSN). Used to track compliance with retailer new item setup timelines and GS1 sunrise date requirements.',
    `data_pool_published` BOOLEAN COMMENT 'Indicates whether the full product data record for this GTIN has been published to a GS1-certified data pool (e.g., 1WorldSync, Salsify) for retailer catalog synchronization. True = published and available to subscribers; False = not yet published.',
    `ean_value` DECIMAL(18,2) COMMENT 'The 13-digit EAN-13 barcode value used for international retail scanning and cross-border trade. Populated when gtin_format is GTIN-13. Required for EU, APAC, and LATAM retailer catalog submissions and EDI transactions.',
    `edi_eligible` BOOLEAN COMMENT 'Indicates whether this GTIN is set up and approved for EDI transactions (850 Purchase Order, 856 ASN, 832 Price/Sales Catalog) with trading partners. False when the GTIN is pending retailer item setup or has failed EDI validation. Managed in SAP S/4HANA SD and Oracle Cloud EDI.',
    `gpc_brick_code` STRING COMMENT 'The 8-digit GS1 Global Product Classification (GPC) Brick Code that categorizes the product into a standardized product segment, family, class, and brick. Required for GS1 data pool submissions and used by retailers for category management and planogram (POG) optimization.. Valid values are `^[0-9]{8}$`',
    `gs1_company_prefix` STRING COMMENT 'The GS1-assigned company prefix (6–12 digits) that identifies the brand owner within the GTIN structure. Issued by GS1 US or a GS1 Member Organization. Determines the number of GTINs available to the company and is embedded in every GTIN assigned by the company.. Valid values are `^[0-9]{6,12}$`',
    `gs1_member_org` STRING COMMENT 'The name of the GS1 Member Organization (e.g., GS1 US, GS1 UK, GS1 Germany) through which the company prefix was licensed. Relevant for multi-national CPG companies that hold prefixes from multiple GS1 member organizations across different markets.',
    `gs1_registration_reference` STRING COMMENT 'The reference number or confirmation identifier issued by GS1 (or a GS1 Member Organization) upon formal registration of this GTIN in the GS1 registry. Used for audit, dispute resolution, and regulatory submissions requiring proof of GS1 registration.',
    `gs1_registry_published` BOOLEAN COMMENT 'Indicates whether this GTIN has been published to the GS1 Registry Platform (formerly GEPIR) and is visible to trading partners and retailers for catalog synchronization. True = published; False = not yet published or withheld.',
    `gtin_format` STRING COMMENT 'Identifies the GTIN format variant: GTIN-8 (EAN-8 short barcode), GTIN-12 (UPC-A, North American standard), GTIN-13 (EAN-13, international standard), or GTIN-14 (ITF-14, used for cases and pallets). Determines barcode symbology and EDI transaction set usage.. Valid values are `GTIN-8|GTIN-12|GTIN-13|GTIN-14`',
    `gtin_value` DECIMAL(18,2) COMMENT 'The full numeric GTIN string including the check digit. Supports GTIN-8, GTIN-12 (UPC-A), GTIN-13 (EAN-13), and GTIN-14 (shipping container/case) formats as defined by GS1 General Specifications. Used in barcode scanning, EDI transactions, and retailer catalog synchronization.',
    `indicator_digit` STRING COMMENT 'Single leading digit (0–9) used in GTIN-14 to indicate the packaging level of a trade item. A value of 0 indicates a consumer unit; values 1–8 indicate inner packs or cases; value 9 is reserved for variable-measure trade items. Applicable only when gtin_format is GTIN-14.. Valid values are `^[0-9]{1}$`',
    `inner_packs_per_case` STRING COMMENT 'The number of inner packs (display shippers or multi-packs) contained within one case. Populated only when an intermediate inner-pack packaging level exists in the hierarchy. Used in SAP S/4HANA MM BOM and GS1 packaging hierarchy declarations.',
    `is_consumer_unit` BOOLEAN COMMENT 'Indicates whether this GTIN represents the consumer-facing sellable unit (each/each pack) as opposed to an inner pack, case, or pallet. True = consumer unit eligible for POS scanning; False = logistic/trade unit. Drives OSA monitoring and POS data matching in Nielsen IQ and TradeEdge.',
    `is_orderable` BOOLEAN COMMENT 'Indicates whether this GTIN is currently eligible to be ordered by retail customers via EDI or Salesforce Consumer Goods Cloud order management. False when the GTIN is retired, pending, or restricted to specific channels.',
    `is_scannable` BOOLEAN COMMENT 'Indicates whether a valid, scannable barcode (UPC/EAN/ITF-14) has been verified and approved for this GTIN. False when the barcode artwork is pending verification or has failed GS1 barcode quality verification. Used in retail execution and DSD workflows in Salesforce Consumer Goods Cloud.',
    `is_variable_measure` BOOLEAN COMMENT 'Indicates whether this GTIN represents a variable-measure trade item (e.g., catch-weight products sold by weight). True = variable measure; False = fixed measure. Variable-measure GTINs use indicator digit 9 in GTIN-14 and require special POS and EDI handling per GS1 specifications.',
    `item_reference_number` STRING COMMENT 'The item reference portion of the GTIN, assigned by the brand owner to uniquely identify the product within the company prefix. Together with the company prefix and check digit, it forms the complete GTIN. Sourced from SAP S/4HANA MM material master EAN/UPC segment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this GTIN registry record in the system of record. Used for incremental data loads, change detection, and audit compliance in the Databricks Silver layer.',
    `net_content_uom` STRING COMMENT 'The unit of measure for the net content value (e.g., ml, L, g, kg, oz, fl_oz, ct, ea). Required for FDA label compliance, GS1 data pool submissions, and retailer catalog item setup. Follows GS1 Recommendation on Unit of Measure codes. [ENUM-REF-CANDIDATE: ml|L|g|kg|oz|fl_oz|ct|ea — 8 candidates stripped; promote to reference product]',
    `net_content_value` DECIMAL(18,2) COMMENT 'The numeric net content quantity of the consumer unit (e.g., 400 for a 400ml shampoo bottle). Combined with net_content_uom to express the full net content declaration required on product labels per FDA and FTC labeling regulations.',
    `packaging_level` STRING COMMENT 'Identifies the packaging hierarchy level to which this GTIN is assigned: each (consumer unit), inner pack (multi-pack or display shipper), case (master carton), or pallet (logistic unit). Drives EDI order management, warehouse scanning, and DRP/MRP planning in SAP S/4HANA and Blue Yonder WMS.. Valid values are `each|inner_pack|case|pallet`',
    `plm_lifecycle_stage` STRING COMMENT 'The current PLM lifecycle stage of the product associated with this GTIN: concept, development, commercialization, active (in market), end_of_life (phase-out initiated), or discontinued. Sourced from the PLM system and used to govern GTIN activation, EDI eligibility, and retailer catalog status.. Valid values are `concept|development|commercialization|active|end_of_life|discontinued`',
    `product_category` STRING COMMENT 'The internal product category classification (e.g., Hair Care, Skin Care, Oral Care, Home Care) to which the SKU belongs. Aligns with the companys PLM product hierarchy and Nielsen IQ category definitions for market share reporting.',
    `product_description` STRING COMMENT 'Short consumer-facing product description associated with this GTIN, as published to retailer catalogs and GS1 data pools. Typically includes brand name, product name, variant, and net content (e.g., Brand X Moisturizing Shampoo 400ml). Sourced from SAP S/4HANA MM material description.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the GTIN registration: active (in use and published to trading partners), pending (assigned but not yet published), inactive (temporarily suspended), retired (permanently discontinued), or cancelled (assigned in error and voided). Governs EDI eligibility and retailer catalog synchronization.. Valid values are `active|inactive|pending|retired|cancelled`',
    `retirement_date` DATE COMMENT 'The date on which the GTIN was retired or discontinued from active commercial use. Per GS1 GTIN Management Standard, a retired GTIN must not be reassigned for a minimum of 48 months. Null when the GTIN is still active.',
    `source_system_key` STRING COMMENT 'The natural key or internal identifier of this GTIN record in the originating source system (e.g., SAP material number + EAN category combination). Used for delta-load reconciliation, deduplication, and lineage tracing in the Databricks Silver layer ingestion pipeline.',
    `target_market_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary market for which this GTIN is intended. A single SKU may have different GTINs for different target markets due to regulatory labeling, language, or formulation differences. Used in GS1 data pool syndication and Veeva Vault regulatory submissions.. Valid values are `^[A-Z]{3}$`',
    `units_per_case` STRING COMMENT 'The number of consumer units (eaches) contained within one case (master carton). Used in SAP S/4HANA MM for BOM/packaging hierarchy, DRP/MRP planning, and EDI order quantity validation. Also referenced in Blue Yonder WMS for receiving and putaway.',
    `upc_value` DECIMAL(18,2) COMMENT 'The 12-digit UPC-A barcode value assigned to the consumer unit (each). Derived from the GTIN-12 and used primarily for North American retail POS scanning and retailer item setup. Populated only when gtin_format is GTIN-12.',
    CONSTRAINT pk_gtin_registry PRIMARY KEY(`gtin_registry_id`)
) COMMENT 'Authoritative registry of all GS1-compliant global trade item numbers (GTIN-8, GTIN-12/UPC, GTIN-13/EAN, GTIN-14) assigned to each SKU and its packaging hierarchy levels (each, inner pack, case, pallet). Stores GTIN value, GS1 company prefix, indicator digit, check digit, packaging level, assignment date, status, and GS1 registration reference. Enables barcode scanning, EDI transactions, and retailer catalog synchronization.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each node in the product classification hierarchy. Serves as the primary key for this record in the Silver Layer lakehouse.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hierarchy changes are approved by a designated employee; required for category management reporting.',
    `parent_hierarchy_id` BIGINT COMMENT 'Reference to the immediate parent node in the product hierarchy tree. NULL for root-level nodes (e.g., Division). Enables recursive traversal of the Division → Category → Sub-Category → Brand → Sub-Brand → Product Form → SKU hierarchy.',
    `approved_date` DATE COMMENT 'Date on which this hierarchy node was formally approved by the data steward or product management team. Supports PLM lifecycle governance and audit trail for regulatory submissions.',
    `brand_code` STRING COMMENT 'Code of the Brand-level ancestor node for this hierarchy node. Denormalized to enable brand-level P&L reporting, brand equity tracking, SOV (Share of Voice) analysis, and trade promotion planning at the brand level.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `category_code` STRING COMMENT 'Code of the Category-level ancestor node for this hierarchy node. Denormalized to support category management, trade promotion planning (TPM), and demand forecasting without recursive hierarchy joins.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `channel_applicability` STRING COMMENT 'Distribution channels through which products in this hierarchy node are sold (e.g., Retail, E-Commerce, DTC, Wholesale, DSD). Supports channel management, trade promotion planning, and distribution requirements planning (DRP). [ENUM-REF-CANDIDATE: Retail|E-Commerce|DTC|Wholesale|DSD|Club|Drug — promote to reference product]',
    `consumer_segment` STRING COMMENT 'Primary consumer segment targeted by products in this hierarchy node (e.g., Men 18-35, Families with Children, Premium Skincare Enthusiasts). Used in brand marketing strategy, NPS (Net Promoter Score) analysis, and consumer engagement planning.',
    `cpsc_regulated` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node are subject to CPSC (Consumer Product Safety Commission) regulations. True = product safety testing, labeling, and reporting requirements under CPSA apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the Silver Layer lakehouse. Supports audit trail, data lineage, and compliance with SOX financial data governance requirements.',
    `division_code` STRING COMMENT 'Code of the top-level Division node to which this hierarchy node belongs (e.g., HPC for Home & Personal Care, FOOD for Food & Beverage). Denormalized for fast filtering in OLAP queries and S&OP (Sales and Operations Planning) reporting without full hierarchy traversal.. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_from` DATE COMMENT 'Date from which this hierarchy node became effective and available for use in planning, trade promotion, and reporting systems. Supports temporal validity management and historical hierarchy reconstruction for trend analysis.',
    `effective_until` DATE COMMENT 'Date after which this hierarchy node is no longer active. NULL indicates an open-ended validity. Used for hierarchy versioning, portfolio rationalization, and ensuring discontinued nodes are excluded from forward-looking demand plans.',
    `external_reference_code` STRING COMMENT 'External partner or retailer-specific category code mapped to this hierarchy node (e.g., Walmart category code, Amazon browse node ID). Supports EDI (Electronic Data Interchange) transactions, retailer data synchronization, and VMI (Vendor Managed Inventory) programs.',
    `gmp_standard` STRING COMMENT 'Applicable GMP (Good Manufacturing Practice) standard for manufacturing products in this hierarchy node. Drives quality management requirements in Siemens Opcenter MES and Veeva Vault QMS. ISO 22716 applies to cosmetics; 21 CFR 111 to dietary supplements; 21 CFR 210/211 to pharmaceuticals.. Valid values are `ISO 22716|GMP 21 CFR 111|GMP 21 CFR 210|GMP 21 CFR 211|OSHA|None`',
    `gpc_brick_code` STRING COMMENT 'GS1 Global Product Classification (GPC) brick-level code (8-digit numeric) aligned to this hierarchy node. Enables cross-industry product classification interoperability, EDI transactions, and retailer data synchronization via GS1 standards.. Valid values are `^[0-9]{8}$`',
    `gpc_brick_name` STRING COMMENT 'Descriptive name of the GS1 GPC brick code associated with this hierarchy node (e.g., Shampoo/Conditioner - Non-Medicated). Supports regulatory submissions, retailer onboarding, and GS1 data pool synchronization.',
    `ibp_planning_level` BOOLEAN COMMENT 'Indicates whether this hierarchy node is a designated planning level in SAP IBP (Integrated Business Planning) for demand forecasting and S&OP (Sales and Operations Planning). True = this node is an active planning aggregation point.',
    `inci_applicable` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node require INCI (International Nomenclature of Cosmetic Ingredients) ingredient declaration on labeling. True = cosmetic/personal care products subject to EU Cosmetics Regulation and FDA cosmetic labeling requirements.',
    `iri_category_code` STRING COMMENT 'IRI (now Circana) proprietary category code mapped to this hierarchy node. Supports market share reporting, TDP (Total Distribution Points) analysis, and SOM (Share of Market) calculations using IRI syndicated data.',
    `is_leaf_node` BOOLEAN COMMENT 'Indicates whether this node is a terminal leaf in the hierarchy (True = no children exist, typically the SKU level). Used to filter for assignable product nodes in demand forecasting, inventory management, and trade promotion planning.',
    `language_code` STRING COMMENT 'ISO 639-1 language code for the node_name and node_description fields (e.g., en, fr, de, es). Supports multi-language product hierarchy management for global CPG/FMCG operations and localized reporting.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this node within the product classification hierarchy. Level 1 = Division, Level 2 = Category, Level 3 = Sub-Category, Level 4 = Brand, Level 5 = Sub-Brand, Level 6 = Product Form, Level 7 = SKU (Stock Keeping Unit). Used for OLAP drill-down and aggregation logic.',
    `level_name` STRING COMMENT 'Business label for the hierarchy depth of this node. Enumerated values correspond to the CPG/FMCG standard classification spine: Division, Category, Sub-Category, Brand, Sub-Brand, Product Form, SKU (Stock Keeping Unit). Drives display logic in reporting tools and S&OP dashboards. [ENUM-REF-CANDIDATE: Division|Category|Sub-Category|Brand|Sub-Brand|Product Form|SKU — 7 candidates stripped; promote to reference product]',
    `market_share_reportable` BOOLEAN COMMENT 'Indicates whether this hierarchy node is included in external market share reporting via Nielsen IQ or IRI/Circana syndicated data. True = node is mapped to a syndicated data category for SOM (Share of Market) and ACV (All Commodity Volume) reporting.',
    `nielsen_category_code` STRING COMMENT 'Nielsen IQ proprietary category code mapped to this hierarchy node. Enables direct linkage between internal product classification and Nielsen IQ retail measurement data for market share reporting, ACV (All Commodity Volume) analysis, and competitive benchmarking.',
    `node_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this hierarchy node within its level. Used as the business key in SAP S/4HANA MM product group structures and referenced in EDI transactions and trade promotion planning systems.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `node_description` STRING COMMENT 'Extended business description of the hierarchy node providing additional context about the product grouping, its scope, and intended use in classification. Supports regulatory categorization and PLM documentation.',
    `node_name` STRING COMMENT 'Human-readable business name of this hierarchy node (e.g., Personal Care, Shampoo, Head & Shoulders, Classic Clean). Used in OLAP drill-down reports, trade promotion planning, and market share dashboards.',
    `node_status` STRING COMMENT 'Current lifecycle status of this hierarchy node. active nodes are available for use in planning, trade promotion, and reporting. discontinued nodes are retained for historical analysis. pending nodes are awaiting approval in the PLM (Product Lifecycle Management) workflow.. Valid values are `active|inactive|pending|discontinued|archived`',
    `path` STRING COMMENT 'Materialized full path string from root to this node using a delimiter (e.g., Consumer Goods / Personal Care / Hair Care / Shampoo / Head & Shoulders / Classic Clean). Enables fast string-based filtering and display in BI tools without recursive joins.',
    `plm_lifecycle_stage` STRING COMMENT 'Current stage of the product node in the PLM (Product Lifecycle Management) lifecycle. Drives NPD (New Product Development) workflows, portfolio rationalization decisions, and demand planning assumptions in SAP IBP. [ENUM-REF-CANDIDATE: concept|development|launch|growth|mature|decline|discontinued — 7 candidates stripped; promote to reference product]',
    `profit_center_code` STRING COMMENT 'SAP CO profit center code associated with this hierarchy node for P&L attribution. Enables EBITDA (Earnings Before Interest, Taxes, Depreciation, and Amortization) reporting and COGS (Cost of Goods Sold) allocation at the product hierarchy level.',
    `reach_regulated` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node are subject to EU REACH Regulation (Registration, Evaluation, Authorisation and Restriction of Chemicals). True = chemical substance registration and SDS (Safety Data Sheet) requirements apply.',
    `regulatory_framework` STRING COMMENT 'Identifies the primary regulatory framework governing products classified under this hierarchy node (e.g., FDA OTC Drug, FDA Cosmetic, EPA Pesticide, CPSC Consumer Product, EU Cosmetics Regulation). Drives compliance workflows in Veeva Vault and regulatory labeling requirements. [ENUM-REF-CANDIDATE: FDA OTC Drug|FDA Cosmetic|EPA Pesticide|CPSC Consumer Product|EU Cosmetics Regulation|REACH|ISO 22716|IFRA — promote to reference product]',
    `sort_order` STRING COMMENT 'Numeric sequence controlling the display order of sibling nodes within the same parent. Used to enforce business-defined ordering in planograms (POG), category management reports, and trade promotion planning interfaces.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this hierarchy node was sourced (e.g., SAP S/4HANA MM, Veeva Vault PLM, Salesforce Consumer Goods Cloud). Supports data lineage tracking and Silver Layer reconciliation in the Databricks Lakehouse. [ENUM-REF-CANDIDATE: SAP_S4|ORACLE_ERP|VEEVA|SALESFORCE_CGC|SAP_IBP|NIELSEN|MANUAL — 7 candidates stripped; promote to reference product]',
    `source_system_node_code` STRING COMMENT 'Native identifier of this hierarchy node in the originating operational system (e.g., SAP product hierarchy node ID, Veeva Vault record ID). Enables reverse traceability from the Silver Layer back to the system of record for reconciliation and audit.',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node carry a sustainability certification (e.g., FSC, RSPO, ISO 14001). Supports ESG reporting, sustainable sourcing procurement decisions, and consumer-facing sustainability claims.',
    `tax_category_code` STRING COMMENT 'Tax classification code assigned to this hierarchy node for VAT/GST determination in SAP S/4HANA FI/CO. Drives correct tax treatment in sales orders, invoicing, and financial reporting across jurisdictions.',
    `trade_promotion_eligible` BOOLEAN COMMENT 'Indicates whether products under this hierarchy node are eligible for trade promotion activities (TPM/TPO). Drives eligibility rules in Salesforce Consumer Goods Cloud Trade Promotion Management and ROI (Return on Investment) reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this hierarchy node record in the Silver Layer. Used for incremental data pipeline processing, change data capture, and audit trail maintenance.',
    `version_number` STRING COMMENT 'Monotonically incrementing version counter for this hierarchy node record. Incremented each time the node definition is materially changed (e.g., reclassification, rename, regulatory framework update). Supports SCD Type 2 history management and audit compliance.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the multi-level product classification hierarchy used across the CPG portfolio: Division → Category → Sub-Category → Brand → Sub-Brand → Product Form → SKU. Each node carries hierarchy level code, node name, parent node reference, sort order, active flag, GPC brick code alignment, Nielsen/IRI category code mapping, and applicable regulatory framework. Serves as the single authoritative classification backbone for OLAP drill-down, trade promotion planning, demand forecasting, market share reporting, and regulatory categorization.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` (
    `product_bom_id` BIGINT COMMENT 'Unique surrogate identifier for the Bill of Materials (BOM) header record in the Databricks Silver Layer. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: BOM release requires employee approval; tracked for manufacturing release and change control.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production site that owns this BOM. BOMs in SAP are plant-specific; the same material may have different BOMs per plant reflecting local sourcing or production capabilities.',
    `sku_id` BIGINT COMMENT 'Reference to the finished good or semi-finished SKU for which this BOM is defined. Links to the product master (material master in SAP). A single SKU may have multiple BOMs of different types.',
    `alternative_bom` STRING COMMENT 'Alternative BOM identifier (SAP STLAL) allowing multiple BOM variants for the same material and plant combination. Used to manage seasonal formulations, regional variants, or cost-optimized alternatives within the same SKU.',
    `approved_date` DATE COMMENT 'Date on which this BOM was formally approved for production use. Part of the GMP and PLM audit trail. Required for regulatory submissions and quality management documentation.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity of the finished or semi-finished material for which the BOM component quantities are specified. All component quantities in BOM line items are expressed relative to this base quantity. Typically 1 or 100 in CPG manufacturing.',
    `base_uom` STRING COMMENT 'Unit of measure for the BOM base quantity (e.g., KG, L, EA, G). Defines the unit in which the finished good is expressed for component ratio calculations. Aligns with SAP base unit of measure (MARA-MEINS) and GS1 unit codes.',
    `bom_category` STRING COMMENT 'SAP BOM category indicating the object type the BOM is assigned to. material is the standard category for product BOMs in CPG/FMCG. equipment and functional_location apply to plant maintenance BOMs. Aligns with SAP STKO-STLTY.. Valid values are `material|equipment|functional_location|document`',
    `bom_description` STRING COMMENT 'Human-readable description of the BOM, typically including the product name, formulation variant, and intended use. Used in PLM, engineering change orders, and regulatory documentation.',
    `bom_level` STRING COMMENT 'Indicates the level of the BOM in a multi-level product structure. Level 0 is the finished good, level 1 represents direct components, level 2 represents sub-components, etc. Used for multi-level BOM explosion in MRP and costing roll-ups.',
    `bom_number` STRING COMMENT 'Externally-known BOM document number as assigned in SAP S/4HANA PP/MM (e.g., SAP BOM header number). This is the business-facing identifier used in PLM, procurement, and manufacturing communications.',
    `bom_type` STRING COMMENT 'Classifies the purpose of the BOM. production is used for manufacturing execution (MRP/MES), costing for COGS and standard cost roll-up, engineering for R&D and NPD design, sales for variant configuration, configurable for multi-variant BOMs. Aligns with SAP BOM usage (STLAL).. Valid values are `production|costing|engineering|sales|configurable`',
    `change_number` STRING COMMENT 'Engineering Change Number (ECN) or Engineering Change Order (ECO) reference that authorized the creation or modification of this BOM version. Provides traceability from BOM changes back to the formal change management process in PLM.',
    `component_count` STRING COMMENT 'Total number of active component line items in this BOM. Provides a quick indicator of BOM complexity and is used in BOM completeness validation checks during PLM review and quality audits.',
    `costing_relevance` STRING COMMENT 'Indicates whether this BOM is relevant for product costing (COGS calculation and standard cost roll-up). relevant means the BOM is included in cost estimates, not_relevant excludes it, conditional applies under specific costing scenarios. Critical for financial reporting and EBITDA analysis.. Valid values are `relevant|not_relevant|conditional`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the source system (SAP S/4HANA). Provides the audit trail creation marker required for GMP, SOX, and ISO 9001 compliance.',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this BOM has been flagged for deletion in SAP. A deletion flag marks the BOM as logically deleted without physically removing the record, preserving audit history. Aligns with SAP STKO-LOEKZ.',
    `effective_from` DATE COMMENT 'The date from which this BOM version is valid and can be used for production planning, MRP, and costing. Supports time-phased BOM management for seasonal reformulations, ingredient substitutions, or regulatory-driven changes.',
    `effective_until` DATE COMMENT 'The date until which this BOM version is valid. Null indicates an open-ended validity. Used to manage BOM version transitions during reformulations, regulatory updates, or product discontinuations.',
    `formulation_code` STRING COMMENT 'R&D or regulatory formulation code that uniquely identifies the product formula associated with this BOM. Links the manufacturing BOM to the R&D formulation record in Veeva Vault or PLM system. Critical for INCI ingredient declaration and regulatory submissions.',
    `gmp_compliant` BOOLEAN COMMENT 'Indicates whether this BOM has been validated as compliant with Good Manufacturing Practice (GMP) standards. Required for health, hygiene, and personal care products. Compliance is verified during quality review before BOM activation.',
    `is_configurable` BOOLEAN COMMENT 'Indicates whether this BOM supports variant configuration, allowing different component selections based on product characteristics (e.g., fragrance variant, pack size). Used for configurable products in CPG where a single BOM covers multiple SKU variants.',
    `is_phantom` BOOLEAN COMMENT 'Indicates whether this BOM represents a phantom assembly — a logical grouping of components that does not physically exist as a stocked item but is used to simplify BOM structures. Phantom assemblies are exploded through in MRP without generating production orders.',
    `last_changed_by` STRING COMMENT 'User ID or name of the person who last modified this BOM record. Part of the change audit trail required for GMP, engineering change management, and SOX compliance.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this BOM record in the source system. Used for incremental data loading, change detection, and audit trail maintenance.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'Minimum lot size for which this BOM is valid. BOMs can be lot-size dependent in process manufacturing, where component quantities vary based on batch size. Used in conjunction with lot_size_to to define the valid production quantity range.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'Maximum lot size for which this BOM is valid. Defines the upper bound of the production quantity range for lot-size-dependent BOMs. Null indicates no upper limit.',
    `lot_size_uom` STRING COMMENT 'Unit of measure for the lot size range (lot_size_from and lot_size_to). Typically matches the base UOM of the finished good (e.g., KG, L, EA).',
    `material_number` STRING COMMENT 'SAP material number (MATNR) of the finished good or semi-finished product for which this BOM is defined. This is the externally-known product code used across SAP modules (MM, PP, SD, CO) and in EDI transactions with trading partners.',
    `mrp_relevance` BOOLEAN COMMENT 'Indicates whether this BOM is used in Material Requirements Planning (MRP) runs for procurement and production scheduling. When true, MRP will explode this BOM to generate dependent requirements for components and raw materials.',
    `notes` STRING COMMENT 'Free-text notes or comments associated with this BOM header, capturing manufacturing instructions, formulation rationale, regulatory notes, or change justifications that do not fit structured fields. Sourced from SAP BOM header long text.',
    `plant_code` STRING COMMENT 'Four-character SAP plant code identifying the manufacturing facility or production site where this BOM is applicable. Used in MRP, production orders, and supply chain planning (SAP IBP).',
    `plm_status` STRING COMMENT 'Current lifecycle state of the BOM as managed in the PLM process. draft indicates initial creation, in_review is under engineering/regulatory review, approved is signed off but not yet released to production, active is in use for manufacturing, obsolete is retired, superseded has been replaced by a newer BOM version.. Valid values are `draft|in_review|approved|active|obsolete|superseded`',
    `production_version` STRING COMMENT 'SAP production version identifier (MKAL-VERID) that links this BOM to a specific routing/recipe and production line. A material may have multiple production versions representing different manufacturing processes or lines at the same plant.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether all chemical substances in this BOM are compliant with EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) regulation. Mandatory for products sold in the European Union.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for this BOM/formulation. Indicates whether the ingredient composition has been reviewed and approved by relevant regulatory bodies (FDA, EU REACH, CPSC). Required before a BOM can be released to active production status.. Valid values are `pending|approved|conditionally_approved|rejected|not_required`',
    `rspo_certified` BOOLEAN COMMENT 'Indicates whether palm oil or palm-derived ingredients in this BOM are sourced from RSPO-certified sustainable sources. Relevant for personal care and household products containing palm oil derivatives. Supports sustainability reporting.',
    `source_system_bom_code` STRING COMMENT 'The native primary key or document number of this BOM record in the originating source system (e.g., SAP internal BOM header key combining MATNR+WERKS+STLAL+STLAN). Enables traceability back to the system of record.',
    `version` STRING COMMENT 'Version or revision identifier for the BOM document, enabling traceability of formulation changes over time. Incremented when ingredient quantities, component substitutions, or structural changes are made. Critical for regulatory submissions and GMP compliance.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this BOM record in SAP S/4HANA or the PLM system. Part of the mandatory audit trail for GMP and SOX compliance.',
    CONSTRAINT pk_product_bom PRIMARY KEY(`product_bom_id`)
) COMMENT 'Bill of Materials (BOM) header record defining the complete ingredient and component structure for a finished good or semi-finished SKU. Captures BOM number, BOM type (production, costing, engineering), base quantity, unit of measure, effective date range, PLM status, and the owning plant or production site. Links to BOM line items for individual component details. Sourced from SAP S/4HANA PP/MM modules.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual component line within a Bill of Materials. Primary key for this entity. Role: TRANSACTION_LINE.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility for which this BOM line is defined. BOM structures can vary by plant due to local sourcing, equipment capabilities, or regulatory requirements.',
    `product_bom_id` BIGINT COMMENT 'Reference to the parent Bill of Materials header that this line belongs to. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `sku_id` BIGINT COMMENT 'Reference to the master product/material record for the component (raw material, packaging component, or sub-assembly) required on this BOM line. Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category.',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred or approved supplier for this component. Used in procurement planning and source list determination during MRP runs. Supports VMI (Vendor Managed Inventory) and MOQ (Minimum Order Quantity) management.',
    `alternative_item_group` STRING COMMENT 'Groups multiple BOM lines that are interchangeable alternatives for the same component requirement. All lines sharing the same group code can substitute for one another, enabling flexible sourcing and production planning.',
    `alternative_priority` STRING COMMENT 'Numeric priority rank within an alternative item group, determining the preferred order of substitution when multiple alternatives exist. Lower numbers indicate higher preference (e.g., 1 = first choice).',
    `bom_item_category` STRING COMMENT 'SAP BOM item category code that controls how the component is procured and managed. Determines whether the item is stocked, non-stocked, variable-size, or a document/text item. [ENUM-REF-CANDIDATE: stock|non_stock|variable_size|document|text|class — promote to reference product]. Valid values are `stock|non_stock|variable_size|document|text|class`',
    `bulk_material_flag` BOOLEAN COMMENT 'Indicates whether this component is a bulk material that is not individually picked or issued but is consumed from a bulk supply point on the shop floor. Bulk materials are typically excluded from individual goods issue postings.',
    `change_number` STRING COMMENT 'The Engineering Change Number (ECN) or Engineering Change Order (ECO) that authorized the creation or modification of this BOM line. Provides traceability to the formal change management process in PLM.',
    `co_product_flag` BOOLEAN COMMENT 'Indicates whether this BOM line represents a co-product or by-product that is produced alongside the primary output. Co-products have positive quantities and receive a portion of the production cost allocation.',
    `component_cost_usd` DECIMAL(18,2) COMMENT 'The standard cost per unit of measure for this component in USD, used for COGS (Cost of Goods Sold) calculation and product costing. Sourced from the material master standard price or moving average price.',
    `component_description` STRING COMMENT 'Human-readable description of the component material, such as HDPE Bottle 500ml Natural or Fragrance Blend XY-204. Used in procurement, quality, and manufacturing documentation.',
    `component_item_number` STRING COMMENT 'The externally-known material or item number for the component as defined in the ERP system (e.g., SAP material number). Used for cross-system referencing and procurement planning.',
    `component_type` STRING COMMENT 'Classification of the component indicating its role in the manufacturing process. Drives MRP planning logic and COGS categorization. [ENUM-REF-CANDIDATE: raw_material|packaging|semi_finished|finished_good|co_product|by_product — promote to reference product]. Valid values are `raw_material|packaging|semi_finished|finished_good|co_product|by_product`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this BOM line record was first created in the system. Used for audit trail, data lineage, and change management tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the component cost value (e.g., USD, EUR, GBP). Enables multi-currency COGS reporting for global manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `fixed_quantity_flag` BOOLEAN COMMENT 'Indicates whether the component quantity is fixed regardless of the parent order quantity (True) or scales proportionally with the production order size (False). Fixed quantities are common for setup materials, catalysts, or tooling items.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this component is classified as a hazardous material under applicable regulations (e.g., OSHA HazCom, EU CLP, DOT). Triggers special handling, storage, and transportation requirements and SDS documentation.',
    `inci_name` STRING COMMENT 'The standardized INCI (International Nomenclature of Cosmetic Ingredients) name for this component when used in personal care or cosmetic formulations. Required for regulatory ingredient labeling compliance on finished product packaging.',
    `is_alternative_item` BOOLEAN COMMENT 'Indicates whether this BOM line represents an alternative or substitute component that can be used in place of the primary component. Alternative items are used when the primary component is unavailable, supporting supply continuity.',
    `is_critical_component` BOOLEAN COMMENT 'Indicates whether this component is designated as critical to the production of the parent SKU. Critical components trigger priority procurement actions and are subject to enhanced supply chain monitoring and safety stock policies.',
    `issue_method` STRING COMMENT 'The method by which this component is issued from inventory to the production order. Backflush automatically posts consumption upon order confirmation; manual requires explicit goods issue; pick list generates a picking document; kanban uses replenishment signals.. Valid values are `backflush|manual|pick_list|kanban`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this BOM line record was most recently updated. Used for change detection, data synchronization, and audit trail purposes in the Silver Layer lakehouse.',
    `lead_time_offset_days` STRING COMMENT 'The number of days before or after the parent order start date that this component must be available. Positive values indicate the component is needed before production start; negative values indicate it is needed after. Used in MRP scheduling.',
    `line_number` STRING COMMENT 'Sequential position number of this component line within the parent BOM, used for ordering and referencing individual line items. Satisfies TRANSACTION_LINE LINE_SEQUENCE category. Corresponds to SAP BOM item number (POSNR).',
    `line_status` STRING COMMENT 'Current lifecycle status of this BOM line item. Controls whether the component is included in active MRP runs and procurement planning. Inactive or obsolete lines are retained for historical traceability.. Valid values are `active|inactive|pending_approval|obsolete|under_review`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity of this component that must be ordered from the supplier in a single purchase order. Used in procurement planning to ensure order quantities meet supplier MOQ (Minimum Order Quantity) requirements.',
    `operation_number` BIGINT COMMENT 'Reference to the specific production routing operation or work center step at which this component is consumed. Enables precise material staging and backflushing in the MES and MRP systems.',
    `phantom_item_flag` BOOLEAN COMMENT 'Indicates whether this BOM line represents a phantom assembly — a logical grouping of components that is not physically stocked or produced as a discrete item but is exploded through in MRP planning.',
    `reach_registration_number` STRING COMMENT 'The EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) registration number for this chemical component. Required for substances manufactured or imported into the EU above threshold quantities.',
    `recursive_bom_flag` BOOLEAN COMMENT 'Indicates whether this component itself has a subordinate BOM (i.e., it is a sub-assembly or semi-finished good with its own BOM structure). Used to identify multi-level BOM explosion requirements in MRP planning.',
    `required_quantity` DECIMAL(18,2) COMMENT 'The quantity of the component required to produce one unit of the parent SKU at the base quantity defined in the BOM header. Satisfies TRANSACTION_LINE LINE_QUANTITY category. Supports MRP and COGS calculation.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'The expected percentage of this component that will be lost or wasted during the manufacturing process. Used to inflate the planned component quantity in MRP runs and COGS calculations. Expressed as a percentage (e.g., 2.5 = 2.5%).',
    `sds_document_number` STRING COMMENT 'The document number or reference identifier for the Safety Data Sheet (SDS) associated with this hazardous component. Links to the SDS stored in Veeva Vault or the document management system for regulatory compliance.',
    `source_system_code` STRING COMMENT 'Identifier for the operational system of record from which this BOM line was sourced (e.g., SAP_S4HANA, ORACLE_ERP). Supports data lineage tracking and multi-system reconciliation in the Databricks Silver Layer.',
    `storage_location` STRING COMMENT 'The designated warehouse storage location or bin where this component is staged for production consumption. Used by WMS and MES for material staging, goods issue, and FEFO/FIFO inventory management.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the required quantity of the component (e.g., KG, L, EA, M, G). Must align with the component material master UOM. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT category (measurement dimension).',
    `usage_probability_pct` DECIMAL(18,2) COMMENT 'The probability (expressed as a percentage, 0–100) that this alternative component will actually be used in production. Used by MRP to calculate weighted component requirements across alternative item groups.',
    `valid_from_date` DATE COMMENT 'The date from which this BOM line is effective and should be included in production and MRP planning. Supports date-effective BOM management for product reformulations and packaging changes.',
    `valid_to_date` DATE COMMENT 'The date after which this BOM line is no longer effective and should be excluded from production and MRP planning. Null indicates the line is open-ended with no planned expiry.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual component line within a Bill of Materials, specifying each raw material, packaging component, or sub-assembly required to produce the parent SKU. Attributes include component item number, component description, component type (raw material, packaging, semi-finished), required quantity, unit of measure, scrap percentage, lead time offset, and whether the component is a critical or alternative item. Supports MRP, COGS calculation, and procurement planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` (
    `product_formulation_id` BIGINT COMMENT 'Unique surrogate identifier for the formulation master record in the Databricks Silver Layer. Primary key for all downstream joins and lineage tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Formulation approval must be signed off by a qualified employee for GMP compliance.',
    `research_formulation_id` BIGINT COMMENT 'Foreign key linking to research.research_formulation. Business justification: Provides audit trail from final product formulation back to its research formulation for change management and compliance reporting.',
    `sds_id` BIGINT COMMENT 'Reference identifier for the Safety Data Sheet (SDS) document associated with this formulation, stored in Veeva Vault. Required under OSHA Hazard Communication Standard (HazCom) and EU REACH for hazardous substances.',
    `active_ingredient_name` STRING COMMENT 'Name of the primary active ingredient in the formulation (e.g., Salicylic Acid, Zinc Pyrithione, Fluoride). Required for OTC drug product regulatory filings with FDA and for consumer-facing efficacy claims.',
    `active_ingredient_pct` DECIMAL(18,2) COMMENT 'Concentration of the primary active ingredient expressed as a weight percentage (w/w%) of the total formulation. Proprietary trade secret data. Governs regulatory classification (OTC drug vs. cosmetic), label claims, and dosage compliance.',
    `allergen_declaration` STRING COMMENT 'Free-text or structured declaration of regulated allergens present in the formulation above threshold concentrations (e.g., EU 26 listed fragrance allergens, FDA major food allergens for food-contact products). Required for consumer safety labeling.',
    `approval_date` DATE COMMENT 'Calendar date on which the formulation received final commercial approval in the PLM system. Marks the transition from regulatory review to approved lifecycle stage and triggers manufacturing authorization.',
    `bom_reference_code` STRING COMMENT 'Reference code linking this formulation to the corresponding Bill of Materials (BOM) in SAP S/4HANA PP/MM. Enables traceability between the approved formulation recipe and the manufacturing BOM used for production planning and Material Requirements Planning (MRP).. Valid values are `^[A-Z0-9-]{4,30}$`',
    `color_description` STRING COMMENT 'Standardized color description of the finished formulation as specified in the quality standard (e.g., White to off-white, Clear colorless, Pale yellow). Used in visual QC inspection and consumer safety documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulation record was first created in the source PLM system (Veeva Vault). Provides audit trail for formulation lifecycle tracking and regulatory inspection readiness.',
    `effective_date` DATE COMMENT 'Date from which this formulation version is authorized for use in commercial manufacturing. May differ from approval_date when a transition period is required to consume existing raw material stocks.',
    `formulation_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the formulation within the Product Lifecycle Management (PLM) system. Sourced from Veeva Vault PLM and used as the cross-system business key across SAP S/4HANA QM and Siemens Opcenter MES.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `formulation_name` STRING COMMENT 'Human-readable descriptive name of the formulation as registered in the PLM system (e.g., Moisturizing Body Lotion Base v2 - Fragrance Free). Used in regulatory submissions, quality documents, and R&D reporting.',
    `formulation_type` STRING COMMENT 'Physical form classification of the formulation describing its physicochemical structure. Drives manufacturing process selection, packaging requirements, and stability testing protocols. [ENUM-REF-CANDIDATE: emulsion|solution|suspension|gel|powder|foam|aerosol|solid — 8 candidates stripped; promote to reference product]',
    `fragrance_code` STRING COMMENT 'Proprietary or supplier-assigned code identifying the fragrance ingredient blend used in this formulation. Required for IFRA compliance assessment, allergen declaration, and INCI ingredient listing on product labels.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the formulation has been developed and validated in compliance with Good Manufacturing Practice (GMP) standards. Required for commercial manufacturing authorization and regulatory audit readiness.',
    `inci_declaration` STRING COMMENT 'Full International Nomenclature of Cosmetic Ingredients (INCI) ingredient list for the formulation in descending order of concentration, as required for product label compliance. Sourced from Veeva Vault regulatory submissions.',
    `intended_use` STRING COMMENT 'Declared intended use or application of the formulation (e.g., Rinse-off body wash for daily use, Leave-on facial moisturizer, Hard surface disinfectant cleaner). Determines regulatory classification pathway and labeling requirements.',
    `is_cruelty_free` BOOLEAN COMMENT 'Indicates whether the formulation and its constituent ingredients have not been tested on animals. Supports cruelty-free certification claims and compliance with EU animal testing ban under Cosmetics Regulation 1223/2009.',
    `is_fragrance_free` BOOLEAN COMMENT 'Indicates whether the formulation contains no added fragrance ingredients. Drives consumer-facing label claims, regulatory declarations, and product positioning for sensitive-skin or hypoallergenic product lines.',
    `is_vegan` BOOLEAN COMMENT 'Indicates whether the formulation contains no animal-derived ingredients or by-products. Supports consumer-facing vegan label claims and retailer listing requirements for vegan-certified product ranges.',
    `lab_notebook_reference` STRING COMMENT 'Reference identifier for the electronic laboratory notebook (ELN) entry or physical lab notebook record documenting the original formulation development experiments. Provides scientific traceability for regulatory submissions and IP protection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this formulation record in the source PLM system. Used for incremental data loading, change detection, and audit trail maintenance in the Databricks Silver Layer.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the formulation in the Product Lifecycle Management (PLM) workflow, from initial lab development through commercial approval and eventual obsolescence. Governs which business processes may consume this formulation record.. Valid values are `lab_development|pilot|stability_testing|regulatory_review|approved|obsolete`',
    `obsolescence_date` DATE COMMENT 'Date on which this formulation version was or is scheduled to be retired and replaced by a newer version. Null for currently active formulations. Used in manufacturing planning to manage version transitions.',
    `ph_max` DECIMAL(18,2) COMMENT 'Maximum acceptable pH value of the formulation as defined in the approved specification. Together with ph_min, defines the pH range tolerance band for quality control (QC) release testing and in-process checks.',
    `ph_min` DECIMAL(18,2) COMMENT 'Minimum acceptable pH value of the formulation as defined in the approved specification. Used in quality control (QC) testing and stability assessments. pH range is a critical quality attribute (CQA) for consumer safety and product efficacy.',
    `preservative_system` STRING COMMENT 'Description or code identifying the preservative system used in the formulation (e.g., Phenoxyethanol/Ethylhexylglycerin, Benzalkonium Chloride, Paraben-free system). Critical for regulatory compliance, challenge testing, and consumer safety claims.',
    `product_category` STRING COMMENT 'High-level consumer goods product category to which this formulation belongs (e.g., Personal Care, Household Cleaning, Health & Hygiene, Baby Care, Oral Care). Drives regulatory framework selection and INCI declaration requirements. [ENUM-REF-CANDIDATE: personal_care|household_cleaning|health_hygiene|baby_care|oral_care|hair_care|skin_care|fabric_care — promote to reference product]',
    `rd_project_code` STRING COMMENT 'Reference code linking this formulation to the originating Research and Development (R&D) / New Product Development (NPD) project in the PLM system. Enables traceability from commercial formulation back to the innovation pipeline.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `reach_registration_number` STRING COMMENT 'European Chemicals Agency (ECHA) registration number assigned under EU REACH Regulation for substances manufactured or imported above 1 tonne per year. Required for market access in the European Union.. Valid values are `^d{2}-d{10}-d{2}-d{4}$`',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status of the formulation as assessed against applicable jurisdictional requirements (FDA, EU REACH, CPSC). Determines whether the formulation may be used in commercial manufacturing. Distinct from internal PLM lifecycle stage.. Valid values are `pending|approved|conditionally_approved|rejected|withdrawn`',
    `regulatory_classification` STRING COMMENT 'Regulatory product classification determining the applicable compliance framework and submission pathway. Drives FDA, EPA, or CPSC filing requirements and labeling obligations.. Valid values are `cosmetic|otc_drug|household_chemical|biocide|medical_device|food_contact`',
    `rspo_certified` BOOLEAN COMMENT 'Indicates whether palm oil or palm-derived ingredients in this formulation are sourced from Roundtable on Sustainable Palm Oil (RSPO) certified supply chains. Supports sustainability reporting and retailer ESG requirements.',
    `source_system_code` STRING COMMENT 'Native record identifier of this formulation in the originating source system (Veeva Vault PLM). Enables bidirectional traceability between the Databricks Silver Layer and the system of record for reconciliation and audit purposes.. Valid values are `^[A-Z0-9-_]{2,50}$`',
    `stability_period_months` STRING COMMENT 'Approved shelf-life stability period of the formulation expressed in months, as determined by accelerated and real-time stability studies. Drives product expiry date calculation, FEFO inventory management, and label best before declarations.',
    `storage_condition` STRING COMMENT 'Specified storage conditions required to maintain formulation integrity and stability (e.g., Store below 25°C, away from direct sunlight, Refrigerate at 2-8°C). Used in warehouse management (WMS), logistics planning, and label compliance.',
    `total_solid_content_pct` DECIMAL(18,2) COMMENT 'Total solid content of the formulation expressed as weight percentage (w/w%). Key physical property used in manufacturing process design, packaging compatibility assessment, and stability testing protocols.',
    `version_number` STRING COMMENT 'Version identifier of the formulation record following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Each approved change to the formulation recipe increments the version. Enables full formulation lifecycle traceability from lab development through commercial approval.. Valid values are `^d+.d+(.d+)?$`',
    `viscosity_max_cps` DECIMAL(18,2) COMMENT 'Maximum acceptable viscosity of the formulation measured in centipoise (cPs) at the specified test temperature. Together with viscosity_min_cps, defines the viscosity tolerance band for quality control (QC) release and in-process testing.',
    `viscosity_min_cps` DECIMAL(18,2) COMMENT 'Minimum acceptable viscosity of the formulation measured in centipoise (cPs) at the specified test temperature. Critical quality attribute (CQA) governing product texture, pourability, and consumer experience. Used in QC release testing.',
    CONSTRAINT pk_product_formulation PRIMARY KEY(`product_formulation_id`)
) COMMENT 'Formulation master record capturing the approved chemical or ingredient recipe for a consumer goods product (household, personal care, health, or hygiene). Stores formulation code, version number, formulation name, product category, regulatory approval status, pH range, viscosity, color, fragrance code, preservative system, and the R&D project reference. Tracks the full formulation lifecycle from lab development through commercial approval. Sourced from Veeva Vault PLM.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` (
    `product_formulation_ingredient_id` BIGINT COMMENT 'Unique surrogate identifier for each ingredient line within a formulation record. Primary key for the formulation_ingredient entity in the Silver Layer lakehouse.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the parent formulation record to which this ingredient line belongs. Links the ingredient to its product formula in the PLM system.',
    `raw_material_spec_id` BIGINT COMMENT 'Reference to the raw material master record corresponding to this ingredient, linking to procurement and supplier management data.',
    `allergen_declaration` STRING COMMENT 'Free-text or structured declaration of allergens present in this ingredient, including EU 14 major food allergens (where applicable for food-contact or ingestible products) and cosmetic fragrance allergens. Supports regulatory labeling and consumer safety.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the regulatory affairs or R&D professional who approved this ingredient for use in the formulation. Supports GMP audit trail and electronic signature requirements.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient line was formally approved for use in the formulation. Provides GMP-compliant audit trail for regulatory inspections and quality management system records.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service (CAS) to every chemical substance. Required for EU REACH registration, SDS documentation, and regulatory submissions.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `concentration_max_pct` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of the ingredient (% w/w) within the approved formulation range. Critical for safety compliance with regulatory concentration limits (e.g., EU Annex III restricted substances). Classified as confidential due to proprietary formulation IP.',
    `concentration_min_pct` DECIMAL(18,2) COMMENT 'Minimum allowable concentration of the ingredient (% w/w) within the approved formulation range. Used for in-process quality control and batch release decisions. Classified as confidential due to proprietary formulation IP.',
    `concentration_nominal_pct` DECIMAL(18,2) COMMENT 'Target or nominal concentration of the ingredient expressed as a weight/weight percentage (% w/w) in the finished formulation. Represents the standard manufacturing target. Classified as confidential due to proprietary formulation IP.',
    `concentration_uom` STRING COMMENT 'Unit of measure used to express ingredient concentration values (nominal, min, max). Standard is % w/w (weight by weight) for most cosmetic and personal care formulations; ppm or ppb may apply for trace ingredients or contaminants.. Valid values are `% w/w|% v/v|% w/v|ppm|ppb|mg/kg`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this formulation ingredient record was first created in the system. Supports data lineage, audit trail, and PLM version history tracking.',
    `ec_number` STRING COMMENT 'Seven-digit EC number (EINECS, ELINCS, or NLP list) assigned to chemical substances regulated under EU REACH. Mandatory for REACH registration dossiers and EU market compliance.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `effective_date` DATE COMMENT 'Date from which this ingredient line is valid and authorized for use in the formulation. Supports PLM version control and ensures only approved ingredient versions are used in active manufacturing.',
    `expiry_date` DATE COMMENT 'Date on which the authorization for this ingredient line expires, after which it must be re-reviewed and re-approved. Supports regulatory compliance lifecycle management and formulation version control.',
    `fda_status` STRING COMMENT 'Regulatory status of the ingredient under U.S. FDA regulations. Indicates whether the ingredient is approved, Generally Recognized as Safe (GRAS), permitted with restrictions, or prohibited for use in the applicable product category (cosmetics, OTC drug, food contact).. Valid values are `approved|gras|permitted|restricted|prohibited|under_review`',
    `ghs_hazard_classification` STRING COMMENT 'GHS hazard classification codes for this ingredient (e.g., Flam. Liq. 3, Skin Irrit. 2, Aquatic Chronic 1). Drives SDS authoring, workplace safety controls, transport classification, and environmental risk assessment.',
    `grade_specification` STRING COMMENT 'Quality grade or purity specification required for this ingredient (e.g., USP, NF, Ph.Eur., cosmetic grade, food grade, technical grade). Defines the minimum quality standard for procurement and incoming quality control.',
    `halal_status` STRING COMMENT 'Halal certification status of this ingredient, indicating compliance with Islamic dietary and product standards. Required for halal-certified product lines sold in Muslim-majority markets and for halal labeling claims.. Valid values are `certified|not_certified|not_applicable|under_review`',
    `ifra_compliance_status` STRING COMMENT 'Compliance status of this ingredient against the current IFRA Standards for fragrance materials. Applicable to fragrance ingredients and fragrance-containing raw materials. Non-compliant ingredients require reformulation or removal.. Valid values are `compliant|non_compliant|not_applicable|under_review`',
    `inci_name` STRING COMMENT 'Standardized INCI name of the ingredient as defined by the Personal Care Products Council and adopted by ISO 11609. Required for cosmetic product labeling compliance under EU Cosmetics Regulation 1223/2009 and FDA 21 CFR Part 701.',
    `ingredient_function` STRING COMMENT 'Functional role or purpose of the ingredient within the product formula (e.g., surfactant, preservative, fragrance, colorant, emollient, emulsifier, pH adjuster, solvent, active). Drives regulatory classification and labeling requirements. [ENUM-REF-CANDIDATE: surfactant|preservative|fragrance|colorant|emollient|emulsifier|pH adjuster|solvent|active|thickener|chelating agent|antioxidant — promote to reference product]',
    `ingredient_name` STRING COMMENT 'Common or trade name of the ingredient as used internally within the organization, which may differ from the INCI name. Used for internal formulation documentation and procurement communication.',
    `ingredient_status` STRING COMMENT 'Current lifecycle status of this ingredient line within the formulation. Drives PLM workflow gates, regulatory review processes, and manufacturing authorization. Active ingredients are cleared for production use.. Valid values are `active|inactive|under_review|approved|rejected|phased_out`',
    `is_active_ingredient` BOOLEAN COMMENT 'Indicates whether this ingredient is classified as an active ingredient (e.g., OTC drug active, sunscreen active, anti-dandruff active) requiring specific regulatory declaration and concentration compliance under FDA OTC monograph or equivalent regulations.',
    `is_fragrance_allergen` BOOLEAN COMMENT 'Indicates whether this ingredient is a declared fragrance allergen requiring mandatory labeling disclosure under EU Cosmetics Regulation 1223/2009 (Annex III) when present above threshold concentrations (0.001% in rinse-off, 0.01% in leave-on products).',
    `is_natural_origin` BOOLEAN COMMENT 'Indicates whether this ingredient is of natural origin as defined by ISO 16128 (Guidelines on definitions and criteria for natural and organic cosmetic ingredients). Supports natural/organic product claims and consumer transparency labeling.',
    `is_palm_derived` BOOLEAN COMMENT 'Indicates whether this ingredient is derived from palm oil or palm kernel oil. Triggers RSPO (Roundtable on Sustainable Palm Oil) sourcing compliance requirements and sustainability reporting obligations.',
    `is_prohibited_substance` BOOLEAN COMMENT 'Indicates whether this ingredient is classified as a prohibited substance under applicable regulations (e.g., EU Cosmetics Regulation Annex II, FDA prohibited ingredients list). Prohibited substances must not appear in finished products.',
    `is_restricted_substance` BOOLEAN COMMENT 'Indicates whether this ingredient is classified as a restricted substance under applicable regulations (e.g., EU Cosmetics Regulation Annex III, IFRA restricted list, EPA restricted chemicals). Restricted substances may be used within defined concentration limits.',
    `line_number` STRING COMMENT 'Sequential line number of this ingredient within the formulation, used for ordering and referencing individual ingredient entries within a formula.',
    `natural_origin_index` DECIMAL(18,2) COMMENT 'Quantitative natural origin index (0.0000 to 1.0000) calculated per ISO 16128-2 methodology, representing the proportion of the ingredient derived from natural sources. Used to compute product-level natural origin index for claims substantiation.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country of origin of this ingredient. Required for customs declarations, country-of-origin labeling, and sustainability sourcing compliance (e.g., RSPO palm oil, FSC certified materials).. Valid values are `^[A-Z]{3}$`',
    `physical_form` STRING COMMENT 'Physical state or form of the ingredient as received from the supplier (e.g., liquid, solid, powder, paste, gel). Relevant for handling, storage, and manufacturing process design. [ENUM-REF-CANDIDATE: liquid|solid|powder|paste|gel|emulsion|suspension|gas — 8 candidates stripped; promote to reference product]',
    `reach_registration_number` STRING COMMENT 'ECHA-assigned registration number for the substance under EU REACH, in the format XX-XXXXXXXXXX-XX-XXXX. Required for substances manufactured or imported into the EU above 1 tonne per year.. Valid values are `^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$`',
    `reach_registration_status` STRING COMMENT 'Registration status of this ingredient under EU REACH Regulation (EC) No 1907/2006. Indicates whether the substance has been registered with ECHA, is pre-registered, exempt from registration, or registration is pending. Mandatory for EU market access.. Valid values are `registered|pre-registered|exempt|not_required|pending|failed`',
    `regulatory_limit_reference` STRING COMMENT 'Citation of the specific regulatory provision or standard that establishes the maximum concentration limit for this ingredient (e.g., EU Cosmetics Reg. 1223/2009 Annex III Entry 98, FDA 21 CFR 352.10). Provides audit traceability for compliance decisions.',
    `regulatory_max_concentration_pct` DECIMAL(18,2) COMMENT 'Maximum concentration limit (% w/w) for this ingredient as mandated by applicable regulations (e.g., EU Cosmetics Regulation Annex III, FDA OTC monograph limits, IFRA usage limits). Formulation concentration_max_pct must not exceed this value.',
    `sds_reference_number` STRING COMMENT 'Document reference number for the Safety Data Sheet (SDS) associated with this ingredient, as maintained in the document management system (Veeva Vault). Required under OSHA Hazard Communication Standard (HCS) 29 CFR 1910.1200 and EU REACH.',
    `sds_version` STRING COMMENT 'Version identifier of the Safety Data Sheet currently associated with this ingredient. Ensures traceability to the correct SDS revision used during formulation approval and manufacturing.',
    `supplier_code` STRING COMMENT 'Internal supplier code identifying the approved vendor supplying this ingredient raw material. Links to the supplier master for procurement, VMI, and approved supplier list (ASL) management in SAP S/4HANA MM.',
    `supplier_material_code` STRING COMMENT 'Suppliers own material or product code for this ingredient, used for purchase order communication, EDI transactions, and supplier quality management. Enables cross-referencing between internal and external material identifiers.',
    `svhc_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is listed as a Substance of Very High Concern (SVHC) on the ECHA Candidate List under EU REACH Article 59. SVHC presence above 0.1% w/w in articles triggers communication and notification obligations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this formulation ingredient record was last modified. Supports change control tracking, data lineage, and incremental data loading in the Silver Layer lakehouse.',
    `vegan_status` STRING COMMENT 'Vegan classification of this ingredient, indicating whether it is free from animal-derived components. Supports vegan product claims, certification (e.g., The Vegan Society), and consumer labeling requirements.. Valid values are `vegan|non_vegan|unknown|under_review`',
    CONSTRAINT pk_product_formulation_ingredient PRIMARY KEY(`product_formulation_ingredient_id`)
) COMMENT 'Individual ingredient line within a formulation record, specifying each chemical or biological substance used in the product formula. Attributes include INCI name (International Nomenclature of Cosmetic Ingredients), CAS number, EC number, function/role (e.g., surfactant, preservative, fragrance, colorant), concentration percentage (min/max/nominal), raw material supplier code, SDS reference, EU REACH registration status, FDA status, and whether the ingredient is a restricted or prohibited substance under applicable regulations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` (
    `product_packaging_spec_id` BIGINT COMMENT 'Unique surrogate identifier for each packaging specification record. One record represents one packaging level for one SKU. MASTER_RESOURCE role — primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Packaging specification approval is an employee responsibility; needed for regulatory packaging compliance.',
    `sku_id` BIGINT COMMENT 'Reference to the parent SKU for which this packaging specification is defined. Links the packaging record to the product master.',
    `supplier_id` BIGINT COMMENT 'Reference to the approved supplier responsible for manufacturing or supplying this packaging component. Links to the supplier master for procurement, quality, and compliance management.',
    `approval_status` STRING COMMENT 'Quality and regulatory approval status of this packaging specification. Only approved specifications may be used in production orders. Supports GMP compliance and change control workflows.. Valid values are `pending|approved|rejected|under_review`',
    `artwork_ref` STRING COMMENT 'Reference code linking to the approved artwork file for this packaging specification in the digital asset management or PLM system. Ensures the correct print-ready artwork version is used in production.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `color` STRING COMMENT 'Primary color of the packaging component as specified in the brand design brief (e.g., Pantone 485 C Red, White, Transparent). Used for brand compliance, print production, and planogram visual merchandising.',
    `component_type` STRING COMMENT 'Specific form of the packaging component (e.g., bottle, tube, sachet, pouch, carton, sleeve, shrink-wrap, case, shipper, tray, blister, jar, can, aerosol). [ENUM-REF-CANDIDATE: bottle|tube|sachet|pouch|carton|sleeve|shrink_wrap|case|shipper|tray|blister|jar|can|aerosol|pallet — promote to reference product]',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where this packaging component is manufactured. Required for customs declarations, import compliance, and supply chain risk assessments.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging specification record was first created in the system. Supports audit trail, data lineage, and change management tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost (e.g., USD, EUR, GBP). Enables multi-currency cost management across global sourcing operations.. Valid values are `^[A-Z]{3}$`',
    `ean` STRING COMMENT '13-digit EAN barcode assigned to this packaging level for European and international retail markets. Used for POS scanning, retailer EDI, and customs documentation.. Valid values are `^[0-9]{13}$`',
    `effective_date` DATE COMMENT 'Date from which this packaging specification version becomes active and valid for production use. Supports version management and change control in PLM and ERP systems.',
    `expiry_date` DATE COMMENT 'Date after which this packaging specification version is no longer valid for production. Null indicates the specification is open-ended with no planned expiry. Supports change control and version governance.',
    `finish` STRING COMMENT 'Surface finish specification of the packaging component. Impacts print quality, consumer perception, and manufacturing process selection. [ENUM-REF-CANDIDATE: gloss|matte|satin|soft_touch|metallic|frosted|clear — 7 candidates stripped; promote to reference product]',
    `gross_weight_g` DECIMAL(18,2) COMMENT 'Total weight of the packaging component including product contents in grams. Used for freight cost calculations, transportation planning, and customs documentation.',
    `gtin` STRING COMMENT 'GS1-assigned Global Trade Item Number for this specific packaging level. GTINs are assigned at each packaging hierarchy level (each, inner pack, case, pallet). Required for EDI order processing, retailer compliance, and GS1 registry submissions.. Valid values are `^[0-9]{8,14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this packaging component contains or is classified as a hazardous material requiring special handling, storage, or transportation documentation (e.g., aerosol propellants, flammable coatings). Triggers SDS requirements.',
    `height_mm` DECIMAL(18,2) COMMENT 'External height dimension of the packaging component in millimeters. Used for planogram compliance, warehouse slotting, Ti-Hi pallet configuration, and transportation cube optimization.',
    `hi` STRING COMMENT 'Number of tiers (layers) stacked on a pallet — the Hi component of the Ti-Hi pallet configuration. Combined with Ti to determine total units per pallet for DRP/MRP and transportation planning.',
    `is_fsc_certified` BOOLEAN COMMENT 'Indicates whether the packaging material is sourced from FSC-certified forests or recycled sources. Required for sustainability claims, retailer compliance programs, and ESG reporting.',
    `is_rspo_certified` BOOLEAN COMMENT 'Indicates whether palm oil-derived materials in the packaging component are RSPO-certified. Relevant for packaging components containing palm-based inks, coatings, or adhesives. Supports ESG and sustainability reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging specification record was last updated. Used for incremental data loads, change detection, and audit compliance in the Silver Layer lakehouse.',
    `lead_time_days` STRING COMMENT 'Supplier lead time in calendar days from purchase order placement to delivery of this packaging component. Critical input for MRP/DRP scheduling and supply chain risk management.',
    `length_mm` DECIMAL(18,2) COMMENT 'External length dimension of the packaging component in millimeters. Used for planogram compliance, warehouse slotting, transportation cube optimization, and retailer shelf-space calculations.',
    `lifecycle_status` STRING COMMENT 'Current PLM lifecycle state of the packaging specification. Controls whether the spec is available for production orders and procurement. Aligns with SAP S/4HANA material status and Veeva Vault document lifecycle.. Valid values are `draft|active|under_review|obsolete|discontinued`',
    `material_composition` STRING COMMENT 'Primary material(s) used in the packaging component (e.g., HDPE, PET, glass, paperboard, aluminum, polypropylene, PCR blend). Supports sustainability reporting, EPR compliance, and plastic tax calculations. [ENUM-REF-CANDIDATE: HDPE|PET|glass|paperboard|aluminum|polypropylene|PCR_blend|cardboard|bioplastic — promote to reference product]',
    `moq` STRING COMMENT 'Minimum number of units the supplier requires per purchase order for this packaging component. Used in procurement planning, MRP calculations, and cost negotiations.',
    `packaging_level` STRING COMMENT 'Hierarchical level of the packaging component: primary (direct product contact — bottle, tube, sachet), secondary (carton, sleeve, shrink-wrap), tertiary (case, shipper), display_unit (shelf-ready display), or pallet. Drives DRP/MRP quantity calculations and warehouse slotting.. Valid values are `primary|secondary|tertiary|display_unit|pallet`',
    `pcr_content_pct` DECIMAL(18,2) COMMENT 'Percentage of post-consumer recycled material in the packaging component by weight (0.00–100.00). Critical for sustainability reporting, EPR obligations, and plastic tax compliance across EU and US jurisdictions.',
    `print_method` STRING COMMENT 'Printing technology used to apply graphics and text to the packaging component. Determines supplier capability requirements, cost structure, and minimum order quantities. [ENUM-REF-CANDIDATE: flexography|offset_lithography|digital|gravure|screen_printing|hot_stamping|label — 7 candidates stripped; promote to reference product]',
    `qty_per_parent` STRING COMMENT 'Number of units of this packaging level contained within the next higher packaging level (e.g., 12 eaches per case, 48 cases per pallet). Core input for DRP/MRP quantity calculations and order processing.',
    `recyclability_code` STRING COMMENT 'How2Recycle label code assigned to this packaging component indicating recyclability instructions for consumers (e.g., Widely Recycled, Check Locally, Not Yet Recycled). Required for EPR compliance and sustainability reporting.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this packaging specification has passed all applicable regulatory compliance checks (FDA, EU REACH, CPSC, etc.) for the target markets. False triggers a compliance review workflow.',
    `spec_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this packaging specification within the PLM or ERP system. Used for cross-system reference and EDI communication.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `spec_name` STRING COMMENT 'Human-readable name describing this packaging specification (e.g., 500ml HDPE Bottle Primary Pack — SKU XYZ). Used in PLM, procurement, and supplier communications.',
    `supplier_tooling_ref` STRING COMMENT 'Supplier-assigned tooling or mold reference number for this packaging component. Used to track proprietary tooling ownership, maintenance schedules, and supplier change management in procurement.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `tare_weight_g` DECIMAL(18,2) COMMENT 'Weight of the empty packaging component without product contents in grams. Used for net weight labeling compliance, material cost calculations, and sustainability reporting on packaging material mass.',
    `ti` STRING COMMENT 'Number of cases or units per tier (layer) on a pallet — the Ti component of the Ti-Hi pallet configuration. Used for warehouse slotting, transportation cube optimization, and retailer receiving compliance.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of this packaging component in the companys base currency. Used for COGS calculation, BOM costing, and packaging cost optimization initiatives.',
    `upc` STRING COMMENT '12-digit UPC-A barcode assigned to this packaging level, primarily used for North American retail POS scanning and retailer item setup. Subset of GTIN-12.. Valid values are `^[0-9]{12}$`',
    `version_number` STRING COMMENT 'Version identifier for this packaging specification (e.g., 1.0, 2.3). Tracks design revisions and change history in PLM. Each approved change increments the version.. Valid values are `^[0-9]+.[0-9]+$`',
    `width_mm` DECIMAL(18,2) COMMENT 'External width dimension of the packaging component in millimeters. Used for planogram compliance, warehouse slotting, and transportation cube optimization.',
    CONSTRAINT pk_product_packaging_spec PRIMARY KEY(`product_packaging_spec_id`)
) COMMENT 'Packaging specification master defining the complete physical, material, structural, and hierarchy attributes of all packaging levels for each SKU — primary (bottle, tube, sachet, pouch), secondary (carton, sleeve, shrink-wrap), tertiary (case, shipper), display unit, and pallet. Each record represents one packaging level for one SKU and captures: component type, material composition (HDPE, PET, glass, paperboard, aluminum, PCR content %), dimensions (L×W×H), gross/tare weight, color, finish, print method, recyclability code (How2Recycle label), FSC/RSPO certification flag, supplier tooling reference, quantity per hierarchy level (e.g., 12 eaches per case, 48 cases per pallet), Ti-Hi pallet configuration, and GTIN assigned at that level. Supports sustainability reporting (EPR, plastic tax), planogram compliance, DRP/MRP calculations, warehouse slotting, transportation cube optimization, and retailer EDI order processing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` (
    `plm_transition_id` BIGINT COMMENT 'Unique surrogate identifier for each PLM stage transition event record. Primary key of the plm_transition table.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user (employee or system account) who initiated or triggered this lifecycle stage transition. Supports audit trail and accountability requirements.',
    `product_brand_id` BIGINT COMMENT 'Reference to the brand under which the SKU or formulation is being developed or managed. Supports brand-level NPD pipeline reporting and portfolio analytics.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the specific formulation version associated with this lifecycle transition, applicable when the transition is driven by a formulation change rather than a product-level event.',
    `rd_project_id` BIGINT COMMENT 'Reference to the NPD project or innovation initiative under which this lifecycle transition is occurring. Links the transition to the broader NPD pipeline for portfolio reporting and resource tracking.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU or product item undergoing the lifecycle stage transition. Links to the product master record.',
    `approval_date` DATE COMMENT 'The date on which the gate review approval was formally granted for this lifecycle stage transition. Distinct from transition_date which records when the transition was executed.',
    `approval_reference` STRING COMMENT 'The formal approval document number, change control reference, or gate review authorization code associated with this transition. Used for cross-referencing with quality management and regulatory submission records in Veeva Vault.',
    `comments` STRING COMMENT 'Additional free-text commentary entered by the triggering user or approver at the time of the transition, capturing context not covered by structured fields. Supplements gate_review_notes with informal observations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this PLM transition record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `from_stage_code` STRING COMMENT 'The PLM lifecycle stage from which the SKU or formulation is transitioning. Standard stage codes: Ideation, Concept, Feasibility, Development, Pilot, Scale-Up, Launch, Active, Renovation, Discontinuation, Archived. [ENUM-REF-CANDIDATE: Ideation|Concept|Feasibility|Development|Pilot|Scale-Up|Launch|Active|Renovation|Discontinuation|Archived — promote to reference product]. Valid values are `Ideation|Concept|Feasibility|Development|Pilot|Scale-Up`',
    `gate_criteria_detail` STRING COMMENT 'Detailed breakdown of individual gate criteria evaluation results, capturing which specific criteria passed, failed, or were waived during the stage-gate review. Supports granular NPD governance reporting.',
    `gate_criteria_validation_result` STRING COMMENT 'Overall outcome of the gate criteria checklist validation performed at the stage-gate review. Pass: all mandatory criteria met; Conditional Pass: approved with conditions or waivers; Fail: one or more mandatory criteria not met; Not Evaluated: gate review not yet conducted.. Valid values are `Pass|Conditional Pass|Fail|Not Evaluated`',
    `gate_review_notes` STRING COMMENT 'Structured or free-text notes recorded during the stage-gate review meeting, capturing key decisions, conditions of approval, open action items, and reviewer commentary. Provides the qualitative audit trail for NPD governance.',
    `is_fast_track` BOOLEAN COMMENT 'Indicates whether this lifecycle transition was processed under an expedited or fast-track NPD process, bypassing standard gate review timelines. Common for regulatory-driven reformulations or urgent market responses.',
    `product_category_code` STRING COMMENT 'Classification code identifying the product category (e.g., personal care, household cleaning, health) to which the SKU belongs. Enables category-level NPD pipeline analysis and regulatory routing.',
    `regulatory_submission_reference` STRING COMMENT 'The reference number or docket identifier for the regulatory submission associated with this lifecycle transition (e.g., FDA 510(k) number, EU REACH dossier ID). Populated when regulatory_submission_required is True.',
    `regulatory_submission_required` BOOLEAN COMMENT 'Indicates whether this lifecycle stage transition triggers a mandatory regulatory submission or notification (e.g., FDA pre-market notification, EU REACH registration update, CPSC safety report). Drives regulatory workflow routing.',
    `revised_launch_date` DATE COMMENT 'Updated target commercial launch date if the original target has been revised as a result of this or a prior transition. Enables tracking of schedule slippage across the NPD pipeline.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this PLM transition event originated. Supports data lineage tracking in the Silver layer lakehouse.. Valid values are `SAP_PLM|VEEVA_VAULT|ORACLE_ERP|MANUAL`',
    `source_system_transition_code` STRING COMMENT 'The native identifier of this transition record in the originating source system (e.g., SAP change request ID, Veeva Vault workflow instance ID). Enables reconciliation between the lakehouse Silver layer and the system of record.',
    `stage_entry_date` DATE COMMENT 'The date on which the SKU or formulation formally entered the to_stage_code as a result of this transition. Used to calculate stage duration and cycle time KPIs for NPD efficiency reporting.',
    `stage_exit_date` DATE COMMENT 'The date on which the SKU or formulation exited the from_stage_code. Together with stage_entry_date of the prior transition, enables calculation of time-in-stage for NPD cycle time analytics.',
    `target_launch_date` DATE COMMENT 'The planned commercial launch date for the SKU as recorded at the time of this lifecycle transition. Used for NPD pipeline milestone tracking and S&OP alignment.',
    `to_stage_code` STRING COMMENT 'The PLM lifecycle stage to which the SKU or formulation is transitioning. Standard stage codes: Ideation, Concept, Feasibility, Development, Pilot, Scale-Up, Launch, Active, Renovation, Discontinuation, Archived. [ENUM-REF-CANDIDATE: Ideation|Concept|Feasibility|Development|Pilot|Scale-Up|Launch|Active|Renovation|Discontinuation|Archived — promote to reference product]. Valid values are `Concept|Feasibility|Development|Pilot|Scale-Up|Launch`',
    `transition_date` DATE COMMENT 'The calendar date on which the lifecycle stage transition was formally executed and recorded. Represents the principal business event date for NPD pipeline reporting and regulatory submission timelines.',
    `transition_reason_code` STRING COMMENT 'Standardized reason code classifying why this lifecycle stage transition was initiated. NPD_PROGRESSION: normal new product development advancement; RENOVATION: product renovation or restage; REFORMULATION: ingredient or formula change; REGULATORY: compliance-driven change; DISCONTINUATION: product end-of-life; ROLLBACK: reversion to prior stage.. Valid values are `NPD_PROGRESSION|RENOVATION|REFORMULATION|REGULATORY|DISCONTINUATION|ROLLBACK`',
    `transition_reason_description` STRING COMMENT 'Free-text narrative providing additional business context for the lifecycle stage transition beyond the standardized reason code. Captures nuances such as market conditions, consumer insights, or regulatory findings that drove the transition.',
    `transition_reference_number` STRING COMMENT 'Externally-known business identifier for this transition event, typically generated by the PLM or ERP system (e.g., SAP change request number or Veeva Vault workflow ID). Used for cross-system traceability.',
    `transition_status` STRING COMMENT 'Current workflow status of this lifecycle stage transition event. Pending indicates awaiting gate review approval; Approved indicates the transition has been formally authorized; Rejected indicates the gate review denied the transition; Withdrawn indicates the request was retracted; Superseded indicates replaced by a subsequent transition.. Valid values are `Pending|Approved|Rejected|Withdrawn|Superseded`',
    `transition_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the lifecycle stage transition event was triggered in the source PLM system. Provides audit-grade temporal precision for regulatory submissions and compliance traceability.',
    `transition_type` STRING COMMENT 'Classifies the direction and nature of the lifecycle stage transition. Forward: normal progression to the next stage; Backward: reversion to a prior stage; Parallel: simultaneous multi-stage activity; Bypass: skipping one or more intermediate stages with documented justification.. Valid values are `Forward|Backward|Parallel|Bypass`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this PLM transition record was last modified in the data platform. Tracks corrections, status updates, or supplemental data additions post-ingestion.',
    `waiver_reference` STRING COMMENT 'Reference number for any formal waiver granted to allow progression despite unmet gate criteria. Populated when gate_criteria_validation_result is Conditional Pass. Required for regulatory audit trail.',
    CONSTRAINT pk_plm_transition PRIMARY KEY(`plm_transition_id`)
) COMMENT 'Transactional record capturing each lifecycle stage transition event for a SKU or formulation. Records from-stage, to-stage (using standard stage codes: Ideation, Concept, Feasibility, Development, Pilot, Scale-Up, Launch, Active, Renovation, Discontinuation, Archived), transition date, triggered-by user, approval reference, transition reason code, gate review notes, and gate criteria validation results. Provides complete audit trail of product lifecycle from ideation through discontinuation. Supports NPD pipeline reporting, stage-gate governance, and regulatory submission timelines.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` (
    `label_spec_id` BIGINT COMMENT 'Unique surrogate identifier for each label specification record. Primary key for the label_spec data product in the product domain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Label approval workflow requires tracking which employee approved each label for regulatory compliance.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this label specification applies. Links the label spec to the product master.',
    `allergen_declaration` STRING COMMENT 'Allergen declaration text as printed on the label (e.g., Contains: Milk, Soy, May contain traces of nuts). Mandatory for food and personal care products under FDA FALCPA and EU Regulation 1169/2011.',
    `approval_status` STRING COMMENT 'Current workflow status of the label specification in the regulatory and artwork approval process. Drives gating of production print runs and market release.. Valid values are `draft|under_review|approved|rejected|superseded`',
    `artwork_file_reference` STRING COMMENT 'Document management system reference or file path to the approved artwork file for this label specification (e.g., Veeva Vault document ID or DAM asset reference). Links label spec to the physical artwork asset.',
    `barcode_placement` STRING COMMENT 'Specification of the physical placement zone for the barcode on the label or packaging (e.g., bottom-right back panel, base of container). Ensures retail scanner readability and planogram compliance.',
    `barcode_type` STRING COMMENT 'Type of barcode symbology specified for placement on the label (e.g., UPC-A, EAN-13, ITF-14, GS1-128, QR Code, DataMatrix). Governs scanner compatibility at retail POS and logistics. [ENUM-REF-CANDIDATE: UPC-A|EAN-13|EAN-8|ITF-14|GS1-128|QR_Code|DataMatrix — 7 candidates stripped; promote to reference product]',
    `certification_marks` STRING COMMENT 'Third-party certification marks and logos authorized for display on this label (e.g., USDA Organic, NSF Certified, Leaping Bunny, RSPO, FSC, CE Mark). Subject to certification body licensing requirements.',
    `claim_text` STRING COMMENT 'Marketing and regulatory claims printed on the label (e.g., Dermatologist Tested, Cruelty-Free, Hypoallergenic, Organic, Clinically Proven). Subject to FTC advertising substantiation requirements.',
    `color_profile` STRING COMMENT 'Color management profile and ink specification for the label (e.g., CMYK + 2 Pantone, Pantone 485C + Black). Ensures brand color consistency across print runs and suppliers.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country of manufacture as declared on the label. Mandatory for customs, trade compliance, and consumer disclosure in most markets.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this label specification record was first created in the system. Supports audit trail, data lineage, and regulatory record-keeping requirements.',
    `digital_watermark_enabled` BOOLEAN COMMENT 'Indicates whether a digital watermark (e.g., GS1 Digital Link, Digimarc) is embedded in the label artwork to support connected packaging, consumer engagement, and supply chain traceability.',
    `distributor_name` STRING COMMENT 'Legal name of the distributor or importer as printed on the label, where different from the manufacturer. Required in markets where the responsible party is the local distributor.',
    `effective_date` DATE COMMENT 'Date from which this label specification version is valid and authorized for use in production and distribution. Supports regulatory compliance date tracking.',
    `expiry_date` DATE COMMENT 'Date after which this label specification version is no longer valid and must be superseded. Nullable for open-ended specifications. Supports artwork lifecycle management.',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number (GTIN) as encoded in the barcode on this label. Uniquely identifies the trade item at the specified packaging level per GS1 standards.. Valid values are `^[0-9]{14}$`',
    `ingredient_declaration_text` STRING COMMENT 'Full ingredient declaration text as it appears on the label, including INCI (International Nomenclature of Cosmetic Ingredients) names for cosmetics or common/scientific names for food and household products. Mandatory for regulatory compliance.',
    `is_primary_label` BOOLEAN COMMENT 'Indicates whether this label specification is the primary (master) label for the SKU-market-language combination, as opposed to a supplementary or promotional label variant.',
    `label_approval_date` DATE COMMENT 'Date on which the label specification received final regulatory and quality approval, authorizing use in production. Key milestone in the PLM artwork approval workflow.',
    `label_dimensions` STRING COMMENT 'Physical dimensions of the label (width x height in mm, e.g., 120x80mm). Required for print production specifications and packaging line setup.',
    `label_type` STRING COMMENT 'Categorizes the physical placement and function of the label on the product packaging (e.g., front_of_pack, back_of_pack, inner_label, neck_label, hang_tag, insert). Drives artwork management and regulatory review workflows.. Valid values are `front_of_pack|back_of_pack|inner_label|neck_label|hang_tag|insert`',
    `label_version` STRING COMMENT 'Version number of the label specification (e.g., 1.0, 2.1, 3.0). Used to track label revisions and manage artwork lifecycle in PLM and Veeva Vault.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) for the label text (e.g., en, fr, de, es, zh-CN). Supports multilingual labeling requirements.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this label specification record was most recently updated. Supports change tracking, audit trail, and downstream data synchronization.',
    `lot_code_format` STRING COMMENT 'Format specification for the lot/batch code printed on the label (e.g., YYYYMMDD-XXXX, Julian date + shift code). Enables product traceability and recall management.',
    `mandatory_regulatory_statements` STRING COMMENT 'Concatenated text of all mandatory regulatory statements required by the applicable regulatory framework (e.g., FDA required statements, EU mandatory disclosures, CPSC safety notices). Stored as structured text for label artwork population.',
    `manufacturer_address` STRING COMMENT 'Full address of the manufacturer or responsible party as printed on the label. Mandatory for consumer contact and regulatory traceability in most jurisdictions.',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturer or responsible party as printed on the label. Required by FDA, EU, and most national regulatory frameworks for product traceability.',
    `market_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the market or country for which this label specification is valid (e.g., USA, GBR, DEU, FRA). Supports multi-market regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `net_content_declaration` STRING COMMENT 'Net content statement as printed on the label, including quantity and unit of measure (e.g., 500 mL, 16 fl oz (473 mL), 250 g). Mandatory per weights and measures regulations.',
    `nutrition_facts_required` BOOLEAN COMMENT 'Indicates whether a Nutrition Facts panel or equivalent nutritional information table is required on this label per applicable regulatory framework. Applies to food, beverage, and dietary supplement categories.',
    `plm_change_order_number` STRING COMMENT 'Change order or engineering change notice (ECN) number from the PLM system that authorized this label specification version. Provides traceability to the formal change management process.',
    `print_process` STRING COMMENT 'Printing technology specified for producing this label (e.g., flexographic, digital, offset, gravure, screen). Determines supplier qualification and color reproduction requirements.. Valid values are `flexographic|digital|offset|gravure|screen`',
    `recycling_symbol_code` STRING COMMENT 'Recycling and environmental symbol codes required on the label (e.g., Mobius loop resin identification code, Green Dot, Tidyman, FSC logo). Supports sustainability compliance and consumer communication.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework governing this label specification (e.g., FDA 21 CFR, EU Regulation 1169/2011, CPSC 16 CFR, Health Canada). Determines mandatory statement requirements. [ENUM-REF-CANDIDATE: FDA_21_CFR|EU_1169_2011|CPSC_16_CFR|Health_Canada|ANVISA|TGA|SFDA — promote to reference product]',
    `regulatory_registration_number` STRING COMMENT 'Product registration or notification number assigned by the regulatory authority for the target market (e.g., FDA Facility Registration, EU Cosmetic Product Notification Portal reference, CPNP number). Required on label in certain markets.',
    `shelf_life_statement` STRING COMMENT 'Shelf life or best-before/expiry date format statement as printed on the label (e.g., Best Before: see base, Use By: MM/YYYY, PAO 12M). Supports FEFO inventory management and consumer safety.',
    `substrate_material` STRING COMMENT 'Material specification for the label substrate (e.g., White BOPP, Kraft Paper, Clear PET, Foil). Drives procurement of label stock and sustainability reporting.',
    `usage_instructions` STRING COMMENT 'Directions for use as printed on the label (e.g., application method, dosage, frequency, preparation instructions). Required for regulated product categories and consumer safety.',
    `veeva_document_reference` STRING COMMENT 'Document identifier in Veeva Vault for the controlled label specification document. Provides direct traceability to the system of record for regulatory submissions and quality documents.',
    `warning_statements` STRING COMMENT 'All warning and precautionary statements required on the label (e.g., Keep out of reach of children, Flammable, allergen warnings, GHS hazard statements). Mandatory for consumer safety compliance.',
    CONSTRAINT pk_label_spec PRIMARY KEY(`label_spec_id`)
) COMMENT 'Regulatory labeling specification for each SKU and market/country combination. Captures label version, language, market/country code, label type (front-of-pack, back-of-pack, inner label), mandatory regulatory statements (FDA, EU, CPSC), ingredient declaration text, net content declaration, warning statements, usage instructions, claim text (e.g., dermatologist tested, cruelty-free), barcode placement, and label approval status. Supports multi-market regulatory compliance and artwork management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` (
    `product_claim_id` BIGINT COMMENT 'Unique surrogate identifier for each product claim record in the master claim registry. Primary key for the product_claim data product.',
    `claim_substantiation_id` BIGINT COMMENT 'Identifier of the supporting study, clinical trial, laboratory test report, or audit document that substantiates the claim. Cross-references the document management system (Veeva Vault) or internal R&D study registry.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) to which this claim is associated. Links the claim to the authoritative product master record.',
    `applicable_markets` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes identifying the markets where this claim is authorized for use. Claim validity is jurisdiction-specific due to varying regulatory requirements (e.g., FDA in USA, EU REACH in Europe). Example: USA,GBR,DEU,FRA.',
    `approval_date` DATE COMMENT 'The date on which the claim was formally approved by the internal regulatory, legal, or marketing compliance team for consumer-facing use. Marks the start of the claims authorized deployment window.',
    `certification_body` STRING COMMENT 'Name of the third-party certification organization that issued or validates the claim (e.g., NSF International, Leaping Bunny, USDA Organic, Rainforest Alliance, RSPO, FSC). Applicable only for certification-type claims.',
    `certification_expiry_date` DATE COMMENT 'The date on which the third-party certification underpinning this claim expires and must be renewed. Distinct from claim expiry_date; a lapsed certification may invalidate the claim even if the claim itself has not expired.',
    `certification_number` STRING COMMENT 'The official certificate or license number issued by the certification body for third-party certified claims. Used for audit trail and regulatory verification purposes.',
    `channel` STRING COMMENT 'The consumer touchpoint channel(s) where this claim is authorized to appear. Packaging: on-pack label; Advertising: TV/print/radio; Digital: e-commerce and social media; In-store: POS/planogram materials; All: unrestricted channel use.. Valid values are `packaging|advertising|digital|in-store|all`',
    `claim_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the claim, used in regulatory submissions, PLM systems, and cross-functional references. Sourced from Veeva Vault claim registration.. Valid values are `^CLM-[A-Z0-9]{6,12}$`',
    `claim_scope` STRING COMMENT 'Defines the level at which the claim applies: Product (specific SKU), Brand (entire brand portfolio), Range (product line/sub-brand), or Ingredient (specific INCI ingredient within the formulation).. Valid values are `product|brand|range|ingredient`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the claim within the approval and compliance workflow. Approved: substantiated and cleared for use; Pending: awaiting substantiation review; Withdrawn: voluntarily removed; Expired: past validity date; Under Review: triggered by regulatory inquiry or market change.. Valid values are `approved|pending|withdrawn|expired|under_review`',
    `claim_text` STRING COMMENT 'The verbatim consumer-facing claim statement as it appears on product packaging, advertising, or digital channels (e.g., 99.9% germ kill, Dermatologist tested, Made with 100% recycled packaging). Must match approved copy exactly.',
    `claim_type` STRING COMMENT 'Categorical classification of the claim by its business and regulatory nature. Efficacy: performance-based claims; Environmental: green/sustainability claims; Certification: third-party certified claims; Nutritional: nutrient content or health claims; Safety: dermatological or toxicological safety claims.. Valid values are `efficacy|environmental|certification|nutritional|safety`',
    `claim_value` DECIMAL(18,2) COMMENT 'The specific numeric value or percentage cited in a quantitative claim (e.g., 99.9, 30, 100). Stored as STRING to accommodate ranges and non-numeric qualifiers. Null for qualitative claims.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this product claim record was first created in the system. Provides the audit trail entry point for the claims lifecycle in the data platform.',
    `effective_from` DATE COMMENT 'The date from which the claim is permitted to appear on product packaging, advertising, or digital channels. May differ from approval_date if a future launch date is planned.',
    `environmental_claim_standard` STRING COMMENT 'The specific environmental standard or framework under which an environmental claim is made (e.g., ISO 14021 for self-declared environmental claims, ISO 14024 for Type I eco-labels, EPA Safer Choice). Applicable only for environmental claim types.',
    `expiry_date` DATE COMMENT 'The date on which the claim authorization expires and must be re-substantiated or withdrawn. Null indicates an open-ended claim with no scheduled expiry. Critical for compliance monitoring and claim lifecycle management.',
    `fda_reviewed` BOOLEAN COMMENT 'Indicates whether the claim has been reviewed for compliance with FDA labeling regulations (21 CFR Part 101 for food/nutrition claims or 21 CFR Part 701 for cosmetics). Applicable for health, nutritional, and drug-related claims.',
    `ftc_compliant` BOOLEAN COMMENT 'Indicates whether the claim has been reviewed and confirmed compliant with FTC advertising guidelines, including the requirement for competent and reliable scientific evidence. True = FTC compliant; False = non-compliant or not yet reviewed.',
    `inci_ingredient_ref` STRING COMMENT 'The INCI (International Nomenclature of Cosmetic Ingredients) name of the specific ingredient referenced in an ingredient-scoped claim. Applicable when claim_scope is ingredient. Ensures regulatory alignment with EU Cosmetics Regulation and FDA cosmetic labeling.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) for the language in which the claim_text is written (e.g., en, fr, de, es, zh-CN). Supports multi-market, multi-language claim management.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `legal_reviewed` BOOLEAN COMMENT 'Indicates whether the claim has been reviewed and cleared by the internal legal counsel for advertising law compliance, IP considerations, and litigation risk. True = legal sign-off obtained.',
    `legal_reviewer` STRING COMMENT 'Name or employee identifier of the legal counsel who reviewed and approved the claim. Provides audit trail for legal sign-off accountability.',
    `marketing_approved` BOOLEAN COMMENT 'Indicates whether the marketing team has approved the claim copy for consumer-facing deployment. Part of the multi-functional claim approval workflow (R&D, Legal, Regulatory, Marketing).',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of the claims substantiation and compliance status. Calculated from approval_date plus review_frequency_days. Triggers compliance workflow in Veeva Vault.',
    `notes` STRING COMMENT 'Free-text field for additional context, internal commentary, or conditional use instructions associated with the claim (e.g., Valid only when product contains ≥0.5% active ingredient, Pending FDA response as of Q3 2024). Not for consumer-facing use.',
    `plm_stage` STRING COMMENT 'The PLM lifecycle stage of the associated SKU at the time this claim is active. Ensures claims are only deployed during appropriate product lifecycle phases and supports NPD (New Product Development) claim planning.. Valid values are `development|pre-launch|active|post-launch|discontinued`',
    `quantitative_claim` BOOLEAN COMMENT 'Indicates whether the claim contains a specific quantitative assertion (e.g., 99.9% effective, reduces wrinkles by 30%). Quantitative claims require a higher standard of substantiation evidence under FTC guidelines.',
    `regulatory_body` STRING COMMENT 'The primary regulatory authority governing this claim in its applicable market(s) (e.g., FDA, EPA, CPSC, EU REACH, IFRA). Drives the compliance review process and substantiation requirements. [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EU_REACH|IFRA|FTC|OSHA|ISO|RSPO|FSC — promote to reference product]',
    `review_frequency_days` STRING COMMENT 'The mandated periodic review interval in days for re-substantiating or reconfirming the claims validity. Drives automated compliance alerts and claim lifecycle management workflows.',
    `scientific_reviewer` STRING COMMENT 'Name or employee identifier of the R&D scientist or regulatory affairs specialist who validated the substantiation evidence for the claim.',
    `source_system_claim_code` STRING COMMENT 'The native identifier of this claim record in the originating operational system (e.g., Veeva Vault document ID, SAP object ID). Enables traceability and reconciliation between the lakehouse silver layer and the system of record.',
    `substantiation_method` STRING COMMENT 'The scientific or evidentiary method used to substantiate the claim per FTC competent and reliable scientific evidence standard. Determines the rigor and defensibility of the claim in regulatory or legal proceedings.. Valid values are `clinical_study|consumer_study|lab_test|third_party_audit|literature_review|expert_panel`',
    `subtype` STRING COMMENT 'Secondary classification providing finer granularity within the claim type (e.g., anti-bacterial, biodegradable, cruelty-free, hypoallergenic, organic, fair-trade). [ENUM-REF-CANDIDATE: anti-bacterial|biodegradable|cruelty-free|hypoallergenic|organic|fair-trade|recyclable|vegan|gluten-free|non-gmo — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this product claim record. Used for incremental data loading, change detection, and audit compliance in the Databricks lakehouse silver layer.',
    `value_unit` STRING COMMENT 'Unit of measure for the quantitative claim value (e.g., %, mg, CFU, hours). Required when claim_value is populated to provide full context for the quantitative assertion.',
    `version_number` STRING COMMENT 'Monotonically incrementing version counter for the claim record, incremented each time the claim text, substantiation, or approval status changes. Supports claim history tracking and regulatory audit trail requirements.',
    `withdrawal_date` DATE COMMENT 'The date on which the claim was formally withdrawn from consumer-facing use. Populated only when claim_status is withdrawn. Critical for regulatory audit trail and litigation defense.',
    `withdrawal_reason` STRING COMMENT 'Free-text explanation for why a claim was withdrawn or rejected. Populated when claim_status is withdrawn or under_review. Captures regulatory challenge, substantiation failure, reformulation, or voluntary removal rationale.',
    CONSTRAINT pk_product_claim PRIMARY KEY(`product_claim_id`)
) COMMENT 'Master record of all marketing and regulatory claims associated with a SKU, including claim text, claim type (efficacy, environmental, certification, nutritional, safety), substantiation method, supporting study or test reference, claim approval date, expiry date, applicable markets, FTC compliance flag, and claim status (approved, pending, withdrawn). Ensures all consumer-facing claims are substantiated and compliant with FTC advertising guidelines and local market regulations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` (
    `product_brand_id` BIGINT COMMENT 'Unique surrogate identifier for each brand master record in the Consumer Goods portfolio. Primary key for the product_brand dimension, referenced by all downstream domains including marketing, trade promotion, and financial reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand manager role is an employee; needed for brand performance dashboards and accountability.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Align internal product_brand records with marketing brand for unified brand strategy and reporting; brand_code is redundant once linked.',
    `architecture_type` STRING COMMENT 'Classification of the brands role within the overall brand architecture strategy. Master brands are umbrella identities; sub-brands extend a master brand; endorsed brands carry a parent endorsement; standalone brands operate independently; house_of_brands indicates a portfolio brand with no visible corporate parent.. Valid values are `master_brand|sub_brand|endorsed_brand|standalone|house_of_brands`',
    `brand_name` STRING COMMENT 'Official consumer-facing name of the brand as registered and used in marketing, packaging, and trade communications. This is the primary human-readable identifier for the brand across all channels including retail, e-commerce, and DTC.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand within the Consumer Goods portfolio. Active brands are fully marketed and distributed; dormant brands are temporarily inactive; divested brands have been sold or licensed out; discontinued brands are permanently retired; pipeline brands are in NPD/R&D pre-launch phase.. Valid values are `active|dormant|divested|discontinued|pipeline`',
    `brand_tier` STRING COMMENT 'Market positioning tier of the brand within the CPG/FMCG portfolio, indicating price-value positioning relative to competition. Drives RSP/MSRP strategy, trade promotion investment levels, and retail channel prioritization. [ENUM-REF-CANDIDATE: premium|mass|value|super_premium|private_label — promote to reference product if tiers expand]. Valid values are `premium|mass|value|super_premium|private_label`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand master record was first created in the system of record. Provides the audit trail entry point for the brands data lifecycle. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the brands products are distributed to consumers. Retail covers brick-and-mortar stores; DTC (Direct to Consumer) covers brand-owned channels; DSD (Direct Store Delivery) covers direct distribution; omnichannel covers integrated multi-channel distribution.. Valid values are `retail|ecommerce|wholesale|dtc|dsd|omnichannel`',
    `divestiture_date` DATE COMMENT 'Date on which the brand was officially divested, sold, or licensed to a third party. Populated only when brand_status is divested. Required for SOX financial reporting and portfolio restructuring audit trails.',
    `ean_prefix` STRING COMMENT 'GS1 company prefix assigned to the brand owner, forming the first digits of all EAN/GTIN barcodes for products under this brand. Enables GS1-compliant product identification and EDI transactions across the global supply chain.. Valid values are `^[0-9]{4,7}$`',
    `equity_methodology` STRING COMMENT 'Methodology or framework used to measure and track brand equity over time. Determines which external measurement partner (Nielsen IQ, Kantar BrandZ, Ipsos) or internal scorecard approach is applied for brand health KPI reporting. [ENUM-REF-CANDIDATE: nielsen_brand_health|kantar_brandz|ipsos_brand_value|internal_scorecard|bav|none — promote to reference product if methodologies expand]. Valid values are `nielsen_brand_health|kantar_brandz|ipsos_brand_value|internal_scorecard|bav|none`',
    `geographic_scope` STRING COMMENT 'Geographic reach of the brands commercial operations. Global brands are sold in multiple continents; regional brands operate within a defined multi-country region; national brands are limited to a single country; local brands serve sub-national markets; export_only brands are manufactured domestically but sold exclusively in foreign markets.. Valid values are `global|regional|national|local|export_only`',
    `gmp_certification_ref` STRING COMMENT 'Reference number or identifier for the GMP certification applicable to the brands manufacturing operations. Required for FDA-regulated brands (21 CFR Parts 110/111/210/211) and cosmetics brands under ISO 22716. Stored in Veeva Vault Quality Documents.',
    `is_licensed_brand` BOOLEAN COMMENT 'Indicates whether the brand is operated under a licensing agreement from a third-party brand owner rather than being wholly owned by the Consumer Goods entity. Licensed brands have different royalty accounting treatment in Oracle Cloud ERP Financials and different regulatory responsibility structures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the brand master record. Used for change data capture (CDC) in the Databricks Silver Layer pipeline, audit compliance, and data freshness monitoring.',
    `launch_date` DATE COMMENT 'Exact calendar date on which the brand was first commercially available to consumers. More precise than brand_launch_year; used for anniversary campaigns, brand lifecycle milestone tracking, and NPD stage-gate reporting.',
    `launch_year` STRING COMMENT 'Calendar year in which the brand was first commercially launched in any market. Used for brand age analytics, heritage positioning, and portfolio vintage analysis in brand equity tracking.',
    `license_expiry_date` DATE COMMENT 'Date on which the brand licensing agreement expires, applicable only when is_licensed_brand is True. Critical for contract renewal planning, financial risk management, and SOX disclosure requirements. Null for wholly-owned brands.',
    `msrp_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the MSRP/RSP defined at the brand level. Provides the currency context for brand-level pricing strategy and trade promotion ROI calculations.. Valid values are `^[A-Z]{3}$`',
    `nps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether active NPS (Net Promoter Score) consumer sentiment tracking is configured for this brand. When True, the brand is enrolled in periodic consumer surveys and NPS measurement programs linked to the consumer domains nps_response product.',
    `owner_division` STRING COMMENT 'Internal business division or strategic business unit (SBU) within the Consumer Goods organization that owns and manages the brand. Used for financial reporting, EBITDA attribution, and S&OP planning alignment in SAP S/4HANA CO module.',
    `owner_entity` STRING COMMENT 'Legal entity name of the company or subsidiary that owns the brand trademark and bears regulatory responsibility for the brand. Critical for SOX financial reporting, regulatory submissions to FDA/EPA/CPSC, and inter-company transfer pricing.',
    `parent_brand_code` STRING COMMENT 'Brand code of the parent or umbrella brand for sub-brands and brand extensions. Enables hierarchical brand architecture modeling (e.g., a skincare sub-brand under a master personal care brand). Null for top-level master brands with no parent.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `plm_stage` STRING COMMENT 'Current stage of the brand in the PLM lifecycle framework. Drives resource allocation, marketing investment levels, and supply chain planning priorities. Concept and development stages are pre-commercial; growth through decline stages are active commercial phases; end_of_life triggers discontinuation planning. [ENUM-REF-CANDIDATE: concept|development|launch|growth|maturity|decline|end_of_life — 7 candidates stripped; promote to reference product]',
    `positioning_statement` STRING COMMENT 'Internal strategic statement articulating the brands unique value proposition, target audience, competitive frame of reference, and key differentiators. Confidential business strategy document used by marketing and trade promotion teams for campaign alignment.',
    `primary_category` STRING COMMENT 'Primary GS1 or internal product category to which the brand belongs (e.g., Household Cleaning, Personal Care, Health & Hygiene, Baby Care). Used for category management, Nielsen IQ market measurement, ACV/TDP reporting, and trade promotion planning.',
    `primary_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary market or country of origin for the brand. Used for regulatory compliance (FDA, EU REACH), customs documentation, and market-level financial reporting.. Valid values are `^[A-Z]{3}$`',
    `regulatory_classification` STRING COMMENT 'FDA/regulatory classification of the brands product portfolio, determining applicable compliance frameworks. OTC drug brands require FDA monograph compliance; cosmetic brands require INCI ingredient declarations per ISO 22716; household chemical brands require EPA registration and SDS documentation. [ENUM-REF-CANDIDATE: otc_drug|cosmetic|food_beverage|household_chemical|medical_device|dietary_supplement|general_merchandise — promote to reference product]',
    `short_name` STRING COMMENT 'Abbreviated or shortened version of the brand name used in space-constrained contexts such as POS displays, planograms (POG), shelf labels, and reporting dashboards where the full brand name may not fit.. Valid values are `^.{1,30}$`',
    `social_media_handle` STRING COMMENT 'Primary social media handle or username for the brand (e.g., @BrandName on Instagram/Twitter/TikTok). Used for SOV (Share of Voice) measurement, digital marketing analytics, and consumer engagement tracking in Nielsen IQ and Salesforce.',
    `source_system_brand_code` STRING COMMENT 'Native brand identifier as stored in the originating operational system (e.g., SAP S/4HANA brand master ID, Salesforce Consumer Goods Cloud brand record ID). Enables reverse lookup and reconciliation between the lakehouse Silver Layer and source systems.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this brand master record originates. Supports data lineage tracking in the Databricks Silver Layer and conflict resolution when multiple systems contribute brand attributes.. Valid values are `SAP_S4|SFDC_CGC|ORACLE_ERP|VEEVA|MANUAL`',
    `sustainability_certification` STRING COMMENT 'Primary sustainability or environmental certification held by the brand, indicating compliance with responsible sourcing and environmental management standards. FSC covers sustainable forestry; RSPO covers sustainable palm oil; ISO 14001 covers environmental management systems.. Valid values are `fsc|rspo|iso_14001|rainforest_alliance|none|multiple`',
    `target_consumer_segment` STRING COMMENT 'Primary consumer demographic or psychographic segment the brand is designed to serve (e.g., Millennial Families, Gen Z Beauty Enthusiasts, Health-Conscious Adults 35-55). Drives brand positioning, media SOV allocation, and NPS/CLTV measurement segmentation.',
    `trade_promotion_eligible` BOOLEAN COMMENT 'Indicates whether the brand is eligible for trade promotion activities managed through TPM/TPO systems (Salesforce Consumer Goods Cloud). Brands marked False may be excluded from promotional funding pools, Hi-Lo pricing events, and EDLP programs.',
    `trademark_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary jurisdiction in which the brand trademark is registered (e.g., USA, GBR, DEU). Supports multi-market brand protection management and regulatory compliance tracking.. Valid values are `^[A-Z]{3}$`',
    `trademark_registration_ref` STRING COMMENT 'Official trademark registration number or reference identifier issued by the relevant intellectual property authority (e.g., USPTO, EUIPO, WIPO). Used for legal protection verification, brand licensing agreements, and regulatory labeling compliance.',
    `website_url` STRING COMMENT 'Official consumer-facing website URL for the brand. Used for DTC channel management, digital marketing attribution, and e-commerce integration. Referenced in Salesforce Consumer Goods Cloud for omnichannel campaign tracking.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_product_brand PRIMARY KEY(`product_brand_id`)
) COMMENT 'Brand master record defining each consumer goods brand in the portfolio. Captures brand code, brand name, brand tier (premium, mass, value), parent brand (for sub-brands), brand owner entity, brand launch year, brand positioning statement, target consumer segment, primary category, brand trademark registration reference, brand status (active, dormant, divested), and the brand equity tracking methodology. Serves as the authoritative brand dimension for marketing, trade promotion, and financial reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` (
    `sku_substitution_id` BIGINT COMMENT 'Unique surrogate identifier for each SKU substitution or supersession relationship record in the product master. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SKU substitution approvals are performed by employees; essential for supply‑chain change control.',
    `sku_id` BIGINT COMMENT 'Reference to the originating SKU being substituted, superseded, or replaced. This is the source product in the substitution relationship, typically the discontinued, reformulated, or out-of-stock item.',
    `to_sku_id` BIGINT COMMENT 'Reference to the replacement or substitute SKU. This is the target product that fulfills demand when the from-SKU is unavailable or discontinued.',
    `approval_date` DATE COMMENT 'The date on which the substitution record received final business or customer approval. Distinct from the effective_date; a substitution may be approved in advance of its operational effective date.',
    `approval_status` STRING COMMENT 'Current approval status for substitutions requiring customer or retailer sign-off. Not_required applies when customer_approval_required is False. Pending indicates awaiting customer response; approved indicates the customer has consented; rejected indicates the customer declined the substitution.. Valid values are `not_required|pending|approved|rejected`',
    `atp_substitution_enabled` BOOLEAN COMMENT 'Indicates whether this substitution relationship is active for ATP (Available to Promise) and CTP (Capable to Promise) calculations in supply planning. When True, the to-SKU inventory is considered when confirming availability for orders requesting the from-SKU.',
    `auto_substitution_allowed` BOOLEAN COMMENT 'Indicates whether the substitution can be executed automatically by order management or ERP systems without manual intervention. False requires a customer service representative or account manager to confirm the substitution before order processing proceeds.',
    `channel_code` STRING COMMENT 'Identifies the specific distribution channel to which this substitution applies when substitution_scope is channel_specific. Examples include DTC (Direct to Consumer), retail, e-commerce, wholesale, DSD (Direct Store Delivery). Null when scope is global or regional.',
    `cogs_impact_pct` DECIMAL(18,2) COMMENT 'Estimated percentage change in COGS (Cost of Goods Sold) resulting from this substitution. Used by finance for COGS bridge analysis across product transitions, particularly for cost optimization and renovation-driven substitutions. Positive values indicate cost increase; negative values indicate cost savings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substitution record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data lineage and compliance reporting.',
    `customer_approval_required` BOOLEAN COMMENT 'Indicates whether explicit customer or retailer approval is required before this substitution can be executed on an order. True for key account or contractual SKU commitments where the buyer must consent to any product change. Drives workflow routing in Salesforce Consumer Goods Cloud account management.',
    `demand_history_normalization` BOOLEAN COMMENT 'Indicates whether demand planning systems should normalize historical sales data by mapping the from-SKU demand history to the to-SKU when the substitution represents a supersession. True enables SAP IBP to consolidate demand signals across the product transition for accurate forecasting.',
    `effective_date` DATE COMMENT 'The calendar date from which this substitution relationship becomes valid and operational. Used by ATP/CTP engines, customer service order management, and demand planning history normalization to determine when the substitution applies.',
    `expiry_date` DATE COMMENT 'The calendar date after which this substitution relationship is no longer valid. Null indicates an open-ended substitution with no planned end date. Used to manage temporary supply shortage substitutions and promotional swaps with defined windows.',
    `is_bidirectional` BOOLEAN COMMENT 'Indicates whether the substitution relationship is bidirectional (True) — meaning either SKU can substitute for the other — or directional (False) — meaning only the from-SKU can be replaced by the to-SKU. Bidirectional substitutions are common for size-equivalent or reformulation-equivalent products.',
    `market_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the market or geography where this substitution is applicable. Null when the substitution is global. Used to manage region-specific regulatory substitutions (e.g., EU REACH-driven reformulations) and market-specific product availability.. Valid values are `^[A-Z]{3}$`',
    `plm_change_order_ref` STRING COMMENT 'Reference to the PLM (Product Lifecycle Management) engineering change order or NPD (New Product Development) project that authorized this substitution. Links the substitution record back to the formal product change governance process in Veeva Vault or the PLM system.',
    `price_adjustment_pct` DECIMAL(18,2) COMMENT 'Percentage price adjustment applied when the substitute SKU carries a different RSP (Recommended Selling Price) or MSRP than the original SKU. Positive values indicate a price increase; negative values indicate a price reduction. Used by finance for COGS bridge analysis and by customer service for order repricing during substitution.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the preference order when multiple substitute SKUs exist for the same from-SKU. Lower values indicate higher preference (1 = most preferred). Used by ATP/CTP and order management systems to select the optimal substitute when multiple options are available.',
    `quantity_conversion_factor` DECIMAL(18,2) COMMENT 'Numeric multiplier applied to convert the ordered quantity of the from-SKU to the equivalent quantity of the to-SKU. For example, a factor of 2.0 means 1 unit of the from-SKU is substituted by 2 units of the to-SKU (e.g., a size change from 500ml to 250ml). Factor of 1.0 indicates a one-for-one substitution.',
    `reason_code` STRING COMMENT 'Business reason driving the substitution relationship. Renovation indicates a product improvement initiative; cost_optimization indicates a COGS reduction program; regulatory_change indicates compliance with FDA, EPA, EU REACH, or other governing body requirements; discontinuation indicates permanent end-of-life; temporary_supply_shortage indicates an OOS-driven interim substitution; reformulation indicates an ingredient or formula change.. Valid values are `renovation|cost_optimization|regulatory_change|discontinuation|temporary_supply_shortage|reformulation`',
    `regulatory_change_ref` STRING COMMENT 'Reference identifier for the regulatory mandate, compliance ruling, or governing body directive that triggered this substitution when reason_code is regulatory_change. Examples include FDA 21 CFR section references, EU REACH substance restriction IDs, EPA compliance notices, or CPSC safety recall numbers.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this substitution record originated. Supports data lineage tracking in the Databricks Silver layer and enables reconciliation across SAP S/4HANA MM, Oracle Cloud ERP, Salesforce Consumer Goods Cloud, and Veeva Vault.. Valid values are `SAP_S4HANA|ORACLE_ERP|SALESFORCE_CGC|VEEVA_VAULT|MANUAL`',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier of this substitution record in the originating operational system (e.g., SAP S/4HANA material substitution record number). Enables traceability and reconciliation between the lakehouse Silver layer and the system of record.',
    `substitution_notes` STRING COMMENT 'Free-text field for additional business context, operational instructions, or caveats associated with this substitution relationship. May include customer communication guidance, handling instructions for customer service teams, or supply chain execution notes.',
    `substitution_scope` STRING COMMENT 'Defines the commercial scope within which this substitution is applicable. Global applies across all markets and channels; regional restricts to a geographic region; customer_specific applies only to a named account; channel_specific applies only to a defined distribution channel (e.g., DTC, retail, wholesale).. Valid values are `global|regional|customer_specific|channel_specific`',
    `substitution_status` STRING COMMENT 'Current lifecycle status of the substitution record. Active indicates the substitution is in effect; pending_approval indicates awaiting customer or commercial sign-off; expired indicates the effective date range has passed; suspended indicates temporarily halted.. Valid values are `active|inactive|pending_approval|expired|suspended`',
    `substitution_type` STRING COMMENT 'Classifies the nature of the substitution relationship between the from-SKU and to-SKU. Direct replacement indicates a like-for-like swap; reformulation indicates a change in product formula; repack indicates a packaging change; size_change indicates a net content or pack size change; promotional_swap indicates a temporary trade promotion substitution; supersession indicates a permanent product lifecycle transition.. Valid values are `direct_replacement|reformulation|repack|size_change|promotional_swap|supersession`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this substitution record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver layer and for audit trail compliance.',
    `veeva_document_reference` STRING COMMENT 'Reference identifier for the supporting quality or regulatory document stored in Veeva Vault that provides evidence or authorization for this substitution, such as a formulation change approval, regulatory submission, or quality release document.',
    CONSTRAINT pk_sku_substitution PRIMARY KEY(`sku_substitution_id`)
) COMMENT 'Defines approved substitution, supersession, and equivalence relationships between SKUs, capturing the from-SKU, to-SKU, substitution type (direct replacement, reformulation, repack, size change, promotional swap), effective date range, priority/preference rank, reason code (renovation, cost optimization, regulatory change, discontinuation, temporary supply shortage), customer approval requirement flag, and whether the substitution is bidirectional or directional. Used by supply chain for ATP/CTP available-to-promise calculations, by customer service for order substitution during stockouts, by demand planning for history normalization when SKUs are superseded, and by finance for COGS bridge analysis across product transitions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` (
    `pack_hierarchy_id` BIGINT COMMENT 'Unique identifier for the pack hierarchy record. Primary key.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which this pack hierarchy is defined. Links to the product master.',
    `parent_sku_id` BIGINT COMMENT 'add column parent_sku_id (BIGINT) with FK to product.sku.sku_id - pack hierarchy needs a parent SKU reference to represent case/pallet/each relationships',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pack hierarchy record was first created in the system.',
    `cumulative_quantity` STRING COMMENT 'The total number of consumer units (eaches) contained in this packaging level. For a case containing 6 inner packs of 12 eaches, this would be 72.',
    `display_ready_flag` BOOLEAN COMMENT 'Indicates whether this packaging level is designed as a retail-ready display unit that can be placed directly on the sales floor without unpacking.',
    `ean` STRING COMMENT 'The 13-digit EAN barcode identifier for this packaging level, used internationally for consumer units.. Valid values are `^[0-9]{13}$`',
    `effective_end_date` DATE COMMENT 'The date on which this pack hierarchy configuration is no longer valid, supporting packaging changes and product lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this pack hierarchy configuration becomes active and valid for use in operations.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'The total weight of the packaging at this level including product and packaging materials, measured in kilograms.',
    `gtin` STRING COMMENT 'The GS1 Global Trade Item Number assigned to this packaging level. May be GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14 (case/pallet).. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `height_cm` DECIMAL(18,2) COMMENT 'The height dimension of the packaging at this level, measured in centimeters.',
    `hi_count` STRING COMMENT 'The number of layers stacked on a pallet (Hi in Ti-Hi configuration). Used for pallet configuration and warehouse planning.',
    `hierarchy_level` STRING COMMENT 'The packaging level within the hierarchy: each (consumer unit), inner pack (multi-pack), case (shipper), display unit (retail-ready), pallet (full pallet), or layer (pallet layer).. Valid values are `each|inner_pack|case|display_unit|pallet|layer`',
    `length_cm` DECIMAL(18,2) COMMENT 'The length dimension of the packaging at this level, measured in centimeters.',
    `max_stack_height` STRING COMMENT 'The maximum number of units of this packaging level that can be safely stacked vertically.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pack hierarchy record was last modified or updated.',
    `moq` STRING COMMENT 'The minimum order quantity required for this packaging level, used in order processing and trade promotion planning.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'The weight of the product content only at this level, excluding packaging materials, measured in kilograms.',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this packaging level can be ordered by customers or retailers through EDI or other ordering systems.',
    `pack_hierarchy_status` STRING COMMENT 'The current lifecycle status of this pack hierarchy configuration: active (in use), inactive (temporarily suspended), pending (awaiting approval), or discontinued (permanently retired).. Valid values are `active|inactive|pending|discontinued`',
    `packaging_material` STRING COMMENT 'The primary material used for packaging at this level: corrugated cardboard, plastic, wood, metal, composite, or shrink wrap.. Valid values are `corrugated_cardboard|plastic|wood|metal|composite|shrink_wrap`',
    `pallet_type` STRING COMMENT 'The type of pallet used for this packaging level: standard (48x40 inches), euro (1200x800 mm), block, custom, half, or quarter pallet.. Valid values are `standard|euro|block|custom|half|quarter`',
    `quantity_per_level` STRING COMMENT 'The number of units from the next lower hierarchy level contained in this level (e.g., 12 eaches per inner pack, 6 inner packs per case).',
    `recyclable_flag` BOOLEAN COMMENT 'Indicates whether the packaging material at this level is recyclable according to local recycling standards.',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'The percentage of recycled material content in the packaging at this level, supporting sustainability reporting.',
    `shippable_flag` BOOLEAN COMMENT 'Indicates whether this packaging level is suitable for direct shipment to customers or distribution centers.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this packaging level can be safely stacked on top of similar units during storage and transportation.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'The weight of the packaging materials only at this level, excluding product content, measured in kilograms.',
    `ti_count` STRING COMMENT 'The number of cases or units per layer on a pallet (Ti in Ti-Hi configuration). Used for pallet configuration and warehouse planning.',
    `upc` STRING COMMENT 'The 12-digit UPC barcode identifier for this packaging level, primarily used in North America for consumer units.. Valid values are `^[0-9]{12}$`',
    `volume_cubic_cm` DECIMAL(18,2) COMMENT 'The cubic volume of the packaging at this level, measured in cubic centimeters. Used for warehouse slotting and transportation cube optimization.',
    `width_cm` DECIMAL(18,2) COMMENT 'The width dimension of the packaging at this level, measured in centimeters.',
    CONSTRAINT pk_pack_hierarchy PRIMARY KEY(`pack_hierarchy_id`)
) COMMENT 'Defines the packaging hierarchy levels for each SKU — each/unit, inner pack, case/shipper, display unit, and pallet — including the quantity per level, GTIN per level, dimensions, weight, and Ti-Hi (tier × height) pallet configuration. Supports warehouse slotting, DRP replenishment calculations, transportation cube optimization, and retailer EDI order processing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the product certification record. Primary key.',
    `product_formulation_id` BIGINT COMMENT 'Reference to the specific formulation version that is certified. Allows certification tracking at the formulation level when a SKU has multiple formulations.',
    `regulatory_registration_id` BIGINT COMMENT 'add column regulatory_registration_id (BIGINT) with FK to regulatory.regulatory_registration.regulatory_registration_id - product certifications often correspond to regulatory registrations',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Certification responsibility is assigned to an employee; needed for audit trails and renewal management.',
    `sku_id` BIGINT COMMENT 'Reference to the product or SKU (Stock Keeping Unit) that holds this certification. Links to the product master data.',
    `applicable_channels` STRING COMMENT 'Comma-separated list of sales channels where this certification applies and can be claimed. Examples: retail, e-commerce, DTC (Direct to Consumer), food service, professional, wholesale.',
    `applicable_markets` STRING COMMENT 'Comma-separated list of geographic markets or countries where this certification is recognized and can be claimed. Uses ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU, FRA, JPN).',
    `audit_date` DATE COMMENT 'The date of the most recent audit or inspection conducted by the certification body to verify ongoing compliance.',
    `audit_result` STRING COMMENT 'The outcome of the most recent audit. Passed indicates full compliance. Passed with conditions indicates minor non-conformances that must be addressed. Failed indicates major non-conformances.. Valid values are `passed|passed_with_conditions|failed|not_applicable`',
    `body` STRING COMMENT 'The name of the third-party organization or authority that issued the certification. Examples: RSPO Secretariat, Forest Stewardship Council, Cruelty Free International, Ecocert, NSF International, Islamic Food and Nutrition Council of America, Orthodox Union.',
    `certificate_document_reference` STRING COMMENT 'Reference path or identifier to the official certificate document in the document management system (e.g., Veeva Vault). Used for regulatory submissions and retailer compliance requests.',
    `certificate_number` STRING COMMENT 'The unique certificate or license number assigned by the certification body. Used for verification and audit trail purposes.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Active indicates the certification is valid and in force. Expired means the certification has passed its expiry date. Suspended indicates temporary hold. Revoked means the certification has been withdrawn. Pending and under_review indicate application or renewal in progress.. Valid values are `active|expired|suspended|revoked|pending|under_review`',
    `certification_type` STRING COMMENT 'The type or name of the third-party certification or compliance attestation. Examples include RSPO (Roundtable on Sustainable Palm Oil), FSC (Forest Stewardship Council), Leaping Bunny (cruelty-free), COSMOS Organic, NSF, Halal, Kosher, EPA Safer Choice, ISO 22716 GMP (Good Manufacturing Practice). [ENUM-REF-CANDIDATE: RSPO|FSC|Leaping Bunny|COSMOS Organic|NSF|Halal|Kosher|EPA Safer Choice|ISO 22716|Fair Trade|Rainforest Alliance|USDA Organic|Ecocert|Vegan Society|B Corp|Carbon Neutral|Cradle to Cradle|EWG Verified|Non-GMO Project|PETA Cruelty-Free|Other — promote to reference product]',
    `claim_text` STRING COMMENT 'The approved marketing claim or statement that can be used on packaging, advertising, and digital channels to communicate this certification to consumers. Must match certification body guidelines.',
    `consumer_facing_flag` BOOLEAN COMMENT 'Indicates whether this certification is actively promoted to consumers on packaging, advertising, and digital channels. True means the certification is part of the brands consumer value proposition.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost paid to obtain and maintain this certification, including application fees, audit fees, and annual licensing fees. Used for sustainability ROI analysis.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the certification cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and the product can carry the certification claim or logo.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid unless renewed. Null if the certification has no expiration.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued by the certification body.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was most recently modified. Used for audit trail and change tracking.',
    `logo_file_reference` STRING COMMENT 'Reference path or identifier to the approved certification logo file in the digital asset management system. Used by packaging and marketing teams.',
    `logo_usage_approved` BOOLEAN COMMENT 'Indicates whether the company is authorized to display the certification bodys logo or seal on product packaging and marketing materials.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next audit or surveillance visit by the certification body.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, exclusions, or internal notes related to this certification. May include audit findings, renewal reminders, or scope limitations.',
    `renewal_date` DATE COMMENT 'The date by which the certification must be renewed to maintain continuous compliance. May differ from expiry date to allow for renewal processing time.',
    `retailer_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is required by one or more key retail customers as a condition of distribution. True means at least one retailer mandates this certification.',
    `scope` STRING COMMENT 'Detailed description of what the certification covers. May specify ingredients, packaging materials, manufacturing processes, supply chain stages, or product categories included in the certification scope.',
    `standard_version` STRING COMMENT 'The version or edition of the certification standard under which the product was certified. Important for tracking compliance with evolving standards.',
    `sustainability_pillar` STRING COMMENT 'The primary sustainability or ESG (Environmental Social Governance) pillar that this certification supports. Used for sustainability reporting and ESG disclosure alignment.. Valid values are `environmental|social|ethical|quality|safety|health`',
    `verification_url` STRING COMMENT 'Public URL where consumers, retailers, or auditors can verify the authenticity of this certification using the certificate number. Supports transparency and claim substantiation.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Tracks third-party certifications and compliance attestations held by a SKU or formulation, such as RSPO (sustainable palm oil), FSC (sustainable packaging), Leaping Bunny (cruelty-free), COSMOS Organic, NSF, Halal, Kosher, EPA Safer Choice, and ISO 22716 GMP. Each record captures certification body, certificate number, certification scope, issue date, expiry date, renewal status, and the applicable markets. Supports sustainability reporting, retailer compliance, and consumer-facing claim substantiation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` (
    `product_registration_id` BIGINT COMMENT 'Primary key for the registration association',
    `jurisdiction_id` BIGINT COMMENT 'add column jurisdiction_id (BIGINT) with FK to regulatory.jurisdiction.jurisdiction_id - product registrations are jurisdiction-specific',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to the shopper who registers the SKU',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU being registered',
    `registration_date` DATE COMMENT 'Date the SKU was registered by the shopper',
    `registration_source` STRING COMMENT 'Source channel through which the registration was made (e.g., online, in‑store)',
    `warranty_status` STRING COMMENT 'Current warranty status of the registered SKU (e.g., active, expired)',
    CONSTRAINT pk_product_registration PRIMARY KEY(`product_registration_id`)
) COMMENT 'Represents the warranty/recall registration linking a SKU to a shopper. Each record captures when and how a shopper registered a product and the current warranty status.. Existence Justification: Consumers actively register each purchased SKU for warranty and recall purposes. A single SKU can be registered by many shoppers, and a shopper can register many different SKUs. The registration itself carries attributes such as registration date, source, and warranty status, making it an operational M:N relationship.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` (
    `vmi_sku_assignment_id` BIGINT COMMENT 'Primary key for the vmi_sku_assignment association',
    `customer_vmi_agreement_id` BIGINT COMMENT 'Foreign key linking to the VMI agreement record',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU master record',
    `forecast_sharing_cadence` STRING COMMENT 'Frequency at which the trade account shares demand forecasts for this SKU',
    `max_inventory_weeks_of_supply` DECIMAL(18,2) COMMENT 'Maximum inventory target expressed as weeks of supply for this SKU',
    `min_inventory_weeks_of_supply` DECIMAL(18,2) COMMENT 'Minimum inventory target expressed as weeks of supply for this SKU',
    `replenishment_frequency` STRING COMMENT 'Cadence at which the manufacturer reviews inventory levels for this SKU under the VMI agreement',
    `replenishment_lead_time_days` STRING COMMENT 'Committed lead time in days from replenishment order creation to delivery for this SKU',
    `safety_stock_weeks` DECIMAL(18,2) COMMENT 'Buffer inventory expressed as weeks of supply for this SKU',
    CONSTRAINT pk_vmi_sku_assignment PRIMARY KEY(`vmi_sku_assignment_id`)
) COMMENT 'This association product represents the contract between a SKU and a customer VMI agreement. It captures the operational parameters that govern how inventory for each SKU is managed under the VMI program, including replenishment cadence, lead times, inventory targets, and forecast sharing settings.. Existence Justification: A SKU can be covered by multiple VMI agreements with different trade accounts, and each VMI agreement can include many SKUs. The agreement records specific parameters (replenishment frequency, lead time, inventory targets, forecast cadence) for each SKU, and the business actively creates, updates, and deletes these mappings as part of VMI program management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` (
    `freight_contract_assignment_id` BIGINT COMMENT 'Primary key for the freight_contract_assignment association',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to carrier contract',
    `sku_id` BIGINT COMMENT 'Foreign key linking to SKU',
    `agreed_rate` DECIMAL(18,2) COMMENT 'Negotiated freight rate for the SKU under this carrier contract',
    `effective_date` DATE COMMENT 'Date when the contract terms become effective for this SKU',
    `expiry_date` DATE COMMENT 'Date when the contract terms expire for this SKU',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Committed shipment volume for the SKU under this contract',
    CONSTRAINT pk_freight_contract_assignment PRIMARY KEY(`freight_contract_assignment_id`)
) COMMENT 'This association captures the contractual relationship between a product SKU and a carrier contract, including the agreed freight rate, volume commitments, and contract effective/expiry dates for each SKU‑carrier pairing.. Existence Justification: In the consumer goods business, each SKU can be covered by multiple carrier contracts, and each carrier contract can apply to multiple SKUs. The company actively creates and maintains these contract records, capturing agreed rates, volume commitments, and effective/expiry dates for each SKU‑carrier pairing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the SupplyAgreement association',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU master record',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to the supplier contract',
    `lead_time_days` STRING COMMENT 'Expected lead time in days for delivery of the SKU under this contract',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered for this SKU under the contract',
    `price_uom` STRING COMMENT 'Unit of measure for the unit price (e.g., USD per kg)',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed unit price for the SKU under this contract',
    `validity_end_date` DATE COMMENT 'Date when the contract line item expires for the SKU',
    `validity_start_date` DATE COMMENT 'Date when the contract line item becomes effective for the SKU',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'This association captures the contractual relationship between a SKU and a supplier contract. Each record links one SKU to one supplier contract and stores attributes that are specific to that contract‑SKU pairing, such as pricing, quantity commitments, and validity periods.. Existence Justification: A SKU can be sourced from multiple supplier contracts, each with its own pricing, quantity, and validity terms. Conversely, a single supplier contract can cover many SKUs across the portfolio. Procurement teams actively create, update, and retire these contract‑SKU links, and the link itself stores attributes such as unit price, lead time, and contract validity dates.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Primary key for category',
    `parent_category_id` BIGINT COMMENT 'Identifier of the immediate parent category in the hierarchy (null for top‑level).',
    `classification_type` STRING COMMENT 'Business classification indicating the nature of the category.',
    `category_code` STRING COMMENT 'Standardized alphanumeric code identifying the category (e.g., GS1 segment).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system.',
    `category_description` STRING COMMENT 'Detailed textual description of the category, its purpose and typical product types.',
    `display_order` STRING COMMENT 'Ordinal value used to order categories in UI listings.',
    `effective_from` DATE COMMENT 'Date when the category becomes active for product assignment.',
    `effective_until` DATE COMMENT 'Date when the category is retired or no longer usable (null if open‑ended).',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the category within the hierarchy (1 = top level).',
    `image_url` STRING COMMENT 'Link to the representative image for the category.',
    `is_leaf` BOOLEAN COMMENT 'Flag indicating whether the category has no child categories.',
    `marketing_tag` STRING COMMENT 'Marketing label applied to the category for promotional purposes.',
    `category_name` STRING COMMENT 'Human‑readable name of the product category.',
    `category_status` STRING COMMENT 'Current lifecycle status of the category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Master reference table for category. Referenced by category_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`material` (
    `material_id` BIGINT COMMENT 'Primary key for material',
    `parent_material_id` BIGINT COMMENT 'Self-referencing FK on material (parent_material_id)',
    `supplier_id` BIGINT COMMENT 'Identifier of the primary supplier for the material.',
    `allergen_info` STRING COMMENT 'Allergen declarations associated with the material, if applicable.',
    `base_uom` STRING COMMENT 'Standard unit of measure used for inventory and transactions.',
    `brand_name` STRING COMMENT 'Brand under which the material is marketed.',
    `material_code` STRING COMMENT 'Internal stock‑keeping unit or catalogue code that uniquely identifies the material within the enterprise.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO code of the country where the material is produced.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the standard cost.',
    `material_description` STRING COMMENT 'Free‑form textual description of the material, including usage notes.',
    `ean` STRING COMMENT '13‑digit European article number for the material.',
    `effective_from` DATE COMMENT 'Date when the material becomes effective for business use.',
    `effective_until` DATE COMMENT 'Date when the material is retired or no longer valid (null if open‑ended).',
    `gtin` STRING COMMENT '14‑digit global identifier assigned to the material for trade and retail purposes.',
    `hazardous_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under safety regulations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the material record.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the material within its product lifecycle.',
    `material_group` STRING COMMENT 'Higher‑level grouping used for reporting and analytics.',
    `material_type` STRING COMMENT 'Category describing the nature of the material within the product hierarchy.',
    `material_name` STRING COMMENT 'Human‑readable name of the material used in catalogs and reports.',
    `packaging_type` STRING COMMENT 'Primary packaging format for the material.',
    `regulatory_status` STRING COMMENT 'Current compliance status of the material with relevant regulations.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before expiration.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Default cost price of the material used for costing and pricing calculations.',
    `material_status` STRING COMMENT 'Current lifecycle state of the material.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Optimal storage temperature for the material in degrees Celsius.',
    `unit_conversion_factor` DECIMAL(18,2) COMMENT 'Factor to convert from the materials base UOM to alternative units.',
    `upc` STRING COMMENT '12‑digit UPC code used primarily in North America.',
    `volume_l` DECIMAL(18,2) COMMENT 'Typical volume of the material per unit, expressed in liters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of a single unit of material expressed in kilograms.',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Master reference table for material. Referenced by material_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` (
    `sku_group_id` BIGINT COMMENT 'Primary key for sku_group',
    `parent_group_id` BIGINT COMMENT 'Identifier of the parent SKU group in a hierarchical grouping structure.',
    `parent_sku_group_id` BIGINT COMMENT 'Self-referencing FK on sku_group (parent_sku_group_id)',
    `average_price` DECIMAL(18,2) COMMENT 'Average retail price of SKUs in the group, expressed in US dollars.',
    `sku_group_code` STRING COMMENT 'Business code used to identify the SKU group across systems (e.g., internal catalog code).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the SKU group record was first created in the system.',
    `sku_group_description` STRING COMMENT 'Detailed description of the SKU group, including purpose and any special handling notes.',
    `effective_end_date` DATE COMMENT 'Date on which the SKU group ceases to be active; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date from which the SKU group is considered active for business processes.',
    `hierarchy_level` STRING COMMENT 'Numeric level of the group within the SKU hierarchy (1 = top level).',
    `is_default` BOOLEAN COMMENT 'Indicates whether this SKU group is the default grouping for its category.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or quality audit performed on the SKU group.',
    `sku_group_name` STRING COMMENT 'Human‑readable name of the SKU group.',
    `notes` STRING COMMENT 'Free‑form field for any extra information or remarks about the SKU group.',
    `packaging_type` STRING COMMENT 'Standard packaging format used for the SKUs in this group.',
    `product_count` STRING COMMENT 'Number of individual SKUs assigned to this group.',
    `regulatory_status` STRING COMMENT 'Current regulatory compliance status of the SKU group.',
    `sku_group_status` STRING COMMENT 'Current lifecycle state of the SKU group.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all SKUs in the group, measured in kilograms.',
    `sku_group_type` STRING COMMENT 'Classification of the group indicating its business purpose or hierarchy level.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the SKU group record.',
    CONSTRAINT pk_sku_group PRIMARY KEY(`sku_group_id`)
) COMMENT 'Master reference table for sku_group. Referenced by sku_group_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_category` (
    `product_category_id` BIGINT COMMENT 'Primary key for product_category',
    `parent_category_id` BIGINT COMMENT 'Identifier of the immediate parent category to support hierarchical classification.',
    `parent_product_category_id` BIGINT COMMENT 'Self-referencing FK on product_category (parent_product_category_id)',
    `business_unit` STRING COMMENT 'Business unit responsible for the category (e.g., global, regional, local).',
    `category_code` STRING COMMENT 'Business code that uniquely identifies the category within the enterprise (e.g., internal SKU hierarchy code).',
    `category_description` STRING COMMENT 'Detailed textual description of the category, its purpose and typical product types.',
    `category_name` STRING COMMENT 'Human‑readable name of the product category as used in catalogs and reports.',
    `classification` STRING COMMENT 'High‑level business classification of the category for reporting and analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the category becomes valid for use in the product master.',
    `effective_until` DATE COMMENT 'Date when the category is retired or no longer valid (null if open‑ended).',
    `hierarchy_level` STRING COMMENT 'Depth of the category within the hierarchy (root = 0).',
    `hierarchy_path` STRING COMMENT 'Slash‑delimited path of ancestor category IDs (e.g., "/1/5/9").',
    `is_leaf` BOOLEAN COMMENT 'True if the category has no child categories; otherwise False.',
    `source_system_code` STRING COMMENT 'Identifier of the category in the source system (e.g., SAP material group code).',
    `product_category_status` STRING COMMENT 'Current lifecycle status of the category (e.g., active for use, deprecated for retirement).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    CONSTRAINT pk_product_category PRIMARY KEY(`product_category_id`)
) COMMENT 'Master reference table for product_category. Referenced by product_category_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_sku_group_id` FOREIGN KEY (`sku_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_hierarchy_id` FOREIGN KEY (`parent_hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ADD CONSTRAINT `fk_product_product_formulation_ingredient_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_to_sku_id` FOREIGN KEY (`to_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ADD CONSTRAINT `fk_product_pack_hierarchy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ADD CONSTRAINT `fk_product_pack_hierarchy_parent_sku_id` FOREIGN KEY (`parent_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_parent_material_id` FOREIGN KEY (`parent_material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ADD CONSTRAINT `fk_product_sku_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ADD CONSTRAINT `fk_product_sku_group_parent_sku_group_id` FOREIGN KEY (`parent_sku_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_parent_product_category_id` FOREIGN KEY (`parent_product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Default Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `innovation_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Innovation Brief Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_group_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Group Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Product Color');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'SKU Discontinuation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `fefo_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `inci_declaration` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_recyclable_packaging` SET TAGS ('dbx_business_glossary_term' = 'Recyclable Packaging Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_regulated_product` SET TAGS ('dbx_business_glossary_term' = 'Regulated Product Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_sustainable` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Product Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'SKU Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `msrp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `net_content` SET TAGS ('dbx_business_glossary_term' = 'Net Content (Quantity)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `net_content_uom` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size (Consumer Units per Pack)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `packaging_material_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Packaging Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `portfolio_classification` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `portfolio_classification` SET TAGS ('dbx_value_regex' = 'core|strategic|tail|innovation|seasonal|limited_edition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_form` SET TAGS ('dbx_business_glossary_term' = 'Product Form');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `scent` SET TAGS ('dbx_business_glossary_term' = 'Scent / Fragrance Descriptor');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|discontinued|pending_launch');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_temperature|dry|flammable');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sub_brand` SET TAGS ('dbx_business_glossary_term' = 'Sub-Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `total_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Total Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `variant` SET TAGS ('dbx_business_glossary_term' = 'Product Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Product Volume (Millilitres)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Registry ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Activation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Assignment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `barcode_symbology` SET TAGS ('dbx_business_glossary_term' = 'Barcode Symbology');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `brand_owner_gln` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `brand_owner_gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `cases_per_pallet` SET TAGS ('dbx_business_glossary_term' = 'Cases Per Pallet');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `check_digit` SET TAGS ('dbx_business_glossary_term' = 'GTIN Check Digit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `check_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `data_pool_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Data Pool Publication Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `data_pool_published` SET TAGS ('dbx_business_glossary_term' = 'Data Pool Published Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `ean_value` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `edi_eligible` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_business_glossary_term' = 'GS1 Global Product Classification (GPC) Brick Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_business_glossary_term' = 'GS1 Company Prefix');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_member_org` SET TAGS ('dbx_business_glossary_term' = 'GS1 Member Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_registration_reference` SET TAGS ('dbx_business_glossary_term' = 'GS1 Registration Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_registry_published` SET TAGS ('dbx_business_glossary_term' = 'GS1 Registry Published Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_format` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Format');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_format` SET TAGS ('dbx_value_regex' = 'GTIN-8|GTIN-12|GTIN-13|GTIN-14');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_value` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `indicator_digit` SET TAGS ('dbx_business_glossary_term' = 'GTIN-14 Indicator Digit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `indicator_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `inner_packs_per_case` SET TAGS ('dbx_business_glossary_term' = 'Inner Packs Per Case');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `is_consumer_unit` SET TAGS ('dbx_business_glossary_term' = 'Consumer Unit Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `is_scannable` SET TAGS ('dbx_business_glossary_term' = 'Scannable Barcode Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `is_variable_measure` SET TAGS ('dbx_business_glossary_term' = 'Variable Measure Item Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `item_reference_number` SET TAGS ('dbx_business_glossary_term' = 'GS1 Item Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `net_content_uom` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `net_content_value` SET TAGS ('dbx_business_glossary_term' = 'Net Content Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'each|inner_pack|case|pallet');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `plm_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `plm_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'concept|development|commercialization|active|end_of_life|discontinued');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'GTIN Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Retirement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Natural Key');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `target_market_country` SET TAGS ('dbx_business_glossary_term' = 'Target Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `target_market_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `units_per_case` SET TAGS ('dbx_business_glossary_term' = 'Units Per Case');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `upc_value` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `parent_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `cpsc_regulated` SET TAGS ('dbx_business_glossary_term' = 'CPSC Regulated Flag (Consumer Product Safety Commission)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `gmp_standard` SET TAGS ('dbx_business_glossary_term' = 'GMP Standard (Good Manufacturing Practice)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `gmp_standard` SET TAGS ('dbx_value_regex' = 'ISO 22716|GMP 21 CFR 111|GMP 21 CFR 210|GMP 21 CFR 211|OSHA|None');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_business_glossary_term' = 'GPC Brick Code (Global Product Classification)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `gpc_brick_name` SET TAGS ('dbx_business_glossary_term' = 'GPC Brick Name (Global Product Classification)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `ibp_planning_level` SET TAGS ('dbx_business_glossary_term' = 'IBP Planning Level Flag (Integrated Business Planning)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `inci_applicable` SET TAGS ('dbx_business_glossary_term' = 'INCI Applicable Flag (International Nomenclature of Cosmetic Ingredients)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `iri_category_code` SET TAGS ('dbx_business_glossary_term' = 'IRI Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `level_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `market_share_reportable` SET TAGS ('dbx_business_glossary_term' = 'Market Share Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `nielsen_category_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen IQ Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Full Path');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `plm_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'PLM Lifecycle Stage (Product Lifecycle Management)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `reach_regulated` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Regulated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `source_system_node_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `trade_promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_subdomain' = 'formulation_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant / Production Site ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `alternative_bom` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bill of Materials (BOM) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'BOM Base Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_category` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_category` SET TAGS ('dbx_value_regex' = 'material|equipment|functional_location|document');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_description` SET TAGS ('dbx_business_glossary_term' = 'BOM Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'BOM Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'production|costing|engineering|sales|configurable');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `component_count` SET TAGS ('dbx_business_glossary_term' = 'BOM Component Count');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `costing_relevance` SET TAGS ('dbx_business_glossary_term' = 'Costing Relevance Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `costing_relevance` SET TAGS ('dbx_value_regex' = 'relevant|not_relevant|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'BOM Deletion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Configurable BOM Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `is_phantom` SET TAGS ('dbx_business_glossary_term' = 'Phantom Assembly Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `last_changed_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Last Changed By');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Last Changed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'BOM Lot Size From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'BOM Lot Size To');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `lot_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `mrp_relevance` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Relevance Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `plm_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `plm_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|active|obsolete|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Regulation Compliant Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `source_system_bom_code` SET TAGS ('dbx_business_glossary_term' = 'Source System BOM Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'BOM Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'formulation_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Item ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `alternative_priority` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_item_category` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_item_category` SET TAGS ('dbx_value_regex' = 'stock|non_stock|variable_size|document|text|class');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bulk_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `co_product_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Product Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Component Cost (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_item_number` SET TAGS ('dbx_business_glossary_term' = 'Component Item Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging|semi_finished|finished_good|co_product|by_product');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `fixed_quantity_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Quantity Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `is_alternative_item` SET TAGS ('dbx_business_glossary_term' = 'Is Alternative Item Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `is_critical_component` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Component Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `issue_method` SET TAGS ('dbx_business_glossary_term' = 'Component Issue Method');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `issue_method` SET TAGS ('dbx_value_regex' = 'backflush|manual|pick_list|kanban');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Production Operation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `phantom_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Phantom Item Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `recursive_bom_flag` SET TAGS ('dbx_business_glossary_term' = 'Recursive BOM Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `usage_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Usage Probability Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` SET TAGS ('dbx_subdomain' = 'formulation_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `active_ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `active_ingredient_pct` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `active_ingredient_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `bom_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `bom_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `color_description` SET TAGS ('dbx_business_glossary_term' = 'Formulation Color Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Formulation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Formulation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `fragrance_code` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `fragrance_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `inci_declaration` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `is_cruelty_free` SET TAGS ('dbx_business_glossary_term' = 'Cruelty Free Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `is_fragrance_free` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Free Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Formulation Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `lab_notebook_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Notebook Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Formulation Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'lab_development|pilot|stability_testing|regulatory_review|approved|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Obsolescence Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `ph_max` SET TAGS ('dbx_business_glossary_term' = 'Formulation pH Maximum');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `ph_min` SET TAGS ('dbx_business_glossary_term' = 'Formulation pH Minimum');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `preservative_system` SET TAGS ('dbx_business_glossary_term' = 'Preservative System');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `rd_project_code` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `rd_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^d{2}-d{10}-d{2}-d{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'cosmetic|otc_drug|household_chemical|biocide|medical_device|food_contact');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-_]{2,50}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `stability_period_months` SET TAGS ('dbx_business_glossary_term' = 'Stability Period (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `total_solid_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Solid Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `viscosity_max_cps` SET TAGS ('dbx_business_glossary_term' = 'Formulation Viscosity Maximum (cPs)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `viscosity_min_cps` SET TAGS ('dbx_business_glossary_term' = 'Formulation Viscosity Minimum (cPs)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` SET TAGS ('dbx_subdomain' = 'formulation_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `product_formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Ingredient ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `raw_material_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_max_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_min_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_min_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_nominal_pct` SET TAGS ('dbx_business_glossary_term' = 'Nominal Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_nominal_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_uom` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `concentration_uom` SET TAGS ('dbx_value_regex' = '% w/w|% v/v|% w/v|ppm|ppb|mg/kg');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Authorization Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `fda_status` SET TAGS ('dbx_business_glossary_term' = 'FDA Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `fda_status` SET TAGS ('dbx_value_regex' = 'approved|gras|permitted|restricted|prohibited|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ghs_hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `grade_specification` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Grade Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `halal_status` SET TAGS ('dbx_business_glossary_term' = 'Halal Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `halal_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|not_applicable|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ifra_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ifra_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ingredient_function` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Functional Role');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Common Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `ingredient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|approved|rejected|phased_out');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `is_active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `is_fragrance_allergen` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Allergen Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `is_natural_origin` SET TAGS ('dbx_business_glossary_term' = 'Natural Origin Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `is_palm_derived` SET TAGS ('dbx_business_glossary_term' = 'Palm-Derived Ingredient Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `is_prohibited_substance` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Substance Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `is_restricted_substance` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `natural_origin_index` SET TAGS ('dbx_business_glossary_term' = 'Natural Origin Index (NOI)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Country of Origin Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Physical Form');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `reach_registration_status` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `reach_registration_status` SET TAGS ('dbx_value_regex' = 'registered|pre-registered|exempt|not_required|pending|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `regulatory_limit_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Concentration Limit Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `regulatory_max_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Maximum Concentration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Supplier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `supplier_material_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `svhc_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance of Very High Concern (SVHC) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `vegan_status` SET TAGS ('dbx_business_glossary_term' = 'Vegan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `vegan_status` SET TAGS ('dbx_value_regex' = 'vegan|non_vegan|unknown|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` SET TAGS ('dbx_subdomain' = 'formulation_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `product_packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `artwork_ref` SET TAGS ('dbx_business_glossary_term' = 'Artwork Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `artwork_ref` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Packaging Color');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Component Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `finish` SET TAGS ('dbx_business_glossary_term' = 'Packaging Surface Finish');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `gross_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (grams)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Height (mm)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `hi` SET TAGS ('dbx_business_glossary_term' = 'Pallet Height (Hi)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `is_fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `is_rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Packaging Component Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Length (mm)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|obsolete|discontinued');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|display_unit|pallet');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `pcr_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Post-Consumer Recycled (PCR) Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `print_method` SET TAGS ('dbx_business_glossary_term' = 'Packaging Print Method');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `qty_per_parent` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Parent Packaging Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `recyclability_code` SET TAGS ('dbx_business_glossary_term' = 'How2Recycle Recyclability Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `recyclability_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `supplier_tooling_ref` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tooling Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `supplier_tooling_ref` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `tare_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (grams)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `ti` SET TAGS ('dbx_business_glossary_term' = 'Pallet Tier (Ti)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Component Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Width (mm)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `plm_transition_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Transition ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Project ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Gate Approval Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Transition Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `from_stage_code` SET TAGS ('dbx_business_glossary_term' = 'From Stage Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `from_stage_code` SET TAGS ('dbx_value_regex' = 'Ideation|Concept|Feasibility|Development|Pilot|Scale-Up');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `gate_criteria_detail` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Detail');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `gate_criteria_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Validation Result');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `gate_criteria_validation_result` SET TAGS ('dbx_value_regex' = 'Pass|Conditional Pass|Fail|Not Evaluated');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `gate_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `is_fast_track` SET TAGS ('dbx_business_glossary_term' = 'Fast Track Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `revised_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PLM|VEEVA_VAULT|ORACLE_ERP|MANUAL');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `source_system_transition_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transition ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `stage_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `stage_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Exit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `to_stage_code` SET TAGS ('dbx_business_glossary_term' = 'To Stage Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `to_stage_code` SET TAGS ('dbx_value_regex' = 'Concept|Feasibility|Development|Pilot|Scale-Up|Launch');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_date` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_value_regex' = 'NPD_PROGRESSION|RENOVATION|REFORMULATION|REGULATORY|DISCONTINUATION|ROLLBACK');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_reference_number` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_status` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|Withdrawn|Superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_type` SET TAGS ('dbx_business_glossary_term' = 'PLM Transition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `transition_type` SET TAGS ('dbx_value_regex' = 'Forward|Backward|Parallel|Bypass');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `waiver_reference` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Waiver Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_subdomain' = 'formulation_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `artwork_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Artwork File Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `barcode_placement` SET TAGS ('dbx_business_glossary_term' = 'Barcode Placement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `certification_marks` SET TAGS ('dbx_business_glossary_term' = 'Certification Marks');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Label Claim Text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `digital_watermark_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Watermark Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Label Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `ingredient_declaration_text` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `is_primary_label` SET TAGS ('dbx_business_glossary_term' = 'Primary Label Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Label Dimensions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'front_of_pack|back_of_pack|inner_label|neck_label|hang_tag|insert');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_version` SET TAGS ('dbx_business_glossary_term' = 'Label Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `lot_code_format` SET TAGS ('dbx_business_glossary_term' = 'Lot Code Format');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `mandatory_regulatory_statements` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Regulatory Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `net_content_declaration` SET TAGS ('dbx_business_glossary_term' = 'Net Content Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `nutrition_facts_required` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Facts Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `plm_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Change Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `print_process` SET TAGS ('dbx_business_glossary_term' = 'Print Process');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `print_process` SET TAGS ('dbx_value_regex' = 'flexographic|digital|offset|gravure|screen');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `recycling_symbol_code` SET TAGS ('dbx_business_glossary_term' = 'Recycling Symbol Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `shelf_life_statement` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `substrate_material` SET TAGS ('dbx_business_glossary_term' = 'Label Substrate Material');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `usage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Usage Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `warning_statements` SET TAGS ('dbx_business_glossary_term' = 'Warning Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `product_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Product Claim ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_substantiation_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Study or Test Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Claim Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'packaging|advertising|digital|in-store|all');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_code` SET TAGS ('dbx_value_regex' = '^CLM-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_scope` SET TAGS ('dbx_business_glossary_term' = 'Claim Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_scope` SET TAGS ('dbx_value_regex' = 'product|brand|range|ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'approved|pending|withdrawn|expired|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Claim Text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'efficacy|environmental|certification|nutritional|safety');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `claim_value` SET TAGS ('dbx_business_glossary_term' = 'Claim Quantitative Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Claim Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `environmental_claim_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Claim Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `fda_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Review Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `ftc_compliant` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `inci_ingredient_ref` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `legal_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `legal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `marketing_approved` SET TAGS ('dbx_business_glossary_term' = 'Marketing Approval Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Claim Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `plm_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `plm_stage` SET TAGS ('dbx_value_regex' = 'development|pre-launch|active|post-launch|discontinued');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `quantitative_claim` SET TAGS ('dbx_business_glossary_term' = 'Quantitative Claim Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Frequency (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `scientific_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Scientific Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `substantiation_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `substantiation_method` SET TAGS ('dbx_value_regex' = 'clinical_study|consumer_study|lab_test|third_party_audit|literature_review|expert_panel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Claim Subtype');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `value_unit` SET TAGS ('dbx_business_glossary_term' = 'Claim Quantitative Value Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Withdrawal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Withdrawal Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `architecture_type` SET TAGS ('dbx_value_regex' = 'master_brand|sub_brand|endorsed_brand|standalone|house_of_brands');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|dormant|divested|discontinued|pipeline');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'premium|mass|value|super_premium|private_label');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|wholesale|dtc|dsd|omnichannel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `divestiture_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Divestiture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `ean_prefix` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN) / GS1 Company Prefix');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `ean_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{4,7}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `equity_methodology` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Tracking Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `equity_methodology` SET TAGS ('dbx_value_regex' = 'nielsen_brand_health|kantar_brandz|ipsos_brand_value|internal_scorecard|bav|none');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Brand Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local|export_only');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `gmp_certification_ref` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `is_licensed_brand` SET TAGS ('dbx_business_glossary_term' = 'Licensed Brand Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `launch_year` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Year');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Brand License Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `nps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Tracking Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `owner_division` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Business Division');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `owner_entity` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Legal Entity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `owner_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `parent_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `parent_brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `plm_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `primary_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country of Origin Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Short Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^.{1,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Brand Social Media Handle');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `source_system_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Brand Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4|SFDC_CGC|ORACLE_ERP|VEEVA|MANUAL');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'fsc|rspo|iso_14001|rainforest_alliance|none|multiple');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trade_promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Management (TPM) Eligible');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trademark_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Trademark Jurisdiction Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trademark_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trademark_registration_ref` SET TAGS ('dbx_business_glossary_term' = 'Brand Trademark Registration Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trademark_registration_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website URL');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `sku_substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Substitution ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'From Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `to_sku_id` SET TAGS ('dbx_business_glossary_term' = 'To Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `atp_substitution_enabled` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Substitution Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `auto_substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Automatic Substitution Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `cogs_impact_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Impact Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `cogs_impact_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `demand_history_normalization` SET TAGS ('dbx_business_glossary_term' = 'Demand History Normalization Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `is_bidirectional` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Substitution Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `plm_change_order_ref` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Change Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `price_adjustment_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `price_adjustment_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Substitution Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `quantity_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Quantity Conversion Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'renovation|cost_optimization|regulatory_change|discontinuation|temporary_supply_shortage|reformulation');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `regulatory_change_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_ERP|SALESFORCE_CGC|VEEVA_VAULT|MANUAL');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_notes` SET TAGS ('dbx_business_glossary_term' = 'Substitution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_scope` SET TAGS ('dbx_business_glossary_term' = 'Substitution Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_scope` SET TAGS ('dbx_value_regex' = 'global|regional|customer_specific|channel_specific');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Substitution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|expired|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'SKU Substitution Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'direct_replacement|reformulation|repack|size_change|promotional_swap|supersession');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `pack_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Hierarchy Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `cumulative_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `display_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Ready Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (cm)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `hi_count` SET TAGS ('dbx_business_glossary_term' = 'Hi Count (Height)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'each|inner_pack|case|display_unit|pallet|layer');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (cm)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `max_stack_height` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stack Height');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `pack_hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Hierarchy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `pack_hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `packaging_material` SET TAGS ('dbx_value_regex' = 'corrugated_cardboard|plastic|wood|metal|composite|shrink_wrap');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `pallet_type` SET TAGS ('dbx_business_glossary_term' = 'Pallet Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `pallet_type` SET TAGS ('dbx_value_regex' = 'standard|euro|block|custom|half|quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `quantity_per_level` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `recyclable_flag` SET TAGS ('dbx_business_glossary_term' = 'Recyclable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `shippable_flag` SET TAGS ('dbx_business_glossary_term' = 'Shippable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight in Kilograms (kg)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `ti_count` SET TAGS ('dbx_business_glossary_term' = 'Ti Count (Tier)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `volume_cubic_cm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Centimeters (cm³)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (cm)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `product_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sales Channels');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'passed|passed_with_conditions|failed|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `certificate_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Certification Claim Text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `consumer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Facing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `logo_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Logo File Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `logo_usage_approved` SET TAGS ('dbx_business_glossary_term' = 'Logo Usage Approved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `retailer_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Retailer Requirement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `sustainability_pillar` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Pillar');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `sustainability_pillar` SET TAGS ('dbx_value_regex' = 'environmental|social|ethical|quality|safety|health');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `verification_url` SET TAGS ('dbx_business_glossary_term' = 'Verification Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_association_edges' = 'product.sku,consumer.shopper');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,customer.customer_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `vmi_sku_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Sku Assignment - Vmi Sku Assignment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `customer_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Sku Assignment - Customer Vmi Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Sku Assignment - Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `forecast_sharing_cadence` SET TAGS ('dbx_business_glossary_term' = 'Forecast Sharing Cadence');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `max_inventory_weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Weeks of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `min_inventory_weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inventory Weeks of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `safety_stock_weeks` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,logistics.carrier_contract');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `freight_contract_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Contract Assignment - Freight Contract Assignment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Contract Assignment - Carrier Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Contract Assignment - Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `agreed_rate` SET TAGS ('dbx_business_glossary_term' = 'Agreed Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'product.sku,procurement.supplier_contract');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supply Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supplier Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price UOM');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Url');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `is_leaf` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `marketing_tag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `parent_material_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Material Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `parent_material_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Info');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'Ean');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Gtin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `unit_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Unit Conversion Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Upc');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `volume_l` SET TAGS ('dbx_business_glossary_term' = 'Volume L');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `sku_group_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Group Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `parent_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Group Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `parent_sku_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sku Group Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `parent_sku_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `average_price` SET TAGS ('dbx_business_glossary_term' = 'Average Price');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `sku_group_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `sku_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `sku_group_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `product_count` SET TAGS ('dbx_business_glossary_term' = 'Product Count');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `sku_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kg');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `sku_group_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `parent_product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `parent_product_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `is_leaf` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `product_category_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
