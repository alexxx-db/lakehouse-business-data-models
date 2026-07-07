-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`procurement` COMMENT 'Purchasing and vendor management for property operations including supplier contracts, purchase orders, receiving, spend analytics, and goods receipt. Manages vendor relationships, contract compliance, procurement categories (F&B supplies, housekeeping, FF&E), and cost optimization. Integrates with SAP S/4HANA MM module. Supports both CapEx procurement (PIP projects) and OpEx purchasing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor. Primary key for the vendor master record.',
    `property_id` BIGINT COMMENT 'FK connection added per structural fix',
    `address_line1` STRING COMMENT 'First line of the vendors primary business address including street number and name. Used for correspondence and legal documentation.',
    `address_line2` STRING COMMENT 'Second line of the vendors address for suite, floor, building, or other secondary address information.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with this vendor over the most recent 12-month period. Used for vendor segmentation, negotiation leverage analysis, and spend analytics. Expressed in the companys reporting currency.',
    `bank_account_number` STRING COMMENT 'Vendors bank account number for electronic payment remittance. Highly sensitive financial information requiring restricted access and encryption.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the vendors primary remittance account. Used for ACH and wire transfer payments.',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number identifying the vendors bank for ACH and wire transfers in the United States.. Valid values are `^[0-9]{9}$`',
    `city` STRING COMMENT 'City or municipality of the vendors primary business location.',
    `classification` STRING COMMENT 'Primary business classification of the vendor based on goods or services provided. Categories include Food and Beverage (F&B) supplier, housekeeping supplier, Furniture Fixtures and Equipment (FF&E) vendor, maintenance contractor, technology provider, and professional services.. Valid values are `food_beverage_supplier|housekeeping_supplier|ffe_vendor|maintenance_contractor|technology_provider|professional_services`',
    `vendor_code` STRING COMMENT 'External business identifier for the vendor used in procurement documents and SAP S/4HANA MM module. Unique alphanumeric code assigned to each supplier.. Valid values are `^[A-Z0-9]{6,12}$`',
    `compliance_status` STRING COMMENT 'Current compliance status indicating whether the vendor meets all required certifications, insurance requirements, and regulatory standards. Non-compliant vendors may be blocked from receiving new purchase orders.. Valid values are `compliant|non_compliant|pending_review|conditional`',
    `contract_end_date` DATE COMMENT 'Expiration date of the current master service agreement or supply contract with the vendor. Null for vendors without formal contracts or with evergreen agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current master service agreement or supply contract with the vendor. Used for contract lifecycle management and renewal tracking.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the vendors primary business location. Examples: USA (United States), CAN (Canada), GBR (United Kingdom).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor master record was first created in the system. Used for audit trail and data lineage tracking.',
    `dba_name` STRING COMMENT 'Trade name or doing business as name if different from legal name. Used for operational communications and invoicing.',
    `diversity_certification` STRING COMMENT 'Diversity certification status of the vendor. Categories include Minority Business Enterprise (MBE), Women Business Enterprise (WBE), Disadvantaged Business Enterprise (DBE), Veteran Business Enterprise (VBE), LGBTQ Business Enterprise (LGBTBE), Service-Disabled Veteran-Owned Small Business (SDVOSB), HUBZone certified, or none. Used for supplier diversity reporting and corporate social responsibility initiatives. [ENUM-REF-CANDIDATE: mbe|wbe|dbe|vbe|lgbtbe|sdvosb|hubzone|none — 8 candidates stripped; promote to reference product]',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number providing unique identification for the vendor entity. Used for credit assessment and supplier risk management.. Valid values are `^[0-9]{9}$`',
    `iban` STRING COMMENT 'International Bank Account Number for vendors in countries using the IBAN standard. Required for SEPA payments in Europe and other international transfers.',
    `insurance_certificate_expiry_date` DATE COMMENT 'Expiration date of the vendors current general liability insurance certificate. Vendors must maintain valid insurance coverage to remain in active status.',
    `last_review_date` DATE COMMENT 'Date of the most recent vendor performance review or compliance audit. Strategic and preferred vendors are typically reviewed annually; approved vendors are reviewed every 2-3 years.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order submission to delivery at property receiving dock. Used for inventory planning and procurement scheduling.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum purchase order value required by the vendor for order acceptance. Orders below this threshold may incur additional fees or be rejected. Expressed in the vendors preferred currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor master record was last updated. Used for change tracking and audit trail compliance.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor or supplier organization as registered with tax authorities and used in contracts.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next vendor performance review or compliance audit. Used for vendor management workflow and compliance calendar.',
    `onboarding_date` DATE COMMENT 'Date when the vendor was first approved and added to the procurement system. Used for vendor relationship tenure analysis and anniversary tracking.',
    `payment_method` STRING COMMENT 'Preferred payment method for remitting funds to the vendor. Options include Automated Clearing House (ACH) electronic transfer, wire transfer, paper check, credit card, or procurement card.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor. Defines the number of days from invoice date until payment is due. Common terms include Net 30 (payment due in 30 days) and 2/10 Net 30 (2% discount if paid within 10 days, otherwise due in 30 days). [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30|prepayment_required — 7 candidates stripped; promote to reference product]',
    `postal_code` STRING COMMENT 'Postal code or ZIP code of the vendors primary business location. Format varies by country.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the vendors preferred invoicing and payment currency. Examples: USD (US Dollar), EUR (Euro), GBP (British Pound).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact for operational communications, purchase orders, and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor organization. Typically the account manager or sales representative assigned to the hospitality business relationship.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary vendor contact. Used for urgent procurement matters and order expediting.',
    `remittance_email` STRING COMMENT 'Email address for sending electronic remittance advice and payment notifications to the vendor. Used for accounts receivable communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_rating` STRING COMMENT 'Overall risk assessment rating for the vendor based on financial stability, compliance history, delivery performance, and business continuity factors. Critical risk vendors require executive approval for new purchase orders.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'State, province, or region of the vendors primary business location. Use standard postal abbreviations (e.g., CA for California, ON for Ontario).',
    `swift_code` STRING COMMENT 'SWIFT/BIC code for international wire transfers to vendors outside the domestic banking system. Eight or eleven character code identifying the bank and branch.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the vendor. In the US this is the Employer Identification Number (EIN) or Social Security Number (SSN) for sole proprietors. Required for 1099 reporting and tax compliance.',
    `tier` STRING COMMENT 'Vendor relationship tier indicating strategic importance and procurement preference. Strategic vendors receive priority treatment and volume commitments; restricted vendors require special approval for purchases.. Valid values are `strategic|preferred|approved|conditional|restricted`',
    `vat_registration_number` STRING COMMENT 'VAT registration number for vendors operating in jurisdictions with value-added tax systems. Required for international procurement and tax reclaim processing.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the procurement system. Active vendors can receive purchase orders; blocked vendors cannot transact pending resolution of compliance or performance issues.. Valid values are `active|inactive|suspended|pending_approval|blocked|terminated`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers and vendors providing goods and services to hotel and resort properties. Captures vendor identity, classification (F&B supplier, FF&E vendor, housekeeping supplier, maintenance contractor), tax registration, payment terms, preferred currency, remittance details, diversity certification, contact persons (account managers, sales reps, escalation contacts), and SAP S/4HANA vendor master integration. Serves as the SSOT for vendor identity and vendor contacts across procurement. Includes vendor tier, risk rating, compliance status, bank/payment details, and communication preferences.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor performance is evaluated by procurement category since performance criteria vary by category (F&B vs. FF&E vs. services). FK enables category-specific scorecards and benchmarking.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted or approved this vendor performance evaluation.',
    `property_id` BIGINT COMMENT 'Reference to the property where vendor performance is being evaluated. Supports property-level vendor scorecarding.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being evaluated in this performance record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation was approved and published. Marks the official completion of the evaluation cycle.',
    `average_lead_time_days` STRING COMMENT 'Average number of days between purchase order issuance and goods receipt during the evaluation period. Measures vendor fulfillment speed.',
    `contract_compliance_score` DECIMAL(18,2) COMMENT 'Composite score measuring vendor adherence to contract terms including pricing, delivery terms, payment terms, and service level agreements. Scored 0-100.',
    `contract_renewal_recommendation` STRING COMMENT 'Recommendation for contract action based on performance evaluation results. Supports contract lifecycle management decisions.. Valid values are `renew|renegotiate|terminate|extend_trial`',
    `cost_competitiveness_rating` DECIMAL(18,2) COMMENT 'Rating of vendor pricing competitiveness compared to market benchmarks and alternative suppliers. Typically scored 1-5 scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation record was first created in the system.',
    `emergency_order_support_rating` DECIMAL(18,2) COMMENT 'Rating of vendor ability to fulfill urgent or emergency purchase orders outside normal lead times. Critical for hospitality operations continuity. Typically scored 1-5 scale.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluator regarding vendor performance, specific issues, or improvement recommendations.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period. Defines the window for performance measurement.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. Typically monthly or quarterly evaluation cycles.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the vendor performance evaluation record.. Valid values are `draft|submitted|approved|published|archived`',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices received without pricing errors, quantity discrepancies, or other billing issues during the evaluation period.',
    `invoice_discrepancies_count` STRING COMMENT 'Number of invoices with pricing errors, quantity mismatches, or other billing issues during the evaluation period.',
    `late_deliveries_count` STRING COMMENT 'Number of purchase orders delivered after the requested delivery date during the evaluation period.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation record was last modified.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the requested delivery date during the evaluation period. Key metric for vendor reliability.',
    `overall_vendor_score` DECIMAL(18,2) COMMENT 'Weighted composite score combining all evaluation criteria (on-time delivery, quality, invoice accuracy, contract compliance, responsiveness). Used for vendor ranking and qualification decisions. Scored 0-100.',
    `payment_terms_compliance_flag` BOOLEAN COMMENT 'Indicates whether vendor adhered to agreed payment terms and did not demand early payment or deviate from contract terms.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor has achieved preferred vendor status based on performance evaluation results. Preferred vendors receive priority consideration for new purchase orders.',
    `qualified_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor meets minimum qualification standards for continued business. Vendors failing qualification may be subject to contract review or termination.',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of goods receipts accepted without quality defects or rejections during the evaluation period. Measures product quality consistency.',
    `quality_rejections_count` STRING COMMENT 'Number of goods receipts rejected due to quality defects during the evaluation period.',
    `responsiveness_rating` DECIMAL(18,2) COMMENT 'Subjective rating of vendor responsiveness to inquiries, issues, and urgent requests. Typically scored 1-5 scale.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether vendor meets sustainability and environmental compliance requirements during the evaluation period. Supports ESG procurement initiatives.',
    `total_purchase_orders` STRING COMMENT 'Total number of purchase orders issued to this vendor during the evaluation period. Provides context for performance metrics.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with this vendor during the evaluation period in USD. Supports spend concentration analysis.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic vendor performance evaluation records capturing on-time delivery rate, quality acceptance rate, invoice accuracy, contract compliance score, responsiveness rating, and overall vendor scorecard. Supports vendor qualification, preferred vendor designation, and contract renewal decisions. Aligned with USALI cost management standards and SAP MM vendor evaluation (ME61).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Procurement contracts are organized by category for contract compliance and category management. FK enables category-specific contract terms, approval workflows, and compliance tracking.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Procurement contracts create compliance obligations that hotels must track: insurance certificate requirements, vendor certifications (food safety, sustainability), regulatory standards (ADA complianc',
    `employee_id` BIGINT COMMENT 'Reference to the procurement or property staff member responsible for managing this contract, monitoring compliance, and coordinating renewals.',
    `primary_procurement_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this contract. Null if contract is not yet approved.',
    `property_id` BIGINT COMMENT 'Reference to the property or hotel location to which this contract applies. Null if contract is.',
    `tertiary_procurement_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this contract record.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this contract is established.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized procurement or finance management. Null if contract is still in draft or pending approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry unless explicitly terminated. True if contract has auto-renewal clause, False if manual renewal required.',
    `capex_designation_flag` BOOLEAN COMMENT 'Indicates whether this contract is designated for capital expenditure purchases (CapEx) such as Property Improvement Plan (PIP) projects, FF&E replacements, or major renovations. True for CapEx contracts, False for operating expenditure (OpEx) contracts.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the procurement contract for easy identification by procurement staff.',
    `contract_number` STRING COMMENT 'Externally visible unique business identifier for the procurement contract, used in vendor communications and purchase orders.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates contract is being negotiated, pending approval awaiting internal authorization, active for contracts in force, suspended for temporarily paused agreements, expired for contracts past end date, terminated for contracts ended before expiry, renewed for contracts that have been extended. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract structure. Master supply agreement for long-term supplier relationships, blanket PO for recurring purchases, frame contract for pre-negotiated terms, spot contract for one-time purchases, service agreement for ongoing services, CapEx contract for capital expenditure projects including Property Improvement Plan (PIP) initiatives.. Valid values are `master_supply_agreement|blanket_purchase_order|frame_contract|spot_contract|service_agreement|capex_contract`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which contract values, pricing, and payments are denominated.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard number of days from purchase order placement to goods receipt at property, as agreed in the contract Service Level Agreement (SLA).',
    `document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the enterprise document management system for legal reference and audit purposes.',
    `effective_date` DATE COMMENT 'Date when the contract terms become binding and purchasing can commence under the agreed terms.',
    `expiry_date` DATE COMMENT 'Date when the contract terms cease to be valid. Null for open-ended contracts without a defined end date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated in the procurement system.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity allowed per purchase order or over contract term, if applicable. Used for contract compliance monitoring. Null if no maximum applies.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per purchase order under this contract to qualify for negotiated pricing. Null if no minimum applies.',
    `negotiated_discount_percent` DECIMAL(18,2) COMMENT 'Overall discount percentage negotiated off standard vendor pricing, applied at contract level. Used for price variance analysis and savings tracking. Null if no blanket discount applies.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, negotiation history, or operational notes relevant to procurement staff.',
    `payment_terms` STRING COMMENT 'Agreed payment terms and conditions, including net payment days, early payment discounts, and payment method requirements (e.g., Net 30, 2/10 Net 30, Net 60).',
    `pip_project_flag` BOOLEAN COMMENT 'Indicates whether this contract is specifically tied to a Property Improvement Plan (PIP) project for property renovation or upgrade. True if PIP-related, False otherwise.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry that either party must provide notice to prevent auto-renewal or to initiate renewal discussions. Null if not applicable.',
    `sla_on_time_delivery_percent` DECIMAL(18,2) COMMENT 'Contractually agreed percentage of orders that must be delivered on time to meet SLA performance targets. Used for vendor performance monitoring.',
    `sla_quality_acceptance_percent` DECIMAL(18,2) COMMENT 'Contractually agreed percentage of delivered goods that must pass quality inspection on first receipt to meet SLA performance targets.',
    `termination_date` DATE COMMENT 'Date when the contract was formally terminated before its natural expiry. Null if contract has not been terminated.',
    `termination_reason` STRING COMMENT 'Business reason or justification for early contract termination, such as vendor performance issues, business requirement changes, or cost optimization. Null if contract has not been terminated.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total estimated or committed monetary value of the contract over its full term, in the contract currency. Used for contract compliance monitoring and spend analytics. Null for open-ended contracts without value caps.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Master procurement contracts and supply agreements with vendors, modeled as header+line. Header captures contract type (master supply agreement, blanket PO, frame contract), vendor, effective/expiry dates, auto-renewal flags, total contract value, negotiated discounts, and SLAs. Lines specify agreed materials/services, unit prices, minimum/maximum order quantities, and validity periods. Supports contract compliance monitoring, price variance analysis, and CapEx/PIP contract designations. Integrates with SAP S/4HANA MM outline agreements (ME31K). [SSOT_OWNER] [SSOT MASTER for group procurement.procurement_contract]channel_contract. [SSOT:contract] Domain-specific specialization of the contract concept; canonical SSOT owner is channel.channel_contract.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase requisitions are classified by procurement category for routing, approval workflows, and spend tracking. The string column procurement_category should be normalized to FK reference. This enab',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department initiating the purchase request (F&B, Housekeeping, Engineering, Spa, Events, Front Office, etc.).',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or suggested vendor for this requisition, if specified by the requestor.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created the purchase requisition.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where the requisition originated.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Purchase requisitions are converted to purchase orders during the procurement workflow. The string column purchase_order_number should be normalized to FK for traceability and requisition-to-PO lifecy',
    `tertiary_purchase_final_approver_employee_id` BIGINT COMMENT 'Identifier of the employee who provided the final approval before conversion to purchase order.',
    `approval_chain_level` STRING COMMENT 'Current level in the approval hierarchy. Increments as requisition moves through approval workflow based on amount thresholds and organizational rules.',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and became eligible for conversion to purchase order.',
    `budget_available_flag` BOOLEAN COMMENT 'Indicates whether sufficient budget is available in the cost center and GL account for this requisition. True if budget check passed, False if insufficient funds.',
    `budget_period` STRING COMMENT 'Specific budget period (quarter or month) for expense allocation. Format: YYYY-Q# or YYYY-M##.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `budget_year` STRING COMMENT 'Fiscal year against which the requisition is being charged for budget tracking and variance analysis.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition lifecycle was completed (converted to PO, cancelled, or rejected).',
    `contract_reference_number` STRING COMMENT 'Reference to an existing vendor contract or master agreement if this requisition is to be fulfilled under contract terms.',
    `converted_to_po_flag` BOOLEAN COMMENT 'Indicates whether this requisition has been converted to one or more purchase orders. True if converted, False if still pending or cancelled.',
    `cost_center_code` STRING COMMENT 'Cost center to which the requisition expense will be charged. Aligns with USALI departmental cost accounting.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated amount.. Valid values are `^[A-Z]{3}$`',
    `delivery_location_code` STRING COMMENT 'Code identifying the specific receiving location within the property (central receiving, F&B storage, housekeeping, engineering shop, etc.).',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'Estimated total value of the requisition in the propertys functional currency. Used for budget checking and approval routing.',
    `gl_account_code` STRING COMMENT 'General ledger account code for expense classification per USALI chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `item_count` STRING COMMENT 'Number of line items (distinct materials or services) included in this requisition.',
    `justification_text` STRING COMMENT 'Business justification provided by the requestor explaining the need for this procurement. Required for approval workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was last updated.',
    `priority_level` STRING COMMENT 'Urgency classification of the requisition. Critical for guest-impacting or safety issues, High for operational needs, Medium for planned procurement, Low for non-urgent requests.. Valid values are `Critical|High|Medium|Low`',
    `rejection_reason` STRING COMMENT 'Explanation provided by approver if the requisition was rejected. Null if not rejected.',
    `requested_delivery_date` DATE COMMENT 'Date by which the requesting department needs the goods or services delivered.',
    `requisition_number` STRING COMMENT 'Business-facing unique requisition number assigned by SAP MM module. Format: PR followed by 10 digits.. Valid values are `^PR[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: Draft|Submitted|Pending Approval|Approved|Rejected|Cancelled|Converted to PO|Closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of requisition by financial treatment: OpEx (Operating Expenditure), CapEx (Capital Expenditure), PIP (Property Improvement Plan), Emergency, Stock Replenishment, or Service procurement.. Valid values are `OpEx|CapEx|PIP|Emergency|Stock Replenishment|Service`',
    `source_system_key` STRING COMMENT 'Natural key or unique identifier from the source system for reconciliation and lineage tracking.',
    `sourcing_strategy` STRING COMMENT 'Procurement approach to be used for fulfilling this requisition based on value, category, and policy.. Valid values are `Direct PO|RFQ Required|Competitive Bid|Sole Source|Corporate Contract|Emergency Purchase`',
    `special_instructions` STRING COMMENT 'Additional instructions or requirements for procurement, delivery, or handling of the requested items.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was submitted for approval workflow.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase request initiated by hotel departments (F&B, Housekeeping, Engineering, Spa, Events) to procure goods or services. Captures requesting department, requestor, cost center, GL account, required delivery date, estimated value, procurement category, priority, justification, and approval status with approval chain. Supports OpEx and CapEx (PIP) procurement initiation, budget checking, and routing to appropriate buyer or sourcing workflow. Sourced from SAP S/4HANA MM purchase requisition (ME51N).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase orders are classified by procurement category for spend analytics, compliance tracking, and category management reporting. Normalizing the string column to FK enables hierarchical category ro',
    `cost_center_id` BIGINT COMMENT 'Reference to the departmental cost center that will bear the expense. Used for OpEx budget tracking and USALI departmental expense allocation (e.g., F&B, Housekeeping, Maintenance).',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: POs create financial commitments posted to specific GL accounts for encumbrance accounting and budget consumption tracking; required for commitment reporting and period-end accruals in hospitality fin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: POs for multi-property portfolios require profit center attribution for property-level budget control and spend allocation; critical for property-level financial performance tracking and owner reporti',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property location where goods or services will be delivered. Represents the ship-to address and the operational unit responsible for the purchase.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom goods or services are being procured. Links to vendor master data in SAP MM.',
    `actual_delivery_date` DATE COMMENT 'The date goods were actually received or services were completed. Populated upon goods receipt posting (MIGO transaction). Used for vendor performance analysis and on-time delivery metrics.',
    `approval_date` DATE COMMENT 'The date the purchase order was approved and the financial commitment was authorized. Represents the encumbrance date for budget tracking.',
    `approver_name` STRING COMMENT 'Name of the manager or authorized signatory who approved the purchase order. Used for financial controls and SOX compliance.',
    `blanket_release_number` STRING COMMENT 'Sequential release number for blanket purchase orders. Tracks individual call-offs against a master blanket PO. Null for non-blanket orders.',
    `buyer_email` STRING COMMENT 'Email address of the buyer for vendor communication and order clarification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or property staff member who created the purchase order. Used for accountability and audit trail.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time the purchase order was closed after complete fulfillment and financial settlement. Null for open orders.',
    `commitment_released_amount` DECIMAL(18,2) COMMENT 'For blanket orders, the cumulative amount released to date against the total blanket commitment. Used for spend tracking and remaining commitment calculation.',
    `contract_reference_number` STRING COMMENT 'Reference to a master contract or blanket purchase agreement under which this PO is issued. Used for contract compliance tracking and release order management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time the purchase order record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values. Typically matches the vendors billing currency or propertys local currency.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_completed_flag` BOOLEAN COMMENT 'Boolean indicator whether all goods or services have been received and posted. True indicates receiving is complete, false indicates partial or no receipt. Used to trigger invoice matching and payment processing.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for shipping, insurance, and risk transfer. Examples: EXW (Ex Works), FOB (Free On Board), DDP (Delivered Duty Paid). Critical for international procurement and FF&E imports. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_completed_flag` BOOLEAN COMMENT 'Boolean indicator whether vendor invoice has been received and matched to the purchase order. Used for three-way match validation (PO, goods receipt, invoice) and accounts payable processing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time the purchase order record was last modified. Used for change tracking and audit compliance.',
    `payment_terms` STRING COMMENT 'The agreed payment terms code defining when payment is due to the vendor. Examples include Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30). Maps to SAP payment terms master data.. Valid values are `^[A-Z0-9]{0,10}$`',
    `po_date` DATE COMMENT 'The date the purchase order was created and issued. Represents the business event timestamp for the procurement transaction.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Unique document number assigned by SAP MM module (transaction ME21N). Used for vendor communication and cross-system reference.. Valid values are `^[A-Z0-9]{10,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the approval and fulfillment workflow. Draft indicates initial creation, pending approval indicates routing through approval chain, approved indicates financial commitment authorized, released indicates transmitted to vendor, partially received indicates goods/services partially delivered, fully received indicates complete delivery, closed indicates financial settlement complete, cancelled indicates order voided. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order. Standard for one-time purchases, blanket for recurring releases against a master agreement, framework for multi-property contracts, CapEx for capital expenditure projects (FF&E, PIP), OpEx for operating expenditure (F&B supplies, housekeeping consumables), service for contracted services.. Valid values are `standard|blanket|framework|capex|opex|service`',
    `promised_delivery_date` DATE COMMENT 'The date the vendor committed to deliver goods or complete services. Used for vendor SLA tracking and receiving schedule planning.',
    `requested_delivery_date` DATE COMMENT 'The date by which the property requires delivery of goods or completion of services. Used for supply chain planning and vendor performance tracking.',
    `requisition_number` STRING COMMENT 'Reference to the internal purchase requisition that originated this purchase order. Links operational need to procurement fulfillment.',
    `ship_to_address_line1` STRING COMMENT 'First line of the delivery address for the property or receiving location. Typically the property name and street address.',
    `ship_to_address_line2` STRING COMMENT 'Second line of the delivery address. May include building name, department, or additional location details.',
    `ship_to_city` STRING COMMENT 'City name for the delivery address.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery address. Used for international shipping, customs, and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `ship_to_postal_code` STRING COMMENT 'Postal code or ZIP code for the delivery address. Used for shipping logistics and tax calculation.',
    `ship_to_state_province` STRING COMMENT 'State, province, or region for the delivery address. Used for tax jurisdiction determination.',
    `shipping_method` STRING COMMENT 'The mode of transportation for goods delivery. Ground for truck freight, air for expedited air freight, ocean for container shipping (FF&E imports), courier for small package delivery, vendor delivery for supplier-managed logistics, pickup for property collection from vendor location.. Valid values are `ground|air|ocean|courier|vendor_delivery|pickup`',
    `special_instructions` STRING COMMENT 'Free-text field for additional delivery instructions, handling requirements, or vendor-specific notes. Examples: Deliver to loading dock, Refrigerated transport required, Contact receiving manager upon arrival.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to the purchase order. Includes sales tax, VAT, GST, or other jurisdiction-specific taxes based on property location and vendor tax classification.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total gross value of the purchase order including all line items, before taxes and fees. Represents the financial commitment or encumbrance against the budget upon approval.',
    `total_amount_with_tax` DECIMAL(18,2) COMMENT 'The total purchase order value including all taxes and fees. Represents the final financial obligation to the vendor.',
    `vendor_quote_number` STRING COMMENT 'Reference number of the vendors quotation or proposal that this purchase order is based on. Used for price verification and audit trail.',
    `wbs_element` STRING COMMENT 'Project WBS element for CapEx and PIP (Property Improvement Plan) procurement. Used to track capital expenditure against specific renovation or development projects. Null for OpEx purchases.. Valid values are `^[A-Z0-9-.]{0,24}$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal purchase orders issued to vendors for goods and services required by hotel and resort operations. Captures PO type (standard, blanket, framework, CapEx/PIP), vendor, delivery address (property), payment terms, incoterms, total PO value, currency, approval status, WBS element for CapEx/PIP projects, and SAP document number. Represents the financial commitment/encumbrance against departmental or project budgets upon approval. Supports both OpEx purchasing (F&B supplies, housekeeping consumables) and CapEx procurement (FF&E, renovation materials). Includes delivery schedule attributes, approval workflow status, and commitment release tracking for blanket orders. Core transactional entity in SAP S/4HANA MM (ME21N).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: PO line items are classified by procurement category for detailed spend analytics and line-level category tracking. FK enables accurate category spend reporting at the most granular level.',
    `po_material_master_id` BIGINT COMMENT 'Reference to the material master record for the item being procured. Links to the material catalog for goods such as Food and Beverage (F&B) supplies, housekeeping items, or Furniture Fixtures and Equipment (FF&E).',
    `po_service_material_master_id` BIGINT COMMENT 'Reference to the service master record for service-based procurement. Used when the line item represents a service rather than a physical material.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master vendor contract or blanket purchase agreement from which this line item is released. Links to negotiated terms and pricing agreements.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `requisition_line_id` BIGINT COMMENT 'Reference to the originating purchase requisition line item that triggered this purchase order line. Provides traceability from demand to procurement.',
    `cost_center` STRING COMMENT 'The cost center to which this line item expenditure will be charged for Operating Expenditure (OpEx) purchases. Used for departmental cost allocation and Gross Operating Profit (GOP) analysis per Uniform System of Accounts for the Lodging Industry (USALI).',
    `created_by_user` STRING COMMENT 'The user ID of the procurement professional or system user who created this purchase order line item. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was originally created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing. Indicates the currency in which unit price and net order value are denominated. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AUD|CAD|CHF|INR|MXN|BRL|AED|SGD|HKD|THB — 15 candidates stripped; promote to reference product]',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion. When true, the line is logically deleted but retained for audit trail purposes.',
    `delivery_date` DATE COMMENT 'The requested or confirmed delivery date for this line item. Represents when the vendor is expected to deliver the goods or complete the service.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating that the final invoice has been received for this line item and no further invoices are expected. Triggers line closure and prevents additional invoice postings.',
    `general_ledger_account` STRING COMMENT 'The General Ledger account code to which this line item will be posted. Determines the financial statement classification per USALI chart of accounts.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt processing is required for this line item. When true, physical receipt must be posted before invoice can be processed.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods that have been physically received and posted against this purchase order line. Used for three-way match validation between PO, goods receipt, and invoice.',
    `incoterms` STRING COMMENT 'The Incoterms code defining the delivery terms and transfer of risk between buyer and seller. Determines shipping responsibility and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this line item. When true, vendor invoice must be matched and verified before payment.',
    `invoice_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the vendor against this purchase order line. Used for three-way match validation and to track invoicing completeness.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and display sequence of line items.',
    `line_status` STRING COMMENT 'The current lifecycle status of this purchase order line item. Tracks progression from order placement through goods receipt, invoicing, and final closure.. Valid values are `Open|Partially Received|Fully Received|Invoiced|Closed|Cancelled`',
    `manufacturer_part_number` STRING COMMENT 'The original manufacturers part number or model number for the item being procured. Ensures correct item specification and quality standards.',
    `modified_by_user` STRING COMMENT 'The user ID of the person who last modified this purchase order line item. Provides audit trail for changes to procurement terms or quantities.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was last modified. Tracks changes to quantities, pricing, delivery dates, or other line attributes.',
    `net_order_value` DECIMAL(18,2) COMMENT 'The total net value of this line item calculated as order quantity multiplied by unit price. Excludes taxes and represents the base procurement cost.',
    `open_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity still outstanding on this purchase order line, calculated as order quantity minus goods receipt quantity. Represents unfulfilled procurement commitment.',
    `order_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units ordered on this line item. Represents the total amount requested from the vendor.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Used for goods receipt validation.',
    `plant_code` STRING COMMENT 'The property or facility code where the material will be received or the service will be performed. Represents the destination location within the hotel or resort portfolio.',
    `price_unit` STRING COMMENT 'The quantity of units to which the unit price applies. For example, if price is stated per 100 units, this field would contain 100.',
    `short_text` STRING COMMENT 'Brief description of the material or service being ordered on this line item. Provides human-readable context for the procurement item.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse within the plant where goods will be received and stored. Examples include main warehouse, F&B storage, housekeeping supply room, or FF&E storage.',
    `tax_code` STRING COMMENT 'Tax classification code that determines the applicable tax rate and tax jurisdiction for this line item. Used for tax calculation and compliance reporting.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may under-deliver below the ordered quantity without penalty. Used for goods receipt validation and automatic PO closure.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is measured. Examples include Each (EA), Case (CS), Kilogram (KG), Liter (LT), Hour (HR) for services, or Day (DA) for rental equipment. [ENUM-REF-CANDIDATE: EA|CS|BX|KG|LB|LT|GL|M|FT|HR|DA|PC|PK|RL|ST — 15 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The agreed price per unit of measure for this line item. Represents the negotiated rate with the vendor before any discounts or surcharges.',
    `vendor_material_number` STRING COMMENT 'The vendors own catalog or SKU number for the material or service. Used for cross-referencing with vendor invoices and facilitating three-way match processing.',
    `wbs_element` STRING COMMENT 'The project Work Breakdown Structure element for Capital Expenditure (CapEx) procurement tied to Property Improvement Plan (PIP) projects or renovation initiatives. Used for project-based cost tracking.',
    `material_master_id` BIGINT COMMENT '',
    `service_material_master_id` BIGINT COMMENT '',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order specifying the material or service ordered, quantity, unit of measure, agreed unit price, delivery date, storage location, and account assignment (cost center, WBS element for CapEx/PIP projects). Tracks goods receipt quantity, invoice quantity, and open quantity for three-way match processing. Sourced from SAP S/4HANA MM PO line item (EKPO).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Goods receipts are classified by procurement category for inventory management and receiving workflow routing. Normalizing enables category-specific receiving rules and quality inspection requirements',
    `pip_plan_id` BIGINT COMMENT 'Reference to the PIP project if this goods receipt is part of a capital improvement initiative. Links FF&E procurement to renovation projects.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or authorized person who approved the goods receipt for posting. Required for segregation of duties and SOX compliance.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where goods are being received. Enables property-level inventory tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received. Links to the originating procurement document.',
    `receiving_employee_id` BIGINT COMMENT 'Identifier of the staff member who physically received and inspected the goods. Used for accountability and training purposes.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor delivering the goods. Used for vendor performance tracking and three-way match.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether the received materials are tracked by batch or lot number. Essential for F&B traceability and recall management.',
    `bill_of_lading_number` STRING COMMENT 'Shipping document number for freight shipments. Used for tracking and freight audit, especially for FF&E deliveries.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt was cancelled or reversed. Used for exception tracking and process improvement analysis.',
    `capex_opex_indicator` STRING COMMENT 'Classification of the procurement as capital expenditure (FF&E, PIP projects) or operating expenditure (supplies, consumables). Drives accounting treatment and financial reporting.. Valid values are `capex|opex`',
    `condition_on_receipt` STRING COMMENT 'Physical condition assessment of goods upon delivery. Drives acceptance decisions, vendor performance scoring, and claims processing.. Valid values are `good|damaged|expired|incorrect_item|short_shipment|overage`',
    `cost_center_code` STRING COMMENT 'Accounting cost center to which the received goods are charged. Enables departmental expense tracking per USALI standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was first created in the system. Used for audit trail and process timing analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction value. Supports multi-currency operations for international property portfolios.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The vendors delivery note or packing slip reference number. Critical for three-way match and vendor reconciliation.',
    `document_date` DATE COMMENT 'The date printed on the delivery note or packing slip from the vendor. Used for reconciliation and dispute resolution.',
    `freight_charges_amount` DECIMAL(18,2) COMMENT 'Shipping and freight costs associated with this delivery. May be capitalized into inventory cost or expensed depending on accounting policy.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting the inventory or expense transaction. Aligns with USALI chart of accounts.',
    `gr_document_number` STRING COMMENT 'External business identifier for the goods receipt document. Unique alphanumeric code used in SAP MM for tracking and audit purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction. Tracks progression from draft through posting to potential reversal.. Valid values are `draft|posted|cancelled|reversed`',
    `inspection_status` STRING COMMENT 'Quality inspection outcome for the received goods. Determines whether goods are accepted into inventory or flagged for return/credit.. Valid values are `not_inspected|passed|failed|partial_acceptance|pending_qa`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was last updated. Tracks changes for audit and compliance purposes.',
    `movement_type` STRING COMMENT 'SAP MM movement type code indicating the nature of the inventory transaction. 101=GR for PO, 102=GR reversal, 161=GR for returns, 501=GR without PO, etc. [ENUM-REF-CANDIDATE: 101|102|103|105|161|501|502 — 7 candidates stripped; promote to reference product]',
    `posted_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt was posted to inventory and financial accounts. Marks the completion of the receiving transaction.',
    `posting_date` DATE COMMENT 'The accounting date when the goods receipt is posted to the general ledger and inventory accounts. May differ from physical receipt date.',
    `quality_rejection_flag` BOOLEAN COMMENT 'Indicates whether any portion of the goods receipt was rejected due to quality issues. Triggers vendor notification and return processing.',
    `receipt_date` DATE COMMENT 'The actual date when goods were physically received at the property. Used for inventory valuation and lead time analysis.',
    `receiving_notes` STRING COMMENT 'Free-text comments from the receiving staff regarding delivery conditions, discrepancies, or other observations. Used for dispute resolution and vendor feedback.',
    `return_delivery_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt represents a return to vendor rather than an inbound delivery. Used for reverse logistics tracking.',
    `serial_number_managed_flag` BOOLEAN COMMENT 'Indicates whether the received items are tracked by individual serial numbers. Typical for FF&E assets and high-value equipment.',
    `special_handling_instructions` STRING COMMENT 'Notes regarding special handling requirements for the received goods, such as refrigeration, fragile items, hazardous materials, or security protocols.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storeroom, warehouse, or storage area within the property where goods are placed. Examples: main kitchen, housekeeping storage, central warehouse.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the goods require temperature-controlled storage. Critical for F&B inventory compliance with food safety regulations.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order, goods receipt, and vendor invoice. Critical for accounts payable processing and internal controls.. Valid values are `not_started|matched|variance_detected|blocked|approved`',
    `total_quantity_received` DECIMAL(18,2) COMMENT 'Aggregate quantity of all line items received in this goods receipt transaction. Used for high-level receiving volume tracking.',
    `total_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all goods received in this transaction, in the propertys local currency. Used for inventory valuation and financial reporting.',
    `unloading_point` STRING COMMENT 'Physical location at the property where goods were delivered and unloaded. Examples: loading dock, main entrance, kitchen entrance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between expected value (from PO) and actual received value. Triggers investigation when exceeds tolerance thresholds.',
    `variance_reason_code` STRING COMMENT 'Standardized code explaining the cause of any variance between PO and GR. Used for root cause analysis and process improvement.. Valid values are `price_change|quantity_short|quantity_over|damaged_goods|substitution|freight_variance`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of goods and materials at hotel and resort properties against purchase orders, modeled as header+line. Header captures receiving date, location (property, storeroom), posting date, and GR document number. Lines capture material received, quantity, unit of measure, batch number, storage location, movement type, condition on receipt, and PO line reference. Triggers inventory update and initiates three-way match for invoice verification. Sourced from SAP S/4HANA MM (MIGO). Critical for F&B inventory, housekeeping supplies, and FF&E receiving.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor invoices are classified by procurement category for AP analytics, accrual tracking, and category spend reporting. FK enables category-level invoice approval workflows and spend variance analysi',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved this invoice for payment. Null if not yet approved.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document for three-way match validation. Null if no GR exists.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Multi-property management companies track vendor invoices by profit center (property) for property-level P&L and owner reporting; required for management fee calculations and owner distribution statem',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property that received the goods or services.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched. Null for non-PO invoices.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who issued this invoice.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice was approved for payment. Null if not yet approved.',
    `cost_center_code` STRING COMMENT 'The cost center code for allocating the invoice expense to a specific department or operational unit within the property.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice (e.g., early payment discount, volume discount), in the invoice currency.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is currently under dispute. True if disputed, False otherwise.',
    `dispute_reason` STRING COMMENT 'The reason code or description for the invoice dispute (e.g., pricing discrepancy, quantity mismatch, quality issue, unauthorized charges). Null if not disputed.',
    `dispute_resolution_date` DATE COMMENT 'The date the dispute was resolved. Null if dispute is still open or if no dispute exists.',
    `dispute_resolution_notes` STRING COMMENT 'Free-text notes describing the resolution of the dispute. Null if not applicable.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The amount in dispute, in the invoice currency. Null if not disputed.',
    `document_date` DATE COMMENT 'The document date used for accounting period assignment and reporting.',
    `early_payment_discount_date` DATE COMMENT 'The last date by which payment must be made to qualify for the early payment discount. Null if not applicable.',
    `early_payment_discount_eligible_flag` BOOLEAN COMMENT 'Indicates whether this invoice is eligible for an early payment discount per the payment terms. True if eligible, False otherwise.',
    `early_payment_discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount available if the invoice is paid within the early payment discount period (e.g., 2.00 for 2%). Null if not applicable.',
    `expense_type` STRING COMMENT 'Classification of the invoice as Operating Expenditure (OpEx) or Capital Expenditure (CapEx). CapEx typically relates to Property Improvement Plan (PIP) projects and Furniture Fixtures and Equipment (FF&E).. Valid values are `opex|capex`',
    `gl_account_code` STRING COMMENT 'The primary General Ledger (GL) account code for posting this invoice. Used for Uniform System of Accounts for the Lodging Industry (USALI)-compliant cost allocation.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax, in the invoice currency. Sum of all line item amounts.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Principal business event timestamp for the invoice.',
    `invoice_description` STRING COMMENT 'Free-text description or notes about the invoice, typically provided by the vendor or added by Accounts Payable (AP) staff.',
    `invoice_number` STRING COMMENT 'The externally-known invoice number assigned by the vendor. Business identifier for the invoice document.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the Accounts Payable (AP) workflow. [ENUM-REF-CANDIDATE: draft|posted|approved|paid|disputed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type (standard invoice, credit memo, debit memo, prepayment, or recurring).. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `match_variance_amount` DECIMAL(18,2) COMMENT 'The variance amount between the invoice and the PO/GR during three-way match, in the invoice currency. Null if matched.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount payable after tax and discounts, in the invoice currency. Gross + Tax - Discount.',
    `payment_date` DATE COMMENT 'The actual date the invoice was paid. Null if not yet paid.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `payment_method` STRING COMMENT 'The payment instrument or method used or planned for paying this invoice (e.g., Automated Clearing House (ACH), wire transfer, check, credit card, virtual card).. Valid values are `ach|wire_transfer|check|credit_card|virtual_card`',
    `payment_reference_number` STRING COMMENT 'The reference number or transaction ID of the payment made against this invoice. Null if not yet paid.',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the due date calculation and early payment discount eligibility (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial ledger in the accounting system.',
    `project_code` STRING COMMENT 'The project code for CapEx invoices related to Property Improvement Plan (PIP) projects, renovations, or capital investments. Null for OpEx invoices.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice, in the invoice currency.',
    `tax_code` STRING COMMENT 'The tax code used for calculating tax on this invoice (e.g., sales tax, VAT, GST). Determines tax rate and jurisdiction.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction or authority under which the tax is calculated (e.g., state, province, country).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation between Purchase Order (PO), Goods Receipt (GR), and invoice. Indicates whether the invoice matches the PO and GR within tolerance.. Valid values are `matched|variance|no_po|no_gr|blocked`',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoices received for goods and services procured by hotel and resort properties, modeled as header+line. Header captures invoice number, date, vendor, gross amount, tax amount, currency, payment due date, payment terms, three-way match status, and dispute details (reason, disputed amount, resolution). Lines capture material/service, quantity billed, unit price, line amount, tax code, GL account, cost center, and PO line/GR references. Supports AP processing, early payment discount capture, dispute management, and USALI-compliant cost allocation. Sourced from SAP S/4HANA MM (MIRO/MIR7).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material catalog.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Materials are classified by procurement category for catalog management, sourcing strategy, and spend classification. FK enables hierarchical category navigation and category-specific procurement rule',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the material master record. Supports accountability and audit compliance.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and usage frequency. A items are high-value/high-usage requiring tight control; C items are low-value/low-usage with relaxed management. Drives inventory policy and cycle count frequency.. Valid values are `A|B|C`',
    `allergen_information` STRING COMMENT 'List of allergens present in the material, critical for Food and Beverage (F&B) ingredients. Examples include dairy, gluten, nuts, shellfish, soy. Required for menu labeling and guest safety.',
    `base_unit_of_measure` STRING COMMENT 'Standard unit in which the material is stocked, issued, and valued. Examples include EA (each), CS (case), BX (box), KG (kilogram), LT (liter), GL (gallon), DZ (dozen). Aligns with inventory and procurement transactions.. Valid values are `^[A-Z]{2,3}$`',
    `brand_name` STRING COMMENT 'Commercial brand or trademark under which the material is marketed. Important for guest-facing amenities and Food and Beverage (F&B) ingredients where brand consistency impacts guest experience.',
    `capex_opex_indicator` STRING COMMENT 'Indicates whether the material is capitalized as a fixed asset (CapEx) or expensed as an operating cost (OpEx). Furniture Fixtures and Equipment (FF&E) for Property Improvement Plan (PIP) projects are typically CapEx; consumables and supplies are OpEx.. Valid values are `capex|opex`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code indicating where the material is manufactured or sourced. Required for customs, trade compliance, and sustainability reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price. Enables multi-currency procurement and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date after which the material is no longer available for procurement. Used for planned discontinuation and phase-out of materials.',
    `effective_start_date` DATE COMMENT 'Date from which the material master record is valid and available for procurement transactions. Supports phased rollout of new materials.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and disposal procedures per Occupational Safety and Health Administration (OSHA) regulations.',
    `lead_time_days` STRING COMMENT 'Average number of days from purchase order placement to goods receipt. Used for Material Requirements Planning (MRP) calculations and reorder point determination.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures or produces the material. Used for quality tracking, warranty management, and vendor performance evaluation.',
    `manufacturer_part_number` STRING COMMENT 'Unique part number assigned by the manufacturer. Enables precise identification for ordering, quality control, and warranty claims.',
    `material_description` STRING COMMENT 'Full descriptive name of the material, supply, or good. Provides human-readable identification for procurement, receiving, and inventory management.',
    `material_group` STRING COMMENT 'Detailed grouping of materials within a procurement category for granular spend analysis, vendor specialization, and contract management. Enables category-level reporting and sourcing strategy.',
    `material_number` STRING COMMENT 'Unique alphanumeric code assigned to the material in the procurement system. External business identifier used across purchase orders, goods receipts, and inventory transactions.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Active materials are available for procurement; inactive or discontinued materials are phased out; blocked materials cannot be ordered due to quality or compliance issues.. Valid values are `active|inactive|discontinued|pending_approval|blocked`',
    `material_type` STRING COMMENT 'Classification of the material based on its procurement and usage purpose. Determines procurement rules, valuation methods, and inventory management policies.. Valid values are `raw_material|trading_goods|finished_goods|spare_parts|consumables|services`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Upper limit for inventory holding to prevent overstocking, minimize carrying costs, and reduce waste for perishable items.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from vendors. Driven by vendor terms, packaging constraints, or economic order quantity calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was last updated. Tracks changes to pricing, status, vendor assignments, and other attributes.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether the material has a limited shelf life and requires expiration date tracking. True for Food and Beverage (F&B) ingredients, fresh produce, and time-sensitive supplies.',
    `procurement_type` STRING COMMENT 'Method by which the material is procured. Standard is direct purchase; consignment is vendor-owned inventory; subcontracting involves external processing; stock transfer is inter-property movement.. Valid values are `standard|consignment|subcontracting|stock_transfer`',
    `purchase_unit_of_measure` STRING COMMENT 'Unit in which the material is ordered from vendors. May differ from base unit (e.g., purchased in cases but stocked in each). Conversion factor to base unit is maintained separately.. Valid values are `^[A-Z]{2,3}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming goods must undergo quality inspection before acceptance. True for critical materials, Food and Beverage (F&B) ingredients, and items with quality history issues.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered. Calculated based on lead time demand and safety stock requirements to prevent stockouts.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Buffer inventory maintained to protect against demand variability and supply disruptions. Critical for high-usage items and materials with long lead times.',
    `shelf_life_days` STRING COMMENT 'Number of days the material remains usable after receipt or production. Critical for Food and Beverage (F&B) ingredients, guest amenities, and pharmaceutical supplies. Drives First-Expired-First-Out (FEFO) inventory rotation.',
    `short_description` STRING COMMENT 'Abbreviated description of the material for use in reports, purchase orders, and mobile applications where space is limited.',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard cost or valuation price of the material in the base currency. Used for inventory valuation, budgeting, and variance analysis. Updated periodically based on procurement trends.',
    `storage_condition` STRING COMMENT 'Required environmental conditions for storing the material to maintain quality and safety. Determines warehouse zone assignment and handling procedures.. Valid values are `ambient|refrigerated|frozen|climate_controlled|dry|secure`',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether the material meets sustainability or environmental certification standards such as Fair Trade, Rainforest Alliance, organic, or eco-label certifications. Supports corporate social responsibility and guest experience programs.',
    `tax_classification` STRING COMMENT 'Tax category code for the material determining applicable sales tax, value-added tax (VAT), or goods and services tax (GST) rates. Varies by jurisdiction and material type.',
    `temperature_range_max` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius allowed for proper storage of temperature-sensitive materials. Exceeding this threshold may compromise quality or safety.',
    `temperature_range_min` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius required for proper storage of temperature-sensitive materials. Used for cold chain compliance and quality assurance.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Master catalog of all materials, supplies, and goods procured for hotel and resort operations. Covers procurement categories including F&B ingredients, housekeeping consumables, FF&E items, engineering spare parts, and guest amenities. Captures material number, description, base unit of measure, procurement category, storage conditions, shelf life, minimum stock level, reorder point, and SAP material type. Serves as the SSOT for procurable items across all properties.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the procurement category. Primary key.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchical taxonomy. Null for top-level (L1) categories. Enables multi-level category drill-down for spend analytics.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Procurement categories enforce category-specific policies: ethical sourcing policies for food/beverage, sustainability policies for supplies, diversity vendor policies for services, data privacy polic',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this procurement category record. Supports audit trail and accountability.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this procurement category is currently active and available for purchase order creation. False for deprecated or discontinued categories.',
    `annual_spend_budget_amount` DECIMAL(18,2) COMMENT 'Planned annual procurement spend budget (in USD) for this category across all properties or at corporate level. Used for budget variance analysis and spend forecasting.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve purchase orders in this category: property (hotel GM), regional (area VP), corporate (CPO), or executive (CFO/CEO for high-value CapEx).. Valid values are `property|regional|corporate|executive`',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum purchase order value (in USD) that can be approved at the defined authority level. Orders exceeding this amount require escalation to higher approval authority.',
    `benchmarking_enabled_flag` BOOLEAN COMMENT 'Indicates whether spend in this category is benchmarked against industry standards (STR reports) or peer properties for cost optimization and competitive analysis.',
    `bid_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum purchase order value (in USD) that triggers mandatory competitive bidding for this category. Null if no threshold applies or competitive bidding is always required.',
    `budget_tracking_flag` BOOLEAN COMMENT 'Indicates whether spend in this category is tracked against annual budgets with variance reporting and budget consumption alerts. True for budget-controlled categories.',
    `category_type` STRING COMMENT 'Classification of procurement category by spend type: direct (guest-facing goods), indirect (operational supplies), capital (FF&E and CapEx), or services (contracted labor and professional services).. Valid values are `direct|indirect|capital|services`',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the procurement category for external reference and system integration. Used in SAP S/4HANA MM module for material group classification.. Valid values are `^[A-Z0-9]{4,12}$`',
    `competitive_bid_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category require competitive bidding process (RFP/RFQ) per procurement policy. True if competitive bidding is mandatory.',
    `compliance_framework` STRING COMMENT 'Specific regulatory or industry compliance framework applicable to this category (e.g., ISO 22000 for food safety, OSHA for workplace safety equipment, ADA for accessibility fixtures, PCI DSS for payment systems).',
    `contract_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category must comply with master service agreements or corporate contracts. True if contract compliance tracking is mandatory.',
    `cost_allocation_method` STRING COMMENT 'Method for allocating procurement spend in this category to financial reporting structures: direct_charge (to specific department), allocated (distributed across properties), cost_center, or profit_center per USALI standards.. Valid values are `direct_charge|allocated|cost_center|profit_center`',
    `cpor_tracking_flag` BOOLEAN COMMENT 'Indicates whether this category is included in CPOR (Cost Per Occupied Room) analysis for operational efficiency benchmarking. True for categories that scale with occupancy (housekeeping, guest amenities).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement category record was first created in the system. Supports audit trail and data lineage tracking.',
    `category_description` STRING COMMENT 'Detailed description of the procurement category scope, including types of goods and services covered, typical use cases, and business context.',
    `effective_end_date` DATE COMMENT 'Date when this procurement category was retired or discontinued. Null for currently active categories. Used for historical spend analysis and category lifecycle tracking.',
    `effective_start_date` DATE COMMENT 'Date when this procurement category became active and available for use in the procurement system. Supports category lifecycle management and historical analysis.',
    `emergency_procurement_allowed_flag` BOOLEAN COMMENT 'Indicates whether expedited emergency procurement procedures (bypassing standard approval workflows) are permitted for this category in urgent operational situations.',
    `inventory_managed_flag` BOOLEAN COMMENT 'Indicates whether items in this category are tracked in property inventory systems with stock levels, reorder points, and inventory valuation. True for stocked items (F&B, housekeeping supplies).',
    `lead_time_days` STRING COMMENT 'Typical lead time in days from purchase order placement to goods receipt for this category. Used for inventory planning and procurement scheduling.',
    `category_level` STRING COMMENT 'Hierarchical level of the category in the taxonomy (1=top level such as F&B or FF&E, 2=sub-category, 3=detailed sub-category). Supports hierarchical spend rollup and analysis.',
    `minimum_vendor_count` STRING COMMENT 'Minimum number of qualified vendors that must be maintained for this category to ensure supply continuity and competitive pricing. Null if no minimum is defined.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement category record was last modified. Updated whenever any attribute changes. Supports change tracking and audit compliance.',
    `category_name` STRING COMMENT 'Full business name of the procurement category (e.g., Food and Beverage Supplies, Housekeeping Linens, Furniture Fixtures and Equipment).',
    `preferred_vendor_program_flag` BOOLEAN COMMENT 'Indicates whether this category participates in a preferred vendor program with pre-negotiated pricing, terms, and service level agreements. True if preferred vendor relationships are established.',
    `quality_certification_required_flag` BOOLEAN COMMENT 'Indicates whether vendors supplying this category must hold specific quality certifications (e.g., ISO 22000 for food safety, industry-specific quality standards).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this category is subject to specific regulatory compliance requirements (e.g., food safety regulations, fire safety codes, ADA accessibility standards for FF&E).',
    `risk_classification` STRING COMMENT 'Procurement risk level for this category based on supply chain volatility, vendor concentration, regulatory exposure, and business impact: low (commodity items), medium (standard supplies), high (specialized equipment), critical (guest-facing or safety-critical).. Valid values are `low|medium|high|critical`',
    `sourcing_strategy` STRING COMMENT 'Procurement approach defined for this category: strategic (long-term partnerships), preferred_vendor (pre-qualified suppliers), competitive_bid (RFP/RFQ process), spot_buy (ad-hoc purchases), or contract (master service agreements).. Valid values are `strategic|preferred_vendor|competitive_bid|spot_buy|contract`',
    `spend_classification` STRING COMMENT 'Financial classification indicating whether spend in this category is treated as operating expenditure (OpEx) or capital expenditure (CapEx) for accounting and budgeting purposes.. Valid values are `opex|capex`',
    `sustainability_criteria_flag` BOOLEAN COMMENT 'Indicates whether this category has defined sustainability or environmental compliance requirements for vendor selection and product sourcing (e.g., eco-friendly cleaning supplies, sustainable seafood).',
    `tax_treatment_code` STRING COMMENT 'Tax classification for purchases in this category: taxable (standard VAT/sales tax), exempt (tax-exempt goods), zero_rated (0% tax rate), or reverse_charge (buyer remits tax). Varies by jurisdiction.. Valid values are `taxable|exempt|zero_rated|reverse_charge`',
    `usali_department_code` STRING COMMENT 'USALI standard department code for financial reporting and cost allocation (e.g., ROOMS for rooms division, F&B for food and beverage, A&G for administrative and general).. Valid values are `^[A-Z0-9]{2,6}$`',
    `vendor_diversification_required_flag` BOOLEAN COMMENT 'Indicates whether procurement policy requires multiple qualified vendors for this category to mitigate supply chain risk and ensure competitive pricing. True for high-risk or high-spend categories.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Hierarchical classification taxonomy for procurement spend categories across hotel and resort operations. Defines category hierarchy (L1: F&B, Housekeeping, FF&E, Engineering, IT; L2+ sub-categories), category manager assignment, preferred vendor associations, sourcing strategy, and competitive bidding thresholds. Supports spend analytics, category management, strategic sourcing decisions, and CPOR (Cost Per Occupied Room) analysis by category.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` (
    `request_for_quotation_id` BIGINT COMMENT 'Primary key for request_for_quotation',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved the issuance of this RFQ.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor selected as the winner of this RFQ, if award decision has been made.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: RFQs are organized by procurement category for strategic sourcing and category management. FK enables category-specific sourcing strategies, bid thresholds, and vendor qualification rules.',
    `primary_request_employee_id` BIGINT COMMENT 'Identifier of the procurement professional or buyer responsible for managing this RFQ.',
    `property_id` BIGINT COMMENT 'Identifier of the property or corporate entity issuing the RFQ.',
    `award_criteria` STRING COMMENT 'Primary basis for vendor selection and contract award. Lowest price awards to the vendor with the lowest compliant bid, best value considers price and non-price factors, technical merit prioritizes quality and capability, multi-vendor award splits the business among multiple qualified vendors.. Valid values are `lowest_price|best_value|technical_merit|multi_vendor_award`',
    `award_decision_date` DATE COMMENT 'Date when the final vendor selection and award decision was made.',
    `awarded_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract awarded as a result of this RFQ.',
    `awarded_timestamp` TIMESTAMP COMMENT 'Timestamp when the award decision was finalized and the winning vendor was officially notified.',
    `capex_opex_flag` STRING COMMENT 'Indicates whether this procurement is classified as Capital Expenditure (CapEx) for long-term assets and Property Improvement Plan (PIP) projects, or Operating Expenditure (OpEx) for day-to-day operational supplies and services.. Valid values are `capex|opex`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ response period officially closed and no further vendor submissions are accepted.',
    `contract_term_months` STRING COMMENT 'Duration of the resulting contract in months, if the RFQ leads to a long-term supply agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this RFQ (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_end_date` DATE COMMENT 'Latest date by which delivery or service completion must occur.',
    `delivery_location` STRING COMMENT 'Physical address or property location where goods or services must be delivered.',
    `delivery_start_date` DATE COMMENT 'Earliest date when delivery or service commencement is required.',
    `estimated_annual_spend_amount` DECIMAL(18,2) COMMENT 'Projected total annual expenditure for the goods or services covered by this RFQ, used for vendor evaluation and contract sizing.',
    `estimated_quantity` DECIMAL(18,2) COMMENT 'Anticipated volume or quantity of goods or services to be procured, expressed in the unit of measure specified.',
    `evaluation_criteria` STRING COMMENT 'Detailed description of the criteria and methodology used to evaluate vendor responses, including weighting of price, quality, delivery, service, and other factors.',
    `event_type` STRING COMMENT 'Type of strategic sourcing event. RFQ (Request for Quotation) for price-focused procurement, RFP (Request for Proposal) for complex service procurement, reverse auction for competitive bidding, negotiation for direct vendor engagement, sealed bid for formal competitive procurement.. Valid values are `rfq|rfp|reverse_auction|negotiation|sealed_bid`',
    `issue_date` DATE COMMENT 'Date when the RFQ was officially issued to participating vendors.',
    `issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ was officially issued to vendors, marking the start of the response period.',
    `minority_vendor_preference_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes preference or set-aside provisions for minority-owned, women-owned, or disadvantaged business enterprises.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was last modified.',
    `participating_vendor_count` STRING COMMENT 'Number of vendors invited to participate in this RFQ event.',
    `payment_terms` STRING COMMENT 'Specified payment terms for the resulting contract, such as Net 30, Net 60, or early payment discount terms (e.g., 2/10 Net 30).',
    `pip_project_flag` BOOLEAN COMMENT 'Indicates whether this RFQ is associated with a Property Improvement Plan (PIP) project for capital improvements, renovations, or major upgrades.',
    `response_deadline_date` DATE COMMENT 'Final date by which vendors must submit their quotations or proposals.',
    `response_deadline_time` TIMESTAMP COMMENT 'Precise timestamp by which vendor responses must be received, including time zone.',
    `response_received_count` STRING COMMENT 'Number of vendor responses actually received by the response deadline.',
    `rfq_description` STRING COMMENT 'Detailed narrative description of the goods or services being sourced, including specifications, quality requirements, and any special conditions.',
    `rfq_number` STRING COMMENT 'Business-facing unique identifier for the RFQ event, typically generated by the procurement system and shared with vendors.',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Draft indicates preparation phase, issued means sent to vendors, open indicates active response period, closed means response deadline passed, awarded indicates vendor selection completed, cancelled indicates RFQ withdrawn.. Valid values are `draft|issued|open|closed|awarded|cancelled`',
    `sustainability_requirement_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes mandatory sustainability, environmental, or green procurement requirements that vendors must meet.',
    `terms_and_conditions` STRING COMMENT 'Legal and commercial terms and conditions that will govern the resulting contract, including payment terms, warranties, liability, and dispute resolution.',
    `unit_of_measure` STRING COMMENT 'Standard unit used to quantify the goods or services (e.g., each, case, kilogram, liter, hour, room night).',
    CONSTRAINT pk_request_for_quotation PRIMARY KEY(`request_for_quotation_id`)
) COMMENT 'Request for Quotation and strategic sourcing events issued to multiple vendors to solicit competitive pricing for goods and services. Captures RFQ/event number, issue date, response deadline, event type (RFQ, RFP, reverse auction, negotiation), procurement category, estimated quantity/annual spend, delivery requirements, evaluation criteria and methodology, award criteria, participating vendor list, and outcome/award decision. Supports competitive sourcing, vendor selection, category management, strategic sourcing governance, and contract negotiation workflows. Sourced from SAP S/4HANA MM RFQ (ME41).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` (
    `vendor_quotation_id` BIGINT COMMENT 'Unique identifier for the vendor quotation record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor quotations are classified by procurement category for evaluation and comparison. FK enables category-specific evaluation criteria and price benchmarking.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement professional or buyer responsible for evaluating this quotation. Links to employee or user master data.',
    `property_id` BIGINT COMMENT 'Identifier of the property or hotel location for which this quotation applies. Supports multi-property procurement operations.',
    `request_for_quotation_id` BIGINT COMMENT 'Reference to the RFQ document that this quotation responds to. Links quotation to the originating procurement request.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor submitting this quotation. Links to vendor master data for supplier information.',
    `award_decision_date` DATE COMMENT 'Date when the final award decision was made for this quotation. Null if quotation is still under evaluation or was not awarded.',
    `award_recommendation_flag` BOOLEAN COMMENT 'Indicates whether the procurement team recommends awarding the purchase order to this vendor based on quotation evaluation. True signals recommended vendor for award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quotation record was first created in the system. Audit trail for data lineage and record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted prices. Supports multi-currency procurement operations across global properties.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Number of days required by the vendor to deliver the goods or services after purchase order placement. Critical factor in vendor selection for time-sensitive procurement.',
    `delivery_location` STRING COMMENT 'Specified delivery location or address for the quoted goods. May reference property receiving dock, central warehouse, or other designated delivery point.',
    `evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp when the quotation evaluation was completed and vendor score was finalized. Key milestone in the procurement decision timeline.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the procurement evaluator regarding this quotation. Captures qualitative assessment factors and decision rationale.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between vendor and buyer. Examples: FOB, CIF, DDP, EXW.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the vendor to honor the quoted price. Important constraint for procurement planning and vendor selection.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quotation record was last modified. Tracks updates to evaluation status, scores, or other quotation attributes.',
    `payment_terms` STRING COMMENT 'Payment terms offered by the vendor. Includes net payment period, early payment discounts, and other financial conditions. Examples: Net 30, 2/10 Net 30, Net 60.',
    `price_competitiveness_rating` STRING COMMENT 'Qualitative assessment of how competitive the quoted price is compared to market benchmarks and other vendor quotations for the same RFQ.. Valid values are `excellent|good|fair|poor`',
    `quotation_document_url` STRING COMMENT 'URL or file path to the original quotation document submitted by the vendor. Links to document management system for audit trail and reference.',
    `quotation_number` STRING COMMENT 'Business identifier for the vendor quotation. Externally visible reference number used in vendor communications and procurement documentation.',
    `quotation_received_date` DATE COMMENT 'Date when the vendor quotation was received by the procurement team. Key timestamp for tracking vendor responsiveness and evaluation timelines.',
    `quotation_status` STRING COMMENT 'Current lifecycle status of the vendor quotation in the procurement evaluation workflow. Tracks progression from receipt through award or rejection decision.. Valid values are `received|under_evaluation|awarded|rejected|expired|withdrawn`',
    `quotation_valid_from_date` DATE COMMENT 'Start date of the quotation validity period. Defines when the quoted prices and terms become effective.',
    `quotation_valid_to_date` DATE COMMENT 'End date of the quotation validity period. After this date, the vendor is not obligated to honor the quoted prices and terms.',
    `quoted_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or services that the vendor is quoting for. May differ from the RFQ requested quantity if vendor proposes alternative volumes.',
    `quoted_total_amount` DECIMAL(18,2) COMMENT 'Total amount quoted by the vendor for the entire order quantity. Calculated as unit price multiplied by quantity, may include volume discounts.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Price per unit quoted by the vendor for the requested item or service. Base price before taxes, discounts, or additional charges.',
    `rejection_reason` STRING COMMENT 'Explanation for why the quotation was rejected if status is rejected. Includes reasons such as non-competitive pricing, specification non-compliance, unacceptable terms, or vendor performance concerns.',
    `specification_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor quotation fully complies with the RFQ specifications. False indicates deviations or exceptions that require evaluation.',
    `specification_deviation_notes` STRING COMMENT 'Detailed description of any deviations from the RFQ specifications proposed by the vendor. Includes alternative materials, quality grades, packaging, or service levels.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether the quoted products or vendor practices meet the organizations sustainability and environmental standards. Increasingly important factor in vendor selection.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity and pricing. Examples include each, case, kilogram, liter, square meter, hour.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor contact for this quotation. Used for quotation clarifications and award notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor representative who submitted or is responsible for this quotation. Business contact information for quotation clarifications.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor contact for this quotation. Business contact information for urgent procurement communications.',
    `vendor_score` DECIMAL(18,2) COMMENT 'Composite evaluation score assigned to this quotation based on price, quality, delivery terms, vendor performance history, and other selection criteria. Used for vendor comparison and award decisions.',
    `warranty_terms` STRING COMMENT 'Warranty or guarantee terms offered by the vendor for the quoted goods or services. Particularly relevant for FF&E and equipment procurement.',
    CONSTRAINT pk_vendor_quotation PRIMARY KEY(`vendor_quotation_id`)
) COMMENT 'Vendor responses to RFQs capturing quoted unit prices, delivery lead times, validity period, payment terms, and any deviations from specifications. Supports price comparison, vendor selection scoring, and award decisions. Tracks quotation status (received, under evaluation, awarded, rejected). Sourced from SAP S/4HANA MM quotation (ME47/ME48).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` (
    `purchase_return_id` BIGINT COMMENT 'Unique identifier for the purchase return record. Primary key for the purchase return entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase returns are tracked by procurement category for quality analytics and vendor performance. FK enables category-specific return rate KPIs and root cause analysis.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Purchase returns reference the original goods receipt being returned. The string column goods_receipt_document_number should be normalized to FK for return-to-receipt traceability and three-way match ',
    `employee_id` BIGINT COMMENT 'Identifier of the quality inspector who performed the inspection that resulted in the return decision.',
    `primary_purchase_employee_id` BIGINT COMMENT 'Identifier of the property staff member who initiated the return (e.g., receiving clerk, F&B manager, housekeeping supervisor).',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property initiating the return.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the original purchase order from which goods are being returned.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom goods are being returned.',
    `ap_credit_posted_flag` BOOLEAN COMMENT 'Indicates whether the vendor credit has been posted to accounts payable, reducing the amount owed to vendor.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier handling the return shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase return record was first created in the system.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Actual credit amount issued by vendor, which may differ from return value due to restocking fees, return shipping charges, or partial credit decisions.',
    `credit_memo_date` DATE COMMENT 'Date when vendor issued the credit memo for the returned goods.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return value amount.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the returned material, particularly relevant for F&B perishable goods returns.',
    `inspection_date` DATE COMMENT 'Date when quality inspection was performed that identified the defect or issue requiring return.',
    `inventory_adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment for the return has been posted in SAP MM, reducing on-hand stock.',
    `material_code` STRING COMMENT 'SAP material master code for the item being returned. Identifies the specific product, supply, or FF&E item.. Valid values are `^[A-Z0-9]{6,18}$`',
    `material_description` STRING COMMENT 'Human-readable description of the material being returned.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase return record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special handling instructions, or communication history related to the return.',
    `perishable_item_flag` BOOLEAN COMMENT 'Indicates whether the returned item is a perishable good (critical for F&B operations). Perishable returns require expedited processing and food safety compliance documentation.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether returned goods were placed on quality hold status prior to return, preventing use in operations.',
    `quality_inspection_result` STRING COMMENT 'Outcome of quality inspection that triggered the return. Documents the specific quality failure or defect identified during receiving inspection.. Valid values are `failed|rejected|non_conforming|damaged|expired|not_inspected`',
    `resolution_status` STRING COMMENT 'Status of the return resolution process with vendor, tracking whether credit has been received and case is closed.. Valid values are `pending|resolved|partial_credit|disputed|closed`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by vendor for processing the return, deducted from credit memo amount.',
    `return_authorization_number` STRING COMMENT 'Return Merchandise Authorization (RMA) number or similar authorization code provided by vendor to approve the return.',
    `return_date` DATE COMMENT 'Date when the return was initiated or goods were shipped back to vendor. Principal business event timestamp for the return transaction.',
    `return_document_number` STRING COMMENT 'Business document number for the return delivery in SAP MM (movement type 122). Externally visible identifier for tracking and audit.. Valid values are `^[A-Z0-9]{10,20}$`',
    `return_quantity` DECIMAL(18,2) COMMENT 'Quantity of material being returned to vendor, expressed in the materials base unit of measure.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for returning goods to vendor. Critical for vendor performance tracking and quality management.. Valid values are `quality_defect|damaged_goods|incorrect_item|over_delivery|expired_perishable|specification_mismatch`',
    `return_reason_description` STRING COMMENT 'Detailed explanation of why goods are being returned, including specific quality issues, damage details, or discrepancies identified during receiving inspection.',
    `return_shipment_tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment to vendor. Enables logistics tracking and proof of delivery to vendor.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost incurred for shipping goods back to vendor. May be absorbed by property or charged back to vendor depending on return reason and contract terms.',
    `return_status` STRING COMMENT 'Current lifecycle status of the purchase return. Tracks workflow from initiation through vendor credit processing. [ENUM-REF-CANDIDATE: draft|submitted|approved|shipped|received_by_vendor|credited|cancelled — 7 candidates stripped; promote to reference product]',
    `return_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the returned goods in the propertys local currency. Basis for vendor credit memo and AP adjustment.',
    `shipped_date` DATE COMMENT 'Date when returned goods were shipped back to vendor.',
    `storage_location_code` STRING COMMENT 'SAP storage location code from which goods were returned (e.g., main warehouse, F&B storeroom, housekeeping storage).. Valid values are `^[A-Z0-9]{4,10}$`',
    `unit_of_measure` STRING COMMENT 'Unit in which return quantity is expressed (e.g., EA for each, KG for kilogram, CS for case). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `vendor_acknowledgement_date` DATE COMMENT 'Date when vendor acknowledged receipt of the return request and agreed to accept returned goods.',
    `vendor_credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued by vendor acknowledging the return and credit to be applied. Links return to AP credit processing.',
    CONSTRAINT pk_purchase_return PRIMARY KEY(`purchase_return_id`)
) COMMENT 'Records of goods returned to vendors due to quality rejection, over-delivery, damaged items, incorrect shipments, or perishable goods expiry (critical for F&B operations) at hotel and resort properties. Captures return reason, material, quantity returned, return value, vendor credit memo reference, return shipment tracking, inspection results, quality hold status, and resolution status. Supports quality management, vendor performance tracking (defect rates), AP credit processing, inventory adjustment, and food safety compliance for perishable returns. Sourced from SAP S/4HANA MM return delivery (MIGO movement type 122).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` (
    `vendor_certification_id` BIGINT COMMENT 'Unique identifier for the vendor certification record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor certifications are scoped to specific procurement categories (e.g., food safety for F&B, sustainability for housekeeping supplies). FK enables category-specific compliance gates and certificati',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the most recent verification of this certification. Supports accountability and audit trail.',
    `property_id` BIGINT COMMENT 'Identifier of the property for which this vendor certification applies. Null if certification is across all properties.',
    `tertiary_vendor_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified this certification record. Supports accountability and audit trail.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor holding this certification. Links to the vendor master record in the procurement system.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the certification automatically renews upon expiration. True if the issuing body or vendor has set up automatic renewal.',
    `brand_standard_flag` BOOLEAN COMMENT 'Indicates whether this certification is required by brand standards or corporate policy. True if mandated by the hotel brand or corporate procurement policy.',
    `certification_name` STRING COMMENT 'Full name or title of the certification, license, or qualification (e.g., ISO 22000 Food Safety Management, HACCP Certification, MBE Minority Business Enterprise).',
    `certification_number` STRING COMMENT 'Unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is valid and in good standing.. Valid values are `active|expired|suspended|pending_verification|revoked|renewed`',
    `certification_subtype` STRING COMMENT 'Detailed subtype or specific standard within the certification type (e.g., ISO 22000, HACCP, Green Key, EarthCheck, MBE, WBE, LGBTBE). Provides granular classification.',
    `certification_type` STRING COMMENT 'Category of certification. Classifies the certification into major compliance domains relevant to hotel and resort procurement. [ENUM-REF-CANDIDATE: food_safety|insurance|business_license|diversity|sustainability|pci_compliance|quality_management|other — 8 candidates stripped; promote to reference product]',
    `compliance_gate_flag` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory qualification gate for vendor approval. True if the vendor cannot be approved or transact without this certification.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Monetary coverage amount for insurance-related certifications (e.g., general liability coverage limit, workers compensation coverage). Null for non-insurance certifications.',
    `coverage_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the coverage amount (e.g., USD, CAD, EUR). Null for non-insurance certifications.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Supports audit trail and data lineage.',
    `document_url` STRING COMMENT 'URL or file path to the stored certification document, certificate image, or supporting documentation. Links to the document management system.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this certification contributes to Environmental, Social, and Governance (ESG) reporting metrics. True for sustainability and diversity certifications.',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and is no longer valid. Null for certifications with no expiration (perpetual licenses).',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued to the vendor. Represents the effective start of the certification validity.',
    `issuing_body` STRING COMMENT 'Name of the organization, agency, or authority that issued the certification (e.g., ISO, local health department, insurance carrier, diversity certification council).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the jurisdiction where the certification was issued (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified. Tracks the most recent update to any field in the record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next internal review or audit of this certification by procurement or compliance teams. Used for proactive monitoring.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the certification, including special conditions, exceptions, or additional context provided by the vendor or procurement team.',
    `renewal_date` DATE COMMENT 'Date on which the certification was last renewed. Tracks the most recent renewal event for multi-year certifications.',
    `renewal_notice_days` STRING COMMENT 'Number of days before expiration that a renewal notice or alert should be triggered. Used for proactive compliance monitoring.',
    `risk_level` STRING COMMENT 'Risk level associated with the absence or expiration of this certification. Critical for food safety and insurance; low for optional sustainability certifications.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed description of the scope of the certification, including specific products, services, or activities covered. Clarifies what the certification qualifies the vendor to supply.',
    `verification_date` DATE COMMENT 'Date on which the certification was last verified by the procurement or compliance team. Tracks the most recent validation event.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity and validity of the certification. Supports audit trail and compliance documentation.. Valid values are `document_upload|third_party_verification|issuer_portal_check|manual_inspection|self_attestation`',
    CONSTRAINT pk_vendor_certification PRIMARY KEY(`vendor_certification_id`)
) COMMENT 'Compliance certifications and qualification records for vendors supplying hotel and resort properties. Includes food safety certifications (ISO 22000, HACCP, local health department permits), insurance certificates (general liability, workers comp), business licenses, diversity certifications (MBE, WBE, LGBTBE), sustainability certifications (Green Key, EarthCheck supplier), and PCI DSS compliance for payment-related vendors. Tracks certification type, issuing body, issue date, expiry date, renewal status, and verification method. Supports vendor qualification gates, compliance monitoring, risk management, brand standards enforcement, and ESG reporting requirements.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` (
    `procurement_supply_agreement_id` BIGINT COMMENT 'Primary key for procurement_supply_agreement',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material being supplied under this agreement',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor who supplies this material under this agreement',
    `agreement_end_date` DATE COMMENT 'Expiration or renewal date of this supply agreement. Null for evergreen agreements. Used to trigger contract renegotiation workflows.',
    `agreement_start_date` DATE COMMENT 'Effective start date of this supply agreement. Supports time-based pricing and contract lifecycle management.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this supply agreement. Active agreements are available for procurement; Inactive/Expired agreements are historical.',
    `contract_reference_number` STRING COMMENT 'External reference to the master supply contract or purchase agreement governing this vendor-material relationship. Links to legal contract repository.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the negotiated unit price. May differ from vendors preferred currency or materials standard price currency.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order placed with this vendor for this material. Used to identify inactive supply relationships and trigger vendor performance reviews.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from this vendor for this material. Vendor-specific term that affects procurement batch sizing.',
    `negotiated_unit_price` DECIMAL(18,2) COMMENT 'The per-unit price negotiated with this specific vendor for this material. Varies by vendor-material combination and is central to sourcing decisions.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred source for this material based on price, quality, reliability, or strategic relationship. Used in automated sourcing logic.',
    `supply_agreement_code` BIGINT COMMENT 'Unique identifier for this vendor-material supply agreement record. Primary key.',
    `vendor_lead_time_days` STRING COMMENT 'Number of days from purchase order placement to goods receipt for this vendor-material combination. Vendor-specific and critical for inventory planning.',
    `vendor_material_number` STRING COMMENT 'The vendors own part number or SKU for this material. Used in purchase orders and receiving to ensure correct material identification in vendor systems.',
    CONSTRAINT pk_procurement_supply_agreement PRIMARY KEY(`procurement_supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between a vendor and a material in the procurement catalog. It captures vendor-specific pricing, lead times, minimum order quantities, and sourcing preferences that exist only in the context of this vendor-material pairing. Each record links one vendor to one material with negotiated commercial terms.. Existence Justification: In hotel and resort procurement operations, materials are routinely multi-sourced from multiple vendors to mitigate supply risk, leverage competitive pricing, and ensure continuity of operations. Each vendor-material pairing has distinct commercial terms including negotiated unit prices, lead times, minimum order quantities, and contract references. The current models single vendor_id FK in material_master cannot represent this multi-sourcing reality.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` (
    `vendor_category_qualification_id` BIGINT COMMENT 'Unique identifier for this vendor-category qualification record. Primary key for the association.',
    `category_id` BIGINT COMMENT 'Foreign key linking to the procurement category. Identifies which category this vendor is qualified to supply.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement professional who created this vendor-category qualification record. Supports accountability and audit requirements.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record. Identifies which vendor holds this category qualification.',
    `annual_spend_actual` DECIMAL(18,2) COMMENT 'Actual annual procurement spend (in USD) with this vendor in this category. Used for vendor performance analysis and spend allocation optimization.',
    `category_performance_score` DECIMAL(18,2) COMMENT 'Vendor performance score specific to this procurement category, typically on a 0-100 scale. Reflects quality, delivery timeliness, pricing competitiveness, and compliance specific to this category. Performance varies by category for multi-category vendors. Identified in detection phase relationship data.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of required certifications for this vendor-category qualification. Used to trigger recertification processes and maintain compliance.',
    `certification_required` STRING COMMENT 'Specific certifications or quality standards required for this vendor to supply this category (e.g., HACCP for food suppliers, LEED for sustainable FF&E vendors, ISO certifications for engineering contractors).',
    `contract_terms` STRING COMMENT 'Category-specific contract terms and conditions negotiated for this vendor-category pairing. May include volume commitments, pricing structures, delivery terms, or quality standards specific to this category. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-category qualification record was created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this vendor-category qualification record. Supports change tracking and audit trail.',
    `last_review_date` DATE COMMENT 'Date of the most recent qualification review or performance assessment for this vendor-category pairing. Used to track periodic reassessment cycles. Identified in detection phase relationship data.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to delivery for this vendor in this specific category. Lead times vary by category based on product complexity and supply chain characteristics.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum purchase order value (in USD) required by this vendor for orders in this category. Category-specific minimums may differ from vendor-wide terms.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next qualification review or performance assessment. Supports proactive vendor management and compliance with periodic review requirements.',
    `payment_terms_override` STRING COMMENT 'Category-specific payment terms that override the vendor master payment terms. Some categories may negotiate extended terms or early payment discounts based on category strategy.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor has preferred vendor status for this specific category. Preferred vendors receive priority consideration in sourcing decisions and may have streamlined approval processes. Identified in detection phase relationship data.',
    `qualification_date` DATE COMMENT 'Date when the vendor was initially qualified to supply goods or services in this procurement category. Identified in detection phase relationship data.',
    `qualification_notes` STRING COMMENT 'Free-text notes documenting qualification decisions, performance issues, or special considerations for this vendor-category relationship. Supports audit trail and knowledge transfer.',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor for this specific category. Values: qualified (approved to supply), pending (under evaluation), suspended (temporarily not approved), disqualified (rejected), under_review (periodic reassessment in progress). Identified in detection phase relationship data.',
    `spend_allocation_percentage` DECIMAL(18,2) COMMENT 'Target percentage of category spend allocated to this vendor as part of vendor panel optimization strategy. Used in multi-sourcing strategies to balance risk and leverage competition. Identified in detection phase relationship data.',
    CONSTRAINT pk_vendor_category_qualification PRIMARY KEY(`vendor_category_qualification_id`)
) COMMENT 'This association product represents the qualification and performance relationship between vendors and procurement categories in hotel and resort operations. It captures category-specific vendor qualifications, performance metrics, preferred vendor status, and contract terms that exist only in the context of a specific vendor-category pairing. Each record links one vendor to one procurement category with attributes that track qualification status, performance history, and category-specific commercial terms. This enables category management best practices including vendor panel optimization, category-specific sourcing strategies, and spend allocation decisions.. Existence Justification: In hotel and resort procurement operations, vendor category qualification is a genuine many-to-many operational relationship. A single vendor (e.g., Sysco) is qualified to supply multiple procurement categories (F&B supplies, housekeeping supplies, paper goods), and each procurement category has multiple qualified vendors forming a vendor panel. The business actively manages these qualifications with category-specific performance scores, preferred vendor designations, contract terms, and spend allocation strategies. This is not an analytical correlation but an operational business process where procurement teams create, review, and update vendor-category qualifications as part of strategic sourcing and category management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` (
    `vendor_program_participation_id` BIGINT COMMENT 'Unique identifier for this vendor-program participation record. Primary key.',
    `vendor_experience_program_id` BIGINT COMMENT 'Foreign key to experience.experience_program.experience_program_id',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services for this experience program',
    `vendor_program_id` BIGINT COMMENT 'Foreign key linking to the experience program in which the vendor participates',
    `capacity_limit` STRING COMMENT 'Maximum number of concurrent guests or service instances this vendor can support for this program. Null indicates no defined limit. Used for program enrollment capacity planning.',
    `contract_reference_number` STRING COMMENT 'Reference number of the legal contract or service agreement governing this vendors participation in this program. Links operational participation to legal agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-program participation record was created in the system.',
    `fulfillment_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this vendor has primary fulfillment responsibility for their service component within this program. True means the vendor is accountable for end-to-end delivery; false means they provide support services only.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review for this vendor-program participation. Used to track review cadence and ensure regular vendor performance management.',
    `minimum_notice_hours` STRING COMMENT 'Minimum number of hours advance notice required for this vendor to fulfill service requests under this program. Varies by program complexity and vendor capacity.',
    `participation_end_date` DATE COMMENT 'Date when the vendors participation in this experience program ends or ended. Null indicates ongoing participation. Critical for tracking vendor contract lifecycles per program.',
    `participation_start_date` DATE COMMENT 'Date when the vendor began participating in this experience program. Tracks the effective start of the vendors service delivery commitment for this specific program.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Current performance rating (0.00 to 5.00) for this vendors delivery of services within this specific program. Based on guest feedback, SLA compliance, and quality audits. Tracked per program because vendor performance may vary across different service types.',
    `pricing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program-specific pricing.',
    `program_specific_pricing` DECIMAL(18,2) COMMENT 'The negotiated price or rate for this vendors services within this specific experience program. Pricing varies by program based on volume, exclusivity, and service scope. Different from the vendors standard pricing.',
    `property_scope` STRING COMMENT 'Comma-separated list of property codes where this vendor provides services for this specific program. A vendor may serve different property sets for different programs based on geographic coverage and capacity.',
    `service_delivery_sla` STRING COMMENT 'Service level agreement terms specific to this vendor-program combination. Defines response times, quality standards, availability requirements, and performance metrics the vendor must meet for this program.',
    `updated_by` STRING COMMENT 'User ID or system identifier of who last updated this participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-program participation record was last updated.',
    `vendor_program_status` STRING COMMENT 'Current operational status of the vendors participation in this specific program. Tracks whether the vendor is actively delivering services, temporarily suspended, or no longer participating. Status is program-specific; a vendor may be active in some programs and suspended in others.',
    `vendor_role_in_program` STRING COMMENT 'The specific role or service type the vendor provides within this experience program. A vendor may have different roles across different programs (e.g., spa operator for wellness programs, transportation for adventure programs).',
    `program_id` BIGINT COMMENT '',
    `experience_program_id` BIGINT COMMENT '',
    `created_by` STRING COMMENT 'User ID or system identifier of who created this participation record.',
    CONSTRAINT pk_vendor_program_participation PRIMARY KEY(`vendor_program_participation_id`)
) COMMENT 'This association product represents the Contract between vendor and experience_program. It captures the operational relationship where vendors deliver specific services as part of curated guest experience programs across hotel and resort properties. Each record links one vendor to one experience_program with attributes that define the vendors role, service delivery commitments, program-specific pricing, and fulfillment responsibilities that exist only in the context of this relationship.. Existence Justification: In travel hospitality operations, experience programs (spa packages, culinary experiences, adventure programs, wellness journeys) require coordination of multiple specialized vendors to deliver the complete guest experience. A single experience program involves multiple vendors (spa operator, restaurant partner, transportation provider, activity vendors), and each vendor participates in multiple programs across different properties and guest segments. The business actively manages these vendor-program relationships with program-specific pricing, SLAs, fulfillment responsibilities, and performance tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` (
    `vendor_touchpoint_service_id` BIGINT COMMENT 'Unique identifier for this vendor-touchpoint service relationship. Primary key.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to the guest journey touchpoint being serviced',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services at this touchpoint',
    `contract_reference_number` STRING COMMENT 'Reference to the master contract governing this vendor-touchpoint service relationship.',
    `cost_per_touchpoint_interaction` DECIMAL(18,2) COMMENT 'The negotiated cost per guest interaction at this touchpoint. Used for cost allocation and vendor performance analysis. Identified in detection phase.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review for this vendor at this touchpoint.',
    `quality_threshold_score` DECIMAL(18,2) COMMENT 'Minimum quality score the vendor must maintain for this touchpoint to remain in compliance. Identified in detection phase.',
    `response_time_minutes` STRING COMMENT 'Maximum response time in minutes the vendor must meet for this touchpoint (e.g., valet retrieval time, concierge callback time). Identified in detection phase.',
    `service_level_agreement` STRING COMMENT 'The SLA tier or contract terms governing vendor performance at this touchpoint. Identified in detection phase.',
    `service_status` STRING COMMENT 'Current operational status of this vendor-touchpoint service relationship.',
    `touchpoint_activation_date` DATE COMMENT 'The date this vendor began servicing this touchpoint. Used to track vendor tenure and historical performance. Identified in detection phase.',
    `touchpoint_deactivation_date` DATE COMMENT 'The date this vendor stopped servicing this touchpoint, if applicable. Supports historical tracking of vendor-touchpoint relationships.',
    `vendor_staff_certification_required_flag` BOOLEAN COMMENT 'Indicates whether vendor staff must hold specific certifications to deliver this touchpoint (e.g., sommelier certification for wine service touchpoint). Identified in detection phase.',
    `vendor_touchpoint_role` STRING COMMENT 'The role this vendor plays in delivering this touchpoint (e.g., primary valet provider, backup spa operator, seasonal transportation partner). Identified in detection phase.',
    CONSTRAINT pk_vendor_touchpoint_service PRIMARY KEY(`vendor_touchpoint_service_id`)
) COMMENT 'This association product represents the service contract between vendors and guest journey touchpoints. It captures vendor accountability for specific touchpoint delivery, including SLAs, quality thresholds, cost allocation, and certification requirements. Each record links one vendor to one touchpoint with attributes that exist only in the context of this service relationship.. Existence Justification: In hospitality operations, vendors provide services at multiple guest journey touchpoints (e.g., a valet vendor services arrival, departure, and concierge-requested retrieval touchpoints), and each touchpoint is typically supported by multiple vendors (e.g., check-in touchpoint involves housekeeping suppliers, technology vendors, and amenity providers). The business actively manages these vendor-touchpoint service relationships with specific SLAs, quality thresholds, cost structures, and certification requirements that vary by vendor-touchpoint combination.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` (
    `category_buyer_assignment_id` BIGINT COMMENT 'Unique identifier for the category buyer assignment record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to the procurement category being managed by the employee',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee (buyer/category manager) assigned to the procurement category',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Active assignments drive requisition routing. Inactive assignments are historical. Suspended assignments are temporarily paused (e.g., during leave).',
    `assignment_type` STRING COMMENT 'Classification of the buyers role in managing this category. Indicates whether the employee is the primary category manager, backup/secondary manager, specialist consultant, or temporary coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the buyers responsibility for this category ends. Null for currently active assignments. Used for tracking assignment history and transitions.',
    `effective_start_date` DATE COMMENT 'Date when the buyers responsibility for this category begins. Used for historical tracking of category ownership and determining active assignments.',
    `primary_backup_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is a primary (true) or backup (false) assignment. Used for requisition routing logic to determine first-line responsibility.',
    `spend_authority_limit` DECIMAL(18,2) COMMENT 'Maximum purchase order value (in USD) that this buyer can approve for this category without escalation. Authority limits vary by buyer experience level and category risk profile.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was last modified.',
    `workload_percentage` DECIMAL(18,2) COMMENT 'Percentage of the buyers time allocated to managing this category. Used for workload balancing and capacity planning across the procurement team.',
    CONSTRAINT pk_category_buyer_assignment PRIMARY KEY(`category_buyer_assignment_id`)
) COMMENT 'This association product represents the assignment of procurement professionals (buyers/category managers) to procurement categories. It captures the buyer-category responsibility matrix that drives requisition routing, vendor relationship ownership, and spend authority. Each record links one employee to one procurement category with assignment-specific attributes including role type (primary/backup), effective dates, and spend authority limits.. Existence Justification: In hospitality procurement operations, category management follows a buyer assignment matrix where procurement professionals (buyers/category managers) are assigned responsibility for specific procurement categories. Each buyer manages multiple categories (e.g., one buyer handles Linens, Uniforms, and Housekeeping Supplies), and each category has both primary and backup buyers to ensure coverage. The business actively manages these assignments with effective dates, authority limits, and role types (primary/backup/specialist).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` (
    `procurement_therapist_certification_id` BIGINT COMMENT 'Primary key for procurement_therapist_certification',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the therapist employee record',
    `spa_therapist_certification_id` BIGINT COMMENT 'Unique identifier for this therapist-treatment certification record. Primary key for the association.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to the spa treatment record',
    `certification_date` DATE COMMENT 'Date when the therapist was certified to perform this specific treatment. Used for compliance tracking and recertification scheduling.',
    `certification_status` STRING COMMENT 'Current lifecycle status of this certification. Controls whether the therapist can be scheduled for this treatment. Values: ACTIVE, EXPIRED, SUSPENDED, PENDING_RENEWAL.',
    `expiration_date` DATE COMMENT 'Date when this certification expires and requires renewal. Null for certifications without expiration. Used for proactive recertification scheduling.',
    `last_performed_date` DATE COMMENT 'Most recent date the therapist performed this treatment on a guest. Used to identify skill currency and trigger refresher training requirements.',
    `notes` STRING COMMENT 'Free-text notes about this therapists certification for this treatment, including special techniques, limitations, or guest feedback themes.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Average guest satisfaction or quality rating for this therapist performing this specific treatment. Used for scheduling premium treatments to top-rated therapists and identifying coaching opportunities.',
    `preferred_for_treatment_flag` BOOLEAN COMMENT 'Indicates whether this therapist is designated as a preferred or specialist provider for this treatment. Used for VIP guest scheduling and premium service delivery.',
    `proficiency_level` STRING COMMENT 'Current skill proficiency level of the therapist for this specific treatment. Used for scheduling optimization, quality assurance, and identifying training needs. Values: TRAINEE, COMPETENT, PROFICIENT, EXPERT.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total hours of training completed by the therapist for this specific treatment. Used for compliance documentation and professional development tracking.',
    `treatments_performed_count` STRING COMMENT 'Total number of times this therapist has performed this specific treatment. Used for experience tracking and proficiency assessment.',
    CONSTRAINT pk_procurement_therapist_certification PRIMARY KEY(`procurement_therapist_certification_id`)
) COMMENT 'This association product represents the certification and competency relationship between spa therapists (employees) and treatments they are qualified to perform. It captures the operational reality that therapists must be certified for specific treatments, and the business actively manages certification status, proficiency levels, training requirements, and performance quality for scheduling, compliance, and quality assurance. Each record links one therapist to one treatment with attributes that exist only in the context of this certification relationship.. Existence Justification: In spa operations, therapists must be certified to perform specific treatments, and each treatment can be performed by multiple certified therapists. The business actively manages this many-to-many relationship through certification programs, proficiency assessments, and performance tracking. Spa managers use this data for scheduling optimization (matching guest requests to qualified therapists), compliance verification (ensuring minimum certification requirements are met), and quality assurance (tracking performance ratings per therapist-treatment combination).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` (
    `program_assignment_id` BIGINT COMMENT 'Unique identifier for this employee-program assignment record. Primary key.',
    `employee_id` BIGINT COMMENT '',
    `currency_id` BIGINT COMMENT '',
    `program_assigned_by_employee_id` BIGINT COMMENT 'Employee who created the assignment.',
    `program_employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to deliver this experience program',
    `program_id` BIGINT COMMENT 'Foreign key linking to the experience program being delivered',
    `project_id` BIGINT COMMENT 'add column project_id (BIGINT) with FK to procurement.project.project_id - program assignments often roll up to projects for billing and tracking.',
    `property_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of time allocated to the program.',
    `allocation_percent` DECIMAL(18,2) COMMENT '',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Added to expand thin product per business context.',
    `approval_status` STRING COMMENT 'Approval state of the assignment.',
    `approved_by` STRING COMMENT '',
    `approved_date` DATE COMMENT '',
    `assigned_by` STRING COMMENT '',
    `assigned_date` DATE COMMENT '',
    `assignment_date` DATE COMMENT '',
    `assignment_end_date` DATE COMMENT 'Date when the employees assignment to this experience program ended. Null indicates an active ongoing assignment. This attribute was explicitly identified in the detection phase as relationship data.',
    `assignment_notes` STRING COMMENT 'Free-text notes on the assignment.',
    `assignment_role` STRING COMMENT '',
    `assignment_start_date` DATE COMMENT 'Date when the employee began their assignment to this experience program. This attribute was explicitly identified in the detection phase as relationship data.',
    `assignment_status` STRING COMMENT 'Current status of this assignment indicating whether the employee is actively delivering this program or temporarily unavailable.',
    `assignment_type` STRING COMMENT '',
    `billing_rate` DECIMAL(18,2) COMMENT '',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to the program assignment',
    `certification_expiry_date` DATE COMMENT 'Expiry date of required certification.',
    `certification_required` STRING COMMENT 'Specific certification or qualification required for the employee to fulfill this role in this program (e.g., Certified Sommelier for culinary programs, Certified Yoga Instructor for wellness programs). This attribute was explicitly identified in the detection phase as relationship data.',
    `certification_verified_flag` BOOLEAN COMMENT 'Whether required certification is verified.',
    `completion_date` DATE COMMENT '',
    `completion_status` STRING COMMENT 'Completion status of program requirements.',
    `compliance_status` STRING COMMENT 'Compliance status of the vendor under the program',
    `contract_value` DECIMAL(18,2) COMMENT '',
    `created_at` TIMESTAMP COMMENT 'Added to expand thin product per business context.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `deliverables` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Expanded thin product',
    `effective_from` DATE COMMENT '',
    `effective_to` DATE COMMENT '',
    `end_date` DATE COMMENT 'Expanded thin product',
    `expiration_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_primary_assignment` BOOLEAN COMMENT 'Whether this is the employees primary program.',
    `notes` STRING COMMENT '',
    `performance_rating` STRING COMMENT 'Performance rating recorded for the assignment.',
    `performance_score` DECIMAL(18,2) COMMENT 'Performance score for the vendor in this program',
    `priority_rank` STRING COMMENT 'Expanded thin product',
    `responsibility_level` STRING COMMENT 'Level of responsibility the employee has for this program (e.g., primary, secondary, backup, trainee). This attribute was explicitly identified in the detection phase as relationship data.',
    `role` STRING COMMENT '',
    `role_code` STRING COMMENT 'Expanded thin product',
    `role_in_program` STRING COMMENT 'The specific role the employee performs within this experience program (e.g., coordinator, instructor, concierge, specialist). This attribute was explicitly identified in the detection phase as relationship data.',
    `scope_of_work` STRING COMMENT '',
    `spend_commitment` DECIMAL(18,2) COMMENT 'Committed spend amount for the assignment',
    `spend_to_date` DECIMAL(18,2) COMMENT 'Actual spend recorded to date against the program',
    `start_date` DATE COMMENT '',
    `termination_reason` STRING COMMENT '',
    `updated_at` TIMESTAMP COMMENT 'Added to expand thin product per business context.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated.',
    CONSTRAINT pk_program_assignment PRIMARY KEY(`program_assignment_id`)
) COMMENT 'This association product represents the Assignment between employee and experience_program. It captures the operational assignment of hotel staff to curated guest experience programs in specific roles. Each record links one employee to one experience_program with attributes that exist only in the context of this assignment relationship, including role, assignment dates, responsibility level, and required certifications.. Existence Justification: In hotel and resort operations, experience programs (wellness retreats, culinary experiences, spa packages) require multiple staff members in different roles to deliver the guest experience - a wellness program needs coordinators, instructors, and concierges working together. Simultaneously, employees participate in multiple programs across their tenure based on their skills and certifications. The business actively manages these assignments with specific roles, dates, responsibility levels, and certification requirements for scheduling, compliance, and quality delivery.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` (
    `requisition_line_id` BIGINT COMMENT 'Primary key for requisition_line',
    `delivery_address_id` BIGINT COMMENT 'Reference to the specific delivery address or receiving location within the property. May differ from the property main address for large resorts with multiple receiving points.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being requisitioned. Links to master material catalog for F&B supplies, housekeeping items, FF&E (Furniture, Fixtures, and Equipment), or other procurement categories.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the supplier contract or purchasing agreement governing this requisition line. Used for contract compliance tracking and pricing validation.',
    `project_id` BIGINT COMMENT 'Reference to the capital project or Property Improvement Plan (PIP) project if this requisition line is part of a specific project initiative. Applicable primarily for CapEx procurement.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property location where the requisitioned items will be delivered and used.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that was created from this requisition line. Populated after the requisition is converted to a purchase order.',
    `purchase_requisition_id` BIGINT COMMENT 'Reference to the parent purchase requisition header that contains this line item.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager who approved this requisition line. Used for audit trail and accountability.',
    `requisition_employee_id` BIGINT COMMENT 'Reference to the employee or user who created this requisition line item. Used for accountability and communication.',
    `split_from_requisition_line_id` BIGINT COMMENT 'Self-referencing FK on requisition_line (split_from_requisition_line_id)',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred or suggested vendor/supplier for this requisition line. May be pre-populated from contract or sourcing agreements.',
    `approval_status` STRING COMMENT 'Current approval workflow status for this requisition line. Tracks whether the line has been reviewed and approved by authorized approvers.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition line was approved. Used for approval cycle time analytics and audit compliance.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center code to which this requisition line expenditure will be charged. Used for departmental budget tracking and spend allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition line record was first created in the system. Used for audit trail and requisition cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing and amounts.',
    `delivery_date` DATE COMMENT 'Date by which the requisitioned material or service is needed at the delivery location. Critical for operational planning and vendor performance tracking.',
    `department_code` STRING COMMENT 'Organizational department code of the requesting unit (e.g., Front Office, Housekeeping, F&B, Engineering). Used for departmental spend analysis.',
    `expenditure_type` STRING COMMENT 'Classification of the expenditure as Operating Expense (OpEx) for day-to-day operations or Capital Expenditure (CapEx) for Property Improvement Plan (PIP) projects and long-term assets.',
    `external_reference_number` STRING COMMENT 'External reference or tracking number from the source system or vendor. Used for cross-system reconciliation and vendor communication.',
    `general_ledger_account` STRING COMMENT 'General ledger account code for financial posting of this requisition line. Determines the expense category (OpEx vs CapEx) and financial statement classification.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this requisition line. Used to track fulfillment progress and identify partial deliveries.',
    `is_deleted` BOOLEAN COMMENT 'Logical deletion flag indicating whether this requisition line has been soft-deleted. Used for data retention and audit compliance without physical deletion.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent requisition, used for ordering and reference.',
    `line_status` STRING COMMENT 'Current lifecycle status of the requisition line item. Tracks progression from creation through approval, ordering, and receipt.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this requisition line, calculated as quantity multiplied by unit price. Represents the estimated spend for this line item.',
    `material_description` STRING COMMENT 'Textual description of the material or service being requisitioned. Provides human-readable context for the line item.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition line record was last updated. Used for change tracking and data quality monitoring.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received for this requisition line. Calculated as requisitioned quantity minus goods receipt quantity.',
    `priority_level` STRING COMMENT 'Business priority classification for this requisition line. Urgent and high-priority items may receive expedited approval and processing.',
    `procurement_category` STRING COMMENT 'High-level classification of the procurement spend category. Used for spend analytics, category management, and strategic sourcing initiatives.',
    `purchase_order_line_number` STRING COMMENT 'Line number on the purchase order that corresponds to this requisition line. Used for traceability between requisition and purchase order.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units being requested in this line item.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver if this requisition line was rejected. Used for feedback to requester and process improvement.',
    `source_system_code` STRING COMMENT 'Identifier of the originating system that created this requisition line (e.g., SAP, Oracle, property management system). Used for data lineage and integration tracking.',
    `special_instructions` STRING COMMENT 'Free-text field for additional delivery instructions, handling requirements, or special notes for the vendor or receiving department.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax amount for this requisition line based on the applicable tax code and line total amount.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applicable to this requisition line. Determines sales tax, VAT, or GST calculation based on delivery location and material type.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requisitioned quantity (e.g., Each, Case, Box, Pound, Kilogram, Gallon, Liter, Dozen, Pair, Set, Hour, Day, Week, Month).',
    `unit_price` DECIMAL(18,2) COMMENT 'Estimated or contracted price per unit of measure for the material or service. Used for budget estimation and spend analytics.',
    CONSTRAINT pk_requisition_line PRIMARY KEY(`requisition_line_id`)
) COMMENT 'Master reference table for requisition_line. Referenced by requisition_line_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` (
    `procurement_work_order_id` BIGINT COMMENT 'Primary key for work_order',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the specific asset or equipment that is the subject of the work order.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the vendor contract governing pricing, terms, and service levels for this work order.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where the work order is executed.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the associated purchase order that authorizes procurement for this work order.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor assigned to fulfill this work order.',
    `actual_completion_date` DATE COMMENT 'Actual date when the work order was completed and closed.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order upon completion, including all charges.',
    `actual_start_date` DATE COMMENT 'Actual date when work commenced on the work order.',
    `approval_date` DATE COMMENT 'Date when the work order was formally approved.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the work order requires formal approval before execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the work order.',
    `assigned_to` STRING COMMENT 'Name or identifier of the person, team, or vendor responsible for executing the work order.',
    `budget_code` STRING COMMENT 'Budget or cost center code against which the work order costs are charged.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order was formally closed and marked as complete.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting work performed, issues encountered, and final outcomes upon completion.',
    `contract_compliance_flag` BOOLEAN COMMENT 'Indicates whether the work order adheres to the terms, pricing, and service levels defined in the vendor contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this work order.',
    `department` STRING COMMENT 'Property department or cost center responsible for the work order (e.g., Engineering, Housekeeping, Food & Beverage).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected total cost for completing the work order, including labor, materials, and services.',
    `expenditure_type` STRING COMMENT 'Classification of spend as Capital Expenditure (CapEx) for PIP projects or Operating Expenditure (OpEx) for routine operations.',
    `general_ledger_account` STRING COMMENT 'General ledger account code for financial posting and accounting integration.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this work order is part of a recurring maintenance or service schedule.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total cost of labor hours expended on the work order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was last updated or modified.',
    `location` STRING COMMENT 'Specific location within the property where work is to be performed (e.g., Room 305, Lobby, Kitchen).',
    `material_cost` DECIMAL(18,2) COMMENT 'Total cost of materials, parts, and supplies consumed in executing the work order.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and resource allocation: critical, high, medium, or low.',
    `procurement_category` STRING COMMENT 'High-level procurement category for spend classification: F&B supplies, housekeeping, FF&E, MRO, CapEx, or services.',
    `recurrence_frequency` STRING COMMENT 'Frequency of recurrence for scheduled recurring work orders: daily, weekly, monthly, quarterly, or annually.',
    `requested_by` STRING COMMENT 'Name or identifier of the person or department who initiated the work order request.',
    `requested_date` DATE COMMENT 'Date when the work order was originally requested or initiated.',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA MM module document number for integration and traceability with the ERP system.',
    `scheduled_completion_date` DATE COMMENT 'Target date by which the work order is expected to be completed.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin.',
    `service_cost` DECIMAL(18,2) COMMENT 'Total cost of external services or contractor fees associated with the work order.',
    `warranty_applicable` BOOLEAN COMMENT 'Indicates whether the work performed is covered under an existing warranty or service agreement.',
    `work_order_description` STRING COMMENT 'Detailed narrative describing the scope, purpose, and requirements of the work order.',
    `work_order_number` STRING COMMENT 'Externally-known business identifier for the work order, typically displayed on documents and used for tracking.',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order: draft, submitted, approved, in progress, on hold, completed, or cancelled.',
    `work_order_type` STRING COMMENT 'Classification of the work order by nature of work: maintenance, repair, installation, inspection, project, or emergency.',
    CONSTRAINT pk_procurement_work_order PRIMARY KEY(`procurement_work_order_id`)
) COMMENT 'Master reference table for work_order. Referenced by work_order_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `parent_project_id` BIGINT COMMENT 'Self-referencing FK on project (parent_project_id)',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master vendor contract or agreement governing procurement for this project, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or executive who granted final approval for the project.',
    `project_manager_employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and overseeing the project execution.',
    `project_sponsor_employee_id` BIGINT COMMENT 'Reference to the executive or business unit sponsoring and funding the project.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property where this project is being executed.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred on the project to date, including all purchase orders, invoices, and expenses.',
    `actual_end_date` DATE COMMENT 'Actual date when project execution was completed or closed.',
    `actual_start_date` DATE COMMENT 'Actual date when project execution commenced.',
    `approval_date` DATE COMMENT 'Date when the project was formally approved by the sponsoring authority or governance board.',
    `brand_standard_compliance` BOOLEAN COMMENT 'Flag indicating whether the project deliverables must comply with specific brand or franchise standards.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated for the project in the propertys operating currency.',
    `business_justification` STRING COMMENT 'Business case and rationale explaining why the project is being undertaken and the expected benefits.',
    `project_category` STRING COMMENT 'Procurement category classification for the project. F&B for food and beverage supplies, housekeeping for cleaning and linen supplies, FF&E for furniture fixtures and equipment, technology for IT and systems, facility for building and infrastructure, guest experience for amenities and services.',
    `project_code` STRING COMMENT 'Business-assigned unique alphanumeric code for the project, used for external reference and reporting.',
    `committed_cost` DECIMAL(18,2) COMMENT 'Total amount committed through approved purchase orders and contracts that have not yet been invoiced or paid.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of project completion based on milestones, deliverables, or earned value, ranging from 0.00 to 100.00.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center code to which project expenses are charged for budgeting and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this project.',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, objectives, and deliverables.',
    `is_pip_project` BOOLEAN COMMENT 'Flag indicating whether this project is part of a Property Improvement Plan mandated by brand standards or franchise agreements.',
    `project_name` STRING COMMENT 'Full descriptive name of the project.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or special instructions related to the project.',
    `planned_end_date` DATE COMMENT 'Scheduled date when project execution is planned to be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date when project execution is planned to begin.',
    `priority` STRING COMMENT 'Business priority level assigned to the project for resource allocation and scheduling decisions.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project indicating its stage in the project management workflow.',
    `project_type` STRING COMMENT 'Classification of the project by financial and operational category. CapEx for capital expenditure projects, OpEx for operational expenditure, PIP for Property Improvement Plan projects, renovation for property upgrades, new build for new construction, maintenance for ongoing upkeep.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for the project based on complexity, dependencies, and potential impact.',
    `sustainability_rating` STRING COMMENT 'Environmental sustainability rating or certification target for the project, such as LEED or Green Key levels.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the project record was last modified in the system.',
    `wbs_element` STRING COMMENT 'Hierarchical work breakdown structure element code used for project planning, tracking, and cost allocation in SAP Project System.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by project_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` (
    `delivery_address_id` BIGINT COMMENT 'Primary key for delivery_address',
    `parent_delivery_address_id` BIGINT COMMENT 'Self-referencing FK on delivery_address (parent_delivery_address_id)',
    `property_id` BIGINT COMMENT 'Reference to the property or facility associated with this delivery address.',
    `address_code` STRING COMMENT 'Unique business identifier or code for the delivery address, used for procurement and logistics operations.',
    `address_line_1` STRING COMMENT 'Primary street address line including street number, street name, and building identifier for the delivery location.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as suite, floor, room, loading dock, or department.',
    `address_line_3` STRING COMMENT 'Tertiary address line for additional location details or special delivery instructions.',
    `address_name` STRING COMMENT 'Business-friendly name or label for the delivery address (e.g., Main Kitchen Loading Dock, Housekeeping Storage Entrance).',
    `address_type` STRING COMMENT 'Classification of the delivery address type indicating the nature of the location.',
    `city` STRING COMMENT 'City or municipality name where the delivery address is located.',
    `contact_email` STRING COMMENT 'Email address for the delivery address contact person or receiving department for delivery notifications and coordination.',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the delivery address for receiving shipments and coordinating deliveries.',
    `contact_phone` STRING COMMENT 'Primary phone number for the delivery address contact person or receiving department.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the delivery address is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery address record was first created in the system.',
    `default_shipping_method` STRING COMMENT 'Preferred or default shipping method for deliveries to this address.',
    `delivery_address_status` STRING COMMENT 'Current lifecycle status of the delivery address indicating whether it is available for use in procurement operations.',
    `effective_from_date` DATE COMMENT 'Date from which this delivery address becomes active and available for use in procurement operations.',
    `effective_to_date` DATE COMMENT 'Date until which this delivery address remains active. Null indicates no planned end date.',
    `forklift_required` BOOLEAN COMMENT 'Indicates whether forklift equipment is required for unloading deliveries at this address.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary or default delivery address for the associated property or entity.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the delivery address has been verified through postal validation services or successful delivery confirmation.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery address for mapping and route optimization.',
    `loading_dock_available` BOOLEAN COMMENT 'Indicates whether a loading dock is available at this delivery address for freight deliveries.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery address for mapping and route optimization.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the delivery address record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery address record was last modified or updated.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the delivery address used for mail and package routing.',
    `procurement_category` STRING COMMENT 'Primary procurement category or material group typically delivered to this address (e.g., Food & Beverage, Housekeeping Supplies, Furniture Fixtures & Equipment).',
    `receiving_days` STRING COMMENT 'Days of the week when deliveries are accepted at this address (e.g., Monday-Friday, Monday,Wednesday,Friday).',
    `receiving_hours_end` STRING COMMENT 'End time for receiving deliveries at this address in HH:MM format (24-hour clock).',
    `receiving_hours_start` STRING COMMENT 'Start time for receiving deliveries at this address in HH:MM format (24-hour clock).',
    `sap_plant_code` STRING COMMENT 'SAP S/4HANA Materials Management (MM) plant code associated with this delivery address for procurement integration.',
    `sap_storage_location` STRING COMMENT 'SAP S/4HANA storage location code within the plant for goods receipt and inventory management.',
    `special_delivery_instructions` STRING COMMENT 'Additional instructions or notes for delivery personnel regarding access, parking, unloading procedures, or security requirements.',
    `state_province` STRING COMMENT 'State, province, or region where the delivery address is located.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the delivery address location, used for scheduling deliveries and coordinating logistics.',
    `verification_date` DATE COMMENT 'Date when the delivery address was last verified or validated.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the delivery address record.',
    CONSTRAINT pk_delivery_address PRIMARY KEY(`delivery_address_id`)
) COMMENT 'Master reference table for delivery_address. Referenced by delivery_address_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` (
    `procurement_benefit_plan_id` BIGINT COMMENT 'Surrogate primary key for benefit_plan',
    `workforce_benefit_plan_id` BIGINT COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    `plan_code` STRING COMMENT '',
    `procurement_benefit_plan_description` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    `procurement_benefit_plan_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `updated_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_procurement_benefit_plan PRIMARY KEY(`procurement_benefit_plan_id`)
) COMMENT 'Records for procurement benefit plan in the procurement domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_po_material_master_id` FOREIGN KEY (`po_material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_po_service_material_master_id` FOREIGN KEY (`po_service_material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_requisition_line_id` FOREIGN KEY (`requisition_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`requisition_line`(`requisition_line_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_request_for_quotation_id` FOREIGN KEY (`request_for_quotation_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation`(`request_for_quotation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ADD CONSTRAINT `fk_procurement_procurement_supply_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ADD CONSTRAINT `fk_procurement_procurement_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ADD CONSTRAINT `fk_procurement_vendor_program_participation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ADD CONSTRAINT `fk_procurement_vendor_touchpoint_service_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ADD CONSTRAINT `fk_procurement_category_buyer_assignment_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`project`(`project_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_delivery_address_id` FOREIGN KEY (`delivery_address_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`delivery_address`(`delivery_address_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`project`(`project_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_split_from_requisition_line_id` FOREIGN KEY (`split_from_requisition_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`requisition_line`(`requisition_line_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ADD CONSTRAINT `fk_procurement_procurement_work_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ADD CONSTRAINT `fk_procurement_procurement_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ADD CONSTRAINT `fk_procurement_procurement_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_parent_project_id` FOREIGN KEY (`parent_project_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`project`(`project_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ADD CONSTRAINT `fk_procurement_delivery_address_parent_delivery_address_id` FOREIGN KEY (`parent_delivery_address_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`delivery_address`(`delivery_address_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'food_beverage_supplier|housekeeping_supplier|ffe_vendor|maintenance_contractor|technology_provider|professional_services');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|conditional');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Doing Business As (DBA) Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `iban` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `minimum_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Vendor State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|restricted');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `contract_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Recommendation');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_value_regex' = 'renew|renegotiate|terminate|extend_trial');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `cost_competitiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `emergency_order_support_rating` SET TAGS ('dbx_business_glossary_term' = 'Emergency Order Support Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `emergency_order_support_rating` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|published|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_discrepancies_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discrepancies Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `late_deliveries_count` SET TAGS ('dbx_business_glossary_term' = 'Late Deliveries Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `overall_vendor_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Vendor Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `payment_terms_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `qualified_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualified Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `quality_rejections_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejections Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `total_purchase_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'contract_sourcing');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot_concept' = 'contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot_group' = 'contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot_canonical' = 'procurement.procurement_contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `primary_procurement_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `primary_procurement_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `primary_procurement_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `capex_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Designation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_supply_agreement|blanket_purchase_order|frame_contract|spot_contract|service_agreement|capex_contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `negotiated_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `pip_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Project Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sla_on_time_delivery_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sla_quality_acceptance_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Quality Acceptance Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_chain_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Available Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `converted_to_po_flag` SET TAGS ('dbx_business_glossary_term' = 'Converted to Purchase Order (PO) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `justification_text` SET TAGS ('dbx_business_glossary_term' = 'Justification Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'OpEx|CapEx|PIP|Emergency|Stock Replenishment|Service');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'Direct PO|RFQ Required|Competitive Bid|Sole Source|Corporate Contract|Emergency Purchase');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `blanket_release_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Release Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `commitment_released_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Released Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Completed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Completed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|capex|opex|service');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship-To City');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship-To State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|courier|vendor_delivery|pickup');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_amount_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount with Tax');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `vendor_quote_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{0,24}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `po_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `po_service_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `requisition_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'Open|Partially Received|Fully Received|Invoiced|Closed|Cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Short Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`po_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `pip_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Project ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) or Operating Expenditure (OpEx) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|incorrect_item|short_shipment|overage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `freight_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'draft|posted|cancelled|reversed');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_inspected|passed|failed|partial_acceptance|pending_qa');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `quality_rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `return_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Delivery Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'not_started|matched|variance_detected|blocked|approved');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `total_quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Received');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `total_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Value Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'price_change|quantity_short|quantity_over|damaged_goods|substitution|freight_variance');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `expense_type` SET TAGS ('dbx_value_regex' = 'opex|capex');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `match_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Variance Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|virtual_card');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance|no_po|no_gr|blocked');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) or Operating Expenditure (OpEx) Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|blocked');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw_material|trading_goods|finished_goods|spare_parts|consumables|services');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|stock_transfer');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Purchase Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Material Short Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|climate_controlled|dry|secure');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `temperature_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ALTER COLUMN `temperature_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Category Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `annual_spend_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'property|regional|corporate|executive');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `benchmarking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Benchmarking Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `bid_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `budget_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Tracking Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|capital|services');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `competitive_bid_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `contract_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct_charge|allocated|cost_center|profit_center');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `cpor_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occupied Room (CPOR) Tracking Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `emergency_procurement_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procurement Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `emergency_procurement_allowed_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `inventory_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Managed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `inventory_managed_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `minimum_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualified Vendor Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `preferred_vendor_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Program Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `quality_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'strategic|preferred_vendor|competitive_bid|spot_buy|contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `spend_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OpEx) vs Capital Expenditure (CapEx) Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `spend_classification` SET TAGS ('dbx_value_regex' = 'opex|capex');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `sustainability_criteria_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rated|reverse_charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ALTER COLUMN `vendor_diversification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Diversification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` SET TAGS ('dbx_subdomain' = 'contract_sourcing');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `request_for_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Request For Quotation Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `primary_request_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `primary_request_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `primary_request_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `award_criteria` SET TAGS ('dbx_business_glossary_term' = 'Award Criteria');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `award_criteria` SET TAGS ('dbx_value_regex' = 'lowest_price|best_value|technical_merit|multi_vendor_award');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `awarded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Awarded Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `capex_opex_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) or Operating Expenditure (OpEx) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `capex_opex_flag` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `estimated_annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Spend Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rfq|rfp|reverse_auction|negotiation|sealed_bid');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'RFQ Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `minority_vendor_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Vendor Preference Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `participating_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Vendor Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `pip_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Project Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Deadline Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `response_deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Deadline Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `response_received_count` SET TAGS ('dbx_business_glossary_term' = 'Response Received Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|open|closed|awarded|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `sustainability_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` SET TAGS ('dbx_subdomain' = 'contract_sourcing');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quotation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `request_for_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `award_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Recommendation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `price_competitiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Price Competitiveness Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `price_competitiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_document_url` SET TAGS ('dbx_business_glossary_term' = 'Quotation Document URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Received Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_value_regex' = 'received|under_evaluation|awarded|rejected|expired|withdrawn');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Valid From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Valid To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `specification_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `specification_deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Deviation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `purchase_return_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Return ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `primary_purchase_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `primary_purchase_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `primary_purchase_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `ap_credit_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Credit Posted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `credit_memo_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `inventory_adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Posted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Return Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `perishable_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Item Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'failed|rejected|non_conforming|damaged|expired|not_inspected');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|resolved|partial_credit|disputed|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_document_number` SET TAGS ('dbx_business_glossary_term' = 'Return Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'quality_defect|damaged_goods|incorrect_item|over_delivery|expired_perishable|specification_mismatch');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Tracking Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `return_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Value Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `shipped_date` SET TAGS ('dbx_business_glossary_term' = 'Shipped Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `vendor_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ALTER COLUMN `vendor_credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credit Memo Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `vendor_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `brand_standard_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_verification|revoked|renewed');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `certification_subtype` SET TAGS ('dbx_business_glossary_term' = 'Certification Subtype');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `compliance_gate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gate Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_upload|third_party_verification|issuer_portal_check|manual_inspection|self_attestation');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_subdomain' = 'contract_sourcing');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.material_master');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `procurement_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'procurement_supply_agreement Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Material Master Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `negotiated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `supply_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `vendor_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.procurement_category');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `vendor_category_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification - Procurement Category Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `annual_spend_actual` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Actual');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Category Performance Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `payment_terms_override` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `spend_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Spend Allocation Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ALTER COLUMN `spend_allocation_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_association_edges' = 'procurement.vendor,experience.experience_program');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Participation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_experience_program_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Program ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Participation - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Participation - Experience Program Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `capacity_limit` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `fulfillment_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Responsibility Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `minimum_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Notice Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Participation End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Participation Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `program_specific_pricing` SET TAGS ('dbx_business_glossary_term' = 'Program Specific Pricing');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `service_delivery_sla` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery SLA');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_program_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_role_in_program` SET TAGS ('dbx_business_glossary_term' = 'Vendor Role in Program');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_association_edges' = 'procurement.vendor,experience.touchpoint');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_touchpoint_service_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Service ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Service - Touchpoint Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Service - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `cost_per_touchpoint_interaction` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Touchpoint Interaction');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `cost_per_touchpoint_interaction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `quality_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Threshold Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `touchpoint_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Activation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `touchpoint_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Deactivation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_staff_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Staff Certification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_touchpoint_role` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Role');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_association_edges' = 'workforce.employee,procurement.procurement_category');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `category_buyer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Category Buyer Assignment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Buyer Assignment - Procurement Category Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Buyer Assignment - Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Buyer Assignment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `primary_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Backup Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `spend_authority_limit` SET TAGS ('dbx_business_glossary_term' = 'Spend Authority Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `workload_percentage` SET TAGS ('dbx_business_glossary_term' = 'Category Workload Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ALTER COLUMN `workload_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_subdomain' = 'contract_sourcing');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_association_edges' = 'workforce.employee,spa.treatment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `procurement_therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'procurement_therapist_certification Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification - Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `spa_therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `spa_therapist_certification_id` SET TAGS ('dbx_ssot_owner' = 'spa.spa_therapist_certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `spa_therapist_certification_id` SET TAGS ('dbx_ssot_entity' = 'therapist_certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification - Treatment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `preferred_for_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Therapist Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `preferred_for_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `preferred_for_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatments_performed_count` SET TAGS ('dbx_business_glossary_term' = 'Treatments Performed Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` SET TAGS ('dbx_subdomain' = 'project_delivery');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` SET TAGS ('dbx_association_edges' = 'workforce.employee,experience.experience_program');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment - Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment - Experience Program Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `certification_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Verified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `is_primary_assignment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `responsibility_level` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Role');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `role_in_program` SET TAGS ('dbx_business_glossary_term' = 'Program Role');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `spend_commitment` SET TAGS ('dbx_business_glossary_term' = 'Spend Commitment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Spend To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `requisition_line_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Line Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `split_from_requisition_line_id` SET TAGS ('dbx_business_glossary_term' = 'Split From Requisition Line Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `split_from_requisition_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `purchase_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` SET TAGS ('dbx_subdomain' = 'project_delivery');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `procurement_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `contract_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'Sap Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `service_cost` SET TAGS ('dbx_business_glossary_term' = 'Service Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `warranty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Warranty Applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_normalization' = 'denormalized-natural-key');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` SET TAGS ('dbx_subdomain' = 'project_delivery');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `parent_project_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Project Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `parent_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_manager_employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_sponsor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_sponsor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_sponsor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `brand_standard_compliance` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Compliance');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `is_pip_project` SET TAGS ('dbx_business_glossary_term' = 'Is Pip Project');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` SET TAGS ('dbx_subdomain' = 'project_delivery');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `parent_delivery_address_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Delivery Address Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `parent_delivery_address_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `parent_delivery_address_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `parent_delivery_address_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_code` SET TAGS ('dbx_business_glossary_term' = 'Address Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_name` SET TAGS ('dbx_business_glossary_term' = 'Address Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `default_shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Default Shipping Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_status` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `forklift_required` SET TAGS ('dbx_business_glossary_term' = 'Forklift Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `loading_dock_available` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Available');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `receiving_days` SET TAGS ('dbx_business_glossary_term' = 'Receiving Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `receiving_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Receiving Hours End');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `receiving_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Receiving Hours Start');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Sap Plant Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Sap Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `special_delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Delivery Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` ALTER COLUMN `procurement_benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` ALTER COLUMN `workforce_benefit_plan_id` SET TAGS ('dbx_ssot_owner' = 'workforce.workforce_benefit_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` ALTER COLUMN `workforce_benefit_plan_id` SET TAGS ('dbx_ssot_entity' = 'benefit_plan');
