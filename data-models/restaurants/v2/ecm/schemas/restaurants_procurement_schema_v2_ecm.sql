-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`procurement` COMMENT 'Owns sourcing events, supplier contracts, spend analytics, purchase requisition-to-order workflows, approved vendor lists, contract compliance, and category management for food, packaging, equipment, and services via Coupa Procurement. Distinct from supply domain which tracks physical inventory movement — procurement owns the commercial supplier relationship and contractual terms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` (
    `procurement_supplier_id` BIGINT COMMENT 'Primary key for the procurement supplier record.',
    `parent_supplier_procurement_supplier_id` BIGINT COMMENT 'Self-referencing FK to parent supplier for hierarchical supplier structures.',
    `address_line` STRING COMMENT 'Primary street address of the supplier.',
    `average_lead_time_days` STRING COMMENT 'Average number of days from order to delivery.',
    `bank_account_number` STRING COMMENT 'Supplier bank account number for payments.',
    `bank_routing_number` STRING COMMENT 'Bank routing number for electronic payments.',
    `city` STRING COMMENT 'City of the supplier address.',
    `classification` STRING COMMENT 'Supplier classification such as strategic, preferred, transactional.',
    `compliance_status` STRING COMMENT 'Current compliance status of the supplier.',
    `contract_end_date` DATE COMMENT 'End date of the primary contract with this supplier.',
    `contract_number` STRING COMMENT 'Reference number of the governing contract.',
    `contract_start_date` DATE COMMENT 'Start date of the primary contract with this supplier.',
    `country` STRING COMMENT 'Country of the supplier address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was created.',
    `currency_code` STRING COMMENT 'Default transaction currency for this supplier.',
    `default_tax_rate` DECIMAL(18,2) COMMENT 'Default tax rate applied to supplier invoices.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Standard discount rate negotiated with the supplier.',
    `email_address` STRING COMMENT 'Primary email address for the supplier.',
    `global_supplier_number` STRING COMMENT 'Global unique identifier for the supplier across systems.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the supplier liability insurance.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit.',
    `legal_name` STRING COMMENT 'Registered legal name of the supplier entity.',
    `liability_limit` DECIMAL(18,2) COMMENT 'Maximum liability limit per the supplier contract.',
    `max_order_quantity` STRING COMMENT 'Maximum order quantity per purchase order.',
    `min_order_quantity` STRING COMMENT 'Minimum order quantity per purchase order.',
    `procurement_supplier_name` STRING COMMENT 'Common/trade name of the supplier.',
    `onboarding_status` STRING COMMENT 'Current status in the supplier onboarding process.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms in net days for the supplier.',
    `phone_number` STRING COMMENT 'Primary phone number for the supplier.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the supplier address.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates if this is a preferred supplier.',
    `primary_contact_email` STRING COMMENT 'Email of the primary contact person at the supplier.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the supplier.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `procurement_supplier_status` STRING COMMENT 'Active/inactive/suspended status of the supplier.',
    `remittance_address` STRING COMMENT 'Address where payments should be sent.',
    `risk_tier` STRING COMMENT 'Risk classification tier for the supplier.',
    `spend_ytd` DECIMAL(18,2) COMMENT 'Year-to-date spend with this supplier.',
    `state` STRING COMMENT 'State/province of the supplier address.',
    `supplier_type` STRING COMMENT 'Type of supplier such as manufacturer, distributor, broker.',
    `tax_identifier` DECIMAL(18,2) COMMENT 'Tax identification number of the supplier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was last updated.',
    CONSTRAINT pk_procurement_supplier PRIMARY KEY(`procurement_supplier_id`)
) COMMENT 'Master record for suppliers used in procurement, containing contact, financial, compliance, and contract details.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Primary key for the approved vendor list entry.',
    `employee_id` BIGINT COMMENT 'Employee who approved the vendor.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to the procurement supplier.',
    `approval_date` DATE COMMENT 'Date the vendor was approved.',
    `approved_status` STRING COMMENT 'Current approval status.',
    `audit_requirement` STRING COMMENT 'Audit requirements for this vendor.',
    `bank_account_number` STRING COMMENT 'Vendor bank account number.',
    `category_scope` STRING COMMENT 'Categories the vendor is approved to supply.',
    `compliance_documents` STRING COMMENT 'List of compliance documents on file.',
    `compliance_status` STRING COMMENT 'Current compliance status of the vendor.',
    `contract_end_date` DATE COMMENT 'End date of the vendor contract.',
    `contract_start_date` DATE COMMENT 'Start date of the vendor contract.',
    `contract_terms_summary` STRING COMMENT 'Summary of key contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `disqualification_date` DATE COMMENT 'Date the vendor was disqualified if applicable.',
    `disqualification_reason` STRING COMMENT 'Reason for vendor disqualification.',
    `expiry_date` DATE COMMENT 'Date the approval expires.',
    `geographic_scope` STRING COMMENT 'Geographic regions the vendor is approved for.',
    `insurance_certificate_expiry` DATE COMMENT 'Expiry date of the vendor insurance certificate.',
    `is_currently_approved` BOOLEAN COMMENT 'Whether the vendor is currently approved.',
    `last_audit_date` DATE COMMENT 'Date of the last vendor audit.',
    `last_audit_result` STRING COMMENT 'Result of the last vendor audit.',
    `last_modified_by` STRING COMMENT 'User who last modified the record.',
    `notes` STRING COMMENT 'Free-text notes about the vendor approval.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms in net days.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates if this is a preferred vendor.',
    `primary_contact_email` STRING COMMENT 'Email of the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact.',
    `primary_contact_phone` STRING COMMENT 'Phone of the primary contact.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score for the vendor.',
    `tax_id_number` DECIMAL(18,2) COMMENT 'Tax identification number of the vendor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vendor_category_code` STRING COMMENT 'Category code assigned to the vendor.',
    `vendor_identifier` STRING COMMENT 'Unique vendor identifier code.',
    `vendor_rating` DECIMAL(18,2) COMMENT 'Overall vendor performance rating.',
    `vendor_type` STRING COMMENT 'Type classification of the vendor.',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Approved vendor list entries tracking which suppliers are authorized to provide goods/services.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`category` (
    `category_id` BIGINT COMMENT 'Primary key for the procurement category.',
    `parent_category_id` BIGINT COMMENT 'Self-referencing FK for category hierarchy.',
    `active_flag` BOOLEAN COMMENT 'Flag indicating active status.',
    `annual_spend` DECIMAL(18,2) COMMENT 'Total annual spend in this category.',
    `category_description` STRING COMMENT 'Detailed description of the category.',
    `category_type` STRING COMMENT 'Type classification (direct, indirect, services).',
    `category_code` STRING COMMENT 'Unique code for the category.',
    `commodity_group` STRING COMMENT 'Commodity group this category belongs to.',
    `created_at` TIMESTAMP COMMENT 'Alternative creation timestamp.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency` STRING COMMENT 'Currency for spend amounts.',
    `effective_from` DATE COMMENT 'Date the category becomes effective.',
    `effective_until` DATE COMMENT 'Date the category expires.',
    `is_active` BOOLEAN COMMENT 'Whether the category is currently active.',
    `is_strategic` DECIMAL(18,2) COMMENT 'Whether this is a strategic category.',
    `category_level` STRING COMMENT 'Hierarchy level of the category.',
    `manager_name` STRING COMMENT 'Name of the category manager responsible.',
    `category_name` STRING COMMENT 'Name of the procurement category.',
    `parent_category` STRING COMMENT 'Name of the parent category.',
    `sourcing_strategy` DECIMAL(18,2) COMMENT 'Sourcing strategy for this category.',
    `spend_category` STRING COMMENT 'Spend classification for reporting.',
    `spend_classification` STRING COMMENT 'Classification of spend type.',
    `spend_owner` STRING COMMENT 'Owner responsible for spend in this category.',
    `spend_ytd` DECIMAL(18,2) COMMENT 'Year-to-date spend in this category.',
    `unspsc_code` STRING COMMENT 'United Nations Standard Products and Services Code.',
    `updated_at` TIMESTAMP COMMENT 'Alternative update timestamp.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Procurement spend categories used to classify and manage sourcing activities and supplier relationships.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Primary key for the sourcing event.',
    `procurement_supplier_id` BIGINT COMMENT 'Awarded supplier if applicable.',
    `employee_id` BIGINT COMMENT 'Employee who created the sourcing event.',
    `sourcing_stakeholder_employee_id` BIGINT COMMENT 'Key stakeholder for the sourcing event.',
    `award_amount` DECIMAL(18,2) COMMENT 'Total awarded amount.',
    `award_date` TIMESTAMP COMMENT 'Date the award was made.',
    `award_decision` STRING COMMENT 'Decision outcome of the sourcing event.',
    `category_scope` STRING COMMENT 'Categories covered by this sourcing event.',
    `compliance_requirements` STRING COMMENT 'Compliance requirements for participants.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency for the sourcing event.',
    `sourcing_event_description` STRING COMMENT 'Detailed description of the sourcing event.',
    `evaluation_criteria` STRING COMMENT 'Criteria used to evaluate responses.',
    `event_code` STRING COMMENT 'Unique code for the sourcing event.',
    `event_end_timestamp` TIMESTAMP COMMENT 'When the sourcing event closes.',
    `event_name` STRING COMMENT 'Name of the sourcing event.',
    `event_notes` STRING COMMENT 'Additional notes about the event.',
    `event_start_timestamp` TIMESTAMP COMMENT 'When the sourcing event opens.',
    `event_type` STRING COMMENT 'Type of sourcing event (RFP, RFQ, auction).',
    `is_confidential` BOOLEAN COMMENT 'Whether the event is confidential.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the event.',
    `submission_deadline` TIMESTAMP COMMENT 'Deadline for response submissions.',
    `total_budget` DECIMAL(18,2) COMMENT 'Total budget allocated for this sourcing.',
    `updated_by` STRING COMMENT 'User who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `weighting_scheme` DECIMAL(18,2) COMMENT 'Scoring weight scheme used for evaluation.',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Sourcing events such as RFPs, RFQs, and reverse auctions used to competitively select suppliers.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` (
    `sourcing_response_id` BIGINT COMMENT 'Primary key for the sourcing response.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier who submitted the response.',
    `sourcing_event_id` BIGINT COMMENT 'Sourcing event this response is for.',
    `award_status` STRING COMMENT 'Whether this response was awarded.',
    `bid_type` STRING COMMENT 'Type of bid submitted.',
    `compliance_attestations` STRING COMMENT 'Compliance attestations provided.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Score for compliance criteria.',
    `contract_term_months` STRING COMMENT 'Proposed contract term in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency of the bid.',
    `delivery_terms` STRING COMMENT 'Proposed delivery terms.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount offered.',
    `disqualification_reason` STRING COMMENT 'Reason if response was disqualified.',
    `is_eligible` BOOLEAN COMMENT 'Whether the response meets eligibility criteria.',
    `is_preferred_supplier` BOOLEAN COMMENT 'Whether the respondent is a preferred supplier.',
    `lead_time_days` STRING COMMENT 'Proposed lead time in days.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity proposed.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price after discounts.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Proposed payment terms.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price proposed.',
    `quality_certifications` STRING COMMENT 'Quality certifications held by supplier.',
    `response_comments` STRING COMMENT 'Additional comments from supplier.',
    `response_number` STRING COMMENT 'Unique response reference number.',
    `risk_level` STRING COMMENT 'Assessed risk level of the response.',
    `scoring_rank` STRING COMMENT 'Rank among all responses.',
    `scoring_total` DECIMAL(18,2) COMMENT 'Total evaluation score.',
    `sourcing_response_status` STRING COMMENT 'Current status of the response.',
    `submission_timestamp` TIMESTAMP COMMENT 'When the response was submitted.',
    `supplier_rating` DECIMAL(18,2) COMMENT 'Historical supplier rating.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount in the bid.',
    `total_price` DECIMAL(18,2) COMMENT 'Total bid price.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for pricing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `valid_until` DATE COMMENT 'Date until which the bid is valid.',
    `warranty_period_months` STRING COMMENT 'Warranty period offered in months.',
    CONSTRAINT pk_sourcing_response PRIMARY KEY(`sourcing_response_id`)
) COMMENT 'Supplier responses/bids submitted to sourcing events including pricing, terms, and evaluation scores.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for the procurement contract.',
    `employee_id` BIGINT COMMENT 'Employee managing the contract.',
    `franchisee_id` BIGINT COMMENT 'Franchisee associated with the contract.',
    `owner_employee_id` BIGINT COMMENT 'Contract owner employee.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier party to the contract.',
    `unit_id` BIGINT COMMENT 'Restaurant unit associated with the contract.',
    `amendment_count` STRING COMMENT 'Number of amendments to the contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Whether the contract auto-renews.',
    `compliance_requirements` STRING COMMENT 'Compliance requirements in the contract.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification.',
    `contract_number` STRING COMMENT 'Unique contract reference number.',
    `contract_status` STRING COMMENT 'Current status of the contract.',
    `contract_type` STRING COMMENT 'Type of contract (blanket, spot, framework).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Contract currency.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Negotiated discount rate.',
    `document_url` STRING COMMENT 'URL to the contract document.',
    `effective_end_date` DATE COMMENT 'Contract end date.',
    `effective_start_date` DATE COMMENT 'Contract start date.',
    `exclusivity_flag` BOOLEAN COMMENT 'Whether the contract is exclusive.',
    `governing_body` STRING COMMENT 'Legal governing body/jurisdiction.',
    `last_review_date` DATE COMMENT 'Date of last contract review.',
    `manager_contact` STRING COMMENT 'Contact information for the contract manager.',
    `contract_name` STRING COMMENT 'Name of the contract.',
    `next_renewal_date` DATE COMMENT 'Next renewal date.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms in net days.',
    `penalty_clause` STRING COMMENT 'Penalty clause details.',
    `pricing_model` STRING COMMENT 'Pricing model (fixed, variable, tiered).',
    `rebate_terms` DECIMAL(18,2) COMMENT 'Rebate terms value.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval.',
    `renewal_term_months` STRING COMMENT 'Renewal term length in months.',
    `scope_of_supply` STRING COMMENT 'Scope of goods/services covered.',
    `sla_commitment` STRING COMMENT 'Service level agreement commitments.',
    `termination_date` DATE COMMENT 'Date the contract was terminated.',
    `termination_reason` STRING COMMENT 'Reason for contract termination.',
    `total_value` DECIMAL(18,2) COMMENT 'Total contract value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `version_number` STRING COMMENT 'Contract version number.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Procurement contracts governing supplier relationships, pricing, terms, and compliance requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Primary key for the contract line.',
    `employee_id` BIGINT COMMENT 'Employee who approved the line.',
    `contract_id` BIGINT COMMENT 'Parent contract.',
    `cost_center_id` BIGINT COMMENT 'Cost center for the line.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier for this line.',
    `stock_item_id` BIGINT COMMENT 'Inventory stock item referenced.',
    `approved_timestamp` TIMESTAMP COMMENT 'When the line was approved.',
    `compliance_requirements` STRING COMMENT 'Line-level compliance requirements.',
    `contract_line_status` STRING COMMENT 'Status of the contract line.',
    `contract_line_type` STRING COMMENT 'Type of contract line.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency for the line.',
    `delivery_location_code` STRING COMMENT 'Code for delivery location.',
    `effective_end_date` DATE COMMENT 'Line effective end date.',
    `effective_start_date` DATE COMMENT 'Line effective start date.',
    `is_price_locked` BOOLEAN COMMENT 'Whether the price is locked.',
    `is_renewable` BOOLEAN COMMENT 'Whether the line is renewable.',
    `item_description` STRING COMMENT 'Description of the item.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `line_sequence` STRING COMMENT 'Sequence number of the line.',
    `maximum_order_quantity` STRING COMMENT 'Maximum order quantity.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity.',
    `notes` STRING COMMENT 'Additional notes.',
    `price_escalation_clause` DECIMAL(18,2) COMMENT 'Price escalation clause value.',
    `price_escalation_frequency` DECIMAL(18,2) COMMENT 'Frequency of price escalation.',
    `price_escalation_percent` DECIMAL(18,2) COMMENT 'Percentage of price escalation.',
    `price_tier_end_quantity` DECIMAL(18,2) COMMENT 'End quantity for price tier.',
    `price_tier_start_quantity` DECIMAL(18,2) COMMENT 'Start quantity for price tier.',
    `regulatory_approval_status` STRING COMMENT 'Regulatory approval status.',
    `renewal_option` STRING COMMENT 'Renewal option details.',
    `sku` STRING COMMENT 'Stock keeping unit code.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate.',
    `tier_price` DECIMAL(18,2) COMMENT 'Price for the tier.',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price for the item.',
    `uom` STRING COMMENT 'Unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `waste_percentage_allowed` DECIMAL(18,2) COMMENT 'Allowable waste percentage.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Expected yield percentage.',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Individual line items within a procurement contract specifying items, pricing, and terms.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Primary key for the requisition.',
    `approved_by_employee_id` BIGINT COMMENT 'Employee who approved the requisition.',
    `contract_id` BIGINT COMMENT 'Associated contract.',
    `cost_center_id` BIGINT COMMENT 'Cost center for the requisition.',
    `created_by_employee_id` BIGINT COMMENT 'Employee who created the requisition.',
    `department_id` BIGINT COMMENT 'Requesting department.',
    `employee_id` BIGINT COMMENT 'Requesting employee.',
    `franchisee_id` BIGINT COMMENT 'Franchisee if applicable.',
    `primary_requisition_approved_by_employee_id` BIGINT COMMENT 'Alternative approver reference.',
    `unit_id` BIGINT COMMENT 'Restaurant unit requesting.',
    `requisition_unit_id` BIGINT COMMENT 'Unit reference.',
    `stock_item_id` BIGINT COMMENT 'Stock item being requested.',
    `tertiary_requisition_employee_id` BIGINT COMMENT 'Employee associated with requisition.',
    `approval_status` STRING COMMENT 'Current approval status.',
    `approved_timestamp` TIMESTAMP COMMENT 'When the requisition was approved.',
    `budget_code` DECIMAL(18,2) COMMENT 'Budget code for the requisition.',
    `compliance_flag` BOOLEAN COMMENT 'Whether the requisition is compliant.',
    `compliance_notes` STRING COMMENT 'Notes on compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency for the requisition.',
    `delivery_method` STRING COMMENT 'Preferred delivery method.',
    `discount_estimate` DECIMAL(18,2) COMMENT 'Estimated discount.',
    `expected_delivery_date` DATE COMMENT 'Expected delivery date.',
    `justification_text` STRING COMMENT 'Business justification.',
    `line_item_count` STRING COMMENT 'Number of line items.',
    `net_estimated_amount` DECIMAL(18,2) COMMENT 'Net estimated amount.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms.',
    `priority_level` STRING COMMENT 'Priority level of the requisition.',
    `procurement_method` STRING COMMENT 'Method of procurement.',
    `required_by_date` DATE COMMENT 'Date by which items are needed.',
    `requisition_number` STRING COMMENT 'Unique requisition number.',
    `requisition_status` STRING COMMENT 'Current status.',
    `spend_category_code` DECIMAL(18,2) COMMENT 'Spend category code.',
    `supplier_preference` STRING COMMENT 'Preferred supplier if any.',
    `tax_estimate` DECIMAL(18,2) COMMENT 'Estimated tax amount.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Whether the requisition is tax exempt.',
    `tax_exempt_reason` DECIMAL(18,2) COMMENT 'Reason for tax exemption.',
    `total_estimated_amount` DECIMAL(18,2) COMMENT 'Total estimated amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `urgency_flag` BOOLEAN COMMENT 'Whether the requisition is urgent.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Purchase requisitions initiated by restaurant units or departments requesting goods or services.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` (
    `procurement_purchase_order_id` BIGINT COMMENT 'Primary key for the purchase order.',
    `contract_id` BIGINT COMMENT 'Associated contract.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `employee_id` BIGINT COMMENT 'Employee who created the PO.',
    `stock_location_id` BIGINT COMMENT 'Stock location for delivery.',
    `franchisee_id` BIGINT COMMENT 'Franchisee if applicable.',
    `unit_id` BIGINT COMMENT 'Delivery location unit.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier for the PO.',
    `procurement_unit_id` BIGINT COMMENT 'Restaurant unit.',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date.',
    `approval_status` STRING COMMENT 'PO approval status.',
    `approved_by` BIGINT COMMENT 'Approver ID.',
    `approved_timestamp` TIMESTAMP COMMENT 'When the PO was approved.',
    `category_code` STRING COMMENT 'Category code for the PO.',
    `compliance_flag` BOOLEAN COMMENT 'Whether the PO is compliant.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'PO currency.',
    `delivery_address` STRING COMMENT 'Delivery address.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount.',
    `external_reference_number` STRING COMMENT 'External reference number.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight/shipping amount.',
    `internal_comments` STRING COMMENT 'Internal comments.',
    `is_consolidated` BOOLEAN COMMENT 'Whether this is a consolidated PO.',
    `is_urgent` BOOLEAN COMMENT 'Whether the PO is urgent.',
    `last_received_timestamp` TIMESTAMP COMMENT 'Last goods receipt timestamp.',
    `line_item_count` STRING COMMENT 'Number of line items.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net PO amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `order_date` DATE COMMENT 'Date the PO was placed.',
    `payment_due_date` DATE COMMENT 'Payment due date.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms.',
    `po_status` STRING COMMENT 'Current PO status.',
    `po_type` STRING COMMENT 'Type of purchase order.',
    `priority` STRING COMMENT 'PO priority level.',
    `promised_delivery_date` DATE COMMENT 'Supplier promised delivery date.',
    `purchase_order_number` STRING COMMENT 'Unique PO number.',
    `receipt_status` STRING COMMENT 'Goods receipt status.',
    `regulatory_approval_status` STRING COMMENT 'Regulatory approval status.',
    `requested_delivery_date` DATE COMMENT 'Requested delivery date.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate.',
    `total_amount_gross` DECIMAL(18,2) COMMENT 'Gross total amount.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_procurement_purchase_order PRIMARY KEY(`procurement_purchase_order_id`)
) COMMENT 'Purchase orders issued to suppliers for goods and services in the procurement process.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Primary key for the PO line.',
    `budget_line_id` BIGINT COMMENT 'Associated budget line.',
    `contract_line_id` BIGINT COMMENT 'Associated contract line.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Purchase order reference.',
    `primary_po_header_procurement_purchase_order_id` BIGINT COMMENT 'Parent purchase order header.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier for this line.',
    `product_id` BIGINT COMMENT 'Product being ordered.',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date for this line.',
    `compliance_flag` BOOLEAN COMMENT 'Whether the line is compliant.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency for the line.',
    `delivery_status` STRING COMMENT 'Delivery status.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount on this line.',
    `expected_delivery_date` DATE COMMENT 'Expected delivery date.',
    `extended_amount` DECIMAL(18,2) COMMENT 'Extended line amount (qty x price).',
    `invoice_timestamp` TIMESTAMP COMMENT 'When the line was invoiced.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity invoiced.',
    `is_late` BOOLEAN COMMENT 'Whether delivery is late.',
    `is_three_way_match` BOOLEAN COMMENT 'Whether three-way match is required.',
    `item_description` STRING COMMENT 'Description of the item.',
    `item_sku` STRING COMMENT 'SKU of the item.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `line_number` STRING COMMENT 'Line number on the PO.',
    `line_status` STRING COMMENT 'Status of the line.',
    `line_type` STRING COMMENT 'Type of line item.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net line amount.',
    `notes` STRING COMMENT 'Additional notes.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity ordered.',
    `receipt_timestamp` TIMESTAMP COMMENT 'When goods were received.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity received.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount for the line.',
    `tax_code` DECIMAL(18,2) COMMENT 'A standardized code representing the tax classification for this po line',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate for the line.',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price.',
    `uom` STRING COMMENT 'Unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Expected waste percentage.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items on a purchase order specifying items, quantities, prices, and delivery details.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Primary key for the supplier invoice.',
    `employee_id` BIGINT COMMENT 'Employee who approved the invoice.',
    `contract_id` BIGINT COMMENT 'Associated contract.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Associated purchase order.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier who issued the invoice.',
    `unit_id` BIGINT COMMENT 'Restaurant unit.',
    `approval_status` STRING COMMENT 'Invoice approval status.',
    `approved_timestamp` TIMESTAMP COMMENT 'When the invoice was approved.',
    `attached_document_url` STRING COMMENT 'URL to attached invoice document.',
    `category_code` STRING COMMENT 'Spend category code.',
    `cogs_percentage` DECIMAL(18,2) COMMENT 'Cost of goods sold percentage.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Invoice currency.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount on the invoice.',
    `dispute_reason` STRING COMMENT 'Reason for dispute if applicable.',
    `due_date` DATE COMMENT 'Payment due date.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'Discount for early payment.',
    `early_payment_due_date` DATE COMMENT 'Due date for early payment discount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied.',
    `external_comments` STRING COMMENT 'Comments from supplier.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross invoice amount.',
    `internal_comments` STRING COMMENT 'Internal processing comments.',
    `invoice_date` DATE COMMENT 'Date of the invoice.',
    `invoice_number` STRING COMMENT 'Supplier invoice number.',
    `invoice_type` STRING COMMENT 'Type of invoice.',
    `is_disputed` BOOLEAN COMMENT 'Whether the invoice is disputed.',
    `line_item_count` STRING COMMENT 'Number of line items.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net invoice amount.',
    `payment_date` DATE COMMENT 'Date payment was made.',
    `payment_method` DECIMAL(18,2) COMMENT 'Payment method used.',
    `payment_status` DECIMAL(18,2) COMMENT 'Payment status.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms.',
    `receipt_date` DATE COMMENT 'Date invoice was received.',
    `receipt_number` STRING COMMENT 'Goods receipt number.',
    `supplier_invoice_status` STRING COMMENT 'Current invoice status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Whether the invoice is tax exempt.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate applied.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vat_number` STRING COMMENT 'VAT registration number.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Invoices received from suppliers for goods and services delivered.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` (
    `supplier_scorecard_id` DECIMAL(18,2) COMMENT 'Primary key for the scorecard.',
    `employee_id` BIGINT COMMENT 'Employee who performed the evaluation.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier being evaluated.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'Average lead time during the period.',
    `comments` STRING COMMENT 'Evaluator comments.',
    `compliance_status` STRING COMMENT 'Compliance status during the period.',
    `contract_number` STRING COMMENT 'Associated contract number.',
    `corrective_action_count` STRING COMMENT 'Number of corrective actions issued.',
    `cost_savings_percent` DECIMAL(18,2) COMMENT 'Cost savings achieved.',
    `evaluation_period_end` DATE COMMENT 'End of evaluation period.',
    `evaluation_period_start` DATE COMMENT 'Start of evaluation period.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'When the evaluation was performed.',
    `evaluator_department` STRING COMMENT 'Department of the evaluator.',
    `fill_rate` DECIMAL(18,2) COMMENT 'Order fill rate percentage.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Invoice accuracy rate.',
    `next_review_due_date` DATE COMMENT 'When next review is due.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'On-time delivery percentage.',
    `overall_score` DECIMAL(18,2) COMMENT 'Overall scorecard score.',
    `quality_rejection_rate` DECIMAL(18,2) COMMENT 'Quality rejection rate.',
    `record_created` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated` TIMESTAMP COMMENT 'Record update timestamp.',
    `region` STRING COMMENT 'Geographic region.',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Supplier responsiveness score.',
    `risk_level` STRING COMMENT 'Risk level assessment.',
    `scorecard_number` DECIMAL(18,2) COMMENT 'Unique scorecard reference.',
    `scorecard_version` DECIMAL(18,2) COMMENT 'Version of the scorecard template.',
    `supplier_category` STRING COMMENT 'Category of the supplier.',
    `supplier_scorecard_status` DECIMAL(18,2) COMMENT 'Status of the scorecard.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Sustainability performance score.',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Periodic supplier performance scorecards measuring delivery, quality, cost, and compliance metrics.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` (
    `supplier_risk_id` BIGINT COMMENT 'Primary key for the risk assessment.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier being assessed.',
    `assessment_timestamp` TIMESTAMP COMMENT 'When the assessment was performed.',
    `compliance_fda_flag` BOOLEAN COMMENT 'Whether supplier is FDA compliant.',
    `compliance_osha_flag` BOOLEAN COMMENT 'Whether supplier is OSHA compliant.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `dependency_percentage` DECIMAL(18,2) COMMENT 'Percentage of supply dependent on this supplier.',
    `financial_stability_score` DECIMAL(18,2) COMMENT 'Financial stability score.',
    `geographic_region` STRING COMMENT 'Geographic region of the supplier.',
    `mitigation_plan` STRING COMMENT 'Risk mitigation plan.',
    `next_review_date` DATE COMMENT 'Next scheduled review date.',
    `review_frequency_days` STRING COMMENT 'How often the risk is reviewed.',
    `risk_category` STRING COMMENT 'Category of risk.',
    `risk_description` STRING COMMENT 'Description of the risk.',
    `risk_factor_details` DECIMAL(18,2) COMMENT 'Detailed risk factor value.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score.',
    `risk_status` STRING COMMENT 'Current risk status.',
    `risk_tier` STRING COMMENT 'Risk tier classification.',
    `single_source_dependency` BOOLEAN COMMENT 'Whether this is a single-source dependency.',
    `supplier_financial_rating` STRING COMMENT 'Supplier financial rating.',
    `supplier_primary_contact` STRING COMMENT 'Primary contact for risk matters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_supplier_risk PRIMARY KEY(`supplier_risk_id`)
) COMMENT 'Risk assessments for suppliers covering financial, operational, compliance, and geographic risks.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` (
    `item_specification_id` BIGINT COMMENT 'Primary key for the item specification.',
    `category_id` BIGINT COMMENT 'Category this item belongs to.',
    `allergen_declaration` DECIMAL(18,2) COMMENT 'Allergen declaration code.',
    `approved_substitutes` STRING COMMENT 'List of approved substitute items.',
    `certification_status` STRING COMMENT 'Certification status of the item.',
    `item_specification_code` STRING COMMENT 'Unique specification code.',
    `compliance_fda_required` BOOLEAN COMMENT 'Whether FDA compliance is required.',
    `compliance_usda_required` DECIMAL(18,2) COMMENT 'USDA compliance requirement.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Cost per unit of the item.',
    `country_of_origin` STRING COMMENT 'Country where the item is produced.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency for pricing.',
    `dietary_restriction` STRING COMMENT 'Dietary restrictions applicable.',
    `effective_from` DATE COMMENT 'Specification effective from date.',
    `effective_until` DATE COMMENT 'Specification effective until date.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date code.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Whether the item is hazardous.',
    `is_perishable` BOOLEAN COMMENT 'Whether the item is perishable.',
    `item_specification_status` STRING COMMENT 'Status of the specification.',
    `last_inspection_date` DATE COMMENT 'Date of last quality inspection.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `material` STRING COMMENT 'Material composition.',
    `maximum_order_quantity` STRING COMMENT 'Maximum order quantity.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity.',
    `item_specification_name` STRING COMMENT 'Name of the specification.',
    `notes` STRING COMMENT 'Additional notes.',
    `packaging_type` STRING COMMENT 'Type of packaging.',
    `quality_grade` STRING COMMENT 'Quality grade requirement.',
    `quantity_per_unit` DECIMAL(18,2) COMMENT 'Quantity per unit of packaging.',
    `shelf_life_days` STRING COMMENT 'Shelf life in days.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Required storage temperature in Celsius.',
    `supplier_requirements` STRING COMMENT 'Requirements for suppliers.',
    `temperature_control_required` BOOLEAN COMMENT 'Whether temperature control is needed.',
    `temperature_range_c` STRING COMMENT 'Acceptable temperature range.',
    `traceability_required` BOOLEAN COMMENT 'Whether traceability is required.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `volume_liters` DECIMAL(18,2) COMMENT 'Volume in liters.',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Expected waste percentage.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight in kilograms.',
    CONSTRAINT pk_item_specification PRIMARY KEY(`item_specification_id`)
) COMMENT 'Detailed specifications for procured items including quality, packaging, storage, and compliance requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` (
    `vendor_rebate_id` BIGINT COMMENT 'Primary key for the vendor rebate.',
    `procurement_supplier_id` BIGINT COMMENT 'Alternative supplier reference.',
    `superseded_vendor_rebate_id` BIGINT COMMENT 'Previous rebate this one supersedes.',
    `vendor_procurement_supplier_id` BIGINT COMMENT 'Supplier offering the rebate.',
    `accrual_amount` DECIMAL(18,2) COMMENT 'Accrual amount.',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Amount accrued to date.',
    `calculation_method` STRING COMMENT 'Method used to calculate the rebate.',
    `created_at` TIMESTAMP COMMENT 'Alternative creation timestamp.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency` STRING COMMENT 'Currency for the rebate.',
    `currency_code` STRING COMMENT 'Currency code.',
    `payment_status` STRING COMMENT 'Payment status of the rebate.',
    `period_end` STRING COMMENT 'End of rebate period.',
    `period_end_date` DATE COMMENT 'End date of the rebate period.',
    `period_start` STRING COMMENT 'Start of rebate period.',
    `period_start_date` DATE COMMENT 'Start date of the rebate period.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Fixed rebate amount.',
    `rebate_name` STRING COMMENT 'Name of the rebate.',
    `rebate_percent` DECIMAL(18,2) COMMENT 'Rebate percentage.',
    `rebate_program_name` STRING COMMENT 'Name of the rebate program.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Rebate rate.',
    `rebate_rate_pct` DECIMAL(18,2) COMMENT 'Rebate rate as percentage.',
    `rebate_rate_percent` DECIMAL(18,2) COMMENT 'Rebate rate as a percent value.',
    `rebate_status` STRING COMMENT 'Detailed rebate status.',
    `rebate_type` STRING COMMENT 'Type of rebate (volume, spend, growth).',
    `vendor_rebate_status` STRING COMMENT 'Current rebate status.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Spend threshold to qualify.',
    `volume_threshold` DECIMAL(18,2) COMMENT 'Volume threshold to qualify.',
    CONSTRAINT pk_vendor_rebate PRIMARY KEY(`vendor_rebate_id`)
) COMMENT 'Vendor rebate programs tracking volume-based or spend-based rebates from suppliers.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` (
    `supplier_category_contract_id` BIGINT COMMENT 'Primary key.',
    `category_id` BIGINT COMMENT 'Procurement category.',
    `contract_id` BIGINT COMMENT 'Associated contract.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this supplier category contract',
    `auto_renew_flag` BOOLEAN COMMENT 'Whether auto-renews.',
    `committed_spend` DECIMAL(18,2) COMMENT 'Committed spend amount.',
    `committed_spend_amount` DECIMAL(18,2) COMMENT 'Alternative committed spend.',
    `committed_volume` STRING COMMENT 'Committed volume.',
    `contract_end_date` DATE COMMENT 'The date and time when the contract end event occurred for this supplier category contract',
    `contract_start_date` DATE COMMENT 'Start date.',
    `contract_status` STRING COMMENT 'Contract status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this supplier category contract',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount rate for the category.',
    `effective_date` DATE COMMENT 'Effective date.',
    `end_date` DATE COMMENT 'Alternative end date.',
    `expiry_date` DATE COMMENT 'Expiry date.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Whether preferred vendor for category.',
    `pricing_terms` STRING COMMENT 'Pricing terms description.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Rebate rate for the category.',
    `start_date` DATE COMMENT 'Alternative start date.',
    `supplier_category_contract_status` STRING COMMENT 'Current status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vendor_rating` STRING COMMENT 'Vendor rating for this category.',
    CONSTRAINT pk_supplier_category_contract PRIMARY KEY(`supplier_category_contract_id`)
) COMMENT 'Contracts linking suppliers to specific procurement categories with pricing and volume commitments.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the supply agreement.',
    `ingredient_id` BIGINT COMMENT 'Ingredient covered by the agreement.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier party to the agreement.',
    `agreement_number` STRING COMMENT 'Unique agreement reference number.',
    `agreement_status` STRING COMMENT 'Detailed agreement status.',
    `auto_renew_flag` BOOLEAN COMMENT 'Whether the agreement auto-renews.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency` STRING COMMENT 'Alternative currency field.',
    `currency_code` STRING COMMENT 'Currency for the agreement.',
    `effective_date` DATE COMMENT 'Alternative effective date.',
    `effective_end_date` DATE COMMENT 'Effective end date.',
    `effective_start_date` DATE COMMENT 'Effective start date.',
    `end_date` DATE COMMENT 'Agreement end date.',
    `expiry_date` DATE COMMENT 'Expiry date.',
    `governing_terms` STRING COMMENT 'Governing terms and conditions.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `payment_terms` STRING COMMENT 'Payment terms.',
    `price_amount` DECIMAL(18,2) COMMENT 'Agreed price amount.',
    `price_tier_max_qty` DECIMAL(18,2) COMMENT 'Maximum quantity for price tier.',
    `price_tier_min_qty` DECIMAL(18,2) COMMENT 'Minimum quantity for price tier.',
    `renewal_terms` STRING COMMENT 'Renewal terms.',
    `start_date` DATE COMMENT 'Agreement start date.',
    `supply_agreement_status` STRING COMMENT 'Agreement status.',
    `total_commitment_value` DECIMAL(18,2) COMMENT 'Alternative total commitment value.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'Total committed value.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'Supply agreements with suppliers for specific ingredients or products with pricing tiers and commitment values.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`procurement`.`product` (
    `product_id` BIGINT COMMENT 'Primary key.',
    `category_id` BIGINT COMMENT 'FK to procurement category.',
    `parent_product_id` BIGINT COMMENT 'Self-FK to parent product.',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier.',
    `allergen_info` STRING COMMENT 'Allergen information.',
    `brand` STRING COMMENT 'Product brand.',
    `product_category` STRING COMMENT 'Product category.',
    `cost_price` DECIMAL(18,2) COMMENT 'Cost price.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `product_description` STRING COMMENT 'Product description.',
    `discontinued_date` DATE COMMENT 'Date product was discontinued.',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `has_allergen` BOOLEAN COMMENT 'Boolean indicator flag for has allergen status in this product',
    `hazardous_material` BOOLEAN COMMENT 'Whether product is hazardous.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Boolean indicator flag for hazardous material flag status in this product',
    `height_cm` DECIMAL(18,2) COMMENT 'Height in centimeters.',
    `is_perishable` BOOLEAN COMMENT 'Whether product is perishable.',
    `lead_time_days` STRING COMMENT 'Lead time in days.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length in centimeters.',
    `lifecycle_stage` STRING COMMENT 'Product lifecycle stage.',
    `line` STRING COMMENT 'Product line.',
    `product_name` STRING COMMENT 'Product name.',
    `nutritional_info` STRING COMMENT 'Nutritional information.',
    `packaging_type` STRING COMMENT 'Type of packaging.',
    `price` DECIMAL(18,2) COMMENT 'Selling price.',
    `reorder_point_quantity` STRING COMMENT 'Reorder point quantity.',
    `safety_stock_quantity` STRING COMMENT 'Safety stock quantity.',
    `sku` STRING COMMENT 'Stock keeping unit.',
    `product_status` STRING COMMENT 'Product status.',
    `subcategory` STRING COMMENT 'Product subcategory.',
    `tax_code` DECIMAL(18,2) COMMENT 'A standardized code representing the tax classification for this product',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `upc` STRING COMMENT 'Universal Product Code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp.',
    `volume_liters` DECIMAL(18,2) COMMENT 'Volume in liters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight in kilograms.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width in centimeters.',
    CONSTRAINT pk_product PRIMARY KEY(`product_id`)
) COMMENT 'Catalog of procurable products with specifications, dimensions, pricing, and lifecycle management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ADD CONSTRAINT `fk_procurement_procurement_supplier_parent_supplier_procurement_supplier_id` FOREIGN KEY (`parent_supplier_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ADD CONSTRAINT `fk_procurement_sourcing_response_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ADD CONSTRAINT `fk_procurement_sourcing_response_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ADD CONSTRAINT `fk_procurement_contract_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_contract_line_id` FOREIGN KEY (`contract_line_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract_line`(`contract_line_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_primary_po_header_procurement_purchase_order_id` FOREIGN KEY (`primary_po_header_procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_product_id` FOREIGN KEY (`product_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`product`(`product_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ADD CONSTRAINT `fk_procurement_supplier_risk_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ADD CONSTRAINT `fk_procurement_item_specification_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ADD CONSTRAINT `fk_procurement_vendor_rebate_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ADD CONSTRAINT `fk_procurement_vendor_rebate_superseded_vendor_rebate_id` FOREIGN KEY (`superseded_vendor_rebate_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`vendor_rebate`(`vendor_rebate_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ADD CONSTRAINT `fk_procurement_vendor_rebate_vendor_procurement_supplier_id` FOREIGN KEY (`vendor_procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ADD CONSTRAINT `fk_procurement_supplier_category_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ADD CONSTRAINT `fk_procurement_supplier_category_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ADD CONSTRAINT `fk_procurement_supplier_category_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ADD CONSTRAINT `fk_procurement_product_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ADD CONSTRAINT `fk_procurement_product_parent_product_id` FOREIGN KEY (`parent_product_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`product`(`product_id`);
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ADD CONSTRAINT `fk_procurement_product_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_restaurants_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_ssot_canonical' = 'supply.supply_supplier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `parent_supplier_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `parent_supplier_procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_business_glossary_term' = 'Address Line');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `default_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `global_supplier_number` SET TAGS ('dbx_business_glossary_term' = 'Global Supplier Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Max Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `remittance_address` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `remittance_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `remittance_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `spend_ytd` SET TAGS ('dbx_business_glossary_term' = 'Spend YTD');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_entity_type' = 'reference');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'AVL ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_documents` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documents');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms Summary');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `insurance_certificate_expiry` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `is_currently_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Currently Approved');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax ID Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_category_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rating');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` SET TAGS ('dbx_entity_type' = 'reference');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `annual_spend` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `commodity_group` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `is_strategic` SET TAGS ('dbx_business_glossary_term' = 'Is Strategic');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `parent_category` SET TAGS ('dbx_business_glossary_term' = 'Parent Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `spend_classification` SET TAGS ('dbx_business_glossary_term' = 'Spend Classification');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `spend_owner` SET TAGS ('dbx_business_glossary_term' = 'Spend Owner');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `spend_ytd` SET TAGS ('dbx_business_glossary_term' = 'Spend YTD');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_stakeholder_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_decision` SET TAGS ('dbx_business_glossary_term' = 'Award Decision');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `weighting_scheme` SET TAGS ('dbx_business_glossary_term' = 'Weighting Scheme');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_response_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Response ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_response_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `compliance_attestations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestations');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Eligible');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `is_preferred_supplier` SET TAGS ('dbx_business_glossary_term' = 'Is Preferred Supplier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `quality_certifications` SET TAGS ('dbx_business_glossary_term' = 'Quality Certifications');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `response_comments` SET TAGS ('dbx_business_glossary_term' = 'Response Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `scoring_rank` SET TAGS ('dbx_business_glossary_term' = 'Scoring Rank');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `scoring_total` SET TAGS ('dbx_business_glossary_term' = 'Scoring Total');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `sourcing_response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `supplier_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Rating');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Valid Until');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`sourcing_response` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` SET TAGS ('dbx_ssot_canonical' = 'supply.supply_contract');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `manager_contact` SET TAGS ('dbx_business_glossary_term' = 'Manager Contact');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `manager_contact` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `manager_contact` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `rebate_terms` SET TAGS ('dbx_business_glossary_term' = 'Rebate Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `scope_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Scope of Supply');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `sla_commitment` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `contract_line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Price Locked');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Is Renewable');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Max Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Frequency');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_escalation_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_tier_end_quantity` SET TAGS ('dbx_business_glossary_term' = 'Price Tier End Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `price_tier_start_quantity` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Start Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'SKU');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `tier_price` SET TAGS ('dbx_business_glossary_term' = 'Tier Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'UOM');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `waste_percentage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage Allowed');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`contract_line` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Approved By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Employee');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tertiary_requisition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `discount_estimate` SET TAGS ('dbx_business_glossary_term' = 'Discount Estimate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `justification_text` SET TAGS ('dbx_business_glossary_term' = 'Justification Text');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `net_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Estimated Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `spend_category_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `supplier_preference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Preference');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tax_estimate` SET TAGS ('dbx_business_glossary_term' = 'Tax Estimate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `total_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`requisition` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_ssot_canonical' = 'supply.supply_purchase_order');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'PO ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Stock Location');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Unit');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Is Urgent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `last_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'PO Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'PO Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'PO Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `total_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Gross');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight KG');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'PO Line ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'PO ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `primary_po_header_procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'PO Header ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `primary_po_header_procurement_purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `product_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `is_late` SET TAGS ('dbx_business_glossary_term' = 'Is Late');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `is_three_way_match` SET TAGS ('dbx_business_glossary_term' = 'Is Three Way Match');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `item_sku` SET TAGS ('dbx_business_glossary_term' = 'Item SKU');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'UOM');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`po_line` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'PO ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `attached_document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cogs_percentage` SET TAGS ('dbx_business_glossary_term' = 'COGS Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `early_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `external_comments` SET TAGS ('dbx_business_glossary_term' = 'External Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Scorecard ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `cost_savings_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Period End');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluator_department` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Department');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `quality_rejection_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_version` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Version');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_scorecard` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_risk_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `compliance_fda_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `compliance_osha_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `dependency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Dependency Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `financial_stability_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_factor_details` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Details');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `single_source_dependency` SET TAGS ('dbx_business_glossary_term' = 'Single Source Dependency');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_primary_contact` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_primary_contact` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` SET TAGS ('dbx_entity_type' = 'reference');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Item Spec ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `approved_substitutes` SET TAGS ('dbx_business_glossary_term' = 'Approved Substitutes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_code` SET TAGS ('dbx_business_glossary_term' = 'Spec Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `compliance_fda_required` SET TAGS ('dbx_business_glossary_term' = 'FDA Compliance Required');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `compliance_usda_required` SET TAGS ('dbx_business_glossary_term' = 'USDA Compliance Required');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `dietary_restriction` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Spec Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Max Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Order Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_name` SET TAGS ('dbx_business_glossary_term' = 'Spec Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `item_specification_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `quantity_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Unit');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `supplier_requirements` SET TAGS ('dbx_business_glossary_term' = 'Supplier Requirements');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range C');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `traceability_required` SET TAGS ('dbx_business_glossary_term' = 'Traceability Required');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume Liters');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`item_specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight KG');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `vendor_rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rebate ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `vendor_rebate_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID Alt');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `superseded_vendor_rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Rebate ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `superseded_vendor_rebate_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `vendor_procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `accrual_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Period End');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_program_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_program_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate PCT');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `vendor_rebate_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`vendor_rebate` ALTER COLUMN `volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_association_edges' = 'procurement.supplier,procurement.procurement_category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `supplier_category_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `supplier_category_contract_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `committed_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `supplier_category_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supplier_category_contract` ALTER COLUMN `vendor_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rating');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,supply.ingredient');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` SET TAGS ('dbx_entity_type' = 'transaction');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `governing_terms` SET TAGS ('dbx_business_glossary_term' = 'Governing Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Amount');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `price_tier_max_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Max Qty');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `price_tier_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Min Qty');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `supply_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `total_commitment_value` SET TAGS ('dbx_business_glossary_term' = 'Total Commitment Value');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`supply_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `parent_product_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `allergen_info` SET TAGS ('dbx_business_glossary_term' = 'Allergen Info');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `discontinued_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height CM');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length CM');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `nutritional_info` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Info');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Price');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'SKU');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'UPC');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume Liters');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight KG');
ALTER TABLE `vibe_restaurants_v1`.`procurement`.`product` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width CM');
