-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`procurement` COMMENT 'Owns sourcing, supplier management, and purchase order execution for raw materials, packaging, and indirect goods. Manages supplier master data, contracts, RFQs, purchase requisitions, PO lifecycle, goods receipt, invoice verification, MOQ terms, SDS documentation, supplier performance scorecards, VMI programs, and sustainable sourcing initiatives (FSC, RSPO).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record. Primary key for the supplier entity.',
    `spend_category_id` BIGINT COMMENT 'The spend category id of the supplier record',
    `address_line1` STRING COMMENT 'Primary street address line for the suppliers registered business location or headquarters.',
    `address_line2` STRING COMMENT 'Secondary address line for additional location details such as suite, building, or floor number.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supplier record',
    `approval_status` STRING COMMENT 'The approval status of the supplier record',
    `city` STRING COMMENT 'City or municipality name where the suppliers business location is registered.',
    `supplier_code` STRING COMMENT 'Internal business identifier or code assigned to the supplier for procurement and ERP system reference.',
    `contract_expiration_date` DATE COMMENT 'Date when the current master supply agreement or contract with the supplier expires and requires renewal or renegotiation.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the supplier is legally registered and operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code indicating the preferred currency for transactions and invoicing with this supplier.. Valid values are `^[A-Z]{3}$`',
    `supplier_description` STRING COMMENT 'The supplier description of the supplier record',
    `diversity_classification` STRING COMMENT 'Classification indicating if the supplier qualifies as a diverse supplier (e.g., minority-owned, women-owned, veteran-owned, small business).',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify the supplier business entity globally.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier has EDI capability for automated exchange of purchase orders, invoices, and shipping notices.',
    `edi_identifier` STRING COMMENT 'Unique EDI identifier or interchange ID used for electronic document exchange with the supplier.',
    `effective_from` DATE COMMENT 'The effective from of the supplier record',
    `effective_until` DATE COMMENT 'The effective until of the supplier record',
    `fsc_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds FSC certification for sustainable forestry and paper-based materials sourcing.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the suppliers legal entity or physical location within the supply chain.. Valid values are `^[0-9]{13}$`',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier is certified for Good Manufacturing Practices, critical for consumer goods quality and safety compliance.',
    `incoterms` STRING COMMENT 'Standard Incoterms code defining the responsibilities, costs, and risks between buyer and supplier for international shipments. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_approved` BOOLEAN COMMENT 'The is approved of the supplier record',
    `is_strategic` BOOLEAN COMMENT 'The is strategic of the supplier record',
    `iso_9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier maintains ISO 9001 quality management system certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit or assessment conducted for quality, compliance, or sustainability verification.',
    `lead_time_days` STRING COMMENT 'Standard number of days required from purchase order placement to goods receipt for this supplier.',
    `legal_name` STRING COMMENT 'The legal name of the supplier record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was last modified or updated in the system.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for purchase orders to be accepted.',
    `moq_unit` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., EA, KG, LB, L, cases, pallets).',
    `supplier_name` STRING COMMENT 'The full legal name of the supplier or vendor organization as registered with governing authorities.',
    `notes` STRING COMMENT 'The notes of the supplier record',
    `onboarding_date` DATE COMMENT 'Date when the supplier was officially onboarded and approved for procurement activities.',
    `onboarding_status` STRING COMMENT 'Current stage of the supplier onboarding process tracking progress from initial registration through final approval.. Valid values are `not_started|in_progress|documentation_review|compliance_check|approved|rejected`',
    `payment_method` STRING COMMENT 'Preferred method of payment for settling invoices with the supplier.. Valid values are `wire_transfer|ach|check|credit_card|edi_payment`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier defining the payment schedule and conditions (e.g., Net 30, Net 60, 2/10 Net 30).',
    `performance_score` DECIMAL(18,2) COMMENT 'Overall performance score for the supplier based on quality, delivery, cost, and service metrics, typically on a 0-100 scale.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the suppliers business address used for mail delivery and logistics coordination.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary supplier contact used for procurement communications and order coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the supplier organization responsible for account management.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary supplier contact for urgent procurement matters and order inquiries.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supplier record',
    `risk_rating` STRING COMMENT 'Risk assessment classification for the supplier based on financial stability, geopolitical factors, compliance history, and supply continuity.. Valid values are `low|medium|high|critical`',
    `rspo_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds RSPO certification for sustainable palm oil sourcing practices.',
    `source_system_code` STRING COMMENT 'The source system code of the supplier record',
    `state_province` STRING COMMENT 'State, province, or regional administrative division for the suppliers business address.',
    `supplier_number` STRING COMMENT 'The supplier number of the supplier record',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier relationship indicating whether the supplier is eligible for procurement activities.. Valid values are `active|inactive|pending_approval|suspended|terminated`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on the category of goods or services provided to the business.. Valid values are `raw_material|packaging|indirect_goods|contract_manufacturer|service_provider|logistics_provider`',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number for the supplier (e.g., EIN in USA, VAT number in EU) used for tax reporting and compliance.',
    `tax_number` STRING COMMENT 'The tax number of the supplier record',
    `tier` STRING COMMENT 'Strategic classification of the supplier indicating their relationship status and procurement priority level with the organization.. Valid values are `strategic|preferred|approved|conditional|blocked`',
    `uom` STRING COMMENT 'The uom of the supplier record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supplier record',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether the supplier is eligible and capable of participating in Vendor Managed Inventory programs.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all suppliers, vendors, and contract manufacturers providing raw materials, packaging, and indirect goods. Captures supplier legal entity details, GS1/DUNS identifiers, tax registration, payment terms, MOQ terms, lead times, incoterms, preferred currency, supplier tier classification (strategic/preferred/approved/conditional), VMI eligibility flag, EDI capability, sustainability certifications (FSC, RSPO), and onboarding status. SSOT for supplier identity across the procurement domain.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` (
    `supplier_site_id` BIGINT COMMENT 'Unique identifier for the supplier site. Primary key for this entity.',
    `jurisdiction_id` BIGINT COMMENT 'add column address_country_jurisdiction_id (BIGINT) with FK to regulatory.jurisdiction.jurisdiction_id - supplier sites need jurisdiction for trade compliance',
    `supplier_id` BIGINT COMMENT 'Reference to the parent supplier organization that owns or operates this site.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: VMI programs map each supplier site to a specific distribution node to manage inventory ownership and replenishment.',
    `address_line1` STRING COMMENT 'The address line1 of the supplier site record',
    `address_line_1` STRING COMMENT 'Primary street address line for the supplier site location.',
    `address_line_2` STRING COMMENT 'Secondary address line for building, suite, or unit information.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supplier site record',
    `audit_score` DECIMAL(18,2) COMMENT 'Most recent audit score for this site, typically on a 0-100 scale, reflecting compliance and quality performance.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the site capacity metric (e.g., units_per_month, pallets, square_meters, kilograms_per_day).',
    `certification_expiry_date` DATE COMMENT 'Date when the primary site certifications expire and require renewal. Used for compliance monitoring and supplier audit scheduling.',
    `city` STRING COMMENT 'City or municipality where the supplier site is located.',
    `supplier_site_code` STRING COMMENT 'The supplier site code of the supplier site record',
    `contact_email` STRING COMMENT 'The contact email of the supplier site record',
    `contact_name` STRING COMMENT 'The contact name of the supplier site record',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country where the site is located. Critical for country of origin tracking and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier site record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the supplier site record',
    `supplier_site_description` STRING COMMENT 'The supplier site description of the supplier site record',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether this site is capable of exchanging purchase orders, invoices, and shipping notices via EDI.',
    `effective_end_date` DATE COMMENT 'Date when this supplier site was deactivated or ceased operations. Null for currently active sites.',
    `effective_from` DATE COMMENT 'The effective from of the supplier site record',
    `effective_start_date` DATE COMMENT 'Date when this supplier site became active and available for procurement operations.',
    `effective_until` DATE COMMENT 'The effective until of the supplier site record',
    `email_address` STRING COMMENT 'Primary email contact for the supplier site.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the supplier site, if applicable.',
    `fsc_certified` BOOLEAN COMMENT 'Indicates whether this site holds FSC certification for sustainable forestry and paper sourcing.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical site location for supply chain traceability and EDI transactions.. Valid values are `^[0-9]{13}$`',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether this site is certified for Good Manufacturing Practices, critical for pharmaceutical and food-grade materials.',
    `is_active` BOOLEAN COMMENT 'The is active of the supplier site record',
    `is_primary_ship_from` BOOLEAN COMMENT 'The is primary ship from of the supplier site record',
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
    `supplier_site_name` STRING COMMENT 'The supplier site name of the supplier site record',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at this site.',
    `notes` STRING COMMENT 'The notes of the supplier site record',
    `phone_number` STRING COMMENT 'Primary contact phone number for the supplier site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supplier site address.',
    `preferred_site_flag` BOOLEAN COMMENT 'Indicates whether this site is designated as a preferred sourcing location based on performance, cost, or strategic criteria.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supplier site record',
    `rspo_certified` BOOLEAN COMMENT 'Indicates whether this site is certified by RSPO for sustainable palm oil sourcing.',
    `site_capacity` DECIMAL(18,2) COMMENT 'Maximum production or storage capacity of the site, measured in units relevant to the site type (e.g., units per month for manufacturing, pallets for warehouse).',
    `site_code` STRING COMMENT 'Internal or supplier-assigned unique code identifying this site location.',
    `site_manager_name` STRING COMMENT 'Name of the site manager or primary contact person responsible for this location.',
    `site_name` STRING COMMENT 'Business name or designation of the supplier site facility.',
    `site_status` STRING COMMENT 'Current operational status of the supplier site in the procurement system.. Valid values are `active|inactive|suspended|pending_approval|decommissioned`',
    `site_type` STRING COMMENT 'Classification of the site based on its primary business function.. Valid values are `manufacturing|warehouse|office|port|distribution_center|r_and_d`',
    `source_system_code` STRING COMMENT 'The source system code of the supplier site record',
    `state_province` STRING COMMENT 'State, province, or administrative region of the supplier site.',
    `supplier_site_status` STRING COMMENT 'The supplier site status of the supplier site record',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the site location, used for scheduling deliveries and coordinating communications.',
    `uom` STRING COMMENT 'The uom of the supplier site record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supplier site record',
    `vmi_enabled` BOOLEAN COMMENT 'Indicates whether this site participates in a VMI program where the supplier manages inventory levels at the buyers location.',
    CONSTRAINT pk_supplier_site PRIMARY KEY(`supplier_site_id`)
) COMMENT 'Physical manufacturing, warehouse, or office locations associated with a supplier. Captures site address, site type (manufacturing/warehouse/office/port), GS1 GLN, country of origin, site capacity, certifications held at site level (ISO 9001, ISO 22716, GMP), site-level lead time, and active status. Supports multi-site supplier relationships and origin traceability for regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Unique identifier for the supplier contract record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract Management process assigns a responsible employee; linking contract_owner to employee enables ownership tracking and compliance reporting.',
    `sourcing_event_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_event. Business justification: A supplier contract is the primary deliverable of a sourcing event. Linking supplier_contract to sourcing_event enables end-to-end sourcing lifecycle tracking — from event initiation through RFQ, awar',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Supplier contracts are negotiated within a specific spend category (e.g., raw materials, packaging, indirect services). Adding spend_category_id to supplier_contract enables category-level contract co',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier party with whom this contract is negotiated.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supplier contract record',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who provided final approval for this contract.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the supplier contract record',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry unless explicitly terminated by either party.',
    `supplier_contract_code` STRING COMMENT 'The supplier contract code of the supplier contract record',
    `contract_document_reference` STRING COMMENT 'Reference identifier or URL to the signed contract document stored in document management system (e.g., Veeva Vault, SharePoint).',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract, used in procurement systems and supplier communications.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract: draft for initial creation, pending approval for review workflow, active for in-force agreements, suspended for temporary holds, expired for naturally ended contracts, terminated for early cancellation, or renewed for extended agreements. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the contract structure: framework agreement for multi-material commitments, blanket order for recurring purchases, spot purchase for one-time buys, long-term agreement for strategic partnerships, consignment for supplier-owned inventory, or vendor managed inventory (VMI) for supplier-controlled replenishment.. Valid values are `framework_agreement|blanket_order|spot_purchase|long_term_agreement|consignment|vendor_managed_inventory`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Total monetary value committed under this contract across all line items and periods, used for spend tracking and budget allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Agreed delivery conditions including lead times, delivery windows, and logistics requirements.',
    `supplier_contract_description` STRING COMMENT 'The supplier contract description of the supplier contract record',
    `effective_date` DATE COMMENT 'Date when the contract becomes legally binding and pricing terms take effect.',
    `effective_from` DATE COMMENT 'The effective from of the supplier contract record',
    `effective_until` DATE COMMENT 'The effective until of the supplier contract record',
    `end_date` DATE COMMENT 'The end date of the supplier contract record',
    `expiry_date` DATE COMMENT 'Date when the contract naturally ends unless renewed or terminated earlier. Nullable for open-ended agreements.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law under which the contract is interpreted and enforced (e.g., State of Delaware, English Law).',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and supplier for shipping, insurance, and risk transfer (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated, used for change tracking and audit purposes.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity allowed per purchase order line under this contract, used to manage supplier capacity and volume commitments.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order line to qualify for contract pricing, expressed in base unit of measure.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this contract record.',
    `supplier_contract_name` STRING COMMENT 'The supplier contract name of the supplier contract record',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, or internal comments not captured in structured fields.',
    `payment_terms` STRING COMMENT 'Agreed payment conditions such as net 30, net 60, or early payment discount terms (e.g., 2/10 net 30).',
    `penalty_clause` STRING COMMENT 'Terms defining financial penalties for supplier non-compliance, late delivery, quality failures, or other contractual breaches.',
    `price_escalation_formula` STRING COMMENT 'Mathematical formula or index reference used to adjust prices over time, such as CPI-based adjustments or commodity index linkage.',
    `pricing_mechanism` STRING COMMENT 'Method by which prices are determined: fixed price for static rates, cost plus for markup on supplier costs, market indexed for commodity-linked pricing, volume tiered for quantity-based discounts, or rebate based for retrospective incentives.. Valid values are `fixed_price|cost_plus|market_indexed|volume_tiered|rebate_based`',
    `purchasing_group` STRING COMMENT 'The buyer or procurement team assigned to manage this contract, responsible for execution and supplier relationship.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for negotiating and managing this contract, typically aligned with regional or divisional procurement teams.',
    `quality_specification` STRING COMMENT 'Reference to quality standards, specifications, or inspection criteria that supplied materials must meet (e.g., GMP, ISO 9001, internal spec codes).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supplier contract record',
    `quantity_unit_of_measure` STRING COMMENT 'Base unit of measure for quantity commitments (e.g., KG, LTR, EA, MT) aligned with material master data.',
    `rebate_terms` STRING COMMENT 'Description of volume-based or performance-based rebate conditions, including thresholds, percentages, and settlement periods.',
    `renewal_notice_days` STRING COMMENT 'The renewal notice days of the supplier contract record',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that either party must provide notice to prevent auto-renewal or initiate renewal negotiations.',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether supplier must provide Safety Data Sheets for hazardous materials covered by this contract, per OSHA and EPA regulations.',
    `source_system_code` STRING COMMENT 'The source system code of the supplier contract record',
    `start_date` DATE COMMENT 'The start date of the supplier contract record',
    `supplier_contract_status` STRING COMMENT 'The supplier contract status of the supplier contract record',
    `sustainability_certification` STRING COMMENT 'Required sustainability certifications for materials under this contract, such as FSC (Forest Stewardship Council) for paper/packaging or RSPO (Roundtable on Sustainable Palm Oil) for palm oil derivatives.',
    `target_quantity_total` DECIMAL(18,2) COMMENT 'Aggregate quantity commitment across all materials and line items over the contract period, used for volume-based pricing and rebate calculations.',
    `termination_date` DATE COMMENT 'Actual date when the contract was terminated early, either by mutual agreement or due to breach. Null if contract expired naturally or is still active.',
    `termination_reason` STRING COMMENT 'Business reason for early termination, such as supplier performance issues, strategic sourcing changes, or mutual agreement.',
    `title` STRING COMMENT 'The title of the supplier contract record',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total contract value of the supplier contract record',
    `uom` STRING COMMENT 'The uom of the supplier contract record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supplier contract record',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Procurement contracts and framework agreements negotiated with suppliers for raw materials, packaging, and indirect goods. Captures contract header (number, type, effective/expiry dates, total value, currency, pricing mechanism, rebate terms, penalty clauses, auto-renewal, governing law) and contract line items (material/SKU, agreed unit price, price UoM, target quantity, MOQ, max order quantity, price validity period, escalation formula, line status). Tracks contract lifecycle from draft through active to expired/terminated. Enables granular price and volume commitment tracking at the material level. Owns all line-level detail as embedded attributes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Unique identifier for the contract line item. Primary key for this entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Contract line items are charged to specific GL accounts for cost tracking; required for contract‑based accounting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution center that will receive the material. Used for multi-site procurement and logistics planning.',
    `sds_id` BIGINT COMMENT 'Reference to the Safety Data Sheet document for hazardous materials. Required for chemical and hazardous substance procurement to ensure workplace safety and regulatory compliance.',
    `sku_id` BIGINT COMMENT 'Reference to the material, raw material, packaging component, or indirect good being procured under this contract line. Links to the product master for specifications and attributes.',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the parent supplier contract that contains this line item. Links this line to the master agreement governing terms, supplier, and overall contract lifecycle.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the contract line record',
    `blocked_reason` STRING COMMENT 'Explanation for why the contract line is blocked or inactive. Provides business context for procurement restrictions (e.g., quality issue, supplier non-compliance, price dispute).',
    `contract_line_code` STRING COMMENT 'The contract line code of the contract line record',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The committed quantity of the contract line record',
    `contract_line_status` STRING COMMENT 'The contract line status of the contract line record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract line record was first created in the system. Used for audit trail and data lineage tracking.',
    `cumulative_invoiced_value` DECIMAL(18,2) COMMENT 'Total invoiced value for all purchase orders released against this contract line to date. Used for spend tracking and budget management.',
    `cumulative_ordered_quantity` DECIMAL(18,2) COMMENT 'Total quantity ordered against this contract line to date. Used for tracking contract utilization and remaining commitment.',
    `cumulative_received_quantity` DECIMAL(18,2) COMMENT 'Total quantity received against this contract line to date. Used for tracking actual fulfillment and supplier performance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price. Defines the monetary denomination for all pricing on this contract line.. Valid values are `^[A-Z]{3}$`',
    `contract_line_description` STRING COMMENT 'The contract line description of the contract line record',
    `effective_from` DATE COMMENT 'The effective from of the contract line record',
    `effective_until` DATE COMMENT 'The effective until of the contract line record',
    `incoterm_code` STRING COMMENT 'International Commercial Terms code defining the division of costs and risks between buyer and supplier for this line item. Governs shipping, insurance, and transfer of ownership responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterm_location` STRING COMMENT 'Named place or port associated with the Incoterm. Specifies the geographic point where cost and risk transfer occurs (e.g., supplier factory, destination port, buyer warehouse).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract line record was most recently updated. Used for change tracking and audit trail.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to expected goods receipt. Used for Material Requirements Planning (MRP) and demand planning calculations.',
    `line_number` STRING COMMENT 'Sequential line number within the parent contract. Used for ordering and referencing specific line items in procurement documents and communications.',
    `line_status` STRING COMMENT 'Current lifecycle status of the contract line. Controls whether purchase orders can be created against this line and tracks the lines operational state.. Valid values are `active|inactive|blocked|expired|pending_approval`',
    `material_code` STRING COMMENT 'The material code of the contract line record',
    `material_description` STRING COMMENT 'Textual description of the material or service being procured. Provides human-readable context for the line item beyond the material code.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials for procurement analysis and reporting. Enables spend analysis by category (e.g., raw materials, packaging, indirect goods).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per purchase order release against this contract line. May reflect supplier capacity constraints or buyer inventory limits.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order release against this contract line. Enforces supplier-defined minimum batch sizes for economic production or logistics.',
    `contract_line_name` STRING COMMENT 'The contract line name of the contract line record',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, special instructions, or contextual information for this contract line. Used for operational guidance and exception handling.',
    `order_quantity_uom` STRING COMMENT 'Unit of measure for minimum and maximum order quantities. Defines the measurement basis for order quantity constraints.',
    `payment_terms_code` STRING COMMENT 'Code representing the agreed payment terms for this contract line (e.g., Net 30, Net 60, 2/10 Net 30). Defines the payment due date calculation and any early payment discounts.',
    `price_escalation_formula` STRING COMMENT 'Formula or reference to index-based pricing adjustment mechanism. Defines how unit price will be adjusted over time based on commodity indices, inflation, or other agreed factors.',
    `price_unit` STRING COMMENT 'Quantity of the material to which the unit price applies. For example, if price is per 100 units, this field would be 100. Used in conjunction with unit_price to calculate effective per-unit cost.',
    `price_uom` STRING COMMENT 'Unit of measure for the price unit. Defines the measurement basis for pricing (e.g., EA for each, KG for kilogram, L for liter, M for meter).',
    `purchasing_group_code` STRING COMMENT 'Code identifying the procurement team or buyer responsible for managing this contract line. Used for workload distribution and accountability tracking.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether incoming goods for this contract line must undergo quality inspection before acceptance. Enforces Good Manufacturing Practice (GMP) and quality assurance requirements.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the contract line record',
    `source_system_code` STRING COMMENT 'The source system code of the contract line record',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location within the plant where the material will be received and stored. Used for warehouse management and inventory tracking.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical sourcing certification required for the material on this contract line. Supports compliance with corporate sustainability commitments and regulatory requirements. [ENUM-REF-CANDIDATE: FSC|RSPO|PEFC|Rainforest Alliance|Fair Trade|Organic|None — 7 candidates stripped; promote to reference product]',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned or target quantity of material to be procured over the contract validity period. Used for volume commitment tracking and supplier capacity planning.',
    `target_quantity_uom` STRING COMMENT 'Unit of measure for the target quantity. Defines how the target volume is measured (e.g., EA, KG, L, M).',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and tax jurisdiction for this contract line. Used for tax calculation and compliance reporting.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of measure for the material or service. This is the base price before any discounts, surcharges, or escalations are applied.',
    `uom` STRING COMMENT 'The uom of the contract line record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the contract line record',
    `validity_end_date` DATE COMMENT 'Date on which the pricing and terms on this contract line expire. Purchase orders can reference this line only on or before this date. Nullable for open-ended agreements.',
    `validity_start_date` DATE COMMENT 'Date from which the pricing and terms on this contract line become effective. Purchase orders can reference this line only on or after this date.',
    `valid_from` DATE COMMENT 'The valid from of the contract line record',
    `valid_to` DATE COMMENT 'The valid to of the contract line record',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Individual line items within a supplier contract specifying material, packaging component, or service being procured. Captures material/SKU reference, agreed unit price, price unit of measure, target quantity, MOQ, maximum order quantity, price validity period, price escalation formula, and contract line status. Enables granular price and volume commitment tracking at the material level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier selected and awarded the business based on evaluation criteria. Null if RFQ not yet awarded or cancelled.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing plant or distribution center where the materials will be delivered. Relevant for logistics planning and supplier proximity evaluation.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the RFQ record. Audit trail for accountability and process compliance.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the business unit, plant, or department that initiated the sourcing request and will consume the procured materials or services.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: RFQ‑Project Allocation process tracks which R&D project each RFQ supports for ingredient sourcing.',
    `rfq_buyer_employee_id` BIGINT COMMENT 'The rfq buyer employee id of the rfq record',
    `sourcing_event_id` BIGINT COMMENT 'The sourcing event id of the rfq record',
    `spend_category_id` BIGINT COMMENT 'The spend category id of the rfq record',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the purchase contract or purchase order created as a result of this RFQ. Links sourcing event to execution.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: RFQ evaluation includes the target node to assess lead‑time, capacity, and cost for the intended receipt location.',
    `tertiary_rfq_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the RFQ record. Audit trail for change accountability.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the rfq record',
    `award_date` DATE COMMENT 'Date when the supplier selection decision was finalized and communicated. Marks the transition from evaluation to contracting phase.',
    `award_justification` STRING COMMENT 'Business rationale for the supplier selection decision. Documents evaluation results, scoring, and strategic considerations for audit and compliance purposes.',
    `rfq_code` STRING COMMENT 'The rfq code of the rfq record',
    `commodity_category` STRING COMMENT 'High-level classification of the materials or services being sourced (e.g., raw materials, packaging, indirect goods, services). Aligns with procurement category management structure.',
    `commodity_subcategory` STRING COMMENT 'Detailed classification within the commodity category (e.g., fragrances, surfactants, bottles, labels, MRO supplies). Enables granular spend analysis and category strategy execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated value and supplier quotations (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `rfq_description` STRING COMMENT 'The rfq description of the rfq record',
    `effective_from` DATE COMMENT 'The effective from of the rfq record',
    `effective_until` DATE COMMENT 'The effective until of the rfq record',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the procurement. Used for budget planning, approval routing, and supplier qualification thresholds.',
    `estimated_volume` DECIMAL(18,2) COMMENT 'Anticipated quantity or volume of materials or services to be procured. Used by suppliers to calculate economies of scale and pricing.',
    `evaluation_criteria_delivery_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to delivery performance (lead time, OTIF history, flexibility) in the supplier evaluation scorecard.',
    `evaluation_criteria_price_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to price in the supplier evaluation scorecard. Part of multi-criteria decision analysis for supplier selection.',
    `evaluation_criteria_quality_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to quality factors (certifications, defect rates, compliance) in the supplier evaluation scorecard.',
    `evaluation_criteria_sustainability_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to sustainability factors (FSC certification, RSPO compliance, carbon footprint, ethical sourcing) in the supplier evaluation scorecard.',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and supplier for transportation, insurance, and risk transfer (e.g., EXW, FCA, DDP, FOB, CIF). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date when the RFQ was officially issued to suppliers. Marks the start of the supplier response period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was last updated. Audit trail for change tracking.',
    `rfq_name` STRING COMMENT 'The rfq name of the rfq record',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, or internal comments related to the RFQ. Used for context that does not fit structured fields.',
    `payment_terms` STRING COMMENT 'Standard payment terms requested from suppliers (e.g., Net 30, Net 60, 2/10 Net 30). Used to evaluate total cost of ownership including cash flow impact.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the rfq record',
    `requires_quality_certification` BOOLEAN COMMENT 'Indicates whether suppliers must provide quality management system certifications (e.g., ISO 9001, GMP, ISO 22716 for cosmetics).',
    `requires_sds` BOOLEAN COMMENT 'Indicates whether suppliers must provide Safety Data Sheets for the materials being sourced. Mandatory for chemicals, fragrances, and hazardous substances.',
    `requires_sustainability_declaration` BOOLEAN COMMENT 'Indicates whether suppliers must provide sustainability certifications or declarations (e.g., FSC for paper/packaging, RSPO for palm oil derivatives, conflict minerals disclosure).',
    `response_due_date` DATE COMMENT 'The response due date of the rfq record',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ, externally visible and used in supplier communications and procurement documentation.. Valid values are `^RFQ-[0-9]{8,12}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Draft indicates preparation phase, issued means sent to suppliers, open indicates active response period, closed means submission deadline passed, awarded indicates supplier selected, cancelled means RFQ withdrawn.. Valid values are `draft|issued|open|closed|awarded|cancelled`',
    `rfq_type` STRING COMMENT 'Classification of the RFQ based on procurement strategy and urgency. Standard for routine sourcing, spot buy for one-time purchases, framework for long-term agreements, emergency for urgent needs, global sourcing for multi-region procurement, strategic for high-value category sourcing.. Valid values are `standard|spot_buy|framework|emergency|global_sourcing|strategic`',
    `source_system_code` STRING COMMENT 'The source system code of the rfq record',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which suppliers must submit their quotations. No responses accepted after this timestamp.',
    `supplier_count_invited` STRING COMMENT 'Number of suppliers invited to participate in this RFQ. Used to assess competitive intensity and sourcing strategy effectiveness.',
    `supplier_count_responded` STRING COMMENT 'Number of suppliers who submitted quotations by the deadline. Used to calculate response rate and assess market interest.',
    `technical_specification_document_url` STRING COMMENT 'Reference to the detailed technical specification document shared with suppliers. Contains material requirements, quality standards, packaging specifications, and testing protocols.',
    `title` STRING COMMENT 'The title of the rfq record',
    `uom` STRING COMMENT 'The uom of the rfq record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the rfq record',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the estimated volume (e.g., kilograms, liters, each, meters, square meters, cubic meters, tons, pounds, gallons, feet, yards). [ENUM-REF-CANDIDATE: KG|L|EA|M|M2|M3|TON|LB|GAL|FT|YD — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation issued to one or more suppliers for raw materials, packaging, or indirect goods. Captures RFQ header (number, type, issue date, submission deadline, commodity category, estimated volume, evaluation criteria weights, status) and all supplier responses/quotations (responding supplier, quoted unit price, lead time, MOQ, validity period, payment terms, sustainability declarations, response status including submitted/accepted/rejected/awarded). Enables competitive sourcing, multi-supplier bid comparison, and sourcing decision documentation. Owns response-level detail as embedded attributes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` (
    `rfq_response_id` BIGINT COMMENT 'Unique identifier for the RFQ response record. Primary key.',
    `rfq_id` BIGINT COMMENT 'Reference to the parent RFQ for which this response was submitted.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this quotation response.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the rfq response record',
    `award_date` DATE COMMENT 'Date when the RFQ was awarded to this supplier.',
    `awarded_flag` BOOLEAN COMMENT 'Indicates whether this RFQ response was awarded the business.',
    `rfq_response_code` STRING COMMENT 'The rfq response code of the rfq response record',
    `contact_email` STRING COMMENT 'Email address of the supplier contact person for this response.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the supplier contact person who submitted the response.',
    `contact_phone` STRING COMMENT 'Phone number of the supplier contact person for this response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ response record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the quoted price.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Specified delivery location or plant code for the quoted materials.',
    `rfq_response_description` STRING COMMENT 'The rfq response description of the rfq response record',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered by the supplier on the quoted price.',
    `effective_from` DATE COMMENT 'The effective from of the rfq response record',
    `effective_until` DATE COMMENT 'The effective until of the rfq response record',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Procurement teams evaluation score for this response based on defined criteria.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery and risk transfer terms. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_awarded` BOOLEAN COMMENT 'The is awarded of the rfq response record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ response record was last updated.',
    `lead_time_days` STRING COMMENT 'The lead time days of the rfq response record',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this quotation.',
    `moq_uom` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., KG, L, EA, MT).',
    `rfq_response_name` STRING COMMENT 'The rfq response name of the rfq response record',
    `notes` STRING COMMENT 'The notes of the rfq response record',
    `payment_terms` STRING COMMENT 'Payment terms offered by the supplier (e.g., Net 30, Net 60, 2/10 Net 30).',
    `quality_certification` STRING COMMENT 'Quality management certifications held by the supplier (e.g., ISO 9001, GMP, ISO 22716).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the rfq response record',
    `quoted_lead_time_days` STRING COMMENT 'Number of days from order placement to delivery as quoted by the supplier.',
    `quoted_price` DECIMAL(18,2) COMMENT 'The quoted price of the rfq response record',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Unit price quoted by the supplier for the requested material or service.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the RFQ response if not awarded.',
    `response_date` DATE COMMENT 'The response date of the rfq response record',
    `response_notes` STRING COMMENT 'Additional notes or comments provided by the supplier with the quotation response.',
    `response_number` STRING COMMENT 'Business identifier for the RFQ response, typically assigned by the supplier or procurement system.',
    `response_status` STRING COMMENT 'Current lifecycle status of the RFQ response in the procurement workflow.. Valid values are `submitted|under_review|accepted|rejected|awarded|withdrawn`',
    `rfq_response_status` STRING COMMENT 'The rfq response status of the rfq response record',
    `sample_available_flag` BOOLEAN COMMENT 'Indicates whether the supplier can provide a sample for evaluation.',
    `sample_lead_time_days` STRING COMMENT 'Number of days required to provide a sample if available.',
    `score` DECIMAL(18,2) COMMENT 'The score of the rfq response record',
    `sds_provided_flag` BOOLEAN COMMENT 'Indicates whether the supplier has provided a Safety Data Sheet with the response.',
    `source_system_code` STRING COMMENT 'The source system code of the rfq response record',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted the RFQ response.',
    `submitted_date` DATE COMMENT 'The submitted date of the rfq response record',
    `sustainability_certification` STRING COMMENT 'Sustainability certifications declared by the supplier (e.g., FSC, RSPO, ISO 14001).',
    `technical_specification_compliance` STRING COMMENT 'Suppliers declared compliance level with the technical specifications in the RFQ.. Valid values are `fully_compliant|partially_compliant|non_compliant|not_assessed`',
    `total_quoted_amount` DECIMAL(18,2) COMMENT 'Total amount quoted for the entire RFQ line item or package.',
    `total_quoted_value` DECIMAL(18,2) COMMENT 'The total quoted value of the rfq response record',
    `uom` STRING COMMENT 'The uom of the rfq response record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the rfq response record',
    `validity_date` DATE COMMENT 'The validity date of the rfq response record',
    `validity_end_date` DATE COMMENT 'Date until which the quoted price and terms remain valid.',
    `validity_start_date` DATE COMMENT 'Date from which the quoted price and terms become valid.',
    `warranty_period_months` STRING COMMENT 'Warranty period offered by the supplier in months.',
    CONSTRAINT pk_rfq_response PRIMARY KEY(`rfq_response_id`)
) COMMENT 'Supplier quotation submitted in response to an RFQ. Captures responding supplier, quoted unit price, currency, quoted lead time, MOQ, validity period, payment terms offered, sustainability declarations, sample availability, and response status (submitted/accepted/rejected/awarded). Enables multi-supplier bid comparison and sourcing decision documentation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the requisition at the current or final approval level.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the specific storage location within the plant where materials should be delivered.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing plant or facility requesting the materials or services.',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred or recommended supplier for this requisition, based on contracts or sourcing strategy.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Requisitions need profit‑center tagging for budgeting and forecast alignment; used in spend planning reports.',
    `cost_center_id` BIGINT COMMENT 'The purchase cost center id of the purchase requisition record',
    `purchase_requested_by_employee_id` BIGINT COMMENT 'The purchase requested by employee id of the purchase requisition record',
    `purchase_requesting_cost_center_id` BIGINT COMMENT 'Identifier of the cost center that initiated the purchase requisition and will bear the expense.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Requisition‑Project Traceability links each purchase requisition to its originating R&D project.',
    `requester_employee_id` BIGINT COMMENT 'Identifier of the employee who created the purchase requisition.',
    `rfq_id` BIGINT COMMENT 'Identifier of the RFQ generated from this requisition for competitive bidding, if applicable.',
    `sku_id` BIGINT COMMENT 'Identifier of the material master record being requested, applicable for material requisitions.',
    `spend_category_id` BIGINT COMMENT 'The spend category id of the purchase requisition record',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the purchasing contract or outline agreement against which this requisition should be fulfilled.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Requisitions must be tied to the network node where the material is needed for accurate supply planning and ATP calculations.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the purchase requisition record',
    `approval_level` STRING COMMENT 'Current approval level in the multi-tier approval workflow (e.g., 1 for manager, 2 for director, 3 for VP).',
    `approval_status` STRING COMMENT 'The approval status of the purchase requisition record',
    `approval_workflow_reference` BIGINT COMMENT 'Identifier of the approval workflow instance governing this requisition, based on value thresholds and organizational rules.',
    `approved_date` DATE COMMENT 'Date when the purchase requisition received final approval and became eligible for purchase order creation.',
    `purchase_requisition_code` STRING COMMENT 'The purchase requisition code of the purchase requisition record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `purchase_requisition_description` STRING COMMENT 'The purchase requisition description of the purchase requisition record',
    `effective_from` DATE COMMENT 'The effective from of the purchase requisition record',
    `effective_until` DATE COMMENT 'The effective until of the purchase requisition record',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition (quantity × estimated unit price), used for budget control and approval routing.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service, used for budgeting and approval thresholds.',
    `general_ledger_account` STRING COMMENT 'General ledger account number to which the purchase requisition expense will be posted.',
    `internal_order_number` STRING COMMENT 'Internal order number for tracking costs related to specific internal activities or campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated.',
    `material_description` STRING COMMENT 'Short text description of the material or service being requested.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials for procurement and reporting purposes (e.g., raw materials, packaging, indirect goods).',
    `material_number` STRING COMMENT 'Business identifier (SKU or material code) of the requested material.',
    `purchase_requisition_name` STRING COMMENT 'The purchase requisition name of the purchase requisition record',
    `notes` STRING COMMENT 'Additional free-text notes or special instructions provided by the requester for procurement or supplier reference.',
    `priority` STRING COMMENT 'Business priority level indicating urgency of the procurement request, used for expediting and resource allocation.. Valid values are `low|normal|high|urgent`',
    `purchase_requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_ordered|fully_ordered|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `purchasing_group_code` STRING COMMENT 'Code of the purchasing group (buyer team) responsible for processing this requisition.',
    `purchasing_organization_code` STRING COMMENT 'Code of the purchasing organization responsible for procuring the requested materials or services.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the purchase requisition record',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material or service units requested in the purchase requisition.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver if the requisition was rejected.',
    `requested_date` DATE COMMENT 'Date when the purchase requisition was created or submitted by the requesting department.',
    `requester_email` STRING COMMENT 'Email address of the employee who created the requisition, used for notifications and approvals.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the employee who created the purchase requisition.',
    `required_date` DATE COMMENT 'The required date of the purchase requisition record',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials or services must be delivered to meet operational or production requirements.',
    `requisition_date` DATE COMMENT 'The requisition date of the purchase requisition record',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition, typically system-generated and externally visible to requesters and procurement teams.. Valid values are `^PR[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'The requisition status of the purchase requisition record',
    `requisition_type` STRING COMMENT 'Classification of the purchase requisition based on procurement scenario: standard purchase, subcontracting, consignment, stock transfer, service procurement, or third-party order.. Valid values are `standard|subcontracting|consignment|stock_transfer|service|third_party`',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet is required for the requested material due to hazardous or regulated chemical content.',
    `source_of_supply` STRING COMMENT 'Recommended or assigned source for fulfilling the requisition (preferred supplier, existing contract, stock transfer, external procurement, internal production).. Valid values are `preferred_supplier|contract|stock_transfer|external|internal`',
    `source_system_code` STRING COMMENT 'The source system code of the purchase requisition record',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether the requisition is for sustainably sourced materials (FSC-certified, RSPO-certified, or other sustainability standards).',
    `total_estimated_value` DECIMAL(18,2) COMMENT 'The total estimated value of the purchase requisition record',
    `unit_of_measure` STRING COMMENT 'Unit in which the requested quantity is expressed (e.g., KG, L, EA, M, BOX).',
    `uom` STRING COMMENT 'The uom of the purchase requisition record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the purchase requisition record',
    `wbs_element` STRING COMMENT 'Project work breakdown structure element for project-related requisitions, used for project cost tracking.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requisition (PR) raised by manufacturing, R&D, marketing, or other departments requesting procurement of raw materials, packaging, or indirect goods. Captures requisition number, requesting cost center, material/service description, required quantity, unit of measure, required delivery date, estimated value, approval workflow status, and source of supply recommendation. Feeds the purchase order creation process and supports budget control and spend governance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key for the purchase order entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign Procurement Tracking: PO for promotional items is linked to the specific marketing campaign driving the purchase, used in spend attribution reports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for PO cost allocation in financial reporting; finance tracks expenses per cost center, obvious to procurement analysts.',
    `inventory_storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_storage_location. Business justification: REQUIRED: Captures the target warehouse for each PO, essential for logistics execution and inventory inbound planning.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant, distribution center, or facility where goods will be delivered. Critical for logistics planning and inventory allocation.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Required for Production‑Order‑Purchase‑Order traceability report linking each PO to the specific production order it fulfills.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profit‑center profitability analysis of procurement spend; standard in consumer‑goods for margin reporting.',
    `employee_id` BIGINT COMMENT 'The purchase buyer employee id of the purchase order record',
    `purchase_created_by_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PO creation audit requires recording the buyer employee; this supports PO creation logs and buyer performance analysis.',
    `purchase_requisition_id` BIGINT COMMENT 'Reference to the internal purchase requisition that triggered this purchase order. Links procurement execution to demand origination for budget tracking and approval audit.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Project‑Based Procurement Report requires each PO to be linked to the R&D project that initiated the material request.',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ that preceded this purchase order. Links procurement execution back to sourcing process for audit trail and supplier selection justification.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Make‑to‑order production requires linking each sales order to its originating purchase order for planning and cost tracking.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to regulatory.sds. Business justification: Regulatory compliance requires attaching the SDS to each Purchase Order for hazardous products; procurement tracks this via a dedicated sds_id column.',
    `sourcing_event_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_event. Business justification: A purchase order is often the direct outcome of a strategic sourcing event. While purchase_order already links to rfq_id and supplier_contract_id, a direct sourcing_event_id enables spend analytics by',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the master procurement contract or blanket agreement under which this purchase order is issued. Used for contract compliance, pricing validation, and spend aggregation.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier from whom materials or services are being procured. Links to supplier master data.',
    `supplier_site_id` BIGINT COMMENT 'The supplier site id of the purchase order record',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: PO execution needs the destination network node to plan inbound shipments, track OTIF, and reconcile inventory at the correct node.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the purchase order record',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the purchase order received final approval and was released for transmission to the supplier. Used for procurement cycle time measurement and approval workflow audit.',
    `approval_status` STRING COMMENT 'The approval status of the purchase order record',
    `approved_by` STRING COMMENT 'User ID or name of the person who provided final approval for this purchase order. Used for authorization audit and segregation of duties compliance.',
    `cancellation_date` DATE COMMENT 'Date when the purchase order was cancelled before completion. Used for supplier performance analysis, demand forecast accuracy, and procurement exception tracking.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the purchase order was cancelled. Examples: demand change, supplier unable to fulfill, duplicate order, pricing dispute. Used for root cause analysis and process improvement.',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after all goods were received, invoices verified, and no further activity expected. Used for procurement lifecycle completion tracking.',
    `purchase_order_code` STRING COMMENT 'The purchase order code of the purchase order record',
    `company_code` STRING COMMENT 'Legal entity code for financial accounting and reporting. Links procurement transactions to the appropriate balance sheet and P&L.. Valid values are `^[A-Z0-9]{4}$`',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery. May differ from requested date due to supplier capacity, lead times, or material availability. Used for OTIF variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first created in the system. Used for audit trail, procurement cycle time analysis, and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this purchase order. Used for foreign exchange management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `purchase_order_description` STRING COMMENT 'The purchase order description of the purchase order record',
    `edi_status` STRING COMMENT 'Status of EDI transmission to the supplier. Tracks whether PO was successfully sent via EDI 850, acknowledged via EDI 855, or encountered transmission errors. Critical for automated supplier integration.. Valid values are `not_sent|sent|acknowledged|rejected|error`',
    `edi_transmission_date` TIMESTAMP COMMENT 'Timestamp when the purchase order was transmitted to the supplier via EDI. Used for supplier response time tracking and transmission audit.',
    `effective_from` DATE COMMENT 'The effective from of the purchase order record',
    `effective_until` DATE COMMENT 'The effective until of the purchase order record',
    `freight_amount` DECIMAL(18,2) COMMENT 'Transportation and logistics charges associated with this purchase order. May be supplier-charged or third-party logistics costs.',
    `goods_receipt_required` BOOLEAN COMMENT 'Indicator whether physical goods receipt posting is required for this purchase order. True for materials, false for services or non-stock items. Controls three-way match process.',
    `incoterms` STRING COMMENT 'International commercial terms defining the division of costs, risks, and responsibilities between buyer and supplier for transportation and delivery. Examples: FOB (Free On Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs. Examples: Shanghai Port, Supplier Warehouse, Buyer Plant.',
    `invoice_receipt_required` BOOLEAN COMMENT 'Indicator whether invoice verification is required before payment. Controls accounts payable workflow and three-way match completion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was last updated. Used for change tracking, audit trail, and data synchronization across systems.',
    `purchase_order_name` STRING COMMENT 'The purchase order name of the purchase order record',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total purchase order value including taxes and freight. Represents the complete financial commitment to the supplier.',
    `notes` STRING COMMENT 'The notes of the purchase order record',
    `order_date` DATE COMMENT 'Date when the purchase order was created and issued to the supplier. Principal business event timestamp for procurement lead time calculation and supplier performance measurement.',
    `payment_terms` STRING COMMENT 'Code defining payment conditions such as net days, early payment discounts, and due date calculation. Examples: NET30, 2/10NET30, NET60. Critical for cash flow management and supplier relationship terms.. Valid values are `^[A-Z0-9]{4,10}$`',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Used for supplier communication, EDI transactions, and cross-system reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Tracks progression from creation through approval, supplier confirmation, goods receipt, and closure. Critical for procurement workflow management and OTIF tracking. [ENUM-REF-CANDIDATE: draft|submitted|approved|confirmed|in_transit|partially_received|fully_received|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement strategy. Standard for one-time orders, blanket for recurring deliveries against a master agreement, contract for long-term commitments, subcontracting for external manufacturing, consignment for supplier-owned inventory, framework for multi-release agreements.. Valid values are `standard|blanket|contract|subcontracting|consignment|framework`',
    `priority` STRING COMMENT 'Business priority level for this purchase order. Urgent for production-critical materials, high for near-term demand, normal for standard replenishment, low for non-critical items.. Valid values are `urgent|high|normal|low`',
    `purchase_order_status` STRING COMMENT 'The purchase order status of the purchase order record',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for this purchase order. Used for workload distribution, performance tracking, and supplier communication routing.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement. Used for spend analysis, contract authority, and supplier relationship ownership.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the purchase order record',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services. Used for production planning, inventory management, and supplier commitment tracking.',
    `source_system_code` STRING COMMENT 'The source system code of the purchase order record',
    `supplier_confirmation_date` TIMESTAMP COMMENT 'Timestamp when the supplier confirmed acceptance of the purchase order. Used for supplier responsiveness measurement and order commitment tracking.',
    `supplier_confirmation_method` STRING COMMENT 'Channel through which the supplier acknowledged the purchase order. EDI 855 for automated acknowledgment, supplier portal for web-based confirmation, email/phone/fax for manual confirmation.. Valid values are `edi_855|supplier_portal|email|phone|fax|not_confirmed`',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical sourcing certification required for materials on this purchase order. FSC for forest products, RSPO for palm oil, fair trade for ethical labor, organic for agricultural inputs. Critical for corporate sustainability reporting and regulatory compliance.. Valid values are `FSC|RSPO|fair_trade|organic|none`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order. Includes VAT, GST, sales tax, or other jurisdiction-specific taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the purchase order record',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and freight. Used for budget tracking, spend analysis, and supplier performance measurement.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the purchase order record',
    `transport_mode` STRING COMMENT 'Primary method of transportation for delivery. Used for logistics planning, lead time estimation, and freight cost allocation.. Valid values are `air|ocean|rail|truck|courier|multimodal`',
    `uom` STRING COMMENT 'The uom of the purchase order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the purchase order record',
    `vmi_indicator` BOOLEAN COMMENT 'Flag indicating whether this purchase order is part of a VMI program where the supplier manages inventory levels and replenishment. True for VMI orders, false for buyer-managed procurement.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase order issued to a supplier for raw materials, packaging components, or indirect goods/services. Captures PO header (number, type, order date, supplier, delivery plant, payment terms, incoterms, total value, currency, EDI status, lifecycle status) and PO line items (material number, ordered quantity, unit price, delivery dates, batch requirements, GR/IR indicators, line status). Includes supplier order confirmations (confirmed dates, quantities, variances, confirmation method EDI 855/portal/email) and delivery schedule lines (planned/confirmed dates, quantities, transport mode, delivery status). Core transactional entity for procurement execution, three-way match, OTIF tracking, and proactive supply risk management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line product.',
    `contract_line_id` BIGINT COMMENT 'The contract line id of the po line record',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each PO line posts to a GL account; required for accurate ledger posting and audit trails.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to regulatory.sds. Business justification: Line‑level SDS reference is needed for quality and safety checks during order fulfillment; PO line stores the specific SDS identifier.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the material master record. Identifies the raw material, packaging component, or indirect good being ordered on this line.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the po line record',
    `batch_management_indicator` BOOLEAN COMMENT 'Flag indicating whether the material on this line is subject to batch management. When true, batch number must be assigned during goods receipt for traceability.',
    `po_line_code` STRING COMMENT 'The po line code of the po line record',
    `confirmed_delivery_date` DATE COMMENT 'Supplier-confirmed delivery date for this line item. May differ from the requested delivery date based on supplier capacity and lead time.',
    `cost_center` STRING COMMENT 'Cost center to which the expense for this purchase order line will be charged. Used for financial accounting and budget tracking.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line was originally created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the net price. Indicates the currency in which the supplier will be paid.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this purchase order line has been marked for deletion. When true, the line is logically deleted but retained for audit purposes.',
    `delivery_date` DATE COMMENT 'Requested or confirmed delivery date for this purchase order line. Target date by which the supplier should deliver the material to the receiving plant.',
    `po_line_description` STRING COMMENT 'The po line description of the po line record',
    `effective_from` DATE COMMENT 'The effective from of the po line record',
    `effective_until` DATE COMMENT 'The effective until of the po line record',
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
    `line_total` DECIMAL(18,2) COMMENT 'The line total of the po line record',
    `manufacturer_part_number` STRING COMMENT 'Original manufacturers part number for the material. Important for quality assurance and regulatory compliance tracking.',
    `material_code` STRING COMMENT 'The material code of the po line record',
    `material_description` STRING COMMENT 'Short text description of the material or service being ordered. Provides human-readable context for the line item.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials for procurement analysis and reporting. Used for spend categorization and supplier segmentation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Business identifier for the material being ordered. Alphanumeric code used across procurement, manufacturing, and supply chain systems.. Valid values are `^[A-Z0-9]{8,18}$`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this material. Procurement must order at least this quantity to meet supplier terms.',
    `po_line_name` STRING COMMENT 'The po line name of the po line record',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value of this purchase order line calculated as ordered quantity multiplied by net price. Excludes taxes and freight.',
    `net_price` DECIMAL(18,2) COMMENT 'Net unit price for the material excluding taxes and additional charges. Base price agreed with the supplier per price unit.',
    `notes` STRING COMMENT 'The notes of the po line record',
    `order_quantity` DECIMAL(18,2) COMMENT 'The order quantity of the po line record',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of material ordered on this purchase order line. Represents the total amount requested from the supplier.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received on this purchase order line. Calculated as ordered quantity minus goods received quantity.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may over-deliver beyond the ordered quantity. Used to control goods receipt tolerances.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the material will be received and consumed. Determines the receiving location for goods receipt.. Valid values are `^[A-Z0-9]{4}$`',
    `po_line_status` STRING COMMENT 'The po line status of the po line record',
    `price_unit` STRING COMMENT 'Quantity unit for which the net price applies. For example, price per 100 units or per 1000 units. Used to calculate total line value.',
    `purchasing_group` STRING COMMENT 'Code identifying the procurement team or buyer responsible for this purchase order line. Used for workload distribution and performance tracking.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the po line record',
    `received_quantity` DECIMAL(18,2) COMMENT 'The received quantity of the po line record',
    `requested_delivery_date` DATE COMMENT 'The requested delivery date of the po line record',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that requested this material through a purchase requisition. Provides accountability and cost center traceability.',
    `short_text` STRING COMMENT 'Additional short text or notes specific to this purchase order line. Provides supplementary information for procurement and receiving teams.',
    `source_system_code` STRING COMMENT 'The source system code of the po line record',
    `storage_location` STRING COMMENT 'Specific storage location or warehouse area within the plant where the material will be stored upon receipt. Used for inventory positioning.. Valid values are `^[A-Z0-9]{4}$`',
    `supplier_material_number` STRING COMMENT 'Suppliers own material or part number for this item. Used for cross-referencing and communication with the supplier.',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and jurisdiction for this line item. Used for invoice verification and tax reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may under-deliver below the ordered quantity. Used to control goods receipt tolerances and automatic PO closure.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity. Standard codes such as KG (kilogram), LT (liter), EA (each), MT (metric ton), CS (case).. Valid values are `^[A-Z]{2,3}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the po line record',
    `uom` STRING COMMENT 'The uom of the po line record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the po line record',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items on a purchase order specifying the material, packaging component, or service being ordered. Captures PO line number, material number, material description, ordered quantity, unit of measure, confirmed delivery date, net price, price unit, storage location, batch management flag, goods receipt indicator, invoice receipt indicator, and line status. Enables granular tracking of delivery and invoice matching at the material level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.delivery_schedule. Business justification: A goods receipt event closes out a delivery schedule line — the physical receipt of goods should reference the scheduled delivery it fulfills. This link enables schedule vs. actual delivery comparison',
    `employee_id` BIGINT COMMENT 'The system user ID of the warehouse operator or receiving clerk who physically accepted and posted the goods receipt. Used for audit trails and accountability.',
    `inventory_storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_storage_location. Business justification: REQUIRED: Records the exact storage location where goods receipt is posted, enabling accurate stock updates.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the inbound shipment or transportation leg that delivered these goods. Links to logistics tracking and OTIF measurement.',
    `po_confirmation_id` BIGINT COMMENT 'Foreign key linking to procurement.po_confirmation. Business justification: A goods receipt validates what was promised in the PO confirmation. Linking goods_receipt to po_confirmation enables three-way match validation (PO → confirmation → GR), OTIF compliance measurement ag',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods were received. Enables line-level tracking and three-way match.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods were received. Links this goods receipt to the originating procurement document.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Materials‑to‑Project Log records receipt of goods against the specific R&D project they support.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the goods. Used for supplier performance scorecards and VMI reconciliation.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Inbound logistics requires linking each goods receipt to the warehouse node for accurate inventory updates and OTIF reporting.',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'The accepted quantity of the goods receipt record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the goods receipt record',
    `batch_number` STRING COMMENT 'The supplier-provided or internally-assigned batch or lot number for traceability. Critical for quality management, recalls, and FEFO inventory management.. Valid values are `^[A-Z0-9]{10}$`',
    `carrier_name` STRING COMMENT 'The name of the transportation carrier or logistics provider who delivered the goods. Used for carrier performance analysis.',
    `certificate_of_analysis_received_flag` BOOLEAN COMMENT 'Indicates whether the supplier-provided Certificate of Analysis was received with the shipment. Required for GMP compliance and quality assurance.',
    `goods_receipt_code` STRING COMMENT 'The goods receipt code of the goods receipt record',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was first created in the database. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the valuation amount is expressed. Typically the company code currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The supplier-provided delivery note or packing slip number accompanying the shipment. Used for cross-referencing and dispute resolution.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `goods_receipt_description` STRING COMMENT 'The goods receipt description of the goods receipt record',
    `document_date` DATE COMMENT 'The date printed on the supplier delivery note or packing slip. May differ from posting date due to processing delays.',
    `effective_from` DATE COMMENT 'The effective from of the goods receipt record',
    `effective_until` DATE COMMENT 'The effective until of the goods receipt record',
    `expiry_date` DATE COMMENT 'The date by which the received material must be consumed or disposed of. Used for FEFO (First Expired First Out) inventory rotation and shelf-life management.',
    `goods_receipt_status` STRING COMMENT 'The goods receipt status of the goods receipt record',
    `gr_document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction. Used for audit trails, supplier communication, and three-way match processing.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed (cancelled). True means the inventory posting has been negated due to return-to-vendor or data correction.',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt. Indicates whether the receipt is active, has been reversed, or is awaiting quality inspection clearance.. Valid values are `posted|reversed|cancelled|pending_inspection|blocked`',
    `inspection_lot_number` STRING COMMENT 'The unique identifier for the quality inspection lot created for this goods receipt. Links to QM inspection results and certificate of analysis.. Valid values are `^[A-Z0-9]{12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was last updated. Used for change tracking and audit trails.',
    `lot_number` STRING COMMENT 'The lot number of the goods receipt record',
    `manufacturing_date` DATE COMMENT 'The date on which the material was produced by the supplier. Used for shelf-life calculation and quality assurance.',
    `material_code` STRING COMMENT 'The unique identifier for the raw material, packaging component, or indirect good that was received. Links to material master data.. Valid values are `^[A-Z0-9]{18}$`',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the nature of the goods receipt transaction (e.g., 101 for GR against PO, 122 for return delivery). Determines inventory and financial posting logic.. Valid values are `^[0-9]{3}$`',
    `goods_receipt_name` STRING COMMENT 'The goods receipt name of the goods receipt record',
    `notes` STRING COMMENT 'The notes of the goods receipt record',
    `otif_compliance_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt met the On Time In Full criteria (received on or before requested date with full ordered quantity). Used for supplier performance scorecards.',
    `posting_date` DATE COMMENT 'The business date on which the goods receipt was posted to inventory. This is the principal business event timestamp for inventory valuation and OTIF measurement.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released for use. True triggers QM workflow and blocks stock until clearance.',
    `quality_status` STRING COMMENT 'The quality status of the goods receipt record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the goods receipt record',
    `receipt_date` DATE COMMENT 'The receipt date of the goods receipt record',
    `receipt_number` STRING COMMENT 'The receipt number of the goods receipt record',
    `receipt_status` STRING COMMENT 'The receipt status of the goods receipt record',
    `received_quantity` DECIMAL(18,2) COMMENT 'The physical quantity of goods received and accepted into inventory. This is the principal quantitative fact for this transaction.',
    `receiving_plant_code` STRING COMMENT 'The manufacturing plant or distribution center where the goods were physically received. Aligns with organizational hierarchy and inventory segmentation.. Valid values are `^[A-Z0-9]{4}$`',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'The rejected quantity of the goods receipt record',
    `remarks` STRING COMMENT 'Free-text field for capturing additional notes, exceptions, or special handling instructions related to this goods receipt. Used for operational communication and audit context.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversing goods receipt transaction, if this receipt was cancelled. Links to the offsetting inventory movement.. Valid values are `^[A-Z0-9]{10}$`',
    `reversal_reason_code` STRING COMMENT 'The business reason why this goods receipt was reversed. Used for root cause analysis and process improvement.. Valid values are `quality_reject|quantity_discrepancy|damaged|wrong_material|duplicate_posting|administrative_error`',
    `source_system_code` STRING COMMENT 'The source system code of the goods receipt record',
    `storage_location_code` STRING COMMENT 'The specific storage location or warehouse zone within the receiving plant where goods were placed. Used for inventory positioning and picking optimization.. Valid values are `^[A-Z0-9]{4}$`',
    `sustainable_sourcing_certification` STRING COMMENT 'The sustainability certification standard under which the received material was sourced (e.g., FSC for paper/packaging, RSPO for palm oil). Supports ESG reporting and sustainable sourcing initiatives.. Valid values are `FSC|RSPO|none`',
    `unit_of_measure` STRING COMMENT 'The unit in which the received quantity is expressed (e.g., KG for kilograms, EA for each, L for liters). Must align with material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'The per-unit price used for inventory valuation at the time of goods receipt. May be standard cost, moving average price, or PO price depending on valuation method.',
    `uom` STRING COMMENT 'The uom of the goods receipt record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the goods receipt record',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total inventory value of the received goods in the company currency, calculated as received quantity multiplied by standard or moving average price. Used for financial posting and COGS calculation.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Goods receipt (GR) event recorded when raw materials, packaging, or indirect goods are physically received at a plant or distribution center against a purchase order. Captures GR document number, posting date, receiving plant, storage location, received quantity per line, unit of measure, batch number, FEFO expiry date, quality inspection flag, movement type, and GR status. Triggers inventory update and three-way match process. Supports GR reversal and return-to-vendor scenarios.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoices are allocated to cost centers for expense tracking; required by internal budgeting controls.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices must map to a GL account for posting; essential for financial consolidation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center allocation of supplier invoices supports profitability analysis of purchased goods.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice was issued.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to regulatory.sds. Business justification: Invoices for regulated chemicals must reference the SDS to support audit trails and tax compliance.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who issued this invoice.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier invoices are issued from a specific supplier site (billing location). Adding supplier_site_id to supplier_invoice enables site-level invoice tracking, supports multi-site supplier billing rec',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supplier invoice record',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the invoice for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was approved for payment.',
    `baseline_date` DATE COMMENT 'The baseline date used for calculating payment due date and cash discount periods.',
    `blocking_reason_code` STRING COMMENT 'Code indicating why the invoice is blocked from payment, if applicable. Empty if not blocked.',
    `blocking_reason_description` STRING COMMENT 'Detailed description of the reason the invoice is blocked from payment.',
    `cash_discount_days` STRING COMMENT 'The number of days within which payment must be made to qualify for the cash discount.',
    `cash_discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount available for early payment per payment terms.',
    `supplier_invoice_code` STRING COMMENT 'The supplier invoice code of the supplier invoice record',
    `company_code` STRING COMMENT 'The company code within the ERP system that is responsible for this invoice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts.. Valid values are `^[A-Z]{3}$`',
    `supplier_invoice_description` STRING COMMENT 'The supplier invoice description of the supplier invoice record',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts.',
    `due_date` DATE COMMENT 'The due date of the supplier invoice record',
    `effective_from` DATE COMMENT 'The effective from of the supplier invoice record',
    `effective_until` DATE COMMENT 'The effective until of the supplier invoice record',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted.',
    `goods_receipt_date` DATE COMMENT 'The date goods were received or services were confirmed, used for three-way match validation.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and adjustments.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'The invoice amount of the supplier invoice record',
    `invoice_date` DATE COMMENT 'The date the supplier issued the invoice. This is the principal business event timestamp for the invoice.',
    `invoice_description` STRING COMMENT 'Free-text description or notes about the invoice provided by the supplier or entered during processing.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the supplier. This is the externally-known identifier for the invoice.',
    `invoice_receipt_date` DATE COMMENT 'The date the invoice was received by the organization.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|paid|blocked|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice type indicating the nature of the transaction.. Valid values are `standard|credit_memo|debit_memo|prepayment|final|proforma`',
    `line_item_count` STRING COMMENT 'Total number of line items included in this invoice.',
    `match_status` STRING COMMENT 'The match status of the supplier invoice record',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the invoice record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last modified.',
    `supplier_invoice_name` STRING COMMENT 'The supplier invoice name of the supplier invoice record',
    `net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount payable after taxes and discounts. This is the final amount due to the supplier.',
    `notes` STRING COMMENT 'The notes of the supplier invoice record',
    `payment_date` DATE COMMENT 'The actual date payment was made to the supplier.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the supplier per payment terms.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the supplier.. Valid values are `wire_transfer|ach|check|credit_card|edi|other`',
    `payment_reference_number` STRING COMMENT 'Reference number assigned when payment is made, linking the invoice to the payment transaction.',
    `payment_status` STRING COMMENT 'The payment status of the supplier invoice record',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the supplier (e.g., Net 30, Net 60, 2/10 Net 30).',
    `plant_code` STRING COMMENT 'The plant or facility code where goods were received or services were rendered.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial accounting system.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supplier invoice record',
    `source_system_code` STRING COMMENT 'The source system code of the supplier invoice record',
    `supplier_invoice_status` STRING COMMENT 'The supplier invoice status of the supplier invoice record',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match validation comparing purchase order, goods receipt, and invoice at header level.. Valid values are `matched|variance_within_tolerance|variance_exceeds_tolerance|not_matched|bypassed`',
    `tolerance_check_result` STRING COMMENT 'Indicates whether the invoice passed tolerance checks for price and quantity variances.. Valid values are `passed|failed|not_applicable`',
    `uom` STRING COMMENT 'The uom of the supplier invoice record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supplier invoice record',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment per regulatory requirements.',
    `withholding_tax_code` STRING COMMENT 'Code representing the withholding tax type and rate applied.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the invoice record in the system.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier invoice received for goods or services delivered against a purchase order. Captures invoice header (supplier-assigned number, invoice date, posting date, gross amount, tax amount, currency, payment due date, three-way match status, tolerance check result, blocking reason, processing status) and invoice line items (referenced PO line, material/service description, invoiced quantity, unit price, line amount, tax code, line-level match status). Supports granular three-way match (PO vs GR vs invoice) at both header and line level. Feeds accounts payable and COGS allocation. Owns all line-level detail as embedded attributes.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Primary key for invoice_line',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt line that this invoice line matches against. Enables three-way match verification between PO, GR, and invoice.',
    `material_id` BIGINT COMMENT 'Reference to the material master record for the invoiced item. Links to the product or raw material being purchased.',
    `po_line_id` BIGINT COMMENT 'Reference to the purchase order line that this invoice line corresponds to. Critical for three-way match validation (PO vs GR vs Invoice).',
    `supplier_invoice_id` BIGINT COMMENT 'Reference to the parent supplier invoice header. Links this line item to the overall invoice document.',
    `service_entry_sheet_line_id` BIGINT COMMENT 'Reference to the service entry sheet line for service-based invoices. Used when the invoice line corresponds to a service rather than a material.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the invoice line record',
    `amount_variance` DECIMAL(18,2) COMMENT 'Total amount variance for this line calculated as the difference between invoiced amount and expected amount based on PO and GR.',
    `batch_number` STRING COMMENT 'Batch or lot number for the material on this invoice line. Critical for quality traceability, recall management, and FEFO inventory management.',
    `blocking_reason` STRING COMMENT 'Reason code or description explaining why this invoice line is blocked from payment. Common reasons include price variance, quantity variance, or missing goods receipt.',
    `invoice_line_code` STRING COMMENT 'The invoice line code of the invoice line record',
    `cost_center_code` STRING COMMENT 'Cost center to which this invoice line expense is allocated. Used for internal cost tracking and management reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code indicating where the material was manufactured or produced. Required for customs, trade compliance, and sustainable sourcing reporting. [ENUM-REF-CANDIDATE: USA|CHN|DEU|IND|BRA|MEX|CAN|GBR|FRA|ITA|JPN|KOR|THA|VNM|POL|ESP — 16 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice line. Must match the invoice header currency. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|CAD|AUD|BRL|MXN — 10 candidates stripped; promote to reference product]',
    `delivery_note_number` STRING COMMENT 'Supplier delivery note or packing slip number referenced on this invoice line. Used for traceability and dispute resolution.',
    `invoice_line_description` STRING COMMENT 'The invoice line description of the invoice line record',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute discount amount applied to this invoice line. Alternative to or in addition to discount_percentage.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Line-level discount percentage applied by the supplier. Reduces the net amount before tax calculation.',
    `effective_from` DATE COMMENT 'The effective from of the invoice line record',
    `effective_until` DATE COMMENT 'The effective until of the invoice line record',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for the material batch. Essential for FEFO inventory rotation and regulatory compliance in consumer goods.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this invoice line amount will be posted. Determines the financial classification for COGS, expense, or asset capitalization.',
    `invoice_line_status` STRING COMMENT 'The invoice line status of the invoice line record',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units invoiced on this line. Used for three-way match comparison against PO quantity and GR quantity.',
    `line_amount` DECIMAL(18,2) COMMENT 'The line amount of the invoice line record',
    `line_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount for this invoice line including taxes and charges. Sum of line_net_amount and line_tax_amount.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net amount for this invoice line before taxes and charges. Typically calculated as invoiced_quantity multiplied by unit_price, adjusted for any line-level discounts.',
    `line_number` STRING COMMENT 'Sequential line item number within the invoice. Determines the ordering and position of this line in the invoice document.',
    `line_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this invoice line. Calculated based on the tax code and net amount.',
    `line_text` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this invoice line. May include supplier remarks or internal annotations.',
    `match_status` STRING COMMENT 'Three-way match status for this invoice line. Indicates whether the line matches the PO and GR within acceptable tolerance thresholds.. Valid values are `matched|quantity_variance|price_variance|unmatched|blocked|approved`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Tracks changes for audit trail and data quality monitoring.',
    `invoice_line_name` STRING COMMENT 'The invoice line name of the invoice line record',
    `notes` STRING COMMENT 'The notes of the invoice line record',
    `payment_terms_code` STRING COMMENT 'Payment terms applicable to this invoice line if different from header-level terms. Defines due date calculation and early payment discount eligibility.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code where the material is received or consumed. Links procurement to manufacturing and supply chain operations.',
    `price_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced unit price and PO unit price. Used to identify pricing discrepancies and trigger approval workflows.',
    `profit_center_code` STRING COMMENT 'Profit center assignment for this invoice line. Enables profitability analysis at the business unit or product line level.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the invoice line record',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced quantity and goods receipt quantity. Positive values indicate over-invoicing; negative values indicate under-invoicing.',
    `sds_document_number` STRING COMMENT 'Reference number for the Safety Data Sheet associated with this material. Required for hazardous materials and chemical ingredients per OSHA and REACH regulations.',
    `source_system_code` STRING COMMENT 'The source system code of the invoice line record',
    `storage_location_code` STRING COMMENT 'Specific storage location within the plant where the material is stored. Provides granular inventory tracking.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical sourcing certification applicable to this material. Examples include FSC for paper/packaging, RSPO for palm oil, or organic certifications.. Valid values are `FSC|RSPO|FAIRTRADE|ORGANIC|RAINFOREST_ALLIANCE|NONE`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount of the invoice line record',
    `tax_code` STRING COMMENT 'Tax jurisdiction and rate code applied to this invoice line. Determines the tax calculation method and rate percentage.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to this line. Derived from the tax code configuration.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity. Must match the UOM on the corresponding PO line and goods receipt for proper three-way match. [ENUM-REF-CANDIDATE: EA|KG|LB|L|GAL|M|FT|BOX|CASE|PALLET|EACH|TON|MT — 13 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure as stated on the invoice line. Compared against PO unit price during invoice verification to identify price variances.',
    `uom` STRING COMMENT 'The uom of the invoice line record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the invoice line record',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from this invoice line payment. Reduces the net payment to the supplier.',
    `withholding_tax_code` STRING COMMENT 'Withholding tax code for this invoice line. Applicable in jurisdictions requiring tax withholding at source for certain supplier payments.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on a supplier invoice corresponding to specific PO lines or service entry sheets. Captures invoice line number, referenced PO line, material/service description, invoiced quantity, unit price, line amount, tax code, and line-level match status. Enables granular three-way match (PO line vs GR line vs invoice line) and supports COGS allocation at the material level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'Unique identifier for the supplier scorecard record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement professional or category manager who conducted the scorecard evaluation.',
    `spend_category_id` BIGINT COMMENT 'Reference to the procurement category or commodity group this supplier primarily serves, used for category-level benchmarking.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being evaluated in this scorecard.',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan or performance improvement plan is required based on scorecard results.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supplier scorecard record',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the scorecard was formally approved and published.',
    `supplier_scorecard_code` STRING COMMENT 'The supplier scorecard code of the supplier scorecard record',
    `comments` STRING COMMENT 'Free-text commentary providing qualitative context, notable achievements, concerns, or recommendations for supplier relationship management.',
    `cost_competitiveness_score` DECIMAL(18,2) COMMENT 'Score evaluating supplier pricing competitiveness relative to market benchmarks and alternative suppliers.',
    `cost_score` DECIMAL(18,2) COMMENT 'The cost score of the supplier scorecard record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this scorecard record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary values in this scorecard.. Valid values are `^[A-Z]{3}$`',
    `delivery_score` DECIMAL(18,2) COMMENT 'The delivery score of the supplier scorecard record',
    `supplier_scorecard_description` STRING COMMENT 'The supplier scorecard description of the supplier scorecard record',
    `effective_from` DATE COMMENT 'The effective from of the supplier scorecard record',
    `effective_until` DATE COMMENT 'The effective until of the supplier scorecard record',
    `evaluation_period` STRING COMMENT 'The evaluation period of the supplier scorecard record',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period covered by this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period covered by this scorecard.',
    `innovation_collaboration_score` DECIMAL(18,2) COMMENT 'Score evaluating supplier contribution to new product development, process improvements, and collaborative innovation initiatives.',
    `invoice_accuracy_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of invoices submitted without errors requiring correction or dispute during the evaluation period.',
    `invoice_accuracy_score` DECIMAL(18,2) COMMENT 'Normalized score for invoice accuracy performance, weighted to contribute to overall score.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this scorecard record was last updated.',
    `supplier_scorecard_name` STRING COMMENT 'The supplier scorecard name of the supplier scorecard record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next supplier performance review and scorecard generation.',
    `notes` STRING COMMENT 'The notes of the supplier scorecard record',
    `otif_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on time and in full during the evaluation period. Key supply chain reliability metric.',
    `otif_pct` DECIMAL(18,2) COMMENT 'The otif pct of the supplier scorecard record',
    `otif_score` DECIMAL(18,2) COMMENT 'Normalized score for OTIF performance, typically weighted and scaled to contribute to overall weighted score.',
    `overall_score` DECIMAL(18,2) COMMENT 'The overall score of the supplier scorecard record',
    `overall_weighted_score` DECIMAL(18,2) COMMENT 'Composite weighted score aggregating all KPI scores, typically on a 0-100 scale. Primary metric for supplier performance ranking.',
    `performance_tier` STRING COMMENT 'Classification tier assigned based on overall score and KPI performance, determining supplier relationship management strategy.. Valid values are `strategic|preferred|approved|conditional|at_risk`',
    `period_end_date` DATE COMMENT 'The period end date of the supplier scorecard record',
    `period_start_date` DATE COMMENT 'The period start date of the supplier scorecard record',
    `prior_period_overall_score` DECIMAL(18,2) COMMENT 'Overall weighted score from the previous evaluation period, used for trend analysis and performance tracking.',
    `quality_rejection_rate_ppm` DECIMAL(18,2) COMMENT 'Defect rate measured in parts per million, indicating the number of rejected units per million units received. Critical quality metric.',
    `quality_score` DECIMAL(18,2) COMMENT 'Normalized score for quality performance based on rejection rates and quality incidents, weighted to contribute to overall score.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supplier scorecard record',
    `rating_grade` STRING COMMENT 'The rating grade of the supplier scorecard record',
    `recommended_action` STRING COMMENT 'Strategic recommendation for supplier relationship management based on scorecard results: maintain current relationship, develop capabilities, monitor closely, escalate issues, or delist supplier.. Valid values are `maintain|develop|monitor|escalate|delist`',
    `regulatory_adherence_score` DECIMAL(18,2) COMMENT 'Score evaluating supplier compliance with regulatory requirements including SDS documentation, GMP standards, FDA regulations, EPA requirements, and REACH compliance.',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Score evaluating supplier responsiveness to inquiries, requests for quotation, change orders, and issue resolution. Based on response time and communication quality.',
    `scorecard_date` DATE COMMENT 'The scorecard date of the supplier scorecard record',
    `scorecard_number` STRING COMMENT 'Business identifier for the supplier scorecard, typically following format SC-YYYYMMDD or similar.. Valid values are `^SC-[0-9]{8}$`',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard indicating its approval and publication state.. Valid values are `draft|published|under_review|approved|archived`',
    `service_score` DECIMAL(18,2) COMMENT 'The service score of the supplier scorecard record',
    `source_system_code` STRING COMMENT 'The source system code of the supplier scorecard record',
    `supplier_scorecard_status` STRING COMMENT 'The supplier scorecard status of the supplier scorecard record',
    `sustainability_compliance_score` DECIMAL(18,2) COMMENT 'Score evaluating supplier adherence to sustainability requirements including FSC certification, RSPO compliance, environmental standards, and ethical sourcing practices.',
    `total_po_count` STRING COMMENT 'Total number of purchase orders issued to this supplier during the evaluation period.',
    `total_purchase_value` DECIMAL(18,2) COMMENT 'Total monetary value of purchases from this supplier during the evaluation period, used for spend-weighted analysis.',
    `trend_vs_prior_period` STRING COMMENT 'Directional indicator showing whether overall performance improved, declined, or remained stable compared to the previous evaluation period.. Valid values are `improved|declined|stable|new_supplier`',
    `uom` STRING COMMENT 'The uom of the supplier scorecard record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supplier scorecard record',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Periodic supplier performance scorecard evaluating suppliers across key procurement KPIs: OTIF delivery rate, quality rejection rate (defect PPM), invoice accuracy, responsiveness, sustainability compliance, and regulatory adherence. Captures scorecard period, overall weighted score, individual KPI scores, trend vs prior period, scorecard status, and recommended action (maintain/develop/escalate/delist). Supports strategic supplier relationship management, sourcing decisions, and category reviews.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Unique identifier for the sourcing event. Primary key.',
    `employee_id` BIGINT COMMENT 'The owner employee id of the sourcing event record',
    `primary_sourcing_employee_id` BIGINT COMMENT 'Identifier of the procurement professional or category manager responsible for managing this sourcing event.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Project‑Driven Sourcing links each sourcing event to the R&D project it aims to support.',
    `spend_category_id` BIGINT COMMENT 'The spend category id of the sourcing event record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sourcing event record',
    `approval_date` DATE COMMENT 'Date when the sourcing event was approved by the appropriate authority.',
    `approval_status` STRING COMMENT 'Approval status of the sourcing event by procurement leadership or governance committee: pending (awaiting approval), approved (authorized to proceed), or rejected (not authorized).. Valid values are `pending|approved|rejected`',
    `award_date` DATE COMMENT 'Date when the sourcing event was awarded to the winning supplier(s). Null until award decision is made.',
    `awarded_savings_amount` DECIMAL(18,2) COMMENT 'Actual savings amount achieved based on awarded supplier bids compared to baseline spend. Null until event is awarded.',
    `awarded_supplier_count` STRING COMMENT 'The awarded supplier count of the sourcing event record',
    `baseline_spend_amount` DECIMAL(18,2) COMMENT 'Historical or current annual spend amount for the commodity or category being sourced, used as the baseline for calculating savings. Expressed in the reporting currency.',
    `bid_close_date` DATE COMMENT 'Date when the bidding window closes and no further supplier responses are accepted.',
    `bid_open_date` DATE COMMENT 'Date when the bidding window opens and suppliers can begin submitting responses.',
    `sourcing_event_code` STRING COMMENT 'The sourcing event code of the sourcing event record',
    `commodity_category` STRING COMMENT 'Primary commodity or material category being sourced (e.g., Raw Materials - Palm Oil, Packaging - Plastic Bottles, Indirect - MRO Supplies). Aligns with procurement category taxonomy.',
    `competitive_bidding_flag` BOOLEAN COMMENT 'Indicates whether this sourcing event involves competitive bidding among multiple suppliers (true) or is a sole-source/single-source procurement (false).',
    `contract_end_date` DATE COMMENT 'Planned or actual end date for the contract resulting from this sourcing event.',
    `contract_start_date` DATE COMMENT 'Planned or actual start date for the contract resulting from this sourcing event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this sourcing event (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `sourcing_event_description` STRING COMMENT 'The sourcing event description of the sourcing event record',
    `effective_from` DATE COMMENT 'The effective from of the sourcing event record',
    `effective_until` DATE COMMENT 'The effective until of the sourcing event record',
    `end_date` DATE COMMENT 'The end date of the sourcing event record',
    `estimated_value` DECIMAL(18,2) COMMENT 'The estimated value of the sourcing event record',
    `event_description` STRING COMMENT 'Detailed description of the sourcing event scope, objectives, requirements, and any special terms or conditions communicated to suppliers.',
    `event_name` STRING COMMENT 'Descriptive name of the sourcing event, typically including the commodity or category being sourced (e.g., Q2 2024 Packaging Materials RFQ, Annual Palm Oil Sourcing).',
    `event_number` STRING COMMENT 'Business identifier for the sourcing event, typically formatted as SE-YYYYNNNN for external reference and communication with suppliers.. Valid values are `^SE-[0-9]{8}$`',
    `event_outcome` STRING COMMENT 'Final outcome of the sourcing event: awarded (supplier selected), no_award (no suitable bids), cancelled (event terminated), extended (timeline extended), or rebid (reissued).. Valid values are `awarded|no_award|cancelled|extended|rebid`',
    `event_status` STRING COMMENT 'Current lifecycle status of the sourcing event: draft (being prepared), published (sent to suppliers), open (accepting bids), closed (bidding ended), awarded (supplier selected), or cancelled.. Valid values are `draft|published|open|closed|awarded|cancelled`',
    `event_type` STRING COMMENT 'Type of sourcing event mechanism used: RFQ (Request for Quotation), RFP (Request for Proposal), RFI (Request for Information), reverse auction, e-auction, negotiation, sole-source justification, or single-source. [ENUM-REF-CANDIDATE: rfq|rfp|rfi|reverse_auction|e_auction|negotiation|sole_source|single_source — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing event record was last updated or modified.',
    `sourcing_event_name` STRING COMMENT 'The sourcing event name of the sourcing event record',
    `notes` STRING COMMENT 'The notes of the sourcing event record',
    `procurement_organization` STRING COMMENT 'Procurement organization or business unit conducting the sourcing event (e.g., Global Procurement, Regional Procurement - EMEA, Category Management - Raw Materials).',
    `publish_date` DATE COMMENT 'Date when the sourcing event was published and made available to invited suppliers.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sourcing event record',
    `risk_category` STRING COMMENT 'Risk classification of the sourcing event based on supply continuity, financial exposure, regulatory compliance, and business impact: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `sole_source_justification` STRING COMMENT 'Business justification for sole-source or single-source procurement when competitive bidding is not used. Required for audit and compliance purposes.',
    `source_system_code` STRING COMMENT 'The source system code of the sourcing event record',
    `sourcing_event_status` STRING COMMENT 'The sourcing event status of the sourcing event record',
    `start_date` DATE COMMENT 'The start date of the sourcing event record',
    `strategic_initiative_flag` BOOLEAN COMMENT 'Indicates whether this sourcing event is part of a strategic procurement initiative or transformation program (e.g., supplier consolidation, dual sourcing, regionalization).',
    `suppliers_awarded_count` STRING COMMENT 'Number of suppliers awarded business as a result of this sourcing event. May be greater than 1 for multi-award scenarios.',
    `suppliers_invited_count` STRING COMMENT 'Total number of suppliers invited to participate in the sourcing event.',
    `suppliers_participated_count` STRING COMMENT 'Number of suppliers who submitted bids or responses to the sourcing event.',
    `sustainability_criteria` STRING COMMENT 'Description of specific sustainability requirements or certifications required for this sourcing event (e.g., FSC-certified packaging, RSPO-certified palm oil, carbon-neutral shipping).',
    `sustainability_requirement_flag` BOOLEAN COMMENT 'Indicates whether this sourcing event includes mandatory sustainability criteria such as FSC certification, RSPO compliance, or other environmental/social governance requirements.',
    `target_savings_amount` DECIMAL(18,2) COMMENT 'Target cost savings or cost avoidance amount that the sourcing event aims to achieve, expressed in the reporting currency.',
    `uom` STRING COMMENT 'The uom of the sourcing event record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sourcing event record',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Strategic sourcing event or category review initiative managing the end-to-end sourcing process for a commodity or spend category. Captures event name, commodity category, spend category reference, event type (RFQ/reverse auction/e-auction/negotiation/sole-source justification), event owner, target savings, baseline spend, awarded savings, event timeline, number of suppliers invited/participated, and event outcome status. Supports category management, procurement savings tracking, and strategic sourcing governance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'Primary key for spend_category',
    `employee_id` BIGINT COMMENT 'Employee identifier of the procurement category manager responsible for strategy, supplier relationships, and performance for this category.',
    `parent_spend_category_id` BIGINT COMMENT 'The parent spend category id of the spend category record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the spend category record',
    `annual_spend` DECIMAL(18,2) COMMENT 'The annual spend of the spend category record',
    `annual_spend_budget_amount` DECIMAL(18,2) COMMENT 'Planned annual procurement spend budget for this category in base currency (USD). Used for budget tracking and variance analysis.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the spend category in procurement systems. Used as the business identifier for category classification and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the spend category scope, including materials, services, and goods covered under this classification.',
    `category_level` STRING COMMENT 'Hierarchical level of the category in the spend taxonomy (L1=top level, L2=sub-category, L3=detailed category, L4=granular classification).. Valid values are `L1|L2|L3|L4`',
    `category_name` STRING COMMENT 'Full descriptive name of the spend category (e.g., Surfactants, Primary Packaging, MRO Supplies).',
    `category_status` STRING COMMENT 'Current lifecycle status of the spend category in the procurement taxonomy (active=in use, inactive=deprecated, under_review=being evaluated, consolidating=merging with other categories, phasing_out=being eliminated).. Valid values are `active|inactive|under_review|consolidating|phasing_out`',
    `spend_category_code` STRING COMMENT 'The spend category code of the spend category record',
    `commodity_type` STRING COMMENT 'High-level classification of the commodity type covered by this category (raw materials, packaging, maintenance/repair/operations, capital expenditure, indirect services, logistics, professional services). [ENUM-REF-CANDIDATE: raw_material|packaging|mro|capex|indirect_service|logistics|professional_service — 7 candidates stripped; promote to reference product]',
    `contract_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of category spend covered by formal contracts or pricing agreements (0-100). Higher coverage indicates better spend management.',
    `cost_savings_target_percentage` DECIMAL(18,2) COMMENT 'Annual cost reduction target for this category as a percentage of baseline spend. Used for procurement performance management.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this category record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend category record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for spend budget and reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `spend_category_description` STRING COMMENT 'The spend category description of the spend category record',
    `effective_end_date` DATE COMMENT 'Date when this category classification is no longer effective. Null for currently active categories.',
    `effective_from` DATE COMMENT 'The effective from of the spend category record',
    `effective_start_date` DATE COMMENT 'Date when this category classification became effective in the procurement taxonomy.',
    `effective_until` DATE COMMENT 'The effective until of the spend category record',
    `is_direct_spend` BOOLEAN COMMENT 'The is direct spend of the spend category record',
    `is_strategic` BOOLEAN COMMENT 'The is strategic of the spend category record',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this category record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend category record was last updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent category strategy review and performance assessment.',
    `lead_time_days_typical` STRING COMMENT 'Average procurement lead time in days for materials in this category from purchase order to goods receipt.',
    `material_group` STRING COMMENT 'Material group classification from ERP system (SAP MM material group) for raw materials and packaging components.',
    `moq_applicable_flag` BOOLEAN COMMENT 'Indicates whether minimum order quantity constraints typically apply to materials in this category.',
    `spend_category_name` STRING COMMENT 'The spend category name of the spend category record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next category strategy review and supplier performance evaluation.',
    `notes` STRING COMMENT 'The notes of the spend category record',
    `preferred_sourcing_strategy` STRING COMMENT 'Recommended sourcing approach for this category (single source, dual source, multi-source, spot buy, strategic partnership, vendor managed inventory, consignment). [ENUM-REF-CANDIDATE: single_source|dual_source|multi_source|spot_buy|strategic_partnership|vmi|consignment — 7 candidates stripped; promote to reference product]',
    `procurement_organization` STRING COMMENT 'Procurement organizational unit responsible for managing this category (e.g., Global Procurement, Regional Procurement EMEA, Direct Materials Procurement).',
    `purchasing_group` STRING COMMENT 'Three-character purchasing group code from ERP system responsible for operational procurement activities in this category.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the spend category record',
    `regulatory_framework` STRING COMMENT 'Comma-separated list of applicable regulatory frameworks governing materials in this category (e.g., REACH, FDA CFR 21, RSPO, FSC, ISO 22716). [ENUM-REF-CANDIDATE: REACH|FDA|RSPO|FSC|ISO_22716|GMP|IFRA|EPA|CPSC — promote to reference product]',
    `risk_profile` STRING COMMENT 'Supply risk assessment for this category considering supplier concentration, market volatility, geopolitical factors, and regulatory complexity.. Valid values are `high_risk|medium_risk|low_risk`',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether materials in this category require Safety Data Sheet documentation for regulatory compliance and workplace safety.',
    `source_system_code` STRING COMMENT 'The source system code of the spend category record',
    `spend_category_status` STRING COMMENT 'The spend category status of the spend category record',
    `spend_visibility_level` STRING COMMENT 'Classification of spend data visibility and tracking maturity for this category (high=fully tracked and managed, medium=partially tracked, low=limited visibility).. Valid values are `high|medium|low`',
    `strategic_importance` STRING COMMENT 'Business criticality classification of this category to operations and product quality (critical=business-critical materials, strategic=high-value/high-risk, tactical=moderate importance, non-critical=low impact).. Valid values are `critical|strategic|tactical|non_critical`',
    `supplier_consolidation_target` STRING COMMENT 'Target number of preferred suppliers for this category as part of supplier rationalization strategy.',
    `sustainable_sourcing_flag` BOOLEAN COMMENT 'Indicates whether this category is subject to sustainable sourcing requirements (e.g., FSC-certified paper, RSPO-certified palm oil, conflict-free minerals).',
    `unspsc_code` STRING COMMENT 'Eight-digit UNSPSC code for global commodity classification alignment and cross-industry spend benchmarking.. Valid values are `^[0-9]{8}$`',
    `uom` STRING COMMENT 'The uom of the spend category record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the spend category record',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Hierarchical classification taxonomy for procurement spend categories covering raw materials (oils, surfactants, fragrances, actives, excipients), primary and secondary packaging, MRO, capex, and indirect services. Captures category code, category name, parent category, category level (L1/L2/L3/L4), commodity type, applicable regulatory frameworks (REACH, FDA, RSPO), preferred sourcing strategy, and category owner. Enables spend analytics, category management, and compliance reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` (
    `approved_supplier_list_id` BIGINT COMMENT 'Unique identifier for the approved supplier list entry. Primary key for the ASL record.',
    `employee_id` BIGINT COMMENT 'The approved by employee id of the approved supplier list record',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Project‑Specific Approved Supplier List ensures only vetted suppliers are used for a given R&D project.',
    `spend_category_id` BIGINT COMMENT 'The spend category id of the approved supplier list record',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the master purchasing contract or framework agreement governing this supplier-material relationship. Links to contract management system.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier authorized to supply materials or services. Links to the supplier master record.',
    `supplier_qualification_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_qualification. Business justification: An ASL entry is formally backed by a supplier qualification/audit record. Adding supplier_qualification_id links the approval decision to the specific qualification assessment that authorized the supp',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: ASL entries are typically site-specific — a supplier may be approved for supply from one manufacturing site but not another. Adding supplier_site_id allows the ASL to specify which physical site of th',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the approved supplier list record',
    `approval_authority` STRING COMMENT 'Name or role of the person or committee who authorized the supplier approval. Provides accountability and audit trail.',
    `approval_basis` STRING COMMENT 'Method or evidence used to grant supplier approval. Audit = on-site supplier audit; Certification = third-party certification (ISO, FSC, RSPO); Qualification test = material sample testing; Performance review = historical performance analysis; Risk assessment = supply chain risk evaluation; Legacy approval = pre-existing authorization.. Valid values are `audit|certification|qualification_test|performance_review|risk_assessment|legacy_approval`',
    `approval_date` DATE COMMENT 'Date when the supplier was approved for this material-plant combination. Represents the effective start of authorization.',
    `approval_expiration_date` DATE COMMENT 'Date when the current approval expires and requires re-evaluation. Null indicates indefinite approval subject to periodic review.',
    `approval_status` STRING COMMENT 'Current authorization status of the supplier for this material-plant combination. Approved = full authorization; Conditional = approved with restrictions; Blocked = temporarily prohibited; Delisted = permanently removed; Pending = under evaluation; Suspended = on hold pending review.. Valid values are `approved|conditional|blocked|delisted|pending|suspended`',
    `approved_supplier_list_status` STRING COMMENT 'The approved supplier list status of the approved supplier list record',
    `blocking_date` DATE COMMENT 'Date when the supplier was blocked, delisted, or suspended. Null when status is approved, conditional, or pending.',
    `blocking_reason` STRING COMMENT 'Explanation for why the supplier is blocked, delisted, or suspended. Includes quality issues, compliance violations, delivery failures, financial instability, or ethical concerns. Null when status is approved or conditional.',
    `approved_supplier_list_code` STRING COMMENT 'The approved supplier list code of the approved supplier list record',
    `compliance_status` STRING COMMENT 'Regulatory and policy compliance status for this supplier-material combination. Compliant = meets all requirements; Non-compliant = violations identified; Under review = compliance assessment in progress; Exempted = waiver granted.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `conditional_terms` STRING COMMENT 'Specific restrictions or requirements when approval status is conditional. Examples: reduced order quantities, enhanced inspection, expedited payment terms, or geographic limitations. Null when status is not conditional.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ASL entry was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The currency code of the approved supplier list record',
    `delivery_rating` STRING COMMENT 'Supplier delivery performance rating for this material-plant combination. A = excellent (>95% OTIF); B = good (90-95% OTIF); C = acceptable (85-90% OTIF); D = marginal (80-85% OTIF); F = failing (<80% OTIF).. Valid values are `A|B|C|D|F`',
    `approved_supplier_list_description` STRING COMMENT 'The approved supplier list description of the approved supplier list record',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether electronic purchase orders and confirmations are enabled for this supplier-material-plant combination. True = EDI transactions supported; False = manual processing.',
    `effective_date` DATE COMMENT 'The effective date of the approved supplier list record',
    `effective_from` DATE COMMENT 'The effective from of the approved supplier list record',
    `effective_until` DATE COMMENT 'The effective until of the approved supplier list record',
    `expiry_date` DATE COMMENT 'The expiry date of the approved supplier list record',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming goods from this supplier-material combination require quality inspection before goods receipt posting. True = inspection mandatory; False = direct posting allowed.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit or site visit for this material-plant combination. Used to track audit currency and schedule follow-ups.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated this ASL entry. Tracks change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ASL entry was last modified. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from PO issuance to goods receipt for this supplier-material-plant combination. Used for MRP and demand planning.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this material-plant combination. Used to enforce purchasing constraints in PO creation.',
    `moq_unit` STRING COMMENT 'Unit of measure for the minimum order quantity. Examples: KG (kilograms), EA (each), LT (liters), MT (metric tons). Follows ISO 80000 or UN/CEFACT standards.. Valid values are `^[A-Z]{2,3}$`',
    `approved_supplier_list_name` STRING COMMENT 'The approved supplier list name of the approved supplier list record',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next supplier audit or site visit. Drives proactive supplier quality management.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the supplier approval, special handling instructions, historical issues, or other relevant information for procurement and quality teams.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution facility code where the supplier is authorized to deliver. Follows GS1 GLN or internal plant coding standard.. Valid values are `^[A-Z0-9]{4,10}$`',
    `preference_rank` STRING COMMENT 'The preference rank of the approved supplier list record',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred source for this material-plant combination. True = preferred supplier with priority allocation; False = approved but not preferred.',
    `price_validity_end_date` DATE COMMENT 'End date of the current pricing agreement. Null indicates open-ended pricing subject to change notification.',
    `price_validity_start_date` DATE COMMENT 'Start date of the current pricing agreement for this supplier-material-plant combination. Used to enforce valid pricing periods in PO creation.',
    `qualification_level` STRING COMMENT 'The qualification level of the approved supplier list record',
    `quality_rating` STRING COMMENT 'Supplier quality performance rating for this material-plant combination. A = excellent (>98% acceptance); B = good (95-98%); C = acceptable (90-95%); D = marginal (85-90%); F = failing (<85%). Derived from quality inspection results.. Valid values are `A|B|C|D|F`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the approved supplier list record',
    `re_evaluation_due_date` DATE COMMENT 'Scheduled date for the next supplier performance review or qualification audit. Drives proactive supplier management activities.',
    `risk_category` STRING COMMENT 'Supply chain risk classification for this supplier-material-plant combination. Low = stable supply, multiple sources; Medium = moderate dependency; High = single source or volatile region; Critical = business-critical material with supply constraints.. Valid values are `low|medium|high|critical`',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the only approved source for this material-plant combination. True = sole source (supply risk); False = multiple sources available.',
    `source_system_code` STRING COMMENT 'The source system code of the approved supplier list record',
    `sustainability_certification` STRING COMMENT 'Sustainability certifications held by the supplier for this material. Pipe-separated list of certifications: FSC (Forest Stewardship Council), RSPO (Roundtable on Sustainable Palm Oil), Fair Trade, Rainforest Alliance, B Corp, Carbon Neutral. Supports sustainable sourcing initiatives.',
    `uom` STRING COMMENT 'The uom of the approved supplier list record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the approved supplier list record',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether this supplier-material-plant combination is eligible for Vendor Managed Inventory programs. True = VMI enabled; False = traditional procurement.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this ASL entry. Provides accountability and audit trail.',
    CONSTRAINT pk_approved_supplier_list PRIMARY KEY(`approved_supplier_list_id`)
) COMMENT 'Approved Supplier List (ASL) entry defining which suppliers are authorized to supply specific materials or spend categories to specific plants. Captures material/category, supplier, plant, approval status (approved/conditional/blocked/delisted), approval date, re-evaluation due date, approval basis (audit/certification/qualification test), and blocking reason. Enforces sourcing compliance and prevents unauthorized supplier usage in PO creation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'Unique identifier for the supplier qualification record. Primary key.',
    `employee_id` BIGINT COMMENT 'The assessor employee id of the supplier qualification record',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being qualified. Links to the supplier master record.',
    `supplier_site_id` BIGINT COMMENT 'The supplier site id of the supplier qualification record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supplier qualification record',
    `approval_date` DATE COMMENT 'Date when the qualification result was formally approved by the authorized quality or procurement manager.',
    `approved_by_name` STRING COMMENT 'Name of the quality manager or procurement director who formally approved the qualification result and authorized the supplier status change.',
    `approved_material_categories` STRING COMMENT 'Comma-separated list or description of material categories or product types that the supplier is qualified to provide based on this assessment. Examples include raw materials, packaging components, finished goods, indirect materials.',
    `assessment_date` DATE COMMENT 'The assessment date of the supplier qualification record',
    `audit_date` DATE COMMENT 'Date when the qualification audit or assessment was conducted. Primary business event timestamp for the qualification activity.',
    `audit_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the audit concluded. Used to calculate total audit duration and resource allocation.',
    `audit_method` STRING COMMENT 'Method used to conduct the qualification audit. On-site for physical facility visits, remote for virtual assessments, hybrid for combination, document review for paper-based evaluation, self-assessment for supplier-submitted questionnaires.. Valid values are `on_site|remote|hybrid|document_review|self_assessment`',
    `audit_report_document_reference` STRING COMMENT 'Reference identifier for the detailed audit report document stored in the document management system. Links to the full audit findings, evidence, and supporting documentation.',
    `audit_scope` STRING COMMENT 'Description of the areas, processes, and systems covered in the qualification audit. May include manufacturing facilities, quality systems, environmental controls, documentation practices, and specific product categories.',
    `audit_score` DECIMAL(18,2) COMMENT 'The audit score of the supplier qualification record',
    `audit_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the on-site or remote audit commenced. Used for detailed audit scheduling and duration tracking.',
    `auditor_certification` STRING COMMENT 'Professional certifications held by the lead auditor, such as Certified Quality Auditor (CQA), Lead Auditor ISO 9001, or other relevant credentials.',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or assessment team leader who conducted the qualification. May be internal quality personnel or third-party auditor.',
    `auditor_organization` STRING COMMENT 'Organization or company that the auditor represents. May be internal (company name) or external third-party audit firm.',
    `certification_reference` STRING COMMENT 'The certification reference of the supplier qualification record',
    `supplier_qualification_code` STRING COMMENT 'The supplier qualification code of the supplier qualification record',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when all required corrective actions were verified as complete and closed. Null if corrective actions are still open or not required.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the supplier must complete and submit evidence of corrective actions for identified findings. Null if no corrective actions are required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier must implement corrective actions to address findings before full qualification is granted. True for conditional qualifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this qualification record was first created in the system. Audit trail for record creation.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances identified during the audit. Critical findings represent severe quality or compliance issues that pose immediate risk and typically result in failed qualification.',
    `currency_code` STRING COMMENT 'The currency code of the supplier qualification record',
    `supplier_qualification_description` STRING COMMENT 'The supplier qualification description of the supplier qualification record',
    `effective_from` DATE COMMENT 'The effective from of the supplier qualification record',
    `effective_until` DATE COMMENT 'The effective until of the supplier qualification record',
    `expiry_date` DATE COMMENT 'The expiry date of the supplier qualification record',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the supplier demonstrated compliance with Good Manufacturing Practice standards during the qualification audit. Critical for suppliers of ingredients, packaging, and finished goods in regulated consumer goods categories.',
    `iso_9001_compliant_flag` BOOLEAN COMMENT 'Indicates whether the supplier demonstrated compliance with ISO 9001 Quality Management System standards during the qualification audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this qualification record was last updated. Audit trail for record changes throughout the qualification lifecycle.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances identified during the audit. Major findings represent significant quality system gaps that require corrective action but may allow conditional qualification.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or observations identified during the audit. Minor findings represent opportunities for improvement that do not prevent qualification.',
    `supplier_qualification_name` STRING COMMENT 'The supplier qualification name of the supplier qualification record',
    `next_qualification_due_date` DATE COMMENT 'Scheduled date for the next periodic re-qualification or audit. Typically set based on qualification type and risk rating, commonly 1-3 years from current qualification.',
    `notes` STRING COMMENT 'The notes of the supplier qualification record',
    `observation_count` STRING COMMENT 'Number of general observations or recommendations noted during the audit that are not formal non-conformances but represent best practice suggestions.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numerical score representing the overall qualification assessment result, typically on a 0-100 scale. Used for supplier performance benchmarking and comparison.',
    `qualification_date` DATE COMMENT 'The qualification date of the supplier qualification record',
    `qualification_notes` STRING COMMENT 'Free-text notes and comments from the auditor regarding the qualification assessment, including strengths, concerns, special conditions, or context for the qualification decision.',
    `qualification_number` STRING COMMENT 'Business identifier for the qualification event. Externally visible reference number used in audit documentation and supplier communications.',
    `qualification_result` STRING COMMENT 'Overall outcome of the qualification assessment. Qualified indicates full approval, conditional indicates approval with corrective actions required, failed indicates supplier did not meet requirements, pending indicates assessment incomplete, not assessed indicates qualification was cancelled or not performed.. Valid values are `qualified|conditional|failed|pending|not_assessed`',
    `qualification_score` DECIMAL(18,2) COMMENT 'The qualification score of the supplier qualification record',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification process. Tracks the workflow state from scheduling through completion.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `qualification_type` STRING COMMENT 'Type of qualification assessment being performed. Initial for new supplier onboarding, periodic for scheduled re-assessments, for-cause for triggered audits due to quality issues, re-qualification for suppliers returning after suspension, pre-qualification for preliminary assessment, special for ad-hoc evaluations.. Valid values are `initial|periodic|for_cause|re_qualification|pre_qualification|special`',
    `qualification_valid_from_date` DATE COMMENT 'Effective start date of the qualification status. Date from which the supplier is considered qualified to supply materials or services.',
    `qualification_valid_until_date` DATE COMMENT 'Expiration date of the qualification status. Date after which the qualification is no longer valid and re-qualification is required. Null for indefinite qualifications pending periodic review.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supplier qualification record',
    `regulatory_compliance_verified_flag` BOOLEAN COMMENT 'Indicates whether the supplier demonstrated compliance with applicable regulatory requirements such as FDA, EPA, REACH, or other jurisdiction-specific regulations relevant to the materials or services being qualified.',
    `sds_documentation_verified_flag` BOOLEAN COMMENT 'Indicates whether the supplier provided complete and compliant Safety Data Sheets for all chemical materials and ingredients. Critical for raw material and packaging suppliers.',
    `source_system_code` STRING COMMENT 'The source system code of the supplier qualification record',
    `supplier_qualification_status` STRING COMMENT 'The supplier qualification status of the supplier qualification record',
    `sustainability_criteria_met_flag` BOOLEAN COMMENT 'Indicates whether the supplier met sustainability and responsible sourcing criteria during qualification, including certifications such as FSC, RSPO, or environmental management practices.',
    `uom` STRING COMMENT 'The uom of the supplier qualification record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supplier qualification record',
    `valid_until_date` DATE COMMENT 'The valid until date of the supplier qualification record',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Supplier qualification and audit record documenting the formal assessment of a suppliers capability, quality systems, and compliance before onboarding or re-qualification. Captures qualification type (initial/periodic/for-cause), audit date, audit scope, auditor name, audit findings count by severity (critical/major/minor), overall qualification result (qualified/conditional/failed), corrective action required flag, and next qualification due date. Supports GMP, ISO 9001, and regulatory compliance requirements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` (
    `procurement_vmi_agreement_id` BIGINT COMMENT 'Unique identifier for the VMI agreement record.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to the distribution facility in the VMI agreement',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `sku_id` BIGINT COMMENT 'The sku id of the procurement vmi agreement record',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: VMI agreements cover specific spend categories (e.g., raw materials, packaging). Adding spend_category_id normalizes the material_scope string field into a proper FK reference, enabling spend category',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: A VMI agreement is governed by an underlying supplier contract that defines the commercial terms. procurement_vmi_agreement has a contract_reference_number string field that should be replaced by a pr',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who manages inventory under this VMI agreement.',
    `supplier_site_id` BIGINT COMMENT 'Reference to the specific supplier site responsible for VMI replenishment under this agreement.',
    `vmi_agreement_type_id` BIGINT COMMENT 'The vmi agreement type id of the procurement vmi agreement record',
    `agreement_name` STRING COMMENT 'Descriptive name for the VMI agreement, typically indicating the supplier, material category, and managed location.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the VMI agreement, used in procurement documents and supplier communications.',
    `agreement_status` STRING COMMENT 'The agreement status of the procurement vmi agreement record',
    `agreement_type` STRING COMMENT 'Classification of the VMI agreement based on the category of materials managed (raw materials, packaging, indirect goods, MRO, or finished goods).. Valid values are `raw_material|packaging|indirect_goods|mro|finished_goods`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the procurement vmi agreement record',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the VMI agreement automatically renews at the end of its term unless either party provides termination notice.',
    `procurement_vmi_agreement_code` STRING COMMENT 'The procurement vmi agreement code of the procurement vmi agreement record',
    `consignment_flag` BOOLEAN COMMENT 'Indicates whether inventory under this VMI agreement is held on consignment, where the supplier retains ownership until consumption by Consumer Goods.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this VMI agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code used for pricing and payment under this VMI agreement.. Valid values are `^[A-Z]{3}$`',
    `procurement_vmi_agreement_description` STRING COMMENT 'The procurement vmi agreement description of the procurement vmi agreement record',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether EDI is used for automated exchange of VMI inventory data, replenishment orders, and consumption reports between Consumer Goods and the supplier.',
    `edi_message_types` STRING COMMENT 'The specific EDI message types used for VMI transactions (e.g., 846 Inventory Inquiry, 852 Product Activity Data, 850 Purchase Order).',
    `effective_date` DATE COMMENT 'The effective date of the procurement vmi agreement record',
    `effective_end_date` DATE COMMENT 'The date when the VMI agreement expires or is scheduled to terminate, after which the supplier is no longer responsible for inventory management.',
    `effective_from` DATE COMMENT 'The effective from of the procurement vmi agreement record',
    `effective_start_date` DATE COMMENT 'The date when the VMI agreement becomes active and the supplier begins managing inventory at the specified location.',
    `effective_until` DATE COMMENT 'The effective until of the procurement vmi agreement record',
    `expiry_date` DATE COMMENT 'The expiry date of the procurement vmi agreement record',
    `inventory_uom` STRING COMMENT 'The unit of measure used for inventory levels in this VMI agreement (e.g., kilograms, liters, pallets, cases, each).',
    `inventory_vmi_agreement_id` BIGINT COMMENT 'References authoritative SSOT record in inventory.inventory_vmi_agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this VMI agreement record was last updated or modified.',
    `managed_location_code` STRING COMMENT 'Code identifying the Consumer Goods plant, warehouse, or distribution center where the supplier manages inventory under this VMI agreement.',
    `managed_location_name` STRING COMMENT 'Name of the Consumer Goods facility where VMI inventory is managed by the supplier.',
    `max_inventory_level` DECIMAL(18,2) COMMENT 'The maximum inventory quantity allowed at the managed location, defining the upper limit for supplier replenishment to avoid overstocking.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The max stock level of the procurement vmi agreement record',
    `min_inventory_level` DECIMAL(18,2) COMMENT 'The minimum inventory quantity that must be maintained at the managed location, triggering replenishment when stock falls below this threshold.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'The min stock level of the procurement vmi agreement record',
    `procurement_vmi_agreement_name` STRING COMMENT 'The procurement vmi agreement name of the procurement vmi agreement record',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the VMI agreement, including any unique operational requirements or exceptions.',
    `ownership_transfer_trigger` STRING COMMENT 'The event that triggers transfer of inventory ownership from the supplier to Consumer Goods (e.g., goods receipt, consumption, withdrawal, invoice receipt, or time-based).. Valid values are `goods_receipt|consumption|withdrawal|invoice_receipt|time_based`',
    `payment_terms` STRING COMMENT 'The agreed payment terms for VMI inventory, specifying when payment is due after ownership transfer (e.g., Net 30, Net 60, upon consumption).',
    `performance_review_frequency` STRING COMMENT 'The frequency at which Consumer Goods and the supplier conduct formal performance reviews of the VMI agreement against SLA targets.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `procurement_vmi_agreement_status` STRING COMMENT 'Current lifecycle status of the VMI agreement indicating whether it is in draft, actively managing inventory, suspended, terminated, or expired.. Valid values are `draft|active|suspended|terminated|expired`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the procurement vmi agreement record',
    `renewal_notice_days` STRING COMMENT 'The number of days advance notice required to terminate or modify the VMI agreement before its renewal date.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The reorder point of the procurement vmi agreement record',
    `replenishment_frequency` STRING COMMENT 'The replenishment frequency of the procurement vmi agreement record',
    `replenishment_lead_time_days` STRING COMMENT 'The number of days required for the supplier to replenish inventory from order placement to delivery at the managed location.',
    `replenishment_model` STRING COMMENT 'The inventory replenishment strategy used by the supplier under this VMI agreement (min/max levels, forecast-driven, consumption-based, kanban, or continuous replenishment).. Valid values are `min_max|forecast_driven|consumption_based|kanban|continuous_replenishment`',
    `review_frequency` STRING COMMENT 'The frequency at which the supplier reviews inventory levels and triggers replenishment orders under this VMI agreement.. Valid values are `daily|weekly|biweekly|monthly|continuous`',
    `sales_vmi_agreement_id` BIGINT COMMENT 'SSOT crosslink to authoritative table',
    `sla_fill_rate_target_pct` DECIMAL(18,2) COMMENT 'The target fill rate percentage the supplier must achieve under this VMI agreement, representing the percentage of demand that must be met from available inventory.',
    `sla_otif_target_pct` DECIMAL(18,2) COMMENT 'The target OTIF percentage the supplier must achieve for VMI replenishments, measuring the percentage of deliveries that arrive on time and in full quantity.',
    `sla_stockout_tolerance_days` STRING COMMENT 'The maximum number of days per period that stockouts are tolerated under this VMI agreement before SLA penalties apply.',
    `source_system_code` STRING COMMENT 'The source system code of the procurement vmi agreement record',
    `supplier_contact_email` STRING COMMENT 'Email address of the primary supplier contact for VMI operations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `supplier_contact_name` STRING COMMENT 'Name of the primary supplier contact responsible for VMI operations and replenishment under this agreement.',
    `supplier_contact_phone` STRING COMMENT 'Phone number of the primary supplier contact for VMI operations and issue escalation.',
    `target_inventory_level` DECIMAL(18,2) COMMENT 'The optimal inventory quantity the supplier should maintain at the managed location, balancing availability and carrying costs.',
    `termination_date` DATE COMMENT 'The actual date when the VMI agreement was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'The reason for termination if the VMI agreement status is terminated, providing context for the end of the supplier-managed inventory arrangement.',
    `uom` STRING COMMENT 'The uom of the procurement vmi agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the procurement vmi agreement record',
    CONSTRAINT pk_procurement_vmi_agreement PRIMARY KEY(`procurement_vmi_agreement_id`)
) COMMENT 'Vendor Managed Inventory (VMI) agreement defining the terms under which a supplier manages and replenishes inventory of raw materials or packaging at a Consumer Goods plant or warehouse. Captures VMI agreement number, supplier, material scope, managed location, min/max inventory levels, replenishment trigger (min stock/forecast-driven), review frequency, VMI start and end dates, consignment flag, ownership transfer trigger, and VMI performance SLA. Supports lean inventory and supply continuity strategies. [SSOT] Superseded by authoritative table inventory.inventory_vmi_agreement for concept vmi_agreement. SSOT: canonical table is inventory.inventory_vmi_agreement. [SSOT for concept vmi_agreement.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` (
    `price_condition_id` BIGINT COMMENT 'Unique identifier for the price condition record. Primary key for the price condition entity.',
    `contract_line_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_line. Business justification: Price conditions in procurement are often defined at the contract line level (specific material/service within a contract). price_condition already has supplier_contract_id for the header-level link',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this price condition is applicable.',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ process that resulted in this price condition. Null for non-RFQ pricing.',
    `sku_id` BIGINT COMMENT 'Reference to the material or service for which this price condition applies.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Price conditions are defined within a spend category context (e.g., raw materials pricing, packaging pricing). Adding spend_category_id to price_condition enables category-level price analysis, benchm',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the supplier contract under which this price condition is established. Null for non-contract pricing.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the material or service under this price condition.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the price condition record',
    `approval_date` DATE COMMENT 'The date on which this price condition was formally approved.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this price condition.',
    `approved_flag` BOOLEAN COMMENT 'Indicates whether this price condition has been formally approved for use in purchase orders (True/False).',
    `calculation_type` STRING COMMENT 'Method used to calculate the condition value (fixed amount, percentage, quantity-based scale, value-based scale).. Valid values are `fixed|percentage|quantity_based|value_based`',
    `price_condition_code` STRING COMMENT 'The price condition code of the price condition record',
    `condition_class` STRING COMMENT 'High-level classification of the condition (price, discount, surcharge, freight, tax) for grouping and reporting purposes.. Valid values are `price|discount|surcharge|freight|tax`',
    `condition_record_number` STRING COMMENT 'The unique business identifier for this price condition record in the source procurement system.',
    `condition_sequence` STRING COMMENT 'The order in which this condition is applied within the pricing procedure (lower numbers applied first).',
    `condition_status` STRING COMMENT 'Current lifecycle status of the price condition (active, inactive, pending approval, expired, superseded by newer condition).. Valid values are `active|inactive|pending|expired|superseded`',
    `condition_type` STRING COMMENT 'The category of pricing element this condition represents (base price, freight, surcharge, discount, tax, rebate, duty, handling, insurance, packaging). [ENUM-REF-CANDIDATE: base_price|freight|surcharge|discount|tax|rebate|duty|handling|insurance|packaging — 10 candidates stripped; promote to reference product]',
    `condition_unit` STRING COMMENT 'The unit of measure for the condition value (e.g., per kilogram, per piece, per liter, percentage).',
    `condition_value` DECIMAL(18,2) COMMENT 'The numeric value of the price condition (price per unit, discount percentage, surcharge amount, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price condition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the condition value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `price_condition_description` STRING COMMENT 'The price condition description of the price condition record',
    `effective_from` DATE COMMENT 'The effective from of the price condition record',
    `effective_until` DATE COMMENT 'The effective until of the price condition record',
    `incoterms` STRING COMMENT 'The Incoterms rule applicable to this price condition, defining delivery and cost responsibilities (e.g., FOB, CIF, DDP).',
    `incoterms_location` STRING COMMENT 'The specific location or port associated with the Incoterms rule (e.g., FOB Shanghai, CIF New York).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this price condition record was last updated or modified.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity required for this price condition to be applicable.',
    `modified_by` STRING COMMENT 'The name or identifier of the user who last modified this price condition record.',
    `moq_uom` STRING COMMENT 'The unit of measure for the minimum order quantity (e.g., EA, KG, L).',
    `price_condition_name` STRING COMMENT 'The price condition name of the price condition record',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this price condition, including special terms, negotiation context, or usage instructions.',
    `payment_terms` STRING COMMENT 'The payment terms code associated with this price condition (e.g., Net 30, 2/10 Net 30).',
    `per_unit_quantity` DECIMAL(18,2) COMMENT 'The quantity basis for the condition value (e.g., price per 100 units, per 1000 kg).',
    `per_unit_uom` STRING COMMENT 'The unit of measure corresponding to the per unit quantity (e.g., EA, KG, L).',
    `price_condition_status` STRING COMMENT 'The price condition status of the price condition record',
    `price_determination_rule` STRING COMMENT 'The business rule or formula used to determine the final price when multiple conditions apply (e.g., lowest price, weighted average, last price).',
    `price_source` STRING COMMENT 'The origin or method by which this price condition was established (contract, RFQ, supplier catalog, negotiated, spot purchase, market index).. Valid values are `contract|rfq|catalog|negotiated|spot|market_index`',
    `price_unit` STRING COMMENT 'The price unit of the price condition record',
    `price_value` DECIMAL(18,2) COMMENT 'The price value of the price condition record',
    `pricing_procedure` STRING COMMENT 'The pricing procedure schema that determines the sequence and calculation logic for applying this condition.',
    `pricing_uom` STRING COMMENT 'The pricing uom of the price condition record',
    `purchasing_group` STRING COMMENT 'The buyer group or team responsible for managing this price condition and supplier relationship.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for procurement activities under this price condition.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the price condition record',
    `scale_basis` STRING COMMENT 'The basis for tiered pricing scales (none for flat pricing, quantity, value, weight, volume for scale-based pricing).. Valid values are `none|quantity|value|weight|volume`',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'The minimum quantity threshold for this price scale tier. Null for non-scaled pricing.',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'The maximum quantity threshold for this price scale tier. Null for open-ended tiers.',
    `scale_uom` STRING COMMENT 'The unit of measure for scale quantity thresholds (e.g., EA, KG, L).',
    `source_system_code` STRING COMMENT 'The source system code of the price condition record',
    `tax_code` STRING COMMENT 'The tax classification code applicable to this price condition for tax calculation purposes.',
    `tax_jurisdiction` STRING COMMENT 'The geographic tax jurisdiction applicable to this price condition (country, state, or local tax authority).',
    `uom` STRING COMMENT 'The uom of the price condition record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the price condition record',
    `validity_end_date` DATE COMMENT 'The date after which this price condition is no longer valid. Null for open-ended conditions.',
    `validity_start_date` DATE COMMENT 'The date from which this price condition becomes effective and can be applied to purchase orders.',
    `valid_from` DATE COMMENT 'The valid from of the price condition record',
    `valid_to` DATE COMMENT 'The valid to of the price condition record',
    CONSTRAINT pk_price_condition PRIMARY KEY(`price_condition_id`)
) COMMENT 'Procurement price conditions and pricing records maintained for materials and services sourced from suppliers, including base prices, surcharges, freight conditions, and discounts. Captures condition type (base price/freight/surcharge/discount/tax), supplier, material, plant, validity start and end dates, condition value, condition unit, scale quantity breaks, and price determination sequence. Enables accurate PO pricing, COGS calculation, and price variance analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule line. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Delivery schedule assigns a carrier to each scheduled delivery, enabling carrier performance tracking and OTIF measurement.',
    `material_id` BIGINT COMMENT 'Reference to the material (raw material, packaging component, or indirect good) being scheduled for delivery.',
    `po_line_id` BIGINT COMMENT 'The po line id of the delivery schedule record',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order or scheduling agreement to which this delivery schedule line belongs.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Project Delivery Planning schedules deliveries based on the timeline of the associated R&D project.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to regulatory.sds. Business justification: Delivery schedules include the SDS ID to ensure carriers handle hazardous materials according to regulations.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier responsible for delivering the scheduled material.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Delivery schedules specify where goods are shipped FROM — the suppliers physical site. delivery_schedule already has supplier_id but not supplier_site_id. Adding this FK enables site-level delivery t',
    `actual_delivery_date` DATE COMMENT 'The actual date when the material was received at the plant, captured from goods receipt transactions.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the delivery schedule record',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice number sent by the supplier via EDI or portal, providing advance notification of this delivery.',
    `atp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this schedule line is considered in Available to Promise (ATP) calculations for downstream order promising.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the material being delivered, critical for traceability and quality management.',
    `blocking_reason` STRING COMMENT 'Explanation of why goods receipt is blocked for this schedule line, if applicable.',
    `delivery_schedule_code` STRING COMMENT 'The delivery schedule code of the delivery schedule record',
    `confirmation_status` STRING COMMENT 'Status indicating whether the supplier has confirmed, rejected, or revised this schedule line.. Valid values are `pending|confirmed|rejected|revised`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier confirmed this delivery schedule line.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the supplier, which may differ from the scheduled date based on supplier capacity or logistics constraints.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity of material confirmed by the supplier for delivery. May differ from scheduled quantity based on supplier capacity or constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery schedule line was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for any monetary values associated with this delivery schedule line.. Valid values are `^[A-Z]{3}$`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The delivered quantity of the delivery schedule record',
    `delivery_instruction` STRING COMMENT 'Special handling or delivery instructions for this schedule line (e.g., dock requirements, unloading equipment, temperature control).',
    `delivery_note_number` STRING COMMENT 'Supplier-provided delivery note or packing slip number accompanying this shipment.',
    `delivery_priority` STRING COMMENT 'Business priority level assigned to this delivery schedule line, used for expediting and resource allocation decisions.. Valid values are `low|normal|high|urgent|critical`',
    `delivery_schedule_status` STRING COMMENT 'The delivery schedule status of the delivery schedule record',
    `delivery_status` STRING COMMENT 'Current lifecycle status of this delivery schedule line indicating progress from scheduling through receipt. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_transit|partially_received|fully_received|cancelled|delayed — 7 candidates stripped; promote to reference product]',
    `delivery_tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable over-delivery or under-delivery tolerance as a percentage of scheduled quantity, per contract terms.',
    `delivery_schedule_description` STRING COMMENT 'The delivery schedule description of the delivery schedule record',
    `effective_from` DATE COMMENT 'The effective from of the delivery schedule record',
    `effective_until` DATE COMMENT 'The effective until of the delivery schedule record',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the material batch being delivered, critical for shelf-life management in consumer goods.',
    `goods_receipt_blocked_flag` BOOLEAN COMMENT 'Indicates whether goods receipt is blocked for this schedule line due to quality, compliance, or commercial issues.',
    `incoterms` STRING COMMENT 'Three-letter Incoterms code defining the responsibilities, costs, and risks between buyer and supplier for this delivery (e.g., FOB, CIF, DDP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery schedule line was last updated in the system.',
    `lead_time_days` STRING COMMENT 'Number of days between order placement and scheduled delivery for this schedule line.',
    `mrp_element_flag` BOOLEAN COMMENT 'Indicates whether this schedule line is an active MRP element used in material requirements planning calculations.',
    `delivery_schedule_name` STRING COMMENT 'The delivery schedule name of the delivery schedule record',
    `notes` STRING COMMENT 'The notes of the delivery schedule record',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity yet to be received, calculated as confirmed quantity minus received quantity.',
    `plant_code` STRING COMMENT 'Four-character code identifying the receiving manufacturing plant or distribution center for this delivery.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this delivery requires quality inspection before goods receipt can be completed.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the delivery schedule record',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of material received against this schedule line through goods receipt transactions.',
    `requested_delivery_date` DATE COMMENT 'The delivery date requested by the purchasing organization or production planning, which may differ from the scheduled date based on MRP or DRP requirements.',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the purchase order identifying this specific delivery schedule. Used for ordering and referencing individual schedule lines.',
    `schedule_status` STRING COMMENT 'The schedule status of the delivery schedule record',
    `scheduled_delivery_date` DATE COMMENT 'The originally planned delivery date for this schedule line as specified in the purchase order or scheduling agreement.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'The quantity of material originally scheduled for delivery on this schedule line as per the purchase order or scheduling agreement.',
    `source_system_code` STRING COMMENT 'The source system code of the delivery schedule record',
    `storage_location_code` STRING COMMENT 'Four-character code identifying the specific storage location within the plant where the material will be received.. Valid values are `^[A-Z0-9]{4}$`',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of this schedule line, calculated as confirmed quantity multiplied by unit price.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier for monitoring delivery progress.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation used or planned for delivering this schedule line.. Valid values are `truck|rail|air|ocean|intermodal|courier`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantities on this schedule line (e.g., KG for kilograms, EA for each, L for liters).. Valid values are `^[A-Z]{2,3}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for the material on this schedule line, as per the purchase order or contract.',
    `uom` STRING COMMENT 'The uom of the delivery schedule record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the delivery schedule record',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Scheduled delivery lines (schedule lines) against a purchase order or scheduling agreement specifying planned delivery dates and quantities for raw materials and packaging. Captures schedule line number, planned delivery date, confirmed delivery date, scheduled quantity, confirmed quantity, delivery status (scheduled/confirmed/partially received/complete), and transport mode. Supports MRP, DRP, and production scheduling by providing confirmed inbound supply commitments.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` (
    `po_confirmation_id` BIGINT COMMENT 'Unique identifier for the purchase order confirmation record. Primary key for the po_confirmation product.',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.delivery_schedule. Business justification: A PO confirmation acknowledges and confirms a specific delivery schedule line. Linking po_confirmation to delivery_schedule enables matching of supplier acknowledgements to the scheduled delivery line',
    `po_line_id` BIGINT COMMENT 'The po line id of the po confirmation record',
    `purchase_order_id` BIGINT COMMENT 'Reference to the original purchase order that this confirmation acknowledges. Links to the purchase order header.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the confirmation. Links to the supplier master data.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the po confirmation record',
    `buyer_approval_date` DATE COMMENT 'Date when the buyer approved or rejected the confirmation. Null if approval is not required or still pending.',
    `buyer_approval_notes` STRING COMMENT 'Notes or comments entered by the buyer during the approval or rejection process. Captures buyer feedback on variances or special conditions.',
    `buyer_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the confirmation requires explicit buyer approval before proceeding. True when there are significant variances, substitutions, or price changes that need buyer review.',
    `buyer_approval_status` STRING COMMENT 'Status of buyer approval for confirmations that require review. Tracks whether the buyer has accepted or rejected the suppliers confirmed terms.. Valid values are `pending|approved|rejected|not_required`',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier or freight forwarder that the supplier will use for shipment. Provided in confirmation for shipment tracking and coordination.',
    `po_confirmation_code` STRING COMMENT 'The po confirmation code of the po confirmation record',
    `confirmation_date` DATE COMMENT 'Date when the supplier issued the confirmation acknowledgement. Represents the business date of confirmation, not the system receipt timestamp.',
    `confirmation_method` STRING COMMENT 'Method or channel through which the supplier submitted the confirmation. EDI 855 is the standard electronic acknowledgement, but portal, email, and manual methods are also tracked.. Valid values are `edi_855|supplier_portal|email|fax|phone|manual`',
    `confirmation_number` STRING COMMENT 'Unique confirmation number assigned by the supplier to this order acknowledgement. Used for supplier reference and tracking.',
    `confirmation_status` STRING COMMENT 'Current status of the supplier confirmation indicating whether the order or line item was accepted, partially accepted, or rejected by the supplier.. Valid values are `acknowledged|accepted|partially_accepted|rejected|pending|cancelled`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when the confirmation was received and recorded in the procurement system. Used for tracking confirmation lead time and system audit.',
    `confirmed_delivery_date` DATE COMMENT 'Delivery date confirmed by the supplier. May differ from requested date due to supplier capacity, lead time constraints, or material availability. Critical for OTIF tracking and supply risk management.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the supplier for delivery. May differ from requested quantity in cases of partial acceptance, substitution, or supplier capacity constraints.',
    `confirmed_unit_price` DECIMAL(18,2) COMMENT 'The confirmed unit price of the po confirmation record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this confirmation record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price and total amount. Examples: USD, EUR, GBP, JPY, CNY.. Valid values are `^[A-Z]{3}$`',
    `delivery_date_variance_days` STRING COMMENT 'Number of days difference between confirmed delivery date and requested delivery date. Positive values indicate delay, negative values indicate early delivery commitment.',
    `delivery_location_code` STRING COMMENT 'Specific delivery location or dock within the plant where goods should be delivered. May be a warehouse, storage location, or receiving dock identifier.',
    `po_confirmation_description` STRING COMMENT 'The po confirmation description of the po confirmation record',
    `edi_transaction_number` STRING COMMENT 'Unique EDI transaction identifier for confirmations received via EDI 855. Null for non-EDI confirmations. Used for EDI audit and reconciliation.',
    `effective_from` DATE COMMENT 'The effective from of the po confirmation record',
    `effective_until` DATE COMMENT 'The effective until of the po confirmation record',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between buyer and supplier. Examples: EXW, FOB, CIF, DDP. Confirmed by supplier in acknowledgement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this confirmation record was last updated. Tracks changes to confirmation status, buyer approval, or other fields throughout the confirmation lifecycle.',
    `material_code` STRING COMMENT 'Internal material code or SKU for the item being confirmed. Links to material master data for product identification.',
    `po_confirmation_name` STRING COMMENT 'The po confirmation name of the po confirmation record',
    `notes` STRING COMMENT 'The notes of the po confirmation record',
    `otif_risk_flag` BOOLEAN COMMENT 'Indicates whether this confirmation represents a risk to OTIF performance. True when confirmed delivery date is later than requested or confirmed quantity is less than requested, signaling potential supply disruption.',
    `plant_code` STRING COMMENT 'Code identifying the receiving plant or facility for the confirmed delivery. Used for logistics planning and inventory allocation.',
    `po_confirmation_status` STRING COMMENT 'The po confirmation status of the po confirmation record',
    `po_line_item_number` STRING COMMENT 'Line item number within the purchase order that this confirmation applies to. Enables line-level confirmation tracking.',
    `promised_ship_date` DATE COMMENT 'Date when the supplier commits to ship the goods. Used for in-transit tracking and logistics planning.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the po confirmation record',
    `quantity_uom` STRING COMMENT 'Unit of measure for the requested and confirmed quantities. Examples include EA (each), KG (kilogram), LB (pound), L (liter), CS (case), PLT (pallet).',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between confirmed quantity and requested quantity (confirmed minus requested). Positive values indicate over-confirmation, negative values indicate under-confirmation or rejection.',
    `quantity_variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance between confirmed and requested quantity, calculated as (quantity_variance / requested_quantity) * 100. Used for supplier performance tracking and OTIF analysis.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for partial or full rejection of the purchase order line. Populated when confirmation_status is rejected or partially_accepted. Examples: capacity_constraint, material_unavailable, price_dispute, discontinued_product.',
    `rejection_reason_description` STRING COMMENT 'Detailed text description of the rejection reason provided by the supplier. Provides additional context beyond the standardized rejection reason code.',
    `requested_delivery_date` DATE COMMENT 'Original delivery date requested in the purchase order. Used as baseline for on-time delivery tracking.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Original quantity requested in the purchase order for this line item. Used as baseline for variance calculation.',
    `source_system_code` STRING COMMENT 'The source system code of the po confirmation record',
    `special_instructions` STRING COMMENT 'Additional instructions or notes from the supplier regarding the confirmation, delivery requirements, handling instructions, or other special conditions.',
    `substitute_material_code` STRING COMMENT 'Material code of the substitute product proposed by the supplier. Populated only when substitution_flag is True. Requires buyer approval before acceptance.',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether the supplier is proposing a substitute material or product in place of the originally requested item. True if substitution is proposed, False otherwise.',
    `supplier_material_code` STRING COMMENT 'Suppliers material code or part number for the item. Used for cross-reference and supplier catalog mapping.',
    `supplier_reference_number` STRING COMMENT 'Suppliers internal reference number for this order or line item. May be a sales order number, production order number, or other supplier-side tracking identifier.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Total amount for this confirmation line, calculated as confirmed_quantity * unit_price. Used for financial reconciliation and invoice matching.',
    `tracking_number` STRING COMMENT 'Carrier tracking number or waybill number for the shipment. May be provided at confirmation time for pre-arranged shipments or updated later when goods are shipped.',
    `unit_price` DECIMAL(18,2) COMMENT 'Confirmed unit price for the material as acknowledged by the supplier. Should match the purchase order price unless price changes are negotiated.',
    `uom` STRING COMMENT 'The uom of the po confirmation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the po confirmation record',
    CONSTRAINT pk_po_confirmation PRIMARY KEY(`po_confirmation_id`)
) COMMENT 'Supplier order acknowledgement and confirmation record for a purchase order, capturing the suppliers confirmed delivery date, confirmed quantity, any partial acceptance or substitution, and confirmation method (EDI 855/portal/email). Captures confirmation number, confirmation date, confirmed delivery date, confirmed quantity per line, variance from PO quantity, supplier reference number, and confirmation status. Enables OTIF tracking and proactive supply risk management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` (
    `vmi_agreement_type_id` BIGINT COMMENT 'The vmi agreement type id of the vmi agreement type record',
    `account_address_id` BIGINT COMMENT 'Carried-over connect_table FK addition P3 (BIGINT) connecting isolated table.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the vmi agreement type record',
    `vmi_agreement_type_code` STRING COMMENT 'The vmi agreement type code of the vmi agreement type record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the vmi agreement type record',
    `currency_code` STRING COMMENT 'The currency code of the vmi agreement type record',
    `vmi_agreement_type_description` STRING COMMENT 'Description.',
    `effective_from` DATE COMMENT 'The effective from of the vmi agreement type record',
    `effective_until` DATE COMMENT 'The effective until of the vmi agreement type record',
    `is_active` BOOLEAN COMMENT 'Whether active.',
    `vmi_agreement_type_name` STRING COMMENT 'The vmi agreement type name of the vmi agreement type record',
    `notes` STRING COMMENT 'The notes of the vmi agreement type record',
    `ownership_transfer_point` STRING COMMENT 'The ownership transfer point of the vmi agreement type record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the vmi agreement type record',
    `replenishment_model` STRING COMMENT 'The replenishment model of the vmi agreement type record',
    `source_system_code` STRING COMMENT 'The source system code of the vmi agreement type record',
    `type_code` STRING COMMENT 'VMI agreement type code.',
    `type_name` STRING COMMENT 'VMI agreement type name.',
    `uom` STRING COMMENT 'The uom of the vmi agreement type record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the vmi agreement type record',
    `vmi_agreement_type_status` STRING COMMENT 'The vmi agreement type status of the vmi agreement type record',
    CONSTRAINT pk_vmi_agreement_type PRIMARY KEY(`vmi_agreement_type_id`)
) COMMENT 'Represents a VMI agreement between a supplier and a distribution facility, capturing inventory targets and SLA metrics that are managed as a contract entity.. Existence Justification: Suppliers and distribution facilities enter Vendor Managed Inventory (VMI) agreements where each supplier can serve multiple facilities and each facility can work with multiple suppliers. The agreement records inventory targets and service‑level metrics, which are actively created, maintained, and queried by both procurement and distribution teams.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` (
    `service_entry_sheet_line_id` BIGINT COMMENT 'Primary key for service_entry_sheet_line',
    `parent_service_entry_sheet_line_id` BIGINT COMMENT 'Self-referencing FK on service_entry_sheet_line (parent_service_entry_sheet_line_id)',
    `po_line_id` BIGINT COMMENT 'The po line id of the service entry sheet line record',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order linked to this service line.',
    `service_entry_sheet_id` BIGINT COMMENT 'Identifier of the parent service entry sheet (header).',
    `service_id` BIGINT COMMENT 'Identifier of the service or activity recorded on this line.',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the contract under which the service is provided.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the service.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the service entry sheet line record',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the service entry line.',
    `service_entry_sheet_line_code` STRING COMMENT 'The service entry sheet line code of the service entry sheet line record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary values.',
    `service_entry_sheet_line_description` STRING COMMENT 'The service entry sheet line description of the service entry sheet line record',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to this line.',
    `effective_date` DATE COMMENT 'Date when the service line becomes effective.',
    `effective_from` DATE COMMENT 'The effective from of the service entry sheet line record',
    `effective_until` DATE COMMENT 'The effective until of the service entry sheet line record',
    `expiry_date` DATE COMMENT 'Date when the service line expires or is no longer valid.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes and discounts (quantity * unit_price).',
    `invoice_number` STRING COMMENT 'Invoice number associated with the service line.',
    `is_vmi` BOOLEAN COMMENT 'Indicates if the service is part of a Vendor Managed Inventory program.',
    `line_amount` DECIMAL(18,2) COMMENT 'The line amount of the service entry sheet line record',
    `line_number` STRING COMMENT 'Sequence number of the line within the service entry sheet.',
    `line_status` STRING COMMENT 'Current processing status of the line.',
    `line_value` DECIMAL(18,2) COMMENT 'The line value of the service entry sheet line record',
    `service_entry_sheet_line_name` STRING COMMENT 'The service entry sheet line name of the service entry sheet line record',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and discount.',
    `notes` STRING COMMENT 'Additional free-text notes for the line.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the service units delivered.',
    `receipt_date` DATE COMMENT 'Date the service was received or acknowledged.',
    `service_entry_sheet_line_status` STRING COMMENT 'The service entry sheet line status of the service entry sheet line record',
    `service_quantity` DECIMAL(18,2) COMMENT 'The service quantity of the service entry sheet line record',
    `source_system_code` STRING COMMENT 'The source system code of the service entry sheet line record',
    `sustainability_certification` STRING COMMENT 'Sustainability certification applicable to the service.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to this line.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the service before taxes and discounts.',
    `uom` STRING COMMENT 'The uom of the service entry sheet line record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_service_entry_sheet_line PRIMARY KEY(`service_entry_sheet_line_id`)
) COMMENT 'Master reference table for service_entry_sheet_line. Referenced by service_entry_sheet_line_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Primary key for service_entry_sheet',
    `corrected_service_entry_sheet_id` BIGINT COMMENT 'Self-referencing FK on service_entry_sheet (corrected_service_entry_sheet_id)',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order linked to this service entry.',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the supplier contract governing the service.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the service.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the service entry sheet record',
    `approval_status` STRING COMMENT 'The approval status of the service entry sheet record',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the service entry sheet.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the service entry sheet was approved.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the record.',
    `service_entry_sheet_code` STRING COMMENT 'The service entry sheet code of the service entry sheet record',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the service expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the service entry sheet record',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values.',
    `service_entry_sheet_description` STRING COMMENT 'The service entry sheet description of the service entry sheet record',
    `due_date` DATE COMMENT 'Payment due date for the service invoice.',
    `effective_from` DATE COMMENT 'The effective from of the service entry sheet record',
    `effective_until` DATE COMMENT 'The effective until of the service entry sheet record',
    `entry_date` DATE COMMENT 'The entry date of the service entry sheet record',
    `entry_sheet_number` STRING COMMENT 'The entry sheet number of the service entry sheet record',
    `entry_status` STRING COMMENT 'The entry status of the service entry sheet record',
    `expense_account` STRING COMMENT 'General ledger expense account used for posting the service cost.',
    `is_sustainable` BOOLEAN COMMENT 'Flag indicating whether the service complies with sustainability policies.',
    `service_entry_sheet_name` STRING COMMENT 'The service entry sheet name of the service entry sheet record',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after tax and any discounts.',
    `notes` STRING COMMENT 'The notes of the service entry sheet record',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for the supplier (e.g., Net 30).',
    `posting_date` DATE COMMENT 'Date the service entry sheet was posted to the financial system.',
    `quantity` DECIMAL(18,2) COMMENT 'Measured quantity of the service (e.g., hours, cubic meters).',
    `receipt_date` DATE COMMENT 'Date the service entry sheet was received by the receiving department.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the service entry sheet record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service entry sheet record.',
    `remarks` STRING COMMENT 'Free‑form comments or notes about the service entry.',
    `service_category` STRING COMMENT 'High‑level classification of the service (e.g., Maintenance, Consulting).',
    `service_date` DATE COMMENT 'Date on which the service was performed.',
    `service_entry_sheet_number` STRING COMMENT 'Business identifier or number assigned to the service entry sheet.',
    `service_entry_sheet_status` STRING COMMENT 'Current lifecycle status of the service entry sheet.',
    `service_period_end` DATE COMMENT 'The service period end of the service entry sheet record',
    `service_period_start` DATE COMMENT 'The service period start of the service entry sheet record',
    `service_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the service was performed.',
    `service_type` STRING COMMENT 'Specific type of service performed.',
    `sheet_number` STRING COMMENT 'The sheet number of the service entry sheet record',
    `source_system_code` STRING COMMENT 'The source system code of the service entry sheet record',
    `supplier_performance_score` DECIMAL(18,2) COMMENT 'Numeric score reflecting supplier performance for this service.',
    `sustainability_certification` STRING COMMENT 'Certification indicating sustainable sourcing (FSC, RSPO, or None).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the service total.',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the service.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount of the service before taxes and discounts.',
    `total_value` DECIMAL(18,2) COMMENT 'The total value of the service entry sheet record',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity (e.g., hour, m3).',
    `uom` STRING COMMENT 'The uom of the service entry sheet record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the service entry sheet record',
    `created_by` STRING COMMENT 'User identifier who initially created the service entry sheet.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Master reference table for service_entry_sheet. Referenced by service_entry_sheet_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`service` (
    `service_id` BIGINT COMMENT 'Primary key for service',
    `compliance_document_id` BIGINT COMMENT 'Identifier of the compliance or safety document linked to the service.',
    `parent_service_id` BIGINT COMMENT 'Self-referencing FK on service (parent_service_id)',
    `spend_category_id` BIGINT COMMENT 'The spend category id of the service record',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the contract governing the service terms.',
    `supplier_id` BIGINT COMMENT 'Identifier of the primary supplier providing this service.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Services are delivered from or associated with a specific supplier site (e.g., a contract manufacturers facility providing a specific service). service already has supplier_id; adding supplier_site_i',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the service record',
    `service_category` STRING COMMENT 'The service category of the service record',
    `service_code` STRING COMMENT 'External code or SKU used to reference the service in contracts and catalogs.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for price_per_unit.',
    `service_description` STRING COMMENT 'Detailed textual description of the service offering.',
    `effective_from` DATE COMMENT 'Date when the service becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the service ceases to be valid (null if open‑ended).',
    `external_reference` STRING COMMENT 'Identifier used in external ERP or supplier systems.',
    `is_sustainable` BOOLEAN COMMENT 'Indicates whether the service meets sustainability criteria.',
    `last_modified_by` STRING COMMENT 'User or system that performed the most recent update.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order to service delivery.',
    `level_agreement` STRING COMMENT 'Reference to the SLA document or summary text.',
    `service_name` STRING COMMENT 'Human‑readable name of the service offered.',
    `notes` STRING COMMENT 'The notes of the service record',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Base price for one unit of the service.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the service record',
    `risk_rating` STRING COMMENT 'Risk classification for the service (e.g., operational, safety).',
    `service_status` STRING COMMENT 'Current lifecycle state of the service.',
    `service_type` STRING COMMENT 'Category of service (e.g., logistics, maintenance).',
    `sla_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied if SLA target is missed.',
    `sla_target_hours` STRING COMMENT 'Maximum response or resolution time promised in the SLA (hours).',
    `source_system_code` STRING COMMENT 'The source system code of the service record',
    `standard_rate` DECIMAL(18,2) COMMENT 'The standard rate of the service record',
    `sustainability_certification` STRING COMMENT 'Environmental certification associated with the service.',
    `unit_of_measure` STRING COMMENT 'Standard unit used to price or bill the service.',
    `unspsc_code` STRING COMMENT 'The unspsc code of the service record',
    `uom` STRING COMMENT 'The uom of the service record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the service record.',
    `created_by` STRING COMMENT 'User or system that created the service record.',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'Master reference table for service. Referenced by service_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` (
    `compliance_document_id` BIGINT COMMENT 'Primary key for compliance_document',
    `compliance_superseded_by_compliance_document_id` BIGINT COMMENT 'Reference to the compliance_document_id of the newer document that replaces this one when document_status is superseded. Enables document lineage tracking and ensures procurement teams use the current version.',
    `primary_supersedes_compliance_document_id` BIGINT COMMENT 'Self-referencing FK on compliance_document (supersedes_compliance_document_id)',
    `supplier_contract_id` BIGINT COMMENT 'Reference to the procurement contract or supplier agreement to which this compliance document is attached, enabling contract-level compliance tracking.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier associated with this compliance document. Links the document to the supplier master for traceability of supplier-specific certifications, SDS, and regulatory submissions.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation body that accredited the certification body or auditor who issued this document (e.g., UKAS, DAkkS, ANAB). Validates the credibility of the issuing body in the supply chain.',
    `applicable_market` STRING COMMENT 'The geographic market or regulatory jurisdiction for which this compliance document is valid or required (e.g., European Union, United States, ASEAN). Supports multi-market compliance management for global Consumer Goods operations.',
    `audit_frequency` STRING COMMENT 'Required frequency of audits or re-assessments for maintaining the validity of this compliance document. Drives scheduling of supplier audits and renewal planning in the procurement calendar.',
    `certificate_number` STRING COMMENT 'Official certificate number assigned by the certifying body (e.g., FSC certificate code FSC-C123456, RSPO membership number, or ISO certificate number). Used for external verification with the issuing bodys public registry.',
    `chain_of_custody_model` STRING COMMENT 'For sustainability certificates (FSC, RSPO, PEFC), the chain of custody model applied, which determines how certified material is tracked through the supply chain. Drives procurement sourcing decisions and sustainability reporting.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the compliance document content as defined by the enterprise data governance policy. Governs access controls and sharing permissions for the document.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the supplier must resolve a non-conformance associated with this compliance document. Null when non_conformance_flag is False. Drives supplier performance management and procurement risk escalation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this compliance document record was first created in the procurement master data system. Provides the audit trail entry point for the documents lifecycle.',
    `document_category` STRING COMMENT 'Broad business category grouping the compliance document, enabling portfolio-level reporting across sustainability (FSC, RSPO), quality (ISO), safety (SDS/GHS), regulatory (REACH, RoHS), and trade compliance domains.',
    `document_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to the compliance document, such as a certificate number, SDS document number, or regulatory submission reference. Used for cross-referencing with supplier and regulatory body records.',
    `document_status` STRING COMMENT 'Current lifecycle state of the compliance document. Controls whether the document is valid for procurement decisions. active indicates the document is current and approved; expired triggers renewal workflows; revoked indicates withdrawal by the issuing body.',
    `document_title` STRING COMMENT 'Human-readable title or name of the compliance document, such as RSPO Supply Chain Certificate, Safety Data Sheet – Palm Oil, or FSC Chain of Custody Certificate.',
    `document_type` STRING COMMENT 'Classification of the compliance document by its regulatory or business function. Drives workflow routing and retention rules. [ENUM-REF-CANDIDATE: certificate|safety_data_sheet|audit_report|regulatory_submission|license|declaration_of_conformity|inspection_report|test_report|permit|policy_statement — promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which the compliance document is valid and binding. Used to determine whether the document covers a given procurement transaction or audit period.',
    `expiry_date` DATE COMMENT 'Date on which the compliance document ceases to be valid. Null for open-ended documents. Triggers automated renewal alerts and procurement holds when approaching or past this date.',
    `file_format` STRING COMMENT 'File format of the stored compliance document (e.g., PDF for certificates, XLSX for data declarations, XML for structured regulatory submissions). Supports document management and retrieval workflows.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this compliance document is mandatory for supplier qualification or procurement approval. When True, procurement orders cannot be approved without a valid instance of this document type from the supplier.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the compliance document has been independently verified or authenticated by the procurement compliance team against the issuing bodys registry or original source.',
    `issue_date` DATE COMMENT 'Calendar date on which the compliance document was formally issued or signed by the issuing body. Distinct from effective_date, which may differ due to retroactive or future-dated validity.',
    `issuing_body` STRING COMMENT 'Name of the organization, certification body, or regulatory authority that issued or approved the compliance document (e.g., Bureau Veritas, SGS, RSPO Secretariat, FSC International, US EPA, ECHA).',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country in which the compliance document was issued or the regulatory jurisdiction it covers (e.g., USA, DEU, GBR, MYS for RSPO-related documents).',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the compliance document (e.g., en, de, fr, zh-CN). Relevant for SDS documents which must be provided in the local language of the country of use under GHS/REACH requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time at which this compliance document record was most recently modified in the procurement master data system. Supports change tracking and audit readiness.',
    `material_category` STRING COMMENT 'Classification of the material or product category to which this compliance document applies within the Consumer Goods procurement context (e.g., raw_material for palm oil, packaging for FSC-certified cartons, chemical for SDS-covered substances).',
    `non_conformance_details` STRING COMMENT 'Textual description of the non-conformance finding associated with this compliance document, including the nature of the deviation, the clause or requirement breached, and the corrective action required.',
    `non_conformance_flag` BOOLEAN COMMENT 'Indicates whether this compliance document is associated with an open non-conformance finding from an audit or regulatory inspection. When True, triggers corrective action workflows and may place the supplier on a procurement hold.',
    `notes` STRING COMMENT 'Free-text field for additional procurement compliance notes, special conditions, or contextual information about this compliance document that does not fit structured fields.',
    `owner_department` STRING COMMENT 'Name of the internal department responsible for managing and renewing this compliance document (e.g., Procurement Compliance, Regulatory Affairs, Sustainability, Quality Assurance).',
    `received_date` DATE COMMENT 'Date on which the compliance document was received from the supplier or issuing body by the procurement team. Used to track supplier responsiveness and document collection SLA performance.',
    `regulatory_framework` STRING COMMENT 'The specific regulatory or sustainability framework under which this compliance document was issued or is required. Drives sourcing decisions and supplier qualification criteria. [ENUM-REF-CANDIDATE: REACH|RoHS|FSC|RSPO|GHS|CITES|PROP_65|TSCA|CPSC|EFSA|ISO_9001|ISO_14001|SA8000|SMETA — promote to reference product]',
    `reminder_days_before_expiry` STRING COMMENT 'Number of calendar days before the expiry_date at which automated renewal reminder notifications should be triggered to the responsible buyer and supplier. Supports proactive compliance management.',
    `renewal_date` DATE COMMENT 'Target date by which the compliance document must be renewed or re-certified to maintain uninterrupted supplier qualification. Supports proactive procurement compliance management.',
    `responsible_buyer` STRING COMMENT 'Name or employee identifier of the procurement buyer or category manager responsible for ensuring this compliance document is current and valid for the associated supplier relationship.',
    `review_date` DATE COMMENT 'Date on which the compliance document was last reviewed or verified by the internal procurement compliance team. Supports audit readiness and periodic re-validation workflows.',
    `revision_reason` STRING COMMENT 'Textual explanation of why this version of the compliance document was revised or reissued, such as regulatory change, formula update, or corrective action following an audit finding.',
    `risk_level` STRING COMMENT 'Assessed risk level associated with the compliance documents subject matter or the suppliers compliance posture. Drives prioritization of procurement compliance reviews and escalation thresholds.',
    `scope_description` STRING COMMENT 'Narrative description of the materials, products, processes, or business activities covered by this compliance document. For example, an FSC certificate scope may list specific wood-based packaging materials or product categories.',
    `sds_ghs_version` STRING COMMENT 'For SDS documents, the version of the Globally Harmonized System (GHS) standard to which the SDS was prepared (e.g., GHS07, GHS09). Null for non-SDS document types. Ensures regulatory alignment with the applicable GHS revision in the target market.',
    `sds_revision_date` DATE COMMENT 'For Safety Data Sheet (SDS) documents, the date of the most recent revision as required by GHS/REACH. Null for non-SDS document types. Ensures procurement teams hold the current hazard communication version.',
    `storage_location_url` STRING COMMENT 'Secure URL or file path pointing to the digital copy of the compliance document stored in the enterprise document management system or data lake. Enables direct retrieval for audits and procurement approvals.',
    `sustainable_sourcing_scheme` STRING COMMENT 'The sustainable sourcing certification scheme under which this document was issued, applicable to Consumer Goods raw materials such as palm oil (RSPO), wood/paper (FSC/PEFC), soy (RTRS), or sugar (Bonsucro). Null for non-sustainability documents. [ENUM-REF-CANDIDATE: FSC|RSPO|RTRS|Rainforest_Alliance|UTZ|PEFC|Bonsucro|Fairtrade|SAN — promote to reference product]',
    `translation_required` BOOLEAN COMMENT 'Indicates whether a translation of this compliance document is required for the destination market or regulatory jurisdiction. Triggers translation workflow in the procurement compliance process.',
    `verified_by` STRING COMMENT 'Name or employee identifier of the procurement compliance officer or auditor who verified the authenticity and validity of this compliance document.',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time at which the compliance document was verified by the procurement compliance team. Provides an audit trail for regulatory inspections and supplier qualification reviews.',
    `version_number` STRING COMMENT 'Version or revision number of the compliance document as assigned by the issuing body or supplier (e.g., 1.0, 2.3, 3.0.1). Critical for SDS documents under GHS where version controls chemical hazard information.',
    CONSTRAINT pk_compliance_document PRIMARY KEY(`compliance_document_id`)
) COMMENT 'Master reference table for compliance_document. Referenced by compliance_document_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ADD CONSTRAINT `fk_procurement_rfq_response_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ADD CONSTRAINT `fk_procurement_rfq_response_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_confirmation_id` FOREIGN KEY (`po_confirmation_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_confirmation`(`po_confirmation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ADD CONSTRAINT `fk_procurement_invoice_line_service_entry_sheet_line_id` FOREIGN KEY (`service_entry_sheet_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line`(`service_entry_sheet_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_parent_spend_category_id` FOREIGN KEY (`parent_spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_qualification_id` FOREIGN KEY (`supplier_qualification_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification`(`supplier_qualification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ADD CONSTRAINT `fk_procurement_approved_supplier_list_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ADD CONSTRAINT `fk_procurement_procurement_vmi_agreement_vmi_agreement_type_id` FOREIGN KEY (`vmi_agreement_type_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type`(`vmi_agreement_type_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ADD CONSTRAINT `fk_procurement_price_condition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ADD CONSTRAINT `fk_procurement_po_confirmation_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ADD CONSTRAINT `fk_procurement_po_confirmation_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ADD CONSTRAINT `fk_procurement_po_confirmation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ADD CONSTRAINT `fk_procurement_po_confirmation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_parent_service_entry_sheet_line_id` FOREIGN KEY (`parent_service_entry_sheet_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line`(`service_entry_sheet_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service`(`service_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ADD CONSTRAINT `fk_procurement_service_entry_sheet_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_corrected_service_entry_sheet_id` FOREIGN KEY (`corrected_service_entry_sheet_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_parent_service_id` FOREIGN KEY (`parent_service_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`service`(`service_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ADD CONSTRAINT `fk_procurement_service_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_compliance_superseded_by_compliance_document_id` FOREIGN KEY (`compliance_superseded_by_compliance_document_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_primary_supersedes_compliance_document_id` FOREIGN KEY (`primary_supersedes_compliance_document_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_consumer_goods_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `fsc_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Approved');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `is_strategic` SET TAGS ('dbx_business_glossary_term' = 'Is Strategic');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `iso_9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `rspo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging|indirect_goods|contract_manufacturer|service_provider|logistics_provider');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `is_primary_ship_from` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Ship From');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `preferred_site_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Site Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `rspo_certified` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_capacity` SET TAGS ('dbx_business_glossary_term' = 'Site Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_capacity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_capacity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|decommissioned');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing|warehouse|office|port|distribution_center|r_and_d');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_site` ALTER COLUMN `vmi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_contract_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Code');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_contract_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Formula');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'fixed_price|cost_plus|market_indexed|volume_tiered|rebate_based');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UoM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `rebate_terms` SET TAGS ('dbx_business_glossary_term' = 'Rebate Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `supplier_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `target_quantity_total` SET TAGS ('dbx_business_glossary_term' = 'Total Target Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_invoiced_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Invoiced Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_invoiced_value` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_invoiced_value` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_ordered_quantity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_ordered_quantity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_received_quantity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `cumulative_received_quantity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `incoterm_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|expired|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `order_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Formula');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_formula` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `target_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`contract_line` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Organization ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_buyer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_buyer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_buyer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `tertiary_rfq_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `tertiary_rfq_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `tertiary_rfq_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `award_justification` SET TAGS ('dbx_business_glossary_term' = 'Award Justification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `award_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_code` SET TAGS ('dbx_business_glossary_term' = 'Rfq Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `commodity_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Commodity Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'Rfq Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `estimated_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria_delivery_weight` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria Delivery Weight Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria_price_weight` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria Price Weight Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria_quality_weight` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria Quality Weight Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria_sustainability_weight` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria Sustainability Weight Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'RFQ Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_name` SET TAGS ('dbx_business_glossary_term' = 'Rfq Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RFQ Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `requires_quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Quality Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `requires_sds` SET TAGS ('dbx_business_glossary_term' = 'Requires Safety Data Sheet (SDS)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `requires_sustainability_declaration` SET TAGS ('dbx_business_glossary_term' = 'Requires Sustainability Declaration');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|open|closed|awarded|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'standard|spot_buy|framework|emergency|global_sourcing|strategic');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'RFQ Submission Deadline');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `supplier_count_invited` SET TAGS ('dbx_business_glossary_term' = 'Supplier Count Invited');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `supplier_count_responded` SET TAGS ('dbx_business_glossary_term' = 'Supplier Count Responded');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `technical_specification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document URL');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rfq_response_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Response Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Awarded Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rfq_response_code` SET TAGS ('dbx_business_glossary_term' = 'Rfq Response Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rfq_response_description` SET TAGS ('dbx_business_glossary_term' = 'Rfq Response Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `is_awarded` SET TAGS ('dbx_business_glossary_term' = 'Is Awarded');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rfq_response_name` SET TAGS ('dbx_business_glossary_term' = 'Rfq Response Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `quoted_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Quoted Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `quoted_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `response_notes` SET TAGS ('dbx_business_glossary_term' = 'Response Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|accepted|rejected|awarded|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `rfq_response_status` SET TAGS ('dbx_business_glossary_term' = 'Rfq Response Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `sample_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Available Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `sample_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Sample Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `sds_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Provided Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `technical_specification_compliance` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `technical_specification_compliance` SET TAGS ('dbx_value_regex' = 'fully_compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `total_quoted_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `total_quoted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `validity_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`rfq_response` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_order_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Storage Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requesting_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_description` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_name` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Requested Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_date` SET TAGS ('dbx_business_glossary_term' = 'Required Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transfer|service|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'preferred_supplier|contract|stock_transfer|external|internal');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `total_estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_order_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_description` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `edi_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `edi_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|rejected|error');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `edi_transmission_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Required');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Required');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_name` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Confirmation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Supplier Confirmation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `supplier_confirmation_method` SET TAGS ('dbx_value_regex' = 'edi_855|supplier_portal|email|phone|fax|not_confirmed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|fair_trade|organic|none');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|rail|truck|courier|multimodal');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`purchase_order` ALTER COLUMN `vmi_indicator` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_order_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `batch_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_code` SET TAGS ('dbx_business_glossary_term' = 'Po Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_description` SET TAGS ('dbx_business_glossary_term' = 'Po Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_name` SET TAGS ('dbx_business_glossary_term' = 'Po Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_status` SET TAGS ('dbx_business_glossary_term' = 'Po Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_order_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `po_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Po Confirmation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_analysis_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_code` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_inspection|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_name` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `otif_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'quality_reject|quantity_discrepancy|damaged|wrong_material|duplicate_posting|administrative_error');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `sustainable_sourcing_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Sourcing Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `sustainable_sourcing_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|none');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `blocking_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Blocking Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `blocking_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Blocking Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cash_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cash_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Processing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|final|proforma');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|edi|other');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance_within_tolerance|variance_exceeds_tolerance|not_matched|bypassed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_result` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Check Result');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `service_entry_sheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `amount_variance` SET TAGS ('dbx_business_glossary_term' = 'Amount Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoice_line_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoice_line_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoice_line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `line_text` SET TAGS ('dbx_business_glossary_term' = 'Line Text');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|unmatched|blocked|approved');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `invoice_line_name` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'FSC|RSPO|FAIRTRADE|ORGANIC|RAINFOREST_ALLIANCE|NONE');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`invoice_line` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `cost_competitiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `innovation_collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation and Collaboration Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `invoice_accuracy_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `invoice_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `otif_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Delivery Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `otif_pct` SET TAGS ('dbx_business_glossary_term' = 'Otif Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `otif_score` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `overall_weighted_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Weighted Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|at_risk');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `prior_period_overall_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Overall Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `quality_rejection_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Rate Parts Per Million (PPM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `rating_grade` SET TAGS ('dbx_business_glossary_term' = 'Rating Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'maintain|develop|monitor|escalate|delist');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `regulatory_adherence_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Adherence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `regulatory_adherence_score` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `regulatory_adherence_score` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|under_review|approved|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `sustainability_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `total_po_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `total_purchase_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `total_purchase_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `trend_vs_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Trend Versus Prior Period');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `trend_vs_prior_period` SET TAGS ('dbx_value_regex' = 'improved|declined|stable|new_supplier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_events');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `primary_sourcing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Event Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `primary_sourcing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `primary_sourcing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Savings Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_savings_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `baseline_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `baseline_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `bid_close_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `bid_open_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Open Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_code` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `competitive_bidding_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bidding Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_description` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^SE-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_outcome` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_outcome` SET TAGS ('dbx_value_regex' = 'awarded|no_award|cancelled|extended|rebid');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|published|open|closed|awarded|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_organization` SET TAGS ('dbx_business_glossary_term' = 'Procurement Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `publish_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sole_source_justification` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Justification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `strategic_initiative_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Initiative Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `suppliers_awarded_count` SET TAGS ('dbx_business_glossary_term' = 'Suppliers Awarded Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `suppliers_invited_count` SET TAGS ('dbx_business_glossary_term' = 'Suppliers Invited Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `suppliers_participated_count` SET TAGS ('dbx_business_glossary_term' = 'Suppliers Participated Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sustainability_criteria` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sustainability_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `target_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Savings Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `target_savings_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`sourcing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Owner Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `parent_spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `annual_spend` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend');
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
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_category_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `contract_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `cost_savings_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `cost_savings_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_category_description` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `is_direct_spend` SET TAGS ('dbx_business_glossary_term' = 'Is Direct Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `is_strategic` SET TAGS ('dbx_business_glossary_term' = 'Is Strategic');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `lead_time_days_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `moq_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Applicable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_category_name` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sourcing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `procurement_organization` SET TAGS ('dbx_business_glossary_term' = 'Procurement Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_category_status` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Spend Visibility Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_visibility_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'critical|strategic|tactical|non_critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `supplier_consolidation_target` SET TAGS ('dbx_business_glossary_term' = 'Supplier Consolidation Target');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `sustainable_sourcing_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Sourcing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`spend_category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List (ASL) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_basis` SET TAGS ('dbx_business_glossary_term' = 'Approval Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_basis` SET TAGS ('dbx_value_regex' = 'audit|certification|qualification_test|performance_review|risk_assessment|legacy_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|blocked|delisted|pending|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approved_supplier_list_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `blocking_date` SET TAGS ('dbx_business_glossary_term' = 'Blocking Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approved_supplier_list_code` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `conditional_terms` SET TAGS ('dbx_business_glossary_term' = 'Conditional Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `delivery_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `delivery_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approved_supplier_list_description` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `approved_supplier_list_name` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `preference_rank` SET TAGS ('dbx_business_glossary_term' = 'Preference Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `re_evaluation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re-evaluation Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `approved_material_categories` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Categories');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|document_review|self_assessment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `auditor_certification` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_qualification_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `iso_9001_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_value_regex' = 'qualified|conditional|failed|pending|not_assessed');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_score` SET TAGS ('dbx_business_glossary_term' = 'Qualification Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|for_cause|re_qualification|pre_qualification|special');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Valid Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `regulatory_compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `regulatory_compliance_verified_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `regulatory_compliance_verified_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `sds_documentation_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Documentation Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `sustainability_criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria Met Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`supplier_qualification` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_subdomain' = 'inventory_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_concept' = 'vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_owner' = 'vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_canonical' = 'inventory.inventory_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_vmi_agreement2_fk_removed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_fk_removed' = 'p1');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vendor Managed Inventory (VMI) Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement - Distribution Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Buyer Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `vmi_agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement Type Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging|indirect_goods|mro|finished_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vmi Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `consignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vmi Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `edi_message_types` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Types');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `inventory_uom` SET TAGS ('dbx_business_glossary_term' = 'Inventory Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `inventory_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Vmi Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `inventory_vmi_agreement_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `managed_location_code` SET TAGS ('dbx_business_glossary_term' = 'Managed Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `managed_location_name` SET TAGS ('dbx_business_glossary_term' = 'Managed Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `max_inventory_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Max Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `min_inventory_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inventory Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vmi Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `ownership_transfer_trigger` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Trigger');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `ownership_transfer_trigger` SET TAGS ('dbx_value_regex' = 'goods_receipt|consumption|withdrawal|invoice_receipt|time_based');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `replenishment_model` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Model');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `replenishment_model` SET TAGS ('dbx_value_regex' = 'min_max|forecast_driven|consumption_based|kanban|continuous_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|continuous');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Vmi Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `sla_fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Fill Rate Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `sla_otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `sla_stockout_tolerance_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Stockout Tolerance Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `target_inventory_level` SET TAGS ('dbx_business_glossary_term' = 'Target Inventory Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Price Condition ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage|quantity_based|value_based');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_class` SET TAGS ('dbx_business_glossary_term' = 'Condition Class');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_class` SET TAGS ('dbx_value_regex' = 'price|discount|surcharge|freight|tax');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Record Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_sequence` SET TAGS ('dbx_business_glossary_term' = 'Condition Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_condition_name` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `per_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Per Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `per_unit_uom` SET TAGS ('dbx_business_glossary_term' = 'Per Unit Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_condition_status` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_determination_rule` SET TAGS ('dbx_business_glossary_term' = 'Price Determination Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'contract|rfq|catalog|negotiated|spot|market_index');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `price_value` SET TAGS ('dbx_business_glossary_term' = 'Price Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `pricing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `pricing_uom` SET TAGS ('dbx_business_glossary_term' = 'Pricing Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Scale Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'none|quantity|value|weight|volume');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `scale_uom` SET TAGS ('dbx_business_glossary_term' = 'Scale Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`price_condition` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'procurement_order_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `atp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Relevant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected|revised');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_instruction` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instruction');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `goods_receipt_blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Blocked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `mrp_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Element Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal|courier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`delivery_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` SET TAGS ('dbx_subdomain' = 'procurement_order_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Confirmation Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `buyer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `buyer_approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `buyer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `buyer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Buyer Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `buyer_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'Po Confirmation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_value_regex' = 'edi_855|supplier_portal|email|fax|phone|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'acknowledged|accepted|partially_accepted|rejected|pending|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `confirmed_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `delivery_date_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date Variance in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_confirmation_description` SET TAGS ('dbx_business_glossary_term' = 'Po Confirmation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `edi_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_confirmation_name` SET TAGS ('dbx_business_glossary_term' = 'Po Confirmation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `otif_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Po Confirmation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `po_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `promised_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `quantity_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `substitute_material_code` SET TAGS ('dbx_business_glossary_term' = 'Substitute Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `supplier_material_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `supplier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`po_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` SET TAGS ('dbx_subdomain' = 'inventory_agreements');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` SET TAGS ('dbx_association_edges' = 'procurement.supplier,distribution.distribution_facility');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `vmi_agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement Type Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `account_address_id` SET TAGS ('dbx_connect_table' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `account_address_id` SET TAGS ('dbx_directive' = 'P3');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `vmi_agreement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement Type Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `vmi_agreement_type_description` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement Type Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `vmi_agreement_type_name` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement Type Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `ownership_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Point');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `replenishment_model` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Model');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Type Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Type Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`vmi_agreement_type` ALTER COLUMN `vmi_agreement_type_status` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement Type Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_entry_sheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `parent_service_entry_sheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Entry Sheet Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `parent_service_entry_sheet_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_entry_sheet_line_code` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_entry_sheet_line_description` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `is_vmi` SET TAGS ('dbx_business_glossary_term' = 'Is Vmi');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `line_value` SET TAGS ('dbx_business_glossary_term' = 'Line Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_entry_sheet_line_name` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_entry_sheet_line_status` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `corrected_service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Service Entry Sheet Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `corrected_service_entry_sheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_code` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_description` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `entry_sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Entry Sheet Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `expense_account` SET TAGS ('dbx_business_glossary_term' = 'Expense Account');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `is_sustainable` SET TAGS ('dbx_business_glossary_term' = 'Is Sustainable');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_name` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_period_end` SET TAGS ('dbx_business_glossary_term' = 'Service Period End');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_period_start` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Sheet Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `supplier_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `parent_service_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `parent_service_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `is_sustainable` SET TAGS ('dbx_business_glossary_term' = 'Is Sustainable');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `sla_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Sla Penalty Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Sla Target Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'Unspsc Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`service` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `compliance_superseded_by_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `primary_supersedes_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Compliance Document Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `primary_supersedes_compliance_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `chain_of_custody_model` SET TAGS ('dbx_business_glossary_term' = 'Chain Of Custody Model');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `non_conformance_details` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Details');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `non_conformance_flag` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `reminder_days_before_expiry` SET TAGS ('dbx_business_glossary_term' = 'Reminder Days Before Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `responsible_buyer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Buyer');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `sds_ghs_version` SET TAGS ('dbx_business_glossary_term' = 'Sds Ghs Version');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Sds Revision Date');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Url');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `sustainable_sourcing_scheme` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Sourcing Scheme');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `translation_required` SET TAGS ('dbx_business_glossary_term' = 'Translation Required');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `translation_required` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `translation_required` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`procurement`.`compliance_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
