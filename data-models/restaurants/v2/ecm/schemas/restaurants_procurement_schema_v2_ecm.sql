-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`procurement` COMMENT 'Owns sourcing events, supplier contracts, spend analytics, purchase requisition-to-order workflows, approved vendor lists, contract compliance, and category management for food, packaging, equipment, and services via Coupa Procurement. Distinct from supply domain which tracks physical inventory movement — procurement owns the commercial supplier relationship and contractual terms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'System-generated unique identifier for the approved vendor list record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor approval process mandates sign‑off by a specific employee; linking provides traceability for compliance audits.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Approved vendor list must reference the supplier it approves; this creates the missing inbound/outbound link for the table.',
    `approval_date` DATE COMMENT 'Date when the vendor was approved.',
    `approved_status` STRING COMMENT 'Current approval status of the vendor.. Valid values are `approved|pending|rejected|suspended`',
    `audit_requirement` STRING COMMENT 'Specific audit or compliance requirements for the vendor (e.g., HACCP, FDA).',
    `bank_account_number` STRING COMMENT 'Bank account number used for vendor payments.',
    `category_scope` STRING COMMENT 'Product or service categories the vendor is approved to supply.. Valid values are `food|packaging|equipment|services|beverage|technology`',
    `compliance_documents` STRING COMMENT 'Identifiers or references to compliance documents on file for the vendor.',
    `compliance_status` STRING COMMENT 'Current compliance status of the vendor.. Valid values are `compliant|non_compliant|under_review`',
    `contract_end_date` DATE COMMENT 'End date of the vendors contract.',
    `contract_start_date` DATE COMMENT 'Start date of the vendors contract.',
    `contract_terms_summary` STRING COMMENT 'Brief summary of key contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `disqualification_date` DATE COMMENT 'Date when the vendor was disqualified.',
    `disqualification_reason` STRING COMMENT 'Reason for any past disqualification of the vendor.',
    `expiry_date` DATE COMMENT 'Date when the vendors approval expires.',
    `geographic_scope` STRING COMMENT 'Geographic coverage for which the vendor is approved.. Valid values are `national|regional|global`',
    `insurance_certificate_expiry` DATE COMMENT 'Expiration date of the vendors liability insurance certificate.',
    `is_currently_approved` BOOLEAN COMMENT 'Indicates whether the vendor is presently approved for procurement.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit performed on the vendor.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit.. Valid values are `pass|fail|conditional|not_applicable`',
    `last_modified_by` STRING COMMENT 'User or system that performed the most recent update.',
    `notes` STRING COMMENT 'Free‑text notes regarding the vendor.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the vendor (e.g., Net 30).',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates if the vendor is marked as a preferred supplier.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact for the vendor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score (0‑100) for the vendor.',
    `tax_id_number` STRING COMMENT 'Vendors tax identification number for reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `vendor_category_code` STRING COMMENT 'Internal code used to categorize the vendor.',
    `vendor_identifier` STRING COMMENT 'Unique vendor code used in Coupa Procurement.',
    `vendor_rating` DECIMAL(18,2) COMMENT 'Average performance rating (0‑5) for the vendor.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on its role in the supply chain.. Valid values are `manufacturer|distributor|service_provider|raw_material_supplier|packaging_supplier|technology_supplier`',
    `created_by` STRING COMMENT 'User or system that created the record.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Authoritative registry of suppliers approved to supply specific categories, items, or restaurant segments. Captures approval status, approval date, expiry date, approving authority, category scope, geographic scope (national/regional), audit requirements, and disqualification history. Governs which suppliers may receive purchase orders — a critical food safety and compliance control.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the procurement_category data product (auto-inserted pre-linking).',
    `category_name` STRING COMMENT '',
    `category_description` STRING COMMENT '',
    `parent_category_id` BIGINT COMMENT '',
    `category_level` BIGINT COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Procurement spend category hierarchy used for category management — food ingredients, packaging materials, smallwares, equipment, facilities services, marketing materials, and technology. Captures category code, parent category, category manager assignment, strategic classification (direct/indirect), spend threshold, and sourcing strategy. Enables PMIX-aligned category management and COGS% analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'System-generated unique identifier for the sourcing event.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier that won the event.',
    `employee_id` BIGINT COMMENT 'Internal employee responsible for managing the sourcing event.',
    `sourcing_stakeholder_employee_id` BIGINT COMMENT 'Internal employee responsible for managing the sourcing event.',
    `award_amount` DECIMAL(18,2) COMMENT 'Monetary value of the contract awarded to the supplier.',
    `award_date` TIMESTAMP COMMENT 'Timestamp when the award was formally issued to the winning supplier.',
    `award_decision` STRING COMMENT 'Result of the sourcing event indicating whether a supplier was awarded.. Valid values are `awarded|not_awarded|cancelled`',
    `category_scope` STRING COMMENT 'Business category or commodity group the sourcing event targets.. Valid values are `food|packaging|equipment|services`',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance standards applicable to the event (e.g., FDA, OSHA, ISO 22000).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for award_amount.',
    `sourcing_event_description` STRING COMMENT 'Free‑text description providing context, objectives, and any special notes for the event.',
    `evaluation_criteria` STRING COMMENT 'Textual definition of the criteria used to evaluate supplier responses.',
    `event_code` STRING COMMENT 'External business code or number assigned to the sourcing event for reference in contracts and reports.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing event closes for further submissions.',
    `event_name` STRING COMMENT 'Descriptive name of the sourcing event, e.g., "2024 Q1 Food Commodity RFQ".',
    `event_notes` STRING COMMENT 'Additional free‑form notes captured by the procurement team.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing event officially opens for supplier participation.',
    `event_type` STRING COMMENT 'Type of sourcing event indicating the procurement method used.. Valid values are `rfi|rfp|rfq|reverse_auction`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the sourcing event details are confidential.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the sourcing event.. Valid values are `draft|open|closed|cancelled|completed`',
    `submission_deadline` TIMESTAMP COMMENT 'Date‑time by which suppliers must submit their responses.',
    `total_budget` DECIMAL(18,2) COMMENT 'Maximum budget allocated for the sourcing event.',
    `updated_by` STRING COMMENT 'User identifier of the employee who last modified the sourcing event record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sourcing event record.',
    `weighting_scheme` STRING COMMENT 'Details of how each evaluation criterion is weighted (e.g., price 40%, quality 30%).',
    `created_by` STRING COMMENT 'User identifier of the employee who created the sourcing event record.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Formal competitive sourcing event (RFI, RFP, RFQ, reverse auction) managed through Coupa. Captures event type, event name, category scope, participating suppliers, submission deadlines, evaluation criteria, weighting, award decision, and event status. Supports strategic sourcing for food commodities, packaging, equipment, and services. Tracks LTO-driven sourcing events and annual contract renewals.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` (
    `sourcing_response_id` BIGINT COMMENT 'System-generated unique identifier for the suppliers response to a sourcing event.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier submitting the response.',
    `sourcing_event_id` BIGINT COMMENT 'Identifier of the sourcing event (RFI/RFP/RFQ) to which this response belongs.',
    `award_status` STRING COMMENT 'Indicates whether the response resulted in a contract award.. Valid values are `awarded|not_awarded`',
    `bid_type` STRING COMMENT 'Type of sourcing solicitation the response addresses.. Valid values are `RFI|RFP|RFQ`',
    `compliance_attestations` STRING COMMENT 'Supplier’s attestations to regulatory or contractual compliance (e.g., FDA, OSHA).',
    `compliance_score` DECIMAL(18,2) COMMENT 'Score reflecting the supplier’s compliance with regulatory and contractual requirements.',
    `contract_term_months` STRING COMMENT 'Proposed duration of the contract in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the response record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for pricing.. Valid values are `[A-Z]{3}`',
    `delivery_terms` STRING COMMENT 'Conditions governing delivery (e.g., FOB, DDP).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the base price before tax.',
    `disqualification_reason` STRING COMMENT 'Reason provided if the response was disqualified.',
    `is_eligible` BOOLEAN COMMENT 'True if the supplier meets all mandatory eligibility criteria.',
    `is_preferred_supplier` BOOLEAN COMMENT 'Indicates if the supplier is designated as a preferred vendor.',
    `lead_time_days` STRING COMMENT 'Estimated number of days from order receipt to delivery.',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity the supplier will accept for this offer.',
    `net_price` DECIMAL(18,2) COMMENT 'Final price after tax and discount adjustments.',
    `payment_terms` STRING COMMENT 'Suppliers payment conditions (e.g., Net 30).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price quoted for the primary SKU or service.',
    `quality_certifications` STRING COMMENT 'Comma‑separated list of quality or safety certifications supplied (e.g., ISO 22000, HACCP).',
    `response_comments` STRING COMMENT 'Free‑form notes or comments supplied by the supplier.',
    `response_number` STRING COMMENT 'Business identifier assigned to the response for tracking and reference.',
    `risk_level` STRING COMMENT 'Assessed risk category of the supplier’s proposal.. Valid values are `low|medium|high`',
    `scoring_rank` STRING COMMENT 'Rank position of the response among all submitted bids.',
    `scoring_total` DECIMAL(18,2) COMMENT 'Aggregated score assigned by the evaluation team.',
    `sourcing_response_status` STRING COMMENT 'Current lifecycle status of the response.. Valid values are `submitted|under_review|awarded|rejected|disqualified`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted the response.',
    `supplier_rating` DECIMAL(18,2) COMMENT 'Overall rating of the supplier based on historical performance.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component included in the total price.',
    `total_price` DECIMAL(18,2) COMMENT 'Aggregate monetary amount quoted in the response, before any adjustments.',
    `unit_of_measure` STRING COMMENT 'Measurement unit associated with the unit price (e.g., each, kg, liter).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the response record.',
    `valid_until` DATE COMMENT 'Date until which the quoted terms and pricing remain valid.',
    `warranty_period_months` STRING COMMENT 'Length of warranty offered, expressed in months.',
    CONSTRAINT pk_sourcing_response PRIMARY KEY(`sourcing_response_id`)
) COMMENT 'Supplier bid or response submitted to a sourcing event (RFI/RFP/RFQ). Captures responding supplier, submitted pricing, proposed lead times, quality certifications offered, compliance attestations, scoring results, disqualification reasons, and award status. Enables side-by-side supplier evaluation and supports audit trails for sourcing decisions.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`contract` (
    `contract_id` BIGINT COMMENT 'System-generated unique identifier for the contract record.',
    `employee_id` BIGINT COMMENT 'Internal employee responsible for overall contract stewardship.',
    `owner_employee_id` BIGINT COMMENT 'Internal employee responsible for overall contract stewardship.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier party associated with the contract.',
    `amendment_count` STRING COMMENT 'Number of amendments or addenda applied to the contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance obligations tied to the contract.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the contract record.. Valid values are `public|internal|confidential|restricted`',
    `contract_number` STRING COMMENT 'External business identifier or reference number assigned to the contract.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `contract_type` STRING COMMENT 'Classification of the agreement (e.g., MSA, BPA, framework).. Valid values are `master_service_agreement|master_purchase_agreement|framework_agreement|blanket_purchase_order|license_agreement|service_level_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the contract value.. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price, if any.',
    `document_url` STRING COMMENT 'Link to the stored electronic contract document.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or ends; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes legally binding.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the supplier has exclusive rights for the supplied goods/services.',
    `governing_body` STRING COMMENT 'Regulatory or standards organization governing the contract terms.. Valid values are `FDA|USDA|OSHA|FTC|ISO22000`',
    `last_review_date` DATE COMMENT 'Date of the most recent contract performance or compliance review.',
    `manager_contact` STRING COMMENT 'Email address of the contract manager or primary point of contact.',
    `contract_name` STRING COMMENT 'Descriptive name of the contract for easy identification.',
    `next_renewal_date` DATE COMMENT 'Planned date for the next contract renewal cycle.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the supplier.. Valid values are `net_30|net_45|net_60|due_on_receipt|custom`',
    `penalty_clause` STRING COMMENT 'Financial or operational penalties for SLA breaches or contract violations.',
    `pricing_model` STRING COMMENT 'Method used to calculate pricing under the contract.. Valid values are `fixed|variable|tiered|cost_plus|subscription`',
    `rebate_terms` STRING COMMENT 'Conditions under which rebates are earned and applied.',
    `regulatory_approval_status` STRING COMMENT 'Status of required regulatory approvals for the contract.. Valid values are `approved|pending|rejected`',
    `renewal_term_months` STRING COMMENT 'Length of each renewal period in months when auto‑renewal is enabled.',
    `scope_of_supply` STRING COMMENT 'Description of goods, services, or deliverables covered by the contract.',
    `sla_commitment` STRING COMMENT 'Key performance metrics and service levels promised by the supplier.',
    `termination_date` DATE COMMENT 'Date on which the contract was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason provided for early termination of the contract.',
    `total_value` DECIMAL(18,2) COMMENT 'Monetary value of the contract covering all line items and services.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `version_number` STRING COMMENT 'Version identifier for the contract document (e.g., v1.0, v2.1).',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master procurement contract governing the commercial relationship with a supplier — supply agreements, master service agreements (MSAs), pricing agreements, and blanket purchase orders — managed in Coupa Contract Management. Captures contract type, effective/expiry dates, auto-renewal flags, royalty/rebate terms, exclusivity clauses, SLA commitments, termination conditions, total contract value, and amendment history. SSOT for contractual terms in the procurement domain. Supports annual contract renewal cycles aligned with commodity market timing and LTO launch schedules.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Unique surrogate key for each contract line item.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract line changes require manager approval; linking to employee enables contract amendment audit.',
    `contract_id` BIGINT COMMENT 'Identifier of the parent procurement contract to which this line belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REQUIRED: Contract line items are budgeted to specific cost centers, essential for capex tracking and compliance reporting.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the item.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Enables mapping contract line SKUs to inventory items for cost tracking, COGS calculation, and contract performance reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract line was approved.',
    `compliance_requirements` STRING COMMENT 'Regulatory or certification requirements applicable to the line (e.g., FDA, ISO 22000).',
    `contract_line_status` STRING COMMENT 'Current lifecycle state of the contract line.. Valid values are `draft|active|expired|cancelled`',
    `contract_line_type` STRING COMMENT 'Category of the line item (e.g., goods, service).. Valid values are `goods|service|packaging|equipment`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `delivery_location_code` STRING COMMENT 'Internal code representing the delivery destination for the item.',
    `effective_end_date` DATE COMMENT 'Date when the contract line expires or is superseded (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the contract line becomes binding.',
    `is_price_locked` BOOLEAN COMMENT 'Indicates whether the negotiated price is locked for the contract duration.',
    `is_renewable` BOOLEAN COMMENT 'True if the contract line can be automatically renewed.',
    `item_description` STRING COMMENT 'Human‑readable description of the product or service.',
    `lead_time_days` STRING COMMENT 'Number of days from order to delivery for this line.',
    `line_sequence` STRING COMMENT 'Ordinal position of the line within the contract for ordering and display.',
    `maximum_order_quantity` STRING COMMENT 'Largest quantity allowed per order for this line.',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity that can be ordered under this contract line.',
    `notes` STRING COMMENT 'Additional remarks or special conditions.',
    `price_escalation_clause` STRING COMMENT 'Text describing any price escalation mechanisms (e.g., CPI‑linked).',
    `price_escalation_frequency` STRING COMMENT 'How often the escalation clause is applied.. Valid values are `annual|quarterly|monthly|none`',
    `price_escalation_percent` DECIMAL(18,2) COMMENT 'Percentage increase applied at each escalation interval.',
    `price_tier_end_quantity` STRING COMMENT 'Upper bound quantity for a volume‑based price tier (null if open‑ended).',
    `price_tier_start_quantity` STRING COMMENT 'Lower bound quantity for a volume‑based price tier.',
    `regulatory_approval_status` STRING COMMENT 'Current status of required regulatory approvals.. Valid values are `approved|pending|rejected`',
    `renewal_option` STRING COMMENT 'Method by which renewal is handled.. Valid values are `auto|manual|none`',
    `sku` STRING COMMENT 'Standardized product code identifying the item covered by the contract line.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate for the line item.',
    `tier_price` DECIMAL(18,2) COMMENT 'Unit price that applies when order quantity falls within the tier range.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit for the line item.',
    `uom` STRING COMMENT 'Measurement unit used for quantity and pricing.. Valid values are `kg|lb|unit|case|liter|gallon`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `waste_percentage_allowed` DECIMAL(18,2) COMMENT 'Maximum permitted waste percentage for the supplied item.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Expected usable yield of the product after processing.',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Individual line items within a procurement contract or standalone pricing agreement specifying the exact SKU, ingredient, packaging item, or service covered. Captures negotiated unit price, UOM, minimum order quantity (MOQ), volume tiers, price escalation clauses (CPI-linked, commodity index-linked), volume commitments, effective date ranges, and approval status. Covers both full contract lines and standalone price agreements. Enables granular contract compliance checking against actual PO prices and supports commodity cost management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`requisition` (
    `requisition_id` BIGINT COMMENT 'System-generated unique identifier for the purchase requisition.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the requisition.',
    `contract_id` BIGINT COMMENT 'Link to a master agreement governing the purchase, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REQUIRED: Requisition approval must allocate costs to a cost center for budgeting and expense tracking, a standard finance‑procurement process.',
    `created_by_employee_id` BIGINT COMMENT 'Employee who initially entered the requisition into the system.',
    `department_id` BIGINT COMMENT 'Organizational department responsible for the requisition.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who originated the requisition.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Supports Requisition Approval Workflow: franchisee initiates requisitions for supplies; FK ties request to owning franchisee for budgeting.',
    `primary_requisition_approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the requisition.',
    `unit_id` BIGINT COMMENT 'Restaurant unit or site for which the requisition is raised.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Requisition process requests specific inventory SKUs; linking enables inventory reservation and demand forecasting.',
    `tertiary_requisition_employee_id` BIGINT COMMENT 'Identifier of the employee who originated the requisition.',
    `approval_status` STRING COMMENT 'Current approval state of the requisition.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition received final approval.',
    `budget_code` STRING COMMENT 'Budget line or code governing the allowable spend.',
    `compliance_flag` BOOLEAN COMMENT 'True if the requisition must satisfy specific regulatory or food‑safety compliance.',
    `compliance_notes` STRING COMMENT 'Additional notes regarding compliance requirements or certifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated amounts.',
    `delivery_method` STRING COMMENT 'Preferred method for receiving the goods.. Valid values are `delivery|pickup|none`',
    `discount_estimate` DECIMAL(18,2) COMMENT 'Projected discount or rebate amount applied to the requisition.',
    `expected_delivery_date` DATE COMMENT 'Target date for receipt of goods or services.',
    `justification_text` STRING COMMENT 'Free‑form description explaining the need for the purchase.',
    `line_item_count` STRING COMMENT 'Count of distinct line‑item entries attached to the requisition.',
    `net_estimated_amount` DECIMAL(18,2) COMMENT 'Estimated total after tax and discount adjustments.',
    `payment_terms` STRING COMMENT 'Negotiated payment conditions (e.g., Net 30, Net 60).',
    `priority_level` STRING COMMENT 'Business‑defined priority used for routing and approval.. Valid values are `low|medium|high`',
    `procurement_method` STRING COMMENT 'Method used to acquire the goods or services.. Valid values are `internal|external|spot|contract`',
    `required_by_date` DATE COMMENT 'Date by which the requested items must be available for operation.',
    `requisition_number` STRING COMMENT 'Human‑readable business identifier assigned to the requisition.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `spend_category_code` STRING COMMENT 'Classification of spend (e.g., food, packaging, equipment).',
    `supplier_preference` STRING COMMENT 'Indicates if a specific supplier is preferred for this requisition.. Valid values are `preferred|any|none`',
    `tax_estimate` DECIMAL(18,2) COMMENT 'Projected tax amount based on applicable tax rules.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the requisition is tax‑exempt.',
    `tax_exempt_reason` STRING COMMENT 'Reason or code for tax exemption, if applicable.',
    `total_estimated_amount` DECIMAL(18,2) COMMENT 'Sum of estimated line‑item costs before taxes, discounts, or adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the requisition record.',
    `urgency_flag` BOOLEAN COMMENT 'Indicates whether the requisition is marked as urgent.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Internal purchase requisition (PR) initiating the procure-to-pay workflow in Coupa. Captures requesting department, restaurant unit or support center, requested items, estimated cost, business justification, budget code, urgency flag, preferred supplier, and multi-level approval status with routing history. Represents the demand signal before a purchase order is raised — the first formal step in authorized procurement spend.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order line.',
    `budget_line_id` BIGINT COMMENT 'Identifier of the budget line to which this purchase is charged.',
    `contract_line_id` BIGINT COMMENT 'Reference to the contract line that governs pricing or terms for this PO line.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the parent purchase order header to which this line belongs.',
    `primary_po_header_procurement_purchase_order_id` BIGINT COMMENT 'Identifier of the parent purchase order header to which this line belongs.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the item.',
    `procurement_item_id` BIGINT COMMENT 'Unique identifier of the product or SKU referenced by this line.',
    `actual_delivery_date` DATE COMMENT 'Date the line items were actually received.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the item meets required food safety or regulatory standards.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order line record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary values on the line.',
    `delivery_status` STRING COMMENT 'Status of the lines delivery to the restaurant.. Valid values are `pending|shipped|delivered|failed`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the line.',
    `expected_delivery_date` DATE COMMENT 'Planned date for receipt of the line items.',
    `extended_amount` DECIMAL(18,2) COMMENT 'Total amount for the line before discounts and taxes (ordered_quantity * unit_price).',
    `invoice_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was invoiced.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item that has been invoiced.',
    `is_late` BOOLEAN COMMENT 'True if actual delivery date is later than expected delivery date.',
    `is_three_way_match` BOOLEAN COMMENT 'Indicates whether PO, receipt, and invoice have been fully matched.',
    `item_description` STRING COMMENT 'Free-text description of the purchased item.',
    `item_sku` STRING COMMENT 'Stock Keeping Unit code for the purchased item.',
    `lead_time_days` STRING COMMENT 'Number of days between PO creation and actual delivery.',
    `line_number` STRING COMMENT 'Sequential number of the line within the purchase order.',
    `line_status` STRING COMMENT 'Current processing status of the purchase order line.. Valid values are `open|partially_received|received|invoiced|cancelled`',
    `line_type` STRING COMMENT 'Classification of the line content (e.g., goods, service, fee).. Valid values are `goods|service|fee`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after discounts and taxes (extended_amount - discount_amount + tax_amount).',
    `notes` STRING COMMENT 'Free-text field for additional comments or special instructions.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item requested on the purchase order line.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Timestamp when receipt of the line was recorded.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item that has been received against this line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax calculated for the line based on applicable tax rules.',
    `tax_code` STRING COMMENT 'Internal tax code used to determine tax treatment.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the line.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated price per unit of the item, before taxes and discounts.',
    `uom` STRING COMMENT 'Unit of measure for quantity fields (e.g., each, kg, lb).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Percentage of the ordered quantity that was wasted or scrapped.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items on a purchase order specifying the exact item (food SKU, packaging SKU, equipment, or service), ordered quantity, UOM, negotiated unit price, extended amount, contract line reference, and line-level delivery status. Enables COGS% tracking at the ingredient/SKU level and supports three-way match (PO → receipt → invoice).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the supplier invoice record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoice approval must be recorded against an employee to satisfy internal control and audit requirements.',
    `contract_id` BIGINT COMMENT 'Identifier of the supplier contract governing the invoice.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Supplier invoices are generated against a purchase order; adding purchase_order_id FK creates the proper parent link and removes the redundant free‑text PO number.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier who issued the invoice.',
    `tax_id` BIGINT COMMENT 'Government‑issued tax identifier for the supplier.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Financial reporting allocates invoice costs to the restaurant unit that incurred the expense; unit_id on invoice enables unit‑level P&L.',
    `approval_status` STRING COMMENT 'Current approval workflow state for the invoice.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was approved.',
    `attached_document_url` STRING COMMENT 'Link to the scanned PDF or electronic copy of the invoice.',
    `category_code` STRING COMMENT 'Internal classification code for reporting (e.g., food, packaging, equipment).',
    `cogs_percentage` DECIMAL(18,2) COMMENT 'COGS% derived from the invoice for profitability analysis.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the invoice expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used on the invoice.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice (e.g., early‑payment discount).',
    `dispute_reason` STRING COMMENT 'Free‑text description of why the invoice is disputed.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid penalties.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount offered for early payment.',
    `early_payment_due_date` DATE COMMENT 'Last date to capture the early‑payment discount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate to the corporate reporting currency at invoice posting.',
    `external_comments` STRING COMMENT 'Supplier‑provided remarks visible to external stakeholders.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or other adjustments.',
    `internal_comments` STRING COMMENT 'Private notes for internal accounting or procurement teams.',
    `invoice_date` DATE COMMENT 'Date the supplier issued the invoice.',
    `invoice_number` STRING COMMENT 'External invoice identifier assigned by the supplier.',
    `invoice_type` STRING COMMENT 'Classification of the invoice content.. Valid values are `goods|services|mixed`',
    `is_disputed` BOOLEAN COMMENT 'Indicates whether the invoice is currently under dispute.',
    `line_item_count` STRING COMMENT 'Number of distinct line items on the invoice.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `payment_date` DATE COMMENT 'Date on which payment was posted.',
    `payment_method` STRING COMMENT 'Method used to settle the invoice.. Valid values are `credit_card|bank_transfer|check|cash|digital_wallet`',
    `payment_status` STRING COMMENT 'Current status of payment against the invoice.. Valid values are `unpaid|partial|paid|failed|refunded`',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the supplier.. Valid values are `net30|net45|net60|due_on_receipt`',
    `receipt_date` DATE COMMENT 'Date the goods/services were received.',
    `receipt_number` STRING COMMENT 'Identifier of the goods receipt document.',
    `supplier_invoice_status` STRING COMMENT 'Current lifecycle state of the invoice.. Valid values are `draft|open|approved|paid|cancelled`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the invoice.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) for the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    `vat_number` STRING COMMENT 'VAT registration number of the supplier, if applicable.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier-submitted invoice for goods or services delivered, including header and line-level detail. Captures invoice number, invoice date, supplier reference, PO match status, line-level quantities/amounts/GL coding, tax amounts, currency, payment due date, early payment discount terms, dispute flags, three-way match status (PO → receipt → invoice), and AP processing status. Feeds SAP S/4HANA AP module. Supports COGS% reconciliation and contract compliance verification at the SKU level.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'Unique identifier for the supplier scorecard record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Scorecard evaluations are performed by employees; linking captures evaluator identity for performance and conflict‑of‑interest checks.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier being evaluated.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'Average number of days between order placement and delivery for the supplier.',
    `comments` STRING COMMENT 'Free-text comments from the evaluator regarding supplier performance.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the supplier with contractual and regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `contract_number` STRING COMMENT 'Reference to the supplier contract associated with this scorecard.',
    `corrective_action_count` STRING COMMENT 'Number of corrective actions issued to the supplier during the evaluation period.',
    `cost_savings_percent` DECIMAL(18,2) COMMENT 'Percentage of cost savings achieved through the supplier during the period.',
    `evaluation_period_end` DATE COMMENT 'End date of the period covered by this scorecard.',
    `evaluation_period_start` DATE COMMENT 'Start date of the period covered by this scorecard.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier performance evaluation was completed.',
    `evaluator_department` STRING COMMENT 'Department or business unit of the evaluator.',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of order lines fully supplied.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices that matched purchase order terms without discrepancies.',
    `next_review_due_date` DATE COMMENT 'Planned date for the next supplier performance review.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived on or before the agreed delivery date.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated overall performance score for the supplier.',
    `quality_rejection_rate` DECIMAL(18,2) COMMENT 'Percentage of received items that failed quality inspection.',
    `record_created` TIMESTAMP COMMENT 'Timestamp when the scorecard record was initially created in the system.',
    `record_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scorecard record.',
    `region` STRING COMMENT 'Geographic region of the supplier. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN|IND|BRA — promote to reference product]',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Score reflecting supplier responsiveness to inquiries and issue resolution.',
    `risk_level` STRING COMMENT 'Risk classification based on supplier performance.. Valid values are `low|medium|high|critical`',
    `scorecard_number` STRING COMMENT 'External reference number for the scorecard as used in procurement processes.',
    `scorecard_version` STRING COMMENT 'Version identifier for the scorecard methodology.',
    `supplier_category` STRING COMMENT 'Business category of the supplier.. Valid values are `ingredient|packaging|equipment|service`',
    `supplier_scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard.. Valid values are `draft|active|inactive|archived|pending`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers environmental and sustainability performance.',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Periodic and event-driven performance and risk evaluation of suppliers across quality, delivery, pricing compliance, service, and risk dimensions. Captures evaluation period, overall score, on-time delivery rate, fill rate, quality rejection rate, invoice accuracy rate, responsiveness score, corrective action count, individual compliance events (price deviations, off-contract spend, SLA breaches, unauthorized usage), and risk assessments (financial stability, geographic concentration, single-source dependency, food safety compliance, geopolitical risk with risk scores and mitigation plans). Supports AVL maintenance decisions, contract renewal negotiations, supplier accountability tracking, and supply chain resilience planning.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` (
    `supplier_risk_id` BIGINT COMMENT 'System-generated unique identifier for the supplier risk assessment record.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier to which this risk assessment applies.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the risk assessment was performed.',
    `compliance_fda_flag` BOOLEAN COMMENT 'Indicates whether the supplier meets FDA food safety compliance requirements.',
    `compliance_osha_flag` BOOLEAN COMMENT 'Indicates whether the supplier complies with OSHA workplace safety standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk record was first created in the system.',
    `dependency_percentage` DECIMAL(18,2) COMMENT 'Proportion of total spend (as a percentage) that is allocated to this supplier.',
    `financial_stability_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting the suppliers financial health and stability.',
    `geographic_region` STRING COMMENT 'Primary geographic region or country where the supplier operates.',
    `mitigation_plan` STRING COMMENT 'Narrative description of actions planned or taken to mitigate the identified risk.',
    `next_review_date` DATE COMMENT 'Calendar date when the next risk review is due.',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled risk review cycles.',
    `risk_category` STRING COMMENT 'High-level classification of the risk type affecting the supplier.. Valid values are `financial|geographic|single_source|food_safety|geopolitical`',
    `risk_description` STRING COMMENT 'Detailed narrative describing the nature and impact of the risk.',
    `risk_factor_details` STRING COMMENT 'Structured or free‑text details of individual risk factors contributing to the overall score.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the overall risk severity for the supplier.',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk assessment record.. Valid values are `open|closed|monitoring`',
    `risk_tier` STRING COMMENT 'Risk tier derived from the risk score, indicating priority for mitigation.. Valid values are `critical|high|medium|low`',
    `single_source_dependency` BOOLEAN COMMENT 'True if the organization relies on this supplier for a critical product or service with no viable alternatives.',
    `supplier_financial_rating` STRING COMMENT 'Credit rating of the supplier (e.g., AAA, AA, A, BBB, BB, B, CCC).',
    `supplier_primary_contact` STRING COMMENT 'Primary contact name or identifier for the supplier (e.g., procurement liaison).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the risk record.',
    CONSTRAINT pk_supplier_risk PRIMARY KEY(`supplier_risk_id`)
) COMMENT 'Risk assessment record for a supplier capturing financial stability risk, geographic concentration risk, single-source dependency risk, food safety compliance risk, and geopolitical risk. Captures risk category, risk score, risk tier (critical/high/medium/low), assessment date, mitigation plan, and review frequency. Supports supply chain resilience and business continuity planning.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier_certification` (
    `procurement_supplier_certification_id` BIGINT COMMENT 'Unique identifier for the procurement_supplier_certification data product (auto-inserted pre-linking).',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_supplier. Business justification: Certification records belong to a supplier; adding supplier_id FK eliminates the silo and enables joins to supplier details.',
    CONSTRAINT pk_procurement_supplier_certification PRIMARY KEY(`procurement_supplier_certification_id`)
) COMMENT 'Compliance certifications held by a supplier — FDA food facility registration, USDA organic certification, SQF/BRC/FSSC 22000 food safety certifications, GMP compliance, allergen management certifications, and sustainability certifications (Rainforest Alliance, Fair Trade). Captures certification type, issuing body, certificate number, issue date, expiry date, and renewal status. Critical for AVL maintenance and HACCP compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` (
    `item_specification_id` BIGINT COMMENT 'Unique surrogate key for the item specification record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Item specifications belong to a procurement category; adding the FK removes the redundant free‑text category column.',
    `allergen_declaration` STRING COMMENT 'Comma‑separated list of allergens present in the item (e.g., peanuts, dairy).',
    `approved_substitutes` STRING COMMENT 'Comma‑separated list of item codes that may replace this item.',
    `certification_status` STRING COMMENT 'Current certification state of the item.. Valid values are `certified|pending|not_certified`',
    `item_specification_code` STRING COMMENT 'Unique business code used to identify the specification across systems.',
    `compliance_fda_required` BOOLEAN COMMENT 'Indicates whether FDA compliance is mandatory for this item.',
    `compliance_usda_required` BOOLEAN COMMENT 'Indicates whether USDA compliance is mandatory for this item.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost charged by the supplier for one unit.',
    `country_of_origin` STRING COMMENT 'ISO‑3166‑1 alpha‑3 code of the country where the item originates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `^[A-Z]{3}$`',
    `dietary_restriction` STRING COMMENT 'Dietary attributes applicable to the item.. Valid values are `vegan|vegetarian|gluten_free|nut_free|halal|kosher`',
    `effective_from` DATE COMMENT 'Date when the specification becomes active.',
    `effective_until` DATE COMMENT 'Date when the specification is retired or superseded.',
    `expiration_date` DATE COMMENT 'Date after which the item must not be used.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates if the item is classified as hazardous under OSHA regulations.',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether the item has a limited usable life after receipt.',
    `item_specification_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `active|inactive|deprecated|pending`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection.',
    `lead_time_days` STRING COMMENT 'Expected number of days from order placement to delivery.',
    `material` STRING COMMENT 'Primary material composition of the item or its packaging.',
    `maximum_order_quantity` STRING COMMENT 'Largest quantity that can be ordered in a single transaction.',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity that can be ordered for this item.',
    `item_specification_name` STRING COMMENT 'Human‑readable name of the item specification.',
    `notes` STRING COMMENT 'Free‑form comments or special handling instructions.',
    `packaging_type` STRING COMMENT 'Primary packaging form for the item.. Valid values are `box|bag|bottle|can|pallet|crate`',
    `quality_grade` STRING COMMENT 'Quality classification assigned by supplier or internal QA.. Valid values are `A|B|C|D|E`',
    `quantity_per_unit` DECIMAL(18,2) COMMENT 'Number of base units contained in one purchase unit.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the item can be stored before expiration.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature in degrees Celsius.',
    `supplier_requirements` STRING COMMENT 'Specific criteria that suppliers must meet to provide this item.',
    `temperature_control_required` BOOLEAN COMMENT 'True if the item must be stored under controlled temperature conditions.',
    `temperature_range_c` STRING COMMENT 'Acceptable temperature range expressed as min‑max (e.g., "2-8").',
    `traceability_required` BOOLEAN COMMENT 'Indicates if the item must be tracked through the supply chain for compliance.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for quantity fields.. Valid values are `kg|g|lb|oz|liter|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification.',
    `volume_liters` DECIMAL(18,2) COMMENT 'Physical volume of the item in liters.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of the item that may be wasted during processing.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the item in kilograms.',
    CONSTRAINT pk_item_specification PRIMARY KEY(`item_specification_id`)
) COMMENT 'Procurement item specification defining the exact quality, safety, and technical requirements for a purchased food ingredient, packaging material, or equipment item. Captures item code, item description, category, unit of measure, quality grade, allergen declarations, country of origin requirements, shelf life requirements, temperature requirements, and approved substitute items. Links procurement to menu BOM and food safety requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` (
    `vendor_rebate_id` BIGINT COMMENT 'Unique identifier for the vendor_rebate data product (auto-inserted pre-linking).',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Vendor rebates are always tied to a supplier; the FK enables proper reporting and eliminates orphan rebate records.',
    `superseded_vendor_rebate_id` BIGINT COMMENT 'Self-referencing FK on vendor_rebate (superseded_vendor_rebate_id)',
    CONSTRAINT pk_vendor_rebate PRIMARY KEY(`vendor_rebate_id`)
) COMMENT 'Tracks volume rebates, marketing development funds (MDF), promotional allowances, and deviated pricing agreements with suppliers. Captures rebate type (volume tier, growth incentive, marketing allowance, new item introduction), calculation basis (percentage of spend, fixed amount per case, tiered brackets), accrual period, qualifying spend threshold, earned amount, claimed amount, settlement status, and payment method (credit memo, check, offset against AP). Critical for foodservice P&L management where vendor rebates can represent 2-5% of total food cost and directly impact COGS% and operator profitability.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` (
    `supplier_category_contract_id` BIGINT COMMENT 'Primary key for the SupplierCategoryContract association',
    `category_id` BIGINT COMMENT 'Foreign key linking to the procurement category master',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier master',
    `contract_end_date` DATE COMMENT 'Date the supplier-category contract expires',
    `contract_start_date` DATE COMMENT 'Date the supplier-category contract becomes effective',
    `payment_terms` STRING COMMENT 'Payment terms specific to this supplier-category agreement',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates if the supplier is marked as preferred for this category',
    `vendor_rating` STRING COMMENT 'Rating assigned to the supplier for this category',
    CONSTRAINT pk_supplier_category_contract PRIMARY KEY(`supplier_category_contract_id`)
) COMMENT 'Represents the contractual approval linking a supplier to a procurement category, capturing the period of validity, vendor rating, payment terms, and preferred‑supplier flag. Each record links one supplier to one procurement category and stores data that belongs to the relationship itself.. Existence Justification: Suppliers are approved to provide goods or services for multiple procurement categories, and each procurement category can have many approved suppliers. The approval is managed as a contract that includes start/end dates, vendor rating, payment terms, and a preferred‑supplier flag. Because the business actively creates, updates, and deletes these contracts, the relationship is a true many‑to‑many with its own attributes.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the SupplyAgreement association',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to the ingredient',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier',
    `currency_code` STRING COMMENT 'Currency of the agreed price',
    `price_amount` DECIMAL(18,2) COMMENT 'Unit price agreed for the ingredient from this supplier',
    `price_tier_max_qty` STRING COMMENT 'Maximum quantity for this price tier',
    `price_tier_min_qty` STRING COMMENT 'Minimum quantity for this price tier',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'Represents the contractual relationship between a supplier and an ingredient. Each record captures the price, quantity tiers, and currency that apply to that specific supplier‑ingredient pairing.. Existence Justification: Suppliers provide many ingredients and each ingredient can be sourced from multiple suppliers. The business tracks pricing tiers, minimum/maximum order quantities, and currency per supplier‑ingredient pair, which are managed as a contract-like agreement. This relationship is actively created, updated, and deleted by procurement teams.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` (
    `procurement_item_id` BIGINT COMMENT '',
    `order_item_id` BIGINT COMMENT '',
    `parent_product_id` BIGINT COMMENT 'Self-referencing FK on product (parent_product_id)',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the primary supplier for this product.',
    `allergen_info` STRING COMMENT 'Allergens present in the product, listed as a comma‑separated string.',
    `brand` STRING COMMENT 'Manufacturer or brand associated with the product.',
    `procurement_item_category` STRING COMMENT 'High‑level classification of the product (e.g., food, packaging, equipment, service).',
    `cost_price` DECIMAL(18,2) COMMENT 'Internal cost incurred to acquire or produce the product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price.',
    `procurement_item_description` STRING COMMENT 'Detailed textual description of the product.',
    `discontinued_date` DATE COMMENT 'Date on which the product was officially discontinued.',
    `effective_from` DATE COMMENT 'Date when the product becomes available for procurement.',
    `effective_until` DATE COMMENT 'Date when the product is retired or no longer purchasable (null if open‑ended).',
    `expiration_date` DATE COMMENT 'Date after which the product should not be used or sold.',
    `hazardous_material` BOOLEAN COMMENT 'Flag indicating whether the product is classified as hazardous.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the product packaging.',
    `is_perishable` BOOLEAN COMMENT 'Flag indicating whether the product has a limited shelf life.',
    `lead_time_days` STRING COMMENT 'Average number of days from order to receipt.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the product packaging.',
    `lifecycle_stage` STRING COMMENT 'Strategic stage of the product within its overall lifecycle.',
    `procurement_item_name` STRING COMMENT 'Human‑readable name of the product.',
    `nutritional_info` STRING COMMENT 'Key nutrition facts (calories, fat, protein, etc.) stored as a structured string.',
    `packaging_type` STRING COMMENT 'Description of the packaging (e.g., box, pallet, bulk).',
    `price` DECIMAL(18,2) COMMENT 'Current list price charged to internal buyers (before discounts).',
    `product_line` STRING COMMENT 'Higher‑level grouping of related products.',
    `reorder_point_quantity` STRING COMMENT 'Inventory level that triggers a new purchase requisition.',
    `safety_stock_quantity` STRING COMMENT 'Minimum inventory level maintained to avoid stockouts.',
    `sku` STRING COMMENT 'Internal code used to track the product in inventory and ordering systems.',
    `procurement_item_status` STRING COMMENT 'Current lifecycle state of the product.',
    `subcategory` STRING COMMENT 'More detailed classification within the main category.',
    `tax_code` STRING COMMENT 'Tax classification code applied to the product for sales tax calculations.',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for quantity ordering.',
    `upc` STRING COMMENT '12‑digit barcode identifier for the product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the product record.',
    `volume_liters` DECIMAL(18,2) COMMENT 'Physical volume of a single unit of the product.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of a single unit of the product.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the product packaging.',
    CONSTRAINT pk_procurement_item PRIMARY KEY(`procurement_item_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'System-generated unique identifier for the supplier record.',
    `parent_supplier_procurement_supplier_id` BIGINT COMMENT 'Identifier of the parent organization if the supplier is a subsidiary.',
    `address_line` STRING COMMENT 'First line of the suppliers mailing address.',
    `average_lead_time_days` STRING COMMENT 'Average number of days between purchase order issuance and receipt.',
    `bank_account_number` STRING COMMENT 'Suppliers bank account number for electronic payments.',
    `bank_routing_number` STRING COMMENT 'Routing number (or equivalent) for the suppliers bank.',
    `city` STRING COMMENT 'City component of the suppliers mailing address.',
    `classification` STRING COMMENT 'Diversity status of the supplier (e.g., Minority‑Owned Business).. Valid values are `mbe|wbe|sbe|veteran|minority|none`',
    `compliance_status` STRING COMMENT 'Current compliance standing of the supplier with regulatory and internal standards.. Valid values are `compliant|non_compliant|under_review`',
    `contract_end_date` DATE COMMENT 'Scheduled termination date of the supplier contract (null if open‑ended).',
    `contract_number` STRING COMMENT 'Unique identifier of the active contract with the supplier.',
    `contract_start_date` DATE COMMENT 'Effective start date of the supplier contract.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the supplier is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for transactions with the supplier.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `default_tax_rate` DECIMAL(18,2) COMMENT 'Standard tax percentage applied to purchases from this supplier.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Default discount percentage applied to purchases from this supplier.',
    `email_address` STRING COMMENT 'General email address for the supplier organization.',
    `global_supplier_number` STRING COMMENT 'External identifier used across multiple enterprise systems to reference the supplier.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the suppliers liability or general insurance coverage.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit performed on the supplier.',
    `legal_name` STRING COMMENT 'Full legal entity name of the supplier as registered with government authorities.',
    `liability_limit` DECIMAL(18,2) COMMENT 'Maximum liability coverage amount provided by the suppliers insurance.',
    `max_order_quantity` STRING COMMENT 'Maximum quantity that can be ordered from the supplier per transaction.',
    `min_order_quantity` STRING COMMENT 'Minimum quantity that can be ordered from the supplier per transaction.',
    `onboarding_status` STRING COMMENT 'Progress of the supplier through the onboarding workflow.. Valid values are `pending|completed|rejected`',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the supplier.. Valid values are `net30|net45|net60|prepay|cod`',
    `phone_number` STRING COMMENT 'General telephone number for the supplier organization.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the suppliers mailing address.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether the supplier is marked as a preferred vendor.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary supplier contact.',
    `primary_contact_name` STRING COMMENT 'Name of the main point‑of‑contact for the supplier.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary supplier contact.',
    `procurement_supplier_name` STRING COMMENT 'Primary display name of the supplier used in reports and UI.',
    `procurement_supplier_status` STRING COMMENT 'Current operational status of the supplier record.. Valid values are `active|inactive|suspended|pending`',
    `remittance_address` STRING COMMENT 'Address to which payment remittances should be sent.',
    `risk_tier` STRING COMMENT 'Risk assessment tier based on financial, compliance, and operational factors.. Valid values are `low|medium|high|critical`',
    `spend_ytd` DECIMAL(18,2) COMMENT 'Total spend with the supplier for the current fiscal year.',
    `state` STRING COMMENT 'State or province component of the suppliers mailing address.',
    `supplier_type` STRING COMMENT 'Broad category describing the primary goods or services supplied.. Valid values are `food|packaging|equipment|services|technology|other`',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier (e.g., EIN) for the supplier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the supplier record.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for every approved and prospective supplier/vendor managed in Coupa Procurement and synchronized to SAP S/4HANA vendor master. Captures supplier identity, legal entity details, tax IDs (EIN/TIN), diversity classifications (MBE/WBE/SBE/LGBTBE), payment terms, remittance addresses, risk tier, onboarding status, preferred supplier flags, and contact details (account managers, sales reps, quality liaisons). SSOT for commercial supplier identity in procurement — distinct from supply domain which tracks physical shipment performance. Covers food, packaging, equipment, and services categories.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order record.',
    `contract_id` BIGINT COMMENT 'Reference to a master contract governing the purchase order, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REQUIRED: Purchase orders are charged to cost centers; linking enables accurate financial reporting and spend analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for PO creation audit report that tracks which employee created each purchase order for accountability.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: POs must specify the receiving stock location to schedule receiving, temperature control, and HACCP monitoring.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Needed for PO Accountability Dashboard: purchase orders are issued by individual franchisees; FK supports audit of spend by franchisee.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier (vendor) to whom the purchase order is issued.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant, distribution center, or commissary where the goods are to be delivered.',
    `purchase_unit_id` BIGINT COMMENT 'Identifier of the restaurant, distribution center, or commissary where the goods are to be delivered.',
    `actual_delivery_date` DATE COMMENT 'Date the goods were actually received at the delivery location.',
    `approval_status` STRING COMMENT 'Result of the internal approval workflow for the purchase order.. Valid values are `approved|rejected|pending`',
    `approved_by` BIGINT COMMENT 'Identifier of the system user who approved the purchase order.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order received final approval.',
    `category_code` STRING COMMENT 'Internal classification of the purchase order line items (e.g., FOOD, PACKAGING, EQUIPMENT).',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the purchase order complies with food safety and regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the purchase order.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Physical address of the delivery location for the purchase order.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the purchase order.',
    `external_reference_number` STRING COMMENT 'Vendor‑provided reference number for the purchase order.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Cost of transportation and shipping associated with the purchase order.',
    `internal_comments` STRING COMMENT 'Internal remarks visible only to authorized personnel.',
    `is_consolidated` BOOLEAN COMMENT 'True if the purchase order aggregates multiple requisitions or suppliers.',
    `is_urgent` BOOLEAN COMMENT 'Indicates whether the purchase order requires expedited processing.',
    `last_received_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent goods receipt against this purchase order.',
    `line_item_count` STRING COMMENT 'Number of distinct line items included on the purchase order.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after taxes, discounts, and freight are applied.',
    `notes` STRING COMMENT 'Free‑form text field for additional information or special instructions.',
    `order_date` DATE COMMENT 'Date the purchase order was created and issued to the supplier.',
    `payment_due_date` DATE COMMENT 'Date by which payment for the purchase order must be received.',
    `payment_terms` STRING COMMENT 'Contractual payment condition (e.g., Net30, Net45).',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order.. Valid values are `open|partially_received|closed|cancelled|pending_approval|rejected`',
    `po_type` STRING COMMENT 'Classification of the purchase order based on its contractual nature.. Valid values are `standard|blanket|contract|planned|spot`',
    `priority` STRING COMMENT 'Business priority assigned to the purchase order for processing and fulfillment.. Valid values are `high|medium|low`',
    `promised_delivery_date` DATE COMMENT 'Date the supplier has committed to deliver the goods.',
    `purchase_order_number` STRING COMMENT 'External business identifier assigned to the purchase order, used in vendor communications and reporting.',
    `receipt_status` STRING COMMENT 'Current status of goods receipt for the purchase order.. Valid values are `not_received|partial|complete`',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory approvals (e.g., FDA, USDA) for the ordered items.. Valid values are `compliant|non_compliant|pending`',
    `requested_delivery_date` DATE COMMENT 'Date the purchasing organization requests the goods to be delivered.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the purchase order.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the purchase order.',
    `total_amount_gross` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order before taxes, discounts, and freight.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items on the purchase order, expressed in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the purchase order record.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal purchase order (PO) issued to a supplier following requisition approval, generated in Coupa Procurement and transmitted via EDI/cXML to suppliers. Captures PO number, supplier, delivery location (restaurant, DC, or commissary), ordered items, quantities, agreed unit prices, requested delivery date, payment terms, freight terms, and PO status (open/partially received/closed/cancelled). SSOT for commercial purchase commitments — distinct from the supply domains goods receipt and physical movement tracking. Supports auto-PO generation from PAR-level triggers and blanket PO release scheduling.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ADD CONSTRAINT `fk_procurement_sourcing_response_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ADD CONSTRAINT `fk_procurement_sourcing_response_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_primary_po_header_procurement_purchase_order_id` FOREIGN KEY (`primary_po_header_procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_item_id` FOREIGN KEY (`procurement_item_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_item`(`procurement_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ADD CONSTRAINT `fk_procurement_supplier_risk_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier_certification` ADD CONSTRAINT `fk_procurement_procurement_supplier_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ADD CONSTRAINT `fk_procurement_item_specification_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ADD CONSTRAINT `fk_procurement_vendor_rebate_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ADD CONSTRAINT `fk_procurement_vendor_rebate_superseded_vendor_rebate_id` FOREIGN KEY (`superseded_vendor_rebate_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`vendor_rebate`(`vendor_rebate_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ADD CONSTRAINT `fk_procurement_supplier_category_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ADD CONSTRAINT `fk_procurement_supplier_category_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ADD CONSTRAINT `fk_procurement_procurement_item_parent_product_id` FOREIGN KEY (`parent_product_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_item`(`procurement_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ADD CONSTRAINT `fk_procurement_procurement_item_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ADD CONSTRAINT `fk_procurement_supplier_parent_supplier_procurement_supplier_id` FOREIGN KEY (`parent_supplier_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Status (APPROVED_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|suspended');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement (AUDIT_REQUIREMENT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (BANK_ACCOUNT_NUMBER)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope (CATEGORY_SCOPE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `category_scope` SET TAGS ('dbx_value_regex' = 'food|packaging|equipment|services|beverage|technology');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_documents` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documents (COMPLIANCE_DOCUMENTS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (CONTRACT_END_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (CONTRACT_START_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms Summary (CONTRACT_TERMS_SUMMARY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Date (DISQUALIFICATION_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason (DISQUALIFICATION_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope (GEOGRAPHIC_SCOPE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|global');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `insurance_certificate_expiry` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry (INSURANCE_CERTIFICATE_EXPIRY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `is_currently_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Currently Approved (IS_CURRENTLY_APPROVED)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAST_AUDIT_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result (LAST_AUDIT_RESULT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LAST_MODIFIED_BY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag (PREFERRED_VENDOR_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (PRIMARY_CONTACT_EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (PRIMARY_CONTACT_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (PRIMARY_CONTACT_PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TAX_ID_NUMBER)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_category_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Code (VENDOR_CATEGORY_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (VENDOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rating (VENDOR_RATING)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type (VENDOR_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'manufacturer|distributor|service_provider|raw_material_supplier|packaging_supplier|technology_supplier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for procurement_category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Award Supplier Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_decision` SET TAGS ('dbx_business_glossary_term' = 'Award Decision');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_decision` SET TAGS ('dbx_value_regex' = 'awarded|not_awarded|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `category_scope` SET TAGS ('dbx_value_regex' = 'food|packaging|equipment|services');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_description` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rfi|rfp|rfq|reverse_auction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|cancelled|completed');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `weighting_scheme` SET TAGS ('dbx_business_glossary_term' = 'Weighting Scheme');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_response_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Response ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status (AWARD_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'awarded|not_awarded');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type (BID_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'RFI|RFP|RFQ');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `compliance_attestations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestations (COMP_ATTEST)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (COMP_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (TERM_MONTHS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (DELIVERY_TERMS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason (DISQ_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag (ELIGIBLE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `is_preferred_supplier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag (PREF_SUPP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (LEAD_TIME_DAYS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price (NET_PRICE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit (UNIT_PRICE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `quality_certifications` SET TAGS ('dbx_business_glossary_term' = 'Quality Certifications (QUAL_CERTS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `response_comments` SET TAGS ('dbx_business_glossary_term' = 'Response Comments (RESP_COMMENTS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number (RESP_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `scoring_rank` SET TAGS ('dbx_business_glossary_term' = 'Scoring Rank (SCORE_RANK)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `scoring_total` SET TAGS ('dbx_business_glossary_term' = 'Total Scoring (SCORE_TOTAL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status (RESP_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_response_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|awarded|rejected|disqualified');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `supplier_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Rating (SUPP_RATING)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price (TOTAL_PRICE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (WARRANTY_MONTHS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_service_agreement|master_purchase_agreement|framework_agreement|blanket_purchase_order|license_agreement|service_level_agreement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|FTC|ISO22000');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `manager_contact` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Contact');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `manager_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `manager_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt|custom');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed|variable|tiered|cost_plus|subscription');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `rebate_terms` SET TAGS ('dbx_business_glossary_term' = 'Rebate Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `scope_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Scope of Supply');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `sla_commitment` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Commitment');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_type` SET TAGS ('dbx_value_regex' = 'goods|service|packaging|equipment');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Locked Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Frequency');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|none');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_tier_end_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier End Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_tier_start_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `tier_price` SET TAGS ('dbx_business_glossary_term' = 'Tier Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Unit Price (USD)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|case|liter|gallon');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `waste_percentage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Employee Identifier (APPROVER_EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By Employee Identifier (CREATED_BY_EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (DEPT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Employee Identifier (REQ_BY_EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_renamed_from' = 'employee_id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Employee Identifier (APPROVER_EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Employee Identifier (REQ_BY_EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code (BUDGET_CD)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag (COMPLIANCE_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMPLIANCE_NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CD)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method (DELIVERY_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'delivery|pickup|none');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `discount_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Discount Amount (EST_DISC_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date (EXP_DELIVERY_DT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `justification_text` SET TAGS ('dbx_business_glossary_term' = 'Business Justification Text (JUSTIFICATION_TXT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Line Items (LINE_ITEM_CNT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `net_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Estimated Amount (EST_NET_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIORITY_LVL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method (PROC_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'internal|external|spot|contract');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date (REQ_BY_DT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number (REQ_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status (REQ_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `spend_category_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Code (SPEND_CAT_CD)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `supplier_preference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Preference (SUPPLIER_PREF)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `supplier_preference` SET TAGS ('dbx_value_regex' = 'preferred|any|none');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tax_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount (EST_TAX_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason (TAX_EXEMPT_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `total_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Amount (EST_TOTAL_AMT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag (URGENT_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line ID (PO_LINE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID (BUDGET_LINE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line ID (CONTRACT_LINE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Header ID (PO_HEADER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `primary_po_header_procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Header ID (PO_HEADER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUPPLIER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID (PRODUCT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACTUAL_DELIVERY_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status (DELIVERY_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|shipped|delivered|failed');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMOUNT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date (EXPECTED_DELIVERY_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount (EXTENDED_AMOUNT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Timestamp (INVOICE_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity (INVOICED_QUANTITY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `is_late` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Flag (IS_LATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `is_three_way_match` SET TAGS ('dbx_business_glossary_term' = 'Three‑Way Match Flag (IS_THREE_WAY_MATCH)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description (ITEM_DESCRIPTION)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `item_sku` SET TAGS ('dbx_business_glossary_term' = 'Item SKU (ITEM_SKU)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (LEAD_TIME_DAYS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LINE_NUMBER)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status (LINE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|received|invoiced|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type (LINE_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'goods|service|fee');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMOUNT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity (ORDERED_QUANTITY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp (RECEIPT_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity (RECEIVED_QUANTITY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMOUNT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UNIT_PRICE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (WASTE_PERCENTAGE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tax Identification Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `attached_document_url` SET TAGS ('dbx_business_glossary_term' = 'Attached Document URL');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cogs_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `early_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `external_comments` SET TAGS ('dbx_business_glossary_term' = 'External Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'goods|services|mixed');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|digital_wallet');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid|failed|refunded');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|due_on_receipt');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|approved|paid|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'Value‑Added Tax (VAT) Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `cost_savings_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluator_department` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Department');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate (%)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate (%)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate (%)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score (0-100)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `quality_rejection_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Rate (%)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Supplier Region');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_version` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Version');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_category` SET TAGS ('dbx_value_regex' = 'ingredient|packaging|equipment|service');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived|pending');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Record ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `compliance_fda_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `compliance_osha_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `dependency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Dependency Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `financial_stability_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'financial|geographic|single_source|food_safety|geopolitical');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_factor_details` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Details');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|closed|monitoring');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `single_source_dependency` SET TAGS ('dbx_business_glossary_term' = 'Single‑Source Dependency Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Financial Rating');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Supplier Primary Contact');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier_certification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier_certification` ALTER COLUMN `procurement_supplier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for procurement_supplier_certification');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Item Specification ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration (ALLERGEN_DECL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `approved_substitutes` SET TAGS ('dbx_business_glossary_term' = 'Approved Substitutes (SUBSTITUTES)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|not_certified');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_code` SET TAGS ('dbx_business_glossary_term' = 'Item Specification Code (CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `compliance_fda_required` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Required (FDA_COMPL_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `compliance_usda_required` SET TAGS ('dbx_business_glossary_term' = 'USDA Compliance Required (USDA_COMPL_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit (COST_PER_UNIT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `dietary_restriction` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction (DIET_RESTR)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `dietary_restriction` SET TAGS ('dbx_value_regex' = 'vegan|vegetarian|gluten_free|nut_free|halal|kosher');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HAZARD_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag (PERISHABLE_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LAST_INSP_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (DAYS) (LEAD_TIME)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material (MATERIAL)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAX_ORDER_QTY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MIN_ORDER_QTY)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_name` SET TAGS ('dbx_business_glossary_term' = 'Item Specification Name (NAME)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type (PKG_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'box|bag|bottle|can|pallet|crate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade (GRADE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `quantity_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity per Unit (QTY_PER_UNIT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (DAYS) (SHELF_LIFE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (STORAGE_TEMP)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `supplier_requirements` SET TAGS ('dbx_business_glossary_term' = 'Supplier Requirements (SUPP_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required (TEMP_CTRL_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range (°C) (TEMP_RANGE)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `traceability_required` SET TAGS ('dbx_business_glossary_term' = 'Traceability Required (TRACE_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|oz|liter|ml');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume (liters) (VOLUME_L)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (WASTE_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg) (WEIGHT_KG)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `vendor_rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for vendor_rebate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `superseded_vendor_rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Vendor Rebate Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `superseded_vendor_rebate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_association_edges' = 'procurement.supplier,procurement.procurement_category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `supplier_category_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Suppliercategorycontract - Supplier Category Contract Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Suppliercategorycontract - Procurement Category Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Suppliercategorycontract - Supplier Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `vendor_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rating');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,supply.ingredient');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supply Agreement Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Ingredient Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supplier Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `price_tier_max_qty` SET TAGS ('dbx_business_glossary_term' = 'Tier Maximum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `price_tier_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Tier Minimum Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `order_item_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `parent_product_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `parent_product_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Info');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `procurement_item_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `procurement_item_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `discontinued_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height Cm');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length Cm');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `procurement_item_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `nutritional_info` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Info');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Sku');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `procurement_item_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Upc');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume Liters');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_item` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width Cm');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `parent_supplier_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Supplier Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_business_glossary_term' = 'Supplier Street Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Supplier City');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Classification');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'mbe|wbe|sbe|veteran|minority|none');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Supplier Country Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `default_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Discount Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Supplier Email Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `global_supplier_number` SET TAGS ('dbx_business_glossary_term' = 'Global Supplier Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Limit');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepay|cod');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `procurement_supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `procurement_supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `procurement_supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `remittance_address` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `remittance_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `remittance_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Tier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `spend_ytd` SET TAGS ('dbx_business_glossary_term' = 'Year‑to‑Date Spend');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Supplier State/Province');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'food|packaging|equipment|services|technology|other');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Urgent Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|closed|cancelled|pending_approval|rejected');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|planned|spot');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partial|complete');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
