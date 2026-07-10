-- Schema for Domain: sales | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`sales` COMMENT 'Sales and commercial domain managing the revenue pipeline including opportunities, quotes, proposals, contracts, order intake, sales pipeline tracking, territory management, and commercial KPIs for industrial automation and electrification products via Salesforce Sales Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that influenced or generated this opportunity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline forecasting allocates expected costs to cost centers for budgeting purposes.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this opportunity.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the primary contact person at the customer account for this opportunity.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or user who owns and is responsible for this opportunity.',
    `engineering_project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: New product opportunities trigger an engineering project; linking enables tracking of project initiation and status.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Opportunity tracking of a specific material enables demand forecasting and aligns inventory planning.',
    `territory_id` BIGINT COMMENT '',
    `primary_opportunity_territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Opportunity stores territory as free text; adding opportunity_territory_id creates a proper link to sales.territory, enabling consistent reporting and removing redundant string column.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Opportunity reporting by product family is essential for portfolio performance analysis and strategic sales planning.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Opportunity stage forecasts profit per profit center, supporting sales‑finance alignment.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project Execution Planning: tracks which project fulfills a won opportunity, essential for schedule and cost alignment.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the resulting contract or order if the opportunity was won and converted.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Opportunity is owned by a sales rep; adding sales_rep_id FK enables proper ownership tracking.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Opportunity pipeline and forecasting require linking each opportunity to the exact SKU being pursued, enabling accurate demand planning and revenue projection.',
    `quote_id` BIGINT COMMENT 'Reference to the quote that is currently synced with the opportunity amount and line items.',
    `amount` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity in the base currency. Represents the gross deal size before discounts.',
    `close_date` DATE COMMENT 'Target date by which the opportunity is expected to close (win or loss decision).',
    `closed_date` DATE COMMENT 'Actual date when the opportunity was marked as closed (won or lost). Null if still open.',
    `competitor_name` STRING COMMENT 'Name of the primary competitor identified in this sales opportunity.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the opportunity location.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
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
    `last_modified_timestamp` TIMESTAMP COMMENT '',
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
    `compliance_product_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.product_certification. Business justification: Quote generation validates that the quoted SKU holds the necessary product certification (e.g., CE, UL) before pricing is presented.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quote budgeting ties estimated costs to a cost center for cost‑control before order conversion.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account (prospective or existing) to whom this quote is issued.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the primary customer contact person to whom the quote is addressed.',
    `employee_id` BIGINT COMMENT 'Reference to the user (sales manager, director, or executive) who approved the quote.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Links Quote to the specific asset being quoted, supporting price calculation, warranty terms, and delivery scheduling.',
    `opportunity_id` BIGINT COMMENT '',
    `previous_quote_id` BIGINT COMMENT 'Reference to the prior version of this quote if this is a revision or amendment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Quote profitability analysis requires profit center linkage to calculate expected margin.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Quote-to-Project conversion: links a quote to the project that will deliver the quoted solution, required for downstream execution.',
    `quote_template_id` BIGINT COMMENT 'Reference to the document template used to generate the customer-facing quote document.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the formal contract record created when the quote is accepted and converted to an order.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for creating and managing this quote.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this quote is assigned for pipeline tracking and commission purposes.',
    `accepted_date` DATE COMMENT 'Date on which the customer formally accepted the quote, triggering order creation.',
    `approval_date` DATE COMMENT 'Date on which the quote received final internal approval.',
    `approval_status` STRING COMMENT 'Status of internal approval workflow for the quote, particularly for non-standard pricing or terms.. Valid values are `not_required|pending|approved|rejected`',
    `competitor_name` STRING COMMENT 'Name of the primary competitor identified in the sales opportunity for this quote.',
    `configuration_summary` DECIMAL(18,2) COMMENT 'High-level summary of the product configuration details included in the quote (e.g., system specifications, key components, customization notes).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the quote is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of days from order confirmation to delivery of the quoted products.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all discounts applied to the quote (standard and non-standard).',
    `discount_percent` DECIMAL(18,2) COMMENT '',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount rate applied to the quote, expressed as a percentage of the subtotal.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was last updated or modified.',
    `quote_name` STRING COMMENT 'Descriptive name or title of the quote, typically reflecting the project or product scope (e.g., Factory Automation System - Plant 5).',
    `non_standard_discount_flag` BOOLEAN COMMENT 'Indicates whether the quote includes discounts that exceed standard approval thresholds and require special authorization.',
    `notes` STRING COMMENT 'Internal notes and comments related to the quote, including negotiation history, customer feedback, and special considerations.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual payment terms offered to the customer (e.g., Net 30, 50% upfront / 50% on delivery, Letter of Credit).',
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
    `bundle_parent_line_id` BIGINT COMMENT 'Reference to the parent quote line if this line is part of a product bundle. Enables hierarchical quote structures for complex system quotes.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Quote creation requires exact component master data for pricing, lead time, and compliance; linking ensures accurate component reference.',
    `configuration_id` BIGINT COMMENT 'Reference to the product configuration record for complex configurable products. Links to CPQ (Configure Price Quote) configuration details.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Quotes must specify the component revision being sold to guarantee correct version delivery and regulatory compliance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Quote line must reference internal material master for cost, inventory availability, and production planning.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this quote line record. Audit trail for accountability.',
    `sku_master_id` BIGINT COMMENT 'Reference to the product master record. Identifies the specific SKU (Stock Keeping Unit), product configuration, or service offering being quoted.',
    `project_header_id` BIGINT COMMENT 'Reference to the engineering or implementation project associated with this quote line. Links sales to project execution.',
    `quote_id` BIGINT COMMENT 'Reference to the parent commercial quotation header. Links this line item to its containing quote document.',
    `quote_sku_master_id` BIGINT COMMENT '',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for this line item. Used for commission calculation and territory management.',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred supplier or vendor for this line item. Used for procurement planning and supply chain management.',
    `approval_level` STRING COMMENT 'The approval authority level required for this line item based on discount depth or special terms. Escalates based on business rules.. Valid values are `none|sales_manager|regional_director|vp_sales|cfo`',
    `commission_percent` DECIMAL(18,2) COMMENT 'The commission rate applicable to this line item for sales compensation. Business confidential.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed by the manufacturer for this line item. Based on production schedule and capacity planning.',
    `configuration_summary` DECIMAL(18,2) COMMENT 'Human-readable summary of the product configuration options selected. Describes customizations, options, and specifications for this line item.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost to manufacture or procure the items on this line. Used for margin analysis and profitability calculations. Business confidential.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this quote line record was first created in the system. Audit trail for record creation.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The absolute monetary discount amount applied to this line item. Alternative to percentage-based discounts.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The percentage discount applied to the list price. Represents negotiated price concessions or promotional discounts.',
    `is_bundle_parent` BOOLEAN COMMENT 'Indicates whether this line item is a parent bundle that contains child line items. True for bundle headers, false for standalone or child items.',
    `is_optional` BOOLEAN COMMENT 'Indicates whether this line item is optional or required. Optional items may be removed by the customer without affecting the core quote.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this quote line record was last modified. Audit trail for change tracking.',
    `lead_time_days` STRING COMMENT 'The estimated lead time in days from order placement to delivery for this line item. Critical for production planning and customer expectations.',
    `line_amount` DECIMAL(18,2) COMMENT '',
    `line_number` STRING COMMENT 'Sequential line number within the quote. Determines the display order of line items on the quote document.',
    `line_status` STRING COMMENT 'The current status of this quote line item in the approval workflow. Tracks the lifecycle state of individual line items.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `line_type` STRING COMMENT 'Classification of the quote line item type. Distinguishes between hardware products, software, installation services, commissioning, and ongoing support services.. Valid values are `product|service|installation|commissioning|maintenance|spare_parts`',
    `list_price` DECIMAL(18,2) COMMENT 'The standard catalog or list price per unit before any discounts. Base price from the product master or price book.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the proposal record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account to whom this proposal is submitted.',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity that this proposal supports.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Proposal‑Project handoff: associates an approved proposal with the resulting project, needed for resource planning and reporting.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Proposal includes a sales_territory string; adding proposal_territory_id provides a normalized reference to sales.territory and removes the redundant column.',
    `quote_id` BIGINT COMMENT 'Reference to the preliminary quote that preceded this formal proposal.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Proposal is authored by a sales rep; adding sales_rep_id FK captures responsibility.',
    `approval_date` DATE COMMENT 'Date when the proposal received final internal approval for submission.',
    `approval_status` STRING COMMENT 'Internal approval status tracking cross-functional review by engineering, legal, and commercial teams.. Valid values are `pending|engineering_approved|legal_approved|commercial_approved|fully_approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who provided final approval for the proposal.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the proposal including site conditions, customer responsibilities, and external dependencies.',
    `competitor_names` STRING COMMENT 'Names of known competitors also bidding for this project or opportunity.',
    `compliance_certifications` STRING COMMENT 'List of applicable compliance certifications and standards that the proposed solution meets (CE, UL, IEC 61131, ISO 13849, IEC 62443).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal record was first created in the system.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the proposal.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT '',
    `customer_contact_email` STRING COMMENT 'Email address of the primary customer contact for proposal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_name` STRING COMMENT 'Name of the primary customer contact person to whom the proposal is addressed.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the primary customer contact for proposal discussions.',
    `delivery_terms` STRING COMMENT 'Incoterms or delivery conditions specifying responsibilities for shipping, insurance, and risk transfer.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary discount amount applied to the proposal.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the proposal value as a commercial concession.',
    `estimated_completion_date` DATE COMMENT 'Proposed date for project completion and final delivery as outlined in the proposal.',
    `estimated_start_date` DATE COMMENT 'Proposed date for project commencement as outlined in the proposal.',
    `exclusions` STRING COMMENT 'Items, services, or responsibilities explicitly excluded from the proposal scope to manage expectations and risk.',
    `grand_total` DECIMAL(18,2) COMMENT 'Final total value of the proposal including all charges and taxes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal record was last updated or modified.',
    `notes` STRING COMMENT 'Additional internal notes, comments, or special instructions related to the proposal.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Detailed payment terms and conditions including milestones, schedules, and methods.',
    `prepared_by` STRING COMMENT 'Name or identifier of the sales engineer or proposal manager who prepared the proposal.',
    `pricing_breakdown` STRING COMMENT 'Itemized breakdown of pricing including equipment, engineering, installation, commissioning, training, and support costs.',
    `project_duration_days` DECIMAL(18,2) COMMENT 'Estimated total duration of the project from commencement to completion in calendar days.',
    `proposal_number` STRING COMMENT 'Externally visible unique business identifier for the proposal document.. Valid values are `^PROP-[0-9]{6,10}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the proposal in the sales process. [ENUM-REF-CANDIDATE: draft|under_review|approved|submitted|accepted|rejected|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `proposal_title` STRING COMMENT '',
    `proposal_type` STRING COMMENT 'Classification of the proposal based on its nature and scope (technical, commercial, combined, RFP response, EPC, turnkey).. Valid values are `technical|commercial|technical_commercial|rfp_response|epc|turnkey`',
    `rfp_reference_number` STRING COMMENT 'Customers RFP or tender reference number if this proposal is in response to a formal request.',
    `risk_clauses` STRING COMMENT 'Legal and commercial risk mitigation clauses including liability limitations, force majeure, and indemnification.',
    `scope_of_supply` STRING COMMENT 'Detailed description of all equipment, systems, services, and deliverables included in the proposal.',
    `solution_architecture_summary` STRING COMMENT 'High-level technical description of the proposed automation or electrification solution architecture.',
    `submission_date` DATE COMMENT 'Date when the proposal was formally submitted to the customer.',
    `submitted_date` TIMESTAMP COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the proposal based on jurisdiction and tax regulations.',
    `technical_specifications` STRING COMMENT 'Detailed technical specifications of the proposed equipment, systems, and components including performance parameters.',
    `title` STRING COMMENT 'Descriptive title of the proposal summarizing the project or solution being offered.',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the proposal including all line items, services, and charges before taxes.',
    `valid_until_date` DATE COMMENT 'Expiration date after which the proposal terms, pricing, and commitments are no longer binding.',
    `version` STRING COMMENT 'Version number of the proposal document to track revisions and amendments.. Valid values are `^[0-9]+.[0-9]+$`',
    `warranty_period_months` STRING COMMENT 'Duration of the warranty coverage offered for the proposed solution in months.',
    `warranty_terms` STRING COMMENT 'Detailed warranty terms and conditions including coverage scope, exclusions, and claim procedures.',
    `win_probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability of winning the proposal expressed as a percentage based on sales assessment.',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Formal technical and commercial proposal submitted to a customer or prospect for complex industrial automation or electrification projects. Includes solution architecture summary, scope of supply, technical specifications, pricing breakdown, project timeline, warranty terms, compliance certifications (CE, UL, IEC 61131, ISO 13849), and risk/exclusion clauses. Represents a more detailed and binding document than a quote, often requiring cross-functional review (engineering, legal, commercial) and multi-level approval. Linked to an opportunity and may reference one or more quotes. Common in EPC and large capital project sales cycles typical of industrial manufacturing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` (
    `sales_lead_id` BIGINT COMMENT 'Unique identifier for the sales lead record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated or influenced this lead.',
    `opportunity_id` BIGINT COMMENT 'Identifier of the opportunity record created when this lead was converted, establishing traceability from lead to opportunity.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account record created or matched when this lead was converted.',
    `customer_contact_id` BIGINT COMMENT 'Identifier of the contact record created when this lead was converted, linking the lead contact to the customer account.',
    `rep_id` BIGINT COMMENT 'Identifier of the sales representative or account executive currently assigned to this lead.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory to which this lead is assigned based on geography or account segmentation.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Estimated annual revenue of the prospective customer organization in USD.',
    `city` STRING COMMENT 'City where the prospective customer organization or contact is located.',
    `company_name` STRING COMMENT 'Name of the prospective customer organization (OEM, distributor, system integrator, or end-user).',
    `company_size` STRING COMMENT 'Size classification of the prospective customer organization based on employee count or revenue (small, medium, large, enterprise).. Valid values are `small|medium|large|enterprise`',
    `contact_first_name` STRING COMMENT 'First name of the primary contact person at the prospective customer organization.',
    `contact_last_name` STRING COMMENT 'Last name of the primary contact person at the prospective customer organization.',
    `contact_title` STRING COMMENT 'Job title or role of the primary contact (e.g., Plant Manager, Automation Engineer, Procurement Director).',
    `conversion_date` DATE COMMENT 'Date on which the lead was converted to an opportunity, marking the transition from unqualified to qualified sales stage.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the prospective customer is located (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the lead record was first created in the CRM system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `sales_lead_description` STRING COMMENT 'Free-text description of the lead, capturing additional context, project details, or special requirements.',
    `do_not_contact` BOOLEAN COMMENT 'Boolean flag indicating whether the lead has opted out of marketing communications or requested not to be contacted.',
    `email_address` STRING COMMENT 'Primary email address of the lead contact for communication and follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_count` STRING COMMENT 'Approximate number of employees at the prospective customer organization.',
    `estimated_close_date` DATE COMMENT 'Anticipated date by which the lead may convert to an opportunity and potentially close, if timeline is known.',
    `estimated_project_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of the potential project or opportunity in USD, if known at lead stage.',
    `estimated_value` DECIMAL(18,2) COMMENT '',
    `industry_segment` STRING COMMENT 'Industry vertical or segment of the prospective customer (e.g., automotive, food & beverage, pharmaceutical, discrete manufacturing, process manufacturing, oil & gas).. Valid values are `automotive|food_beverage|pharma|discrete_manufacturing|process_manufacturing|oil_gas`',
    `is_converted` BOOLEAN COMMENT 'Boolean flag indicating whether the lead has been converted to an opportunity (True) or remains in lead stage (False).',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, email, meeting) logged against this lead.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the lead record was last updated or modified.',
    `lead_name` STRING COMMENT '',
    `lead_number` STRING COMMENT 'Business-facing unique identifier for the lead, typically auto-generated by Salesforce CRM in format LEAD-########.. Valid values are `^LEAD-[0-9]{8}$`',
    `lead_score` STRING COMMENT '',
    `lead_source` STRING COMMENT 'Origin channel through which the lead was generated (e.g., trade show, website inquiry, partner referral, inbound call). [ENUM-REF-CANDIDATE: trade_show|website|referral|inbound_inquiry|partner|advertising|cold_call — 7 candidates stripped; promote to reference product]',
    `lead_status` STRING COMMENT 'Current qualification status of the lead in the sales pipeline (new, contacted, qualified, disqualified, converted to opportunity).. Valid values are `new|contacted|qualified|disqualified|converted`',
    `mobile_number` STRING COMMENT 'Mobile phone number of the lead contact for urgent or mobile communication.',
    `phone_number` STRING COMMENT 'Primary phone number of the lead contact for direct communication.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the prospective customer organization or contact location.',
    `product_interest_area` STRING COMMENT 'Product category or solution area the lead has expressed interest in (e.g., drives, PLCs, HMI, switchgear, building automation, SCADA systems, MES).',
    `qualification_notes` STRING COMMENT 'Free-text notes capturing qualification details, BANT criteria assessment (Budget, Authority, Need, Timeline), or disqualification reasons.',
    `qualified_date` TIMESTAMP COMMENT '',
    `rating` STRING COMMENT 'Qualitative assessment of lead temperature or priority (hot, warm, cold) based on engagement level and fit.. Valid values are `hot|warm|cold`',
    `score` STRING COMMENT 'Numeric score assigned to the lead based on qualification criteria, engagement behavior, and fit (typically 0-100 scale).',
    `source_detail` STRING COMMENT 'Additional detail about the lead source, such as specific trade show name, campaign identifier, or referring partner name.',
    `state_province` STRING COMMENT 'State or province where the prospective customer organization or contact is located.',
    `street_address` STRING COMMENT 'Street address of the prospective customer organization or contact location.',
    `website_url` STRING COMMENT 'Website URL of the prospective customer organization for research and account profiling.',
    CONSTRAINT pk_sales_lead PRIMARY KEY(`sales_lead_id`)
) COMMENT 'Unqualified sales lead representing an initial expression of interest from a prospective industrial customer, OEM, distributor, system integrator, or end-user organization. Captures lead source (trade show, website, referral, inbound inquiry), contact information, company size, industry segment (automotive, food & beverage, pharma, discrete manufacturing), product interest area (drives, PLCs, HMI, switchgear, building automation), estimated project value, and qualification status (new, contacted, qualified, disqualified). Sourced from Salesforce Sales Cloud Lead object. Converted to an opportunity upon meeting BANT or similar qualification criteria.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` (
    `sales_contract_id` BIGINT COMMENT 'Unique identifier for the sales contract. Primary key for the sales contract entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contract accounting requires mapping contract revenue/costs to a cost center for internal cost tracking.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Linking contracts to credit profiles enables automated credit risk checks required for contract approval in manufacturing.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is the counterparty to this sales contract. Links to the customer master data for billing, shipping, and relationship management.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or business unit that owns and is accountable for this sales contract. Responsible for contract administration, compliance, and customer relationship.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Contracts often cover specific equipment for service or warranty; linking provides traceability for compliance and service scheduling.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Contracts often cover entire product families; linking enables compliance checks, warranty terms, and pricing rules per family.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center assignment enables profit margin reporting per contract (mandatory for management reporting).',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Contract‑Project binding: ensures the contractual obligations are tied to the specific project for compliance and cost tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contracts embed clauses referencing the primary regulatory requirement governing the sale, enabling legal compliance tracking.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for negotiating and managing this sales contract. Links to employee or sales team master data.',
    `territory_id` BIGINT COMMENT 'Reference to the geographic or organizational sales territory to which this contract is assigned. Used for territory management, quota tracking, and commission calculation.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Sales contracts often reference a supplier responsible for warranty or service parts; linking enables warranty claim routing and supplier performance monitoring.',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity or deal that resulted in this executed contract. Links to CRM opportunity data for pipeline tracking and conversion analysis.',
    `quote_id` BIGINT COMMENT 'Reference to the formal quotation or proposal that was accepted and converted into this sales contract. Links to quote master data for pricing and terms traceability.',
    `approval_date` DATE COMMENT 'Date when the sales contract received final internal approval and was authorized for execution. Marks completion of internal review and sign-off process.',
    `auto_renewal_flag` BOOLEAN COMMENT '',
    `compliance_certifications_required` STRING COMMENT 'List of mandatory certifications, standards, or regulatory approvals that products or services must meet under the sales contract. Examples: CE marking, UL certification, ISO 9001, IEC 61131, OSHA compliance.',
    `confidentiality_clause` STRING COMMENT 'Contractual provisions protecting proprietary information, trade secrets, technical specifications, and business data shared between parties. Defines confidential information, permitted uses, and disclosure restrictions.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the sales contract. Used for customer communication, legal reference, and cross-system tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the sales contract. Draft contracts are being prepared; pending approval contracts await internal or customer sign-off; active contracts are in force; suspended contracts are temporarily on hold; completed contracts have fulfilled all obligations; terminated contracts ended early by mutual agreement; cancelled contracts were voided before activation. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|completed|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the sales contract based on commercial structure. Standard contracts use pre-approved terms; custom contracts are negotiated; framework contracts establish terms for multiple orders; blanket contracts cover recurring purchases; spot contracts are one-time transactions; turnkey contracts include design, supply, and commissioning.. Valid values are `standard|custom|framework|blanket|spot|turnkey`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales contract record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT '',
    `customer_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the sales contract on behalf of the customer. Used for legal verification and audit trail.',
    `delivery_location` STRING COMMENT 'Physical address or site where contracted products, systems, or equipment will be delivered. May reference customer facility, project site, or designated warehouse.',
    `delivery_schedule` STRING COMMENT 'Detailed timeline and milestones for delivery of products, systems, or services under the sales contract. May include phased deliveries, installation schedules, and commissioning dates.',
    `dispute_resolution_method` STRING COMMENT 'Agreed mechanism for resolving disputes arising from the sales contract. Litigation involves court proceedings; arbitration uses neutral arbitrators; mediation involves facilitated negotiation; negotiation is direct party-to-party resolution.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `document_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the digitally stored executed sales contract document. Links to document management system or secure repository.',
    `effective_date` DATE COMMENT 'Date when the sales contract becomes legally binding and enforceable. Marks the start of the contract period and triggers obligations for both parties.',
    `end_date` TIMESTAMP COMMENT '',
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
    `payment_method` DECIMAL(18,2) COMMENT 'Instrument or mechanism through which the customer will remit payment. Wire transfer for electronic bank transfers; letter of credit for trade finance; bank guarantee for secured payments; check for paper-based payments; credit card for card payments; direct debit for automated withdrawals.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Detailed description of payment conditions including milestones, due dates, installment schedules, and payment triggers. Examples: Net 30, 50% upfront 50% on delivery, milestone-based payments.',
    `penalty_clause` STRING COMMENT 'Contractual provisions defining financial penalties or liquidated damages for non-performance, late delivery, or breach of SLA commitments. Specifies penalty amounts, triggers, and caps.',
    `renewal_terms` STRING COMMENT 'Provisions governing automatic renewal, renewal options, or renegotiation terms at contract expiration. Defines renewal notice periods, pricing adjustments, and renewal conditions.',
    `signature_date` DATE COMMENT 'Date when the sales contract was signed by both parties and became legally executed. May differ from effective date if contract has a future start date.',
    `sla_resolution_time_hours` STRING COMMENT 'Maximum number of hours within which the supplier must resolve customer issues or restore service under the contract. Part of SLA commitments for uptime and availability.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours within which the supplier must respond to customer service requests or incidents under the contract. Part of SLA commitments for support and maintenance.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed minimum uptime or availability percentage for systems, equipment, or services covered by the sales contract. Expressed as a percentage (e.g., 99.5% uptime).',
    `start_date` TIMESTAMP COMMENT '',
    `supplier_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the sales contract on behalf of the supplier. Used for legal verification and audit trail.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the sales contract. Includes VAT, GST, sales tax, or other applicable taxes based on jurisdiction and product classification.',
    `termination_clause` STRING COMMENT 'Contractual provisions defining conditions, notice periods, and procedures under which either party may terminate the sales contract. Includes termination for cause, convenience, or force majeure.',
    `total_contract_value` DECIMAL(18,2) COMMENT '',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sales contract representing the gross revenue commitment. Includes all line items, products, services, and deliverables before adjustments.',
    `value_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the contract value. Defines the currency in which all financial terms, payments, and penalties are denominated.',
    `warranty_period_months` STRING COMMENT 'Duration in months for which the supplier provides warranty coverage for products, systems, or equipment delivered under the sales contract. Covers defects in materials and workmanship.',
    `warranty_terms` STRING COMMENT 'Detailed description of warranty provisions including coverage scope, exclusions, repair or replacement terms, and customer obligations. Defines what is covered and what is not under warranty.',
    CONSTRAINT pk_sales_contract PRIMARY KEY(`sales_contract_id`)
) COMMENT 'Executed commercial sales contract governing the terms and conditions for supply of industrial automation, electrification, or infrastructure products and systems. Captures contract value, duration, payment milestones, delivery schedule, SLA commitments, warranty provisions, penalty clauses, governing law, and Incoterms. Distinct from procurement contracts (owned by procurement domain) and service contracts (owned by service domain). SSOT for commercial sales agreement terms only.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `employee_id` BIGINT COMMENT 'Reference to the sales manager or territory owner responsible for this territory. Links to employee or user record in Salesforce or Workday HCM.',
    `parent_territory_id` BIGINT COMMENT 'Reference to the parent territory in the hierarchical territory structure. Null for top-level territories.',
    `account_count` STRING COMMENT 'Total number of customer accounts assigned to this territory. Used for territory balance and coverage analysis.',
    `annual_revenue_quota` DECIMAL(18,2) COMMENT 'Target annual revenue quota assigned to this territory in the base currency. Used for quota attainment tracking and sales performance measurement.',
    `approval_status` STRING COMMENT 'Approval workflow status for territory definition changes: draft (being edited), pending_approval (submitted for review), approved (finalized), or rejected (not approved).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the sales leader or executive who approved this territory definition. Used for governance and audit trail.',
    `approved_date` DATE COMMENT 'Date when the territory definition was formally approved. Used for compliance and change tracking.',
    `assignment_rule` STRING COMMENT 'Business rule or criteria used to assign accounts or opportunities to this territory (e.g., Postal codes 10000-19999, Annual revenue > $1M in automotive sector). Free-text description of assignment logic.',
    `territory_code` STRING COMMENT 'Business identifier code for the territory used in Salesforce Sales Cloud and reporting systems. Externally-known unique code.. Valid values are `^[A-Z0-9]{3,15}$`',
    `commission_plan_code` STRING COMMENT 'Reference code to the commission or incentive compensation plan applicable to sales representatives in this territory. Links to compensation management system.',
    `country_code` STRING COMMENT '',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes covered by this territory (e.g., USA,CAN,MEX or DEU,AUT,CHE).',
    `coverage_model` STRING COMMENT 'Sales coverage approach for this territory: direct (direct sales force), channel (partner/distributor), hybrid (combination), inside_sales (remote/phone), or field_sales (on-site visits).. Valid values are `direct|channel|hybrid|inside_sales|field_sales`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was first created in the system. Used for audit trail and data lineage.',
    `territory_description` STRING COMMENT 'Detailed textual description of the territory scope, strategic objectives, and special considerations. Provides context for territory planning and handoff.',
    `effective_end_date` DATE COMMENT 'Date when this territory definition expires or is superseded. Null for currently active territories with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this territory definition becomes active and operational. Used for territory planning and historical tracking.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this territory definition and quota are applicable (e.g., FY2024, FY2025). Enables year-over-year territory comparison.. Valid values are `^FY[0-9]{4}$`',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic coverage (e.g., Germany, Austria, Switzerland, US Northeast Corridor, Asia-Pacific excluding China).',
    `industry_vertical` STRING COMMENT 'Target industry sector or vertical market for this territory (e.g., Automotive Manufacturing, Food & Beverage, Pharmaceuticals, Energy & Utilities). Applicable when territory_type includes industry_vertical.',
    `is_active` BOOLEAN COMMENT '',
    `is_overlay_territory` BOOLEAN COMMENT 'Boolean flag indicating whether this is an overlay territory (True) that operates across other territories for specialized products or services, or a standard exclusive territory (False).',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the primary business language in this territory (e.g., en, de, zh, es). Used for localization and communication planning.. Valid values are `^[a-z]{2}$`',
    `market_segment` STRING COMMENT 'Target customer segment for this territory: enterprise (large corporations), mid_market (medium businesses), smb (small business), oem (Original Equipment Manufacturer), government (public sector), or education (academic institutions).. Valid values are `enterprise|mid_market|smb|oem|government|education`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was last modified. Used for change tracking and synchronization.',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory (e.g., North America Industrial Automation, EMEA Electrification Solutions).',
    `notes` STRING COMMENT 'Free-form notes and comments about the territory, including special instructions, historical context, or strategic considerations. Used for knowledge transfer and planning.',
    `overlay_type` STRING COMMENT 'Type of overlay territory if is_overlay_territory is True: product_specialist (specific product expertise), solution_architect (technical pre-sales), key_account (strategic account support), or none (not an overlay).. Valid values are `product_specialist|solution_architect|key_account|none`',
    `priority_level` STRING COMMENT 'Strategic priority classification of the territory: strategic (top-tier), high (important growth area), medium (standard), low (maintenance), or emerging (new market development).. Valid values are `strategic|high|medium|low|emerging`',
    `product_line_scope` STRING COMMENT 'Comma-separated list of product lines or families assigned to this territory (e.g., PLC,SCADA,HMI or Electrification,Automation,Digitalization). Defines which products the territory sales team is responsible for.',
    `quota_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the revenue quota (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `quota_period` STRING COMMENT 'Time period for quota measurement: annual (yearly), semi_annual (twice per year), quarterly (every quarter), or monthly.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `region` STRING COMMENT '',
    `region_level` STRING COMMENT 'Hierarchical level of the territory within the organizational geography: global (worldwide), regional (multi-country), country (single nation), local (sub-national), district (city/metro), or zone (sub-district).. Valid values are `global|regional|country|local|district|zone`',
    `sales_channel` STRING COMMENT 'Primary sales channel used in this territory: direct (company sales force), distributor (third-party distributor), reseller (value-added reseller), online (e-commerce), oem (embedded in OEM products), or system_integrator (SI partner).. Valid values are `direct|distributor|reseller|online|oem|system_integrator`',
    `sales_team_size` STRING COMMENT 'Number of sales representatives assigned to this territory. Used for capacity planning and workload distribution.',
    `source_system_code` STRING COMMENT 'Unique identifier of this territory in the source system. Used for cross-system reconciliation and data integration.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory: active (operational), inactive (not in use), pending (awaiting activation), suspended (temporarily disabled), archived (historical), or planned (future territory).. Valid values are `active|inactive|pending|suspended|archived|planned`',
    `territory_type` STRING COMMENT 'Classification of territory assignment model: geographic (region-based), industry_vertical (sector-based), account_based (strategic accounts), product_line (product family focus), hybrid (combination), or named_account (specific customer assignment).. Valid values are `geographic|industry_vertical|account_based|product_line|hybrid|named_account`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/New_York, Europe/Berlin, Asia/Shanghai). Used for scheduling and activity coordination.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Sales territory definition representing a geographic, industry-vertical, or account-based assignment used to organize the sales force for industrial automation and electrification markets. Captures territory code, region hierarchy (global/regional/local), assigned revenue quota, product line scope, and effective dates. Enables territory-based pipeline reporting and quota attainment tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` (
    `territory_assignment_id` BIGINT COMMENT 'Unique identifier for the territory assignment record. Primary key for the territory assignment entity.',
    `primary_predecessor_assignment_territory_assignment_id` BIGINT COMMENT 'Identifier of the previous territory assignment record that this assignment replaces. Used to track territory transition history and account handoff lineage. Nullable for initial assignments.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales manager or team leader to whom this sales representative reports for this territory assignment. Supports matrix reporting structures where a specialist may report to a different manager than the primary account manager.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory being assigned. References the geographic or account-based territory definition.',
    `rep_id` BIGINT COMMENT '',
    `territory_sales_rep_id` BIGINT COMMENT 'Identifier of the sales representative or sales team member assigned to the territory. May reference individual contributor or team lead.',
    `approval_date` DATE COMMENT 'Date when the territory assignment was approved by management. Used for audit trail and effective date validation. Nullable for assignments not requiring approval.',
    `approval_status` STRING COMMENT 'Workflow approval status for the territory assignment. Draft indicates in preparation; pending approval indicates submitted for review; approved indicates management authorization; rejected indicates denied assignment. Used in territory planning and governance.. Valid values are `draft|pending_approval|approved|rejected`',
    `assignment_end_date` TIMESTAMP COMMENT '',
    `assignment_notes` STRING COMMENT 'Free-text notes documenting special conditions, transition plans, account handoff details, or coverage agreements for this territory assignment. Used for knowledge transfer and audit trail.',
    `assignment_priority` STRING COMMENT 'Numeric priority ranking for this assignment when multiple representatives cover the same territory. Lower numbers indicate higher priority. Used for opportunity routing and conflict resolution in matrix sales organizations.',
    `assignment_reason` STRING COMMENT 'Business reason for creating this territory assignment. New hire indicates onboarding; territory realignment indicates organizational restructuring; promotion indicates role change; backfill indicates replacement; expansion indicates market growth; specialization indicates product or vertical focus; temporary coverage indicates short-term assignment; leave replacement indicates coverage during absence. [ENUM-REF-CANDIDATE: new_hire|territory_realignment|promotion|backfill|expansion|specialization|temporary_coverage|leave_replacement — 8 candidates stripped; promote to reference product]',
    `assignment_role` STRING COMMENT '',
    `assignment_source` STRING COMMENT 'Origin of the territory assignment record. Manual indicates user-created; automated rule indicates system-generated based on assignment rules; territory model indicates derived from territory planning model; import indicates bulk data load; api indicates external system integration.. Valid values are `manual|automated_rule|territory_model|import|api`',
    `assignment_start_date` TIMESTAMP COMMENT '',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the territory assignment. Active indicates currently in effect; inactive indicates terminated; pending indicates future-dated assignment not yet effective; suspended indicates temporarily paused; expired indicates past end date.. Valid values are `active|inactive|pending|suspended|expired`',
    `assignment_type` STRING COMMENT 'Classification of the assignment role. Primary indicates main account owner; overlay indicates supporting specialist; product specialist indicates domain expert (e.g., drives, PLC, building automation); technical specialist indicates pre-sales engineering support; inside sales indicates remote coverage; channel partner indicates indirect sales coverage.. Valid values are `primary|overlay|product_specialist|technical_specialist|inside_sales|channel_partner`',
    `assignment_version` STRING COMMENT 'Version number of the territory assignment record. Incremented with each modification to support change tracking and audit history. Used in territory planning and governance.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether this assignment is eligible for commission calculation. True for quota-carrying roles; false for support roles or salaried positions. Used in compensation processing.',
    `coverage_level` STRING COMMENT 'Scope of coverage responsibility within the territory. Full indicates complete account coverage; partial indicates subset of accounts or opportunities; strategic accounts only indicates focus on key accounts; named accounts indicates specific account list; transactional indicates order processing only.. Valid values are `full|partial|strategic_accounts_only|named_accounts|transactional`',
    `coverage_role` STRING COMMENT 'Functional role of the sales representative in this territory assignment. Account manager owns customer relationship; product specialist provides domain expertise (e.g., drives, automation, electrification); technical consultant provides pre-sales engineering; inside sales rep provides remote support; channel manager manages indirect partners; overlay specialist provides supplemental coverage.. Valid values are `account_manager|product_specialist|technical_consultant|inside_sales_rep|channel_manager|overlay_specialist`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when the territory assignment ends and coverage responsibility transfers. Nullable for open-ended assignments. Used for territory transition planning and historical pipeline attribution.',
    `effective_start_date` DATE COMMENT 'Date when the territory assignment becomes active and the sales representative begins coverage responsibility. Used for territory transition planning and historical pipeline attribution.',
    `industry_vertical_focus` STRING COMMENT 'Industry vertical or market segment this assignment covers within the territory. Examples: automotive, food and beverage, pharmaceutical, oil and gas, water and wastewater, discrete manufacturing, process industries. Supports vertical specialist overlay model.',
    `is_primary` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory assignment record was last updated. Used for audit trail and change tracking.',
    `primary_assignment_flag` BOOLEAN COMMENT 'Indicates whether this is the primary assignment for the territory. True for the main account owner; false for overlay and specialist assignments. Used to determine default opportunity ownership and customer communication responsibility.',
    `product_line_focus` STRING COMMENT 'Specific product line or solution area this assignment covers within the territory. Examples: drives and motors, programmable logic controllers (PLC), building automation, electrification products, industrial communication, motion control, process instrumentation. Supports product specialist overlay model common in industrial automation sales.',
    `quota_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of territory quota assigned to this sales representative. Used for performance measurement and capacity planning. May differ from revenue allocation in overlay models where specialists receive credit but not quota burden.',
    `revenue_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of territory revenue credited to this sales representative for quota and commission calculation. Supports split-credit scenarios in matrix sales organizations where multiple specialists support the same account. Sum of all assignments for a territory may exceed 100% in overlay models.',
    CONSTRAINT pk_territory_assignment PRIMARY KEY(`territory_assignment_id`)
) COMMENT 'Association record linking a sales representative or sales team to a specific territory for a defined period. Captures assignment type (primary, overlay, product specialist), effective start and end dates, coverage role, assignment status, revenue allocation percentage, and reporting hierarchy override. Supports matrix sales organizations common in industrial automation where product specialists (e.g., drives expert, PLC specialist, building automation consultant) overlay geographic account managers. Enables territory-based pipeline attribution and split-credit deal tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `employee_id` BIGINT COMMENT 'Reference to the employee record in the workforce domain. Links the sales representative to their HR employee profile.',
    `manager_rep_id` BIGINT COMMENT 'Reference to the sales representative record of this reps direct manager in the sales hierarchy.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory assigned to this representative defining their geographic or account-based coverage area.',
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
    `email` STRING COMMENT '',
    `email_address` STRING COMMENT 'Primary business email address for the sales representative used for customer communication and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `full_name` STRING COMMENT 'Full legal name of the sales representative as recorded in the sales system.',
    `hire_date` DATE COMMENT 'Date when the sales representative was hired into the sales organization.',
    `industry_vertical_focus` STRING COMMENT 'Target industry vertical or market segment that the sales representative focuses on, such as automotive, food and beverage, pharmaceuticals, or infrastructure.',
    `is_active` BOOLEAN COMMENT '',
    `is_key_account_manager` BOOLEAN COMMENT 'Boolean flag indicating whether this sales representative is designated as a key account manager responsible for strategic, high-value customer relationships.',
    `language_proficiency` STRING COMMENT 'Languages spoken by the sales representative relevant for customer communication and territory coverage, stored as comma-separated language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was most recently updated in the sales system.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this sales representative.',
    `last_training_date` DATE COMMENT 'Date of the most recent sales training, product training, or professional development activity completed by the representative.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the sales representative used for field communication and urgent customer contact.',
    `rep_name` STRING COMMENT '',
    `notes` STRING COMMENT 'Free-form notes capturing additional context about the sales representatives specializations, territory nuances, or other relevant information for sales operations.',
    `onboarding_completion_date` DATE COMMENT 'Date when the sales representative completed the formal onboarding and training program for new sales hires.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the sales representative based on quota attainment, customer satisfaction, and other Key Performance Indicators (KPIs).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Primary business phone number for the sales representative to be contacted by customers and internal stakeholders.',
    `product_line_specialization` STRING COMMENT 'Primary product line or solution area that the sales representative specializes in, such as drives, PLCs (Programmable Logic Controllers), switchgear, building automation, or electrification systems.',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `quota_period_end_date` DATE COMMENT 'End date of the current quota period for this sales representative.',
    `quota_period_start_date` DATE COMMENT 'Start date of the current quota period for this sales representative, typically aligned with fiscal year or calendar year.',
    `rep_status` STRING COMMENT 'Current lifecycle status of the sales representative indicating their availability and eligibility for sales assignments.. Valid values are `active|inactive|on_leave|terminated|suspended|probation`',
    `rep_type` STRING COMMENT '',
    `sales_channel` STRING COMMENT 'Primary sales channel through which the representative conducts business: direct to end customer, through channel partners, distributors, or Original Equipment Manufacturer (OEM) relationships.. Valid values are `direct|partner|distributor|oem|hybrid`',
    `sales_office_location` STRING COMMENT 'Primary office location or branch where the sales representative is based for administrative and reporting purposes.',
    `sales_role` STRING COMMENT 'Commercial role classification indicating the sales representatives position in the sales organization hierarchy.. Valid values are `individual_contributor|team_lead|regional_manager|district_manager|account_executive|sales_engineer`',
    `termination_date` DATE COMMENT 'Date when the sales representatives employment or sales role ended. Null for active representatives.',
    `travel_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of work time spent traveling for customer visits, trade shows, and field sales activities.',
    `years_of_experience` STRING COMMENT 'Total years of sales experience in industrial automation, electrification, or related technical sales roles.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representative profile within the sales domain capturing commercial role, quota assignment, product line specialization (drives, PLCs, switchgear, building automation), territory alignment, and performance targets. Distinct from the workforce domain employee record — this is the sales-domain view of a seller including their book of business, commission plan reference, CRM user linkage, and sales hierarchy position (individual contributor, team lead, regional manager). Sourced from Salesforce User / Sales Cloud.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`quota` (
    `quota_id` BIGINT COMMENT 'Unique identifier for the sales quota record. Primary key.',
    `parent_quota_id` BIGINT COMMENT 'Identifier of the parent quota in a hierarchical quota structure (e.g., a regional quota that rolls up to a global quota). Enables quota hierarchy navigation and rollup reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this quota record. Links to the user record for audit trail and accountability purposes.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Quota has a free‑text territory field; adding quota_territory_id links quota to the territory hierarchy and eliminates the redundant string column.',
    `rep_id` BIGINT COMMENT '',
    `quota_sales_rep_id` BIGINT COMMENT 'Identifier of the sales representative, team, or territory to whom this quota is assigned. Links to the employee or organizational unit responsible for achieving the target.',
    `quota_territory_id` BIGINT COMMENT '',
    `tertiary_quota_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this quota record. Links to the user record for change tracking and audit compliance.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The net amount by which the base quota was adjusted after initial assignment. Positive values indicate quota increases; negative values indicate reductions. Used for variance analysis and compensation dispute resolution.',
    `adjustment_date` DATE COMMENT 'The effective date of the most recent quota adjustment. Used to track when changes were applied for accurate period-over-period performance comparison.',
    `adjustment_reason` STRING COMMENT 'Free-text explanation for any mid-period adjustments to the quota (e.g., territory realignment, market condition changes, organizational restructuring). Provides business context for quota modifications.',
    `allocation_method` STRING COMMENT 'The methodology used to determine this quota amount: top_down (corporate target cascaded down), bottom_up (aggregated from territory forecasts), hybrid (combination), historical (based on prior period performance), or market_based (derived from market opportunity analysis).. Valid values are `top_down|bottom_up|hybrid|historical|market_based`',
    `amount` DECIMAL(18,2) COMMENT '',
    `approval_status` STRING COMMENT 'The approval workflow state for this quota assignment: pending (awaiting management review), approved (confirmed and active), or rejected (not accepted, requires revision).. Valid values are `pending|approved|rejected`',
    `approved_date` DATE COMMENT 'The date when this quota was formally approved by management. Used for audit trail and to track planning cycle timelines.',
    `attainment_amount` DECIMAL(18,2) COMMENT 'The actual performance amount achieved against this quota as of the last calculation date. Updated periodically (daily, weekly, monthly) based on closed-won opportunities or booked orders.',
    `attainment_percent` DECIMAL(18,2) COMMENT 'The percentage of base quota achieved, calculated as (attainment_amount / base_quota_amount) * 100. Key performance indicator (KPI) for sales performance dashboards and incentive compensation calculations.',
    `base_quota_amount` DECIMAL(18,2) COMMENT 'The standard target amount assigned to the quota owner for the period. Represents the minimum performance expectation for full incentive payout.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code (e.g., USA, DEU, CHN) representing the primary country for this quota assignment. Supports country-level performance analysis and compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this quota record was first created in the system. Used for audit trail and to track planning cycle execution timelines.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code (e.g., USD, EUR, GBP) in which the quota amounts are denominated, enabling multi-currency quota management for global sales organizations.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT '',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (Q1, Q2, Q3, Q4) to which this quota applies, supporting quarterly performance tracking and incentive compensation cycles.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this quota applies, enabling year-over-year performance analysis and annual planning alignment.',
    `industry_segment` STRING COMMENT 'The target industry vertical or customer segment for this quota (e.g., Automotive, Energy, Pharmaceuticals, Infrastructure). Enables industry-focused quota planning and vertical market analysis.',
    `is_team_quota` BOOLEAN COMMENT 'Boolean flag indicating whether this quota is assigned to a team (True) or an individual sales representative (False). Supports team-based incentive structures and collaborative selling models.',
    `last_attainment_calculation_date` DATE COMMENT 'The date when the attainment amount and percentage were last recalculated. Indicates the freshness of performance metrics for reporting and compensation purposes.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this quota record was most recently updated. Supports change tracking, audit compliance, and data synchronization processes.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or instructions related to this quota assignment (e.g., strategic account focus, product launch priorities, market entry considerations).',
    `period_end_date` DATE COMMENT 'The last date of the performance period for which this quota is effective. Defines the end of the measurement window.',
    `period_start_date` DATE COMMENT 'The first date of the performance period for which this quota is effective. Defines the beginning of the measurement window.',
    `product_line` STRING COMMENT 'The product line or business unit to which this quota applies (e.g., Automation Systems, Electrification Solutions, Smart Infrastructure). Enables product-specific quota allocation and performance tracking.',
    `quota_number` STRING COMMENT 'Human-readable business identifier for the quota record, typically following a pattern such as QTA-YYYYNNNN for external reference and reporting.. Valid values are `^QTA-[0-9]{6,10}$`',
    `quota_status` STRING COMMENT 'Current lifecycle state of the quota: draft (under review), active (in effect), suspended (temporarily paused), closed (period completed), or cancelled (no longer valid).. Valid values are `draft|active|suspended|closed|cancelled`',
    `quota_type` STRING COMMENT 'Classification of the quota by measurement type: revenue (monetary sales target), units (volume target), margin (gross profit target), new logos (new customer acquisition target), bookings (order intake target), or pipeline (opportunity generation target).. Valid values are `revenue|units|margin|new_logos|bookings|pipeline`',
    `region` STRING COMMENT 'The broader geographic region encompassing the territory (e.g., Americas, EMEA, APAC). Used for regional rollup reporting and executive dashboards.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The gap between base quota and current attainment, calculated as (base_quota_amount - attainment_amount). Indicates the remaining target to achieve full quota for the period.',
    `stretch_quota_amount` DECIMAL(18,2) COMMENT 'The aspirational target amount beyond the base quota, used to incentivize exceptional performance with accelerated commission rates or bonuses.',
    CONSTRAINT pk_quota PRIMARY KEY(`quota_id`)
) COMMENT 'Sales quota record defining the revenue, volume, or margin target assigned to a sales representative, team, or territory for a specific period (monthly, quarterly, annual). Captures quota type (revenue, units, new logos), product line breakdown, base quota, stretch target, and attainment tracking. Supports commercial KPI reporting and incentive compensation management for industrial sales organizations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`price_book` (
    `price_book_id` BIGINT COMMENT 'Unique identifier for the price book record. Primary key.',
    `parent_price_book_id` BIGINT COMMENT 'Reference to a parent or master price book from which this price book inherits base pricing. Null if this is a top-level price book.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or team responsible for maintaining and managing this price book.',
    `tertiary_price_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this price book record.',
    `approval_date` DATE COMMENT 'Date when the price book was approved for use by authorized personnel.',
    `approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether quotes or orders using this price book require management approval before finalization.',
    `price_book_code` DECIMAL(18,2) COMMENT 'Unique alphanumeric code identifying the price book for system integration and reporting purposes.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the specific country for which this price book applies. Null if applicable to multiple countries.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the price book record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all prices in this price book (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or classification for which this price book is intended (e.g., Enterprise, SMB, OEM Partners, Distributors, Government).',
    `price_book_description` DECIMAL(18,2) COMMENT 'Detailed description of the price book purpose, scope, and applicability (e.g., Standard list prices for North America industrial automation products effective Q1 2024).',
    `discount_policy` STRING COMMENT 'Reference to the discount policy or guidelines that govern allowable discounts from this price book (e.g., Standard 10% max, Volume-based tiered, No discounts allowed).',
    `effective_end_date` DATE COMMENT 'Date after which the price book is no longer valid for new transactions. Null indicates no expiration date.',
    `effective_start_date` DATE COMMENT 'Date from which the price book becomes valid and can be used for pricing sales transactions.',
    `industry_segment` STRING COMMENT 'Specific industry vertical or segment for which this price book is designed (e.g., Automotive Manufacturing, Food & Beverage, Pharmaceuticals, Energy & Utilities).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the price book is currently active and available for selection in sales opportunities and quotes.',
    `is_standard` BOOLEAN COMMENT 'Boolean flag indicating whether this is the standard (default) price book for the organization. Only one standard price book should be active at a time.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the price book record was last modified or updated.',
    `price_book_name` DECIMAL(18,2) COMMENT 'Business name of the price book (e.g., Standard Price Book, EMEA Industrial Automation 2024, OEM Partner Pricing).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the price book usage and applicability.',
    `price_book_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the price book indicating whether it is available for use in sales transactions.',
    `price_book_type` DECIMAL(18,2) COMMENT 'Classification of the price book indicating its purpose and usage context within the sales organization.',
    `pricing_strategy` DECIMAL(18,2) COMMENT 'The pricing methodology or strategy applied in this price book (e.g., list pricing, cost-plus, competitive pricing, value-based pricing).',
    `product_line` STRING COMMENT 'Primary product line or family covered by this price book (e.g., Industrial Automation, Electrification Solutions, Smart Infrastructure, PLCs, Drives & Motors).',
    `region` STRING COMMENT 'Geographic region or territory for which this price book applies (e.g., North America, EMEA, APAC, LATAM).',
    `revision_date` DATE COMMENT 'Date when the current version of the price book was last revised or updated.',
    `source_system_code` STRING COMMENT 'Unique identifier of this price book in the source system for traceability and data lineage purposes.',
    `version` STRING COMMENT 'Version identifier for the price book to track revisions and updates over time (e.g., v1.0, 2024.Q1, Rev 3).',
    CONSTRAINT pk_price_book PRIMARY KEY(`price_book_id`)
) COMMENT 'Commercial price book defining the standard or customer-specific list prices for industrial automation products, electrification solutions, and smart infrastructure components. Captures price book name, currency, effective date range, customer segment applicability, and whether it is the standard or a custom price book. Sourced from Salesforce CPQ Price Book. SSOT for sales-side pricing (distinct from product catalog cost data).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` (
    `price_book_entry_id` BIGINT COMMENT 'Unique identifier for the price book entry record. Primary key.',
    `discount_schedule_id` BIGINT COMMENT 'Reference to a volume-based or tiered discount schedule that applies to this product. Enables automated discount calculation in Configure Price Quote (CPQ) systems.',
    `price_book_id` BIGINT COMMENT 'Reference to the parent price book that contains this entry. Links to the price book master record defining the pricing context (standard, regional, promotional).',
    `catalog_entry_id` BIGINT COMMENT 'Reference to the product or Stock Keeping Unit (SKU) that this price book entry applies to. Links to the product master record in the product catalog.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this price book entry. Used for audit trail and accountability in pricing governance.',
    `sku_master_id` BIGINT COMMENT '',
    `tertiary_price_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this price book entry record. Part of the standard audit trail.',
    `tertiary_price_product_catalog_entry_id` BIGINT COMMENT 'FK to product.catalog_entry',
    `approval_status` STRING COMMENT 'The approval workflow status for this price book entry. Tracks whether custom or non-standard pricing has been reviewed and approved per governance policies.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_date` DATE COMMENT 'The date on which this price book entry was approved. Part of the audit trail for pricing governance and compliance.',
    `cost_price` DECIMAL(18,2) COMMENT 'The internal cost or standard cost of the product. Used for margin calculation and profitability analysis. Business-confidential data.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this price book entry record was first created in the system. Part of the standard audit trail.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which all prices in this entry are denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or tier for which this pricing applies (e.g., Enterprise, Mid-Market, Small Business, Government). Supports segment-based pricing strategies.',
    `price_book_entry_description` DECIMAL(18,2) COMMENT 'Additional notes or description providing context about this pricing entry, such as special terms, conditions, or the rationale for custom pricing.',
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
    `price_book_entry_name` DECIMAL(18,2) COMMENT 'A descriptive name or label for this price book entry, typically combining product name, price book name, and currency for easy identification in reports and user interfaces.',
    `price_type` DECIMAL(18,2) COMMENT 'The type or nature of the price (e.g., list price, negotiated price, promotional price, contract price, spot price). Indicates the pricing strategy applied.',
    `pricing_method` STRING COMMENT 'The methodology used to determine the price (e.g., fixed, cost-plus, market-based, value-based). Supports pricing strategy analysis and governance.. Valid values are `fixed|cost_plus|market_based|value_based`',
    `product_family` STRING COMMENT 'The product family or category to which this product belongs (e.g., Automation Controllers, Electrification Components, SCADA Systems). Used for reporting and segmentation.',
    `product_line` STRING COMMENT 'The business product line or division responsible for this product (e.g., Industrial Automation, Building Technologies, Mobility Solutions).',
    `sales_channel` STRING COMMENT 'The sales channel through which this pricing is applicable (e.g., direct sales, distributor, partner, Original Equipment Manufacturer (OEM), online).. Valid values are `direct|distributor|partner|oem|online`',
    `tax_code` STRING COMMENT 'The tax classification code that determines applicable sales tax, Value Added Tax (VAT), or Goods and Services Tax (GST) rates for this product in the specified geography.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pricing (e.g., Each, Box, Pallet, Kilogram, Meter). Defines the quantity basis for the unit price.',
    `unit_price` DECIMAL(18,2) COMMENT 'The effective selling price per unit for this product in the price book. May differ from list price due to volume discounts, promotions, or regional adjustments.',
    `use_standard_price` DECIMAL(18,2) COMMENT 'Indicates whether this entry uses the standard price book price or a custom price. True means standard pricing applies; false indicates custom or negotiated pricing.',
    CONSTRAINT pk_price_book_entry PRIMARY KEY(`price_book_entry_id`)
) COMMENT 'Individual product-price association within a price book, linking a specific SKU or product configuration to its list price, minimum price, and discount thresholds for a given currency and effective period. Supports multi-currency industrial sales across global markets and enables CPQ-driven automated pricing in Salesforce.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Primary key for forecast',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales forecasts feed cost center budgets; linking ensures accurate cost planning.',
    `rep_id` BIGINT COMMENT '',
    `forecast_sales_rep_id` BIGINT COMMENT 'Sales representative, manager, or regional leader who submitted this forecast.',
    `territory_id` BIGINT COMMENT '',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Sales forecast per material drives production scheduling and inventory replenishment decisions.',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity this forecast is associated with.',
    `previous_forecast_id` BIGINT COMMENT 'Reference to the prior version of this forecast if this is a revision.',
    `primary_forecast_territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Forecast contains a free‑text territory field; adding forecast_territory_id creates a normalized link to sales.territory and eliminates the duplicate string column.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Forecasted profit per profit center is required for quarterly performance dashboards.',
    `amount` DECIMAL(18,2) COMMENT '',
    `approval_date` DATE COMMENT 'Date when the forecast was approved by management.',
    `approved_by` BIGINT COMMENT 'Manager or executive who approved this forecast submission.',
    `best_case_amount` DECIMAL(18,2) COMMENT 'Optimistic revenue projection if all opportunities close favorably.',
    `forecast_category` STRING COMMENT 'Classification of forecast confidence level: pipeline (early stage), best_case (optimistic), commit (high confidence), closed (won deals).. Valid values are `pipeline|best_case|commit|closed`',
    `closed_amount` DECIMAL(18,2) COMMENT 'Actual revenue from deals already closed and won during the forecast period.',
    `committed_amount` DECIMAL(18,2) COMMENT 'High-confidence revenue projection that the sales team commits to achieving.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary market of this forecast.. Valid values are `^[A-Z]{3}$`',
    `created_date` DATE COMMENT 'Date when the forecast record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all forecast amounts.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'End date of the forecast period being projected.',
    `fiscal_period` STRING COMMENT '',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter designation (Q1, Q2, Q3, Q4) for the forecast period.. Valid values are `^Q[1-4]$`',
    `fiscal_year` STRING COMMENT 'Fiscal year for the forecast period.',
    `forecast_number` STRING COMMENT 'Business identifier for the forecast record, typically system-generated.. Valid values are `^FC-[0-9]{8}$`',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record.. Valid values are `draft|submitted|approved|rejected|revised`',
    `industry_segment` STRING COMMENT 'Target industry vertical for the forecasted opportunities (e.g., Automotive, Energy, Pharmaceuticals).',
    `is_latest_version` BOOLEAN COMMENT 'Flag indicating whether this is the most current version of the forecast for this period and owner.',
    `last_modified_by` BIGINT COMMENT 'User who last modified this forecast record.',
    `last_modified_date` DATE COMMENT 'Date when the forecast record was last updated.',
    `manager_adjusted_amount` DECIMAL(18,2) COMMENT 'Revenue amount after manager review and adjustment, may differ from submitted amount based on pipeline scrutiny.',
    `manager_notes` STRING COMMENT 'Commentary from the reviewing manager explaining adjustments or concerns.',
    `notes` STRING COMMENT 'Free-text commentary from the sales representative explaining assumptions, risks, or opportunities in the forecast.',
    `opportunity_count` STRING COMMENT 'Number of opportunities included in this forecast submission.',
    `period_type` STRING COMMENT 'Time granularity of the forecast period: monthly, quarterly, or annual.. Valid values are `monthly|quarterly|annual`',
    `pipeline_amount` DECIMAL(18,2) COMMENT 'Total pipeline revenue including early-stage opportunities with lower probability.',
    `product_line` STRING COMMENT 'Primary product line or business unit for this forecast (e.g., Industrial Automation, Electrification, Smart Infrastructure).',
    `quota_amount` DECIMAL(18,2) COMMENT 'Assigned sales quota target for the forecast owner during this period.',
    `quota_attainment_percent` TIMESTAMP COMMENT 'Percentage of quota achieved based on committed forecast amount.',
    `region` STRING COMMENT 'Broader geographic region grouping multiple territories (e.g., EMEA, Americas, APAC).',
    `rejection_reason` STRING COMMENT 'Explanation provided when a forecast is rejected by management, requiring revision.',
    `start_date` DATE COMMENT 'Start date of the forecast period being projected.',
    `submission_date` DATE COMMENT 'Date when the forecast was submitted by the sales representative or manager.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the forecast was submitted into the system.',
    `submitted_amount` DECIMAL(18,2) COMMENT 'Revenue amount submitted by the sales representative for this forecast period and category.',
    `variance_to_quota` DECIMAL(18,2) COMMENT 'Difference between committed forecast amount and quota target, can be positive or negative.',
    `version` STRING COMMENT 'Version number tracking revisions to the forecast for the same period.',
    `weighted_pipeline_amount` DECIMAL(18,2) COMMENT 'Pipeline amount adjusted by probability weighting based on opportunity stages.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Periodic sales forecast record capturing the committed, best-case, and pipeline revenue projections submitted by sales reps, managers, and regional leaders for a given forecast period. Tracks forecast category, submitted amount, manager-adjusted amount, product line breakdown, and variance to quota. Supports S&OP (Sales and Operations Planning) and executive revenue visibility for industrial automation business units.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` (
    `channel_partner_id` BIGINT COMMENT 'Unique identifier for the channel partner record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this partner record.',
    `channel_employee_id` BIGINT COMMENT 'Identifier of the internal employee (partner account manager or channel manager) responsible for managing the relationship with this partner.',
    `channel_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this partner record.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory to which this partner is assigned for reporting and commission purposes.',
    `supplier_id` BIGINT COMMENT '',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'The annual revenue target or quota assigned to the partner for the current fiscal year, in the partners operating currency.',
    `authorized_product_lines` STRING COMMENT 'Comma-separated list of product lines or business units the partner is authorized to sell or integrate. Examples: Industrial Automation, Electrification, Building Technologies, Motion Control, Process Instrumentation.',
    `certification_expiry_date` DATE COMMENT 'Date when the partners current certification expires and requires renewal.',
    `certification_status` STRING COMMENT 'Current status of the partners technical or sales certification. Certified (all required certifications current), In Progress (certification training underway), Expired (certifications lapsed), Not Certified (no certifications obtained).. Valid values are `certified|in_progress|expired|not_certified`',
    `contract_end_date` DATE COMMENT 'Expiration or renewal date of the current partner agreement or contract.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current partner agreement or contract.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this partner record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit limit extended to the partner for outstanding receivables, in the partners operating currency.',
    `deal_registration_enabled` DECIMAL(18,2) COMMENT 'Indicates whether the partner is authorized to register deals for protection and special pricing. True if deal registration is enabled, False otherwise.',
    `discount_tier` STRING COMMENT 'Discount tier assigned to the partner based on volume commitments and tier status. Determines the standard discount percentage the partner receives on product pricing.. Valid values are `tier_1|tier_2|tier_3|tier_4|standard`',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number uniquely identifying the partner organization globally.. Valid values are `^[0-9]{9}$`',
    `employee_count_range` STRING COMMENT 'Size classification of the partner organization by number of employees.. Valid values are `1-10|11-50|51-200|201-500|501-1000|1001-5000|5000+`',
    `geographic_coverage` STRING COMMENT 'Geographic territories or regions where the partner is authorized to operate and sell. May include country codes, state/province lists, or named territories.',
    `headquarters_address_line1` STRING COMMENT 'First line of the street address for the partners headquarters or principal place of business.',
    `headquarters_city` STRING COMMENT 'City where the partners headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the partners headquarters location.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the partners headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State, province, or region where the partners headquarters is located.',
    `industry_focus` STRING COMMENT 'Primary industry verticals or market segments the partner specializes in serving. Examples: Automotive, Food & Beverage, Pharmaceuticals, Oil & Gas, Water & Wastewater.',
    `is_active` BOOLEAN COMMENT '',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this partner record was last updated or modified.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal business review or performance evaluation conducted with the partner.',
    `legal_name` STRING COMMENT 'The official registered legal name of the channel partner organization as it appears on incorporation documents and contracts.',
    `mdf_eligible` BOOLEAN COMMENT 'Indicates whether the partner is eligible to receive Market Development Funds for co-marketing activities. True if eligible, False otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments about the partner relationship.',
    `onboarding_date` TIMESTAMP COMMENT '',
    `partner_code` STRING COMMENT '',
    `partner_name` STRING COMMENT '',
    `partner_number` STRING COMMENT 'Externally-known unique business identifier for the channel partner, typically assigned by the partner management system. Used in contracts, deal registrations, and commercial correspondence.. Valid values are `^[A-Z0-9]{8,15}$`',
    `partner_program_enrollment_date` DATE COMMENT 'Date when the partner was enrolled in the channel partner program and the relationship was established.',
    `partner_status` STRING COMMENT 'Current lifecycle status of the partner relationship. Active (authorized to transact), Inactive (temporarily not transacting), Suspended (authorization revoked pending review), Pending Approval (application under review), Terminated (relationship ended).. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `partner_tier` STRING COMMENT 'Partner program tier indicating authorization level, benefits, and performance status. Platinum (top tier, highest revenue and certification), Gold (high performance), Silver (standard), Bronze (entry level), Registered (basic enrollment).. Valid values are `platinum|gold|silver|bronze|registered`',
    `partner_type` STRING COMMENT 'Classification of the channel partner by business model: distributor (bulk stock and resell), system integrator (solution design and implementation), VAR (Value-Added Reseller - customize and resell), OEM (Original Equipment Manufacturer - embed products), reseller (direct resale), consultant (advisory and referral).. Valid values are `distributor|system_integrator|var|oem|reseller|consultant`',
    `payment_terms_days` DECIMAL(18,2) COMMENT 'Standard payment terms extended to the partner, expressed in number of days (e.g., 30, 60, 90 days net).',
    `primary_contact_email` STRING COMMENT 'Primary email address for the main business contact at the partner organization. Used for operational communications, deal notifications, and program updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the main business contact at the partner organization.',
    `target_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual revenue target.. Valid values are `^[A-Z]{3}$`',
    `tax_id_number` STRING COMMENT 'Tax identification number, VAT number, or equivalent government-issued business tax identifier for the partner organization.',
    `technical_capability_level` STRING COMMENT 'Assessment of the partners technical capability and expertise. Advanced (complex system integration, custom engineering), Intermediate (standard configuration and deployment), Basic (product resale with limited technical support).. Valid values are `advanced|intermediate|basic`',
    `trade_name` STRING COMMENT 'The commercial trading name or DBA name under which the partner operates in the market, if different from legal name.',
    `website_url` STRING COMMENT 'Primary website URL for the partner organization.',
    CONSTRAINT pk_channel_partner PRIMARY KEY(`channel_partner_id`)
) COMMENT 'Authorized channel partner record representing distributors, system integrators, value-added resellers (VARs), and OEM partners who sell or embed the companys industrial automation and electrification products. Captures partner tier (platinum, gold, silver), authorized product lines, geographic coverage, certification status, annual revenue target, partner program enrollment, deal registration rules, and opportunity involvement role (reseller, referral, co-sell). Distinct from the supplier domain — this is the sales-side commercial partner. SSOT for partner identity, authorization level, and commercial terms in the sales domain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` (
    `order_intake_id` BIGINT COMMENT 'Primary key for order_intake',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue allocation to cost center for cost accounting on each order intake (required for statutory cost reporting).',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account placing the order. Links to the master customer account record.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order intake records the exact material to be delivered, linking to inventory for allocation and picking.',
    `opportunity_id` BIGINT COMMENT 'Reference to the won sales opportunity that generated this order intake. Links to the originating opportunity record in Salesforce Sales Cloud.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Order intake records a sales territory as text; adding order_intake_territory_id creates a proper FK to sales.territory and removes the ambiguous string column.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Order intake for equipment installation must reference the required permit to ensure legal installation and tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting per profit center for each order intake (used in profit analysis reports).',
    `project_header_id` BIGINT COMMENT 'Reference to the customer project or program this order is associated with. Used for project-based revenue tracking and multi-phase delivery coordination.',
    `quote_id` BIGINT COMMENT 'Reference to the accepted quote that was converted into this order intake. May be null if order originated directly from opportunity without formal quote.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the master sales contract or framework agreement under which this order was placed. May be null for spot orders without framework agreement.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager who owns this order intake. Used for quota attainment and commission calculation.',
    `sales_team_id` BIGINT COMMENT 'Reference to the sales team responsible for this order. Used for team-based performance tracking and collaborative selling analytics.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Order intake processing must map incoming orders to the master product record for inventory allocation and production scheduling.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Order fulfillment planning requires assigning a primary supplier to each order intake for procurement scheduling and delivery coordination.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Logistics tracking needs the specific supplier site fulfilling the order, enabling shipping, compliance, and performance reporting.',
    `booking_recognition_date` DATE COMMENT 'The date when this order intake was recognized as a booking for quota and sales performance measurement. May differ from intake date based on validation rules.',
    `booking_recognized_flag` BOOLEAN COMMENT 'Indicates whether this order intake has been recognized as a booking against sales quota. True when order meets booking recognition criteria per sales policy.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed by sales to the customer. May differ from requested date based on production capacity and supply chain constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order intake record was first created. Used for audit trail and data lineage tracking.',
    `credit_approval_date` DATE COMMENT 'Date when credit approval was granted for this order, if required. Null if order did not require credit approval or is still pending.',
    `credit_check_status` DECIMAL(18,2) COMMENT 'Result of the customer credit check performed at order intake. Orders failing credit check may require advance payment or credit approval before handoff to fulfillment.',
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
    `intake_amount` DECIMAL(18,2) COMMENT '',
    `intake_date` DATE COMMENT 'The date when the order was officially received and recorded in the sales system. This is the booking date used for sales quota recognition and revenue pipeline tracking.',
    `intake_number` STRING COMMENT 'Business identifier for the order intake record. Human-readable unique number used for tracking and reference in sales reporting and KPI dashboards.. Valid values are `^OI-[0-9]{8}$`',
    `intake_status` STRING COMMENT '',
    `intake_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the order intake record was created in the system. Used for sales-to-fulfillment cycle time measurement and operational analytics.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this order intake record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order intake record was last updated. Used for change tracking and data synchronization.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this order intake. May include customer requests, internal coordination notes, or special handling instructions.',
    `order_management_reference` STRING COMMENT 'The order number or reference assigned by the order management system after handoff. Links this sales intake record to the authoritative order record in SAP SD or equivalent ERP.',
    `order_priority` STRING COMMENT 'The priority level assigned to this order intake. Influences production scheduling and resource allocation in the fulfillment process.. Valid values are `Standard|High|Urgent|Critical`',
    `order_type` STRING COMMENT 'Classification of the order by business type. Distinguishes between new customer acquisition, existing customer expansion, and service orders for sales mix analysis. [ENUM-REF-CANDIDATE: New Business|Renewal|Upgrade|Add-On|Replacement|Service|Spare Parts — 7 candidates stripped; promote to reference product]',
    `order_value` DECIMAL(18,2) COMMENT 'The total confirmed order value at intake. This is the gross order amount before any adjustments, used for sales booking recognition and quota attainment calculation.',
    `order_value_base_currency` DECIMAL(18,2) COMMENT 'Order value converted to the companys base reporting currency using the exchange rate at intake date. Used for consolidated sales reporting and KPI tracking.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The agreed payment terms for this order. Defines when payment is due relative to delivery or invoice date. Critical for cash flow forecasting and credit risk management. [ENUM-REF-CANDIDATE: Net 30|Net 45|Net 60|Net 90|Advance Payment|Letter of Credit|Installment|Custom — 8 candidates stripped; promote to reference product]',
    `payment_terms_days` DECIMAL(18,2) COMMENT 'Number of days until payment is due per the agreed payment terms. Used for accounts receivable forecasting and working capital planning.',
    `product_line` STRING COMMENT 'The primary product line or business unit for this order. Used for sales performance segmentation and product portfolio analysis.',
    `requested_delivery_date` DATE COMMENT 'The customers requested delivery date as captured at order intake. Used for production planning coordination and customer expectation management.',
    `shipping_method` STRING COMMENT 'The agreed shipping or transportation method for order delivery. Impacts delivery lead time and logistics cost allocation. [ENUM-REF-CANDIDATE: Air Freight|Sea Freight|Road Transport|Rail|Courier|Customer Pickup|Multimodal — 7 candidates stripped; promote to reference product]',
    `special_terms_conditions` STRING COMMENT 'Any special commercial terms, conditions, or customer-specific agreements applicable to this order. May include warranty extensions, service level commitments, or pricing exceptions.',
    `created_by` STRING COMMENT 'Username or identifier of the sales user who created this order intake record in the system.',
    CONSTRAINT pk_order_intake PRIMARY KEY(`order_intake_id`)
) COMMENT 'Sales order intake record capturing the commercial handoff from a won opportunity or accepted quote to the order management domain. Records the intake date, confirmed order value, customer PO reference, requested delivery date, payment terms confirmed, and handoff status. This is NOT the SSOT for order fulfillment data — the authoritative order record lives in the order domain. The sales domain retains this record solely for order intake KPI tracking, sales-to-fulfillment cycle time measurement, and booking recognition against quota.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` (
    `opportunity_component_id` BIGINT COMMENT 'Primary key for the opportunity_component association',
    `component_id` BIGINT COMMENT 'Foreign key linking to the component master record',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to the sales opportunity',
    `sku_master_id` BIGINT COMMENT '',
    `component_notes` STRING COMMENT '',
    `component_quantity` DECIMAL(18,2) COMMENT '',
    `component_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `discount_percent` DECIMAL(18,2) COMMENT 'discount percent',
    `discount_percentage` DECIMAL(18,2) COMMENT '',
    `estimated_quantity` DECIMAL(18,2) COMMENT 'Quantity of the component expected to be sold in the opportunity',
    `estimated_total_value` DECIMAL(18,2) COMMENT '',
    `estimated_unit_price` DECIMAL(18,2) COMMENT '',
    `expected_close_date` TIMESTAMP COMMENT '',
    `extended_amount` DECIMAL(18,2) COMMENT 'extended amount',
    `extended_price_amount` DECIMAL(18,2) COMMENT '',
    `interest_level` STRING COMMENT 'Qualitative level of interest (high, medium, low) expressed by the sales team for the component within the opportunity',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_amount` DECIMAL(18,2) COMMENT '',
    `line_number` STRING COMMENT '',
    `line_status` STRING COMMENT 'line status',
    `line_total_amount` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `quantity` STRING COMMENT '',
    `target_delivery_date` DATE COMMENT 'Planned delivery date for the component as promised in the opportunity',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `unit_price_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_opportunity_component PRIMARY KEY(`opportunity_component_id`)
) COMMENT 'Represents the association between a component and a sales opportunity. Each record captures the sales interest, quantity estimate, and planned delivery date for a component within a specific opportunity.. Existence Justification: Sales representatives add multiple engineered components to a single sales opportunity, and each component can appear in many different opportunities across customers. The association captures interest level, estimated quantity, and target delivery date, which are specific to the component‑opportunity pairing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` (
    `project_rep_assignment_id` BIGINT COMMENT 'Primary key for the project_rep_assignment association',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to the project header',
    `rep_id` BIGINT COMMENT '',
    `project_sales_rep_id` BIGINT COMMENT 'Foreign key linking to the sales representative',
    `active_flag` BOOLEAN COMMENT 'Active flag',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the reps capacity allocated to the project',
    `allocation_percentage` DECIMAL(18,2) COMMENT '',
    `approval_status` STRING COMMENT 'Approval status',
    `assigned_by` STRING COMMENT 'User who created the assignment.',
    `assigned_date` TIMESTAMP COMMENT 'assigned date',
    `assignment_date` DATE COMMENT '',
    `assignment_end_date` DATE COMMENT '',
    `assignment_notes` STRING COMMENT '',
    `assignment_reason` STRING COMMENT 'Assignment reason',
    `assignment_role` STRING COMMENT '',
    `assignment_start_date` DATE COMMENT '',
    `assignment_status` STRING COMMENT '',
    `commission_percent` DECIMAL(18,2) COMMENT 'Commission percentage for the rep on this project.',
    `commission_percentage` DECIMAL(18,2) COMMENT '',
    `commission_rate` DECIMAL(18,2) COMMENT '',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission rate percentage for the assignment.',
    `commission_share_percent` DECIMAL(18,2) COMMENT '',
    `coverage_scope` STRING COMMENT 'Coverage scope',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'ISO currency code for monetary amounts.',
    `end_date` DATE COMMENT 'Date when the reps assignment to the project ends',
    `is_primary` BOOLEAN COMMENT '',
    `is_primary_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `primary_flag` BOOLEAN COMMENT '',
    `quota_amount` DECIMAL(18,2) COMMENT 'Quota amount attributed to the rep on this project.',
    `quota_credit_percent` DECIMAL(18,2) COMMENT 'Quota credit share attributed to the rep.',
    `role` STRING COMMENT 'The functional role of the sales rep on the project (e.g., Lead, Support, Technical)',
    `start_date` DATE COMMENT 'Date when the reps assignment to the project begins',
    `territory_code` STRING COMMENT 'Territory code associated with the assignment.',
    CONSTRAINT pk_project_rep_assignment PRIMARY KEY(`project_rep_assignment_id`)
) COMMENT 'This association captures the assignment of sales representatives to capital or engineering projects. Each record links one sales_rep_id to one project_header_id and stores the role, allocation percentage, and the effective start and end dates of the assignment.. Existence Justification: A sales representative can be assigned to multiple capital or engineering projects, and each project can have multiple sales representatives contributing with defined roles and allocation percentages. The assignment is actively managed, with start/end dates, role definitions, and allocation percentages recorded for each rep‑project pairing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` (
    `device_contract_assignment_id` BIGINT COMMENT 'Primary key for the device_contract_assignment association',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to the device registry',
    `equipment_register_id` BIGINT COMMENT '',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to the sales contract',
    `sku_master_id` BIGINT COMMENT '',
    `assigned_by` STRING COMMENT '',
    `assigned_by_name` STRING COMMENT '',
    `assigned_by_user` STRING COMMENT 'assigned by user',
    `assigned_date` TIMESTAMP COMMENT 'assigned date',
    `assignment_date` DATE COMMENT '',
    `assignment_end_date` TIMESTAMP COMMENT '',
    `assignment_notes` STRING COMMENT '',
    `assignment_number` STRING COMMENT '',
    `assignment_start_date` TIMESTAMP COMMENT '',
    `assignment_status` STRING COMMENT '',
    `assignment_type` STRING COMMENT 'Business data attribute for device_contract_assignment.',
    `billing_frequency` STRING COMMENT '',
    `billing_rate` DECIMAL(18,2) COMMENT '',
    `contract_device_end_date` DATE COMMENT 'Date when the device coverage under the contract ends',
    `contract_device_start_date` DATE COMMENT 'Date when the device coverage under the contract starts',
    `contract_value` DECIMAL(18,2) COMMENT '',
    `contracted_value` DECIMAL(18,2) COMMENT '',
    `coverage_end_date` DATE COMMENT '',
    `coverage_start_date` DATE COMMENT '',
    `coverage_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` TIMESTAMP COMMENT '',
    `effective_from_date` TIMESTAMP COMMENT 'effective from date',
    `effective_to_date` TIMESTAMP COMMENT 'effective to date',
    `end_date` DATE COMMENT '',
    `expiry_date` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `serial_number` STRING COMMENT '',
    `service_level` STRING COMMENT 'Service level agreed for the device under the contract',
    `start_date` DATE COMMENT '',
    CONSTRAINT pk_device_contract_assignment PRIMARY KEY(`device_contract_assignment_id`)
) COMMENT 'This association product represents the contractual coverage relationship between a sales contract and an automation device. It captures the period during which a device is covered by a contract and the service level agreed for that coverage.. Existence Justification: A sales contract can cover multiple automation devices, and a single device may be covered under multiple contracts over its lifecycle (e.g., initial sale, later service extensions). The business actively creates, updates, and deletes these links, tracking start/end dates and service levels for each contract‑device pairing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `employee_id` BIGINT COMMENT 'Internal user responsible for the campaign execution and oversight.',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `actual_clicks` BIGINT COMMENT 'Number of clicks recorded for the campaign.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT '',
    `actual_impressions` BIGINT COMMENT 'Number of times the campaign content was actually displayed.',
    `actual_leads` BIGINT COMMENT 'Number of qualified leads actually generated.',
    `actual_revenue` DECIMAL(18,2) COMMENT 'Revenue realized from the campaign.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved monetary budget allocated for the campaign.',
    `campaign_type` STRING COMMENT '',
    `channel` STRING COMMENT 'Primary channel through which the campaign is delivered (e.g., email, social media, search, event, direct).',
    `campaign_code` STRING COMMENT 'External code or reference number assigned to the campaign, often used in marketing systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `currency_code` STRING COMMENT '',
    `campaign_description` STRING COMMENT 'Detailed narrative describing the campaign purpose, messaging, and scope.',
    `end_date` DATE COMMENT 'Date on which the campaign is scheduled to end or be retired.',
    `expected_clicks` BIGINT COMMENT 'Projected number of clicks generated by the campaign.',
    `expected_impressions` BIGINT COMMENT 'Projected number of times the campaign content will be displayed to the target audience.',
    `expected_leads` BIGINT COMMENT 'Projected number of qualified leads generated by the campaign.',
    `expected_revenue` DECIMAL(18,2) COMMENT 'Projected revenue attributable to the campaign.',
    `frequency` STRING COMMENT 'How often the campaign is executed or repeated.',
    `is_test_campaign` BOOLEAN COMMENT 'True if the campaign is a test or pilot; false otherwise.',
    `language_code` STRING COMMENT 'Two‑letter ISO language code of the primary language used in campaign assets.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the campaign used in reports and dashboards.',
    `objective` STRING COMMENT 'Strategic objective the campaign aims to achieve.',
    `priority` STRING COMMENT 'Business priority level assigned to the campaign.',
    `region_code` STRING COMMENT 'Three‑letter ISO code representing the primary geographic region targeted by the campaign.',
    `start_date` DATE COMMENT 'Date on which the campaign is scheduled to begin.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.',
    `success_metric` STRING COMMENT 'Key performance indicator used to evaluate campaign success (e.g., leads_generated, revenue_attributed).',
    `target_audience` STRING COMMENT 'Description of the primary audience segment(s) the campaign is intended for.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by campaign_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` (
    `sales_team_id` BIGINT COMMENT 'Primary key for sales_team',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_sales_team_id` BIGINT COMMENT 'Self-referencing FK on sales_team (parent_sales_team_id)',
    `sales_employee_id` BIGINT COMMENT 'Identifier of the employee who manages the sales team.',
    `sales_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the sales team.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Internal cost center code associated with the sales team expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales team record was first created in the system.',
    `sales_team_description` STRING COMMENT 'Detailed description of the sales teams purpose, responsibilities, and scope.',
    `end_date` DATE COMMENT 'Date when the sales team was discontinued or archived, if applicable.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the budget and quota apply.',
    `headcount` STRING COMMENT 'Number of members in the sales team.',
    `is_active` BOOLEAN COMMENT '',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the sales team operates remotely.',
    `office_location` STRING COMMENT 'Physical office address of the sales team.',
    `performance_rating` STRING COMMENT 'Performance rating of the sales team for the evaluation period.',
    `primary_contact_email` STRING COMMENT 'Main email address for contacting the sales team.',
    `primary_contact_phone` STRING COMMENT 'Main phone number for contacting the sales team.',
    `product_line_focus` STRING COMMENT 'Primary product line(s) the sales team sells.',
    `quota_achieved` DECIMAL(18,2) COMMENT 'Actual sales quota achieved by the team.',
    `quota_target` DECIMAL(18,2) COMMENT 'Target sales quota assigned to the team for the fiscal period.',
    `region` STRING COMMENT 'Geographic region where the sales team operates.',
    `sales_channel_focus` STRING COMMENT 'Primary sales channel focus of the team.',
    `start_date` DATE COMMENT 'Date when the sales team was established.',
    `sales_team_status` STRING COMMENT 'Current lifecycle status of the sales team.',
    `team_code` STRING COMMENT 'Unique alphanumeric code identifying the sales team within the organization.',
    `team_name` STRING COMMENT 'Human readable name of the sales team.',
    `team_type` STRING COMMENT 'Classification of the sales team based on its focus or structure.',
    `territory` STRING COMMENT 'Specific sales territory assigned to the team.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sales team record.',
    CONSTRAINT pk_sales_team PRIMARY KEY(`sales_team_id`)
) COMMENT 'Master reference table for sales_team. Referenced by sales_team_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` (
    `discount_schedule_id` BIGINT COMMENT 'Primary key for discount_schedule',
    `base_discount_schedule_id` BIGINT COMMENT 'Self-referencing FK on discount_schedule (base_discount_schedule_id)',
    `price_book_id` BIGINT COMMENT '',
    `applies_to_customer_segment` STRING COMMENT 'Customer segment (e.g., enterprise, SMB) for which the discount schedule is valid.',
    `applies_to_product_category` STRING COMMENT 'Product category or line to which the discount schedule applies.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether changes to this schedule require managerial approval.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the discount schedule was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the discount schedule record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary discount values.',
    `discount_schedule_description` STRING COMMENT 'Free‑form description of the discount schedule purpose and rules.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount amount when the schedule is amount‑based.',
    `discount_method` STRING COMMENT 'Method used to calculate the discount (percentage, fixed amount, tiered).',
    `discount_percent` DECIMAL(18,2) COMMENT '',
    `discount_rate` DECIMAL(18,2) COMMENT 'Primary discount percentage applied when the schedule is percentage‑based.',
    `discount_type` STRING COMMENT '',
    `effective_end_date` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT 'Date on which the discount schedule becomes valid.',
    `effective_start_date` TIMESTAMP COMMENT '',
    `effective_until` DATE COMMENT 'Date on which the discount schedule expires; null for open‑ended.',
    `is_active` BOOLEAN COMMENT '',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this discount can be combined with other discounts.',
    `last_review_date` DATE COMMENT 'Date of the most recent policy or compliance review of the schedule.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Upper limit on the discount amount that can be applied per transaction.',
    `max_quantity` DECIMAL(18,2) COMMENT '',
    `min_quantity` DECIMAL(18,2) COMMENT '',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum order monetary value required for the discount schedule to be eligible.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `region_code` STRING COMMENT 'Three‑letter region code indicating geographic applicability.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the discount schedule.',
    `schedule_code` STRING COMMENT 'Business code used to reference the discount schedule in external systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the discount schedule.',
    `schedule_type` STRING COMMENT 'Classification of the schedule indicating how discounts are calculated.',
    `discount_schedule_status` STRING COMMENT 'Current lifecycle status of the discount schedule.',
    `tier_max_quantity` STRING COMMENT 'Maximum quantity threshold for the tiered discount; null if unlimited.',
    `tier_min_quantity` STRING COMMENT 'Minimum quantity threshold for the tiered discount to apply.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the discount schedule record.',
    CONSTRAINT pk_discount_schedule PRIMARY KEY(`discount_schedule_id`)
) COMMENT 'Master reference table for discount_schedule. Referenced by discount_schedule_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` (
    `quote_template_id` BIGINT COMMENT 'Primary key for quote_template',
    `base_quote_template_id` BIGINT COMMENT 'Self-referencing FK on quote_template (base_quote_template_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the archive action.',
    `quote_employee_id` BIGINT COMMENT 'Identifier of the internal user who created the template.',
    `quote_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user who last updated the template.',
    `applicable_product_line` STRING COMMENT 'Product line(s) for which the template is intended; free‑text list or comma‑separated values.',
    `approval_deadline` DATE COMMENT 'Date by which the pending approval must be completed.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the template must be approved before it can be used to generate quotes.',
    `approval_status` STRING COMMENT 'Current approval state of the template.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the template was archived.',
    `compliance_requirements` STRING COMMENT 'Regulatory or standards constraints that must be reflected in quotes generated from this template.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the template record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values in the template.',
    `default_discount_percent` DECIMAL(18,2) COMMENT 'Standard discount applied by default when the template is used, expressed as a percent.',
    `default_price_amount` DECIMAL(18,2) COMMENT 'Baseline monetary amount used as a starting point when creating a quote from this template.',
    `quote_template_description` STRING COMMENT 'Detailed free‑text description of the purpose and scope of the quote template.',
    `effective_from` DATE COMMENT 'Date from which the template becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the template is no longer valid; null indicates indefinite validity.',
    `industry` STRING COMMENT 'Industry segment the template targets (e.g., automotive, energy, aerospace).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the template is currently available for use.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `quote_template_name` STRING COMMENT 'Human‑readable name of the quote template.',
    `notes` STRING COMMENT 'Additional free‑form notes for internal users.',
    `pricing_terms` STRING COMMENT 'Free‑text description of pricing rules, payment terms, and conditions embedded in the template.',
    `region` STRING COMMENT 'Primary geographic region where the template is used.',
    `revision_number` STRING COMMENT 'Sequential number tracking manual revisions of the template content.',
    `quote_template_status` STRING COMMENT 'Current lifecycle state of the quote template.',
    `template_category` STRING COMMENT 'High‑level business category the template belongs to.',
    `template_code` STRING COMMENT 'Business code used to reference the template in downstream processes.',
    `template_content` STRING COMMENT '',
    `template_name` STRING COMMENT '',
    `template_owner` STRING COMMENT 'Name or identifier of the business owner responsible for the template.',
    `template_type` STRING COMMENT '',
    `template_version_description` STRING COMMENT 'Narrative description of changes introduced in this version.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the template record.',
    `validity_period_days` STRING COMMENT 'Number of days the generated quote remains valid after issuance.',
    `version` STRING COMMENT 'Incremental version number of the template; higher numbers indicate newer revisions.',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_quote_template PRIMARY KEY(`quote_template_id`)
) COMMENT 'Master reference table for quote_template. Referenced by template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_primary_opportunity_territory_id` FOREIGN KEY (`primary_opportunity_territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_previous_quote_id` FOREIGN KEY (`previous_quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_quote_template_id` FOREIGN KEY (`quote_template_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_template`(`quote_template_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bundle_parent_line_id` FOREIGN KEY (`bundle_parent_line_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ADD CONSTRAINT `fk_sales_sales_lead_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_primary_predecessor_assignment_territory_assignment_id` FOREIGN KEY (`primary_predecessor_assignment_territory_assignment_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory_assignment`(`territory_assignment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_territory_sales_rep_id` FOREIGN KEY (`territory_sales_rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_parent_quota_id` FOREIGN KEY (`parent_quota_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quota`(`quota_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_quota_sales_rep_id` FOREIGN KEY (`quota_sales_rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_quota_territory_id` FOREIGN KEY (`quota_territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_parent_price_book_id` FOREIGN KEY (`parent_price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_discount_schedule_id` FOREIGN KEY (`discount_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`discount_schedule`(`discount_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_forecast_sales_rep_id` FOREIGN KEY (`forecast_sales_rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_previous_forecast_id` FOREIGN KEY (`previous_forecast_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`forecast`(`forecast_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_primary_forecast_territory_id` FOREIGN KEY (`primary_forecast_territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_sales_team_id` FOREIGN KEY (`sales_team_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ADD CONSTRAINT `fk_sales_opportunity_component_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ADD CONSTRAINT `fk_sales_project_rep_assignment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ADD CONSTRAINT `fk_sales_project_rep_assignment_project_sales_rep_id` FOREIGN KEY (`project_sales_rep_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ADD CONSTRAINT `fk_sales_device_contract_assignment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_parent_sales_team_id` FOREIGN KEY (`parent_sales_team_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ADD CONSTRAINT `fk_sales_discount_schedule_base_discount_schedule_id` FOREIGN KEY (`base_discount_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`discount_schedule`(`discount_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ADD CONSTRAINT `fk_sales_discount_schedule_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ADD CONSTRAINT `fk_sales_quote_template_base_quote_template_id` FOREIGN KEY (`base_quote_template_id`) REFERENCES `vibe_manufacturing_v1`.`sales`.`quote_template`(`quote_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `primary_opportunity_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Synced Quote ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'quote_pricing');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `compliance_product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `previous_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Quote Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_template_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Template Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Acceptance Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `competitor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `competitor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote` ALTER COLUMN `quote_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'quote_pricing');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `bundle_parent_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Parent Line Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `bundle_parent_line_id` SET TAGS ('dbx_self_ref_fk_reviewed' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|engineering_approved|legal_approved|commercial_approved|fully_approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `competitor_names` SET TAGS ('dbx_business_glossary_term' = 'Competitor Names');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `competitor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `competitor_names` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `competitor_names` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Proposal Currency');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `estimated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `grand_total` SET TAGS ('dbx_business_glossary_term' = 'Grand Total');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `grand_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `pricing_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Pricing Breakdown');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `pricing_breakdown` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `project_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Project Duration in Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_value_regex' = '^PROP-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'technical|commercial|technical_commercial|rfp_response|epc|turnkey');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `rfp_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `risk_clauses` SET TAGS ('dbx_business_glossary_term' = 'Risk Clauses');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `scope_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Scope of Supply');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `solution_architecture_summary` SET TAGS ('dbx_business_glossary_term' = 'Solution Architecture Summary');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Proposal Value');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `sales_lead_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Lead Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Opportunity Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Account Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Contact Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `company_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `company_size` SET TAGS ('dbx_business_glossary_term' = 'Company Size');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `company_size` SET TAGS ('dbx_value_regex' = 'small|medium|large|enterprise');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `contact_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `sales_lead_description` SET TAGS ('dbx_business_glossary_term' = 'Lead Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `estimated_close_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `estimated_project_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project Value');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `estimated_project_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `industry_segment` SET TAGS ('dbx_value_regex' = 'automotive|food_beverage|pharma|discrete_manufacturing|process_manufacturing|oil_gas');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Is Converted Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `lead_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_business_glossary_term' = 'Lead Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_value_regex' = '^LEAD-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_value_regex' = 'new|contacted|qualified|disqualified|converted');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `product_interest_area` SET TAGS ('dbx_business_glossary_term' = 'Product Interest Area');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Lead Rating');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'hot|warm|cold');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Detail');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `street_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `street_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_lead` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` SET TAGS ('dbx_subdomain' = 'contract_revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'standard|custom|framework|blanket|spot|turnkey');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Signatory Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signature Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sla_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Manager ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `annual_revenue_quota` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Quota');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `annual_revenue_quota` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `assignment_rule` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rule');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `coverage_model` SET TAGS ('dbx_business_glossary_term' = 'Coverage Model');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `coverage_model` SET TAGS ('dbx_value_regex' = 'direct|channel|hybrid|inside_sales|field_sales');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^FY[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `is_overlay_territory` SET TAGS ('dbx_business_glossary_term' = 'Is Overlay Territory Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|smb|oem|government|education');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `overlay_type` SET TAGS ('dbx_business_glossary_term' = 'Overlay Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `overlay_type` SET TAGS ('dbx_value_regex' = 'product_specialist|solution_architect|key_account|none');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'strategic|high|medium|low|emerging');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `product_line_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Line Scope');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `quota_period` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `region_level` SET TAGS ('dbx_business_glossary_term' = 'Region Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `region_level` SET TAGS ('dbx_value_regex' = 'global|regional|country|local|district|zone');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|reseller|online|oem|system_integrator');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `sales_team_size` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Size');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived|planned');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|industry_vertical|account_based|product_line|hybrid|named_account');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `territory_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `primary_predecessor_assignment_territory_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Assignment ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `territory_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'manual|automated_rule|territory_model|import|api');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|overlay|product_specialist|technical_specialist|inside_sales|channel_partner');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `assignment_version` SET TAGS ('dbx_business_glossary_term' = 'Assignment Version');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'full|partial|strategic_accounts_only|named_accounts|transactional');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `coverage_role` SET TAGS ('dbx_business_glossary_term' = 'Coverage Role');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `coverage_role` SET TAGS ('dbx_value_regex' = 'account_manager|product_specialist|technical_consultant|inside_sales_rep|channel_manager|overlay_specialist');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `industry_vertical_focus` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical Focus');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `product_line_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Line Focus');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `quota_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`territory_assignment` ALTER COLUMN `revenue_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Full Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_id` SET TAGS ('dbx_business_glossary_term' = 'Quota ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `parent_quota_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Quota ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Quota Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Quota Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `tertiary_quota_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `tertiary_quota_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `tertiary_quota_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Adjustment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Adjustment Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Quota Adjustment Reason');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|hybrid|historical|market_based');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Quota Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `attainment_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `attainment_percent` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `base_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Quota Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `is_team_quota` SET TAGS ('dbx_business_glossary_term' = 'Is Team Quota Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `last_attainment_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Attainment Calculation Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quota Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_number` SET TAGS ('dbx_value_regex' = '^QTA-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_status` SET TAGS ('dbx_business_glossary_term' = 'Quota Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `quota_type` SET TAGS ('dbx_value_regex' = 'revenue|units|margin|new_logos|bookings|pipeline');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quota Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quota` ALTER COLUMN `stretch_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Stretch Quota Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` SET TAGS ('dbx_subdomain' = 'quote_pricing');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `parent_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Price Book ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `tertiary_price_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `tertiary_price_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `tertiary_price_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price Book Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_status` SET TAGS ('dbx_business_glossary_term' = 'Price Book Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_business_glossary_term' = 'Price Book Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price Book Version');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` SET TAGS ('dbx_subdomain' = 'quote_pricing');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `discount_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Schedule Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `tertiary_price_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `tertiary_price_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `tertiary_price_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`price_book_entry` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` SET TAGS ('dbx_subdomain' = 'contract_revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `previous_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Forecast ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `primary_forecast_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `best_case_amount` SET TAGS ('dbx_business_glossary_term' = 'Best Case Forecast Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `closed_amount` SET TAGS ('dbx_business_glossary_term' = 'Closed Won Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Forecast Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_value_regex' = '^FC-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `is_latest_version` SET TAGS ('dbx_business_glossary_term' = 'Is Latest Forecast Version');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Last Modified Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `manager_adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Manager Adjusted Forecast Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Manager Review Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `opportunity_count` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Count');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `pipeline_amount` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Forecast Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Quota Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `quota_attainment_percent` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Forecast Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `submitted_amount` SET TAGS ('dbx_business_glossary_term' = 'Submitted Forecast Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `variance_to_quota` SET TAGS ('dbx_business_glossary_term' = 'Variance to Quota');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`forecast` ALTER COLUMN `weighted_pipeline_amount` SET TAGS ('dbx_business_glossary_term' = 'Weighted Pipeline Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` SET TAGS ('dbx_subdomain' = 'partner_channels');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Manager Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `authorized_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Lines');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|in_progress|expired|not_certified');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `deal_registration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Deal Registration Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Discount Tier Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `discount_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|standard');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `discount_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Range');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_value_regex' = '1-10|11-50|51-200|201-500|501-1000|1001-5000|5000+');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Territory');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `industry_focus` SET TAGS ('dbx_business_glossary_term' = 'Industry Focus or Specialization');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Business Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `mdf_eligible` SET TAGS ('dbx_business_glossary_term' = 'Market Development Funds (MDF) Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes or Comments');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_number` SET TAGS ('dbx_business_glossary_term' = 'Partner Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_program_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Enrollment Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|registered');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'distributor|system_integrator|var|oem|reseller|consultant');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `target_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Target Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `target_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `technical_capability_level` SET TAGS ('dbx_business_glossary_term' = 'Technical Capability Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `technical_capability_level` SET TAGS ('dbx_value_regex' = 'advanced|intermediate|basic');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name or Doing Business As (DBA)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `trade_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `trade_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`channel_partner` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Partner Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` SET TAGS ('dbx_subdomain' = 'contract_revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team ID');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `booking_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Recognition Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `booking_recognized_flag` SET TAGS ('dbx_business_glossary_term' = 'Booking Recognized Flag');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`order_intake` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
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
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` SET TAGS ('dbx_association_edges' = 'engineering.component,sales.opportunity');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ALTER COLUMN `opportunity_component_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Component - Opportunity Component Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Component - Component Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Component - Opportunity Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ALTER COLUMN `interest_level` SET TAGS ('dbx_business_glossary_term' = 'Interest Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`opportunity_component` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` SET TAGS ('dbx_association_edges' = 'sales.rep,project.project_header');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `project_rep_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Project Rep Assignment - Project Rep Assignment Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Rep Assignment - Project Header Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `project_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Project Rep Assignment - Sales Rep Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`project_rep_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` SET TAGS ('dbx_subdomain' = 'contract_revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` SET TAGS ('dbx_association_edges' = 'sales.sales_contract,automation.device_registry');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `device_contract_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Device Contract Assignment - Device Contract Assignment Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Contract Assignment - Device Registry Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Device Contract Assignment - Sales Contract Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `assigned_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `contract_device_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Device End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `contract_device_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Device Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`device_contract_assignment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'partner_channels');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `actual_clicks` SET TAGS ('dbx_business_glossary_term' = 'Actual Clicks');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `actual_leads` SET TAGS ('dbx_business_glossary_term' = 'Actual Leads');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `actual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `expected_clicks` SET TAGS ('dbx_business_glossary_term' = 'Expected Clicks');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `expected_impressions` SET TAGS ('dbx_business_glossary_term' = 'Expected Impressions');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `expected_leads` SET TAGS ('dbx_business_glossary_term' = 'Expected Leads');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `expected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `is_test_campaign` SET TAGS ('dbx_business_glossary_term' = 'Is Test Campaign');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Objective');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `success_metric` SET TAGS ('dbx_business_glossary_term' = 'Success Metric');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `parent_sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sales Team Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `parent_sales_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_team_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Is Remote');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `office_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `office_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `product_line_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Line Focus');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `quota_achieved` SET TAGS ('dbx_business_glossary_term' = 'Quota Achieved');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `quota_target` SET TAGS ('dbx_business_glossary_term' = 'Quota Target');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_channel_focus` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Focus');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `sales_team_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `team_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `team_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`sales_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` SET TAGS ('dbx_subdomain' = 'quote_pricing');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `discount_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Schedule Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `base_discount_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Base Discount Schedule Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `base_discount_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `applies_to_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applies To Customer Segment');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `applies_to_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applies To Product Category');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `discount_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `discount_method` SET TAGS ('dbx_business_glossary_term' = 'Discount Method');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Max Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `discount_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `tier_max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Max Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `tier_min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Min Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`discount_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` SET TAGS ('dbx_subdomain' = 'quote_pricing');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_template_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Template Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `base_quote_template_id` SET TAGS ('dbx_business_glossary_term' = 'Base Quote Template Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `base_quote_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Archived By User Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `applicable_product_line` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Line');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `approval_deadline` SET TAGS ('dbx_business_glossary_term' = 'Approval Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `default_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Discount Percent');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `default_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Price Amount');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `industry` SET TAGS ('dbx_business_glossary_term' = 'Industry');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_template_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_template_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_template_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `quote_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `template_category` SET TAGS ('dbx_business_glossary_term' = 'Template Category');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `template_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `template_owner` SET TAGS ('dbx_business_glossary_term' = 'Template Owner');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `template_version_description` SET TAGS ('dbx_business_glossary_term' = 'Template Version Description');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Days');
ALTER TABLE `vibe_manufacturing_v1`.`sales`.`quote_template` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
