-- Schema for Domain: sales | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`sales` COMMENT 'Sales and commercial domain managing the revenue pipeline including opportunities, quotes, proposals, contracts, order intake, sales pipeline tracking, territory management, and commercial KPIs for industrial automation and electrification products via Salesforce Sales Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Project Execution Planning: tracks which project fulfills a won opportunity, essential for schedule and cost alignment.',
    `contact_id` BIGINT COMMENT 'Reference to the primary contact person at the customer account for this opportunity.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this opportunity.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Equipment upgrade, replacement, and service contract opportunities in manufacturing are tied to specific registered assets. Sales reps need the equipment_register reference for accurate quoting, engin',
    `installed_base_id` BIGINT COMMENT 'Foreign key linking to service.installed_base. Business justification: Installed-base selling motion: upgrade, expansion, and renewal opportunities in manufacturing are tied to a specific installed asset. Sales reps need to know which asset is being replaced or expanded ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Opportunity reporting by product family is essential for portfolio performance analysis and strategic sales planning.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: New product opportunities trigger an engineering project; linking enables tracking of project initiation and status.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Opportunity is owned by a sales rep; adding sales_rep_id FK enables proper ownership tracking.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Opportunity pipeline and forecasting require linking each opportunity to the exact SKU being pursued, enabling accurate demand planning and revenue projection.',
    `amount` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity in the base currency. Represents the gross deal size before discounts.',
    `close_date` DATE COMMENT 'Target date by which the opportunity is expected to close (win or loss decision).',
    `closed_date` DATE COMMENT 'Actual date when the opportunity was marked as closed (won or lost). Null if still open.',
    `competitor_name` STRING COMMENT 'Name of the primary competitor identified in this sales opportunity.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the opportunity location.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the opportunity amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_installation_status` STRING COMMENT 'Current status of product delivery and installation for won opportunities. Tracks post-sale fulfillment.. Valid values are `not_started|in_progress|completed|on_hold`',
    `opportunity_description` STRING COMMENT 'Detailed narrative description of the opportunity including customer needs, solution scope, and strategic context.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Total discount percentage applied to the opportunity amount. Used for pricing and margin analysis.',
    `expected_revenue` DECIMAL(18,2) COMMENT 'Probability-weighted revenue calculated as amount multiplied by probability percentage. Used for forecast accuracy.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the opportunity is expected to close (e.g., Q1 FY2024). Used for quota and forecast alignment.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the opportunity is expected to close. Used for annual revenue planning.',
    `forecast_category` STRING COMMENT 'Sales forecast classification indicating confidence level for revenue planning and quota tracking.. Valid values are `pipeline|best_case|commit|closed`',
    `has_open_activity` BOOLEAN COMMENT 'Boolean indicator whether there are open tasks or activities associated with this opportunity. Used for pipeline health monitoring.',
    `industry_segment` STRING COMMENT 'Target industry vertical or market segment for this opportunity (e.g., automotive, food and beverage, pharmaceuticals).',
    `is_closed` BOOLEAN COMMENT 'Boolean indicator whether the opportunity has reached a final closed state (won or lost).',
    `is_private` BOOLEAN COMMENT 'Boolean indicator whether the opportunity is marked as private with restricted visibility.',
    `is_won` BOOLEAN COMMENT 'Boolean indicator whether the opportunity was closed as won (deal successfully secured).',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, meeting, email) logged against this opportunity.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the opportunity record was last updated.',
    `lead_source` STRING COMMENT 'Original source or channel through which the opportunity was generated.. Valid values are `web|trade_show|referral|partner|cold_call|campaign`',
    `loss_reason` STRING COMMENT 'Primary reason why the opportunity was lost. Used for win/loss analysis and competitive intelligence.. Valid values are `price|competitor|no_decision|timing|product_fit|budget`',
    `opportunity_name` STRING COMMENT 'Business-friendly name or title of the sales opportunity describing the potential deal.',
    `next_step` STRING COMMENT 'Description of the next planned action or milestone to advance the opportunity.',
    `opportunity_number` STRING COMMENT 'Externally-visible unique business identifier for the opportunity used in sales communications and reporting.',
    `opportunity_type` STRING COMMENT 'Classification of the opportunity based on customer relationship status (new customer acquisition vs existing customer expansion).. Valid values are `new_business|existing_customer|renewal|upgrade`',
    `order_number` STRING COMMENT 'Reference to the order number generated when the opportunity was converted to a sales order in the ERP (Enterprise Resource Planning) system.',
    `probability_percent` DECIMAL(18,2) COMMENT 'Estimated probability of winning this opportunity expressed as a percentage (0-100). Used for weighted pipeline forecasting.',
    `product_line` STRING COMMENT 'Primary product line or business unit category for the opportunity (e.g., automation systems, electrification solutions, smart infrastructure).',
    `project_end_date` DATE COMMENT 'Planned or actual completion date for project delivery if the opportunity is won.',
    `project_start_date` DATE COMMENT 'Planned or actual start date for project delivery if the opportunity is won.',
    `region` STRING COMMENT 'Geographic region classification for the opportunity (e.g., North America, EMEA, APAC).',
    `sales_cycle_days` STRING COMMENT 'Number of days from opportunity creation to close date. Used for sales velocity analysis.',
    `stage` STRING COMMENT 'Current stage of the opportunity in the sales pipeline lifecycle indicating progression toward close. [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `stage_changed_date` TIMESTAMP COMMENT 'Timestamp when the opportunity stage was last changed. Used for stage duration and velocity analysis.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Core sales opportunity record representing a potential deal for industrial automation, electrification, or smart infrastructure products. Tracks the full revenue pipeline from initial identification through close, including estimated value, probability, stage progression, expected close date, product lines of interest, competitive landscape, win/loss outcome, and primary loss reason. Sourced from Salesforce Sales Cloud Opportunity object. SSOT for all pipeline, forecast, and win/loss analysis data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique identifier for the commercial quotation record. Primary key.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Quote-to-Project conversion: links a quote to the project that will deliver the quoted solution, required for downstream execution.',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: Manufacturing quotes reference a specific catalog entry (catalog_number, list_price, standard_lead_time_days, warranty_period_months) as the commercial product definition. Direct FK supports quote gen',
    `contact_id` BIGINT COMMENT 'Reference to the primary customer contact person to whom the quote is addressed.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account (prospective or existing) to whom this quote is issued.',
    `installed_base_id` BIGINT COMMENT 'Foreign key linking to service.installed_base. Business justification: Upgrade/replacement quoting process: quotes for equipment upgrades or replacements must reference the specific installed asset to validate compatibility, apply trade-in credits, and configure the repl',
    `previous_quote_id` BIGINT COMMENT 'Reference to the prior version of this quote if this is a revision or amendment.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: A commercial quotation is issued under a specific price book (standard or customer-specific), which governs the pricing framework for all line items on the quote. Adding price_book_id to quote establi',
    `sales_contract_id` BIGINT COMMENT 'Reference to the formal contract record created when the quote is accepted and converted to an order.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for creating and managing this quote.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Quote generation validates that the quoted SKU holds the necessary product certification (e.g., CE, UL) before pricing is presented.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Quoting / lead-time calculation: the source warehouse determines shipping lead times, freight costs, and customs compliance included in a quote. Manufacturing sales teams must specify the supply wareh',
    `accepted_date` DATE COMMENT 'Date on which the customer formally accepted the quote, triggering order creation.',
    `approval_date` DATE COMMENT 'Date on which the quote received final internal approval.',
    `approval_status` STRING COMMENT 'Status of internal approval workflow for the quote, particularly for non-standard pricing or terms.. Valid values are `not_required|pending|approved|rejected`',
    `competitor_name` STRING COMMENT 'Name of the primary competitor identified in the sales opportunity for this quote.',
    `configuration_summary` STRING COMMENT 'High-level summary of the product configuration details included in the quote (e.g., system specifications, key components, customization notes).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the quote is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of days from order confirmation to delivery of the quoted products.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all discounts applied to the quote (standard and non-standard).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount rate applied to the quote, expressed as a percentage of the subtotal.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was last updated or modified.',
    `quote_name` STRING COMMENT 'Descriptive name or title of the quote, typically reflecting the project or product scope (e.g., Factory Automation System - Plant 5).',
    `non_standard_discount_flag` BOOLEAN COMMENT 'Indicates whether the quote includes discounts that exceed standard approval thresholds and require special authorization.',
    `notes` STRING COMMENT 'Internal notes and comments related to the quote, including negotiation history, customer feedback, and special considerations.',
    `payment_terms` STRING COMMENT 'Contractual payment terms offered to the customer (e.g., Net 30, 50% upfront / 50% on delivery, Letter of Credit).',
    `presented_date` DATE COMMENT 'Date on which the quote was formally presented to the customer.',
    `quote_date` DATE COMMENT 'Date on which the quote was formally issued to the customer.',
    `quote_number` STRING COMMENT 'Externally visible business identifier for the quote. Used in customer communications and contract references.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `quote_status` STRING COMMENT 'Current lifecycle status of the quote in the sales workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|presented|accepted|rejected|expired — 7 candidates stripped; promote to reference product]',
    `quote_type` STRING COMMENT 'Classification of the quote based on the nature of the commercial transaction.. Valid values are `new_business|renewal|amendment|upsell|replacement`',
    `rejected_date` DATE COMMENT 'Date on which the customer formally rejected or declined the quote.',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided by the customer for rejecting the quote (e.g., Price too high, Lead time unacceptable, Competitor selected).',
    `service_level_agreement` STRING COMMENT 'Service level commitments included in the quote (e.g., response time, uptime guarantees, maintenance windows).',
    `shipping_handling_amount` DECIMAL(18,2) COMMENT 'Estimated cost for shipping and handling of the quoted products to the customer site.',
    `shipping_method` STRING COMMENT 'Planned method of shipment for the quoted products (e.g., Air Freight, Ocean Freight, Ground Transport, Courier).',
    `special_terms_conditions` STRING COMMENT 'Additional contractual terms, conditions, or clauses specific to this quote that deviate from standard terms.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total value of all quoted line items before discounts, taxes, and adjustments.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated on the quote based on applicable tax jurisdictions and rates.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total value of the quote including all line items, discounts, taxes, and fees.',
    `valid_from_date` DATE COMMENT 'Date from which the quoted prices and terms become effective.',
    `valid_until_date` DATE COMMENT 'Expiration date after which the quote is no longer valid and prices/terms may change.',
    `version` STRING COMMENT 'Version number of the quote, incremented when revisions are made to pricing, terms, or configuration.',
    `warranty_terms` STRING COMMENT 'Description of warranty coverage included with the quoted products (duration, scope, exclusions).',
    `win_probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability (0-100%) that this quote will be accepted and converted to an order, based on sales assessment.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Commercial quotation issued to a prospective or existing industrial customer for automation systems, electrification solutions, or smart infrastructure components. Captures quoted price, discount structure (including approved non-standard discounts), validity period, payment terms, delivery lead time, configuration details, and approval status. Linked to an opportunity and may progress to a formal proposal or order. Sourced from Salesforce CPQ / Sales Cloud Quote object.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line item. Primary key.',
    `account_site_id` BIGINT COMMENT 'Reference to the engineering or implementation project associated with this quote line. Links sales to project execution.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: In MTO/ETO manufacturing, quote lines reference a specific BOM to drive cost rollup and lead time estimation during quoting. Direct FK to bom_header enables cost-to-quote analysis and BOM-driven prici',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: In manufacturing, quote line pricing is driven by BOM cost rollups. Linking quote_line to the BOM used for cost estimation enables cost-to-price analysis, margin reporting by BOM version, and ensures ',
    `bundle_parent_line_quote_line_id` BIGINT COMMENT 'Reference to the parent quote line if this line is part of a product bundle. Enables hierarchical quote structures for complex system quotes.',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: Manufacturing quote lines are built from catalog entries (orderable_flag, list_price, standard_lead_time_days, warranty_period_months). Direct FK supports quoting validation against catalog status and',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Quote creation requires exact component master data for pricing, lead time, and compliance; linking ensures accurate component reference.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: During manufacturing quoting, each quote line must reference the engineering specification defining technical requirements (tolerances, materials, performance criteria) being priced. This ensures the ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Quote line must reference internal material master for cost, inventory availability, and production planning.',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: Each quote line is priced against a specific price book entry (SKU-price association). Adding price_book_entry_id to quote_line establishes the authoritative pricing reference for the line item. The l',
    `sku_master_id` BIGINT COMMENT 'Reference to the product master record. Identifies the specific SKU (Stock Keeping Unit), product configuration, or service offering being quoted.',
    `quote_id` BIGINT COMMENT 'Reference to the parent commercial quotation header. Links this line item to its containing quote document.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Quotes must specify the component revision being sold to guarantee correct version delivery and regulatory compliance.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for this line item. Used for commission calculation and territory management.',
    `approval_level` STRING COMMENT 'The approval authority level required for this line item based on discount depth or special terms. Escalates based on business rules.. Valid values are `none|sales_manager|regional_director|vp_sales|cfo`',
    `commission_percent` DECIMAL(18,2) COMMENT 'The commission rate applicable to this line item for sales compensation. Business confidential.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed by the manufacturer for this line item. Based on production schedule and capacity planning.',
    `configuration_summary` STRING COMMENT 'Human-readable summary of the product configuration options selected. Describes customizations, options, and specifications for this line item.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost to manufacture or procure the items on this line. Used for margin analysis and profitability calculations. Business confidential.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this quote line record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The absolute monetary discount amount applied to this line item. Alternative to percentage-based discounts.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The percentage discount applied to the list price. Represents negotiated price concessions or promotional discounts.',
    `is_bundle_parent` BOOLEAN COMMENT 'Indicates whether this line item is a parent bundle that contains child line items. True for bundle headers, false for standalone or child items.',
    `is_optional` BOOLEAN COMMENT 'Indicates whether this line item is optional or required. Optional items may be removed by the customer without affecting the core quote.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this quote line record was last modified. Audit trail for change tracking.',
    `lead_time_days` STRING COMMENT 'The estimated lead time in days from order placement to delivery for this line item. Critical for production planning and customer expectations.',
    `line_number` STRING COMMENT 'Sequential line number within the quote. Determines the display order of line items on the quote document.',
    `line_status` STRING COMMENT 'The current status of this quote line item in the approval workflow. Tracks the lifecycle state of individual line items.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `line_type` STRING COMMENT 'Classification of the quote line item type. Distinguishes between hardware products, software, installation services, commissioning, and ongoing support services.. Valid values are `product|service|installation|commissioning|maintenance|spare_parts`',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for this item. Used for procurement and supply chain traceability.',
    `margin_amount` DECIMAL(18,2) COMMENT 'The gross margin amount for this line item. Calculated as subtotal amount minus cost amount. Business confidential.',
    `margin_percent` DECIMAL(18,2) COMMENT 'The gross margin percentage for this line item. Calculated as margin amount divided by subtotal amount. Business confidential.',
    `notes` STRING COMMENT 'Internal notes or comments about this quote line item. Used for collaboration between sales, engineering, and operations teams.',
    `product_family` STRING COMMENT 'The product family or category classification. Groups related products for reporting and analysis (e.g., Automation Systems, Electrification Solutions, Smart Infrastructure).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of units being quoted for this line item. Supports fractional quantities for materials sold by weight or volume.',
    `requested_delivery_date` DATE COMMENT 'The customer-requested delivery date for this line item. May differ from the committed delivery date based on production capacity.',
    `special_terms` STRING COMMENT 'Any special terms, conditions, or notes specific to this line item. May include warranty extensions, service level agreements, or custom provisions.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The extended line amount before taxes and fees. Calculated as quantity multiplied by unit price.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to this line item. May include VAT, sales tax, or other applicable taxes based on jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total line amount including all taxes and fees. Final amount for this line item that contributes to the quote total.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quoted quantity. Defines how the product or service is quantified (e.g., each, kilogram, meter, hour for services). [ENUM-REF-CANDIDATE: each|kg|meter|liter|hour|day|month|year|set — 9 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The actual selling price per unit after applying discounts and adjustments. This is the negotiated price for this specific quote.',
    CONSTRAINT pk_quote_line PRIMARY KEY(`quote_line_id`)
) COMMENT 'Individual line item within a commercial quotation, representing a specific SKU, product configuration, or service offering with its own quantity, unit price, discount, and extended amount. Supports multi-line complex industrial system quotes including hardware, software, installation, and commissioning services. Sourced from Salesforce CPQ Quote Line object.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` (
    `sales_contract_id` BIGINT COMMENT 'Unique identifier for the sales contract. Primary key for the sales contract entity.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Contract‑Project binding: ensures the contractual obligations are tied to the specific project for compliance and cost tracking.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to product.product_certification. Business justification: Manufacturing sales contracts specify required product certifications (CE, UL, ATEX, RoHS) as contractual compliance obligations. Direct FK to product_certification normalizes the plain-text complianc',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Linking contracts to credit profiles enables automated credit risk checks required for contract approval in manufacturing.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is the counterparty to this sales contract. Links to the customer master data for billing, shipping, and relationship management.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Manufacturing sales contracts for custom-engineered products contractually reference the engineering specification defining acceptance criteria, tolerances, and performance requirements. Contract disp',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity or deal that resulted in this executed contract. Links to CRM opportunity data for pipeline tracking and conversion analysis.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: An executed sales contract locks in a specific price book for the duration of the contract, governing contracted pricing for supply of industrial automation and electrification products. Adding price_',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Contracts often cover entire product families; linking enables compliance checks, warranty terms, and pricing rules per family.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for negotiating and managing this sales contract. Links to employee or sales team master data.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Manufacturing sales contracts require a named customer signatory for legal enforceability. sales_contract carries customer_signatory_name as a plain text denormalization of customer_contact. This FK e',
    `approval_date` DATE COMMENT 'Date when the sales contract received final internal approval and was authorized for execution. Marks completion of internal review and sign-off process.',
    `confidentiality_clause` STRING COMMENT 'Contractual provisions protecting proprietary information, trade secrets, technical specifications, and business data shared between parties. Defines confidential information, permitted uses, and disclosure restrictions.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the sales contract. Used for customer communication, legal reference, and cross-system tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the sales contract. Draft contracts are being prepared; pending approval contracts await internal or customer sign-off; active contracts are in force; suspended contracts are temporarily on hold; completed contracts have fulfilled all obligations; terminated contracts ended early by mutual agreement; cancelled contracts were voided before activation. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|completed|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the sales contract based on commercial structure. Standard contracts use pre-approved terms; custom contracts are negotiated; framework contracts establish terms for multiple orders; blanket contracts cover recurring purchases; spot contracts are one-time transactions; turnkey contracts include design, supply, and commissioning.. Valid values are `standard|custom|framework|blanket|spot|turnkey`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales contract record was first created in the system. Part of audit trail for data lineage and compliance.',
    `delivery_location` STRING COMMENT 'Physical address or site where contracted products, systems, or equipment will be delivered. May reference customer facility, project site, or designated warehouse.',
    `delivery_schedule` STRING COMMENT 'Detailed timeline and milestones for delivery of products, systems, or services under the sales contract. May include phased deliveries, installation schedules, and commissioning dates.',
    `dispute_resolution_method` STRING COMMENT 'Agreed mechanism for resolving disputes arising from the sales contract. Litigation involves court proceedings; arbitration uses neutral arbitrators; mediation involves facilitated negotiation; negotiation is direct party-to-party resolution.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `document_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the digitally stored executed sales contract document. Links to document management system or secure repository.',
    `effective_date` DATE COMMENT 'Date when the sales contract becomes legally binding and enforceable. Marks the start of the contract period and triggers obligations for both parties.',
    `expiration_date` DATE COMMENT 'Date when the sales contract ends and obligations cease. Nullable for open-ended contracts or contracts with indefinite terms subject to termination clauses.',
    `force_majeure_clause` STRING COMMENT 'Contractual provisions excusing non-performance due to unforeseeable events beyond parties control such as natural disasters, war, pandemics, or government actions. Defines qualifying events and relief procedures.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and body of law that governs the interpretation, enforcement, and dispute resolution of the sales contract. Typically specifies country and state/province.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities, costs, and risks between buyer and seller for delivery of goods. Examples: EXW (Ex Works), FOB (Free On Board), CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Mandatory insurance coverage that the supplier or customer must maintain during contract performance. May include general liability, professional indemnity, product liability, or cargo insurance with specified coverage limits.',
    `intellectual_property_terms` STRING COMMENT 'Provisions defining ownership, licensing, and usage rights for intellectual property including patents, designs, software, documentation, and technical know-how. Specifies IP ownership and license grants.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability amount that either party can be held responsible for under the sales contract. Limits exposure for damages, losses, or claims arising from contract performance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales contract record was last updated in the system. Part of audit trail for change tracking and compliance.',
    `net_contract_value` DECIMAL(18,2) COMMENT 'Net monetary value of the sales contract after applying discounts, rebates, and before taxes. Represents the actual revenue to be recognized.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the sales contract. Used for internal communication and knowledge transfer.',
    `payment_method` STRING COMMENT 'Instrument or mechanism through which the customer will remit payment. Wire transfer for electronic bank transfers; letter of credit for trade finance; bank guarantee for secured payments; check for paper-based payments; credit card for card payments; direct debit for automated withdrawals.. Valid values are `wire_transfer|letter_of_credit|bank_guarantee|check|credit_card|direct_debit`',
    `payment_terms` STRING COMMENT 'Detailed description of payment conditions including milestones, due dates, installment schedules, and payment triggers. Examples: Net 30, 50% upfront 50% on delivery, milestone-based payments.',
    `penalty_clause` STRING COMMENT 'Contractual provisions defining financial penalties or liquidated damages for non-performance, late delivery, or breach of SLA commitments. Specifies penalty amounts, triggers, and caps.',
    `renewal_terms` STRING COMMENT 'Provisions governing automatic renewal, renewal options, or renegotiation terms at contract expiration. Defines renewal notice periods, pricing adjustments, and renewal conditions.',
    `signature_date` DATE COMMENT 'Date when the sales contract was signed by both parties and became legally executed. May differ from effective date if contract has a future start date.',
    `sla_resolution_time_hours` STRING COMMENT 'Maximum number of hours within which the supplier must resolve customer issues or restore service under the contract. Part of SLA commitments for uptime and availability.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours within which the supplier must respond to customer service requests or incidents under the contract. Part of SLA commitments for support and maintenance.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed minimum uptime or availability percentage for systems, equipment, or services covered by the sales contract. Expressed as a percentage (e.g., 99.5% uptime).',
    `supplier_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the sales contract on behalf of the supplier. Used for legal verification and audit trail.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the sales contract. Includes VAT, GST, sales tax, or other applicable taxes based on jurisdiction and product classification.',
    `termination_clause` STRING COMMENT 'Contractual provisions defining conditions, notice periods, and procedures under which either party may terminate the sales contract. Includes termination for cause, convenience, or force majeure.',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sales contract representing the gross revenue commitment. Includes all line items, products, services, and deliverables before adjustments.',
    `value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value. Defines the currency in which all financial terms, payments, and penalties are denominated.. Valid values are `^[A-Z]{3}$`',
    `warranty_period_months` STRING COMMENT 'Duration in months for which the supplier provides warranty coverage for products, systems, or equipment delivered under the sales contract. Covers defects in materials and workmanship.',
    `warranty_terms` STRING COMMENT 'Detailed description of warranty provisions including coverage scope, exclusions, repair or replacement terms, and customer obligations. Defines what is covered and what is not under warranty.',
    CONSTRAINT pk_sales_contract PRIMARY KEY(`sales_contract_id`)
) COMMENT 'Executed commercial sales contract governing the terms and conditions for supply of industrial automation, electrification, or infrastructure products and systems. Captures contract value, duration, payment milestones, delivery schedule, SLA commitments, warranty provisions, penalty clauses, governing law, and Incoterms. Distinct from procurement contracts (owned by procurement domain) and service contracts (owned by service domain). SSOT for commercial sales agreement terms only.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `manager_rep_id` BIGINT COMMENT 'Reference to the sales representative record of this reps direct manager in the sales hierarchy.',
    `active_account_count` STRING COMMENT 'Number of active customer accounts currently assigned to and managed by this sales representative.',
    `active_opportunity_count` STRING COMMENT 'Number of open sales opportunities currently in the representatives pipeline.',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Annual sales quota target assigned to the representative measured in base currency. Used for performance tracking and commission calculation.',
    `book_of_business_value` DECIMAL(18,2) COMMENT 'Total annual recurring revenue or contract value of the customer accounts currently managed by this sales representative.',
    `certification_list` STRING COMMENT 'Professional certifications held by the sales representative relevant to industrial automation and electrification sales, such as product certifications, technical sales training, or industry credentials.',
    `rep_code` STRING COMMENT 'Business-assigned unique code for the sales representative used in order entry, commission tracking, and reporting systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `commission_plan_code` STRING COMMENT 'Reference code to the commission plan structure governing how this sales representative earns variable compensation based on sales performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was first created in the sales system.',
    `crm_user_code` STRING COMMENT 'Salesforce Sales Cloud user identifier linking this sales representative to their CRM login and activity tracking.',
    `customer_segment` STRING COMMENT 'Target customer segment that the sales representative primarily serves based on account size and strategic importance.. Valid values are `enterprise|mid_market|small_business|strategic_accounts`',
    `email_address` STRING COMMENT 'Primary business email address for the sales representative used for customer communication and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `full_name` STRING COMMENT 'Full legal name of the sales representative as recorded in the sales system.',
    `hire_date` DATE COMMENT 'Date when the sales representative was hired into the sales organization.',
    `industry_vertical_focus` STRING COMMENT 'Target industry vertical or market segment that the sales representative focuses on, such as automotive, food and beverage, pharmaceuticals, or infrastructure.',
    `is_key_account_manager` BOOLEAN COMMENT 'Boolean flag indicating whether this sales representative is designated as a key account manager responsible for strategic, high-value customer relationships.',
    `language_proficiency` STRING COMMENT 'Languages spoken by the sales representative relevant for customer communication and territory coverage, stored as comma-separated language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was most recently updated in the sales system.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this sales representative.',
    `last_training_date` DATE COMMENT 'Date of the most recent sales training, product training, or professional development activity completed by the representative.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the sales representative used for field communication and urgent customer contact.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context about the sales representatives specializations, territory nuances, or other relevant information for sales operations.',
    `onboarding_completion_date` DATE COMMENT 'Date when the sales representative completed the formal onboarding and training program for new sales hires.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the sales representative based on quota attainment, customer satisfaction, and other Key Performance Indicators (KPIs).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Primary business phone number for the sales representative to be contacted by customers and internal stakeholders.',
    `product_line_specialization` STRING COMMENT 'Primary product line or solution area that the sales representative specializes in, such as drives, PLCs (Programmable Logic Controllers), switchgear, building automation, or electrification systems.',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `quota_period_end_date` DATE COMMENT 'End date of the current quota period for this sales representative.',
    `quota_period_start_date` DATE COMMENT 'Start date of the current quota period for this sales representative, typically aligned with fiscal year or calendar year.',
    `rep_status` STRING COMMENT 'Current lifecycle status of the sales representative indicating their availability and eligibility for sales assignments.. Valid values are `active|inactive|on_leave|terminated|suspended|probation`',
    `sales_channel` STRING COMMENT 'Primary sales channel through which the representative conducts business: direct to end customer, through channel partners, distributors, or Original Equipment Manufacturer (OEM) relationships.. Valid values are `direct|partner|distributor|oem|hybrid`',
    `sales_office_location` STRING COMMENT 'Primary office location or branch where the sales representative is based for administrative and reporting purposes.',
    `sales_role` STRING COMMENT 'Commercial role classification indicating the sales representatives position in the sales organization hierarchy.. Valid values are `individual_contributor|team_lead|regional_manager|district_manager|account_executive|sales_engineer`',
    `termination_date` DATE COMMENT 'Date when the sales representatives employment or sales role ended. Null for active representatives.',
    `travel_percentage` STRING COMMENT 'Expected percentage of work time spent traveling for customer visits, trade shows, and field sales activities.',
    `years_of_experience` STRING COMMENT 'Total years of sales experience in industrial automation, electrification, or related technical sales roles.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representative profile within the sales domain capturing commercial role, quota assignment, product line specialization (drives, PLCs, switchgear, building automation), territory alignment, and performance targets. Distinct from the workforce domain employee record — this is the sales-domain view of a seller including their book of business, commission plan reference, CRM user linkage, and sales hierarchy position (individual contributor, team lead, regional manager). Sourced from Salesforce User / Sales Cloud.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`price_book` (
    `price_book_id` BIGINT COMMENT 'Unique identifier for the price book record. Primary key.',
    `parent_price_book_id` BIGINT COMMENT 'Reference to a parent or master price book from which this price book inherits base pricing. Null if this is a top-level price book.',
    `approval_date` DATE COMMENT 'Date when the price book was approved for use by authorized personnel.',
    `approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether quotes or orders using this price book require management approval before finalization.',
    `price_book_code` STRING COMMENT 'Unique alphanumeric code identifying the price book for system integration and reporting purposes.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the specific country for which this price book applies. Null if applicable to multiple countries.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the price book record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all prices in this price book (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or classification for which this price book is intended (e.g., Enterprise, SMB, OEM Partners, Distributors, Government).',
    `price_book_description` STRING COMMENT 'Detailed description of the price book purpose, scope, and applicability (e.g., Standard list prices for North America industrial automation products effective Q1 2024).',
    `discount_policy` STRING COMMENT 'Reference to the discount policy or guidelines that govern allowable discounts from this price book (e.g., Standard 10% max, Volume-based tiered, No discounts allowed).',
    `effective_end_date` DATE COMMENT 'Date after which the price book is no longer valid for new transactions. Null indicates no expiration date.',
    `effective_start_date` DATE COMMENT 'Date from which the price book becomes valid and can be used for pricing sales transactions.',
    `industry_segment` STRING COMMENT 'Specific industry vertical or segment for which this price book is designed (e.g., Automotive Manufacturing, Food & Beverage, Pharmaceuticals, Energy & Utilities).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the price book is currently active and available for selection in sales opportunities and quotes.',
    `is_standard` BOOLEAN COMMENT 'Boolean flag indicating whether this is the standard (default) price book for the organization. Only one standard price book should be active at a time.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the price book record was last modified or updated.',
    `price_book_name` STRING COMMENT 'Business name of the price book (e.g., Standard Price Book, EMEA Industrial Automation 2024, OEM Partner Pricing).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the price book usage and applicability.',
    `price_book_status` STRING COMMENT 'Current lifecycle status of the price book indicating whether it is available for use in sales transactions.. Valid values are `active|inactive|draft|archived|pending_approval|expired`',
    `price_book_type` STRING COMMENT 'Classification of the price book indicating its purpose and usage context within the sales organization.. Valid values are `standard|custom|promotional|contract|oem|distributor`',
    `pricing_strategy` STRING COMMENT 'The pricing methodology or strategy applied in this price book (e.g., list pricing, cost-plus, competitive pricing, value-based pricing).. Valid values are `list|cost_plus|competitive|value_based|penetration|premium`',
    `product_line` STRING COMMENT 'Primary product line or family covered by this price book (e.g., Industrial Automation, Electrification Solutions, Smart Infrastructure, PLCs, Drives & Motors).',
    `region` STRING COMMENT 'Geographic region or territory for which this price book applies (e.g., North America, EMEA, APAC, LATAM).',
    `revision_date` DATE COMMENT 'Date when the current version of the price book was last revised or updated.',
    `source_system_code` STRING COMMENT 'Unique identifier of this price book in the source system for traceability and data lineage purposes.',
    `version` STRING COMMENT 'Version identifier for the price book to track revisions and updates over time (e.g., v1.0, 2024.Q1, Rev 3).',
    CONSTRAINT pk_price_book PRIMARY KEY(`price_book_id`)
) COMMENT 'Commercial price book defining the standard or customer-specific list prices for industrial automation products, electrification solutions, and smart infrastructure components. Captures price book name, currency, effective date range, customer segment applicability, and whether it is the standard or a custom price book. Sourced from Salesforce CPQ Price Book. SSOT for sales-side pricing (distinct from product catalog cost data).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` (
    `price_book_entry_id` BIGINT COMMENT 'Unique identifier for the price book entry record. Primary key.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Cost-margin analysis and pricing governance: price book entries define list prices for materials; linking to material_master enables direct comparison of list_price vs. moving_average_price/standard_p',
    `price_book_id` BIGINT COMMENT 'Reference to the parent price book that contains this entry. Links to the price book master record defining the pricing context (standard, regional, promotional).',
    `catalog_entry_id` BIGINT COMMENT 'Reference to the product or Stock Keeping Unit (SKU) that this price book entry applies to. Links to the product master record in the product catalog.',
    `tertiary_price_product_catalog_entry_id` BIGINT COMMENT 'FK to product.catalog_entry',
    `approval_status` STRING COMMENT 'The approval workflow status for this price book entry. Tracks whether custom or non-standard pricing has been reviewed and approved per governance policies.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_date` DATE COMMENT 'The date on which this price book entry was approved. Part of the audit trail for pricing governance and compliance.',
    `cost_price` DECIMAL(18,2) COMMENT 'The internal cost or standard cost of the product. Used for margin calculation and profitability analysis. Business-confidential data.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this price book entry record was first created in the system. Part of the standard audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which all prices in this entry are denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or tier for which this pricing applies (e.g., Enterprise, Mid-Market, Small Business, Government). Supports segment-based pricing strategies.',
    `price_book_entry_description` STRING COMMENT 'Additional notes or description providing context about this pricing entry, such as special terms, conditions, or the rationale for custom pricing.',
    `effective_end_date` DATE COMMENT 'The date after which this price book entry is no longer valid. Null indicates no expiration. Used for promotional pricing and seasonal campaigns.',
    `effective_start_date` DATE COMMENT 'The date from which this price book entry becomes valid and can be used in sales transactions. Supports time-bound pricing strategies.',
    `geography_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code indicating the geographic market for which this pricing applies (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this price book entry is currently active and available for use in quotes and orders. Inactive entries are retained for historical reference.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this price book entry record was last modified. Part of the standard audit trail for change tracking.',
    `lead_time_days` STRING COMMENT 'The standard lead time in days from order placement to delivery for this product. Used for delivery date estimation in quotes and orders.',
    `list_price` DECIMAL(18,2) COMMENT 'The standard published list price for this product in the specified currency. Represents the baseline price before any discounts or negotiations.',
    `market_segment` STRING COMMENT 'The target market segment or industry vertical for this product pricing (e.g., Automotive, Food & Beverage, Pharmaceuticals, Energy).',
    `maximum_discount_percent` DECIMAL(18,2) COMMENT 'The maximum allowable discount percentage that can be applied to this product without requiring special approval. Used to enforce pricing governance.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered for this product at this price. Enforces Minimum Order Quantity (MOQ) policies in Configure Price Quote (CPQ) systems.',
    `minimum_price` DECIMAL(18,2) COMMENT 'The floor price below which this product cannot be sold. Used to enforce pricing policies and protect margin thresholds in Configure Price Quote (CPQ) processes.',
    `price_book_entry_name` STRING COMMENT 'A descriptive name or label for this price book entry, typically combining product name, price book name, and currency for easy identification in reports and user interfaces.',
    `price_type` STRING COMMENT 'The type or nature of the price (e.g., list price, negotiated price, promotional price, contract price, spot price). Indicates the pricing strategy applied.. Valid values are `list|negotiated|promotional|contract|spot`',
    `pricing_method` STRING COMMENT 'The methodology used to determine the price (e.g., fixed, cost-plus, market-based, value-based). Supports pricing strategy analysis and governance.. Valid values are `fixed|cost_plus|market_based|value_based`',
    `product_family` STRING COMMENT 'The product family or category to which this product belongs (e.g., Automation Controllers, Electrification Components, SCADA Systems). Used for reporting and segmentation.',
    `product_line` STRING COMMENT 'The business product line or division responsible for this product (e.g., Industrial Automation, Building Technologies, Mobility Solutions).',
    `sales_channel` STRING COMMENT 'The sales channel through which this pricing is applicable (e.g., direct sales, distributor, partner, Original Equipment Manufacturer (OEM), online).. Valid values are `direct|distributor|partner|oem|online`',
    `tax_code` STRING COMMENT 'The tax classification code that determines applicable sales tax, Value Added Tax (VAT), or Goods and Services Tax (GST) rates for this product in the specified geography.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pricing (e.g., Each, Box, Pallet, Kilogram, Meter). Defines the quantity basis for the unit price.',
    `unit_price` DECIMAL(18,2) COMMENT 'The effective selling price per unit for this product in the price book. May differ from list price due to volume discounts, promotions, or regional adjustments.',
    `use_standard_price` BOOLEAN COMMENT 'Indicates whether this entry uses the standard price book price or a custom price. True means standard pricing applies; false indicates custom or negotiated pricing.',
    CONSTRAINT pk_price_book_entry PRIMARY KEY(`price_book_entry_id`)
) COMMENT 'Individual product-price association within a price book, linking a specific SKU or product configuration to its list price, minimum price, and discount thresholds for a given currency and effective period. Supports multi-currency industrial sales across global markets and enables CPQ-driven automated pricing in Salesforce.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` (
    `order_intake_id` BIGINT COMMENT 'Primary key for order_intake',
    `account_site_id` BIGINT COMMENT 'Reference to the customer project or program this order is associated with. Used for project-based revenue tracking and multi-phase delivery coordination.',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: Order intake in manufacturing must validate against the catalog entrys orderable_flag, lifecycle_stage, and standard_lead_time_days. Direct FK enables order acceptance validation against commercial p',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: In manufacturing O2C, the customer contact who issued or approved the purchase order is recorded on the order intake for order confirmation, dispute resolution, and delivery communication workflows. A',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to billing.credit_limit. Business justification: order_intake already carries credit_check_status and credit_approval_date, indicating a credit limit check occurs at order acceptance. Linking directly to the credit_limit record supports the credit a',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Manufacturing O2C requires a credit check against the customers credit profile at order booking. order_intake carries credit_check_status and credit_approval_date, which are operationally tied to a s',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account placing the order. Links to the master customer account record.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order intake records the exact material to be delivered, linking to inventory for allocation and picking.',
    `opportunity_id` BIGINT COMMENT 'Reference to the won sales opportunity that generated this order intake. Links to the originating opportunity record in Salesforce Sales Cloud.',
    `quote_id` BIGINT COMMENT 'Reference to the accepted quote that was converted into this order intake. May be null if order originated directly from opportunity without formal quote.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the master sales contract or framework agreement under which this order was placed. May be null for spot orders without framework agreement.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager who owns this order intake. Used for quota attainment and commission calculation.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Order intake processing must map incoming orders to the master product record for inventory allocation and production scheduling.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: In manufacturing, each order intake is governed by a specific SLA agreement that sets committed delivery targets and penalty terms. Linking order_intake to sla_agreement enables SLA compliance trackin',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Order fulfillment / ATP process: when a sales order is booked, the committed fulfillment stock location must be recorded to drive pick-list generation, available-to-promise checks, and shipment planni',
    `booking_recognition_date` DATE COMMENT 'The date when this order intake was recognized as a booking for quota and sales performance measurement. May differ from intake date based on validation rules.',
    `booking_recognized_flag` BOOLEAN COMMENT 'Indicates whether this order intake has been recognized as a booking against sales quota. True when order meets booking recognition criteria per sales policy.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed by sales to the customer. May differ from requested date based on production capacity and supply chain constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order intake record was first created. Used for audit trail and data lineage tracking.',
    `credit_approval_date` DATE COMMENT 'Date when credit approval was granted for this order, if required. Null if order did not require credit approval or is still pending.',
    `credit_check_status` STRING COMMENT 'Result of the customer credit check performed at order intake. Orders failing credit check may require advance payment or credit approval before handoff to fulfillment.. Valid values are `Passed|Failed|Pending|Waived|Manual Review`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value. Essential for multi-currency sales operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `customer_po_date` DATE COMMENT 'The date on the customers purchase order. Used for contract compliance verification and order validity checks.',
    `customer_po_number` STRING COMMENT 'The customers purchase order reference number. Critical for order validation, invoicing, and customer reconciliation. May be required per customer contract terms.',
    `delivery_location` STRING COMMENT 'The customers delivery address or site location for this order. May reference a customer site ID or contain full address details.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied at intake date to convert order value to base currency. Locked at intake for consistent booking valuation.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter in which this order intake was booked. Format Q1-YYYY through Q4-YYYY. Used for quarterly sales performance reporting and quota tracking.. Valid values are `^Q[1-4]-[0-9]{4}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this order intake was booked. Used for annual sales performance reporting and year-over-year growth analysis.',
    `handoff_date` DATE COMMENT 'The date when the order intake was successfully handed off to the order management domain. Used for sales-to-fulfillment cycle time KPI calculation.',
    `handoff_status` STRING COMMENT 'Current status of the handoff from sales to order management domain. Tracks the intake record through validation, transfer, and acceptance by the fulfillment organization.. Valid values are `Pending|Validated|Transferred|Accepted|Rejected|On Hold`',
    `incoterms` STRING COMMENT 'The Incoterms rule defining the division of costs and risks between buyer and seller. Critical for international trade compliance and logistics planning. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `industry_segment` STRING COMMENT 'The customers industry segment or vertical market. Used for market analysis, sales territory planning, and industry-specific KPI tracking.',
    `intake_date` DATE COMMENT 'The date when the order was officially received and recorded in the sales system. This is the booking date used for sales quota recognition and revenue pipeline tracking.',
    `intake_number` STRING COMMENT 'Business identifier for the order intake record. Human-readable unique number used for tracking and reference in sales reporting and KPI dashboards.. Valid values are `^OI-[0-9]{8}$`',
    `intake_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the order intake record was created in the system. Used for sales-to-fulfillment cycle time measurement and operational analytics.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this order intake record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order intake record was last updated. Used for change tracking and data synchronization.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this order intake. May include customer requests, internal coordination notes, or special handling instructions.',
    `order_management_reference` STRING COMMENT 'The order number or reference assigned by the order management system after handoff. Links this sales intake record to the authoritative order record in SAP SD or equivalent ERP.',
    `order_priority` STRING COMMENT 'The priority level assigned to this order intake. Influences production scheduling and resource allocation in the fulfillment process.. Valid values are `Standard|High|Urgent|Critical`',
    `order_type` STRING COMMENT 'Classification of the order by business type. Distinguishes between new customer acquisition, existing customer expansion, and service orders for sales mix analysis. [ENUM-REF-CANDIDATE: New Business|Renewal|Upgrade|Add-On|Replacement|Service|Spare Parts — 7 candidates stripped; promote to reference product]',
    `order_value` DECIMAL(18,2) COMMENT 'The total confirmed order value at intake. This is the gross order amount before any adjustments, used for sales booking recognition and quota attainment calculation.',
    `order_value_base_currency` DECIMAL(18,2) COMMENT 'Order value converted to the companys base reporting currency using the exchange rate at intake date. Used for consolidated sales reporting and KPI tracking.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this order. Defines when payment is due relative to delivery or invoice date. Critical for cash flow forecasting and credit risk management. [ENUM-REF-CANDIDATE: Net 30|Net 45|Net 60|Net 90|Advance Payment|Letter of Credit|Installment|Custom — 8 candidates stripped; promote to reference product]',
    `payment_terms_days` STRING COMMENT 'Number of days until payment is due per the agreed payment terms. Used for accounts receivable forecasting and working capital planning.',
    `product_line` STRING COMMENT 'The primary product line or business unit for this order. Used for sales performance segmentation and product portfolio analysis.',
    `requested_delivery_date` DATE COMMENT 'The customers requested delivery date as captured at order intake. Used for production planning coordination and customer expectation management.',
    `shipping_method` STRING COMMENT 'The agreed shipping or transportation method for order delivery. Impacts delivery lead time and logistics cost allocation. [ENUM-REF-CANDIDATE: Air Freight|Sea Freight|Road Transport|Rail|Courier|Customer Pickup|Multimodal — 7 candidates stripped; promote to reference product]',
    `special_terms_conditions` STRING COMMENT 'Any special commercial terms, conditions, or customer-specific agreements applicable to this order. May include warranty extensions, service level commitments, or pricing exceptions.',
    `created_by` STRING COMMENT 'Username or identifier of the sales user who created this order intake record in the system.',
    CONSTRAINT pk_order_intake PRIMARY KEY(`order_intake_id`)
) COMMENT 'Sales order intake record capturing the commercial handoff from a won opportunity or accepted quote to the order management domain. Records the intake date, confirmed order value, customer PO reference, requested delivery date, payment terms confirmed, and handoff status. This is NOT the SSOT for order fulfillment data — the authoritative order record lives in the order domain. The sales domain retains this record solely for order intake KPI tracking, sales-to-fulfillment cycle time measurement, and booking recognition against quota.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_previous_quote_id` FOREIGN KEY (`previous_quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bundle_parent_line_quote_line_id` FOREIGN KEY (`bundle_parent_line_quote_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_parent_price_book_id` FOREIGN KEY (`parent_price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `delivery_installation_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Installation Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `delivery_installation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `expected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `has_open_activity` SET TAGS ('dbx_business_glossary_term' = 'Has Open Activity Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `is_private` SET TAGS ('dbx_business_glossary_term' = 'Is Private Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `is_won` SET TAGS ('dbx_business_glossary_term' = 'Is Won Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_value_regex' = 'web|trade_show|referral|partner|cold_call|campaign');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Loss Reason');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_value_regex' = 'price|competitor|no_decision|timing|product_fit|budget');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Step');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_value_regex' = 'new_business|existing_customer|renewal|upgrade');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `sales_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Sales Cycle Duration Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Sales Stage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `stage_changed_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Changed Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `previous_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Quote Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Acceptance Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `configuration_summary` SET TAGS ('dbx_business_glossary_term' = 'Configuration Summary');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_name` SET TAGS ('dbx_business_glossary_term' = 'Quote Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `non_standard_discount_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Standard Discount Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `presented_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Presentation Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'new_business|renewal|amendment|upsell|replacement');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `rejected_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Rejection Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `shipping_handling_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping and Handling Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Terms and Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Subtotal Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Total Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `win_probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `bundle_parent_line_quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Parent Line Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'none|sales_manager|regional_director|vp_sales|cfo');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `commission_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `commission_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `configuration_summary` SET TAGS ('dbx_business_glossary_term' = 'Configuration Summary');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `is_bundle_parent` SET TAGS ('dbx_business_glossary_term' = 'Is Bundle Parent Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `is_optional` SET TAGS ('dbx_business_glossary_term' = 'Is Optional Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'product|service|installation|commissioning|maintenance|spare_parts');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `special_terms` SET TAGS ('dbx_business_glossary_term' = 'Special Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'standard|custom|framework|blanket|spot|turnkey');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `intellectual_property_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `net_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Net Contract Value');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|letter_of_credit|bank_guarantee|check|credit_card|direct_debit');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signature Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sla_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'representative_operations');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `active_account_count` SET TAGS ('dbx_business_glossary_term' = 'Active Account Count');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `active_opportunity_count` SET TAGS ('dbx_business_glossary_term' = 'Active Opportunity Count');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Quota Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `book_of_business_value` SET TAGS ('dbx_business_glossary_term' = 'Book of Business Value');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `book_of_business_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `certification_list` SET TAGS ('dbx_business_glossary_term' = 'Certification List');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `crm_user_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) User ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `crm_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `crm_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|small_business|strategic_accounts');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Full Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Hire Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `industry_vertical_focus` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical Focus');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `is_key_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Is Key Account Manager Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Mobile Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `product_line_specialization` SET TAGS ('dbx_business_glossary_term' = 'Product Line Specialization');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `quota_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `quota_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended|probation');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|partner|distributor|oem|hybrid');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `sales_office_location` SET TAGS ('dbx_business_glossary_term' = 'Sales Office Location');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `sales_role` SET TAGS ('dbx_business_glossary_term' = 'Sales Role');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `sales_role` SET TAGS ('dbx_value_regex' = 'individual_contributor|team_lead|regional_manager|district_manager|account_executive|sales_engineer');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Termination Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `travel_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Sales Experience');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` SET TAGS ('dbx_subdomain' = 'pricing_catalog');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `parent_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Price Book ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_code` SET TAGS ('dbx_business_glossary_term' = 'Price Book Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_description` SET TAGS ('dbx_business_glossary_term' = 'Price Book Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `discount_policy` SET TAGS ('dbx_business_glossary_term' = 'Discount Policy');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `is_standard` SET TAGS ('dbx_business_glossary_term' = 'Is Standard Price Book Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_name` SET TAGS ('dbx_business_glossary_term' = 'Price Book Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price Book Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_status` SET TAGS ('dbx_business_glossary_term' = 'Price Book Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|pending_approval|expired');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_business_glossary_term' = 'Price Book Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_value_regex' = 'standard|custom|promotional|contract|oem|distributor');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'list|cost_plus|competitive|value_based|penetration|premium');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price Book Version');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` SET TAGS ('dbx_subdomain' = 'pricing_catalog');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `tertiary_price_product_catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Price Product Catalog Entry Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `tertiary_price_product_catalog_entry_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `maximum_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `minimum_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_name` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|negotiated|promotional|contract|spot');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'fixed|cost_plus|market_based|value_based');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|partner|oem|online');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `use_standard_price` SET TAGS ('dbx_business_glossary_term' = 'Use Standard Price Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` SET TAGS ('dbx_subdomain' = 'representative_operations');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `booking_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Recognition Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `booking_recognized_flag` SET TAGS ('dbx_business_glossary_term' = 'Booking Recognized Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Pending|Waived|Manual Review');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `customer_po_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `handoff_date` SET TAGS ('dbx_business_glossary_term' = 'Handoff Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `handoff_status` SET TAGS ('dbx_business_glossary_term' = 'Handoff Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `handoff_status` SET TAGS ('dbx_value_regex' = 'Pending|Validated|Transferred|Accepted|Rejected|On Hold');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `intake_date` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `intake_number` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `intake_number` SET TAGS ('dbx_value_regex' = '^OI-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `intake_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_management_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Management Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'Standard|High|Urgent|Critical');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_value` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Order Value');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_value_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Order Value in Base Currency');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Terms and Conditions');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
