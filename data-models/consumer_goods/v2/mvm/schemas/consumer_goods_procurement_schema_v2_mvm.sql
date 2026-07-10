-- Schema for Domain: procurement | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-07-10 14:48:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`procurement` COMMENT 'Owns sourcing, supplier management, and purchase order execution for raw materials, packaging, and indirect goods. Manages supplier master data, contracts, RFQs, purchase requisitions, PO lifecycle, goods receipt, invoice verification, MOQ terms, SDS documentation, supplier performance scorecards, VMI programs, and sustainable sourcing initiatives (FSC, RSPO).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record. Primary key for the supplier entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Vendor master management: suppliers are assigned to company codes for legal entity-level procurement, tax reporting (VAT, withholding), and payment processing. Multi-entity consumer goods companies re',
    `address_line1` STRING COMMENT 'Primary street address line for the suppliers registered business location or headquarters.',
    `address_line2` STRING COMMENT 'Secondary address line for additional location details such as suite, building, or floor number.',
    `city` STRING COMMENT 'City or municipality name where the suppliers business location is registered.',
    `supplier_code` STRING COMMENT 'Internal business identifier or code assigned to the supplier for procurement and ERP system reference.',
    `contract_expiration_date` DATE COMMENT 'Date when the current master supply agreement or contract with the supplier expires and requires renewal or renegotiation.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the supplier is legally registered and operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code indicating the preferred currency for transactions and invoicing with this supplier.. Valid values are `^[A-Z]{3}$`',
    `diversity_classification` STRING COMMENT 'Classification indicating if the supplier qualifies as a diverse supplier (e.g., minority-owned, women-owned, veteran-owned, small business).',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify the supplier business entity globally.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier has EDI capability for automated exchange of purchase orders, invoices, and shipping notices.',
    `edi_identifier` STRING COMMENT 'Unique EDI identifier or interchange ID used for electronic document exchange with the supplier.',
    `fsc_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds FSC certification for sustainable forestry and paper-based materials sourcing.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the suppliers legal entity or physical location within the supply chain.. Valid values are `^[0-9]{13}$`',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier is certified for Good Manufacturing Practices, critical for consumer goods quality and safety compliance.',
    `incoterms` STRING COMMENT 'Standard Incoterms code defining the responsibilities, costs, and risks between buyer and supplier for international shipments. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `iso_9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier maintains ISO 9001 quality management system certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit or assessment conducted for quality, compliance, or sustainability verification.',
    `lead_time_days` STRING COMMENT 'Standard number of days required from purchase order placement to goods receipt for this supplier.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was last modified or updated in the system.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for purchase orders to be accepted.',
    `moq_unit` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., EA, KG, LB, L, cases, pallets).',
    `supplier_name` STRING COMMENT 'The full legal name of the supplier or vendor organization as registered with governing authorities.',
    `onboarding_date` DATE COMMENT 'Date when the supplier was officially onboarded and approved for procurement activities.',
    `onboarding_status` STRING COMMENT 'Current stage of the supplier onboarding process tracking progress from initial registration through final approval.. Valid values are `not_started|in_progress|documentation_review|compliance_check|approved|rejected`',
    `payment_method` STRING COMMENT 'Preferred method of payment for settling invoices with the supplier.. Valid values are `wire_transfer|ach|check|credit_card|edi_payment`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier defining the payment schedule and conditions (e.g., Net 30, Net 60, 2/10 Net 30).',
    `performance_score` DECIMAL(18,2) COMMENT 'Overall performance score for the supplier based on quality, delivery, cost, and service metrics, typically on a 0-100 scale.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the suppliers business address used for mail delivery and logistics coordination.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary supplier contact used for procurement communications and order coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the supplier organization responsible for account management.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary supplier contact for urgent procurement matters and order inquiries.',
    `risk_rating` STRING COMMENT 'Risk assessment classification for the supplier based on financial stability, geopolitical factors, compliance history, and supply continuity.. Valid values are `low|medium|high|critical`',
    `rspo_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds RSPO certification for sustainable palm oil sourcing practices.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division for the suppliers business address.',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier relationship indicating whether the supplier is eligible for procurement activities.. Valid values are `active|inactive|pending_approval|suspended|terminated`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on the category of goods or services provided to the business.. Valid values are `raw_material|packaging|indirect_goods|contract_manufacturer|service_provider|logistics_provider`',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number for the supplier (e.g., EIN in USA, VAT number in EU) used for tax reporting and compliance.',
    `tier` STRING COMMENT 'Strategic classification of the supplier indicating their relationship status and procurement priority level with the organization.. Valid values are `strategic|preferred|approved|conditional|blocked`',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether the supplier is eligible and capable of participating in Vendor Managed Inventory programs.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all suppliers, vendors, and contract manufacturers providing raw materials, packaging, and indirect goods. Captures supplier legal entity details, GS1/DUNS identifiers, tax registration, payment terms, MOQ terms, lead times, incoterms, preferred currency, supplier tier classification (strategic/preferred/approved/conditional), VMI eligibility flag, EDI capability, sustainability certifications (FSC, RSPO), and onboarding status. SSOT for supplier identity across the procurement domain.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` (
    `supplier_site_id` BIGINT COMMENT 'Unique identifier for the supplier site. Primary key for this entity.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent supplier organization that owns or operates this site.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: VMI programs map each supplier site to a specific distribution node to manage inventory ownership and replenishment.',
    `address_line_1` STRING COMMENT 'Primary street address line for the supplier site location.',
    `address_line_2` STRING COMMENT 'Secondary address line for building, suite, or unit information.',
    `audit_score` DECIMAL(18,2) COMMENT 'Most recent audit score for this site, typically on a 0-100 scale, reflecting compliance and quality performance.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the site capacity metric (e.g., units_per_month, pallets, square_meters, kilograms_per_day).',
    `certification_expiry_date` DATE COMMENT 'Date when the primary site certifications expire and require renewal. Used for compliance monitoring and supplier audit scheduling.',
    `city` STRING COMMENT 'City or municipality where the supplier site is located.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country where the site is located. Critical for country of origin tracking and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier site record was first created in the system.',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether this site is capable of exchanging purchase orders, invoices, and shipping notices via EDI.',
    `effective_end_date` DATE COMMENT 'Date when this supplier site was deactivated or ceased operations. Null for currently active sites.',
    `effective_start_date` DATE COMMENT 'Date when this supplier site became active and available for procurement operations.',
    `email_address` STRING COMMENT 'Primary email contact for the supplier site.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the supplier site, if applicable.',
    `fsc_certified` BOOLEAN COMMENT 'Indicates whether this site holds FSC certification for sustainable forestry and paper sourcing.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical site location for supply chain traceability and EDI transactions.. Valid values are `^[0-9]{13}$`',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether this site is certified for Good Manufacturing Practices, critical for pharmaceutical and food-grade materials.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether this site holds ISO 14001 Environmental Management System certification.',
    `iso_22716_certified` BOOLEAN COMMENT 'Indicates whether this site holds ISO 22716 Good Manufacturing Practices for Cosmetics certification.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether this site holds ISO 9001 Quality Management System certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at this site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier site record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supplier site, used for logistics optimization and distance calculations.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from this site to the buyers receiving location, used for procurement planning and MRP calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supplier site, used for logistics optimization and distance calculations.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required by this site for purchase orders.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., units, cases, pallets, kilograms).',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at this site.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the supplier site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supplier site address.',
    `preferred_site_flag` BOOLEAN COMMENT 'Indicates whether this site is designated as a preferred sourcing location based on performance, cost, or strategic criteria.',
    `rspo_certified` BOOLEAN COMMENT 'Indicates whether this site is certified by RSPO for sustainable palm oil sourcing.',
    `site_capacity` DECIMAL(18,2) COMMENT 'Maximum production or storage capacity of the site, measured in units relevant to the site type (e.g., units per month for manufacturing, pallets for warehouse).',
    `site_code` STRING COMMENT 'Internal or supplier-assigned unique code identifying this site location.',
    `site_manager_name` STRING COMMENT 'Name of the site manager or primary contact person responsible for this location.',
    `site_name` STRING COMMENT 'Business name or designation of the supplier site facility.',
    `site_status` STRING COMMENT 'Current operational status of the supplier site in the procurement system.. Valid values are `active|inactive|suspended|pending_approval|decommissioned`',
    `site_type` STRING COMMENT 'Classification of the site based on its primary business function.. Valid values are `manufacturing|warehouse|office|port|distribution_center|r_and_d`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the supplier site.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the site location, used for scheduling deliveries and coordinating communications.',
    `vmi_enabled` BOOLEAN COMMENT 'Indicates whether this site participates in a VMI program where the supplier manages inventory levels at the buyers location.',
    CONSTRAINT pk_supplier_site PRIMARY KEY(`supplier_site_id`)
) COMMENT 'Physical manufacturing, warehouse, or office locations associated with a supplier. Captures site address, site type (manufacturing/warehouse/office/port), GS1 GLN, country of origin, site capacity, certifications held at site level (ISO 9001, ISO 22716, GMP), site-level lead time, and active status. Supports multi-site supplier relationships and origin traceability for regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Unique identifier for the supplier contract record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity contract ownership: supplier contracts are executed by specific company codes for legal enforceability, tax compliance, and financial reporting. Multi-entity consumer goods companies requ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Brand Contract Management: contracts are associated with the brand they cover, needed for legal compliance and brand‑level cost analysis.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: supplier_contract.quality_specification is a denormalized text reference to the quality specification the supplier must meet. A proper FK to quality.specification enables contract compliance monitorin',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Supplier contracts are negotiated for specific spend categories (raw materials, packaging, indirect goods). Adding spend_category_id enables category-level contract coverage analytics, supports catego',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier party with whom this contract is negotiated.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who provided final approval for this contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry unless explicitly terminated by either party.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or URL to the signed contract document stored in document management system (e.g., Veeva Vault, SharePoint).',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract, used in procurement systems and supplier communications.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract: draft for initial creation, pending approval for review workflow, active for in-force agreements, suspended for temporary holds, expired for naturally ended contracts, terminated for early cancellation, or renewed for extended agreements. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the contract structure: framework agreement for multi-material commitments, blanket order for recurring purchases, spot purchase for one-time buys, long-term agreement for strategic partnerships, consignment for supplier-owned inventory, or vendor managed inventory (VMI) for supplier-controlled replenishment.. Valid values are `framework_agreement|blanket_order|spot_purchase|long_term_agreement|consignment|vendor_managed_inventory`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Total monetary value committed under this contract across all line items and periods, used for spend tracking and budget allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Agreed delivery conditions including lead times, delivery windows, and logistics requirements.',
    `effective_date` DATE COMMENT 'Date when the contract becomes legally binding and pricing terms take effect.',
    `expiry_date` DATE COMMENT 'Date when the contract naturally ends unless renewed or terminated earlier. Nullable for open-ended agreements.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law under which the contract is interpreted and enforced (e.g., State of Delaware, English Law).',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and supplier for shipping, insurance, and risk transfer (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated, used for change tracking and audit purposes.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity allowed per purchase order line under this contract, used to manage supplier capacity and volume commitments.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order line to qualify for contract pricing, expressed in base unit of measure.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this contract record.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, or internal comments not captured in structured fields.',
    `payment_terms` STRING COMMENT 'Agreed payment conditions such as net 30, net 60, or early payment discount terms (e.g., 2/10 net 30).',
    `penalty_clause` STRING COMMENT 'Terms defining financial penalties for supplier non-compliance, late delivery, quality failures, or other contractual breaches.',
    `price_escalation_formula` STRING COMMENT 'Mathematical formula or index reference used to adjust prices over time, such as CPI-based adjustments or commodity index linkage.',
    `pricing_mechanism` STRING COMMENT 'Method by which prices are determined: fixed price for static rates, cost plus for markup on supplier costs, market indexed for commodity-linked pricing, volume tiered for quantity-based discounts, or rebate based for retrospective incentives.. Valid values are `fixed_price|cost_plus|market_indexed|volume_tiered|rebate_based`',
    `purchasing_group` STRING COMMENT 'The buyer or procurement team assigned to manage this contract, responsible for execution and supplier relationship.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for negotiating and managing this contract, typically aligned with regional or divisional procurement teams.',
    `quantity_unit_of_measure` STRING COMMENT 'Base unit of measure for quantity commitments (e.g., KG, LTR, EA, MT) aligned with material master data.',
    `rebate_terms` STRING COMMENT 'Description of volume-based or performance-based rebate conditions, including thresholds, percentages, and settlement periods.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that either party must provide notice to prevent auto-renewal or initiate renewal negotiations.',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether supplier must provide Safety Data Sheets for hazardous materials covered by this contract, per OSHA and EPA regulations.',
    `sustainability_certification` STRING COMMENT 'Required sustainability certifications for materials under this contract, such as FSC (Forest Stewardship Council) for paper/packaging or RSPO (Roundtable on Sustainable Palm Oil) for palm oil derivatives.',
    `target_quantity_total` DECIMAL(18,2) COMMENT 'Aggregate quantity commitment across all materials and line items over the contract period, used for volume-based pricing and rebate calculations.',
    `termination_date` DATE COMMENT 'Actual date when the contract was terminated early, either by mutual agreement or due to breach. Null if contract expired naturally or is still active.',
    `termination_reason` STRING COMMENT 'Business reason for early termination, such as supplier performance issues, strategic sourcing changes, or mutual agreement.',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Procurement contracts and framework agreements negotiated with suppliers for raw materials, packaging, and indirect goods. Captures contract header (number, type, effective/expiry dates, total value, currency, pricing mechanism, rebate terms, penalty clauses, auto-renewal, governing law) and contract line items (material/SKU, agreed unit price, price UoM, target quantity, MOQ, max order quantity, price validity period, escalation formula, line status). Tracks contract lifecycle from draft through active to expired/terminated. Enables granular price and volume commitment tracking at the material level. Owns all line-level detail as embedded attributes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Unique identifier for the contract line item. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget commitment tracking: contract lines in consumer goods procurement are assigned to cost centers for budget commitment reporting and spend-against-budget analysis. This enables finance to track c',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Contract line items are charged to specific GL accounts for cost tracking; required for contract‑based accounting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution center that will receive the material. Used for multi-site procurement and logistics planning.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Contract lines specify raw materials (ingredients, packaging components) in addition to finished SKUs. Essential for procurement of bulk ingredients, chemicals, and packaging materials in consumer goo',
    `sku_id` BIGINT COMMENT 'Reference to the material, raw material, packaging component, or indirect good being procured under this contract line. Links to the product master for specifications and attributes.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: A contract line for a specific SKU must reference the applicable quality specification to enforce line-level quality requirements. This enables procurement to verify that the contracted material meets',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the parent supplier contract that contains this line item. Links this line to the master agreement governing terms, supplier, and overall contract lifecycle.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Contract lines in consumer goods procurement specify the sourcing terms for a material from a particular supplier site — for example, a contract line may specify that palm oil is to be sourced from a ',
    `blocked_reason` STRING COMMENT 'Explanation for why the contract line is blocked or inactive. Provides business context for procurement restrictions (e.g., quality issue, supplier non-compliance, price dispute).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract line record was first created in the system. Used for audit trail and data lineage tracking.',
    `cumulative_invoiced_value` DECIMAL(18,2) COMMENT 'Total invoiced value for all purchase orders released against this contract line to date. Used for spend tracking and budget management.',
    `cumulative_ordered_quantity` DECIMAL(18,2) COMMENT 'Total quantity ordered against this contract line to date. Used for tracking contract utilization and remaining commitment.',
    `cumulative_received_quantity` DECIMAL(18,2) COMMENT 'Total quantity received against this contract line to date. Used for tracking actual fulfillment and supplier performance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price. Defines the monetary denomination for all pricing on this contract line.. Valid values are `^[A-Z]{3}$`',
    `incoterm_code` STRING COMMENT 'International Commercial Terms code defining the division of costs and risks between buyer and supplier for this line item. Governs shipping, insurance, and transfer of ownership responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterm_location` STRING COMMENT 'Named place or port associated with the Incoterm. Specifies the geographic point where cost and risk transfer occurs (e.g., supplier factory, destination port, buyer warehouse).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract line record was most recently updated. Used for change tracking and audit trail.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to expected goods receipt. Used for Material Requirements Planning (MRP) and demand planning calculations.',
    `line_number` STRING COMMENT 'Sequential line number within the parent contract. Used for ordering and referencing specific line items in procurement documents and communications.',
    `line_status` STRING COMMENT 'Current lifecycle status of the contract line. Controls whether purchase orders can be created against this line and tracks the lines operational state.. Valid values are `active|inactive|blocked|expired|pending_approval`',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per purchase order release against this contract line. May reflect supplier capacity constraints or buyer inventory limits.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order release against this contract line. Enforces supplier-defined minimum batch sizes for economic production or logistics.',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, special instructions, or contextual information for this contract line. Used for operational guidance and exception handling.',
    `order_quantity_uom` STRING COMMENT 'Unit of measure for minimum and maximum order quantities. Defines the measurement basis for order quantity constraints.',
    `payment_terms_code` STRING COMMENT 'Code representing the agreed payment terms for this contract line (e.g., Net 30, Net 60, 2/10 Net 30). Defines the payment due date calculation and any early payment discounts.',
    `price_escalation_formula` STRING COMMENT 'Formula or reference to index-based pricing adjustment mechanism. Defines how unit price will be adjusted over time based on commodity indices, inflation, or other agreed factors.',
    `price_unit` STRING COMMENT 'Quantity of the material to which the unit price applies. For example, if price is per 100 units, this field would be 100. Used in conjunction with unit_price to calculate effective per-unit cost.',
    `price_uom` STRING COMMENT 'Unit of measure for the price unit. Defines the measurement basis for pricing (e.g., EA for each, KG for kilogram, L for liter, M for meter).',
    `purchasing_group_code` STRING COMMENT 'Code identifying the procurement team or buyer responsible for managing this contract line. Used for workload distribution and accountability tracking.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether incoming goods for this contract line must undergo quality inspection before acceptance. Enforces Good Manufacturing Practice (GMP) and quality assurance requirements.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location within the plant where the material will be received and stored. Used for warehouse management and inventory tracking.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical sourcing certification required for the material on this contract line. Supports compliance with corporate sustainability commitments and regulatory requirements. [ENUM-REF-CANDIDATE: FSC|RSPO|PEFC|Rainforest Alliance|Fair Trade|Organic|None — 7 candidates stripped; promote to reference product]',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned or target quantity of material to be procured over the contract validity period. Used for volume commitment tracking and supplier capacity planning.',
    `target_quantity_uom` STRING COMMENT 'Unit of measure for the target quantity. Defines how the target volume is measured (e.g., EA, KG, L, M).',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and tax jurisdiction for this contract line. Used for tax calculation and compliance reporting.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of measure for the material or service. This is the base price before any discounts, surcharges, or escalations are applied.',
    `validity_end_date` DATE COMMENT 'Date on which the pricing and terms on this contract line expire. Purchase orders can reference this line only on or before this date. Nullable for open-ended agreements.',
    `validity_start_date` DATE COMMENT 'Date from which the pricing and terms on this contract line become effective. Purchase orders can reference this line only on or after this date.',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Individual line items within a supplier contract specifying material, packaging component, or service being procured. Captures material/SKU reference, agreed unit price, price unit of measure, target quantity, MOQ, maximum order quantity, price validity period, price escalation formula, and contract line status. Enables granular price and volume commitment tracking at the material level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Requisitions for direct materials are triggered by demand plans in consumer goods MRP processes. Essential for demand-driven procurement, tracing requisition origin to demand signal, and validating pr',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget checking and commitment accounting: purchase requisitions reference GL accounts for budget availability checks before PO creation. The plain-text general_ledger_account on purchase_requisition ',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing plant or facility requesting the materials or services.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.planned_order. Business justification: MRP/IBP generates planned orders that convert to purchase requisitions for externally-procured materials. This standard SAP MRP-to-procurement flow requires the PR to reference its originating planned',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred or recommended supplier for this requisition, based on contracts or sourcing strategy.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Requisition‑Project Traceability links each purchase requisition to its originating R&D project.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Requisitions need profit‑center tagging for budgeting and forecast alignment; used in spend planning reports.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center that initiated the purchase requisition and will bear the expense.',
    `sku_id` BIGINT COMMENT 'Identifier of the material master record being requested, applicable for material requisitions.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Purchase requisitions should be classified by spend category to enable spend visibility and category management. The purchase_requisition table has material_group_code as a string but no structured FK',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the purchasing contract or outline agreement against which this requisition should be fulfilled.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Requisitions must be tied to the network node where the material is needed for accurate supply planning and ATP calculations.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Promotional demand-driven sourcing: requisitions for promotional materials reference the authorizing trade promotion for budget validation before PO creation. Enables end-to-end promotional spend trac',
    `approval_level` STRING COMMENT 'Current approval level in the multi-tier approval workflow (e.g., 1 for manager, 2 for director, 3 for VP).',
    `approval_workflow_reference` BIGINT COMMENT 'Identifier of the approval workflow instance governing this requisition, based on value thresholds and organizational rules.',
    `approved_date` DATE COMMENT 'Date when the purchase requisition received final approval and became eligible for purchase order creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition (quantity × estimated unit price), used for budget control and approval routing.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service, used for budgeting and approval thresholds.',
    `internal_order_number` STRING COMMENT 'Internal order number for tracking costs related to specific internal activities or campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated.',
    `material_description` STRING COMMENT 'Short text description of the material or service being requested.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials for procurement and reporting purposes (e.g., raw materials, packaging, indirect goods).',
    `material_number` STRING COMMENT 'Business identifier (SKU or material code) of the requested material.',
    `notes` STRING COMMENT 'Additional free-text notes or special instructions provided by the requester for procurement or supplier reference.',
    `priority` STRING COMMENT 'Business priority level indicating urgency of the procurement request, used for expediting and resource allocation.. Valid values are `low|normal|high|urgent`',
    `purchase_requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_ordered|fully_ordered|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `purchasing_group_code` STRING COMMENT 'Code of the purchasing group (buyer team) responsible for processing this requisition.',
    `purchasing_organization_code` STRING COMMENT 'Code of the purchasing organization responsible for procuring the requested materials or services.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material or service units requested in the purchase requisition.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver if the requisition was rejected.',
    `requested_date` DATE COMMENT 'Date when the purchase requisition was created or submitted by the requesting department.',
    `requester_email` STRING COMMENT 'Email address of the employee who created the requisition, used for notifications and approvals.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the employee who created the purchase requisition.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials or services must be delivered to meet operational or production requirements.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition, typically system-generated and externally visible to requesters and procurement teams.. Valid values are `^PR[0-9]{10}$`',
    `requisition_type` STRING COMMENT 'Classification of the purchase requisition based on procurement scenario: standard purchase, subcontracting, consignment, stock transfer, service procurement, or third-party order.. Valid values are `standard|subcontracting|consignment|stock_transfer|service|third_party`',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet is required for the requested material due to hazardous or regulated chemical content.',
    `source_of_supply` STRING COMMENT 'Recommended or assigned source for fulfilling the requisition (preferred supplier, existing contract, stock transfer, external procurement, internal production).. Valid values are `preferred_supplier|contract|stock_transfer|external|internal`',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether the requisition is for sustainably sourced materials (FSC-certified, RSPO-certified, or other sustainability standards).',
    `unit_of_measure` STRING COMMENT 'Unit in which the requested quantity is expressed (e.g., KG, L, EA, M, BOX).',
    `wbs_element` STRING COMMENT 'Project work breakdown structure element for project-related requisitions, used for project cost tracking.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requisition (PR) raised by manufacturing, R&D, marketing, or other departments requesting procurement of raw materials, packaging, or indirect goods. Captures requisition number, requesting cost center, material/service description, required quantity, unit of measure, required delivery date, estimated value, approval workflow status, and source of supply recommendation. Feeds the purchase order creation process and supports budget control and spend governance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key for the purchase order entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity procurement tracking: POs are issued by a specific company code for financial reporting, tax compliance, and payment processing. The plain-text company_code on purchase_order should be re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for PO cost allocation in financial reporting; finance tracks expenses per cost center, obvious to procurement analysts.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant, distribution center, or facility where goods will be delivered. Critical for logistics planning and inventory allocation.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Required for Production‑Order‑Purchase‑Order traceability report linking each PO to the specific production order it fulfills.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profit‑center profitability analysis of procurement spend; standard in consumer‑goods for margin reporting.',
    `purchase_requisition_id` BIGINT COMMENT 'Reference to the internal purchase requisition that triggered this purchase order. Links procurement execution to demand origination for budget tracking and approval audit.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Make‑to‑order production requires linking each sales order to its originating purchase order for planning and cost tracking.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign Procurement Tracking: PO for promotional items is linked to the specific marketing campaign driving the purchase, used in spend attribution reports.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Purchase orders should reference the spend category they belong to for spend analytics and category management reporting. The purchase_order table has material_group and purchasing_group as strings bu',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the master procurement contract or blanket agreement under which this purchase order is issued. Used for contract compliance, pricing validation, and spend aggregation.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier from whom materials or services are being procured. Links to supplier master data.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: A purchase order in consumer goods procurement is issued to a specific supplier site (manufacturing plant, warehouse, or distribution center), not just the supplier entity. Capturing supplier_site_id ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: PO execution needs the destination network node to plan inbound shipments, track OTIF, and reconcile inventory at the correct node.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Promotional materials procurement: POs for promotional packaging, displays, and promotional-specific SKUs are raised against a trade promotion for budget tracking and ROI reporting. CPG procurement te',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the purchase order received final approval and was released for transmission to the supplier. Used for procurement cycle time measurement and approval workflow audit.',
    `approved_by` STRING COMMENT 'User ID or name of the person who provided final approval for this purchase order. Used for authorization audit and segregation of duties compliance.',
    `cancellation_date` DATE COMMENT 'Date when the purchase order was cancelled before completion. Used for supplier performance analysis, demand forecast accuracy, and procurement exception tracking.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the purchase order was cancelled. Examples: demand change, supplier unable to fulfill, duplicate order, pricing dispute. Used for root cause analysis and process improvement.',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after all goods were received, invoices verified, and no further activity expected. Used for procurement lifecycle completion tracking.',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery. May differ from requested date due to supplier capacity, lead times, or material availability. Used for OTIF variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first created in the system. Used for audit trail, procurement cycle time analysis, and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this purchase order. Used for foreign exchange management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `edi_status` STRING COMMENT 'Status of EDI transmission to the supplier. Tracks whether PO was successfully sent via EDI 850, acknowledged via EDI 855, or encountered transmission errors. Critical for automated supplier integration.. Valid values are `not_sent|sent|acknowledged|rejected|error`',
    `edi_transmission_date` TIMESTAMP COMMENT 'Timestamp when the purchase order was transmitted to the supplier via EDI. Used for supplier response time tracking and transmission audit.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Transportation and logistics charges associated with this purchase order. May be supplier-charged or third-party logistics costs.',
    `goods_receipt_required` BOOLEAN COMMENT 'Indicator whether physical goods receipt posting is required for this purchase order. True for materials, false for services or non-stock items. Controls three-way match process.',
    `incoterms` STRING COMMENT 'International commercial terms defining the division of costs, risks, and responsibilities between buyer and supplier for transportation and delivery. Examples: FOB (Free On Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs. Examples: Shanghai Port, Supplier Warehouse, Buyer Plant.',
    `invoice_receipt_required` BOOLEAN COMMENT 'Indicator whether invoice verification is required before payment. Controls accounts payable workflow and three-way match completion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was last updated. Used for change tracking, audit trail, and data synchronization across systems.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total purchase order value including taxes and freight. Represents the complete financial commitment to the supplier.',
    `order_date` DATE COMMENT 'Date when the purchase order was created and issued to the supplier. Principal business event timestamp for procurement lead time calculation and supplier performance measurement.',
    `payment_terms` STRING COMMENT 'Code defining payment conditions such as net days, early payment discounts, and due date calculation. Examples: NET30, 2/10NET30, NET60. Critical for cash flow management and supplier relationship terms.. Valid values are `^[A-Z0-9]{4,10}$`',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Used for supplier communication, EDI transactions, and cross-system reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Tracks progression from creation through approval, supplier confirmation, goods receipt, and closure. Critical for procurement workflow management and OTIF tracking. [ENUM-REF-CANDIDATE: draft|submitted|approved|confirmed|in_transit|partially_received|fully_received|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement strategy. Standard for one-time orders, blanket for recurring deliveries against a master agreement, contract for long-term commitments, subcontracting for external manufacturing, consignment for supplier-owned inventory, framework for multi-release agreements.. Valid values are `standard|blanket|contract|subcontracting|consignment|framework`',
    `priority` STRING COMMENT 'Business priority level for this purchase order. Urgent for production-critical materials, high for near-term demand, normal for standard replenishment, low for non-critical items.. Valid values are `urgent|high|normal|low`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for this purchase order. Used for workload distribution, performance tracking, and supplier communication routing.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement. Used for spend analysis, contract authority, and supplier relationship ownership.. Valid values are `^[A-Z0-9]{4,10}$`',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services. Used for production planning, inventory management, and supplier commitment tracking.',
    `supplier_confirmation_date` TIMESTAMP COMMENT 'Timestamp when the supplier confirmed acceptance of the purchase order. Used for supplier responsiveness measurement and order commitment tracking.',
    `supplier_confirmation_method` STRING COMMENT 'Channel through which the supplier acknowledged the purchase order. EDI 855 for automated acknowledgment, supplier portal for web-based confirmation, email/phone/fax for manual confirmation.. Valid values are `edi_855|supplier_portal|email|phone|fax|not_confirmed`',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical sourcing certification required for materials on this purchase order. FSC for forest products, RSPO for palm oil, fair trade for ethical labor, organic for agricultural inputs. Critical for corporate sustainability reporting and regulatory compliance.. Valid values are `FSC|RSPO|fair_trade|organic|none`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order. Includes VAT, GST, sales tax, or other jurisdiction-specific taxes.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and freight. Used for budget tracking, spend analysis, and supplier performance measurement.',
    `transport_mode` STRING COMMENT 'Primary method of transportation for delivery. Used for logistics planning, lead time estimation, and freight cost allocation.. Valid values are `air|ocean|rail|truck|courier|multimodal`',
    `vmi_indicator` BOOLEAN COMMENT 'Flag indicating whether this purchase order is part of a VMI program where the supplier manages inventory levels and replenishment. True for VMI orders, false for buyer-managed procurement.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase order issued to a supplier for raw materials, packaging components, or indirect goods/services. Captures PO header (number, type, order date, supplier, delivery plant, payment terms, incoterms, total value, currency, EDI status, lifecycle status) and PO line items (material number, ordered quantity, unit price, delivery dates, batch requirements, GR/IR indicators, line status). Includes supplier order confirmations (confirmed dates, quantities, variances, confirmation method EDI 855/portal/email) and delivery schedule lines (planned/confirmed dates, quantities, transport mode, delivery status). Core transactional entity for procurement execution, three-way match, OTIF tracking, and proactive supply risk management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line product.',
    `contract_line_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_line. Business justification: PO lines are frequently created from contract lines (call-off orders against framework agreements). Adding contract_line_id enables traceability from PO line back to the governing contract line, suppo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget consumption reporting: PO lines are assigned to cost centers for budget consumption tracking and spend reporting. The plain-text cost_center on po_line should be replaced with a proper FK enabl',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each PO line posts to a GL account; required for accurate ledger posting and audit trails.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: A PO line for quality-controlled materials specifies which inspection plan governs incoming inspection. po_line has quality_inspection_required flag but no plan reference. This link enables procuremen',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Purchase orders frequently procure raw materials (ingredients, bulk chemicals, packaging components) rather than finished SKUs. Critical for manufacturing operations in consumer goods. Enables materia',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the material master record. Identifies the raw material, packaging component, or indirect good being ordered on this line.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: PO lines represent the actual spend at the line level and should be classified by spend category for granular spend analytics. po_line has material_group as a string but no structured FK. Adding spend',
    `batch_management_indicator` BOOLEAN COMMENT 'Flag indicating whether the material on this line is subject to batch management. When true, batch number must be assigned during goods receipt for traceability.',
    `confirmed_delivery_date` DATE COMMENT 'Supplier-confirmed delivery date for this line item. May differ from the requested delivery date based on supplier capacity and lead time.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line was originally created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the net price. Indicates the currency in which the supplier will be paid.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this purchase order line has been marked for deletion. When true, the line is logically deleted but retained for audit purposes.',
    `delivery_date` DATE COMMENT 'Requested or confirmed delivery date for this purchase order line. Target date by which the supplier should deliver the material to the receiving plant.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt is required for this purchase order line. When true, physical receipt must be posted before invoice can be processed.',
    `goods_received_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of material received against this purchase order line. Updated with each goods receipt posting. Used for delivery tracking and invoice matching.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms code defining the delivery terms and transfer of risk between buyer and supplier. Examples: EXW, FOB, CIF, DDP.. Valid values are `^[A-Z]{3}$`',
    `incoterm_location` STRING COMMENT 'Specific location or port associated with the Incoterm. Defines the point where responsibility and risk transfer occurs.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this line. When true, supplier invoice must be matched and verified against this PO line.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the supplier for this purchase order line. Used for three-way matching between PO, goods receipt, and invoice.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line was last updated. Tracks the most recent change to any field on the line item.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from order placement to expected delivery. Used for demand planning and inventory replenishment calculations.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and position of this line in the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line. Tracks progression from open through goods receipt to closure or cancellation.. Valid values are `open|partially_received|fully_received|closed|cancelled|blocked`',
    `manufacturer_part_number` STRING COMMENT 'Original manufacturers part number for the material. Important for quality assurance and regulatory compliance tracking.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this material. Procurement must order at least this quantity to meet supplier terms.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value of this purchase order line calculated as ordered quantity multiplied by net price. Excludes taxes and freight.',
    `net_price` DECIMAL(18,2) COMMENT 'Net unit price for the material excluding taxes and additional charges. Base price agreed with the supplier per price unit.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of material ordered on this purchase order line. Represents the total amount requested from the supplier.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received on this purchase order line. Calculated as ordered quantity minus goods received quantity.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may over-deliver beyond the ordered quantity. Used to control goods receipt tolerances.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the material will be received and consumed. Determines the receiving location for goods receipt.. Valid values are `^[A-Z0-9]{4}$`',
    `price_unit` STRING COMMENT 'Quantity unit for which the net price applies. For example, price per 100 units or per 1000 units. Used to calculate total line value.',
    `purchasing_group` STRING COMMENT 'Code identifying the procurement team or buyer responsible for this purchase order line. Used for workload distribution and performance tracking.. Valid values are `^[A-Z0-9]{3}$`',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that requested this material through a purchase requisition. Provides accountability and cost center traceability.',
    `short_text` STRING COMMENT 'Additional short text or notes specific to this purchase order line. Provides supplementary information for procurement and receiving teams.',
    `storage_location` STRING COMMENT 'Specific storage location or warehouse area within the plant where the material will be stored upon receipt. Used for inventory positioning.. Valid values are `^[A-Z0-9]{4}$`',
    `supplier_material_number` STRING COMMENT 'Suppliers own material or part number for this item. Used for cross-referencing and communication with the supplier.',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and jurisdiction for this line item. Used for invoice verification and tax reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may under-deliver below the ordered quantity. Used to control goods receipt tolerances and automatic PO closure.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity. Standard codes such as KG (kilogram), LT (liter), EA (each), MT (metric ton), CS (case).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items on a purchase order specifying the material, packaging component, or service being ordered. Captures PO line number, material number, material description, ordered quantity, unit of measure, confirmed delivery date, net price, price unit, storage location, batch management flag, goods receipt indicator, invoice receipt indicator, and line status. Enables granular tracking of delivery and invoice matching at the material level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional materials OTIF tracking: goods receipts for promotion-specific materials (displays, promotional packs) link to the promotion event to measure on-time delivery against promotion start date ',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: REQUIRED: Records the exact storage location where goods receipt is posted, enabling accurate stock updates.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Goods receipts fulfill scheduled deliveries. Adding delivery_schedule_id to goods_receipt enables traceability from receipt back to the scheduled delivery line, supports delivery performance measureme',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods were received. Enables line-level tracking and three-way match.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Materials‑to‑Project Log records receipt of goods against the specific R&D project they support.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: In make-to-order consumer goods, goods receipts for raw materials are triggered by specific production orders. Direct FK enables production cost settlement, GMP lot genealogy, and batch traceability r',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods were received. Links this goods receipt to the originating procurement document.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Goods receipts fulfill planned replenishment orders. Critical for closing the supply planning loop, updating supply plan actuals, confirming planned receipts, and enabling replenishment order closure ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Receiving teams verify the SDS against the received goods; the receipt records the SDS ID instead of a simple flag.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the goods. Used for supplier performance scorecards and VMI reconciliation.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Goods are physically received FROM a specific supplier site. Linking goods_receipt to supplier_site enables site-level OTIF compliance tracking, quality inspection correlation with site audit scores, ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Inbound logistics requires linking each goods receipt to the warehouse node for accurate inventory updates and OTIF reporting.',
    `batch_number` STRING COMMENT 'The supplier-provided or internally-assigned batch or lot number for traceability. Critical for quality management, recalls, and FEFO inventory management.. Valid values are `^[A-Z0-9]{10}$`',
    `carrier_name` STRING COMMENT 'The name of the transportation carrier or logistics provider who delivered the goods. Used for carrier performance analysis.',
    `certificate_of_analysis_received_flag` BOOLEAN COMMENT 'Indicates whether the supplier-provided Certificate of Analysis was received with the shipment. Required for GMP compliance and quality assurance.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was first created in the database. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the valuation amount is expressed. Typically the company code currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The supplier-provided delivery note or packing slip number accompanying the shipment. Used for cross-referencing and dispute resolution.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `document_date` DATE COMMENT 'The date printed on the supplier delivery note or packing slip. May differ from posting date due to processing delays.',
    `expiry_date` DATE COMMENT 'The date by which the received material must be consumed or disposed of. Used for FEFO (First Expired First Out) inventory rotation and shelf-life management.',
    `gr_document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction. Used for audit trails, supplier communication, and three-way match processing.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed (cancelled). True means the inventory posting has been negated due to return-to-vendor or data correction.',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt. Indicates whether the receipt is active, has been reversed, or is awaiting quality inspection clearance.. Valid values are `posted|reversed|cancelled|pending_inspection|blocked`',
    `inspection_lot_number` STRING COMMENT 'The unique identifier for the quality inspection lot created for this goods receipt. Links to QM inspection results and certificate of analysis.. Valid values are `^[A-Z0-9]{12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was last updated. Used for change tracking and audit trails.',
    `manufacturing_date` DATE COMMENT 'The date on which the material was produced by the supplier. Used for shelf-life calculation and quality assurance.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the nature of the goods receipt transaction (e.g., 101 for GR against PO, 122 for return delivery). Determines inventory and financial posting logic.. Valid values are `^[0-9]{3}$`',
    `otif_compliance_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt met the On Time In Full criteria (received on or before requested date with full ordered quantity). Used for supplier performance scorecards.',
    `posting_date` DATE COMMENT 'The business date on which the goods receipt was posted to inventory. This is the principal business event timestamp for inventory valuation and OTIF measurement.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released for use. True triggers QM workflow and blocks stock until clearance.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The physical quantity of goods received and accepted into inventory. This is the principal quantitative fact for this transaction.',
    `receiving_plant_code` STRING COMMENT 'The manufacturing plant or distribution center where the goods were physically received. Aligns with organizational hierarchy and inventory segmentation.. Valid values are `^[A-Z0-9]{4}$`',
    `remarks` STRING COMMENT 'Free-text field for capturing additional notes, exceptions, or special handling instructions related to this goods receipt. Used for operational communication and audit context.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversing goods receipt transaction, if this receipt was cancelled. Links to the offsetting inventory movement.. Valid values are `^[A-Z0-9]{10}$`',
    `reversal_reason_code` STRING COMMENT 'The business reason why this goods receipt was reversed. Used for root cause analysis and process improvement.. Valid values are `quality_reject|quantity_discrepancy|damaged|wrong_material|duplicate_posting|administrative_error`',
    `storage_location_code` STRING COMMENT 'The specific storage location or warehouse zone within the receiving plant where goods were placed. Used for inventory positioning and picking optimization.. Valid values are `^[A-Z0-9]{4}$`',
    `sustainable_sourcing_certification` STRING COMMENT 'The sustainability certification standard under which the received material was sourced (e.g., FSC for paper/packaging, RSPO for palm oil). Supports ESG reporting and sustainable sourcing initiatives.. Valid values are `FSC|RSPO|none`',
    `unit_of_measure` STRING COMMENT 'The unit in which the received quantity is expressed (e.g., KG for kilograms, EA for each, L for liters). Must align with material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'The per-unit price used for inventory valuation at the time of goods receipt. May be standard cost, moving average price, or PO price depending on valuation method.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total inventory value of the received goods in the company currency, calculated as received quantity multiplied by standard or moving average price. Used for financial posting and COGS calculation.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Goods receipt (GR) event recorded when raw materials, packaging, or indirect goods are physically received at a plant or distribution center against a purchase order. Captures GR document number, posting date, receiving plant, storage location, received quantity per line, unit of measure, batch number, FEFO expiry date, quality inspection flag, movement type, and GR status. Triggers inventory update and three-way match process. Supports GR reversal and return-to-vendor scenarios.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: AP processing and tax reporting: supplier invoices are posted to a specific company code for financial close, VAT reporting, and intercompany reconciliation. The plain-text company_code on supplier_in',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoices are allocated to cost centers for expense tracking; required by internal budgeting controls.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices must map to a GL account for posting; essential for financial consolidation.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Supplier invoices cover material purchases (ingredients, packaging components, bulk chemicals) in addition to finished goods. Required for accurate material cost accounting, standard cost updates, and',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center allocation of supplier invoices supports profitability analysis of purchased goods.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice was issued.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Invoices for regulated chemicals must reference the SDS to support audit trails and tax compliance.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Supplier invoices for contract-based procurement should reference the governing supplier contract for contract compliance verification, rebate calculation, and payment terms validation. Adding supplie',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who issued this invoice.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier invoices in consumer goods procurement are often issued from a specific supplier site (particularly for multi-site suppliers with separate billing entities per site). Linking supplier_invoice',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the invoice for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was approved for payment.',
    `baseline_date` DATE COMMENT 'The baseline date used for calculating payment due date and cash discount periods.',
    `blocking_reason_code` STRING COMMENT 'Code indicating why the invoice is blocked from payment, if applicable. Empty if not blocked.',
    `blocking_reason_description` STRING COMMENT 'Detailed description of the reason the invoice is blocked from payment.',
    `cash_discount_days` STRING COMMENT 'The number of days within which payment must be made to qualify for the cash discount.',
    `cash_discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount available for early payment per payment terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted.',
    `goods_receipt_date` DATE COMMENT 'The date goods were received or services were confirmed, used for three-way match validation.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and adjustments.',
    `invoice_date` DATE COMMENT 'The date the supplier issued the invoice. This is the principal business event timestamp for the invoice.',
    `invoice_description` STRING COMMENT 'Free-text description or notes about the invoice provided by the supplier or entered during processing.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the supplier. This is the externally-known identifier for the invoice.',
    `invoice_receipt_date` DATE COMMENT 'The date the invoice was received by the organization.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|paid|blocked|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice type indicating the nature of the transaction.. Valid values are `standard|credit_memo|debit_memo|prepayment|final|proforma`',
    `line_item_count` STRING COMMENT 'Total number of line items included in this invoice.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the invoice record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount payable after taxes and discounts. This is the final amount due to the supplier.',
    `payment_date` DATE COMMENT 'The actual date payment was made to the supplier.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the supplier per payment terms.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the supplier.. Valid values are `wire_transfer|ach|check|credit_card|edi|other`',
    `payment_reference_number` STRING COMMENT 'Reference number assigned when payment is made, linking the invoice to the payment transaction.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the supplier (e.g., Net 30, Net 60, 2/10 Net 30).',
    `plant_code` STRING COMMENT 'The plant or facility code where goods were received or services were rendered.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial accounting system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match validation comparing purchase order, goods receipt, and invoice at header level.. Valid values are `matched|variance_within_tolerance|variance_exceeds_tolerance|not_matched|bypassed`',
    `tolerance_check_result` STRING COMMENT 'Indicates whether the invoice passed tolerance checks for price and quantity variances.. Valid values are `passed|failed|not_applicable`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment per regulatory requirements.',
    `withholding_tax_code` STRING COMMENT 'Code representing the withholding tax type and rate applied.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the invoice record in the system.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier invoice received for goods or services delivered against a purchase order. Captures invoice header (supplier-assigned number, invoice date, posting date, gross amount, tax amount, currency, payment due date, three-way match status, tolerance check result, blocking reason, processing status) and invoice line items (referenced PO line, material/service description, invoiced quantity, unit price, line amount, tax code, line-level match status). Supports granular three-way match (PO vs GR vs invoice) at both header and line level. Feeds accounts payable and COGS allocation. Owns all line-level detail as embedded attributes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Primary key for invoice_line',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Granular spend tracking: invoice lines are assigned to cost centers for line-level budget consumption and spend reporting. The plain-text cost_center_code on invoice_line should be replaced with a pro',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial posting accuracy: invoice lines post to specific GL accounts for financial reporting and audit. The plain-text gl_account_code on invoice_line should be replaced with a proper FK ensuring re',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt line that this invoice line matches against. Enables three-way match verification between PO, GR, and invoice.',
    `material_id` BIGINT COMMENT 'Reference to the material master record for the invoiced item. Links to the product or raw material being purchased.',
    `po_line_id` BIGINT COMMENT 'Reference to the purchase order line that this invoice line corresponds to. Critical for three-way match validation (PO vs GR vs Invoice).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting: invoice lines need profit center assignment for P&L reporting by product line or brand segment. The plain-text profit_center_code on invoice_line should be replaced with a pro',
    `purchase_order_id` BIGINT COMMENT 'Reference to the service entry sheet line for service-based invoices. Used when the invoice line corresponds to a service rather than a material.',
    `supplier_invoice_id` BIGINT COMMENT 'Reference to the parent supplier invoice header. Links this line item to the overall invoice document.',
    `amount_variance` DECIMAL(18,2) COMMENT 'Total amount variance for this line calculated as the difference between invoiced amount and expected amount based on PO and GR.',
    `batch_number` STRING COMMENT 'Batch or lot number for the material on this invoice line. Critical for quality traceability, recall management, and FEFO inventory management.',
    `blocking_reason` STRING COMMENT 'Reason code or description explaining why this invoice line is blocked from payment. Common reasons include price variance, quantity variance, or missing goods receipt.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code indicating where the material was manufactured or produced. Required for customs, trade compliance, and sustainable sourcing reporting. [ENUM-REF-CANDIDATE: USA|CHN|DEU|IND|BRA|MEX|CAN|GBR|FRA|ITA|JPN|KOR|THA|VNM|POL|ESP — 16 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice line. Must match the invoice header currency. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|CAD|AUD|BRL|MXN — 10 candidates stripped; promote to reference product]',
    `delivery_note_number` STRING COMMENT 'Supplier delivery note or packing slip number referenced on this invoice line. Used for traceability and dispute resolution.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute discount amount applied to this invoice line. Alternative to or in addition to discount_percentage.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Line-level discount percentage applied by the supplier. Reduces the net amount before tax calculation.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for the material batch. Essential for FEFO inventory rotation and regulatory compliance in consumer goods.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units invoiced on this line. Used for three-way match comparison against PO quantity and GR quantity.',
    `line_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount for this invoice line including taxes and charges. Sum of line_net_amount and line_tax_amount.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net amount for this invoice line before taxes and charges. Typically calculated as invoiced_quantity multiplied by unit_price, adjusted for any line-level discounts.',
    `line_number` STRING COMMENT 'Sequential line item number within the invoice. Determines the ordering and position of this line in the invoice document.',
    `line_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this invoice line. Calculated based on the tax code and net amount.',
    `line_text` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this invoice line. May include supplier remarks or internal annotations.',
    `match_status` STRING COMMENT 'Three-way match status for this invoice line. Indicates whether the line matches the PO and GR within acceptable tolerance thresholds.. Valid values are `matched|quantity_variance|price_variance|unmatched|blocked|approved`',
    `material_description` STRING COMMENT 'Textual description of the material or service as it appears on the invoice line. May differ from master data description if supplier uses alternate naming.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Tracks changes for audit trail and data quality monitoring.',
    `payment_terms_code` STRING COMMENT 'Payment terms applicable to this invoice line if different from header-level terms. Defines due date calculation and early payment discount eligibility.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code where the material is received or consumed. Links procurement to manufacturing and supply chain operations.',
    `price_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced unit price and PO unit price. Used to identify pricing discrepancies and trigger approval workflows.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced quantity and goods receipt quantity. Positive values indicate over-invoicing; negative values indicate under-invoicing.',
    `sds_document_number` STRING COMMENT 'Reference number for the Safety Data Sheet associated with this material. Required for hazardous materials and chemical ingredients per OSHA and REACH regulations.',
    `storage_location_code` STRING COMMENT 'Specific storage location within the plant where the material is stored. Provides granular inventory tracking.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical sourcing certification applicable to this material. Examples include FSC for paper/packaging, RSPO for palm oil, or organic certifications.. Valid values are `FSC|RSPO|FAIRTRADE|ORGANIC|RAINFOREST_ALLIANCE|NONE`',
    `tax_code` STRING COMMENT 'Tax jurisdiction and rate code applied to this invoice line. Determines the tax calculation method and rate percentage.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to this line. Derived from the tax code configuration.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity. Must match the UOM on the corresponding PO line and goods receipt for proper three-way match. [ENUM-REF-CANDIDATE: EA|KG|LB|L|GAL|M|FT|BOX|CASE|PALLET|EACH|TON|MT — 13 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure as stated on the invoice line. Compared against PO unit price during invoice verification to identify price variances.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from this invoice line payment. Reduces the net payment to the supplier.',
    `withholding_tax_code` STRING COMMENT 'Withholding tax code for this invoice line. Applicable in jurisdictions requiring tax withholding at source for certain supplier payments.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on a supplier invoice corresponding to specific PO lines or service entry sheets. Captures invoice line number, referenced PO line, material/service description, invoiced quantity, unit price, line amount, tax code, and line-level match status. Enables granular three-way match (PO line vs GR line vs invoice line) and supports COGS allocation at the material level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'Primary key for spend_category',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget control and spend reporting: spend categories are mapped to default cost centers for budget allocation and spend visibility in consumer goods procurement. This drives automatic cost center assi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Automatic account determination: spend categories map to GL accounts for correct financial posting when POs are created (standard procurement-finance integration). Consumer goods companies require thi',
    `parent_category_spend_category_id` BIGINT COMMENT 'Reference to the parent spend category in the hierarchical taxonomy. Null for top-level (L1) categories.',
    `annual_spend_budget_amount` DECIMAL(18,2) COMMENT 'Planned annual procurement spend budget for this category in base currency (USD). Used for budget tracking and variance analysis.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the spend category in procurement systems. Used as the business identifier for category classification and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the spend category scope, including materials, services, and goods covered under this classification.',
    `category_level` STRING COMMENT 'Hierarchical level of the category in the spend taxonomy (L1=top level, L2=sub-category, L3=detailed category, L4=granular classification).. Valid values are `L1|L2|L3|L4`',
    `category_name` STRING COMMENT 'Full descriptive name of the spend category (e.g., Surfactants, Primary Packaging, MRO Supplies).',
    `category_status` STRING COMMENT 'Current lifecycle status of the spend category in the procurement taxonomy (active=in use, inactive=deprecated, under_review=being evaluated, consolidating=merging with other categories, phasing_out=being eliminated).. Valid values are `active|inactive|under_review|consolidating|phasing_out`',
    `commodity_type` STRING COMMENT 'High-level classification of the commodity type covered by this category (raw materials, packaging, maintenance/repair/operations, capital expenditure, indirect services, logistics, professional services). [ENUM-REF-CANDIDATE: raw_material|packaging|mro|capex|indirect_service|logistics|professional_service — 7 candidates stripped; promote to reference product]',
    `contract_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of category spend covered by formal contracts or pricing agreements (0-100). Higher coverage indicates better spend management.',
    `cost_savings_target_percentage` DECIMAL(18,2) COMMENT 'Annual cost reduction target for this category as a percentage of baseline spend. Used for procurement performance management.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this category record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend category record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for spend budget and reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this category classification is no longer effective. Null for currently active categories.',
    `effective_start_date` DATE COMMENT 'Date when this category classification became effective in the procurement taxonomy.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this category record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend category record was last updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent category strategy review and performance assessment.',
    `lead_time_days_typical` STRING COMMENT 'Average procurement lead time in days for materials in this category from purchase order to goods receipt.',
    `material_group` STRING COMMENT 'Material group classification from ERP system (SAP MM material group) for raw materials and packaging components.',
    `moq_applicable_flag` BOOLEAN COMMENT 'Indicates whether minimum order quantity constraints typically apply to materials in this category.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next category strategy review and supplier performance evaluation.',
    `preferred_sourcing_strategy` STRING COMMENT 'Recommended sourcing approach for this category (single source, dual source, multi-source, spot buy, strategic partnership, vendor managed inventory, consignment). [ENUM-REF-CANDIDATE: single_source|dual_source|multi_source|spot_buy|strategic_partnership|vmi|consignment — 7 candidates stripped; promote to reference product]',
    `procurement_organization` STRING COMMENT 'Procurement organizational unit responsible for managing this category (e.g., Global Procurement, Regional Procurement EMEA, Direct Materials Procurement).',
    `purchasing_group` STRING COMMENT 'Three-character purchasing group code from ERP system responsible for operational procurement activities in this category.. Valid values are `^[A-Z0-9]{3}$`',
    `regulatory_framework` STRING COMMENT 'Comma-separated list of applicable regulatory frameworks governing materials in this category (e.g., REACH, FDA CFR 21, RSPO, FSC, ISO 22716). [ENUM-REF-CANDIDATE: REACH|FDA|RSPO|FSC|ISO_22716|GMP|IFRA|EPA|CPSC — promote to reference product]',
    `risk_profile` STRING COMMENT 'Supply risk assessment for this category considering supplier concentration, market volatility, geopolitical factors, and regulatory complexity.. Valid values are `high_risk|medium_risk|low_risk`',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether materials in this category require Safety Data Sheet documentation for regulatory compliance and workplace safety.',
    `spend_visibility_level` STRING COMMENT 'Classification of spend data visibility and tracking maturity for this category (high=fully tracked and managed, medium=partially tracked, low=limited visibility).. Valid values are `high|medium|low`',
    `strategic_importance` STRING COMMENT 'Business criticality classification of this category to operations and product quality (critical=business-critical materials, strategic=high-value/high-risk, tactical=moderate importance, non-critical=low impact).. Valid values are `critical|strategic|tactical|non_critical`',
    `supplier_consolidation_target` STRING COMMENT 'Target number of preferred suppliers for this category as part of supplier rationalization strategy.',
    `sustainable_sourcing_flag` BOOLEAN COMMENT 'Indicates whether this category is subject to sustainable sourcing requirements (e.g., FSC-certified paper, RSPO-certified palm oil, conflict-free minerals).',
    `unspsc_code` STRING COMMENT 'Eight-digit UNSPSC code for global commodity classification alignment and cross-industry spend benchmarking.. Valid values are `^[0-9]{8}$`',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Hierarchical classification taxonomy for procurement spend categories covering raw materials (oils, surfactants, fragrances, actives, excipients), primary and secondary packaging, MRO, capex, and indirect services. Captures category code, category name, parent category, category level (L1/L2/L3/L4), commodity type, applicable regulatory frameworks (REACH, FDA, RSPO), preferred sourcing strategy, and category owner. Enables spend analytics, category management, and compliance reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` (
    `approved_supplier_list_id` BIGINT COMMENT 'Unique identifier for the approved supplier list entry. Primary key for the ASL record.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: The ASL entry for a supplier-material combination must reference the required inspection plan governing incoming quality checks. Procurement uses this to communicate quality requirements at supplier o',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: ASL must qualify suppliers at material level (ingredients, packaging components, chemicals) not just finished SKUs. Essential for regulatory compliance (GMP, FDA, REACH), quality assurance, and suppli',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Project‑Specific Approved Supplier List ensures only vetted suppliers are used for a given R&D project.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: The quality basis for supplier approval on the ASL is the applicable material specification. Linking ASL to specification enables automatic re-evaluation triggers when a specification is revised, and ',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Approved Supplier List entries define which suppliers are authorized for specific spend categories. The ASL currently has sku_id and supplier_id but no spend_category_id, limiting category-level ASL m',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the master purchasing contract or framework agreement governing this supplier-material relationship. Links to contract management system.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier authorized to supply materials or services. Links to the supplier master record.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: ASL entries in consumer goods procurement are frequently site-specific — a suppliers particular manufacturing or warehouse site is approved for a given material or category, not just the supplier ent',
    `approval_authority` STRING COMMENT 'Name or role of the person or committee who authorized the supplier approval. Provides accountability and audit trail.',
    `approval_basis` STRING COMMENT 'Method or evidence used to grant supplier approval. Audit = on-site supplier audit; Certification = third-party certification (ISO, FSC, RSPO); Qualification test = material sample testing; Performance review = historical performance analysis; Risk assessment = supply chain risk evaluation; Legacy approval = pre-existing authorization.. Valid values are `audit|certification|qualification_test|performance_review|risk_assessment|legacy_approval`',
    `approval_date` DATE COMMENT 'Date when the supplier was approved for this material-plant combination. Represents the effective start of authorization.',
    `approval_expiration_date` DATE COMMENT 'Date when the current approval expires and requires re-evaluation. Null indicates indefinite approval subject to periodic review.',
    `approval_status` STRING COMMENT 'Current authorization status of the supplier for this material-plant combination. Approved = full authorization; Conditional = approved with restrictions; Blocked = temporarily prohibited; Delisted = permanently removed; Pending = under evaluation; Suspended = on hold pending review.. Valid values are `approved|conditional|blocked|delisted|pending|suspended`',
    `blocking_date` DATE COMMENT 'Date when the supplier was blocked, delisted, or suspended. Null when status is approved, conditional, or pending.',
    `blocking_reason` STRING COMMENT 'Explanation for why the supplier is blocked, delisted, or suspended. Includes quality issues, compliance violations, delivery failures, financial instability, or ethical concerns. Null when status is approved or conditional.',
    `compliance_status` STRING COMMENT 'Regulatory and policy compliance status for this supplier-material combination. Compliant = meets all requirements; Non-compliant = violations identified; Under review = compliance assessment in progress; Exempted = waiver granted.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `conditional_terms` STRING COMMENT 'Specific restrictions or requirements when approval status is conditional. Examples: reduced order quantities, enhanced inspection, expedited payment terms, or geographic limitations. Null when status is not conditional.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ASL entry was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delivery_rating` STRING COMMENT 'Supplier delivery performance rating for this material-plant combination. A = excellent (>95% OTIF); B = good (90-95% OTIF); C = acceptable (85-90% OTIF); D = marginal (80-85% OTIF); F = failing (<80% OTIF).. Valid values are `A|B|C|D|F`',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether electronic purchase orders and confirmations are enabled for this supplier-material-plant combination. True = EDI transactions supported; False = manual processing.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming goods from this supplier-material combination require quality inspection before goods receipt posting. True = inspection mandatory; False = direct posting allowed.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit or site visit for this material-plant combination. Used to track audit currency and schedule follow-ups.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated this ASL entry. Tracks change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ASL entry was last modified. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from PO issuance to goods receipt for this supplier-material-plant combination. Used for MRP and demand planning.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this material-plant combination. Used to enforce purchasing constraints in PO creation.',
    `moq_unit` STRING COMMENT 'Unit of measure for the minimum order quantity. Examples: KG (kilograms), EA (each), LT (liters), MT (metric tons). Follows ISO 80000 or UN/CEFACT standards.. Valid values are `^[A-Z]{2,3}$`',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next supplier audit or site visit. Drives proactive supplier quality management.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the supplier approval, special handling instructions, historical issues, or other relevant information for procurement and quality teams.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution facility code where the supplier is authorized to deliver. Follows GS1 GLN or internal plant coding standard.. Valid values are `^[A-Z0-9]{4,10}$`',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred source for this material-plant combination. True = preferred supplier with priority allocation; False = approved but not preferred.',
    `price_validity_end_date` DATE COMMENT 'End date of the current pricing agreement. Null indicates open-ended pricing subject to change notification.',
    `price_validity_start_date` DATE COMMENT 'Start date of the current pricing agreement for this supplier-material-plant combination. Used to enforce valid pricing periods in PO creation.',
    `quality_rating` STRING COMMENT 'Supplier quality performance rating for this material-plant combination. A = excellent (>98% acceptance); B = good (95-98%); C = acceptable (90-95%); D = marginal (85-90%); F = failing (<85%). Derived from quality inspection results.. Valid values are `A|B|C|D|F`',
    `re_evaluation_due_date` DATE COMMENT 'Scheduled date for the next supplier performance review or qualification audit. Drives proactive supplier management activities.',
    `risk_category` STRING COMMENT 'Supply chain risk classification for this supplier-material-plant combination. Low = stable supply, multiple sources; Medium = moderate dependency; High = single source or volatile region; Critical = business-critical material with supply constraints.. Valid values are `low|medium|high|critical`',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the only approved source for this material-plant combination. True = sole source (supply risk); False = multiple sources available.',
    `sustainability_certification` STRING COMMENT 'Sustainability certifications held by the supplier for this material. Pipe-separated list of certifications: FSC (Forest Stewardship Council), RSPO (Roundtable on Sustainable Palm Oil), Fair Trade, Rainforest Alliance, B Corp, Carbon Neutral. Supports sustainable sourcing initiatives.',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether this supplier-material-plant combination is eligible for Vendor Managed Inventory programs. True = VMI enabled; False = traditional procurement.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this ASL entry. Provides accountability and audit trail.',
    CONSTRAINT pk_approved_supplier_list PRIMARY KEY(`approved_supplier_list_id`)
) COMMENT 'Approved Supplier List (ASL) entry defining which suppliers are authorized to supply specific materials or spend categories to specific plants. Captures material/category, supplier, plant, approval status (approved/conditional/blocked/delisted), approval date, re-evaluation due date, approval basis (audit/certification/qualification test), and blocking reason. Enforces sourcing compliance and prevents unauthorized supplier usage in PO creation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_parent_category_spend_category_id` FOREIGN KEY (`parent_category_spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `fsc_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `iso_9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|documentation_review|compliance_check|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|edi_payment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `rspo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging|indirect_goods|contract_manufacturer|service_provider|logistics_provider');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `fsc_certified` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `gmp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `iso_22716_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 22716 Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `preferred_site_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Site Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_capacity` SET TAGS ('dbx_business_glossary_term' = 'Site Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|decommissioned');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing|warehouse|office|port|distribution_center|r_and_d');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `vmi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'framework_agreement|blanket_order|spot_purchase|long_term_agreement|consignment|vendor_managed_inventory');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Formula');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'fixed_price|cost_plus|market_indexed|volume_tiered|rebate_based');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UoM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `rebate_terms` SET TAGS ('dbx_business_glossary_term' = 'Rebate Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `target_quantity_total` SET TAGS ('dbx_business_glossary_term' = 'Total Target Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_invoiced_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Invoiced Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `incoterm_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|expired|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `order_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Formula');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `target_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Requested Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transfer|service|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'preferred_supplier|contract|stock_transfer|external|internal');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `edi_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `edi_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|rejected|error');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `edi_transmission_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Required');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Required');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|subcontracting|consignment|framework');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Confirmation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Supplier Confirmation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_confirmation_method` SET TAGS ('dbx_value_regex' = 'edi_855|supplier_portal|email|phone|fax|not_confirmed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|fair_trade|organic|none');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|rail|truck|courier|multimodal');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `vmi_indicator` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `batch_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `goods_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `incoterm_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_analysis_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_inspection|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `otif_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'quality_reject|quantity_discrepancy|damaged|wrong_material|duplicate_posting|administrative_error');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `sustainable_sourcing_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Sourcing Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `sustainable_sourcing_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|none');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'invoice_reconciliation');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `blocking_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Blocking Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `blocking_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Blocking Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cash_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cash_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Processing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|final|proforma');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|edi|other');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance_within_tolerance|variance_exceeds_tolerance|not_matched|bypassed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_result` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Check Result');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_reconciliation');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `amount_variance` SET TAGS ('dbx_business_glossary_term' = 'Amount Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Text');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|unmatched|blocked|approved');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|FAIRTRADE|ORGANIC|RAINFOREST_ALLIANCE|NONE');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_subdomain' = 'invoice_reconciliation');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `parent_category_spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `annual_spend_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `annual_spend_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|L4');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|consolidating|phasing_out');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `contract_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `cost_savings_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `cost_savings_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `lead_time_days_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `moq_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Applicable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sourcing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `procurement_organization` SET TAGS ('dbx_business_glossary_term' = 'Procurement Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Spend Visibility Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_visibility_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'critical|strategic|tactical|non_critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `supplier_consolidation_target` SET TAGS ('dbx_business_glossary_term' = 'Supplier Consolidation Target');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `sustainable_sourcing_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Sourcing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List (ASL) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_basis` SET TAGS ('dbx_business_glossary_term' = 'Approval Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_basis` SET TAGS ('dbx_value_regex' = 'audit|certification|qualification_test|performance_review|risk_assessment|legacy_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|blocked|delisted|pending|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `blocking_date` SET TAGS ('dbx_business_glossary_term' = 'Blocking Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_business_glossary_term' = 'Conditional Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `delivery_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `delivery_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `re_evaluation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re-evaluation Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
