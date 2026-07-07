-- Schema for Domain: product | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`product` COMMENT 'Single source of truth for all product master data across the CPG/FMCG portfolio. Owns SKU definitions, GTIN/UPC/EAN identifiers, product hierarchies, BOM structures, PLM lifecycle stages, formulation records, packaging specifications, INCI ingredient declarations, and regulatory labeling attributes. Serves as the authoritative product catalog referenced by all other domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique surrogate identifier for each SKU record in the product master. Primary key for the sku data product, referenced by all downstream domains as the authoritative product identifier.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: ASL-to-SKU linkage is a core consumer goods procurement control: production and procurement cannot proceed without ASL qualification. Quality and regulatory teams query which ASL governs this SKU fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each SKU to be assigned a cost_center for expense tracking and product profitability analysis.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Required for assigning each SKU to its primary distribution node used in supply planning, ATP calculations, and network optimization.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR invoice posting uses a default sales GL account per SKU; linking enables automated revenue posting and audit trails.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: sku should be linked to its product hierarchy for classification; no existing column, so new FK added.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: CAPACITY PLANNING: Assign each SKU to its primary manufacturing facility for production capacity allocation, cost per facility, and regulatory reporting.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand performance reports require each SKU to be linked to its marketing brand for equity and spend analysis.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Primary Supplier Assignment for each SKU is required for sourcing strategy, cost analysis, and regulatory compliance reports.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Designating a primary supplier site per SKU supports logistics planning, VMI inventory control, and OTIF performance tracking.',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: sku needs to reference its brand master; brand string is redundant once product_brand_id FK is added.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability statements map each SKU to a profit_center, enabling SKU‑level P&L reporting and margin analysis.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: SKU belongs to a product category; linking SKU to category eliminates silo and consolidates category data.',
    `sku_product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: SKU may belong to multiple product categories; linking SKU to product_category adds needed inbound relationship.',
    `amount` DECIMAL(18,2) COMMENT 'Amount value for the sku record.',
    `sku_code` STRING COMMENT 'Internal alphanumeric code assigned to the SKU within the ERP system (SAP S/4HANA Material Number). Serves as the primary business identifier used in procurement, manufacturing, and sales transactions. Maps to SAP MM material number.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `color` STRING COMMENT 'Consumer-facing color descriptor for the SKU (e.g., Blue, Clear, White). Applicable to products where color is a differentiating attribute (e.g., hair color, cosmetics, cleaning products). Used in planogram execution and consumer-facing content.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the product is manufactured or substantially transformed. Required for customs declarations, trade compliance, and consumer labeling in many markets.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was first created in the system of record (SAP S/4HANA). Used for data lineage, audit trail, and compliance with SOX record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the MSRP and standard cost fields (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `sku_description` STRING COMMENT 'The sku description of the sku record',
    `discontinuation_date` DATE COMMENT 'Date on which the SKU was or is planned to be permanently discontinued from the portfolio. Triggers end-of-life processes in supply chain, manufacturing, and trade. Null if the SKU is still active.',
    `ean` STRING COMMENT '13-digit European Article Number (EAN-13) used in international retail markets outside North America for barcode scanning and product identification. Registered with GS1.. Valid values are `^[0-9]{13}$`',
    `effective_from` DATE COMMENT 'The effective from of the sku.',
    `effective_until` DATE COMMENT 'The effective until of the sku record',
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
    `sku_name` STRING COMMENT 'The sku name of the sku record',
    `net_content` DECIMAL(18,2) COMMENT 'Numeric net content quantity of the product as declared on packaging (e.g., 500, 1.5, 200). Must be paired with net_content_uom. Regulated by FDA and FTC for accurate labeling. Used in COGS calculation and logistics weight/volume planning.',
    `net_content_uom` STRING COMMENT 'Unit of measure for the net content quantity (e.g., ml, L, g, kg, oz, fl oz, ct). Aligned with GS1 UN/CEFACT unit codes. Required for regulatory labeling compliance and logistics planning. [ENUM-REF-CANDIDATE: ml|L|g|kg|oz|fl oz|ct|units — 8 candidates stripped; promote to reference product]',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content excluding packaging in kilograms. Used in COGS calculation, regulatory labeling, and customs declarations. Maps to SAP MM material master net weight field.',
    `notes` STRING COMMENT 'The notes of the sku record',
    `pack_size` STRING COMMENT 'Number of individual consumer units contained within a single sellable pack (e.g., 1 for single unit, 2 for twin pack, 6 for multipack). Used in trade promotion planning (TPM), pricing, and distribution requirements planning (DRP).',
    `packaging_material_type` STRING COMMENT 'Material type of the primary consumer packaging (e.g., plastic, glass, aluminum, paper, cardboard). Used in sustainability reporting, EU REACH compliance, and packaging specification management in Veeva Vault. [ENUM-REF-CANDIDATE: plastic|glass|aluminum|paper|cardboard|composite|biodegradable — 7 candidates stripped; promote to reference product]',
    `portfolio_classification` STRING COMMENT 'Strategic classification of the SKU within the brand portfolio (e.g., core, strategic, tail, innovation, seasonal, limited_edition). Used in S&OP (Sales and Operations Planning) prioritization, resource allocation, and SKU rationalization decisions.. Valid values are `core|strategic|tail|innovation|seasonal|limited_edition`',
    `product_form` STRING COMMENT 'Physical or chemical form of the product (e.g., liquid, powder, gel, cream, spray). Critical for manufacturing process routing in Siemens Opcenter MES, packaging specification, and regulatory classification. [ENUM-REF-CANDIDATE: liquid|powder|gel|cream|foam|spray|bar|tablet|capsule|wipe|stick|sheet — promote to reference product]',
    `product_name` STRING COMMENT 'Full consumer-facing product name as it appears on packaging and in retail listings. Includes brand, variant, and size descriptors (e.g., Brand X Moisturizing Body Wash Fresh Scent 500ml). Used in marketing, trade, and regulatory submissions.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sku record',
    `regulatory_category` STRING COMMENT 'Regulatory classification of the SKU determining the applicable regulatory framework and labeling requirements (e.g., cosmetic, OTC drug, household chemical, food). Drives compliance workflows in Veeva Vault and regulatory reporting. [ENUM-REF-CANDIDATE: cosmetic|otc_drug|household_chemical|food|dietary_supplement|medical_device|general_merchandise — 7 candidates stripped; promote to reference product]',
    `scent` STRING COMMENT 'Consumer-facing scent or fragrance descriptor for the SKU (e.g., Fresh, Lavender, Unscented). Relevant for personal care and household products. Used in consumer engagement, marketing, and IFRA fragrance compliance tracking.',
    `short_description` STRING COMMENT 'Abbreviated product description (typically 40–80 characters) used in ERP transactions, warehouse management systems, and EDI communications where full product names are truncated. Maps to SAP MM short text field.',
    `sku_status` STRING COMMENT 'Current operational status of the SKU in the ERP system (SAP S/4HANA material status). Controls whether the SKU can be procured, manufactured, sold, or shipped. blocked prevents all transactions; pending_launch indicates pre-commercialization.. Valid values are `active|inactive|blocked|discontinued|pending_launch`',
    `source_system_code` STRING COMMENT 'The source system code of the sku record',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per consumer unit used for Cost of Goods Sold (COGS) calculation, financial reporting, and profitability analysis. Set annually during standard cost roll in SAP S/4HANA CO. Confidential financial data.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the SKU throughout the supply chain (e.g., ambient, refrigerated, frozen, controlled_temperature). Drives warehouse slotting in Blue Yonder WMS, transportation lane requirements, and regulatory compliance.. Valid values are `ambient|refrigerated|frozen|controlled_temperature|dry|flammable`',
    `sub_brand` STRING COMMENT 'Sub-brand or product line within the parent brand (e.g., Dove Men+Care, Tide PODS). Enables granular brand portfolio analysis and targeted trade promotion management (TPM).',
    `subcategory` STRING COMMENT 'Second-level product classification within the category (e.g., Shampoo, Conditioner, Detergent Pods). Supports granular category management, demand planning in SAP IBP, and retail execution reporting.',
    `target_demographic` STRING COMMENT 'Primary consumer demographic segment this SKU is designed and marketed for (e.g., adult, baby, male, female, professional). Drives consumer segmentation, marketing investment allocation, and shelf placement strategy. [ENUM-REF-CANDIDATE: adult|baby|child|teen|senior|unisex|male|female|professional|family — promote to reference product]',
    `total_shelf_life_days` STRING COMMENT 'Total shelf life of the SKU in days from the date of manufacture to the expiry date as declared on packaging. Used in FEFO (First Expired First Out) inventory management, Blue Yonder WMS configuration, and regulatory compliance.',
    `uom` STRING COMMENT 'The uom of the sku record',
    `upc` STRING COMMENT '12-digit Universal Product Code (UPC-A) used primarily in North American retail for point-of-sale scanning and inventory management. Subset of GTIN. Registered with GS1 US.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sku record',
    `variant` STRING COMMENT 'Specific variant descriptor distinguishing this SKU from others within the same product line (e.g., Original, Sensitive Skin, Extra Strength, 2-in-1). Used in PLM lifecycle management and consumer segmentation.',
    `volume_ml` DECIMAL(18,2) COMMENT 'Volume of the consumer unit in millilitres, used for liquid and semi-liquid products. Supports logistics cube utilization calculations, warehouse slotting, and transportation planning.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Core master record for every Stock Keeping Unit (SKU) in the CPG/FMCG portfolio. Single source of truth for SKU identity including internal code, description, brand assignment, sub-brand, product form, variant, net content, unit of measure, pack size, launch date, discontinuation date, PLM lifecycle stage, portfolio classification, shelf life attributes (total shelf life, FEFO threshold, storage conditions), and key consumer-facing attributes (scent, color, target demographic). Referenced by all other domains as the authoritative product identifier.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` (
    `gtin_registry_id` BIGINT COMMENT 'Unique surrogate primary key for each GTIN registry record in the Databricks Silver layer. Assigned by the platform upon ingestion from SAP S/4HANA MM or GS1 registration source.',
    `account_address_id` BIGINT COMMENT 'Carried-over connect_table FK addition P5 (BIGINT).',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: GTIN legal entity ownership for intercompany reconciliation and regulatory filings. In multi-entity CPG companies, GTINs are registered and owned by specific legal entities (company codes). Required f',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: A GTIN is assigned at a specific packaging level (consumer unit, inner pack, case, pallet) and corresponds to a specific packaging specification. The gtin_registry already links to sku via sku_id, but',
    `sku_id` BIGINT COMMENT 'Reference to the internal SKU master record to which this GTIN is assigned. A single SKU may have multiple GTINs across packaging hierarchy levels (each, inner pack, case, pallet).',
    `activation_date` DATE COMMENT 'The date on which the GTIN was activated and made available for commercial use, EDI transactions, and retailer catalog publication. May differ from assignment_date when a GTIN is pre-assigned during NPD but activated at product launch.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the gtin registry record',
    `assignment_date` DATE COMMENT 'The calendar date on which this GTIN was formally assigned to the SKU by the brand owner. Used for GS1 GTIN Management Standard compliance, audit trails, and PLM lifecycle tracking in SAP S/4HANA MM.',
    `barcode_symbology` STRING COMMENT 'The barcode symbology used to encode this GTIN on the physical product or packaging (e.g., UPC-A for consumer units, ITF-14 for cases, GS1-128 for logistic labels). Determines scanner compatibility at POS, warehouse, and DSD delivery points. [ENUM-REF-CANDIDATE: UPC-A|EAN-13|EAN-8|ITF-14|GS1-128|GS1_DataBar|QR_Code — promote to reference product]',
    `brand_name` STRING COMMENT 'The registered brand or trademark name under which the product is marketed to consumers. Used for retailer catalog syndication, Nielsen IQ market measurement reporting, and trade promotion management in Salesforce Consumer Goods Cloud.',
    `brand_owner_gln` STRING COMMENT 'The 13-digit GS1 Global Location Number (GLN) identifying the legal entity that owns the brand and is responsible for the GTIN assignment. Required for GS1 Data Source (1WorldSync/Salsify) product data syndication and retailer onboarding.. Valid values are `^[0-9]{13}$`',
    `cases_per_pallet` STRING COMMENT 'The standard number of cases stacked on one pallet (logistic unit). Used for transportation planning, warehouse slotting in Blue Yonder WMS, and pallet-level GTIN-14 assignment. Drives DRP and S&OP capacity calculations in SAP IBP.',
    `check_digit` STRING COMMENT 'The single trailing check digit of the GTIN, calculated using the GS1 modulo-10 algorithm. Used to validate GTIN integrity during barcode scanning, EDI processing, and retailer catalog ingestion. Stored explicitly to support validation workflows.. Valid values are `^[0-9]{1}$`',
    `gtin_registry_code` STRING COMMENT 'The gtin registry code for the gtin registry record.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the product was manufactured or substantially transformed. Required for customs declarations, FDA import labeling, FTC country-of-origin rules, and retailer catalog submissions.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GTIN registry record was first created in the system of record. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, SOX compliance, and data lineage tracking.',
    `currency_code` STRING COMMENT 'Currency code for gtin_registry (currency_code).',
    `data_pool_publication_date` DATE COMMENT 'The date on which the product data for this GTIN was first published to the GS1 data pool (GDSN). Used to track compliance with retailer new item setup timelines and GS1 sunrise date requirements.',
    `data_pool_published` BOOLEAN COMMENT 'Indicates whether the full product data record for this GTIN has been published to a GS1-certified data pool (e.g., 1WorldSync, Salsify) for retailer catalog synchronization. True = published and available to subscribers; False = not yet published.',
    `gtin_registry_description` STRING COMMENT 'The gtin registry description of the gtin registry record',
    `ean_value` DECIMAL(18,2) COMMENT 'The 13-digit EAN-13 barcode value used for international retail scanning and cross-border trade. Populated when gtin_format is GTIN-13. Required for EU, APAC, and LATAM retailer catalog submissions and EDI transactions.',
    `edi_eligible` BOOLEAN COMMENT 'Indicates whether this GTIN is set up and approved for EDI transactions (850 Purchase Order, 856 ASN, 832 Price/Sales Catalog) with trading partners. False when the GTIN is pending retailer item setup or has failed EDI validation. Managed in SAP S/4HANA SD and Oracle Cloud EDI.',
    `effective_from` DATE COMMENT 'The effective from of the gtin registry record',
    `effective_until` DATE COMMENT 'The effective until of the gtin registry record',
    `gpc_brick_code` STRING COMMENT 'The 8-digit GS1 Global Product Classification (GPC) Brick Code that categorizes the product into a standardized product segment, family, class, and brick. Required for GS1 data pool submissions and used by retailers for category management and planogram (POG) optimization.. Valid values are `^[0-9]{8}$`',
    `gs1_company_prefix` STRING COMMENT 'The GS1-assigned company prefix (6–12 digits) that identifies the brand owner within the GTIN structure. Issued by GS1 US or a GS1 Member Organization. Determines the number of GTINs available to the company and is embedded in every GTIN assigned by the company.. Valid values are `^[0-9]{6,12}$`',
    `gs1_member_org` STRING COMMENT 'The name of the GS1 Member Organization (e.g., GS1 US, GS1 UK, GS1 Germany) through which the company prefix was licensed. Relevant for multi-national CPG companies that hold prefixes from multiple GS1 member organizations across different markets.',
    `gs1_registration_reference` STRING COMMENT 'The reference number or confirmation identifier issued by GS1 (or a GS1 Member Organization) upon formal registration of this GTIN in the GS1 registry. Used for audit, dispute resolution, and regulatory submissions requiring proof of GS1 registration.',
    `gs1_registry_published` BOOLEAN COMMENT 'Indicates whether this GTIN has been published to the GS1 Registry Platform (formerly GEPIR) and is visible to trading partners and retailers for catalog synchronization. True = published; False = not yet published or withheld.',
    `gtin_format` STRING COMMENT 'Identifies the GTIN format variant: GTIN-8 (EAN-8 short barcode), GTIN-12 (UPC-A, North American standard), GTIN-13 (EAN-13, international standard), or GTIN-14 (ITF-14, used for cases and pallets). Determines barcode symbology and EDI transaction set usage.. Valid values are `GTIN-8|GTIN-12|GTIN-13|GTIN-14`',
    `gtin_registry_status` STRING COMMENT 'The gtin registry status of the gtin registry record',
    `gtin_value` DECIMAL(18,2) COMMENT 'The full numeric GTIN string including the check digit. Supports GTIN-8, GTIN-12 (UPC-A), GTIN-13 (EAN-13), and GTIN-14 (shipping container/case) formats as defined by GS1 General Specifications. Used in barcode scanning, EDI transactions, and retailer catalog synchronization.',
    `indicator_digit` STRING COMMENT 'Single leading digit (0–9) used in GTIN-14 to indicate the packaging level of a trade item. A value of 0 indicates a consumer unit; values 1–8 indicate inner packs or cases; value 9 is reserved for variable-measure trade items. Applicable only when gtin_format is GTIN-14.. Valid values are `^[0-9]{1}$`',
    `inner_packs_per_case` STRING COMMENT 'The number of inner packs (display shippers or multi-packs) contained within one case. Populated only when an intermediate inner-pack packaging level exists in the hierarchy. Used in SAP S/4HANA MM BOM and GS1 packaging hierarchy declarations.',
    `is_consumer_unit` BOOLEAN COMMENT 'Indicates whether this GTIN represents the consumer-facing sellable unit (each/each pack) as opposed to an inner pack, case, or pallet. True = consumer unit eligible for POS scanning; False = logistic/trade unit. Drives OSA monitoring and POS data matching in Nielsen IQ and TradeEdge.',
    `is_orderable` BOOLEAN COMMENT 'Indicates whether this GTIN is currently eligible to be ordered by retail customers via EDI or Salesforce Consumer Goods Cloud order management. False when the GTIN is retired, pending, or restricted to specific channels.',
    `is_scannable` BOOLEAN COMMENT 'Indicates whether a valid, scannable barcode (UPC/EAN/ITF-14) has been verified and approved for this GTIN. False when the barcode artwork is pending verification or has failed GS1 barcode quality verification. Used in retail execution and DSD workflows in Salesforce Consumer Goods Cloud.',
    `is_variable_measure` BOOLEAN COMMENT 'Indicates whether this GTIN represents a variable-measure trade item (e.g., catch-weight products sold by weight). True = variable measure; False = fixed measure. Variable-measure GTINs use indicator digit 9 in GTIN-14 and require special POS and EDI handling per GS1 specifications.',
    `item_reference_number` STRING COMMENT 'The item reference portion of the GTIN, assigned by the brand owner to uniquely identify the product within the company prefix. Together with the company prefix and check digit, it forms the complete GTIN. Sourced from SAP S/4HANA MM material master EAN/UPC segment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this GTIN registry record in the system of record. Used for incremental data loads, change detection, and audit compliance in the Databricks Silver layer.',
    `gtin_registry_name` STRING COMMENT 'The gtin registry name of the gtin registry record',
    `net_content_uom` STRING COMMENT 'The unit of measure for the net content value (e.g., ml, L, g, kg, oz, fl_oz, ct, ea). Required for FDA label compliance, GS1 data pool submissions, and retailer catalog item setup. Follows GS1 Recommendation on Unit of Measure codes. [ENUM-REF-CANDIDATE: ml|L|g|kg|oz|fl_oz|ct|ea — 8 candidates stripped; promote to reference product]',
    `net_content_value` DECIMAL(18,2) COMMENT 'The numeric net content quantity of the consumer unit (e.g., 400 for a 400ml shampoo bottle). Combined with net_content_uom to express the full net content declaration required on product labels per FDA and FTC labeling regulations.',
    `notes` STRING COMMENT 'The notes of the gtin registry record',
    `packaging_level` STRING COMMENT 'Identifies the packaging hierarchy level to which this GTIN is assigned: each (consumer unit), inner pack (multi-pack or display shipper), case (master carton), or pallet (logistic unit). Drives EDI order management, warehouse scanning, and DRP/MRP planning in SAP S/4HANA and Blue Yonder WMS.. Valid values are `each|inner_pack|case|pallet`',
    `plm_lifecycle_stage` STRING COMMENT 'The current PLM lifecycle stage of the product associated with this GTIN: concept, development, commercialization, active (in market), end_of_life (phase-out initiated), or discontinued. Sourced from the PLM system and used to govern GTIN activation, EDI eligibility, and retailer catalog status.. Valid values are `concept|development|commercialization|active|end_of_life|discontinued`',
    `product_category` STRING COMMENT 'The internal product category classification (e.g., Hair Care, Skin Care, Oral Care, Home Care) to which the SKU belongs. Aligns with the companys PLM product hierarchy and Nielsen IQ category definitions for market share reporting.',
    `product_description` STRING COMMENT 'Short consumer-facing product description associated with this GTIN, as published to retailer catalogs and GS1 data pools. Typically includes brand name, product name, variant, and net content (e.g., Brand X Moisturizing Shampoo 400ml). Sourced from SAP S/4HANA MM material description.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the gtin registry record',
    `registration_status` STRING COMMENT 'Current lifecycle status of the GTIN registration: active (in use and published to trading partners), pending (assigned but not yet published), inactive (temporarily suspended), retired (permanently discontinued), or cancelled (assigned in error and voided). Governs EDI eligibility and retailer catalog synchronization.. Valid values are `active|inactive|pending|retired|cancelled`',
    `retirement_date` DATE COMMENT 'The date on which the GTIN was retired or discontinued from active commercial use. Per GS1 GTIN Management Standard, a retired GTIN must not be reassigned for a minimum of 48 months. Null when the GTIN is still active.',
    `source_system_code` STRING COMMENT 'The source system code of the gtin registry record',
    `source_system_key` STRING COMMENT 'The natural key or internal identifier of this GTIN record in the originating source system (e.g., SAP material number + EAN category combination). Used for delta-load reconciliation, deduplication, and lineage tracing in the Databricks Silver layer ingestion pipeline.',
    `target_market_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary market for which this GTIN is intended. A single SKU may have different GTINs for different target markets due to regulatory labeling, language, or formulation differences. Used in GS1 data pool syndication and Veeva Vault regulatory submissions.. Valid values are `^[A-Z]{3}$`',
    `units_per_case` STRING COMMENT 'The number of consumer units (eaches) contained within one case (master carton). Used in SAP S/4HANA MM for BOM/packaging hierarchy, DRP/MRP planning, and EDI order quantity validation. Also referenced in Blue Yonder WMS for receiving and putaway.',
    `uom` STRING COMMENT 'The uom of the gtin registry record',
    `upc_value` DECIMAL(18,2) COMMENT 'The 12-digit UPC-A barcode value assigned to the consumer unit (each). Derived from the GTIN-12 and used primarily for North American retail POS scanning and retailer item setup. Populated only when gtin_format is GTIN-12.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the gtin registry record',
    CONSTRAINT pk_gtin_registry PRIMARY KEY(`gtin_registry_id`)
) COMMENT 'Authoritative registry of all GS1-compliant global trade item numbers (GTIN-8, GTIN-12/UPC, GTIN-13/EAN, GTIN-14) assigned to each SKU and its packaging hierarchy levels (each, inner pack, case, pallet). Stores GTIN value, GS1 company prefix, indicator digit, check digit, packaging level, assignment date, status, and GS1 registration reference. Enables barcode scanning, EDI transactions, and retailer catalog synchronization.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each node in the product classification hierarchy. Serves as the primary key for this record in the Silver Layer lakehouse.',
    `parent_hierarchy_id` BIGINT COMMENT 'Reference to the immediate parent node in the product hierarchy tree. NULL for root-level nodes (e.g., Division). Enables recursive traversal of the Division → Category → Sub-Category → Brand → Sub-Brand → Product Form → SKU hierarchy.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Hierarchical P&L and segment reporting. CPG product hierarchy nodes (division, category, subcategory) map to profit center hierarchy for management P&L, IBP planning, and IFRS 8 segment reporting. The',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the hierarchy record',
    `approved_date` DATE COMMENT 'Date on which this hierarchy node was formally approved by the data steward or product management team. Supports PLM lifecycle governance and audit trail for regulatory submissions.',
    `brand_code` STRING COMMENT 'Code of the Brand-level ancestor node for this hierarchy node. Denormalized to enable brand-level P&L reporting, brand equity tracking, SOV (Share of Voice) analysis, and trade promotion planning at the brand level.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `category_code` STRING COMMENT 'Code of the Category-level ancestor node for this hierarchy node. Denormalized to support category management, trade promotion planning (TPM), and demand forecasting without recursive hierarchy joins.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `channel_applicability` STRING COMMENT 'Distribution channels through which products in this hierarchy node are sold (e.g., Retail, E-Commerce, DTC, Wholesale, DSD). Supports channel management, trade promotion planning, and distribution requirements planning (DRP). [ENUM-REF-CANDIDATE: Retail|E-Commerce|DTC|Wholesale|DSD|Club|Drug — promote to reference product]',
    `hierarchy_code` STRING COMMENT 'The hierarchy code of the hierarchy record',
    `cpsc_regulated` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node are subject to CPSC (Consumer Product Safety Commission) regulations. True = product safety testing, labeling, and reporting requirements under CPSA apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the Silver Layer lakehouse. Supports audit trail, data lineage, and compliance with SOX financial data governance requirements.',
    `currency_code` STRING COMMENT 'The currency code of the hierarchy record',
    `hierarchy_description` STRING COMMENT 'The hierarchy description of the hierarchy record',
    `division_code` STRING COMMENT 'Code of the top-level Division node to which this hierarchy node belongs (e.g., HPC for Home & Personal Care, FOOD for Food & Beverage). Denormalized for fast filtering in OLAP queries and S&OP (Sales and Operations Planning) reporting without full hierarchy traversal.. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_from` DATE COMMENT 'Date from which this hierarchy node became effective and available for use in planning, trade promotion, and reporting systems. Supports temporal validity management and historical hierarchy reconstruction for trend analysis.',
    `effective_until` DATE COMMENT 'Date after which this hierarchy node is no longer active. NULL indicates an open-ended validity. Used for hierarchy versioning, portfolio rationalization, and ensuring discontinued nodes are excluded from forward-looking demand plans.',
    `external_reference_code` STRING COMMENT 'External partner or retailer-specific category code mapped to this hierarchy node (e.g., Walmart category code, Amazon browse node ID). Supports EDI (Electronic Data Interchange) transactions, retailer data synchronization, and VMI (Vendor Managed Inventory) programs.',
    `gmp_standard` STRING COMMENT 'Applicable GMP (Good Manufacturing Practice) standard for manufacturing products in this hierarchy node. Drives quality management requirements in Siemens Opcenter MES and Veeva Vault QMS. ISO 22716 applies to cosmetics; 21 CFR 111 to dietary supplements; 21 CFR 210/211 to pharmaceuticals.. Valid values are `ISO 22716|GMP 21 CFR 111|GMP 21 CFR 210|GMP 21 CFR 211|OSHA|None`',
    `gpc_brick_code` STRING COMMENT 'GS1 Global Product Classification (GPC) brick-level code (8-digit numeric) aligned to this hierarchy node. Enables cross-industry product classification interoperability, EDI transactions, and retailer data synchronization via GS1 standards.. Valid values are `^[0-9]{8}$`',
    `gpc_brick_name` STRING COMMENT 'Descriptive name of the GS1 GPC brick code associated with this hierarchy node (e.g., Shampoo/Conditioner - Non-Medicated). Supports regulatory submissions, retailer onboarding, and GS1 data pool synchronization.',
    `hierarchy_status` STRING COMMENT 'The hierarchy status of the hierarchy record',
    `ibp_planning_level` BOOLEAN COMMENT 'Indicates whether this hierarchy node is a designated planning level in SAP IBP (Integrated Business Planning) for demand forecasting and S&OP (Sales and Operations Planning). True = this node is an active planning aggregation point.',
    `inci_applicable` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node require INCI (International Nomenclature of Cosmetic Ingredients) ingredient declaration on labeling. True = cosmetic/personal care products subject to EU Cosmetics Regulation and FDA cosmetic labeling requirements.',
    `iri_category_code` STRING COMMENT 'IRI (now Circana) proprietary category code mapped to this hierarchy node. Supports market share reporting, TDP (Total Distribution Points) analysis, and SOM (Share of Market) calculations using IRI syndicated data.',
    `is_leaf_node` BOOLEAN COMMENT 'Indicates whether this node is a terminal leaf in the hierarchy (True = no children exist, typically the SKU level). Used to filter for assignable product nodes in demand forecasting, inventory management, and trade promotion planning.',
    `language_code` STRING COMMENT 'ISO 639-1 language code for the node_name and node_description fields (e.g., en, fr, de, es). Supports multi-language product hierarchy management for global CPG/FMCG operations and localized reporting.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this node within the product classification hierarchy. Level 1 = Division, Level 2 = Category, Level 3 = Sub-Category, Level 4 = Brand, Level 5 = Sub-Brand, Level 6 = Product Form, Level 7 = SKU (Stock Keeping Unit). Used for OLAP drill-down and aggregation logic.',
    `level_name` STRING COMMENT 'Business label for the hierarchy depth of this node. Enumerated values correspond to the CPG/FMCG standard classification spine: Division, Category, Sub-Category, Brand, Sub-Brand, Product Form, SKU (Stock Keeping Unit). Drives display logic in reporting tools and S&OP dashboards. [ENUM-REF-CANDIDATE: Division|Category|Sub-Category|Brand|Sub-Brand|Product Form|SKU — 7 candidates stripped; promote to reference product]',
    `market_share_reportable` BOOLEAN COMMENT 'Indicates whether this hierarchy node is included in external market share reporting via Nielsen IQ or IRI/Circana syndicated data. True = node is mapped to a syndicated data category for SOM (Share of Market) and ACV (All Commodity Volume) reporting.',
    `hierarchy_name` STRING COMMENT 'The hierarchy name of the hierarchy record',
    `nielsen_category_code` STRING COMMENT 'Nielsen IQ proprietary category code mapped to this hierarchy node. Enables direct linkage between internal product classification and Nielsen IQ retail measurement data for market share reporting, ACV (All Commodity Volume) analysis, and competitive benchmarking.',
    `node_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this hierarchy node within its level. Used as the business key in SAP S/4HANA MM product group structures and referenced in EDI transactions and trade promotion planning systems.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `node_description` STRING COMMENT 'Extended business description of the hierarchy node providing additional context about the product grouping, its scope, and intended use in classification. Supports regulatory categorization and PLM documentation.',
    `node_name` STRING COMMENT 'Human-readable business name of this hierarchy node (e.g., Personal Care, Shampoo, Head & Shoulders, Classic Clean). Used in OLAP drill-down reports, trade promotion planning, and market share dashboards.',
    `node_status` STRING COMMENT 'Current lifecycle status of this hierarchy node. active nodes are available for use in planning, trade promotion, and reporting. discontinued nodes are retained for historical analysis. pending nodes are awaiting approval in the PLM (Product Lifecycle Management) workflow.. Valid values are `active|inactive|pending|discontinued|archived`',
    `notes` STRING COMMENT 'The notes of the hierarchy record',
    `path` STRING COMMENT 'Materialized full path string from root to this node using a delimiter (e.g., Consumer Goods / Personal Care / Hair Care / Shampoo / Head & Shoulders / Classic Clean). Enables fast string-based filtering and display in BI tools without recursive joins.',
    `plm_lifecycle_stage` STRING COMMENT 'Current stage of the product node in the PLM (Product Lifecycle Management) lifecycle. Drives NPD (New Product Development) workflows, portfolio rationalization decisions, and demand planning assumptions in SAP IBP. [ENUM-REF-CANDIDATE: concept|development|launch|growth|mature|decline|discontinued — 7 candidates stripped; promote to reference product]',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the hierarchy record',
    `reach_regulated` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node are subject to EU REACH Regulation (Registration, Evaluation, Authorisation and Restriction of Chemicals). True = chemical substance registration and SDS (Safety Data Sheet) requirements apply.',
    `regulatory_framework` STRING COMMENT 'Identifies the primary regulatory framework governing products classified under this hierarchy node (e.g., FDA OTC Drug, FDA Cosmetic, EPA Pesticide, CPSC Consumer Product, EU Cosmetics Regulation). Drives compliance workflows in Veeva Vault and regulatory labeling requirements. [ENUM-REF-CANDIDATE: FDA OTC Drug|FDA Cosmetic|EPA Pesticide|CPSC Consumer Product|EU Cosmetics Regulation|REACH|ISO 22716|IFRA — promote to reference product]',
    `sort_order` STRING COMMENT 'Numeric sequence controlling the display order of sibling nodes within the same parent. Used to enforce business-defined ordering in planograms (POG), category management reports, and trade promotion planning interfaces.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this hierarchy node was sourced (e.g., SAP S/4HANA MM, Veeva Vault PLM, Salesforce Consumer Goods Cloud). Supports data lineage tracking and Silver Layer reconciliation in the Databricks Lakehouse. [ENUM-REF-CANDIDATE: SAP_S4|ORACLE_ERP|VEEVA|SALESFORCE_CGC|SAP_IBP|NIELSEN|MANUAL — 7 candidates stripped; promote to reference product]',
    `source_system_node_code` STRING COMMENT 'Native identifier of this hierarchy node in the originating operational system (e.g., SAP product hierarchy node ID, Veeva Vault record ID). Enables reverse traceability from the Silver Layer back to the system of record for reconciliation and audit.',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether products in this hierarchy node carry a sustainability certification (e.g., FSC, RSPO, ISO 14001). Supports ESG reporting, sustainable sourcing procurement decisions, and consumer-facing sustainability claims.',
    `tax_category_code` STRING COMMENT 'Tax classification code assigned to this hierarchy node for VAT/GST determination in SAP S/4HANA FI/CO. Drives correct tax treatment in sales orders, invoicing, and financial reporting across jurisdictions.',
    `trade_promotion_eligible` BOOLEAN COMMENT 'Indicates whether products under this hierarchy node are eligible for trade promotion activities (TPM/TPO). Drives eligibility rules in Salesforce Consumer Goods Cloud Trade Promotion Management and ROI (Return on Investment) reporting.',
    `uom` STRING COMMENT 'The uom of the hierarchy record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this hierarchy node record in the Silver Layer. Used for incremental data pipeline processing, change data capture, and audit trail maintenance.',
    `version_number` STRING COMMENT 'Monotonically incrementing version counter for this hierarchy node record. Incremented each time the node definition is materially changed (e.g., reclassification, rename, regulatory framework update). Supports SCD Type 2 history management and audit compliance.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the multi-level product classification hierarchy used across the CPG portfolio: Division → Category → Sub-Category → Brand → Sub-Brand → Product Form → SKU. Each node carries hierarchy level code, node name, parent node reference, sort order, active flag, GPC brick code alignment, Nielsen/IRI category code mapping, and applicable regulatory framework. Serves as the single authoritative classification backbone for OLAP drill-down, trade promotion planning, demand forecasting, market share reporting, and regulatory categorization.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` (
    `product_bom_id` BIGINT COMMENT 'Unique surrogate identifier for the Bill of Materials (BOM) header record in the Databricks Silver Layer. Primary key for this entity.',
    `account_address_id` BIGINT COMMENT 'Carried-over connect_table FK addition P7 (BIGINT).',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: A Bill of Materials is built to manufacture a specific approved formulation. product_bom currently carries formulation_code as a plain STRING reference to the formulation — this is a denormalized poin',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: BOM change control requires linking each BOM version to the active inspection plan so that BOM revisions automatically trigger inspection plan review. Standard SAP QM/PLM integration for GMP manufactu',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production site that owns this BOM. BOMs in SAP are plant-specific; the same material may have different BOMs per plant reflecting local sourcing or production capabilities.',
    `sku_id` BIGINT COMMENT 'Reference to the finished good or semi-finished SKU for which this BOM is defined. Links to the product master (material master in SAP). A single SKU may have multiple BOMs of different types.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: BOM change control in consumer goods GMP manufacturing requires linking each BOM version to its governing quality specification. When a BOM changes, the linked specification triggers mandatory QA revi',
    `alternative_bom` STRING COMMENT 'Alternative BOM identifier (SAP STLAL) allowing multiple BOM variants for the same material and plant combination. Used to manage seasonal formulations, regional variants, or cost-optimized alternatives within the same SKU.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the product bom record',
    `approved_date` DATE COMMENT 'Date on which this BOM was formally approved for production use. Part of the GMP and PLM audit trail. Required for regulatory submissions and quality management documentation.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity of the finished or semi-finished material for which the BOM component quantities are specified. All component quantities in BOM line items are expressed relative to this base quantity. Typically 1 or 100 in CPG manufacturing.',
    `base_uom` STRING COMMENT 'Unit of measure for the BOM base quantity (e.g., KG, L, EA, G). Defines the unit in which the finished good is expressed for component ratio calculations. Aligns with SAP base unit of measure (MARA-MEINS) and GS1 unit codes.',
    `bom_category` STRING COMMENT 'SAP BOM category indicating the object type the BOM is assigned to. material is the standard category for product BOMs in CPG/FMCG. equipment and functional_location apply to plant maintenance BOMs. Aligns with SAP STKO-STLTY.. Valid values are `material|equipment|functional_location|document`',
    `bom_description` STRING COMMENT 'Human-readable description of the BOM, typically including the product name, formulation variant, and intended use. Used in PLM, engineering change orders, and regulatory documentation.',
    `bom_level` STRING COMMENT 'Indicates the level of the BOM in a multi-level product structure. Level 0 is the finished good, level 1 represents direct components, level 2 represents sub-components, etc. Used for multi-level BOM explosion in MRP and costing roll-ups.',
    `bom_number` STRING COMMENT 'Externally-known BOM document number as assigned in SAP S/4HANA PP/MM (e.g., SAP BOM header number). This is the business-facing identifier used in PLM, procurement, and manufacturing communications.',
    `bom_type` STRING COMMENT 'Classifies the purpose of the BOM. production is used for manufacturing execution (MRP/MES), costing for COGS and standard cost roll-up, engineering for R&D and NPD design, sales for variant configuration, configurable for multi-variant BOMs. Aligns with SAP BOM usage (STLAL).. Valid values are `production|costing|engineering|sales|configurable`',
    `change_number` STRING COMMENT 'Engineering Change Number (ECN) or Engineering Change Order (ECO) reference that authorized the creation or modification of this BOM version. Provides traceability from BOM changes back to the formal change management process in PLM.',
    `product_bom_code` STRING COMMENT 'The product bom code of the product bom record',
    `component_count` STRING COMMENT 'Total number of active component line items in this BOM. Provides a quick indicator of BOM complexity and is used in BOM completeness validation checks during PLM review and quality audits.',
    `costing_relevance` STRING COMMENT 'Indicates whether this BOM is relevant for product costing (COGS calculation and standard cost roll-up). relevant means the BOM is included in cost estimates, not_relevant excludes it, conditional applies under specific costing scenarios. Critical for financial reporting and EBITDA analysis.. Valid values are `relevant|not_relevant|conditional`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the source system (SAP S/4HANA). Provides the audit trail creation marker required for GMP, SOX, and ISO 9001 compliance.',
    `currency_code` STRING COMMENT 'The currency code of the product bom record',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this BOM has been flagged for deletion in SAP. A deletion flag marks the BOM as logically deleted without physically removing the record, preserving audit history. Aligns with SAP STKO-LOEKZ.',
    `product_bom_description` STRING COMMENT 'The product bom description of the product bom record',
    `effective_from` DATE COMMENT 'The date from which this BOM version is valid and can be used for production planning, MRP, and costing. Supports time-phased BOM management for seasonal reformulations, ingredient substitutions, or regulatory-driven changes.',
    `effective_until` DATE COMMENT 'The date until which this BOM version is valid. Null indicates an open-ended validity. Used to manage BOM version transitions during reformulations, regulatory updates, or product discontinuations.',
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
    `product_bom_name` STRING COMMENT 'The product bom name of the product bom record',
    `notes` STRING COMMENT 'Free-text notes or comments associated with this BOM header, capturing manufacturing instructions, formulation rationale, regulatory notes, or change justifications that do not fit structured fields. Sourced from SAP BOM header long text.',
    `plant_code` STRING COMMENT 'Four-character SAP plant code identifying the manufacturing facility or production site where this BOM is applicable. Used in MRP, production orders, and supply chain planning (SAP IBP).',
    `plm_status` STRING COMMENT 'Current lifecycle state of the BOM as managed in the PLM process. draft indicates initial creation, in_review is under engineering/regulatory review, approved is signed off but not yet released to production, active is in use for manufacturing, obsolete is retired, superseded has been replaced by a newer BOM version.. Valid values are `draft|in_review|approved|active|obsolete|superseded`',
    `product_bom_status` STRING COMMENT 'The product bom status of the product bom record',
    `production_version` STRING COMMENT 'SAP production version identifier (MKAL-VERID) that links this BOM to a specific routing/recipe and production line. A material may have multiple production versions representing different manufacturing processes or lines at the same plant.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the product bom record',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether all chemical substances in this BOM are compliant with EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) regulation. Mandatory for products sold in the European Union.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for this BOM/formulation. Indicates whether the ingredient composition has been reviewed and approved by relevant regulatory bodies (FDA, EU REACH, CPSC). Required before a BOM can be released to active production status.. Valid values are `pending|approved|conditionally_approved|rejected|not_required`',
    `rspo_certified` BOOLEAN COMMENT 'Indicates whether palm oil or palm-derived ingredients in this BOM are sourced from RSPO-certified sustainable sources. Relevant for personal care and household products containing palm oil derivatives. Supports sustainability reporting.',
    `source_system_bom_code` STRING COMMENT 'The native primary key or document number of this BOM record in the originating source system (e.g., SAP internal BOM header key combining MATNR+WERKS+STLAL+STLAN). Enables traceability back to the system of record.',
    `source_system_code` STRING COMMENT 'The source system code of the product bom record',
    `uom` STRING COMMENT 'The uom of the product bom record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the product bom record',
    `version` STRING COMMENT 'Version or revision identifier for the BOM document, enabling traceability of formulation changes over time. Incremented when ingredient quantities, component substitutions, or structural changes are made. Critical for regulatory submissions and GMP compliance.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this BOM record in SAP S/4HANA or the PLM system. Part of the mandatory audit trail for GMP and SOX compliance.',
    CONSTRAINT pk_product_bom PRIMARY KEY(`product_bom_id`)
) COMMENT 'Bill of Materials (BOM) header record defining the complete ingredient and component structure for a finished good or semi-finished SKU. Captures BOM number, BOM type (production, costing, engineering), base quantity, unit of measure, effective date range, PLM status, and the owning plant or production site. Links to BOM line items for individual component details. Sourced from SAP S/4HANA PP/MM modules.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual component line within a Bill of Materials. Primary key for this entity. Role: TRANSACTION_LINE.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: MRP and procurement planning systems check the ASL for each BOM component to determine valid sources before generating purchase requisitions. In consumer goods, each BOM line component must have an AS',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility for which this BOM line is defined. BOM structures can vary by plant due to local sourcing, equipment capabilities, or regulatory requirements.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Each BOM line specifies a raw material or packaging component. The material table is the authoritative master for all materials in the CPG portfolio. bom_line currently stores component_description as',
    `product_bom_id` BIGINT COMMENT 'Reference to the parent Bill of Materials header that this line belongs to. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `sku_id` BIGINT COMMENT 'Reference to the master product/material record for the component (raw material, packaging component, or sub-assembly) required on this BOM line. Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Each BOM line item (ingredient/component) in GMP consumer goods manufacturing references its governing quality specification for incoming inspection and CoA validation. Component-level spec linkage is',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred or approved supplier for this component. Used in procurement planning and source list determination during MRP runs. Supports VMI (Vendor Managed Inventory) and MOQ (Minimum Order Quantity) management.',
    `alternative_item_group` STRING COMMENT 'Groups multiple BOM lines that are interchangeable alternatives for the same component requirement. All lines sharing the same group code can substitute for one another, enabling flexible sourcing and production planning.',
    `alternative_priority` STRING COMMENT 'Numeric priority rank within an alternative item group, determining the preferred order of substitution when multiple alternatives exist. Lower numbers indicate higher preference (e.g., 1 = first choice).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the bom line record',
    `bom_item_category` STRING COMMENT 'SAP BOM item category code that controls how the component is procured and managed. Determines whether the item is stocked, non-stocked, variable-size, or a document/text item. [ENUM-REF-CANDIDATE: stock|non_stock|variable_size|document|text|class — promote to reference product]. Valid values are `stock|non_stock|variable_size|document|text|class`',
    `bom_line_status` STRING COMMENT 'The bom line status of the bom line record',
    `bulk_material_flag` BOOLEAN COMMENT 'Indicates whether this component is a bulk material that is not individually picked or issued but is consumed from a bulk supply point on the shop floor. Bulk materials are typically excluded from individual goods issue postings.',
    `change_number` STRING COMMENT 'The Engineering Change Number (ECN) or Engineering Change Order (ECO) that authorized the creation or modification of this BOM line. Provides traceability to the formal change management process in PLM.',
    `co_product_flag` BOOLEAN COMMENT 'Indicates whether this BOM line represents a co-product or by-product that is produced alongside the primary output. Co-products have positive quantities and receive a portion of the production cost allocation.',
    `bom_line_code` STRING COMMENT 'The bom line code of the bom line record',
    `component_cost_usd` DECIMAL(18,2) COMMENT 'The standard cost per unit of measure for this component in USD, used for COGS (Cost of Goods Sold) calculation and product costing. Sourced from the material master standard price or moving average price.',
    `component_item_number` STRING COMMENT 'The externally-known material or item number for the component as defined in the ERP system (e.g., SAP material number). Used for cross-system referencing and procurement planning.',
    `component_type` STRING COMMENT 'Classification of the component indicating its role in the manufacturing process. Drives MRP planning logic and COGS categorization. [ENUM-REF-CANDIDATE: raw_material|packaging|semi_finished|finished_good|co_product|by_product — promote to reference product]. Valid values are `raw_material|packaging|semi_finished|finished_good|co_product|by_product`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this BOM line record was first created in the system. Used for audit trail, data lineage, and change management tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the component cost value (e.g., USD, EUR, GBP). Enables multi-currency COGS reporting for global manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `bom_line_description` STRING COMMENT 'The bom line description of the bom line record',
    `effective_from` DATE COMMENT 'The effective from of the bom line record',
    `effective_until` DATE COMMENT 'The effective until of the bom line record',
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
    `bom_line_name` STRING COMMENT 'The bom line name of the bom line record',
    `notes` STRING COMMENT 'The notes of the bom line record',
    `operation_number` BIGINT COMMENT 'Reference to the specific production routing operation or work center step at which this component is consumed. Enables precise material staging and backflushing in the MES and MRP systems.',
    `phantom_item_flag` BOOLEAN COMMENT 'Indicates whether this BOM line represents a phantom assembly — a logical grouping of components that is not physically stocked or produced as a discrete item but is exploded through in MRP planning.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the bom line record',
    `reach_registration_number` STRING COMMENT 'The EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) registration number for this chemical component. Required for substances manufactured or imported into the EU above threshold quantities.',
    `recursive_bom_flag` BOOLEAN COMMENT 'Indicates whether this component itself has a subordinate BOM (i.e., it is a sub-assembly or semi-finished good with its own BOM structure). Used to identify multi-level BOM explosion requirements in MRP planning.',
    `required_quantity` DECIMAL(18,2) COMMENT 'The quantity of the component required to produce one unit of the parent SKU at the base quantity defined in the BOM header. Satisfies TRANSACTION_LINE LINE_QUANTITY category. Supports MRP and COGS calculation.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'The expected percentage of this component that will be lost or wasted during the manufacturing process. Used to inflate the planned component quantity in MRP runs and COGS calculations. Expressed as a percentage (e.g., 2.5 = 2.5%).',
    `sds_document_number` STRING COMMENT 'The document number or reference identifier for the Safety Data Sheet (SDS) associated with this hazardous component. Links to the SDS stored in Veeva Vault or the document management system for regulatory compliance.',
    `source_system_code` STRING COMMENT 'Identifier for the operational system of record from which this BOM line was sourced (e.g., SAP_S4HANA, ORACLE_ERP). Supports data lineage tracking and multi-system reconciliation in the Databricks Silver Layer.',
    `storage_location` STRING COMMENT 'The designated warehouse storage location or bin where this component is staged for production consumption. Used by WMS and MES for material staging, goods issue, and FEFO/FIFO inventory management.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the required quantity of the component (e.g., KG, L, EA, M, G). Must align with the component material master UOM. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT category (measurement dimension).',
    `uom` STRING COMMENT 'The uom of the bom line record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the bom line record',
    `usage_probability_pct` DECIMAL(18,2) COMMENT 'The probability (expressed as a percentage, 0–100) that this alternative component will actually be used in production. Used by MRP to calculate weighted component requirements across alternative item groups.',
    `valid_from_date` DATE COMMENT 'The date from which this BOM line is effective and should be included in production and MRP planning. Supports date-effective BOM management for product reformulations and packaging changes.',
    `valid_to_date` DATE COMMENT 'The date after which this BOM line is no longer effective and should be excluded from production and MRP planning. Null indicates the line is open-ended with no planned expiry.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual component line within a Bill of Materials, specifying each raw material, packaging component, or sub-assembly required to produce the parent SKU. Attributes include component item number, component description, component type (raw material, packaging, semi-finished), required quantity, unit of measure, scrap percentage, lead time offset, and whether the component is a critical or alternative item. Supports MRP, COGS calculation, and procurement planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`formulation` (
    `formulation_id` BIGINT COMMENT 'Unique surrogate identifier for the formulation master record in the Databricks Silver Layer. Primary key for all downstream joins and lineage tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: R&D cost tracking and project accounting. Formulations are developed in R&D labs; lab costs, stability testing, and regulatory approval expenses are charged to specific R&D cost centers. CPG finance t',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: A product formulation is created for a specific SKU — this is the foundational parent-child relationship. product_formulation currently has no in-domain FK, making it a silo. Adding sku_id normalizes ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Contract/toll manufacturing in consumer goods requires tracking which supplier produces each formulation. Quality audits, regulatory submissions, and COGS calculations depend on knowing the formulatio',
    `active_ingredient_name` STRING COMMENT 'The active ingredient name of the product formulation record',
    `active_ingredient_pct` DECIMAL(18,2) COMMENT 'The active ingredient pct of the product formulation record',
    `allergen_declaration` STRING COMMENT 'The allergen declaration of the product formulation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the product formulation record',
    `approval_date` DATE COMMENT 'The approval date of the product formulation record',
    `bom_reference_code` STRING COMMENT 'The bom reference code of the product formulation record',
    `formulation_code` STRING COMMENT 'The formulation code of the product formulation record',
    `color_description` STRING COMMENT 'The color description of the product formulation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product formulation record',
    `currency_code` STRING COMMENT 'The currency code of the product formulation record',
    `effective_date` DATE COMMENT 'The effective date of the product formulation record',
    `effective_from` DATE COMMENT 'The effective from of the product formulation record',
    `effective_until` DATE COMMENT 'The effective until of the product formulation record',
    `formulation_type` STRING COMMENT 'The formulation type of the product formulation record',
    `fragrance_code` STRING COMMENT 'The fragrance code of the product formulation record',
    `gmp_compliance_flag` BOOLEAN COMMENT 'The gmp compliance flag of the product formulation record',
    `inci_declaration` STRING COMMENT 'The inci declaration of the product formulation record',
    `intended_use` STRING COMMENT 'The intended use of the product formulation record',
    `is_cruelty_free` BOOLEAN COMMENT 'The is cruelty free of the product formulation record',
    `is_fragrance_free` BOOLEAN COMMENT 'The is fragrance free of the product formulation record',
    `is_vegan` BOOLEAN COMMENT 'The is vegan of the product formulation record',
    `lab_notebook_reference` STRING COMMENT 'The lab notebook reference of the product formulation record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product formulation record',
    `lifecycle_stage` STRING COMMENT 'The lifecycle stage of the product formulation record',
    `formulation_name` STRING COMMENT 'The formulation name of the product formulation record',
    `notes` STRING COMMENT 'The notes of the product formulation record',
    `obsolescence_date` DATE COMMENT 'The obsolescence date of the product formulation record',
    `ph_max` DECIMAL(18,2) COMMENT 'The ph max of the product formulation record',
    `ph_min` DECIMAL(18,2) COMMENT 'The ph min of the product formulation record',
    `preservative_system` STRING COMMENT 'The preservative system of the product formulation record',
    `product_category` STRING COMMENT 'The product category of the product formulation record',
    `product_formulation_code` STRING COMMENT 'The product formulation code of the product formulation record',
    `product_formulation_description` STRING COMMENT 'The product formulation description of the product formulation record',
    `product_formulation_name` STRING COMMENT 'The product formulation name of the product formulation record',
    `product_formulation_status` STRING COMMENT 'The product formulation status of the product formulation record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the product formulation record',
    `rd_project_code` STRING COMMENT 'The rd project code of the product formulation record',
    `reach_registration_number` STRING COMMENT 'The reach registration number of the product formulation record',
    `regulatory_approval_status` STRING COMMENT 'The regulatory approval status of the product formulation record',
    `regulatory_classification` STRING COMMENT 'The regulatory classification of the product formulation record',
    `rspo_certified` BOOLEAN COMMENT 'The rspo certified of the product formulation record',
    `source_system_code` STRING COMMENT 'The source system code of the product formulation record',
    `stability_period_months` STRING COMMENT 'The stability period months of the product formulation record',
    `storage_condition` STRING COMMENT 'The storage condition of the product formulation record',
    `total_solid_content_pct` DECIMAL(18,2) COMMENT 'The total solid content pct of the product formulation record',
    `uom` STRING COMMENT 'The uom of the product formulation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the product formulation record',
    `version_number` STRING COMMENT 'The version number of the product formulation record',
    `viscosity_max_cps` DECIMAL(18,2) COMMENT 'The viscosity max cps of the product formulation record',
    `viscosity_min_cps` DECIMAL(18,2) COMMENT 'The viscosity min cps of the product formulation record',
    CONSTRAINT pk_formulation PRIMARY KEY(`formulation_id`)
) COMMENT 'Formulation master record capturing the approved chemical or ingredient recipe for a consumer goods product (household, personal care, health, or hygiene). Stores formulation code, version number, formulation name, product category, regulatory approval status, pH range, viscosity, color, fragrance code, preservative system, and the R&D project reference. Tracks the full formulation lifecycle from lab development through commercial approval. Sourced from Veeva Vault PLM. [SSOT: authoritative table is research.research_formulation; this table is a deprecated duplicate.] [Non-authoritative; defers to SSOT research.research_formulation for concept formulation.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` (
    `packaging_spec_id` BIGINT COMMENT 'Unique surrogate identifier for each packaging specification record. One record represents one packaging level for one SKU. MASTER_RESOURCE role — primary key.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Packaging component specs require GMP site qualification per manufacturing facility — a spec approved at one plant may not be valid at another. Regulatory audits (FDA, EU GMP) require traceability of ',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Packaging component qualification requires ASL approval beyond just knowing the supplier identity. Quality teams need ASL status (qualification level, audit score, expiry) for packaging supplier audit',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: A packaging specification is defined for a specific primary packaging material (e.g., HDPE bottle, aluminum can, paperboard carton). The material table is the master reference for all packaging materi',
    `sku_id` BIGINT COMMENT 'Reference to the parent SKU for which this packaging specification is defined. Links the packaging record to the product master.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Packaging procurement in consumer goods is governed by specific supplier contracts defining tooling ownership, pricing, and quality standards. Packaging teams need to reference the active contract for',
    `supplier_id` BIGINT COMMENT 'Reference to the approved supplier responsible for manufacturing or supplying this packaging component. Links to the supplier master for procurement, quality, and compliance management.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Customer-specific packaging specifications (retailer-exclusive pack sizes, private label packaging, club-store formats) are standard in consumer goods. Linking product_packaging_spec to trade_account ',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the product packaging spec record',
    `approval_status` STRING COMMENT 'The approval status of the product packaging spec record',
    `artwork_ref` STRING COMMENT 'The artwork ref of the product packaging spec record',
    `color` STRING COMMENT 'The color of the product packaging spec record',
    `component_type` STRING COMMENT 'The component type of the product packaging spec record',
    `country_of_origin` STRING COMMENT 'The country of origin of the product packaging spec record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product packaging spec record',
    `currency_code` STRING COMMENT 'The currency code of the product packaging spec record',
    `ean` STRING COMMENT 'The ean of the product packaging spec record',
    `effective_date` DATE COMMENT 'The effective date of the product packaging spec record',
    `effective_from` DATE COMMENT 'The effective from of the product packaging spec record',
    `effective_until` DATE COMMENT 'The effective until of the product packaging spec record',
    `expiry_date` DATE COMMENT 'The expiry date of the product packaging spec record',
    `finish` STRING COMMENT 'The finish of the product packaging spec record',
    `gross_weight_g` DECIMAL(18,2) COMMENT 'The gross weight g of the product packaging spec record',
    `gtin` STRING COMMENT 'The gtin of the product packaging spec record',
    `hazmat_flag` BOOLEAN COMMENT 'The hazmat flag of the product packaging spec record',
    `height_mm` DECIMAL(18,2) COMMENT 'The height mm of the product packaging spec record',
    `hi` STRING COMMENT 'The hi of the product packaging spec record',
    `is_fsc_certified` BOOLEAN COMMENT 'The is fsc certified of the product packaging spec record',
    `is_rspo_certified` BOOLEAN COMMENT 'The is rspo certified of the product packaging spec record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the product packaging spec record',
    `lead_time_days` STRING COMMENT 'The lead time days of the product packaging spec record',
    `length_mm` DECIMAL(18,2) COMMENT 'The length mm of the product packaging spec record',
    `lifecycle_status` STRING COMMENT 'The lifecycle status of the product packaging spec record',
    `material_composition` STRING COMMENT 'The material composition of the product packaging spec record',
    `moq` STRING COMMENT 'The moq of the product packaging spec record',
    `notes` STRING COMMENT 'The notes of the product packaging spec record',
    `packaging_level` STRING COMMENT 'The packaging level of the product packaging spec record',
    `pcr_content_pct` DECIMAL(18,2) COMMENT 'The pcr content pct of the product packaging spec record',
    `print_method` STRING COMMENT 'The print method of the product packaging spec record',
    `product_packaging_spec_code` STRING COMMENT 'The product packaging spec code of the product packaging spec record',
    `product_packaging_spec_description` STRING COMMENT 'The product packaging spec description of the product packaging spec record',
    `product_packaging_spec_name` STRING COMMENT 'The product packaging spec name of the product packaging spec record',
    `product_packaging_spec_status` STRING COMMENT 'The product packaging spec status of the product packaging spec record',
    `qty_per_parent` STRING COMMENT 'The qty per parent of the product packaging spec record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the product packaging spec record',
    `recyclability_code` STRING COMMENT 'The recyclability code of the product packaging spec record',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'The regulatory compliance flag of the product packaging spec record',
    `source_system_code` STRING COMMENT 'The source system code of the product packaging spec record',
    `spec_code` STRING COMMENT 'The spec code of the product packaging spec record',
    `spec_name` STRING COMMENT 'The spec name of the product packaging spec record',
    `supplier_tooling_ref` STRING COMMENT 'The supplier tooling ref of the product packaging spec record',
    `tare_weight_g` DECIMAL(18,2) COMMENT 'The tare weight g of the product packaging spec record',
    `ti` STRING COMMENT 'The ti of the product packaging spec record',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the product packaging spec record',
    `uom` STRING COMMENT 'The uom of the product packaging spec record',
    `upc` STRING COMMENT 'The upc of the product packaging spec record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the product packaging spec record',
    `version_number` STRING COMMENT 'The version number of the product packaging spec record',
    `width_mm` DECIMAL(18,2) COMMENT 'The width mm of the product packaging spec record',
    CONSTRAINT pk_packaging_spec PRIMARY KEY(`packaging_spec_id`)
) COMMENT 'Packaging specification master defining the complete physical, material, structural, and hierarchy attributes of all packaging levels for each SKU — primary (bottle, tube, sachet, pouch), secondary (carton, sleeve, shrink-wrap), tertiary (case, shipper), display unit, and pallet. Each record represents one packaging level for one SKU and captures: component type, material composition (HDPE, PET, glass, paperboard, aluminum, PCR content %), dimensions (L×W×H), gross/tare weight, color, finish, print method, recyclability code (How2Recycle label), FSC/RSPO certification flag, supplier tooling reference, quantity per hierarchy level (e.g., 12 eaches per case, 48 cases per pallet), Ti-Hi pallet configuration, and GTIN assigned at that level. Supports sustainability reporting (EPR, plastic tax), planogram compliance, DRP/MRP calculations, warehouse slotting, transportation cube optimization, and retailer EDI order processing. [SSOT: authoritative table is research.research_packaging_spec; this table is a deprecated duplicate.] [Non-authoritative; defers to SSOT research.research_packaging_spec for concept packaging_spec.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` (
    `label_spec_id` BIGINT COMMENT 'Unique surrogate identifier for each label specification record. Primary key for the label_spec data product in the product domain.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: A regulatory label specification is derived from the approved product formulation — the ingredient_declaration_text, INCI names, allergen declarations, and regulatory statements on the label must alig',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Label printing is a distinct procurement category in consumer goods managed by packaging procurement teams. Each label spec must reference the approved print supplier for sourcing, quality control, an',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: A label specification is physically applied to a specific packaging component — the label dimensions, substrate material, print process, and barcode placement are all defined in relation to the packag',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this label specification applies. Links the label spec to the product master.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Label approval process in consumer goods requires QA sign-off against the governing quality specification for regulatory compliance (allergen declarations, mandatory warnings). This FK enables label c',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Retailer-specific label requirements (private label, export compliance labels, retailer-mandated warning statements) are a standard consumer goods operational need. Linking label_spec to trade_account',
    `allergen_declaration` STRING COMMENT 'Allergen declaration text as printed on the label (e.g., Contains: Milk, Soy, May contain traces of nuts). Mandatory for food and personal care products under FDA FALCPA and EU Regulation 1169/2011.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the label spec record',
    `approval_status` STRING COMMENT 'Current workflow status of the label specification in the regulatory and artwork approval process. Drives gating of production print runs and market release.. Valid values are `draft|under_review|approved|rejected|superseded`',
    `artwork_file_reference` STRING COMMENT 'Document management system reference or file path to the approved artwork file for this label specification (e.g., Veeva Vault document ID or DAM asset reference). Links label spec to the physical artwork asset.',
    `barcode_placement` STRING COMMENT 'Specification of the physical placement zone for the barcode on the label or packaging (e.g., bottom-right back panel, base of container). Ensures retail scanner readability and planogram compliance.',
    `barcode_type` STRING COMMENT 'Type of barcode symbology specified for placement on the label (e.g., UPC-A, EAN-13, ITF-14, GS1-128, QR Code, DataMatrix). Governs scanner compatibility at retail POS and logistics. [ENUM-REF-CANDIDATE: UPC-A|EAN-13|EAN-8|ITF-14|GS1-128|QR_Code|DataMatrix — 7 candidates stripped; promote to reference product]',
    `certification_marks` STRING COMMENT 'Third-party certification marks and logos authorized for display on this label (e.g., USDA Organic, NSF Certified, Leaping Bunny, RSPO, FSC, CE Mark). Subject to certification body licensing requirements.',
    `claim_text` STRING COMMENT 'Marketing and regulatory claims printed on the label (e.g., Dermatologist Tested, Cruelty-Free, Hypoallergenic, Organic, Clinically Proven). Subject to FTC advertising substantiation requirements.',
    `label_spec_code` STRING COMMENT 'The label spec code of the label spec record',
    `color_profile` STRING COMMENT 'Color management profile and ink specification for the label (e.g., CMYK + 2 Pantone, Pantone 485C + Black). Ensures brand color consistency across print runs and suppliers.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country of manufacture as declared on the label. Mandatory for customs, trade compliance, and consumer disclosure in most markets.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this label specification record was first created in the system. Supports audit trail, data lineage, and regulatory record-keeping requirements.',
    `currency_code` STRING COMMENT 'The currency code of the label spec record',
    `label_spec_description` STRING COMMENT 'The label spec description of the label spec record',
    `digital_watermark_enabled` BOOLEAN COMMENT 'Indicates whether a digital watermark (e.g., GS1 Digital Link, Digimarc) is embedded in the label artwork to support connected packaging, consumer engagement, and supply chain traceability.',
    `distributor_name` STRING COMMENT 'Legal name of the distributor or importer as printed on the label, where different from the manufacturer. Required in markets where the responsible party is the local distributor.',
    `effective_date` DATE COMMENT 'Date from which this label specification version is valid and authorized for use in production and distribution. Supports regulatory compliance date tracking.',
    `effective_from` DATE COMMENT 'The effective from of the label spec record',
    `effective_until` DATE COMMENT 'The effective until of the label spec record',
    `expiry_date` DATE COMMENT 'Date after which this label specification version is no longer valid and must be superseded. Nullable for open-ended specifications. Supports artwork lifecycle management.',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number (GTIN) as encoded in the barcode on this label. Uniquely identifies the trade item at the specified packaging level per GS1 standards.. Valid values are `^[0-9]{14}$`',
    `ingredient_declaration_text` STRING COMMENT 'Full ingredient declaration text as it appears on the label, including INCI (International Nomenclature of Cosmetic Ingredients) names for cosmetics or common/scientific names for food and household products. Mandatory for regulatory compliance.',
    `is_primary_label` BOOLEAN COMMENT 'Indicates whether this label specification is the primary (master) label for the SKU-market-language combination, as opposed to a supplementary or promotional label variant.',
    `label_approval_date` DATE COMMENT 'Date on which the label specification received final regulatory and quality approval, authorizing use in production. Key milestone in the PLM artwork approval workflow.',
    `label_dimensions` STRING COMMENT 'Physical dimensions of the label (width x height in mm, e.g., 120x80mm). Required for print production specifications and packaging line setup.',
    `label_spec_status` STRING COMMENT 'The label spec status of the label spec record',
    `label_type` STRING COMMENT 'Categorizes the physical placement and function of the label on the product packaging (e.g., front_of_pack, back_of_pack, inner_label, neck_label, hang_tag, insert). Drives artwork management and regulatory review workflows.. Valid values are `front_of_pack|back_of_pack|inner_label|neck_label|hang_tag|insert`',
    `label_version` STRING COMMENT 'Version number of the label specification (e.g., 1.0, 2.1, 3.0). Used to track label revisions and manage artwork lifecycle in PLM and Veeva Vault.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) for the label text (e.g., en, fr, de, es, zh-CN). Supports multilingual labeling requirements.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this label specification record was most recently updated. Supports change tracking, audit trail, and downstream data synchronization.',
    `lot_code_format` STRING COMMENT 'Format specification for the lot/batch code printed on the label (e.g., YYYYMMDD-XXXX, Julian date + shift code). Enables product traceability and recall management.',
    `mandatory_regulatory_statements` STRING COMMENT 'Concatenated text of all mandatory regulatory statements required by the applicable regulatory framework (e.g., FDA required statements, EU mandatory disclosures, CPSC safety notices). Stored as structured text for label artwork population.',
    `manufacturer_address` STRING COMMENT 'Full address of the manufacturer or responsible party as printed on the label. Mandatory for consumer contact and regulatory traceability in most jurisdictions.',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturer or responsible party as printed on the label. Required by FDA, EU, and most national regulatory frameworks for product traceability.',
    `market_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the market or country for which this label specification is valid (e.g., USA, GBR, DEU, FRA). Supports multi-market regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `label_spec_name` STRING COMMENT 'The label spec name of the label spec record',
    `net_content_declaration` STRING COMMENT 'Net content statement as printed on the label, including quantity and unit of measure (e.g., 500 mL, 16 fl oz (473 mL), 250 g). Mandatory per weights and measures regulations.',
    `notes` STRING COMMENT 'The notes of the label spec record',
    `nutrition_facts_required` BOOLEAN COMMENT 'Indicates whether a Nutrition Facts panel or equivalent nutritional information table is required on this label per applicable regulatory framework. Applies to food, beverage, and dietary supplement categories.',
    `plm_change_order_number` STRING COMMENT 'Change order or engineering change notice (ECN) number from the PLM system that authorized this label specification version. Provides traceability to the formal change management process.',
    `print_process` STRING COMMENT 'Printing technology specified for producing this label (e.g., flexographic, digital, offset, gravure, screen). Determines supplier qualification and color reproduction requirements.. Valid values are `flexographic|digital|offset|gravure|screen`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the label spec record',
    `recycling_symbol_code` STRING COMMENT 'Recycling and environmental symbol codes required on the label (e.g., Mobius loop resin identification code, Green Dot, Tidyman, FSC logo). Supports sustainability compliance and consumer communication.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework governing this label specification (e.g., FDA 21 CFR, EU Regulation 1169/2011, CPSC 16 CFR, Health Canada). Determines mandatory statement requirements. [ENUM-REF-CANDIDATE: FDA_21_CFR|EU_1169_2011|CPSC_16_CFR|Health_Canada|ANVISA|TGA|SFDA — promote to reference product]',
    `regulatory_registration_number` STRING COMMENT 'Product registration or notification number assigned by the regulatory authority for the target market (e.g., FDA Facility Registration, EU Cosmetic Product Notification Portal reference, CPNP number). Required on label in certain markets.',
    `shelf_life_statement` STRING COMMENT 'Shelf life or best-before/expiry date format statement as printed on the label (e.g., Best Before: see base, Use By: MM/YYYY, PAO 12M). Supports FEFO inventory management and consumer safety.',
    `source_system_code` STRING COMMENT 'The source system code of the label spec record',
    `substrate_material` STRING COMMENT 'Material specification for the label substrate (e.g., White BOPP, Kraft Paper, Clear PET, Foil). Drives procurement of label stock and sustainability reporting.',
    `uom` STRING COMMENT 'The uom of the label spec record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the label spec record',
    `usage_instructions` STRING COMMENT 'Directions for use as printed on the label (e.g., application method, dosage, frequency, preparation instructions). Required for regulated product categories and consumer safety.',
    `veeva_document_reference` STRING COMMENT 'Document identifier in Veeva Vault for the controlled label specification document. Provides direct traceability to the system of record for regulatory submissions and quality documents.',
    `warning_statements` STRING COMMENT 'All warning and precautionary statements required on the label (e.g., Keep out of reach of children, Flammable, allergen warnings, GHS hazard statements). Mandatory for consumer safety compliance.',
    CONSTRAINT pk_label_spec PRIMARY KEY(`label_spec_id`)
) COMMENT 'Regulatory labeling specification for each SKU and market/country combination. Captures label version, language, market/country code, label type (front-of-pack, back-of-pack, inner label), mandatory regulatory statements (FDA, EU, CPSC), ingredient declaration text, net content declaration, warning statements, usage instructions, claim text (e.g., dermatologist tested, cruelty-free), barcode placement, and label approval status. Supports multi-market regulatory compliance and artwork management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` (
    `product_brand_id` BIGINT COMMENT 'Unique surrogate identifier for each brand master record in the Consumer Goods portfolio. Primary key for the product_brand dimension, referenced by all downstream domains including marketing, trade promotion, and financial reporting.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Brand legal entity ownership for trademark amortization, royalty accounting, and intercompany licensing. In multi-entity CPG companies, brands are owned by specific legal entities. The plain owner_en',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Brand-level spend tracking and marketing budget allocation. In CPG, each product brand is assigned a cost center for brand overhead, A&P spend, and brand profitability reporting. Finance controllers e',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand-level P&L reporting. CPG companies run profit center accounting at the brand level — brand revenue, COGS, and gross margin are tracked per profit center. Standard SAP CO-PA setup; brand managers',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the product brand record',
    `architecture_type` STRING COMMENT 'The architecture type of the product brand record',
    `brand_name` STRING COMMENT 'The brand name of the product brand record',
    `brand_status` STRING COMMENT 'The brand status of the product brand record',
    `brand_tier` STRING COMMENT 'The brand tier of the product brand record',
    `product_brand_code` STRING COMMENT 'The product brand code of the product brand record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product brand record',
    `currency_code` STRING COMMENT 'The currency code of the product brand record',
    `product_brand_description` STRING COMMENT 'The product brand description of the product brand record',
    `distribution_channel` STRING COMMENT 'The distribution channel of the product brand record',
    `divestiture_date` DATE COMMENT 'The divestiture date of the product brand record',
    `ean_prefix` STRING COMMENT 'The ean prefix of the product brand record',
    `effective_from` DATE COMMENT 'The effective from of the product brand record',
    `effective_until` DATE COMMENT 'The effective until of the product brand record',
    `equity_methodology` STRING COMMENT 'The equity methodology of the product brand record',
    `geographic_scope` STRING COMMENT 'The geographic scope of the product brand record',
    `gmp_certification_ref` STRING COMMENT 'The gmp certification ref of the product brand record',
    `is_licensed_brand` BOOLEAN COMMENT 'The is licensed brand of the product brand record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the product brand record',
    `launch_date` DATE COMMENT 'The launch date of the product brand record',
    `launch_year` STRING COMMENT 'The launch year of the product brand record',
    `license_expiry_date` DATE COMMENT 'The license expiry date of the product brand record',
    `msrp_currency_code` STRING COMMENT 'The msrp currency code of the product brand record',
    `product_brand_name` STRING COMMENT 'The product brand name of the product brand record',
    `notes` STRING COMMENT 'The notes of the product brand record',
    `nps_tracking_enabled` BOOLEAN COMMENT 'The nps tracking enabled of the product brand record',
    `owner_division` STRING COMMENT 'The owner division of the product brand record',
    `parent_brand_code` STRING COMMENT 'The parent brand code of the product brand record',
    `plm_stage` STRING COMMENT 'The plm stage of the product brand record',
    `positioning_statement` STRING COMMENT 'The positioning statement of the product brand record',
    `primary_country_code` STRING COMMENT 'The primary country code of the product brand record',
    `product_brand_status` STRING COMMENT 'The product brand status of the product brand record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the product brand record',
    `regulatory_classification` STRING COMMENT 'The regulatory classification of the product brand record',
    `short_name` STRING COMMENT 'The short name of the product brand record',
    `social_media_handle` STRING COMMENT 'The social media handle of the product brand record',
    `source_system_brand_code` STRING COMMENT 'The source system brand code of the product brand record',
    `source_system_code` STRING COMMENT 'The source system code of the product brand record',
    `sustainability_certification` STRING COMMENT 'The sustainability certification of the product brand record',
    `trade_promotion_eligible` BOOLEAN COMMENT 'The trade promotion eligible of the product brand record',
    `trademark_jurisdiction` STRING COMMENT 'The trademark jurisdiction of the product brand record',
    `trademark_registration_ref` STRING COMMENT 'The trademark registration ref of the product brand record',
    `uom` STRING COMMENT 'The uom of the product brand record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the product brand record',
    `website_url` STRING COMMENT 'The website url of the product brand record',
    CONSTRAINT pk_product_brand PRIMARY KEY(`product_brand_id`)
) COMMENT 'Brand master record defining each consumer goods brand in the portfolio. Captures brand code, brand name, brand tier (premium, mass, value), parent brand (for sub-brands), brand owner entity, brand launch year, brand positioning statement, target consumer segment, primary category, brand trademark registration reference, brand status (active, dormant, divested), and the brand equity tracking methodology. Serves as the authoritative brand dimension for marketing, trade promotion, and financial reporting. [SSOT] Superseded by authoritative table marketing.marketing_brand for concept brand. SSOT: canonical table is marketing.marketing_brand. [SSOT for concept brand.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`registration` (
    `registration_id` BIGINT COMMENT 'Primary key for the registration association',
    `address_id` BIGINT COMMENT 'Foreign key linking to consumer.address. Business justification: Product registration captures a consumers address for warranty service dispatch, product recall notifications, and regulatory compliance (CPSC recall traceability). Linking to consumer.address enable',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: Product recall management requires tracing registered consumer products to their batch release record to identify affected consumers for targeted recall notifications. Regulatory recall processes (FDA',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: CPG product registrations are attributed to acquisition campaigns (e.g., registered via summer loyalty campaign) for campaign ROI measurement and CRM attribution reporting. registration_source and r',
    `loyalty_account_id` BIGINT COMMENT 'Foreign key linking to consumer.loyalty_account. Business justification: Product registration is a primary loyalty enrollment touchpoint in consumer goods (e.g., Dyson, Philips). Linking registration to loyalty_account enables warranty-loyalty integration, post-purchase lo',
    `shopper_id` BIGINT COMMENT 'add column registered_shopper_id (BIGINT) with FK to consumer.shopper.shopper_id - product registration is a consumer warranty/registration record',
    `registration_product_shopper_id` BIGINT COMMENT 'Foreign key linking to the shopper who registers the SKU',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Warranty/product registration analytics by retail store: consumer goods brands track registrations by point-of-sale store for recall targeting, warranty claim validation, and retail performance report',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU being registered',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the product registration record',
    `channel` STRING COMMENT 'The registration channel of the product registration record',
    `consent_marketing_flag` BOOLEAN COMMENT 'The consent marketing flag of the product registration record',
    `consent_to_marketing` BOOLEAN COMMENT 'The consent to marketing of the product registration record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the product registration record',
    `currency_code` STRING COMMENT 'The currency code of the product registration record',
    `effective_from` DATE COMMENT 'The effective from of the product registration record',
    `effective_until` DATE COMMENT 'The effective until of the product registration record',
    `extended_warranty_flag` BOOLEAN COMMENT 'The extended warranty flag of the product registration record',
    `extended_warranty_purchased` BOOLEAN COMMENT 'The extended warranty purchased of the product registration record',
    `gift_flag` BOOLEAN COMMENT 'The gift flag of the product registration record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the product registration record',
    `lot_number` STRING COMMENT 'The lot number of the product registration record',
    `marketing_consent_flag` BOOLEAN COMMENT 'The marketing consent flag of the product registration record',
    `marketing_opt_in` BOOLEAN COMMENT 'The marketing opt in of the product registration record',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'The marketing opt in flag of the product registration record',
    `notes` STRING COMMENT 'The notes of the product registration record',
    `opt_in_marketing_flag` BOOLEAN COMMENT 'The opt in marketing flag of the product registration record',
    `product_condition` STRING COMMENT 'The product condition of the product registration record',
    `product_registration_code` STRING COMMENT 'The product registration code of the product registration record',
    `product_registration_description` STRING COMMENT 'The product registration description of the product registration record',
    `product_registration_name` STRING COMMENT 'The product registration name of the product registration record',
    `product_registration_status` STRING COMMENT 'The product registration status of the product registration record',
    `proof_of_purchase_ref` STRING COMMENT 'The proof of purchase ref of the product registration record',
    `proof_of_purchase_reference` STRING COMMENT 'The proof of purchase reference of the product registration record',
    `purchase_channel` STRING COMMENT 'The purchase channel of the product registration record',
    `purchase_date` DATE COMMENT 'The purchase date of the product registration record',
    `purchase_price` DECIMAL(18,2) COMMENT 'The purchase price of the product registration record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the product registration record',
    `recall_notification_opt_in` BOOLEAN COMMENT 'The recall notification opt in of the product registration record',
    `reference` STRING COMMENT 'The registration reference of the product registration record',
    `registered_email` STRING COMMENT 'The registered email of the product registration record',
    `registration_date` DATE COMMENT 'The registration date of the product registration record',
    `registration_number` STRING COMMENT 'The registration number of the product registration record',
    `registration_status` STRING COMMENT 'The registration status of the product registration record',
    `retailer_name` STRING COMMENT 'The retailer name of the product registration record',
    `serial_number` STRING COMMENT 'The serial number of the product registration record',
    `source` STRING COMMENT 'The registration source of the product registration record',
    `source_system_code` STRING COMMENT 'The source system code of the product registration record',
    `uom` STRING COMMENT 'The uom of the product registration record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the product registration record',
    `verification_status` STRING COMMENT 'The verification status of the product registration record',
    `verified_flag` BOOLEAN COMMENT 'The verified flag of the product registration record',
    `warranty_duration_months` STRING COMMENT 'The warranty duration months of the product registration record',
    `warranty_end_date` DATE COMMENT 'The warranty end date of the product registration record',
    `warranty_expiry_date` DATE COMMENT 'The warranty expiry date of the product registration record',
    `warranty_period_months` STRING COMMENT 'The warranty period months of the product registration record',
    `warranty_start_date` DATE COMMENT 'The warranty start date of the product registration record',
    `warranty_status` STRING COMMENT 'The warranty status of the product registration record',
    `warranty_term_months` STRING COMMENT 'The warranty term months of the product registration record',
    `warranty_type` STRING COMMENT 'The warranty type of the product registration record',
    CONSTRAINT pk_registration PRIMARY KEY(`registration_id`)
) COMMENT 'Represents the warranty/recall registration linking a SKU to a shopper. Each record captures when and how a shopper registered a product and the current warranty status.. Existence Justification: Consumers actively register each purchased SKU for warranty and recall purposes. A single SKU can be registered by many shoppers, and a shopper can register many different SKUs. The registration itself carries attributes such as registration date, source, and warranty status, making it an operational M:N relationship. [SSOT: authoritative table is regulatory.regulatory_registration; this table is a deprecated duplicate.] [SSOT: authoritative table is regulatory.regulatory_registration; this is a deprecated duplicate for concept registration.] [Non-authoritative; defers to SSOT regulatory.regulatory_registration for concept registration.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Primary key for category',
    `hierarchy_id` BIGINT COMMENT 'The hierarchy id of the category record',
    `parent_category_id` BIGINT COMMENT 'Identifier of the immediate parent category in the hierarchy (null for top‑level).',
    `parent_product_category_id` BIGINT COMMENT 'Self-referencing FK on product_category (parent_product_category_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Category-level P&L management. CPG category managers report revenue, trade spend, and margin by product category mapped to profit centers. Standard in SAP CO-PA for category management reporting, trad',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the category record',
    `business_unit` STRING COMMENT 'Business unit responsible for the category (e.g., global, regional, local).',
    `category_status` STRING COMMENT 'Current lifecycle status of the category.',
    `category_type` STRING COMMENT 'The category type of the category record',
    `classification` STRING COMMENT 'High‑level business classification of the category for reporting and analytics.',
    `classification_type` STRING COMMENT 'Business classification indicating the nature of the category.',
    `category_code` STRING COMMENT 'Standardized alphanumeric code identifying the category (e.g., GS1 segment).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the category record',
    `category_description` STRING COMMENT 'Detailed textual description of the category, its purpose and typical product types.',
    `display_order` STRING COMMENT 'Ordinal value used to order categories in UI listings.',
    `effective_from` DATE COMMENT 'Date when the category becomes active for product assignment.',
    `effective_until` DATE COMMENT 'Date when the category is retired or no longer usable (null if open‑ended).',
    `gpc_brick_code` STRING COMMENT 'The gpc brick code of the category record',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the category within the hierarchy (1 = top level).',
    `hierarchy_path` STRING COMMENT 'Slash‑delimited path of ancestor category IDs (e.g., "/1/5/9").',
    `image_url` STRING COMMENT 'Link to the representative image for the category.',
    `is_active` BOOLEAN COMMENT 'The is active of the category record',
    `is_leaf` BOOLEAN COMMENT 'Flag indicating whether the category has no child categories.',
    `is_leaf_node` BOOLEAN COMMENT 'The is leaf node of the category record',
    `category_level` STRING COMMENT 'The category level of the category record',
    `marketing_tag` STRING COMMENT 'Marketing label applied to the category for promotional purposes.',
    `merchandising_segment` STRING COMMENT 'The merchandising segment of the category record',
    `category_name` STRING COMMENT 'Human‑readable name of the product category.',
    `nielsen_category_code` STRING COMMENT 'The nielsen category code of the category record',
    `notes` STRING COMMENT 'The notes of the category record',
    `path` STRING COMMENT 'The category path of the category record',
    `product_category_code` STRING COMMENT 'The product category code of the category record',
    `product_category_description` STRING COMMENT 'The product category description of the category record',
    `product_category_name` STRING COMMENT 'The product category name of the category record',
    `product_category_status` STRING COMMENT 'Current lifecycle status of the category (e.g., active for use, deprecated for retirement).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the category record',
    `sort_order` STRING COMMENT 'The sort order of the category record',
    `source_system_code` STRING COMMENT 'The source system code of the category record',
    `uom` STRING COMMENT 'The uom of the category record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Master reference table for category. Referenced by category_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`material` (
    `material_id` BIGINT COMMENT 'Primary key for material',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Material valuation and inventory accounting. In CPG/SAP MM-FI integration, each material (raw material, packaging) is assigned a GL account via valuation class for inventory posting, COGS recognition,',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Plant-specific material master is a core ERP concept (SAP MM): raw/packaging materials are qualified per manufacturing facility for GMP compliance, MRP planning, and procurement. A manufacturing domai',
    `parent_material_id` BIGINT COMMENT 'Self-referencing FK on material (parent_material_id)',
    `supplier_id` BIGINT COMMENT 'Identifier of the primary supplier for the material.',
    `allergen_info` STRING COMMENT 'Allergen declarations associated with the material, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the material record',
    `base_uom` STRING COMMENT 'Standard unit of measure used for inventory and transactions.',
    `brand_name` STRING COMMENT 'Brand under which the material is marketed.',
    `cas_number` STRING COMMENT 'The cas number of the material record',
    `material_code` STRING COMMENT 'Internal stock‑keeping unit or catalogue code that uniquely identifies the material within the enterprise.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO code of the country where the material is produced.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the standard cost.',
    `material_description` STRING COMMENT 'Free‑form textual description of the material, including usage notes.',
    `ean` STRING COMMENT '13‑digit European article number for the material.',
    `effective_from` DATE COMMENT 'Date when the material becomes effective for business use.',
    `effective_until` DATE COMMENT 'Date when the material is retired or no longer valid (null if open‑ended).',
    `group` STRING COMMENT 'Higher‑level grouping used for reporting and analytics.',
    `gtin` STRING COMMENT '14‑digit global identifier assigned to the material for trade and retail purposes.',
    `hazard_classification` STRING COMMENT 'The hazard classification of the material record',
    `hazardous_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under safety regulations.',
    `inci_name` STRING COMMENT 'The inci name of the material record',
    `is_hazardous` BOOLEAN COMMENT 'The is hazardous of the material record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the material record.',
    `lead_time_days` STRING COMMENT 'The lead time days of the material record',
    `lifecycle_stage` STRING COMMENT 'Current stage of the material within its product lifecycle.',
    `material_status` STRING COMMENT 'Current lifecycle state of the material.',
    `material_type` STRING COMMENT 'Category describing the nature of the material within the product hierarchy.',
    `material_name` STRING COMMENT 'Human‑readable name of the material used in catalogs and reports.',
    `notes` STRING COMMENT 'The notes of the material record',
    `number` STRING COMMENT 'The number of the material record',
    `packaging_type` STRING COMMENT 'Primary packaging format for the material.',
    `procurement_type` STRING COMMENT 'The procurement type of the material record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the material record',
    `regulatory_status` STRING COMMENT 'Current compliance status of the material with relevant regulations.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before expiration.',
    `source_system_code` STRING COMMENT 'The source system code of the material record',
    `standard_cost` DECIMAL(18,2) COMMENT 'Default cost price of the material used for costing and pricing calculations.',
    `storage_conditions` STRING COMMENT 'The storage conditions of the material record',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Optimal storage temperature for the material in degrees Celsius.',
    `unit_conversion_factor` DECIMAL(18,2) COMMENT 'Factor to convert from the materials base UOM to alternative units.',
    `uom` STRING COMMENT 'The uom of the material record',
    `upc` STRING COMMENT '12‑digit UPC code used primarily in North America.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the material record',
    `volume_l` DECIMAL(18,2) COMMENT 'Typical volume of the material per unit, expressed in liters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of a single unit of material expressed in kilograms.',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Master reference table for material. Referenced by material_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_sku_product_category_id` FOREIGN KEY (`sku_product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_hierarchy_id` FOREIGN KEY (`parent_hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ADD CONSTRAINT `fk_product_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ADD CONSTRAINT `fk_product_category_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_product_category_id` FOREIGN KEY (`parent_product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_parent_material_id` FOREIGN KEY (`parent_material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Default Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Product Color');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Sku Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'SKU Discontinuation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `fefo_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `inci_declaration` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_recyclable_packaging` SET TAGS ('dbx_business_glossary_term' = 'Recyclable Packaging Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_regulated_product` SET TAGS ('dbx_business_glossary_term' = 'Regulated Product Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_regulated_product` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_regulated_product` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `is_sustainable` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Product Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'SKU Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `msrp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_name` SET TAGS ('dbx_business_glossary_term' = 'Sku Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `net_content` SET TAGS ('dbx_business_glossary_term' = 'Net Content (Quantity)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `net_content_uom` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size (Consumer Units per Pack)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `packaging_material_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Packaging Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `portfolio_classification` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `portfolio_classification` SET TAGS ('dbx_value_regex' = 'core|strategic|tail|innovation|seasonal|limited_edition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_form` SET TAGS ('dbx_business_glossary_term' = 'Product Form');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `scent` SET TAGS ('dbx_business_glossary_term' = 'Scent / Fragrance Descriptor');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|discontinued|pending_launch');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_temperature|dry|flammable');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `sub_brand` SET TAGS ('dbx_business_glossary_term' = 'Sub-Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `total_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Total Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `variant` SET TAGS ('dbx_business_glossary_term' = 'Product Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Product Volume (Millilitres)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Registry ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `account_address_id` SET TAGS ('dbx_directive' = 'P5');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Activation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Assignment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `barcode_symbology` SET TAGS ('dbx_business_glossary_term' = 'Barcode Symbology');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `brand_owner_gln` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `brand_owner_gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `cases_per_pallet` SET TAGS ('dbx_business_glossary_term' = 'Cases Per Pallet');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `check_digit` SET TAGS ('dbx_business_glossary_term' = 'GTIN Check Digit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `check_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_code` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `data_pool_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Data Pool Publication Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `data_pool_published` SET TAGS ('dbx_business_glossary_term' = 'Data Pool Published Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_description` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `ean_value` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `edi_eligible` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_business_glossary_term' = 'GS1 Global Product Classification (GPC) Brick Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_business_glossary_term' = 'GS1 Company Prefix');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_member_org` SET TAGS ('dbx_business_glossary_term' = 'GS1 Member Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_registration_reference` SET TAGS ('dbx_business_glossary_term' = 'GS1 Registration Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gs1_registry_published` SET TAGS ('dbx_business_glossary_term' = 'GS1 Registry Published Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_format` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Format');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_format` SET TAGS ('dbx_value_regex' = 'GTIN-8|GTIN-12|GTIN-13|GTIN-14');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_status` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Status');
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
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_name` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `net_content_uom` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `net_content_value` SET TAGS ('dbx_business_glossary_term' = 'Net Content Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'each|inner_pack|case|pallet');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `plm_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `plm_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'concept|development|commercialization|active|end_of_life|discontinued');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'GTIN Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Retirement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Natural Key');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `target_market_country` SET TAGS ('dbx_business_glossary_term' = 'Target Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `target_market_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `units_per_case` SET TAGS ('dbx_business_glossary_term' = 'Units Per Case');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `upc_value` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC) Value');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `parent_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `cpsc_regulated` SET TAGS ('dbx_business_glossary_term' = 'CPSC Regulated Flag (Consumer Product Safety Commission)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `cpsc_regulated` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `cpsc_regulated` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Description');
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
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `ibp_planning_level` SET TAGS ('dbx_business_glossary_term' = 'IBP Planning Level Flag (Integrated Business Planning)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `inci_applicable` SET TAGS ('dbx_business_glossary_term' = 'INCI Applicable Flag (International Nomenclature of Cosmetic Ingredients)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `iri_category_code` SET TAGS ('dbx_business_glossary_term' = 'IRI Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `level_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `market_share_reportable` SET TAGS ('dbx_business_glossary_term' = 'Market Share Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `nielsen_category_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen IQ Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Full Path');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `plm_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'PLM Lifecycle Stage (Product Lifecycle Management)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `reach_regulated` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Regulated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `reach_regulated` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `reach_regulated` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `source_system_node_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Node ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `trade_promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_subdomain' = 'formulation_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `account_address_id` SET TAGS ('dbx_directive' = 'P7');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant / Production Site ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `alternative_bom` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bill of Materials (BOM) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
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
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_code` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `component_count` SET TAGS ('dbx_business_glossary_term' = 'BOM Component Count');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `costing_relevance` SET TAGS ('dbx_business_glossary_term' = 'Costing Relevance Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `costing_relevance` SET TAGS ('dbx_value_regex' = 'relevant|not_relevant|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'BOM Deletion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_description` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective Until Date');
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
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_name` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `plm_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `plm_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|active|obsolete|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_status` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Regulation Compliant Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `source_system_bom_code` SET TAGS ('dbx_business_glossary_term' = 'Source System BOM Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'BOM Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'formulation_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Item ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `alternative_priority` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_item_category` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_item_category` SET TAGS ('dbx_value_regex' = 'stock|non_stock|variable_size|document|text|class');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bulk_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `co_product_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Product Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_code` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Component Cost (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_item_number` SET TAGS ('dbx_business_glossary_term' = 'Component Item Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging|semi_finished|finished_good|co_product|by_product');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_description` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
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
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `bom_line_name` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Production Operation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `phantom_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Phantom Item Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `recursive_bom_flag` SET TAGS ('dbx_business_glossary_term' = 'Recursive BOM Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `usage_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Usage Probability Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` SET TAGS ('dbx_subdomain' = 'formulation_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `active_ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `active_ingredient_pct` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `bom_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Bom Reference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `color_description` SET TAGS ('dbx_business_glossary_term' = 'Color Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Formulation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `fragrance_code` SET TAGS ('dbx_business_glossary_term' = 'Fragrance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Gmp Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `inci_declaration` SET TAGS ('dbx_business_glossary_term' = 'Inci Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `is_cruelty_free` SET TAGS ('dbx_business_glossary_term' = 'Is Cruelty Free');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `is_fragrance_free` SET TAGS ('dbx_business_glossary_term' = 'Is Fragrance Free');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Is Vegan');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `lab_notebook_reference` SET TAGS ('dbx_business_glossary_term' = 'Lab Notebook Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Formulation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `ph_max` SET TAGS ('dbx_business_glossary_term' = 'Ph Max');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `ph_min` SET TAGS ('dbx_business_glossary_term' = 'Ph Min');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `preservative_system` SET TAGS ('dbx_business_glossary_term' = 'Preservative System');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_description` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_status` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `product_formulation_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `rd_project_code` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Reach Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Rspo Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `stability_period_months` SET TAGS ('dbx_business_glossary_term' = 'Stability Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `total_solid_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Solid Content Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `viscosity_max_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Max Cps');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`formulation` ALTER COLUMN `viscosity_min_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Min Cps');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `artwork_ref` SET TAGS ('dbx_business_glossary_term' = 'Artwork Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'Ean');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `finish` SET TAGS ('dbx_business_glossary_term' = 'Finish');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `gross_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight G');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Gtin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height Mm');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `hi` SET TAGS ('dbx_business_glossary_term' = 'Hi');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `is_fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Fsc Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `is_rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Rspo Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length Mm');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Moq');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `pcr_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Pcr Content Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `print_method` SET TAGS ('dbx_business_glossary_term' = 'Print Method');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `product_packaging_spec_code` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `product_packaging_spec_description` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `product_packaging_spec_name` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `product_packaging_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `qty_per_parent` SET TAGS ('dbx_business_glossary_term' = 'Qty Per Parent');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `recyclability_code` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `supplier_tooling_ref` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tooling Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `tare_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight G');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `ti` SET TAGS ('dbx_business_glossary_term' = 'Ti');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Upc');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width Mm');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Label Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `artwork_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Artwork File Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `barcode_placement` SET TAGS ('dbx_business_glossary_term' = 'Barcode Placement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `certification_marks` SET TAGS ('dbx_business_glossary_term' = 'Certification Marks');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Label Claim Text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_spec_code` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_spec_description` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `digital_watermark_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Watermark Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Label Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `ingredient_declaration_text` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `is_primary_label` SET TAGS ('dbx_business_glossary_term' = 'Primary Label Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Label Dimensions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'front_of_pack|back_of_pack|inner_label|neck_label|hang_tag|insert');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_version` SET TAGS ('dbx_business_glossary_term' = 'Label Version');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `lot_code_format` SET TAGS ('dbx_business_glossary_term' = 'Lot Code Format');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `mandatory_regulatory_statements` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Regulatory Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `mandatory_regulatory_statements` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `mandatory_regulatory_statements` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `label_spec_name` SET TAGS ('dbx_business_glossary_term' = 'Label Spec Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `net_content_declaration` SET TAGS ('dbx_business_glossary_term' = 'Net Content Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `nutrition_facts_required` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Facts Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `plm_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Change Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `print_process` SET TAGS ('dbx_business_glossary_term' = 'Print Process');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `print_process` SET TAGS ('dbx_value_regex' = 'flexographic|digital|offset|gravure|screen');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `recycling_symbol_code` SET TAGS ('dbx_business_glossary_term' = 'Recycling Symbol Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_registration_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `regulatory_registration_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `shelf_life_statement` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `substrate_material` SET TAGS ('dbx_business_glossary_term' = 'Label Substrate Material');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `usage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Usage Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `warning_statements` SET TAGS ('dbx_business_glossary_term' = 'Warning Statements');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Architecture Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_description` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `divestiture_date` SET TAGS ('dbx_business_glossary_term' = 'Divestiture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `ean_prefix` SET TAGS ('dbx_business_glossary_term' = 'Ean Prefix');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `equity_methodology` SET TAGS ('dbx_business_glossary_term' = 'Equity Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `gmp_certification_ref` SET TAGS ('dbx_business_glossary_term' = 'Gmp Certification Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `is_licensed_brand` SET TAGS ('dbx_business_glossary_term' = 'Is Licensed Brand');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `launch_year` SET TAGS ('dbx_business_glossary_term' = 'Launch Year');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Msrp Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `nps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Nps Tracking Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `owner_division` SET TAGS ('dbx_business_glossary_term' = 'Owner Division');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `parent_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `plm_stage` SET TAGS ('dbx_business_glossary_term' = 'Plm Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Positioning Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_status` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `source_system_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trade_promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Eligible');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trademark_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Trademark Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `trademark_registration_ref` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Registration Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Address Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registration_product_shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Registration Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `consent_marketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Marketing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `consent_to_marketing` SET TAGS ('dbx_business_glossary_term' = 'Consent To Marketing');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `extended_warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `extended_warranty_purchased` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Purchased');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `gift_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `opt_in_marketing_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt In Marketing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `product_condition` SET TAGS ('dbx_business_glossary_term' = 'Product Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `product_registration_code` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `product_registration_description` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `product_registration_name` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `product_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `proof_of_purchase_ref` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Purchase Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `proof_of_purchase_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Purchase Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `purchase_channel` SET TAGS ('dbx_business_glossary_term' = 'Purchase Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `recall_notification_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Recall Notification Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Registration Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registered_email` SET TAGS ('dbx_business_glossary_term' = 'Registered Email');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registered_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registered_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `retailer_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration Months');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_term_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Term Months');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`registration` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `parent_product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `parent_product_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `gpc_brick_code` SET TAGS ('dbx_business_glossary_term' = 'Gpc Brick Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Url');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `is_leaf` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `marketing_tag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `merchandising_segment` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `nielsen_category_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Category Path');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `product_category_description` SET TAGS ('dbx_business_glossary_term' = 'Product Category Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `product_category_name` SET TAGS ('dbx_business_glossary_term' = 'Product Category Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `product_category_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_subdomain' = 'formulation_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `parent_material_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Material Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `parent_material_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Info');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Cas Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'Ean');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Gtin');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'Inci Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `unit_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Unit Conversion Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Upc');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `volume_l` SET TAGS ('dbx_business_glossary_term' = 'Volume L');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
